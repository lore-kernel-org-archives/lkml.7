Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B79C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2442087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/tfpJ46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfEPOAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:00:42 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43228 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfEPOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:00:41 -0400
Received: by mail-vs1-f74.google.com with SMTP id z126so698371vsb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rlRVknlZU7qYpUcxId0/VutlDA2ELBhIWtuAFSYl26U=;
        b=W/tfpJ46pm6QwaEsnL+ks8gRef5r8nf2B7dUTibUg/joOKC1EXfGHPltFpIwbVPU9v
         TBi+fnSwOkLvw7FzES/V0KLSXqhV+MC58kUWaVGqWAtcz0p5qDde0U+iA9vX84D+2sjp
         OWFgPDghIPEHlYjiZrU58wH21GXVNplgPUMeZT1N9gV0WjtY8I1sqCEzlxKNWv/BeBUc
         C8EhUu7EN1/JirLH4YBUHjQ/9US8Gx/KphuXRUUbx24XcF6uPyvLsslL1+CrYu9e0b4y
         VmcgF1DroAo1yJD+zY+C634qxRbld2c6PNMYlHs/wZ4Oz0LHwtL2X8/DLImc2Vine3xZ
         nwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rlRVknlZU7qYpUcxId0/VutlDA2ELBhIWtuAFSYl26U=;
        b=PQMShINtxojV/+mzigooxAYT0z3vkpyOwjvSvqr3iAlIbsftlREbJ+GP1eCqpE8JTr
         uX2GXF7DiuhNocfgh2J4C1JsPfMg+sfQVwD6TQfkncSlaadd48bZ+xX/QonzSR65i8o/
         UsFkZaA6cjywih3OAoXd3HPIg5rj68lyrJ1wTUlF06IwqA/8RyrNgd7PmbVTgTilmzJb
         1xnWYEg/ySKZCK7Ji7sc9r16Iw+zjBXzRtUKf+8RM8gp8FN/FdkjF15jnrDzsN1/RAld
         Yt7iyKME8UDs1JdP4PSIvN3RQtEvaaLQ8d1lj78QH2LxudkeDQjWooe97CKGuG+BAfqk
         3p+A==
X-Gm-Message-State: APjAAAVXXr6QW5XzCrf8xH4evPwIYkUVeUrYS/zZMZk9Kh4ZCHqZdMHJ
        DHhkloljwphwBL/TMKWzmrdd6TdQ9Ik=
X-Google-Smtp-Source: APXvYqwBfop0sVMYzVgicTJbUQL+4IOtu+mUxtXvxjLYIa8tDZ5zzlW2t2aIKr249ZniIeEVl/xOiRgLgck=
X-Received: by 2002:a67:8042:: with SMTP id b63mr23047683vsd.202.1558015240438;
 Thu, 16 May 2019 07:00:40 -0700 (PDT)
Date:   Thu, 16 May 2019 16:00:19 +0200
In-Reply-To: <20190516140020.200105-1-darekm@google.com>
Message-Id: <20190516140020.200105-2-darekm@google.com>
Mime-Version: 1.0
References: <20190516140020.200105-1-darekm@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v5 2/3] drm/bridge: dw-hdmi: pass connector info to the CEC adapter
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org, hans.verkuil@cisco.com,
        hverkuil@xs4all.nl
Cc:     linux-kernel@vger.kernel.org,
        Dariusz Marcinkiewicz <darekm@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes dw-hdmi pass DRM connector info to a respective
CEC adapter. In order to be able to do that it delays creation of
the dw-hdmi-cec platform device until DRM connector is initialized.

Requires testing.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c |  5 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h |  2 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 82 +++++++++++--------
 3 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
index 84fb7b6a0a5e0..cf879629e0726 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
@@ -232,6 +232,7 @@ static void dw_hdmi_cec_del(void *data)
 static int dw_hdmi_cec_probe(struct platform_device *pdev)
 {
 	struct dw_hdmi_cec_data *data = dev_get_platdata(&pdev->dev);
+	struct cec_connector_info conn_info;
 	struct dw_hdmi_cec *cec;
 	int ret;
 
@@ -258,10 +259,12 @@ static int dw_hdmi_cec_probe(struct platform_device *pdev)
 	dw_hdmi_write(cec, ~0, HDMI_IH_MUTE_CEC_STAT0);
 	dw_hdmi_write(cec, 0, HDMI_CEC_POLARITY);
 
+	cec_fill_connector_info(&conn_info, data->connector);
+
 	cec->adap = cec_allocate_adapter(&dw_hdmi_cec_ops, cec, "dw_hdmi",
 					 CEC_CAP_LOG_ADDRS | CEC_CAP_TRANSMIT |
 					 CEC_CAP_RC | CEC_CAP_PASSTHROUGH,
-					 CEC_MAX_LOG_ADDRS, NULL);
+					 CEC_MAX_LOG_ADDRS, &conn_info);
 	if (IS_ERR(cec->adap))
 		return PTR_ERR(cec->adap);
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h
index cf4dc121a2c43..a2ac91ec845ed 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h
@@ -1,6 +1,7 @@
 #ifndef DW_HDMI_CEC_H
 #define DW_HDMI_CEC_H
 
