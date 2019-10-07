Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F08ECE596
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6682070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfJGTVz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:21:55 -0400
Received: from mail-oln040092067026.outbound.protection.outlook.com ([40.92.67.26]:44163
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbfJGTVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7g7yUeB+IHaHKDGvv2MxPQUORaR6uEDGy/wvmQ25CCbrPX+MX8toaivxE8cYkoOVm9vPMuSBio+Zz+5mMkHiOyxP/jhTz8Fgyx8js9hFuln/jbiqpLRZm5QcVNeMUf36mMTygGWGJo6bAko8ac/EN00qx0LNmkT9lYb69KBBiRRJQwKWgCBXiEnMR9bAhdsWUGImt0prbUB1DnG5xb5ktOTJIyX0pj1Xk11pVtPMnB6w2wEJx3HcJ7sfSrDzJiiViLQqO5quOHFUsP9Zbyj6/+ZZx3Go25IayAzi/LycG7F8hUgV3VuTsqrxjSvz3YDkD+IZRsH47Luz3/SBPfD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GmXMoZqbQgbuXEGY5AMW5EjmhkY8tF/xxVQQoHQrIA=;
 b=BtbhHJk03/94eLeSjSkh7XsMnk6/HJiZP20o4SyWg7r5sqRFm64vFaOXPaeOtF4qGbFqaumenESWRpKb8wllY80uzcmlhUDc5KRLymzB2glyZcP4l4po1vDPDwRp+iiBVgpDg0qmlSbvyhzeDA/rndOGbo3Ex3uCe0595RRId//MkbBe85EFZTLe6P+H4JzEjYPJ2+fahw9Ybcvoh/WMGKZGy6mnPhTRcl9S4vwCrkFZrWm9F8Arr9CI+vNtA8cGlZS4kgky/V9/zcQTSiho82XL1fUnjlULuj4jLu7NN18mlycWXtZvn/gNCsB3e4nkhJ0aDqqROcYA/3u9dnNMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (10.152.8.58) by AM5EUR02HT008.eop-EUR02.prod.protection.outlook.com
 (10.152.8.87) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.20; Mon, 7 Oct
 2019 19:21:48 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.8.55) by
 AM5EUR02FT039.mail.protection.outlook.com (10.152.9.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.20 via Frontend Transport; Mon, 7 Oct 2019 19:21:48 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::5c5a:1160:a2e0:43d8%4]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 19:21:48 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] drm/bridge: dw-hdmi: Add Dynamic Range and Mastering
 InfoFrame support
Thread-Topic: [PATCH v2 1/4] drm/bridge: dw-hdmi: Add Dynamic Range and
 Mastering InfoFrame support
Thread-Index: AQHVfUR3du6nZITFzkKDCJlMcDjXMg==
Date:   Mon, 7 Oct 2019 19:21:48 +0000
Message-ID: <HE1PR06MB4011D7B916CBF8B740ACC45FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:70BAB055347A50A9803CE6752A0D259B08E0EB46AFB17D25F50CA8CE9270C4BC;UpperCasedChecksum:02E8799A1085B2CCA5C61188EFBEB4C23A746D419F76A145C87E0FCB5C869ECE;SizeAsReceived:8141;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [AQR41JfWxKoBBSfOwQMM3oAjNLbYRz6W]
x-microsoft-original-message-id: <20191007192135.4525-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR02HT008:
x-ms-exchange-purlcount: 2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3W+XYo+8KkSK6ALcfRpp0b1mhe8g435YyjwxsvFGO+wMiUnRQWBfv6s7okDvYO8uwShPU9hkakmMJectDWFnSZcPpsiIGjugdWQo1n4zHQWSDHfZKkyBZ0ztO2g9gbFVvg8zBtd5dITm6SZL8oJDytyH78Y/VQ1U/y08yXA1TtqX9WoX3zLwSakZbJK6UWZJ8lXnoB5srIJ3xwfy/AWmNqaGrRP/L3opE1LpbTtnSqg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c375bb-b166-4e5f-b763-08d74b5b995d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 19:21:48.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuring Dynamic Range and Mastering InfoFrame from
the hdr_output_metadata connector property.

