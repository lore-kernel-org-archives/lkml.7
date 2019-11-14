Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E15C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40B42070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rS0OBR4p";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rS0OBR4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKNIhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:37:42 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:34839
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfKNIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsOUzp77nJl9O3WojFtY2JRXsyfXhsor1OJ5olyuFR0=;
 b=rS0OBR4p14/DJju/VzEVcfPJYYl0h6oAFyTlcYVGc0XjKwIx/+d+OWRZXtOjUb8pp7YP17XXbYaqVgasyhxfG5QTX1vhZoJv8aFGAkQavkB17NawyP2rxRl1l1leW4mhsqYy3X8aBEnyN4ywX8GG2sXZ72PS20r9x/GxX0e/e5I=
Received: from AM6PR08CA0009.eurprd08.prod.outlook.com (2603:10a6:20b:b2::21)
 by AM5PR0802MB2564.eurprd08.prod.outlook.com (2603:10a6:203:a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 14 Nov
 2019 08:37:34 +0000
Received: from AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM6PR08CA0009.outlook.office365.com
 (2603:10a6:20b:b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Thu, 14 Nov 2019 08:37:35 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT017.mail.protection.outlook.com (10.152.16.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:37:34 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Thu, 14 Nov 2019 08:37:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ef44006d2a0e0b86
X-CR-MTA-TID: 64aa7808
Received: from 3ea362dbe0f1.2 (cr-mta-lb-1.cr-mta-net [104.47.6.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AB8C96AF-C819-4356-BFFE-22504439D382.1;
        Thu, 14 Nov 2019 08:37:28 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3ea362dbe0f1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGY1Tr+IoapMO6nFGGZk1Di1nQeg/noQYNX8hDS71trYaUOmtWTLBykewlvxtJgCI5ip4DfbHc+EUBXgPhRJGLCfkH545pH2XaZPIkinqSNFr6J9OxBVjMs0KT9IxSASt7++A0m5XpG243etVprtkzSYlMvuM6tRh6t8MlM42vMuCwvzoDGrjaeJAOlj9KtpS3xtMaPCb67zI2ZpqDRQ/ylFjTwwXeOGKT1SQ0G8x2WWvRLCnkJmxatbh/uVsHN0aY3/uaQ57vNay0fAfA3KE8Zfp2g/G6XyDNuKsLDWbcaw75wnEzO0GeI1gvKvUXFh6OjjX4aPqc9vQaQ4KUNFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsOUzp77nJl9O3WojFtY2JRXsyfXhsor1OJ5olyuFR0=;
 b=VfRrN9zG0R9vsCdDN0qllC9m5lLXfe/glA5/Tke77uQBeetIjucJDlaWQiEejLsje2lQshXSKGhQr9pj3c87xlLYaNCk04BGH9t4q4YkpOj9kDXuenkK6aOhkXLpX2KoBxOQt+MqOQGNj9X9xUpIUZhVLvYwWQLwIwWtJYRPT9NsXA4wL8RKNO+sXdvMcFOVnMBTV03GaUAbZVWAY9+H/Od3oRFycMSZym75zhyY09O7NJcfRtWRZ6cLOAtV9GTWbcpIhk+EnMB5PvQe41zRKdUk11aHwSLOOLq0vWHM+77OV6C85kvpSRkDDj4xDfGKMJm+Ss2Yo41HPOLFM2psLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsOUzp77nJl9O3WojFtY2JRXsyfXhsor1OJ5olyuFR0=;
 b=rS0OBR4p14/DJju/VzEVcfPJYYl0h6oAFyTlcYVGc0XjKwIx/+d+OWRZXtOjUb8pp7YP17XXbYaqVgasyhxfG5QTX1vhZoJv8aFGAkQavkB17NawyP2rxRl1l1leW4mhsqYy3X8aBEnyN4ywX8GG2sXZ72PS20r9x/GxX0e/e5I=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4782.eurprd08.prod.outlook.com (10.255.115.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 08:37:25 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:37:25 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 1/6] drm/komeda: Add side by side assembling
Thread-Topic: [PATCH v3 1/6] drm/komeda: Add side by side assembling
Thread-Index: AQHVmsa9UkYGk9o7O0O+920wharNZA==
Date:   Thu, 14 Nov 2019 08:37:24 +0000
Message-ID: <20191114083658.27237-2-james.qian.wang@arm.com>
References: <20191114083658.27237-1-james.qian.wang@arm.com>
In-Reply-To: <20191114083658.27237-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 628033a1-f98c-4605-7cd1-08d768dde5d5
X-MS-TrafficTypeDiagnostic: VE1PR08MB4782:|VE1PR08MB4782:|AM5PR0802MB2564:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2564F11E39C98D2DFC7B5595B3710@AM5PR0802MB2564.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3044;OLM:3044;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(189003)(199004)(25786009)(486006)(66476007)(66446008)(66946007)(66556008)(64756008)(66066001)(11346002)(4326008)(386003)(6636002)(8936002)(446003)(2616005)(476003)(305945005)(14454004)(2501003)(478600001)(36756003)(7736002)(1076003)(5660300002)(54906003)(256004)(14444005)(316002)(6436002)(6512007)(71190400001)(52116002)(71200400001)(110136005)(76176011)(8676002)(102836004)(6506007)(6486002)(2201001)(55236004)(50226002)(103116003)(26005)(86362001)(186003)(3846002)(2906002)(81166006)(81156014)(6116002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4782;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KVe4BfeS7WEdRZ90f2As8N+RcKkFWSeROha2cSQNjLMU4uWrplslVjct+5o2KYyZ8gc/dPbbrdlj06FqN8edISH6z4Lk0tWW1SsnxgmDM6qpov/oxBI+se70xmLTTF9aE4iVRoVF7TgXMRLbSBMSjblfw5qNrq2H/1PWLefZCIg2NEUH6rNMQ6gaaLodKiPZjQGWu+/c+OeO70dcJKnmmVFCt0OtZdEcGdS4ueD2Qp1FjQ+8N6qIKastw6CnqNCaa6rQuJCu7RAg4XyEfh+E4B5JCharKsMiRA9RgNpJPhkR5yjgGHgI8LHxEZD6tG2cgHqYx3cHpueQOjO+WTxB2iOf4hSkDItiU9NQjzDH135nR/qfH/fgfkoUE+FGB2SyJTdtiiapLGlIZQoSbb8Jo6xN5nFVXheFbqdpKJ5CIBNP+uIJV3za30dnN7jELX7a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4782
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(1110001)(339900001)(189003)(199004)(8676002)(50226002)(23756003)(446003)(11346002)(102836004)(2501003)(26005)(305945005)(7736002)(66066001)(5660300002)(70586007)(2906002)(6116002)(8936002)(81166006)(3846002)(8746002)(22756006)(76130400001)(81156014)(14444005)(70206006)(47776003)(54906003)(1076003)(356004)(103116003)(76176011)(486006)(105606002)(386003)(36756003)(476003)(2616005)(126002)(6506007)(99286004)(36906005)(478600001)(186003)(336012)(2201001)(6636002)(50466002)(4326008)(316002)(14454004)(6512007)(26826003)(86362001)(110136005)(6486002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2564;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: db6ed058-2e0e-4029-4a3a-08d768dddfbc
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3ybpb8iIWiTbbSCaNF1yQYko1HzPPrbyVoeOpph4Wj9OY7Jcfn4HUG9AsWRpvba93V5ZsPpiSmkYXMTuRZbyoA9nBvQzW0r7tFz2ryUpz8yDoQig6fI0eFwk5VlFixmtMaXGZEKIaabBlKGF2g4XC4H//KPy+12bZxBlGmFKOxixI3zKNkukkKDi9edjI97Vh2S871Cyymq3VDBy+37aUqJXyFXan5aPPB5sUpvCmVPTS16CiXs2fycpd6S3usxyRauuzM5JIwBPT99rs0SgCZ9DthjEnZn3vX6Ob0t4tG6dp0WrjpcMKMy4g3e18dQeTNUBfE6Hc8gKCCfN7tYgCOOwycomKGfE3Xvkk3r6cL+fYzY5ks0f0jg8zNKgW82TL9B8+aKo+fbCUiA6uywzXGFoWD/uLODw+1t0Clp1vGuNkKjDiUme5l/MIzq+sx5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:37:34.8628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628033a1-f98c-4605-7cd1-08d768dde5d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2564
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

