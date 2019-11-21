Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19455C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C828E20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Y568bpsB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Y568bpsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKUISD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:18:03 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:43527
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfKUISC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QASb25Jew3FsFszPjgiiGr3y2lMle5ccT+pKmrURqnE=;
 b=Y568bpsBWUBkHlzkJ3HfphKeRYbxgKKVI4UHpwr/vAzxci3hHj3Q4lMxaifC5g/KL+Z7IpPx46UVKYdzD7psgUQiaxEQHExCxgY1I1OHV1NXQRSs2uzapHvgoq7zlEAM9rPMrF46lvU5i3WaMCyjPS/3PMhaBlP/g8y13WoZQ4w=
Received: from VI1PR08CA0190.eurprd08.prod.outlook.com (2603:10a6:800:d2::20)
 by AM6PR08MB3205.eurprd08.prod.outlook.com (2603:10a6:209:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 08:17:53 +0000
Received: from DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR08CA0190.outlook.office365.com
 (2603:10a6:800:d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Thu, 21 Nov 2019 08:17:53 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT038.mail.protection.outlook.com (10.152.21.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 08:17:53 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Thu, 21 Nov 2019 08:17:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c5807edc8ee2474d
X-CR-MTA-TID: 64aa7808
Received: from 8339bfbc747e.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AAFBD1A8-7EA8-48BC-8535-3AC62EB5B825.1;
        Thu, 21 Nov 2019 08:17:47 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8339bfbc747e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 08:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCYA0mQWFT8TVX3DHDLJyu3hqcz+upn7lCqh9aK0xgyw2zaq694G07HwMlLSGIj8+zZZhVIjimoW4hu5ACcNaSkkiSa7Tk4eHhGjisJ4TCOpMZNh4J1UzTYJgMigQEVjzxwHjrXRcH/kRuiTPyga9aHz+MlX6s3M8e3znXzWEpQ1QsJG+3i/kDj+wmvnpm+ps6uWz9n2W6i1kOmMz8qjk5cfRKcl5LpYOxZ7T+qlkTp2ZKUtg0LjU1eW1fZ2f+Rcpbx4GwAiRNJCZKy5svqnfmU/2ymeROQfd0PX64SVFPQ+wcYdq4RkkgbMtT/Jg4XmBO+Z1jOzJaOovRTi7Do4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QASb25Jew3FsFszPjgiiGr3y2lMle5ccT+pKmrURqnE=;
 b=PtqaFdxMze/vsq/r94PXQXfFQwHT4290p2+pycPujvLO/O3hZqy6Y76WeV08TRx+MIIIo3YyDKnt8iavh28L26lZxrqhGXEEqvAjPsEKrfkvamkTH7buUUMuMlRsa0UnbJz9DcbJFcfKX6oCHKiMb6Gh54CZdKpp6gpxvA59NGvhYlLLG3W2acPKp9DVi5zuz9PcQqyQOzsQa8c5aREGb8k81Lk9MjG1veRpDnS5Shh3g2AgQ3CDU4ur0DA+QVdVQlQ5bdzhdq/lHIC+2ZdJNSnccXVHh7Ip14BCC8sFhCvOw/0Z7x5F1I051TB1+ZI+5GpExYYcv6iTQKJCK3Eb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QASb25Jew3FsFszPjgiiGr3y2lMle5ccT+pKmrURqnE=;
 b=Y568bpsBWUBkHlzkJ3HfphKeRYbxgKKVI4UHpwr/vAzxci3hHj3Q4lMxaifC5g/KL+Z7IpPx46UVKYdzD7psgUQiaxEQHExCxgY1I1OHV1NXQRSs2uzapHvgoq7zlEAM9rPMrF46lvU5i3WaMCyjPS/3PMhaBlP/g8y13WoZQ4w=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4910.eurprd08.prod.outlook.com (10.255.114.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 08:17:45 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 08:17:45 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVoEQnHODp0nh43k+zk6WDkpPTxA==
Date:   Thu, 21 Nov 2019 08:17:45 +0000
Message-ID: <20191121081717.29518-3-james.qian.wang@arm.com>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
In-Reply-To: <20191121081717.29518-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd1686cc-939d-467a-fc92-08d76e5b4e5b
X-MS-TrafficTypeDiagnostic: VE1PR08MB4910:|VE1PR08MB4910:|AM6PR08MB3205:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB32052519E2D9B1D71D2AB56DB34E0@AM6PR08MB3205.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39850400004)(189003)(199004)(6116002)(3846002)(2616005)(6486002)(478600001)(86362001)(4326008)(446003)(102836004)(6636002)(71190400001)(26005)(71200400001)(54906003)(110136005)(14454004)(186003)(2501003)(11346002)(6436002)(316002)(6512007)(99286004)(25786009)(2906002)(66946007)(64756008)(7736002)(66556008)(66066001)(305945005)(1076003)(66476007)(256004)(14444005)(36756003)(52116002)(76176011)(386003)(6506007)(55236004)(81166006)(81156014)(8676002)(50226002)(103116003)(66446008)(8936002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4910;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PxP72KOwQXGJio0A8mGPnfzZ1LQyj/uf5pUMtcznNlJKNNZbAESVsEbgWZC1dUMwQK5zLBy5TDd2l1O+hkopnBcNVeZt7IV9kBVBRi+Dv9MKEFbLY7NUUqEW6PxuIyUa3YX4FjNoP970M65tBvnp1jC4IxoqstgsiVSqq5awH/t4p93kp7lhvJlqHv8U5ry71HGEQetLZwG4OnoqODximXMHI8ZElIPzY24XqYOPM7YgpuE2VxSJOKyJ5wCYMUZlJK4350/+/P1/a1vvDvQ/eAgPlHoC32D/ubWJPsOgXud66s2w67nzPFPSYsdOQvTJBBF1LB+y1SwW9Eay/uHVGa6sEndQ663Zsin9cOXJ7rojygQPpaH49ZhFso7a+HMm5ik9JCoHON6SBZrK8k3Ve1uYg4FzyMAWEDf30McEcRlqwQ35Znfu3h2dBSC1zn8n
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4910
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39850400004)(1110001)(339900001)(199004)(189003)(1076003)(6486002)(86362001)(6636002)(305945005)(81166006)(26826003)(81156014)(3846002)(2906002)(70206006)(6116002)(22756006)(70586007)(478600001)(7736002)(316002)(36756003)(110136005)(103116003)(105606002)(14454004)(356004)(8676002)(54906003)(99286004)(2501003)(336012)(76176011)(186003)(386003)(26005)(25786009)(8746002)(76130400001)(50226002)(5660300002)(11346002)(2616005)(446003)(8936002)(14444005)(23756003)(47776003)(4326008)(50466002)(6512007)(66066001)(102836004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3205;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1530753a-151d-4646-32c9-08d76e5b496a
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Mv68FTF/EM+28bGz3qn8xxDvV4lHFCBFHRlNs4u/A8CzSUm2I54EzD2gZjFHOsyj2BJcbqwkKG9hI/r1XFZxrWTpT9CN7Xpt/iG3ZJzZX3DnaBUznJEBV4o1m89FNR7SNJBwIdxLQv0EL/R48ICWk6lXvcFwVSPLt2aQZQ2vfgBjP8l/de7ZnIbepM5Y70hzrTBF26xSMRsldVeDMXtCIJrMqV0mIX0H7wP+smiEQTQv5amqxhDO7UQnH2Or/25SzK5jFSSHpHsQ/NGgF1w3mS5VA+onoG5gkT4aNDytu41BtIb08bomix0B9IfKwIPiHD/TpF4msIkpPCA3gUQqM7y60QgoMAmfeFYMfSljjQijJ5H+eWmCiPNVNplNk52lbx+XNqQGs76p81ojJB1KxopUIiKqqql9Xzem17z2HzslJOv+evwNdNkDa92V9Ik
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 08:17:53.1424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1686cc-939d-467a-fc92-08d76e5b4e5b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D32 is simple version of D71, the difference is:
- Only has one pipeline
- Drop the periph block and merge it to GCU

v2: Rebase.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/include/malidp_product.h  |  3 +-
 .../arm/display/komeda/d71/d71_component.c    |  2 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 43 ++++++++++++-------
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
 5 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers=
/gpu/drm/arm/display/include/malidp_product.h
index 96e2e4016250..dbd3d4765065 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_product.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
@@ -18,7 +18,8 @@
 #define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id)) & 0xFF)
=20
 /* Mali-display product IDs */
-#define MALIDP_D71_PRODUCT_ID   0x0071
+#define MALIDP_D71_PRODUCT_ID	0x0071
+#define MALIDP_D32_PRODUCT_ID	0x0032
=20
 union komeda_config_id {
 	struct {
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 6dadf4413ef3..c7f7e9c545c7 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1274,7 +1274,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
=20
 	ctrlr =3D to_ctrlr(c);
=20
-	ctrlr->supports_dual_link =3D true;
+	ctrlr->supports_dual_link =3D d71->supports_dual_link;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 9b3bf353b6cc..2d429e310e5b 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -371,23 +371,33 @@ static int d71_enum_resources(struct komeda_dev *mdev=
)
 		goto err_cleanup;
 	}
=20
-	/* probe PERIPH */
+	/* Only the legacy HW has the periph block, the newer merges the periph
+	 * into GCU
+	 */
 	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
-	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
-		DRM_ERROR("access blk periph but got blk: %d.\n",
-			  BLOCK_INFO_BLK_TYPE(value));
-		err =3D -EINVAL;
-		goto err_cleanup;
+	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH)
+		d71->periph_addr =3D NULL;
+
+	if (d71->periph_addr) {
+		/* probe PERIPHERAL in legacy HW */
+		value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
+
+		d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
+		d71->max_vsize		=3D 4096;
+		d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
+		d71->supports_dual_link	=3D !!(value & PERIPH_SPLIT_EN);
+		d71->integrates_tbu	=3D !!(value & PERIPH_TBU_EN);
+	} else {
+		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID0);
+		d71->max_line_size	=3D GCU_MAX_LINE_SIZE(value);
+		d71->max_vsize		=3D GCU_MAX_NUM_LINES(value);
+
+		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID1);
+		d71->num_rich_layers	=3D GCU_NUM_RICH_LAYERS(value);
+		d71->supports_dual_link	=3D GCU_DISPLAY_SPLIT_EN(value);
+		d71->integrates_tbu	=3D GCU_DISPLAY_TBU_EN(value);
 	}
=20
-	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
-
-	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
-	d71->max_vsize		=3D 4096;
-	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
-	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : false;
-	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
-
 	for (i =3D 0; i < d71->num_pipelines; i++) {
 		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
 					   &d71_pipeline_funcs);
@@ -415,7 +425,7 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 	}
=20
 	/* loop the register blks and probe */
-	i =3D 2; /* exclude GCU and PERIPH */
+	i =3D 1; /* exclude GCU */
 	offset =3D D71_BLOCK_SIZE; /* skip GCU */
 	while (i < d71->num_blocks) {
 		blk_base =3D mdev->reg_base + (offset >> 2);
@@ -425,9 +435,9 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 			err =3D d71_probe_block(d71, &blk, blk_base);
 			if (err)
 				goto err_cleanup;
-			i++;
 		}
=20
+		i++;
 		offset +=3D D71_BLOCK_SIZE;
 	}
