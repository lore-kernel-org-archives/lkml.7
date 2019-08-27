Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA222C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D5217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ugl/8zro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfH0J6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:58:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfH0J6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:58:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so18120164wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3MX6dJTEQsQ89HsRB1zdZlcheUaoM7pF8lBBmIX570=;
        b=Ugl/8zrolmxov83L5GM9xV8mmhNk/xvoT9Qx80voxCM0e8fyHjKUfK9EPT9dzOC14H
         hDRkEM8GqCtOPBom0oTAthFAT/kEh2l/myItSPKeMeNTkl/qfNLQ/lIvkyxw4YvUBcom
         LaMQoNUJEJ+bdvvurb05C58eDEp2KNhjg9m46jQoNSAYu+zFKVgBhKQHPKp1+fSHpp9P
         7obFgm0tdMoEyEKKO10dgDvTaWnz2rUrvbU0EDVHVaNwJoLLfSHFCwM/dvDk113dUAP7
         Q5czgoZ3XfZXqGwFrWn/2hJjvjMMeYoj7TgAu5ru27WSD46DDJpRCHBZ2Pbsd2BIlHhK
         nJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3MX6dJTEQsQ89HsRB1zdZlcheUaoM7pF8lBBmIX570=;
        b=WrZIs8DwXQs5n1As0BPXWwpxbTl9aqVGR2l+s6mqtbq+ZLvnEumvKHmId7svzoLiem
         n6bniNAe5nEpSpOwlNdVX95JSKysJKPKPPF9eaTLly5Elg7GsuRjCbVS0vCFDq85hvm8
         /bmTm4xVhsFhHtf1FxeD/DEbXF8luJxWL6pLIQizO8J50xA6sy2HwdsEnQeN+/e04nWK
         W1j+PbQUoXJ0B205siYboMXR/iJpLAuiuA26JgkwQcmInVeuqf6TQ8NmGKcdNtN8oumy
         asWMIFznvtCbXEYywTCHG8oQAf6u/hs/a4E88lv1120wEPWKcahdakNwY8GWN6C2ATQq
         rSZA==
X-Gm-Message-State: APjAAAUT+IGj3gwBaioHsE23XSgpW8vW/r+x9Bn167mvRyDaX7M/sMQN
        cxGRBA+O/uQMezW9auVav5yPmA==
X-Google-Smtp-Source: APXvYqy4ZYB2/q/DqDVQb0WL+EPpli8OSFxCaqbkjlDMpmc/cnWWUqiSdxK0DJT+0XlCte2VBKjc4Q==
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr28230101wrw.7.1566899908606;
        Tue, 27 Aug 2019 02:58:28 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m6sm10862084wrq.95.2019.08.27.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:58:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] drm/meson: dw_hdmi: add resume/suspend hooks
Date:   Tue, 27 Aug 2019 11:58:24 +0200
Message-Id: <20190827095825.21015-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827095825.21015-1-narmstrong@baylibre.com>
References: <20190827095825.21015-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the suspens and resume hooks to:
- reset the whole HDMI glue and HDMI controller on suspend
- re-init the HDMI glue and HDMI controller on resume

The HDMI glue init is refactored to be re-used from the resume hook.

It makes usage of dw_hdmi_resume() to recover a functionnal DDC bus.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 110 ++++++++++++++++++--------
 1 file changed, 76 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index df3f9ddd2234..a722ddbfbede 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -799,6 +799,47 @@ static bool meson_hdmi_connector_is_available(struct device *dev)
 	return false;
 }
 
