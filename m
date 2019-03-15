Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46881C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05934218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fcid22Cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfCOJyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:54:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35905 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:54:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id e16so5447089wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMNxuBFkfxH/Pp2e0D/vuUTdP7DiCTna/TvHjdOEJW8=;
        b=Fcid22Crd69kN12+21PzsGaZiUWPHL/S7LQ+Q7zdeJQedXWw0GXjWDnDQodjY/epoY
         62EN2SZ2ZClyJ6PUCbOG3Onx2T18oolqENLp5T3DbXnxRW5G0SzBy6f1pyA1380ksDwm
         x6+imSAGVCUpATIpi68qxfiX4tYMHwou6gJgHO+eYGYvWpX6O1NhixeprfsJsB+CFMiV
         EKfsBAGjQ8FyR1KtZ6AuqbHAmU3BfA6fdvG5RppdvpCYrq6vFO/RhEDoDR57xzvo0PDS
         N3AqFxS+N7WAhCh0iMqsIogIkfbmiTT+hIf+hx436I1GwMq+Jgo+6kKhW4CbDswdHDCl
         3Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMNxuBFkfxH/Pp2e0D/vuUTdP7DiCTna/TvHjdOEJW8=;
        b=VWj2CjluOg+6QQTx1zrn+F2OLe/jPcv/zbM49iSNXPIQq0h8OYb4xVIJUe68QBetfm
         l3abzgXNE862o5coeSAfx9fKI+uWrCugtMUNqUg/U0oxOaZCYeD6cz1l08JKt9ZsoD27
         +7ko47bRgI6A/RYLGgdFy3/ehI2h49wZ4AATfkX33MKf6KIE3wJzaS6VRlUtZ/6XGT0F
         BwvzgFx4nwLAbZKJnyCpmavBGp7esjtpQDagThqQQDSLpwmzaWyVMD968BH17GoPWSdF
         /6LBjK6IgDC8BjWiUhlgQKJIcOSg6+Q+2hR5x+qrOO0NOtrlA8nnJlavtySomdGbl2bD
         YgYg==
X-Gm-Message-State: APjAAAXLvfq1lzsEQaow0m5pEFVH70S6bA19ikalEAuL83LvkPgEsIG0
        YT62OPONL8VLbBoBkGp/O2YZRg==
X-Google-Smtp-Source: APXvYqzpk9rciGy4Ra3i/qZ/fk86Vn9cwD5fHgaNEEQyBoEC3t7vAj+buGrW4QGk/PwPpTxt4tEbEA==
X-Received: by 2002:a1c:eb1a:: with SMTP id j26mr1399768wmh.43.1552643656162;
        Fri, 15 Mar 2019 02:54:16 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c202sm1683958wme.38.2019.03.15.02.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 02:54:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        heiko@sntech.de, robh@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Subject: [PATCH] drm/bridge: dw-hdmi: disable SCDC configuration for invalid setups
Date:   Fri, 15 Mar 2019 10:54:14 +0100
Message-Id: <20190315095414.28520-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an attempt to limit HDMI 2.0 SCDC setup when :
- the SoC embeds an HDMI 1.4 only controller
- the EDID supports SCDC but not scrambling
- the EDID supports SCDC scrambling but not for low TMDS bit rates,
  while only supporting low TMDS bit rates

This to avoid communicating with the SCDC DDC slave uncessary, and
setting the DW-HDMI TMDS Scrambler setup when not supported by the
underlying hardware.

Reported-by: Rob Herring <robh@kernel.org>
Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---

Rob,

this patch should also solve your issue with your 11' display, could you
test it ?
If this works, I will focus on the underlying issue where the RK3399 SoC
freezes in your setup.

Thanks,
Neil

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 34 ++++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a63e5f0dae56..db761329a1e3 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1037,6 +1037,31 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
 
+/* Filter out invalid setups to avoid configuring SCDC and scrambling */
+static bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi)
+{
+	struct drm_display_info *display = &hdmi->connector.display_info;
+
+	/* Completely disable SCDC support for older controllers */
+	if (hdmi->version < 0x200a)
+		return false;
+
+	/* Disable if SCDC is not supported, or if an HF-VSDB block is absent */
+	if (!display->hdmi.scdc.supported ||
+	    !display->hdmi.scdc.scrambling.supported)
+		return false;
+
+	/*
+	 * Disable if display only support low TMDS rates and scrambling
+	 * for low rates is not supported either
+	 */
+	if (!display->hdmi.scdc.scrambling.low_rates &&
+	    display->max_tmds_clock <= 340000)
+		return false;
+
+	return true;
+}
+
 /*
  * HDMI2.0 Specifies the following procedure for High TMDS Bit Rates:
  * - The Source shall suspend transmission of the TMDS clock and data
@@ -1055,7 +1080,7 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
 	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mtmdsclock;
 
 	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
-	if (hdmi->connector.display_info.hdmi.scdc.supported) {
+	if (dw_hdmi_support_scdc(hdmi)) {
 		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
 			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
 		else
@@ -1579,8 +1604,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	/* Set up HDMI_FC_INVIDCONF */
 	inv_val = (hdmi->hdmi_data.hdcp_enable ||
-		   vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
-		   hdmi_info->scdc.scrambling.low_rates ?
+		   (dw_hdmi_support_scdc(hdmi) &&
+		    (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
+		     hdmi_info->scdc.scrambling.low_rates)) ?
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
 
@@ -1646,7 +1672,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	}
 
 	/* Scrambling Control */
-	if (hdmi_info->scdc.supported) {
+	if (dw_hdmi_support_scdc(hdmi)) {
 		if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
 		    hdmi_info->scdc.scrambling.low_rates) {
 			/*
-- 
2.20.1

