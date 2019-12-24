Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0737C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC592071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mYIFAD2e";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mYIFAD2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLXRex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:34:53 -0500
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:25603
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbfLXRen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+BjJ4oleP0F+g2uQH0sdo3cOlucbZnmXGMSAGPWTnU=;
 b=mYIFAD2e4WsuPFDY8d0DrKROsqf/Cj7Ya3ZlSrd0XT2aN8OZwrOg5I4Wlm2sx9edfPObmmINFVz0jyrR7hw8LOIZUp6ZJqLHD/LTbgJkWkrCtXX3Od2aCU1Pk/uvW3zVVF5LCF1qbxvXDpQCuhyNp+0VkHnqYTQmyp2RcSPjNHo=
Received: from HE1PR0802CA0016.eurprd08.prod.outlook.com (2603:10a6:3:bd::26)
 by AM0PR08MB5395.eurprd08.prod.outlook.com (2603:10a6:208:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Tue, 24 Dec
 2019 17:34:34 +0000
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by HE1PR0802CA0016.outlook.office365.com
 (2603:10a6:3:bd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:34 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:34 +0000
Received: ("Tessian outbound 121a58c8f9bf:v40"); Tue, 24 Dec 2019 17:34:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5375a5759b2747d4
X-CR-MTA-TID: 64aa7808
Received: from 3bb695b41535.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 19930B0A-9112-4056-9E8A-1A6F24B07B9F.1;
        Tue, 24 Dec 2019 17:34:28 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3bb695b41535.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UioaxFNnxh4vuSBOcxbYfGOQTW+sUs9SF3qjegxf9xQJGm99HuramR5/EiHsU7Fdc2pwcZYQXCDEHWOsC1n3pTh0eqpWmmUFMq0H+gOpoFy8Fz1a/4g1VM/UgF6YD3eLtBEXY3F8Ld5zMqsWSWQZZ0UqETb8EZc1Rox9nMP8dMbLASplxOT/vZCDySMtAlu2zWwY/ZMU96hY64mdhVZP2BKcltYaiOAajB8HaYg3g5q5B2O4IUJu5nRCwmS7mc/a1/oTltskC2B9ZHIBD4in124NjaLFBDZEtzwna8s94Wlgv6GoO4yMQhTjwxJPS7JMf1+0dcrV960gIXRyEyZ+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+BjJ4oleP0F+g2uQH0sdo3cOlucbZnmXGMSAGPWTnU=;
 b=GoZHQei+V5yncd2bKKZZ34asLtOLDbIjxuCctIeWdt8TZVhxgXCt015Z9D4a8yGT8MVlG4V8Y/Q/Jl+p06cyBrlDoU4QQRIM0oxiKuOAWnfY+nkl60HCCh9U73n7Z0VTf2EdTD7Pm3BIDwtHYFeHXD5zzAEEr1KMrwUhOWakQ5QcbOi3+FfLDRzYDrg4efnVZbxAJRHMOorbH4h/5JFMcn78QPeig/z7FVQ2uJ+T4JzZ1frUwAsXjkf/ahpN7oiryobwMwHYaE85G5Y5XQG6Frpe4WXd80Et2jhZJBPQw65OnoOKJEkL+Sdr/Doj3PhDpYxeTJixxCLo4f+jm0/yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+BjJ4oleP0F+g2uQH0sdo3cOlucbZnmXGMSAGPWTnU=;
 b=mYIFAD2e4WsuPFDY8d0DrKROsqf/Cj7Ya3ZlSrd0XT2aN8OZwrOg5I4Wlm2sx9edfPObmmINFVz0jyrR7hw8LOIZUp6ZJqLHD/LTbgJkWkrCtXX3Od2aCU1Pk/uvW3zVVF5LCF1qbxvXDpQCuhyNp+0VkHnqYTQmyp2RcSPjNHo=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:27 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:27 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/35] drm/sti: Stop using drm_bridge->driver_private
Thread-Topic: [PATCH v3 07/35] drm/sti: Stop using drm_bridge->driver_private
Thread-Index: AQHVuoBjsi6tg1ZBDEOAw9KpCAgOVA==
Date:   Tue, 24 Dec 2019 17:34:26 +0000
Message-ID: <20191224173408.25624-8-mihail.atanassov@arm.com>
References: <20191224173408.25624-1-mihail.atanassov@arm.com>
In-Reply-To: <20191224173408.25624-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.24.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9f2c114-e6cf-4829-4281-08d788978abd
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|AM0PR08MB5395:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB53952210AFF0285FE87415BF8F290@AM0PR08MB5395.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6ICbo7rSN+pfeClD8ZLLWS58j6MHR3aXKPPSgyof4Z6QYs90B8jihqpGht9srtqZe0TnZfsKRW9pOd4r3eEIuk41Gayao/HI1LmOqQBMXxgmp4DGExUi2QiAQ/gOEccRKVsP0mIXY9uyf8ppaB36GmYspjVffUZi9D0EYDJMvy5PGSQ4XbyZm0bTZvFymydzAVPS4Z0xcJ0EIfUExYH30fRApwtcBJCE6B74qUBEuxhTogvm0rDFSmKV1uEgiS8nhKpHoYPotZam4T1NmpWgMY75qvR6gv/95iVHgzs/BcIRnJ/PEnT4vvfvfCCxkH6f0L4Xv3QnmOLMv5E86WXjkyVaglkE9+dKNTah9VaO4lQi6WzV3nklmUjwpCtm5VDg/ZP5xKctHFlNJSlCkQ6qabVA102Mf0khddh3jnN7TRJiA2NEc1XetbI3qwsNzhlY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(70586007)(70206006)(186003)(81156014)(81166006)(54906003)(36906005)(26826003)(478600001)(36756003)(26005)(8676002)(5660300002)(8936002)(336012)(316002)(86362001)(6486002)(356004)(76130400001)(6862004)(2616005)(2906002)(4326008)(6512007)(6506007)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5395;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d0868ee4-142d-4d0c-e825-08d7889785e3
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un4WT5eTbQG7HxsjJV0u2dAsPVrjH/jlXGtbsyjiL0QEj8BW6LtGz9KQAlf+ZUt9apZW8Yq1xZ/aZLfjwLBR8CvW3jI2Js6QB3/MEPnMa/vjBtf7JSy3dKdhhv38t2TjM4oew9yxyfgmnkmCB8+Vye0DewoZqpaIC9afYDnLx72mq4kfpDnNpyjHXUPblkxxVGFysLvbL92FVowORpz8+Kbbn/Hep0CIF8+uLMjKy2qspzfFxKNpZayw7aZ2kIHqFPWBuD/qoAW9bCDBqTQeJ5HFCze5zXR0JnNMQ3J4w1Ic6sn18Kw+2t4ZnYwHgv0H3dDpFw5tlmbv4VLBLj5ILtNYC0lX/8zGPn71xfATTK06TUQJxuincq90dcXrg/eBOJ8pR8+yE2+F8ysV0pHlQlh35rtEBXRPby6mAI90eLPIwAqeW34NvVGBqTRML19C
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:34.3851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f2c114-e6cf-4829-4281-08d788978abd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead, embed the drm_bridge structure in the originally-pointed-to
struct and use a container_of wrapper to access it.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 20 ++++++++------------
 drivers/gpu/drm/sti/sti_hda.c  | 17 ++++++++---------
 drivers/gpu/drm/sti/sti_hdmi.c | 13 ++++---------
 drivers/gpu/drm/sti/sti_hdmi.h |  5 +++++
 4 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index df2ee86cd4c1..194491231de2 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -96,9 +96,11 @@ struct sti_dvo {
 	struct dvo_config *config;
 	bool enabled;
 	struct drm_encoder *encoder;
-	struct drm_bridge *bridge;
+	struct drm_bridge bridge;
 };
=20
+#define bridge_to_sti_dvo(b) container_of((b), struct sti_dvo, bridge)
+
 struct sti_dvo_connector {
 	struct drm_connector drm_connector;
 	struct drm_encoder *encoder;
@@ -210,7 +212,7 @@ static int dvo_debugfs_init(struct sti_dvo *dvo, struct=
 drm_minor *minor)
=20
 static void sti_dvo_disable(struct drm_bridge *bridge)
 {
-	struct sti_dvo *dvo =3D bridge->driver_private;
+	struct sti_dvo *dvo =3D bridge_to_sti_dvo(bridge);
=20
 	if (!dvo->enabled)
 		return;
@@ -233,7 +235,7 @@ static void sti_dvo_disable(struct drm_bridge *bridge)
=20
 static void sti_dvo_pre_enable(struct drm_bridge *bridge)
 {
-	struct sti_dvo *dvo =3D bridge->driver_private;
+	struct sti_dvo *dvo =3D bridge_to_sti_dvo(bridge);
 	struct dvo_config *config =3D dvo->config;
 	u32 val;
=20
@@ -280,7 +282,7 @@ static void sti_dvo_set_mode(struct drm_bridge *bridge,
 			     const struct drm_display_mode *mode,
 			     const struct drm_display_mode *adjusted_mode)
 {
-	struct sti_dvo *dvo =3D bridge->driver_private;
+	struct sti_dvo *dvo =3D bridge_to_sti_dvo(bridge);
 	struct sti_mixer *mixer =3D to_sti_mixer(dvo->encoder->crtc);
 	int rate =3D mode->clock * 1000;
 	struct clk *clkp;
@@ -438,11 +440,11 @@ static struct drm_encoder *sti_dvo_find_encoder(struc=
t drm_device *dev)
 static int sti_dvo_bind(struct device *dev, struct device *master, void *d=
ata)
 {
 	struct sti_dvo *dvo =3D dev_get_drvdata(dev);
+	struct drm_bridge *bridge =3D &dvo->bridge;
 	struct drm_device *drm_dev =3D data;
 	struct drm_encoder *encoder;
 	struct sti_dvo_connector *connector;
 	struct drm_connector *drm_connector;
-	struct drm_bridge *bridge;
 	int err;
=20
 	/* Set the drm device handle */
@@ -458,11 +460,6 @@ static int sti_dvo_bind(struct device *dev, struct dev=
ice *master, void *data)
=20
 	connector->dvo =3D dvo;
=20
-	bridge =3D devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge)
-		return -ENOMEM;
-
-	bridge->driver_private =3D dvo;
 	bridge->funcs =3D &sti_dvo_bridge_funcs;
 	bridge->of_node =3D dvo->dev.of_node;
 	drm_bridge_add(bridge);
@@ -473,7 +470,6 @@ static int sti_dvo_bind(struct device *dev, struct devi=
ce *master, void *data)
 		return err;
 	}
=20
-	dvo->bridge =3D bridge;
 	connector->encoder =3D encoder;
 	dvo->encoder =3D encoder;
=20
@@ -504,7 +500,7 @@ static void sti_dvo_unbind(struct device *dev,
 {
 	struct sti_dvo *dvo =3D dev_get_drvdata(dev);
=20
-	drm_bridge_remove(dvo->bridge);
+	drm_bridge_remove(&dvo->bridge);
 }
=20
 static const struct component_ops sti_dvo_ops =3D {
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 8f7bf33815fd..d5b569ce93d0 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -236,6 +236,7 @@ static const struct sti_hda_video_config hda_supported_=
modes[] =3D {
  *
  * @dev: driver device
  * @drm_dev: pointer to drm device
+ * @bridge: drm bridge for encoder->connector link
  * @mode: current display mode selected
  * @regs: HD analog register
  * @video_dacs_ctrl: video DACS control register
@@ -244,6 +245,7 @@ static const struct sti_hda_video_config hda_supported_=
modes[] =3D {
 struct sti_hda {
 	struct device dev;
 	struct drm_device *drm_dev;
+	struct drm_bridge bridge;
 	struct drm_display_mode mode;
 	void __iomem *regs;
 	void __iomem *video_dacs_ctrl;
@@ -252,6 +254,8 @@ struct sti_hda {
 	bool enabled;
 };
=20
+#define bridge_to_sti_hda(b) container_of((b), struct sti_hda, bridge)
+
 struct sti_hda_connector {
 	struct drm_connector drm_connector;
 	struct drm_encoder *encoder;
@@ -400,7 +404,7 @@ static void sti_hda_configure_awg(struct sti_hda *hda, =
u32 *awg_instr, int nb)
=20
 static void sti_hda_disable(struct drm_bridge *bridge)
 {
-	struct sti_hda *hda =3D bridge->driver_private;
+	struct sti_hda *hda =3D bridge_to_sti_hda(bridge);
 	u32 val;
=20
 	if (!hda->enabled)
@@ -425,7 +429,7 @@ static void sti_hda_disable(struct drm_bridge *bridge)
=20
 static void sti_hda_pre_enable(struct drm_bridge *bridge)
 {
-	struct sti_hda *hda =3D bridge->driver_private;
+	struct sti_hda *hda =3D bridge_to_sti_hda(bridge);
 	u32 val, i, mode_idx;
 	u32 src_filter_y, src_filter_c;
 	u32 *coef_y, *coef_c;
@@ -516,7 +520,7 @@ static void sti_hda_set_mode(struct drm_bridge *bridge,
 			     const struct drm_display_mode *mode,
 			     const struct drm_display_mode *adjusted_mode)
 {
-	struct sti_hda *hda =3D bridge->driver_private;
+	struct sti_hda *hda =3D bridge_to_sti_hda(bridge);
 	u32 mode_idx;
 	int hddac_rate;
 	int ret;
@@ -676,10 +680,10 @@ static int sti_hda_bind(struct device *dev, struct de=
vice *master, void *data)
 {
 	struct sti_hda *hda =3D dev_get_drvdata(dev);
 	struct drm_device *drm_dev =3D data;
+	struct drm_bridge *bridge =3D &hda->bridge;
 	struct drm_encoder *encoder;
 	struct sti_hda_connector *connector;
 	struct drm_connector *drm_connector;
-	struct drm_bridge *bridge;
 	int err;
=20
 	/* Set the drm device handle */
@@ -695,11 +699,6 @@ static int sti_hda_bind(struct device *dev, struct dev=
ice *master, void *data)
=20
 	connector->hda =3D hda;
=20
-		bridge =3D devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge)
-		return -ENOMEM;
-
-	bridge->driver_private =3D hda;
 	bridge->funcs =3D &sti_hda_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
=20
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.=
c
index 814560ead4e1..7a7b0ce7bb14 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -741,7 +741,7 @@ static int hdmi_debugfs_init(struct sti_hdmi *hdmi, str=
uct drm_minor *minor)
=20
 static void sti_hdmi_disable(struct drm_bridge *bridge)
 {
-	struct sti_hdmi *hdmi =3D bridge->driver_private;
+	struct sti_hdmi *hdmi =3D bridge_to_sti_hdmi(bridge);
=20
 	u32 val =3D hdmi_read(hdmi, HDMI_CFG);
=20
@@ -873,7 +873,7 @@ static int hdmi_audio_configure(struct sti_hdmi *hdmi)
=20
 static void sti_hdmi_pre_enable(struct drm_bridge *bridge)
 {
-	struct sti_hdmi *hdmi =3D bridge->driver_private;
+	struct sti_hdmi *hdmi =3D bridge_to_sti_hdmi(bridge);
=20
 	DRM_DEBUG_DRIVER("\n");
=20
@@ -928,7 +928,7 @@ static void sti_hdmi_set_mode(struct drm_bridge *bridge=
,
 			      const struct drm_display_mode *mode,
 			      const struct drm_display_mode *adjusted_mode)
 {
-	struct sti_hdmi *hdmi =3D bridge->driver_private;
+	struct sti_hdmi *hdmi =3D bridge_to_sti_hdmi(bridge);
 	int ret;
=20
 	DRM_DEBUG_DRIVER("\n");
@@ -1255,11 +1255,11 @@ static int sti_hdmi_bind(struct device *dev, struct=
 device *master, void *data)
 {
 	struct sti_hdmi *hdmi =3D dev_get_drvdata(dev);
 	struct drm_device *drm_dev =3D data;
+	struct drm_bridge *bridge =3D &hdmi->bridge;
 	struct drm_encoder *encoder;
 	struct sti_hdmi_connector *connector;
 	struct cec_connector_info conn_info;
 	struct drm_connector *drm_connector;
-	struct drm_bridge *bridge;
 	int err;
=20
 	/* Set the drm device handle */
@@ -1275,11 +1275,6 @@ static int sti_hdmi_bind(struct device *dev, struct =
device *master, void *data)
=20
 	connector->hdmi =3D hdmi;
=20
-	bridge =3D devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge)
-		return -EINVAL;
-
-	bridge->driver_private =3D hdmi;
 	bridge->funcs =3D &sti_hdmi_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
=20
diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.=
h
index 1f6dc90b5d83..4e33cbd7cbca 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.h
+++ b/drivers/gpu/drm/sti/sti_hdmi.h
@@ -12,6 +12,7 @@
=20
 #include <media/cec-notifier.h>
=20
+#include <drm/drm_bridge.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_property.h>
=20
@@ -46,6 +47,7 @@ static const struct drm_prop_enum_list colorspace_mode_na=
mes[] =3D {
  *
  * @dev: driver device
  * @drm_dev: pointer to drm device
+ * @bridge: drm bridge for encoder->connector link
  * @mode: current display mode selected
  * @regs: hdmi register
  * @syscfg: syscfg register for pll rejection configuration
@@ -72,6 +74,7 @@ static const struct drm_prop_enum_list colorspace_mode_na=
mes[] =3D {
 struct sti_hdmi {
 	struct device dev;
 	struct drm_device *drm_dev;
+	struct drm_bridge bridge;
 	struct drm_display_mode mode;
 	void __iomem *regs;
 	void __iomem *syscfg;
@@ -96,6 +99,8 @@ struct sti_hdmi {
 	struct cec_notifier *notifier;
 };
=20
+#define bridge_to_sti_hdmi(b) container_of((b), struct sti_hdmi, bridge)
+
 u32 hdmi_read(struct sti_hdmi *hdmi, int offset);
 void hdmi_write(struct sti_hdmi *hdmi, u32 val, int offset);
=20
--=20
2.24.0

