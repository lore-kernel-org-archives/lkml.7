Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F36C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E837E2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JzKx+RF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfEPVku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:40:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44245 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEPVkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:40:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so2177935pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukge0ptaqtQfzBE3gk2H8jEArL17PgyGsxqUKXtZMbQ=;
        b=JzKx+RF4TLBsEzBvWlJuApn0knquV7p4R881+CU/VNU+JGrSzZmo4yrONglkpOvAzb
         gFKMQzVEIn3490zilMNi3bc38jveC54jAPM+0tQpFwfuIXjhPX0C35zllfCsiU4t6RZy
         LQxCLZG/xoArLy1BwI631/GGRSoB4DjJLfhcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukge0ptaqtQfzBE3gk2H8jEArL17PgyGsxqUKXtZMbQ=;
        b=h77ErgmtU/UC/A3IjZY6poKtvJFagSL9VkZsdL+7mbnomuCmR2SgyfenmX9jmThdZm
         aOzPq47X8MuTCgNV2wjFShriR+HbmP2y2abnnTTuYz7B0FwVycDaBVqotY3SxUJA1Rj4
         a9aYlbNg8sXzGWha/4bh312o52OU3V5TLNsExIEAJ1VtFiAqUetMDis8v0HD5b9jQkxZ
         ur0gM8P3y9D8VS/EpBSCGtxQOWktnIdEAoK9rm8i3n67mFT14W8sj3He1z7aWdbOyVaG
         kxBj+pwx/h4oiFrXatafr/rLTYKY3NsD8ZbXo+If6RWUoSNSQhbbQfqIto4V4N7j0zzW
         dO3Q==
X-Gm-Message-State: APjAAAVnWVwZfYhUiW5d9nQOqZylgkbaCqVOsCm9xmbg9+lSixMt6yHW
        JsXpAQnnSyL8IN6a7QyKkmCtlA==
X-Google-Smtp-Source: APXvYqwOR1Vaun2FkXTwvszdYiYWTQfSZ7dyxK8u7skFfDe5/KjtBFl9QmluFeY4GYG/t/JXRiUNlw==
X-Received: by 2002:a63:5c1b:: with SMTP id q27mr53715942pgb.127.1558042848815;
        Thu, 16 May 2019 14:40:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v4sm13127252pff.45.2019.05.16.14.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:40:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 1/2] drm: bridge: dw-hdmi: Add hook for resume
Date:   Thu, 16 May 2019 14:40:21 -0700
Message-Id: <20190516214022.65220-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Rockchip rk3288-based Chromebooks when you do a suspend/resume
cycle:

1. You lose the ability to detect an HDMI device being plugged in.

2. If you're using the i2c bus built in to dw_hdmi then it stops
working.

Let's add a hook to the core dw-hdmi driver so that we can call it in
dw_hdmi-rockchip in the next commit.

NOTE: the exact set of steps I've done here in resume come from
looking at the normal dw_hdmi init sequence in upstream Linux plus the
sequence that we did in downstream Chrome OS 3.14.  Testing show that
it seems to work, but if an extra step is needed or something here is
not needed we could improve it.

As part of this change we'll refactor the hardware init bits of
dw-hdmi to happen all in one function and all at the same time.  Since
we need to init the interrupt mutes before we request the IRQ, this
means moving the hardware init earlier in the function, but there
should be no problems with that.  Also as part of this we now
unconditionally init the "i2c" parts of dw-hdmi, but again that ought
to be fine.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- No empty stub for suspend (Laurent)
- Refactor to use the same code in probe and resume (Laurent)
- Unconditionally init i2c (seems OK + needed before hdmi->i2c init)
- Combine "init" of i2c and "setup" of i2c (no reason to split)

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 50 ++++++++++++++---------
 include/drm/bridge/dw_hdmi.h              |  2 +
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ab7968c8f6a2..636d55d1398c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -227,6 +227,13 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 
 static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
 {
+	hdmi_writeb(hdmi, HDMI_PHY_I2CM_INT_ADDR_DONE_POL,
+		    HDMI_PHY_I2CM_INT_ADDR);
+
+	hdmi_writeb(hdmi, HDMI_PHY_I2CM_CTLINT_ADDR_NAC_POL |
+		    HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_POL,
+		    HDMI_PHY_I2CM_CTLINT_ADDR);
+
 	/* Software reset */
 	hdmi_writeb(hdmi, 0x00, HDMI_I2CM_SOFTRSTZ);
 
@@ -1925,16 +1932,6 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	return 0;
 }
 
-static void dw_hdmi_setup_i2c(struct dw_hdmi *hdmi)
-{
-	hdmi_writeb(hdmi, HDMI_PHY_I2CM_INT_ADDR_DONE_POL,
-		    HDMI_PHY_I2CM_INT_ADDR);
-
-	hdmi_writeb(hdmi, HDMI_PHY_I2CM_CTLINT_ADDR_NAC_POL |
-		    HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_POL,
-		    HDMI_PHY_I2CM_CTLINT_ADDR);
-}
-
 static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
 {
 	u8 ih_mute;
@@ -2435,6 +2432,21 @@ static const struct regmap_config hdmi_regmap_32bit_config = {
 	.max_register	= HDMI_I2CM_FS_SCL_LCNT_0_ADDR << 2,
 };
 
+static void dw_hdmi_init_hw(struct dw_hdmi *hdmi)
+{
+	initialize_hdmi_ih_mutes(hdmi);
+
+	/*
+	 * Reset HDMI DDC I2C master controller and mute I2CM interrupts.
+	 * Even if we are using a separate i2c adapter doing this doesn't
+	 * hurt.
+	 */
+	dw_hdmi_i2c_init(hdmi);
+
+	if (hdmi->phy.ops->setup_hpd)
+		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
+}
+
 static struct dw_hdmi *
 __dw_hdmi_probe(struct platform_device *pdev,
 		const struct dw_hdmi_plat_data *plat_data)
@@ -2586,7 +2598,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		 prod_id1 & HDMI_PRODUCT_ID1_HDCP ? "with" : "without",
 		 hdmi->phy.name);
 
-	initialize_hdmi_ih_mutes(hdmi);
+	dw_hdmi_init_hw(hdmi);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -2625,10 +2637,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.of_node = pdev->dev.of_node;
 #endif
 
-	dw_hdmi_setup_i2c(hdmi);
-	if (hdmi->phy.ops->setup_hpd)
-		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
-
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
 	pdevinfo.id = PLATFORM_DEVID_AUTO;
@@ -2681,10 +2689,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->cec = platform_device_register_full(&pdevinfo);
 	}
 
-	/* Reset HDMI DDC I2C master controller and mute I2CM interrupts */
-	if (hdmi->i2c)
-		dw_hdmi_i2c_init(hdmi);
-
 	return hdmi;
 
 err_iahb:
@@ -2788,6 +2792,14 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
 
+int dw_hdmi_resume(struct dw_hdmi *hdmi)
+{
+	dw_hdmi_init_hw(hdmi);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_resume);
+
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 66e70770cce5..1626731e1681 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -154,6 +154,8 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 			     struct drm_encoder *encoder,
 			     const struct dw_hdmi_plat_data *plat_data);
 
+int dw_hdmi_resume(struct dw_hdmi *hdmi);
+
 void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
-- 
2.21.0.1020.gf2820cf01a-goog

