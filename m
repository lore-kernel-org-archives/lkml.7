Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086BC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB99C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pkRCUHr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfETJIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:08:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36690 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfETJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:08:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so6498977pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xEFhsAjZ+Xzcbx2mHUcUiTH2Zxcv+pD6TtDJ+37nOCw=;
        b=pkRCUHr3PbHTjPtc0qjpfo1lrEPZql2aeKEwix+ScaX1hHjAmL8U69LjgqUEDGAHHZ
         vGACrzd6Kmoy1bkgevpRYfNdHQnemycdG4G1VtfGtCdNjhb2as9Ypzh0BOVLPtzBINyi
         lyIN9ZuCYdiVQB/9yqx/RnaZks4NbxiNnbEPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEFhsAjZ+Xzcbx2mHUcUiTH2Zxcv+pD6TtDJ+37nOCw=;
        b=V+BRDgn3YTBfUM94UhFryEClyeiqwvLCnBXeKWnsTg8mLjT0ireKT6tHlrkQ7yDTd8
         cTMAywCrmpWzAWDpprXB0gDW8uBqB8oBO2ZPUYwSZ0j10Yo2KC1ZtYoTPa1+06kW1gw7
         pT8dwmFdMWEYzD2viIslK+B5UuTu+/7XKbuXK8X+Nrbmxr/JmRgB/+A9CSlWolFMg2AF
         MeO25xFXCV3w/nnIOghqHkg3KEvYrUp7UaeJh6eDXUYlMllg12eLImex87t6YO6kFjpJ
         zs142IuuymKXY5Skwj7d9yXJ5/IPZZl8vte53ImdhFwDbQfNxb9u5KHhnmGh3XZfqvfg
         pR4w==
X-Gm-Message-State: APjAAAVFG5gaqeyz6Gy/x8Jkj6bR6eOuhjiy5ZiPbSwhU0qz4A0+ZXeO
        299gkFKImS2t3EJYOEQdQYlA9Q==
X-Google-Smtp-Source: APXvYqwqd4qJH6N7Gr6VNXBwWrTXaJZVOL3zSzQQK/VIAilUj4DHIF2KXdm0VmOuIoTm6pT2UMghGQ==
X-Received: by 2002:a63:3ece:: with SMTP id l197mr36282516pga.268.1558343279532;
        Mon, 20 May 2019 02:07:59 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:59 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 09/11] drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator support
Date:   Mon, 20 May 2019 14:33:16 +0530
Message-Id: <20190520090318.27570-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
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
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 5584e9c2f8bd..a5d73a283ed7 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1150,6 +1150,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
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
@@ -1223,6 +1229,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
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
@@ -1255,6 +1268,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
+	regulator_disable(dsi->regulator);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 156523859d82..c76b71259d2e 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -13,6 +13,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 
+#include <linux/regulator/consumer.h>
+
 struct sun6i_dsi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -21,6 +23,7 @@ struct sun6i_dsi {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
 	struct regmap		*regs;
+	struct regulator	*regulator;
 	struct reset_control	*reset;
 	struct phy		*dphy;
 
-- 
2.18.0.321.gffc6fa0e3

