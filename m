Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D181CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CE1222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KQ2LkOEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfJCGqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:46:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38365 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfJCGqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:46:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so1135530pgi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w28l9Bay7xNtt5EXEnd1uzJ8iDtWAmssV5M28OxUAUw=;
        b=KQ2LkOEKTiO6GSVyAcVCwmI6tIIYuy7DboEUKeXPS7BzMWxfmXMGK4XlY2+G43azj7
         lbWDLABCj1KDR3VPgHd0Ok/LMU8p7VvOv86DtsxVtqDxwFP7arJNy173b+On2ikOKiuc
         bLXmZaGH5ckchLB7pXN2xEm6b/fYaac9AJj/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w28l9Bay7xNtt5EXEnd1uzJ8iDtWAmssV5M28OxUAUw=;
        b=ipb6jyiPuDR3IouWZwu9FHd1X5+LBnCRMht5E4aXxxXOKkDSW3XpDo2rFj3FZvq6br
         mg0FWaA+pOuqbGOMfkg128z0AHxgcKXNX39tuV4m2+k1T7a+uD/ZlgmQBwph+B8VdH9n
         vwyVZf/gmdP1fO9EHmL84SUKfzSbDb81jL2f7Fb8ARzQUCs/av1I9pctkx60mqC6CTS1
         m5TGo4CTLsaSPMpAFLGdEEKaf3bQzTEumTfq/ObP8ZMnRej3ZVoYmuLARnpEdhzsidQM
         TyIFiZYnjfZRXef2jOD3PYAJ2PanLumfYsr27Ao8NsdT0oquwIIfTLDSNW+OiDHlLM8z
         t40g==
X-Gm-Message-State: APjAAAVU8LRitq+s/mGNRLKfsubZb7tG/IllWNh/3a9XvQ5xdYW6kRZ7
        3d4Ggb6P0DCmCr3qSHMHrRPOcA==
X-Google-Smtp-Source: APXvYqw9CN7jIsE+MsR2uxNhq5HhPqVzRo1QO/rv7lizgNxxfZvpTowoqU4TBvLm2ucXujxNgqGZOA==
X-Received: by 2002:a17:90a:da05:: with SMTP id e5mr8479030pjv.141.1570085180342;
        Wed, 02 Oct 2019 23:46:20 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.121])
        by smtp.gmail.com with ESMTPSA id b18sm1423294pfi.157.2019.10.02.23.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 23:46:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 5/7] drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator support
Date:   Thu,  3 Oct 2019 12:15:25 +0530
Message-Id: <20191003064527.15128-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191003064527.15128-1-jagan@amarulasolutions.com>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner MIPI DSI controllers are supplied with SoC
DSI power rails via VCC-DSI pin.

Add support for this supply pin by adding voltage
regulator handling code to MIPI DSI driver.

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 446dc56cc44b..fe9a3667f3a1 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1110,6 +1110,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
+	dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
+	if (IS_ERR(dsi->regulator)) {
+		dev_err(dev, "Couldn't get VCC-DSI supply\n");
+		return PTR_ERR(dsi->regulator);
+	}
+
 	dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
 					      &sun6i_dsi_regmap_config);
 	if (IS_ERR(dsi->regs)) {
@@ -1183,6 +1189,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	int err;
+
+	err = regulator_enable(dsi->regulator);
+	if (err) {
+		dev_err(dsi->dev, "failed to enable VCC-DSI supply: %d\n", err);
+		return err;
+	}
 
 	reset_control_deassert(dsi->reset);
 	clk_prepare_enable(dsi->mod_clk);
@@ -1215,6 +1228,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
+	regulator_disable(dsi->regulator);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 5c3ad5be0690..a01d44e9e461 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -12,6 +12,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
+#include <linux/regulator/consumer.h>
 
 #define SUN6I_DSI_TCON_DIV	4
 
@@ -23,6 +24,7 @@ struct sun6i_dsi {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
 	struct regmap		*regs;
+	struct regulator	*regulator;
 	struct reset_control	*reset;
 	struct phy		*dphy;
 
-- 
2.18.0.321.gffc6fa0e3

