Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827BCC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438F120706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7l3fOIov";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7l3fOIov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLXRej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:34:39 -0500
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:12807
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfLXRei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8y3GMi06ZfA7o6GfitjMMzqG4xMPXJbq3e1jAMkuKU=;
 b=7l3fOIov1xafgnpggNQ2EZqPcKptPygSsLGDvPUBw/i1N/NRXlNYkRCCyf0K7plvIk8WY1S5N0emnp6hJSIpNl1F1gYbtk9VY5cIDfriVqMz4UbhBNcXMXWznH4dSbobA86M22tlN5gbpbmuVr/37HXvQPTD622WTDEcIGyzhEk=
Received: from VI1PR08CA0191.eurprd08.prod.outlook.com (2603:10a6:800:d2::21)
 by AM0PR08MB4243.eurprd08.prod.outlook.com (2603:10a6:208:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Tue, 24 Dec
 2019 17:34:32 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VI1PR08CA0191.outlook.office365.com
 (2603:10a6:800:d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:31 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:31 +0000
Received: ("Tessian outbound 28955e0c1ca8:v40"); Tue, 24 Dec 2019 17:34:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f1b881154abfd2ca
X-CR-MTA-TID: 64aa7808
Received: from c7aa28829b3e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1DF3A40A-A190-4531-9CFE-B0D49AEA1C08.1;
        Tue, 24 Dec 2019 17:34:25 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c7aa28829b3e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f346dqzGGcASRKRIM3AEpMlKvS9YN5WHCVGqlRGsFpr25P0g44VDgI3vPMRlgUADDO+kJe+lQcevQk0hw06Yg/ylyC3TzERUNkQ4OzcPZ1cXlAOgtJCW0mpXcqeVvXo8dwb+cXIp6hdHQPoGFzkKzjicyQA0dAesc2mcyqaffx1Z6mvwvQq/chBIqde96fPPrfUsJ4nJDzlMkXoDmDftDEWgf8iDui52yLOKB7WYsI5xczXlDcd32nGuh/EqdmSgiB1MvfgKU+neRQ38+pILXyF4GWj2Yd6D7gxHeJuUOje0+lFNEN+0YS6MiecfpaSpkBIyBiMGo5SXmaDAMxmC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8y3GMi06ZfA7o6GfitjMMzqG4xMPXJbq3e1jAMkuKU=;
 b=HXjkohl4H8m/Wyf8swCRB3RXp3dljdp4WcX9PgJTMQj5ZWs3obvbiuVf5iUf30JQRVFSzbLG52cmAk5VsVU/8jjR48qPqrGPtupBV1lMj/T4KAOxgrAcOWzFFqqktIeVv0ZZFRCVVz+UQ39I13eiEIVbFIa4gOqErQnHZrfUIGkHeYhLPPCWiqEAaS+xKBKKk00WJVK+7vqUaRJinCeQjHApdLwjg1aMUkkHtRibPYj2BFypzftTDmkBPoNvybvVw6b80OkHPyM1TCgfmIWTsgJEZuORnTF4Jq4CQiQTmT+oNc89FvYb2V/vdRKeGp7g5sn14HaUS6IW80OI9gd3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8y3GMi06ZfA7o6GfitjMMzqG4xMPXJbq3e1jAMkuKU=;
 b=7l3fOIov1xafgnpggNQ2EZqPcKptPygSsLGDvPUBw/i1N/NRXlNYkRCCyf0K7plvIk8WY1S5N0emnp6hJSIpNl1F1gYbtk9VY5cIDfriVqMz4UbhBNcXMXWznH4dSbobA86M22tlN5gbpbmuVr/37HXvQPTD622WTDEcIGyzhEk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:24 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:24 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/35] drm/bridge/synopsys: Stop using
 drm_bridge->driver_private
Thread-Topic: [PATCH v3 03/35] drm/bridge/synopsys: Stop using
 drm_bridge->driver_private
Thread-Index: AQHVuoBgDD48T29lSEihrvDPdP2k7g==
Date:   Tue, 24 Dec 2019 17:34:22 +0000
Message-ID: <20191224173408.25624-4-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc48e0e9-1e21-4a94-9fcc-08d788978908
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|AM0PR08MB4243:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB42436A92A03E2912C0EE996A8F290@AM0PR08MB4243.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:418;OLM:418;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5O3rSr2i+a+tA0amttawEsipuBxuQ9aYk9nUBG3FXI8lsJwTQgFjeN36i9z1Baeg8K33aVK5psq9kZcnhjhWZPeOGX2q4fKb5hKPLHY2OV58+jTNCWvuuz5xGEh/pwglQ8RUV7L54Ncjlv+g2IMvU+VCRf+hm+EW+PGn1mMigzQ/GoLrQffMrkgVhTnuBNIQ5EkmtjNGrlH/dhqEtjnOQoJD88x1dUVS8SaIIS5Qqa5KQ2b+CjOzZ03gBo/JohsUXk4t09Da806A+hR2XcA3tHFMH157+tX2Kw7y7MUJ1rMkafq7hiX4NF95kZn2/lvNZ8BSgOxuUy2ZSMAeNHuWTIGjypviavzMkx4TZQJ68Yz0RTikdXcbCTZmOuNI5sMWUm8nSqk0FCqDb0+frqY3fFL2bJ+PtvemHQtJ+D6VViqbNp53A1ov6n7g3wtwh2bX
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(81156014)(81166006)(6506007)(356004)(8676002)(76130400001)(8936002)(6512007)(2616005)(2906002)(86362001)(336012)(1076003)(70206006)(54906003)(70586007)(5660300002)(316002)(186003)(478600001)(6486002)(36756003)(26005)(4326008)(26826003)(6862004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4243;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0ab56e01-81a4-44e6-971b-08d788978356
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBpz38k2liqU5vVirUWgq+hCjYQsOjj4ppSmDh0kmOf0cVgRfTfVBf26XRyShMRFktIUslUjc26jy4HSfVpD750E/OcMEPLvUOPvZvcrHWEk3QIdlYqGYe5xCeT18KmCOxulxgBjXlT6ksuYKPBtwwqlxKEJEMprQSoXgk06qHneKQG73NV4LfSj5VRSM/oePpCRwDTBBNU5qVPzlgtDdhMrQ3vAyMwyHdGg00YfTnmRhfkttegLfU2pp/AV7BABSXfLYwm4sc/iPHMTf3p6JbvIm1fSe3/LAAcoBPQfz89fdfODUZveBRe46Hl6mIPPfHtCS+bgS1waYQtX6QNdjp21lrgavY0r2kCGpF63hLPa4QoHxU3X3/yEmJjjurzuT4Y9dP0Ydaov3UUeS5+ODDa5jZ+OM/2QiCnfsSzYjq/N4nTy1jF+tsSWccBv+h2D
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:31.5926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc48e0e9-1e21-4a94-9fcc-08d788978908
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4243
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dw_hdmi: The drm_bridge struct is already embedded, so use
a container_of wrapper to access it.

dw-mipi-dsi: The field is unused, remove it.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 15 ++++++++-------
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  1 -
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/br=
idge/synopsys/dw-hdmi.c
index 99274ca0fdf6..946aa1af8841 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -196,6 +196,8 @@ struct dw_hdmi {
 	struct cec_notifier *cec_notifier;
 };
=20
+#define bridge_to_dw_hdmi(b) container_of((b), struct dw_hdmi, bridge)
+
 #define HDMI_IH_PHY_STAT0_RX_SENSE \
 	(HDMI_IH_PHY_STAT0_RX_SENSE0 | HDMI_IH_PHY_STAT0_RX_SENSE1 | \
 	 HDMI_IH_PHY_STAT0_RX_SENSE2 | HDMI_IH_PHY_STAT0_RX_SENSE3)
@@ -2335,7 +2337,7 @@ static const struct drm_connector_helper_funcs dw_hdm=
i_connector_helper_funcs =3D
=20
 static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 {
-	struct dw_hdmi *hdmi =3D bridge->driver_private;
+	struct dw_hdmi *hdmi =3D bridge_to_dw_hdmi(bridge);
 	struct drm_encoder *encoder =3D bridge->encoder;
 	struct drm_connector *connector =3D &hdmi->connector;
 	struct cec_connector_info conn_info;
@@ -2372,7 +2374,7 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *b=
ridge)
=20
 static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
 {
-	struct dw_hdmi *hdmi =3D bridge->driver_private;
+	struct dw_hdmi *hdmi =3D bridge_to_dw_hdmi(bridge);
=20
 	mutex_lock(&hdmi->cec_notifier_mutex);
 	cec_notifier_conn_unregister(hdmi->cec_notifier);
@@ -2384,7 +2386,7 @@ static enum drm_mode_status
 dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 			  const struct drm_display_mode *mode)
 {
-	struct dw_hdmi *hdmi =3D bridge->driver_private;
+	struct dw_hdmi *hdmi =3D bridge_to_dw_hdmi(bridge);
 	struct drm_connector *connector =3D &hdmi->connector;
 	enum drm_mode_status mode_status =3D MODE_OK;
=20
@@ -2402,7 +2404,7 @@ static void dw_hdmi_bridge_mode_set(struct drm_bridge=
 *bridge,
 				    const struct drm_display_mode *orig_mode,
 				    const struct drm_display_mode *mode)
 {
-	struct dw_hdmi *hdmi =3D bridge->driver_private;
+	struct dw_hdmi *hdmi =3D bridge_to_dw_hdmi(bridge);
=20
 	mutex_lock(&hdmi->mutex);
=20
@@ -2414,7 +2416,7 @@ static void dw_hdmi_bridge_mode_set(struct drm_bridge=
 *bridge,
=20
 static void dw_hdmi_bridge_disable(struct drm_bridge *bridge)
 {
-	struct dw_hdmi *hdmi =3D bridge->driver_private;
+	struct dw_hdmi *hdmi =3D bridge_to_dw_hdmi(bridge);
=20
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled =3D true;
@@ -2425,7 +2427,7 @@ static void dw_hdmi_bridge_disable(struct drm_bridge =
*bridge)
=20
 static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 {
-	struct dw_hdmi *hdmi =3D bridge->driver_private;
+	struct dw_hdmi *hdmi =3D bridge_to_dw_hdmi(bridge);
=20
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled =3D false;
@@ -2898,7 +2900,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 			hdmi->ddc =3D NULL;
 	}
=20
-	hdmi->bridge.driver_private =3D hdmi;
 	hdmi->bridge.funcs =3D &dw_hdmi_bridge_funcs;
 #ifdef CONFIG_OF
 	hdmi->bridge.of_node =3D pdev->dev.of_node;
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-mipi-dsi.c
index b18351b6760a..3aa4f9289416 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1064,7 +1064,6 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		return ERR_PTR(ret);
 	}
=20
-	dsi->bridge.driver_private =3D dsi;
 	dsi->bridge.funcs =3D &dw_mipi_dsi_bridge_funcs;
 #ifdef CONFIG_OF
 	dsi->bridge.of_node =3D pdev->dev.of_node;
--=20
2.24.0

