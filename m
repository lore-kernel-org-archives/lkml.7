Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F2C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D358206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5fr9elvz";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5fr9elvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLJItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:49:05 -0500
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:43492
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfLJItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYmCw/H9HAJXv2dndC52ixrEWr9aWZfqlU0dti+9oas=;
 b=5fr9elvzsr6sOvugAnOl+cXEweumTZsh7X7/S18GhfUu8H7oFfgJ0UZzjAZoIHeMPe6a3OHIaLXJDmvHNl4RbzCSSFx23kzCvFeP9huHiuegcZY/T8mUHgbH1QpMu56Ku76Ne4Q0CmydYM0aJcpHjLe24VpnBDwbPLQaz1ANkWo=
Received: from VI1PR08CA0268.eurprd08.prod.outlook.com (2603:10a6:803:dc::41)
 by DB6PR08MB2789.eurprd08.prod.outlook.com (2603:10a6:6:20::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Tue, 10 Dec
 2019 08:48:58 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0268.outlook.office365.com
 (2603:10a6:803:dc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Tue, 10 Dec 2019 08:48:58 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 10 Dec 2019 08:48:58 +0000
Received: ("Tessian outbound 25173d5f5683:v37"); Tue, 10 Dec 2019 08:48:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c62a380993af5820
X-CR-MTA-TID: 64aa7808
Received: from 4d760b48d4b6.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DDF5CBD7-AD5D-469C-A1D9-9F1818DB3B99.1;
        Tue, 10 Dec 2019 08:48:52 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4d760b48d4b6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Dec 2019 08:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMjBRjUxL37PhaKD4mkQGrT3qp/2foFMP5yM1IbqAqLavNHbLnCOSwGpikhaFT4GYUH2gphuN2l1J2vgcqrSYxXgiW2JCCPwVTnMyQsdIjeZ1qRTLhgzaQ7nEyvevgzGIMFH7t+shwYoOSjmQJzcF0nXGRCKbYcFH1VhKqY5XyRklLMkLx+8jiZHhhSE/vKWKINuduMz9+CInMxIhrsJlmDDYrgwZeljAYM64Nbq5iLvmNIOiBUIRwMuxYBSzKMzN6ACYYe6X6ec9QDKHB2ZJMdAD7SzecQq7Ooe22Vt5Qp/G1xN67D7Y9P4MsrwG9nm1HCIM8Zz4Fs9Oj7wlL+vTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYmCw/H9HAJXv2dndC52ixrEWr9aWZfqlU0dti+9oas=;
 b=EhGm9iAfIusqC5/g0wuECrSKKcTyH+UiI1APW2EVyVHClQK5r+PR4HZ0AQ7t5OSVSqhvxHEZQ0T/mqlNb6aKZ1Yo4MiyaOb9qZ0rTpGWuw+VhBCHAV85o7XQbWuIyni0T65k+LeBZGj1KQTmwJmJ7EHMJGZSWN/R+JDo5dHK5VzuyFxh42CaWFOC42A1rI8ZrlyxCUiYenFS/lPkQBtsCKS9gbqUz2QvcxvKFp61t3Dgr/JmhHrSbmro9KMJQlvDORWB5BPwDjRPv3lWItYauEhYagaRRs4jPWhhaYzQaTUmUB0vk5BKRw5w+4nQ2ScjzxmG2Bwg5GgpAHQWSBtHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYmCw/H9HAJXv2dndC52ixrEWr9aWZfqlU0dti+9oas=;
 b=5fr9elvzsr6sOvugAnOl+cXEweumTZsh7X7/S18GhfUu8H7oFfgJ0UZzjAZoIHeMPe6a3OHIaLXJDmvHNl4RbzCSSFx23kzCvFeP9huHiuegcZY/T8mUHgbH1QpMu56Ku76Ne4Q0CmydYM0aJcpHjLe24VpnBDwbPLQaz1ANkWo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5182.eurprd08.prod.outlook.com (20.179.31.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 08:48:51 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 08:48:51 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v3 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVrzaleAtsmVu8OkaYqJLyku2PnQ==
Date:   Tue, 10 Dec 2019 08:48:51 +0000
Message-ID: <20191210084828.19664-3-james.qian.wang@arm.com>
References: <20191210084828.19664-1-james.qian.wang@arm.com>
In-Reply-To: <20191210084828.19664-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edce7f9e-bd1f-4cb3-ddc5-08d77d4dcc05
X-MS-TrafficTypeDiagnostic: VE1PR08MB5182:|VE1PR08MB5182:|DB6PR08MB2789:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB2789EA036287FA0642BFD4D6B35B0@DB6PR08MB2789.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 02475B2A01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(54906003)(4326008)(66446008)(26005)(1076003)(103116003)(66556008)(37006003)(186003)(66946007)(64756008)(8676002)(66476007)(36756003)(6862004)(305945005)(2616005)(2906002)(71200400001)(6486002)(86362001)(478600001)(6512007)(6636002)(316002)(71190400001)(5660300002)(55236004)(81156014)(81166006)(8936002)(52116002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5182;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KsSO07UuusPkwFdrCldGUD1EEVXP4ugytbcJ5GNYeLC8/4LsqBlfsegvpYXNMXmuvaqCF7pi4+QgCxrVOKkXl6qE9gXYm8sK0J2F8zmJGZBL0/Yra8E3lwLIGAwaGc9N2YdfK+DzNkJd3QpXYpF2qiJE0vIgX+tMHC4OpR5KKdvLDFqjWmfWoN4g+TLMFcJLvs858bVs2S8f8M6hBKRjpQ3pjX69mTePRLOtFttwjl7ZrvKNLyMLVgnry4XtWNxJd9mAyBO1BX2VUH1uOvGZQxf4mJlQprBIvsNv07BRml5g5r9TmYtDoBR/q2c9T65I1I3iOfTMI7kMbtyp27TfVn5rRxbpapwYdMoH/f7tfA3d0JR1cg19Q2grWy68NWhb+Leb+Fgkyh3ASSKYCP6vlmChnej3rqt/Pkar7ZNKaJhC+hS/sx5avtF7pQCdZAwy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5182
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(70206006)(2616005)(26005)(36756003)(6862004)(8936002)(6506007)(70586007)(103116003)(6512007)(4326008)(336012)(26826003)(86362001)(305945005)(37006003)(54906003)(81156014)(356004)(478600001)(81166006)(8676002)(316002)(76130400001)(6636002)(36906005)(1076003)(6486002)(5660300002)(186003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2789;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6f5184c5-d7d7-47ae-3c7b-08d77d4dc783
NoDisclaimer: True
X-Forefront-PRVS: 02475B2A01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgEcmBhs7RtbbKyD4V7QzCd6olsVniaFz2Mw/4bONE8DsBjEResKV47+wtK5X7xvuVLWve+KVGVMDk6TaInSHq4r1pB1wpSPsli1m3jDrnhh2gn/chSioLWljrn2FcXJ6xReUdwJtpCuBjj62aiPVzNSuqkWYbAXk/O3PWfmVIISbW72Mo8u8pnEExqZnHAVzPpPzmfZiIofm7J8Nj2Iibtbq3qEA6eVi45u9Fq08itzAS5wUlQa9cwcWVZQ1fPAbwsJNwxTjiFj5WB8DhX8QaK7qg9DLOv82QaHnJAaeYrPiDkYE0gCXglkhn7x+gYqUV0S4e3fm7LJZgsQRkZ0eOrg8Vz2eWiXv8P864PMSjw22KbEV4IyvQm8t6px/viunkhW+ydhyMbC+Ii8VZPAZHjtGKfXmbNa4Q5MLwtSJef2UI/A2dbIHQzQQXacn7QH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 08:48:58.3977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edce7f9e-bd1f-4cb3-ddc5-08d77d4dcc05
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D32 is simple version of D71, the difference is:
- Only has one pipeline
- Drop the periph block and merge it to GCU

v2: Rebase.
v3: Isolate the block counting fix to a new patch

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/include/malidp_product.h  |  3 +-
 .../arm/display/komeda/d71/d71_component.c    |  2 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 39 ++++++++++++-------
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 +++++++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
 5 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers=
/gpu/drm/arm/display/include/malidp_product.h
index 1053b11352eb..16a8a2c22c42 100644
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
index b6517c46e670..8a02ade369db 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1270,7 +1270,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
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
index 7e79c2e88421..dd1ecf4276d3 100644
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
@@ -606,6 +616,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chip_=
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