This patch adds a use_drm_infoframe flag to dw_hdmi_plat_data that platform
drivers use to signal when Dynamic Range and Mastering infoframes is supported.
This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
and only GXL support DRM InfoFrame.

These changes were based on work done by Zheng Yang <zhengyang@rock-chips.com>
to support DRM InfoFrame on the Rockchip 4.4 BSP kernel at [1] and [2]

[1] https://github.com/rockchip-linux/kernel/tree/develop-4.4
[2] https://github.com/rockchip-linux/kernel/commit/d1943fde81ff41d7cca87f4a42f03992e90bddd5

Cc: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 81 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 37 +++++++++++
 include/drm/bridge/dw_hdmi.h              |  1 +
 3 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a15fbf71b9d7..fdc29869d75a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -25,6 +25,7 @@
 #include <uapi/linux/videodev2.h>
 
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
@@ -1743,6 +1744,41 @@ static void hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi,
 			HDMI_FC_DATAUTO0_VSD_MASK);
 }
 
+static void hdmi_config_drm_infoframe(struct dw_hdmi *hdmi)
+{
+	const struct drm_connector_state *conn_state = hdmi->connector.state;
+	struct hdmi_drm_infoframe frame;
+	u8 buffer[30];
+	ssize_t err;
+	int i;
+
+	if (!hdmi->plat_data->use_drm_infoframe)
+		return;
+
+	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_DISABLE,
+		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
+
+	err = drm_hdmi_infoframe_set_hdr_metadata(&frame, conn_state);
+	if (err < 0)
+		return;
+
+	err = hdmi_drm_infoframe_pack(&frame, buffer, sizeof(buffer));
+	if (err < 0) {
+		dev_err(hdmi->dev, "Failed to pack drm infoframe: %zd\n", err);
+		return;
+	}
+
+	hdmi_writeb(hdmi, frame.version, HDMI_FC_DRM_HB0);
+	hdmi_writeb(hdmi, frame.length, HDMI_FC_DRM_HB1);
+
+	for (i = 0; i < frame.length; i++)
+		hdmi_writeb(hdmi, buffer[4 + i], HDMI_FC_DRM_PB0 + i);
+
+	hdmi_writeb(hdmi, 1, HDMI_FC_DRM_UP);
+	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_ENABLE,
+		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
+}
+
 static void hdmi_av_composer(struct dw_hdmi *hdmi,
 			     const struct drm_display_mode *mode)
 {
@@ -2064,6 +2100,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 		/* HDMI Initialization Step F - Configure AVI InfoFrame */
 		hdmi_config_AVI(hdmi, mode);
 		hdmi_config_vendor_specific_infoframe(hdmi, mode);
+		hdmi_config_drm_infoframe(hdmi);
 	} else {
 		dev_dbg(hdmi->dev, "%s DVI mode\n", __func__);
 	}
@@ -2230,6 +2267,45 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
+static bool hdr_metadata_equal(const struct drm_connector_state *old_state,
+			       const struct drm_connector_state *new_state)
+{
+	struct drm_property_blob *old_blob = old_state->hdr_output_metadata;
+	struct drm_property_blob *new_blob = new_state->hdr_output_metadata;
+
+	if (!old_blob || !new_blob)
+		return old_blob == new_blob;
+
+	if (old_blob->length != new_blob->length)
+		return false;
+
+	return !memcmp(old_blob->data, new_blob->data, old_blob->length);
+}
+
+static int dw_hdmi_connector_atomic_check(struct drm_connector *connector,
+					  struct drm_atomic_state *state)
+{
+	struct drm_connector_state *old_state =
+		drm_atomic_get_old_connector_state(state, connector);
+	struct drm_connector_state *new_state =
+		drm_atomic_get_new_connector_state(state, connector);
+	struct drm_crtc *crtc = new_state->crtc;
+	struct drm_crtc_state *crtc_state;
+
+	if (!crtc)
+		return 0;
+
+	if (!hdr_metadata_equal(old_state, new_state)) {
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		crtc_state->mode_changed = true;
+	}
+
+	return 0;
+}
+
 static void dw_hdmi_connector_force(struct drm_connector *connector)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