=20
@@ -603,6 +613,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chip_=
info *chip)
=20
 	switch (product_id) {
 	case MALIDP_D71_PRODUCT_ID:
+	case MALIDP_D32_PRODUCT_ID:
 		funcs =3D &d71_chip_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/gp=
u/drm/arm/display/komeda/d71/d71_regs.h
index 1727dc993909..81de6a23e7f3 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
@@ -72,6 +72,19 @@
 #define GCU_CONTROL_MODE(x)	((x) & 0x7)
 #define GCU_CONTROL_SRST	BIT(16)
=20
+/* GCU_CONFIGURATION registers */
+#define GCU_CONFIGURATION_ID0	0x100
+#define GCU_CONFIGURATION_ID1	0x104
+
+/* GCU configuration */
+#define GCU_MAX_LINE_SIZE(x)	((x) & 0xFFFF)
+#define GCU_MAX_NUM_LINES(x)	((x) >> 16)
+#define GCU_NUM_RICH_LAYERS(x)	((x) & 0x7)
+#define GCU_NUM_PIPELINES(x)	(((x) >> 3) & 0x7)
+#define GCU_NUM_SCALERS(x)	(((x) >> 6) & 0x7)
+#define GCU_DISPLAY_SPLIT_EN(x)	(((x) >> 16) & 0x1)
+#define GCU_DISPLAY_TBU_EN(x)	(((x) >> 17) & 0x1)
+
 /* GCU opmode */
 #define INACTIVE_MODE		0
 #define TBU_CONNECT_MODE	1
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index b7a1097c45c4..ad38bbc7431e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -125,6 +125,7 @@ static int komeda_platform_remove(struct platform_devic=
e *pdev)
=20
 static const struct of_device_id komeda_of_match[] =3D {
 	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
+	{ .compatible =3D "arm,mali-d32", .data =3D d71_identify, },
 	{},
 };
=20
--=20
2.20.1