+static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
+{
+	struct meson_drm *priv = meson_dw_hdmi->priv;
+
+	/* Enable clocks */
+	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
+
+	/* Bring HDMITX MEM output of power down */
+	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
+
+	/* Reset HDMITX APB & TX & PHY */
+	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
+	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
+	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
+
+	/* Enable APB3 fail on error */
+	if (!meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		writel_bits_relaxed(BIT(15), BIT(15),
+				    meson_dw_hdmi->hdmitx + HDMITX_TOP_CTRL_REG);
+		writel_bits_relaxed(BIT(15), BIT(15),
+				    meson_dw_hdmi->hdmitx + HDMITX_DWC_CTRL_REG);
+	}
+
+	/* Bring out of reset */
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
+				       HDMITX_TOP_SW_RESET,  0);
+
+	msleep(20);
+
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
+				       HDMITX_TOP_CLK_CNTL, 0xff);
+
+	/* Enable HDMI-TX Interrupt */
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
+				       HDMITX_TOP_INTR_CORE);
+
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_MASKN,
+				       HDMITX_TOP_INTR_CORE);
+
+}
+
 static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 				void *data)
 {
@@ -922,40 +963,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	DRM_DEBUG_DRIVER("encoder initialized\n");
 
-	/* Enable clocks */
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
-
-	/* Bring HDMITX MEM output of power down */
-	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
-
-	/* Reset HDMITX APB & TX & PHY */
-	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
-	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
-	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
-
-	/* Enable APB3 fail on error */
-	if (!meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
-		writel_bits_relaxed(BIT(15), BIT(15),
-				    meson_dw_hdmi->hdmitx + HDMITX_TOP_CTRL_REG);
-		writel_bits_relaxed(BIT(15), BIT(15),
-				    meson_dw_hdmi->hdmitx + HDMITX_DWC_CTRL_REG);
-	}
-
-	/* Bring out of reset */
-	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
-				       HDMITX_TOP_SW_RESET,  0);
-
-	msleep(20);
-
-	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
-				       HDMITX_TOP_CLK_CNTL, 0xff);
-
-	/* Enable HDMI-TX Interrupt */
-	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
-				       HDMITX_TOP_INTR_CORE);
-
-	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_MASKN,
-				       HDMITX_TOP_INTR_CORE);
+	meson_dw_hdmi_init(meson_dw_hdmi);
 
 	/* Bridge / Connector */
 
@@ -991,6 +999,34 @@ static const struct component_ops meson_dw_hdmi_ops = {
 	.unbind	= meson_dw_hdmi_unbind,
 };
 
+static int __maybe_unused meson_dw_hdmi_pm_suspend(struct device *dev)
+{
+	struct meson_dw_hdmi *meson_dw_hdmi = dev_get_drvdata(dev);
+
+	if (!meson_dw_hdmi)
+		return 0;
+
+	/* Reset TOP */
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
+				       HDMITX_TOP_SW_RESET, 0);
+
+	return 0;
+}
+
+static int __maybe_unused meson_dw_hdmi_pm_resume(struct device *dev)
+{
+	struct meson_dw_hdmi *meson_dw_hdmi = dev_get_drvdata(dev);
+
+	if (!meson_dw_hdmi)
+		return 0;
+
+	meson_dw_hdmi_init(meson_dw_hdmi);
+
+	dw_hdmi_resume(meson_dw_hdmi->hdmi);
+
+	return 0;
+}
+
 static int meson_dw_hdmi_probe(struct platform_device *pdev)
 {
 	return component_add(&pdev->dev, &meson_dw_hdmi_ops);
@@ -1003,6 +1039,11 @@ static int meson_dw_hdmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops meson_dw_hdmi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(meson_dw_hdmi_pm_suspend,
+				meson_dw_hdmi_pm_resume)
+};
+
 static const struct of_device_id meson_dw_hdmi_of_table[] = {
 	{ .compatible = "amlogic,meson-gxbb-dw-hdmi",
 	  .data = &meson_dw_hdmi_gx_data },
@@ -1022,6 +1063,7 @@ static struct platform_driver meson_dw_hdmi_platform_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table	= meson_dw_hdmi_of_table,
+		.pm = &meson_dw_hdmi_pm_ops,
 	},
 };
 module_platform_driver(meson_dw_hdmi_platform_driver);
-- 
2.22.0