@@ -2254,6 +2330,7 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
 	.get_modes = dw_hdmi_connector_get_modes,
+	.atomic_check = dw_hdmi_connector_atomic_check,
 };
 
 static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
@@ -2274,6 +2351,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 				    DRM_MODE_CONNECTOR_HDMIA,
 				    hdmi->ddc);
 
+	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
+		drm_object_attach_property(&connector->base,
+			connector->dev->mode_config.hdr_output_metadata_property, 0);
+
 	drm_connector_attach_encoder(connector, encoder);
 
 	cec_fill_conn_info_from_drm(&conn_info, connector);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index fcff5059db24..1999db05bc3b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -254,6 +254,7 @@
 #define HDMI_FC_POL2                            0x10DB
 #define HDMI_FC_PRCONF                          0x10E0
 #define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
+#define HDMI_FC_PACKET_TX_EN                    0x10E3
 
 #define HDMI_FC_GMD_STAT                        0x1100
 #define HDMI_FC_GMD_EN                          0x1101
@@ -289,6 +290,37 @@
 #define HDMI_FC_GMD_PB26                        0x111F
 #define HDMI_FC_GMD_PB27                        0x1120
 
+#define HDMI_FC_DRM_UP                          0x1167
+#define HDMI_FC_DRM_HB0                         0x1168
+#define HDMI_FC_DRM_HB1                         0x1169
+#define HDMI_FC_DRM_PB0                         0x116A
+#define HDMI_FC_DRM_PB1                         0x116B
+#define HDMI_FC_DRM_PB2                         0x116C
+#define HDMI_FC_DRM_PB3                         0x116D
+#define HDMI_FC_DRM_PB4                         0x116E
+#define HDMI_FC_DRM_PB5                         0x116F
+#define HDMI_FC_DRM_PB6                         0x1170
+#define HDMI_FC_DRM_PB7                         0x1171
+#define HDMI_FC_DRM_PB8                         0x1172
+#define HDMI_FC_DRM_PB9                         0x1173
+#define HDMI_FC_DRM_PB10                        0x1174
+#define HDMI_FC_DRM_PB11                        0x1175
+#define HDMI_FC_DRM_PB12                        0x1176
+#define HDMI_FC_DRM_PB13                        0x1177
+#define HDMI_FC_DRM_PB14                        0x1178
+#define HDMI_FC_DRM_PB15                        0x1179
+#define HDMI_FC_DRM_PB16                        0x117A
+#define HDMI_FC_DRM_PB17                        0x117B
+#define HDMI_FC_DRM_PB18                        0x117C
+#define HDMI_FC_DRM_PB19                        0x117D
+#define HDMI_FC_DRM_PB20                        0x117E
+#define HDMI_FC_DRM_PB21                        0x117F
+#define HDMI_FC_DRM_PB22                        0x1180
+#define HDMI_FC_DRM_PB23                        0x1181
+#define HDMI_FC_DRM_PB24                        0x1182
+#define HDMI_FC_DRM_PB25                        0x1183
+#define HDMI_FC_DRM_PB26                        0x1184
+
 #define HDMI_FC_DBGFORCE                        0x1200
 #define HDMI_FC_DBGAUD0CH0                      0x1201
 #define HDMI_FC_DBGAUD1CH0                      0x1202
@@ -744,6 +776,11 @@ enum {
 	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_MASK = 0x0F,
 	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_OFFSET = 0,
 
+/* FC_PACKET_TX_EN field values */
+	HDMI_FC_PACKET_TX_EN_DRM_MASK = 0x80,
+	HDMI_FC_PACKET_TX_EN_DRM_ENABLE = 0x80,
+	HDMI_FC_PACKET_TX_EN_DRM_DISABLE = 0x00,
+
 /* FC_AVICONF0-FC_AVICONF3 field values */
 	HDMI_FC_AVICONF0_PIX_FMT_MASK = 0x03,
 	HDMI_FC_AVICONF0_PIX_FMT_RGB = 0x00,
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 4b3e863c4f8a..fbf3812c4326 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -126,6 +126,7 @@ struct dw_hdmi_plat_data {
 					   const struct drm_display_mode *mode);
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
+	bool use_drm_infoframe;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.17.1