+struct drm_connector;
 struct dw_hdmi;
 
 struct dw_hdmi_cec_ops {
@@ -13,6 +14,7 @@ struct dw_hdmi_cec_ops {
 struct dw_hdmi_cec_data {
 	struct dw_hdmi *hdmi;
 	const struct dw_hdmi_cec_ops *ops;
+	const struct drm_connector *connector;
 	int irq;
 };
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index db761329a1e3e..6aaf0a7db9818 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -138,6 +138,8 @@ struct dw_hdmi {
 	struct drm_connector connector;
 	struct drm_bridge bridge;
 
+	int irq;
+
 	unsigned int version;
 
 	struct platform_device *audio;
@@ -189,6 +191,7 @@ struct dw_hdmi {
 	void (*enable_audio)(struct dw_hdmi *hdmi);
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
+	bool cec_configured;
 	struct cec_notifier *cec_notifier;
 };
 
@@ -2105,6 +2108,29 @@ static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs =
 	.get_modes = dw_hdmi_connector_get_modes,
 };
 
+static void dw_hdmi_cec_enable(struct dw_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->mutex);
+	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CECCLK_DISABLE;
+	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
+	mutex_unlock(&hdmi->mutex);
+}
+
+static void dw_hdmi_cec_disable(struct dw_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->mutex);
+	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_CECCLK_DISABLE;
+	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
+	mutex_unlock(&hdmi->mutex);
+}
+
+static const struct dw_hdmi_cec_ops dw_hdmi_cec_ops = {
+	.write = hdmi_writeb,
+	.read = hdmi_readb,
+	.enable = dw_hdmi_cec_enable,
+	.disable = dw_hdmi_cec_disable,
+};
+
 static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 {
 	struct dw_hdmi *hdmi = bridge->driver_private;
@@ -2121,6 +2147,23 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 
 	drm_connector_attach_encoder(connector, encoder);
 
+	if (hdmi->cec_configured) {
+		struct platform_device_info pdevinfo;
+		struct dw_hdmi_cec_data cec;
+
+		cec.hdmi = hdmi;
+		cec.ops = &dw_hdmi_cec_ops;
+		cec.irq = hdmi->irq;
+		cec.connector = connector;
+
+		pdevinfo.name = "dw-hdmi-cec";
+		pdevinfo.data = &cec;
+		pdevinfo.size_data = sizeof(cec);
+		pdevinfo.dma_mask = 0;
+
+		hdmi->cec = platform_device_register_full(&pdevinfo);
+	}
+
 	return 0;
 }
 
@@ -2390,29 +2433,6 @@ static int dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
 	return -ENODEV;
 }
 
-static void dw_hdmi_cec_enable(struct dw_hdmi *hdmi)
-{
-	mutex_lock(&hdmi->mutex);
-	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CECCLK_DISABLE;
-	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
-	mutex_unlock(&hdmi->mutex);
-}
-
-static void dw_hdmi_cec_disable(struct dw_hdmi *hdmi)
-{
-	mutex_lock(&hdmi->mutex);
-	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_CECCLK_DISABLE;
-	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
-	mutex_unlock(&hdmi->mutex);
-}
-
-static const struct dw_hdmi_cec_ops dw_hdmi_cec_ops = {
-	.write = hdmi_writeb,
-	.read = hdmi_readb,
-	.enable = dw_hdmi_cec_enable,
-	.disable = dw_hdmi_cec_disable,
-};
-
 static const struct regmap_config hdmi_regmap_8bit_config = {
 	.reg_bits	= 32,
 	.val_bits	= 8,
@@ -2435,7 +2455,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	struct device_node *np = dev->of_node;
 	struct platform_device_info pdevinfo;
 	struct device_node *ddc_node;
-	struct dw_hdmi_cec_data cec;
 	struct dw_hdmi *hdmi;
 	struct resource *iores = NULL;
 	int irq;
@@ -2585,6 +2604,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		ret = irq;
 		goto err_iahb;
 	}
+	hdmi->irq = irq;
 
 	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
 					dw_hdmi_irq, IRQF_SHARED,
@@ -2660,18 +2680,8 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->audio = platform_device_register_full(&pdevinfo);
 	}
 
-	if (config0 & HDMI_CONFIG0_CEC) {
-		cec.hdmi = hdmi;
-		cec.ops = &dw_hdmi_cec_ops;
-		cec.irq = irq;
-
-		pdevinfo.name = "dw-hdmi-cec";
-		pdevinfo.data = &cec;
-		pdevinfo.size_data = sizeof(cec);
-		pdevinfo.dma_mask = 0;
-
-		hdmi->cec = platform_device_register_full(&pdevinfo);
-	}
+	if (config0 & HDMI_CONFIG0_CEC)
+		hdmi->cec_configured = true;
 
 	/* Reset HDMI DDC I2C master controller and mute I2CM interrupts */
 	if (hdmi->i2c)
-- 
2.18.1

