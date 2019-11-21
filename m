Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143AEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18D620898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oyiMJAXB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oyiMJAXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKUHMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:12:47 -0500
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:51652
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfKUHMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsOUzp77nJl9O3WojFtY2JRXsyfXhsor1OJ5olyuFR0=;
 b=oyiMJAXB3bOxYFJHJgwCN/JhFujU3/l+qckQWrV5WxwubB9K40BRcykZ6yMz9krgpA4OMeisDZOiC1smCEiPumunek329edmA28i40UaLBMjbg1z5A1UsHVGWmhxn+wOkxxqBOJ0ro743gs20Daq7I3lb9U7JV1v26hcrhA4cbQ=
Received: from VI1PR0802CA0039.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::25) by DBBPR08MB4903.eurprd08.prod.outlook.com
 (2603:10a6:10:df::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Thu, 21 Nov
 2019 07:12:37 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR0802CA0039.outlook.office365.com
 (2603:10a6:800:a9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Thu, 21 Nov 2019 07:12:37 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT031.mail.protection.outlook.com (10.152.18.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 07:12:37 +0000
Received: ("Tessian outbound dbe0f0961e8c:v33"); Thu, 21 Nov 2019 07:12:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 17e046ee2c6b5da9
X-CR-MTA-TID: 64aa7808
Received: from 1450494e56c4.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1542E9F1-5701-4E17-9154-EB776BF738CC.1;
        Thu, 21 Nov 2019 07:12:31 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1450494e56c4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 07:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfMbAv/vhWrvZNKF7uK4spuFLDtfBbx7SjgdVmJHQo0kjtOBR0fr7YQkkfrBAaM4Y3VwMBkbe0dgZtPsKv8AMm2Q12CUtiFjDwYJTXJQcmxlDIB6H5jWpXlvMs3BuGCyFiG7abS/Vcs1v+DfZD9FKx/ljIMd1Bpocwg2m3g+4KJnu1BaxKX1j+pz3V/YCWTCLIG4Vb6VG6ZitzIdoJjQj2i724ls7TFdOuL5qI2vrxd0huo8cD303SupDX1Z0tjgdy1qoi5NZE61TcEgrXLomETB6SQ2zYgU7Xb7VySYSnNFon2RvCXOuT13WpfzvCjolEXeSzXKO6DSrH7LrugoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsOUzp77nJl9O3WojFtY2JRXsyfXhsor1OJ5olyuFR0=;
 b=hEH+NT4av2+TASzqAdZR5xTW5VJinOqR0FPVrjt+Z+lhYC/zXZbRdaNhaiDUur+UHYbtLUV67ZtCyv2kP8dFtJbZJNdtNRA7iLEdXl6jjbBQP3W6WvteLjQHSXhDpBaX+5Z35ocyGxorT/J5p1CnZXfh85EZjAE3f9L7vV4NGyB6tiSIErhzIse5RYUVWVVui9Am+Kxqid23klBQ+OQNH0rC8QzybU2/Emes9PxrL0tq8AWsLjoaTAGueB368DWhWIEKOIdLpXqabq+i7yPwjbh6R+UWp0EQZrVvIIVzhjrY5+Dt8U4efFwIviYAn2VOdVTT9Gd5FmHQ8iG665WqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsOUzp77nJl9O3WojFtY2JRXsyfXhsor1OJ5olyuFR0=;
 b=oyiMJAXB3bOxYFJHJgwCN/JhFujU3/l+qckQWrV5WxwubB9K40BRcykZ6yMz9krgpA4OMeisDZOiC1smCEiPumunek329edmA28i40UaLBMjbg1z5A1UsHVGWmhxn+wOkxxqBOJ0ro743gs20Daq7I3lb9U7JV1v26hcrhA4cbQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5069.eurprd08.prod.outlook.com (20.179.29.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 07:12:29 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:12:29 +0000
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
Subject: [PATCH v4 1/6] drm/komeda: Add side by side assembling
Thread-Topic: [PATCH v4 1/6] drm/komeda: Add side by side assembling
Thread-Index: AQHVoDsJFnTIa+Sei0Kq3YwRmg+KZQ==
Date:   Thu, 21 Nov 2019 07:12:29 +0000
Message-ID: <20191121071205.27511-2-james.qian.wang@arm.com>
References: <20191121071205.27511-1-james.qian.wang@arm.com>
In-Reply-To: <20191121071205.27511-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1327c876-1cda-4192-0188-08d76e52309a
X-MS-TrafficTypeDiagnostic: VE1PR08MB5069:|VE1PR08MB5069:|DBBPR08MB4903:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB49035DC4F6AF127A5AC663D3B34E0@DBBPR08MB4903.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3044;OLM:3044;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(189003)(199004)(386003)(6636002)(55236004)(102836004)(6506007)(76176011)(256004)(52116002)(2906002)(14444005)(50226002)(7736002)(305945005)(66446008)(186003)(81166006)(81156014)(8676002)(8936002)(66946007)(6512007)(26005)(2616005)(71200400001)(6486002)(446003)(478600001)(11346002)(71190400001)(6436002)(64756008)(66476007)(66556008)(86362001)(66066001)(4326008)(36756003)(2501003)(6116002)(316002)(3846002)(14454004)(103116003)(99286004)(54906003)(110136005)(25786009)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5r/C9L0KmMOygWD5UyqRhN+yRl6O94CXMKmM2Qe05CgcKxBJyQDWR/yO1nUmnoxhC9lO/21Tk6aZltTPRkd66e8UMpkJjxv33/k2QKMrTnchgOEji7nLNOiVPsA3bIsdYvFl3dQqGUp6ZbzIqj5jtBYrOvZVPHXb1jX9g+1c6ah3MuZYGVSH2wAbACjnXMRYaY8s0gXBZ6o91dmxZHyu+Pq69nrsUkVHNRu0glSWnpGV4tsqTXo5RK12CJdxoTJhyPQdXCP82Jo3iX6me+LrY9d/6+9DdQLTe9AL3vVWJ2ZCDHt+BXAAvhIKaWkw+W1gpoXAjo8mFjan8P2iTq90HUmm6mxqd1KLyTDLGJcU2TmjRqE0AtlHe2laBeB/Q0/07lbCa41g8XKeTGs0fvPY0ZQJRRFrQC+0DDQFlzix4Hs3wzCUe/o/xLEEhQZpFklu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(1110001)(339900001)(189003)(199004)(103116003)(47776003)(6512007)(81156014)(6116002)(81166006)(8676002)(8936002)(50226002)(102836004)(8746002)(2616005)(6486002)(3846002)(386003)(6506007)(1076003)(11346002)(26005)(76176011)(76130400001)(336012)(5660300002)(70586007)(446003)(186003)(70206006)(25786009)(14444005)(2906002)(105606002)(26826003)(356004)(2501003)(14454004)(36756003)(22756006)(50466002)(478600001)(305945005)(316002)(54906003)(23756003)(110136005)(36906005)(7736002)(6636002)(99286004)(4326008)(86362001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4903;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 16d46c0b-026d-4561-6117-08d76e522baf
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzuUNzkTxKfHRWLxGUY2vKNtu2SJJlc4IK9g2Q5fvh8aCmNA3mOaAWoqS0kviWfX5kDVqGRunvYxcAJurJfXGETvbjg2pEzVUgGECqQyN9LqpHR0jkry3dTSCYle/FpezMymimDaTXEKX1YJQRfMpdQnNaky5pikigGSUuz1y4r7NNY86iR4qdW5GXQ+c/kO5XB8vMeJg1DBnHUDO1nDPlJ/RE2leBY2qYDwCVS8VieaX+if2iuQTMxMNKfFKlEBJeyR87QK+xzTk2wu0xytXsBV+0a3a0PD1VqtW/Z9xzTITc6WE03zoNh37067vRS8pth2vQvHc3FCr2SsEAjtt1+nC/j9uVcWdpt30oVhZNpRnHEa2o283IoFvhfhvbcNQmuXRfAcYPKmvT7+rKNyzfkT/yMGtcd4Mvp5+YHsY0bxJ4u3kOrzEfTu5YaONeN6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 07:12:37.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1327c876-1cda-4192-0188-08d76e52309a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda HW can support side by side, which splits the internal display
processing to two single halves (LEFT/RIGHT) and handle them by two
pipelines separately.
komeda "side by side" is enabled by DT property: "side_by_side_master",
once DT configured side by side, komeda need to verify it with HW's
configuration, and assemble it for the further usage.

v3: Correct a typo.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 13 ++++-
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  3 ++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  9 ++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 ++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 50 +++++++++++++++++--
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 6 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 1c452ea75999..cee9a1692e71 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -561,21 +561,30 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms=
,
 	kms->n_crtcs =3D 0;
=20
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
+		/* if sbs, one komeda_dev only can represent one CRTC */
+		if (mdev->side_by_side && i !=3D mdev->side_by_side_master)
+			continue;
+
 		crtc =3D &kms->crtcs[kms->n_crtcs];
 		master =3D mdev->pipelines[i];
=20
 		crtc->master =3D master;
 		crtc->slave  =3D komeda_pipeline_get_slave(master);
+		crtc->side_by_side =3D mdev->side_by_side;
=20
 		if (crtc->slave)
 			sprintf(str, "pipe-%d", crtc->slave->id);
 		else
 			sprintf(str, "None");
=20
-		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
-			 kms->n_crtcs, master->id, str);
+		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s) sbs(%s).\n",
+			 kms->n_crtcs, master->id, str,
+			 crtc->side_by_side ? "On" : "Off");
=20
 		kms->n_crtcs++;
+
+		if (mdev->side_by_side)
+			break;
 	}
=20
 	return 0;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 4e46f650fddf..c3fa4835cb8d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -178,6 +178,9 @@ static int komeda_parse_dt(struct device *dev, struct k=
omeda_dev *mdev)
 		}
 	}
