Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450CEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE802070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfJGTV7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:21:59 -0400
Received: from mail-oln040092067010.outbound.protection.outlook.com ([40.92.67.10]:40554
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728753AbfJGTV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:21:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cengtP4VhDEdTrpkzSSAeaX1870ohQYBMSXdcYJs68cJ7adphrB4FkebpTKvO3urPicoeCs02I0w/6BVS29EGzvyrEg9wWNDDQ8aCU5WEdv12dabDwfKtI8ckSYh2AJmg3cY9kBhjyiSOZV6OjygaUG9VA2PM9qKPi6UM7eXGXUAfurDdLPG6X/uS8KxOxeFCDjsBzNpvrWU8KeclpUxyvQpHjsrNTVRghtz4iutVnBDGTOfjfEFTXybmIWS4hAdyT7yXfAoHWc75o+oxTvQF2V+GfsFWRiWooS6a65bK0aZJg1t/fwoXk+D2b7fv1URe6bboXnZ0aFMB25m/0w0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMr7TSAw59HeQij82vZcWLy+Seko8ouxQb5xqDWfYKU=;
 b=VtD+2DVsCXT44zo9/DQLeVjgmSyW5mx4nu6i1ZA01Wty0rRXzq0u+VF0tkCi6BIwbzdfuU440s552lHIT0/53dGrZ5PNp3tVLNvjpuoBpHiIlv2c0sGknsXNNecra3yhnEdU0T3A3EfYG/BEKfp42URiM6RcFdbdnhlPka8+BxyT532BtaAepsoJIuX1WFw5HINd879OT0uAncGFZFmDuddviHohHyCRpO6SUYCrVoKJnAHxpP7gWXcZQ9wS08uVBuiwe7iWbI2+Ky7201Em8uGDMnE1OlZSxmPfsPL7d4DCKqNGB8ULCgfrmRDoStszzxm+uRF4tVKHyj2RI+I1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (10.152.8.57) by AM5EUR02HT223.eop-EUR02.prod.protection.outlook.com
 (10.152.9.249) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.20; Mon, 7 Oct
 2019 19:21:52 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.8.55) by
 AM5EUR02FT039.mail.protection.outlook.com (10.152.9.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.20 via Frontend Transport; Mon, 7 Oct 2019 19:21:51 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8%4]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 19:21:51 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
Thread-Topic: [PATCH v2 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
Thread-Index: AQHVfUR4DEVZhP0iNUCc+IpngvnB+Q==
Date:   Mon, 7 Oct 2019 19:21:51 +0000
Message-ID: <HE1PR06MB40119DBC0DAE7BA251DF7074AC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20191007192135.4525-1-jonas@kwiboo.se>
In-Reply-To: <20191007192135.4525-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:2EC0351338A8C7C026F6C35DB4240C2DA494C07F5556F28F755AF783A6B0B62A;UpperCasedChecksum:A3DE7AC9E2901186DF0FE5F62BFB249AFA6EE6F7EC1C6EA3276DBE5B8BB88DD5;SizeAsReceived:8117;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [+DGfIH1tljwW6plgLJs9J94ZJkul7ZgA]
x-microsoft-original-message-id: <20191007192135.4525-4-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR02HT223:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgXf706xoIspInLE1UtGYXHnElulJYd9UqhcZYa/CAGEPt/XGjJf2t0SQ3b+TF2tOJRzs2r1pFILGLgJq6CYjFLokYGPUWt1VfPi/MEtQS1wAWxUDbJx9hplZV+sxhGIp4JRN0Cjn6NpBQ46ebyJTcrM/9fwP5kdWSoLCxhhKAWF+YV7T2kQjXihl+XkBPIz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9e58ce-bd17-400d-ad90-08d74b5b9b27
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 19:21:51.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Dynamic Range and Mastering InfoFrame on H6.

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index a44dca4b0219..e8a317d5ba19 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -226,6 +226,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	sun8i_hdmi_phy_init(hdmi->phy);
 
 	plat_data->mode_valid = hdmi->quirks->mode_valid;
+	plat_data->use_drm_infoframe = hdmi->quirks->use_drm_infoframe;
 	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
 
 	platform_set_drvdata(pdev, hdmi);
@@ -300,6 +301,7 @@ static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
 
 static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
 	.mode_valid = sun8i_dw_hdmi_mode_valid_h6,
+	.use_drm_infoframe = true,
 };
 
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index d707c9171824..8e64945167e9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -179,6 +179,7 @@ struct sun8i_dw_hdmi_quirks {
 	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
 					   const struct drm_display_mode *mode);
 	unsigned int set_rate : 1;
+	unsigned int use_drm_infoframe : 1;
 };
 
 struct sun8i_dw_hdmi {
-- 
2.17.1

