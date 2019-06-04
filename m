Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61FFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3975207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oe/GAvOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFDUmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:42:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35711 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFDUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:42:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so8800510plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/HYQ/vk4D8YwsOYcNtmXEt7k4Cw/SNCazVxbSK/MBw=;
        b=Oe/GAvOveh8cEnZRbjewFICZg+C+Mz/D/CnWC95t1aKO8nC/4h7shSTzLU1vBw2wNk
         Q1E2ChcF+TNLJ2tV6Ni7gtfIe57YJiqgABXAPEz6xUQT5FB5SryOZlCsF80LZflBgjCo
         x1xz8v+X7QR/1VrE0lLahDkyw4U3TwBM8X1Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/HYQ/vk4D8YwsOYcNtmXEt7k4Cw/SNCazVxbSK/MBw=;
        b=crbLh9HEJl+9Nl78ZTLpUX6vmNx8CV10nJYm/sJPXdLpAvF2NnPca/KGJfMYGkraD/
         4YHozn8rW3MUrddZw48Irsi5ur6BOFfYRI6j8boi+6rdCaePxWf75aoJgIAjiJXwkNFW
         kOh2KGhuSv7K7040R9W3UFTUgVrJjumdur4QZo60JDZwCr4NXDilqAJgUp1OM8nz0f2h
         5m2Ti0a1CUyYPHJbGy0sRpKNLKMSoY1rEEPLOrIt8A7p/Prfv+JESnb1mXiQvmZPKQ5v
         TAoDK9AYaxM6PjLj76brBWV+06xiU6HFw++msULDJpYGQ4dH42lTF8FGgKO7QTxkz7Vm
         kJfA==
X-Gm-Message-State: APjAAAVL7Ne2IIvCZu7yQQqpkTFhHQUE5vHWxP0r8eL6R8+747ss7M4+
        MtmUvgT1+ozag/YGp5rB6XwgyQ==
X-Google-Smtp-Source: APXvYqxZ3/7BjsatDoJITrpZzUz7cdM4OD6rVIjnIvwx6bqgW4w4ZY2kqNMfOkqzav5S1V+S/pPOEw==
X-Received: by 2002:a17:902:347:: with SMTP id 65mr39818136pld.232.1559680951603;
        Tue, 04 Jun 2019 13:42:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m5sm11553616pgn.59.2019.06.04.13.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:42:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 1/2] drm: bridge: dw-hdmi: Add hook for resume
Date:   Tue,  4 Jun 2019 13:42:06 -0700
Message-Id: <20190604204207.168085-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes in v3:
- Change resume to void function (Laurent)

Changes in v2:
- No empty stub for suspend (Laurent)
- Refactor to use the same code in probe and resume (Laurent)
- Unconditionally init i2c (seems OK + needed before hdmi->i2c init)
- Combine "init" of i2c and "setup" of i2c (no reason to split)

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 48 ++++++++++++++---------
 include/drm/bridge/dw_hdmi.h              |  2 +
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 66bd66bad44c..a00ccf123877 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -228,6 +228,13 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
 
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
 
@@ -1926,16 +1933,6 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
@@ -2436,6 +2433,21 @@ static const struct regmap_config hdmi_regmap_32bit_config = {
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
@@ -2587,7 +2599,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		 prod_id1 & HDMI_PRODUCT_ID1_HDCP ? "with" : "without",
 		 hdmi->phy.name);
 
-	initialize_hdmi_ih_mutes(hdmi);
+	dw_hdmi_init_hw(hdmi);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -2626,10 +2638,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.of_node = pdev->dev.of_node;
 #endif
 
-	dw_hdmi_setup_i2c(hdmi);
-	if (hdmi->phy.ops->setup_hpd)
-		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
-
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
 	pdevinfo.id = PLATFORM_DEVID_AUTO;
@@ -2682,10 +2690,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->cec = platform_device_register_full(&pdevinfo);
 	}
 
-	/* Reset HDMI DDC I2C master controller and mute I2CM interrupts */
-	if (hdmi->i2c)
-		dw_hdmi_i2c_init(hdmi);
-
 	return hdmi;
 
 err_iahb:
@@ -2789,6 +2793,12 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
 
+void dw_hdmi_resume(struct dw_hdmi *hdmi)
+{
+	dw_hdmi_init_hw(hdmi);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_resume);
+
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 66e70770cce5..601243b56b69 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -154,6 +154,8 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 			     struct drm_encoder *encoder,
 			     const struct dw_hdmi_plat_data *plat_data);
 
+void dw_hdmi_resume(struct dw_hdmi *hdmi);
+
 void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
-- 
2.22.0.rc1.311.g5d7573a151-goog