=20
+	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master",
+						   &mdev->side_by_side_master);
+
 	return ret;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index d406a4d83352..471604b42431 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -183,6 +183,15 @@ struct komeda_dev {
=20
 	/** @irq: irq number */
 	int irq;
+	/**
+	 * @side_by_side:
+	 *
+	 * on sbs the whole display frame will be split to two halves (1:2),
+	 * master pipeline handles the left part, slave for the right part
+	 */
+	bool side_by_side;
+	/** @side_by_side_master: master pipe id for side by side */
+	int side_by_side_master;
=20
 	/** @lock: used to protect dpmode */
 	struct mutex lock;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 456f3c435719..ae6654fe95e2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -76,6 +76,9 @@ struct komeda_crtc {
 	 */
 	struct komeda_pipeline *slave;
=20
+	/** @side_by_side: if the master and slave works on side by side mode */
+	bool side_by_side;
+
 	/** @slave_planes: komeda slave planes mask */
 	u32 slave_planes;
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 452e505a1fd3..104e27cc1dc3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -326,14 +326,56 @@ static void komeda_pipeline_assemble(struct komeda_pi=
peline *pipe)
 struct komeda_pipeline *
 komeda_pipeline_get_slave(struct komeda_pipeline *master)
 {
-	struct komeda_component *slave;
+	struct komeda_dev *mdev =3D master->mdev;
+	struct komeda_component *comp, *slave;
+	u32 avail_inputs;
+
+	/* on SBS, slave pipeline merge to master via image processor */
+	if (mdev->side_by_side) {
+		comp =3D &master->improc->base;
+		avail_inputs =3D KOMEDA_PIPELINE_IMPROCS;
+	} else {
+		comp =3D &master->compiz->base;
+		avail_inputs =3D KOMEDA_PIPELINE_COMPIZS;
+	}
=20
-	slave =3D komeda_component_pickup_input(&master->compiz->base,
-					      KOMEDA_PIPELINE_COMPIZS);
+	slave =3D komeda_component_pickup_input(comp, avail_inputs);
=20
 	return slave ? slave->pipeline : NULL;
 }
=20
+static int komeda_assemble_side_by_side(struct komeda_dev *mdev)
+{
+	struct komeda_pipeline *master, *slave;
+	int i;
+
+	if (!mdev->side_by_side)
+		return 0;
+
+	if (mdev->side_by_side_master >=3D mdev->n_pipelines) {
+		DRM_ERROR("DT configured side by side master-%d is invalid.\n",
+			  mdev->side_by_side_master);
+		return -EINVAL;
+	}
+
+	master =3D mdev->pipelines[mdev->side_by_side_master];
+	slave =3D komeda_pipeline_get_slave(master);
+	if (!slave || slave->n_layers !=3D master->n_layers) {
+		DRM_ERROR("Current HW doesn't support side by side.\n");
+		return -EINVAL;
+	}
+
+	if (!master->dual_link) {
+		DRM_DEBUG_ATOMIC("SBS can not work without dual link.\n");
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < master->n_layers; i++)
+		master->layers[i]->sbs_slave =3D slave->layers[i];
+
+	return 0;
+}
+
 int komeda_assemble_pipelines(struct komeda_dev *mdev)
 {
 	struct komeda_pipeline *pipe;
@@ -346,7 +388,7 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev)
 		komeda_pipeline_dump(pipe);
 	}
=20
-	return 0;
+	return komeda_assemble_side_by_side(mdev);
 }
=20
 void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index ac8725e24853..20a076cce635 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -237,6 +237,7 @@ struct komeda_layer {
 	 * not the source buffer.
 	 */
 	struct komeda_layer *right;
+	struct komeda_layer *sbs_slave;
 };
=20
 struct komeda_layer_state {
--=20
2.20.1

