Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743A221904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc7VTEgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCVD3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33911 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfCVD3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so516914pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4FUv02SQ3zv65QS8OzonTlunRayPuSXzQTWW2/7lqo=;
        b=Fc7VTEgGuGMbbrH1hsMsMvtZXW3bd6bY2JNvHm+Pl7ZMQvB7hZ5eDkk9C2xdDnkltr
         Nqm4IxcNZX/Hjh+EmUeXAt41VJPzRTRJlUg0efieyfVXUdbPaeDa3FpIZU70u8sUegYQ
         mhVKq7A+SkF5DpQk+v+Wfbr+2a0/mLVCv5YTFWv+VVHa5n+83mLtH7aUsGdEzTImy/wi
         VSNsgBiwIJXW/k1+l1Jn04RsQFAOb/+ehDJYlIcUlKdJOWeabDYrW13efSWX4gyG0FO5
         vInoHebZyTy5pVAakGWZPRtQjkLscO7LBJ9J99BOiaAd2rjOuLC1KjzePVJPrsF41qLt
         gCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4FUv02SQ3zv65QS8OzonTlunRayPuSXzQTWW2/7lqo=;
        b=mKs7GJ+ITM3bxamvcZ3RGnEFKfX2QEmcP1REW7Av4QbkLng7czGa1zpy3YfY/o/ftC
         6ZKZ5vhnl5oOnXIcUZ5f/7ecqRi54F3N0Rnx1Q4n9LVUpEe+mHf/P0BuSe5Hp/MsMwP9
         SCqX5aCvO/oxLS+4rbNcH/mjB5QOzykDv4DtqSXBAhz8otNzR0oAkDiJsNjhVaLFUs6+
         vZpJzjpN7SS6WEh5kxTd3ehOqWgOyd/PWBEeDY64LFq3r3eS1XMMhDPrZ0TqNaDu/UI5
         WF3IFE9s4aaeRnx9EMmCwO0GNUpRchevuSHoJemS3Q2yOA9LoCyHCM4tQaQJquZi28nv
         B3cw==
X-Gm-Message-State: APjAAAV82jZ58rPZoO/0kSWXwOOIQLLQ6DC/WctD0J2VXYpqmwY8auql
        Ee4zUyeC7uW4xw4T3f+KgFw=
X-Google-Smtp-Source: APXvYqyzQpcq/u7y+xqcbcqbuXHdPlyeJDv3IvMEaP4G2FxJOECschsM/hOYi5YYHklhH1BGEBkvlA==
X-Received: by 2002:a63:ef05:: with SMTP id u5mr6732728pgh.177.1553225361371;
        Thu, 21 Mar 2019 20:29:21 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:20 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] drm/bridge: tc358767: Drop custom tc_write()/tc_read() accessors
Date:   Thu, 21 Mar 2019 20:28:51 -0700
Message-Id: <20190322032901.12045-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A very unfortunate aspect of tc_write()/tc_read() macro helpers is
that they capture quite a bit of context around them and thus require
the caller to have magic variables 'ret' and 'tc' as well as label
'err'. That makes a number of code paths rather counterintuitive and
somewhat clunky, for example tc_stream_clock_calc() ends up being like
this:

	int ret;

	tc_write(DP0_VIDMNGEN1, 32768);

	return 0;
err:
	return ret;

which is rather surprising when you read the code for the first
time. Since those helpers arguably aren't really saving that much code
and there's no way of fixing them without making them too verbose to
be worth it change the driver code to not use them at all.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 249 +++++++++++++++++-------------
 1 file changed, 144 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index d99c9f32a133..060e4b05095a 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -266,20 +266,6 @@ static inline struct tc_data *connector_to_tc(struct drm_connector *c)
 	return container_of(c, struct tc_data, connector);
 }
 
-/* Simple macros to avoid repeated error checks */
-#define tc_write(reg, var)					\
-	do {							\
-		ret = regmap_write(tc->regmap, reg, var);	\
-		if (ret)					\
-			goto err;				\
-	} while (0)
-#define tc_read(reg, var)					\
-	do {							\
-		ret = regmap_read(tc->regmap, reg, var);	\
-		if (ret)					\
-			goto err;				\
-	} while (0)
-
 static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
 				  unsigned int cond_mask,
 				  unsigned int cond_value,
@@ -337,7 +323,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 
 	ret = tc_aux_wait_busy(tc, 100);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (request == DP_AUX_I2C_WRITE || request == DP_AUX_NATIVE_WRITE) {
 		/* Store data */
@@ -348,7 +334,11 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 				tmp = (tmp << 8) | buf[i];
 			i++;
 			if (((i % 4) == 0) || (i == size)) {
-				tc_write(DP0_AUXWDATA((i - 1) >> 2), tmp);
+				ret = regmap_write(tc->regmap,
+						   DP0_AUXWDATA((i - 1) >> 2),
+						   tmp);
+				if (ret)
+					return ret;
 				tmp = 0;
 			}
 		}
@@ -358,23 +348,32 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	}
 
 	/* Store address */
-	tc_write(DP0_AUXADDR, msg->address);
+	ret = regmap_write(tc->regmap, DP0_AUXADDR, msg->address);
+	if (ret)
+		return ret;
 	/* Start transfer */
-	tc_write(DP0_AUXCFG0, ((size - 1) << 8) | request);
+	ret = regmap_write(tc->regmap, DP0_AUXCFG0,
+			   ((size - 1) << 8) | request);
+	if (ret)
+		return ret;
 
 	ret = tc_aux_wait_busy(tc, 100);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = tc_aux_get_status(tc, &msg->reply);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (request == DP_AUX_I2C_READ || request == DP_AUX_NATIVE_READ) {
 		/* Read data */
 		while (i < size) {
-			if ((i % 4) == 0)
-				tc_read(DP0_AUXRDATA(i >> 2), &tmp);
+			if ((i % 4) == 0) {
+				ret = regmap_read(tc->regmap,
+						  DP0_AUXRDATA(i >> 2), &tmp);
+				if (ret)
+					return ret;
+			}
 			buf[i] = tmp & 0xff;
 			tmp = tmp >> 8;
 			i++;
@@ -382,8 +381,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	}
 
 	return size;
-err:
-	return ret;
 }
 
 static const char * const training_pattern1_errors[] = {
@@ -440,6 +437,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
 	int ext_div[] = {1, 2, 3, 5, 7};
 	int best_pixelclock = 0;
 	int vco_hi = 0;
+	u32 pxl_pllparam;
 
 	dev_dbg(tc->dev, "PLL: requested %d pixelclock, ref %d\n", pixelclock,
 		refclk);
@@ -509,24 +507,29 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
 		best_mul = 0;
 
 	/* Power up PLL and switch to bypass */
-	tc_write(PXL_PLLCTRL, PLLBYP | PLLEN);
+	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLBYP | PLLEN);
+	if (ret)
+		return ret;
 
-	tc_write(PXL_PLLPARAM,
-		 (vco_hi << 24) |		/* For PLL VCO >= 300 MHz = 1 */
-		 (ext_div[best_pre] << 20) |	/* External Pre-divider */
-		 (ext_div[best_post] << 16) |	/* External Post-divider */
-		 IN_SEL_REFCLK |		/* Use RefClk as PLL input */
-		 (best_div << 8) |		/* Divider for PLL RefClk */
-		 (best_mul << 0));		/* Multiplier for PLL */
+	pxl_pllparam  = vco_hi << 24; /* For PLL VCO >= 300 MHz = 1 */
+	pxl_pllparam |= ext_div[best_pre] << 20; /* External Pre-divider */
+	pxl_pllparam |= ext_div[best_post] << 16; /* External Post-divider */
+	pxl_pllparam |= IN_SEL_REFCLK; /* Use RefClk as PLL input */
+	pxl_pllparam |= best_div << 8; /* Divider for PLL RefClk */
+	pxl_pllparam |= best_mul; /* Multiplier for PLL */
+
+	ret = regmap_write(tc->regmap, PXL_PLLPARAM, pxl_pllparam);
+	if (ret)
+		return ret;
 
 	/* Force PLL parameter update and disable bypass */
-	tc_write(PXL_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLUPDATE | PLLEN);
+	if (ret)
+		return ret;
 
 	tc_wait_pll_lock(tc);
 
 	return 0;
-err:
-	return ret;
 }
 
 static int tc_pxl_pll_dis(struct tc_data *tc)
@@ -537,7 +540,6 @@ static int tc_pxl_pll_dis(struct tc_data *tc)
 
 static int tc_stream_clock_calc(struct tc_data *tc)
 {
-	int ret;
 	/*
 	 * If the Stream clock and Link Symbol clock are
 	 * asynchronous with each other, the value of M changes over
@@ -553,16 +555,13 @@ static int tc_stream_clock_calc(struct tc_data *tc)
 	 * M/N = f_STRMCLK / f_LSCLK
 	 *
 	 */
-	tc_write(DP0_VIDMNGEN1, 32768);
-
-	return 0;
-err:
-	return ret;
+	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
 }
 
 static int tc_aux_link_setup(struct tc_data *tc)
 {
 	unsigned long rate;
+	u32 dp0_auxcfg1;
 	u32 value;
 	int ret;
 
@@ -587,18 +586,25 @@ static int tc_aux_link_setup(struct tc_data *tc)
 
 	/* Setup DP-PHY / PLL */
 	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	tc_write(SYS_PLLPARAM, value);
-
-	tc_write(DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_A0_EN);
+	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	if (ret)
+		goto err;
 
+	ret = regmap_write(tc->regmap, DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_A0_EN);
+	if (ret)
+		goto err;
 	/*
 	 * Initially PLLs are in bypass. Force PLL parameter update,
 	 * disable PLL bypass, enable PLL
 	 */
-	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	if (ret)
+		goto err;
 	tc_wait_pll_lock(tc);
 
-	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	if (ret)
+		goto err;
 	tc_wait_pll_lock(tc);
 
 	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
@@ -610,9 +616,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	}
 
 	/* Setup AUX link */
-	tc_write(DP0_AUXCFG1, AUX_RX_FILTER_EN |
-		 (0x06 << 8) |	/* Aux Bit Period Calculator Threshold */
-		 (0x3f << 0));	/* Aux Response Timeout Timer */
+	dp0_auxcfg1  = AUX_RX_FILTER_EN;
+	dp0_auxcfg1 |= 0x06 << 8; /* Aux Bit Period Calculator Threshold */
+	dp0_auxcfg1 |= 0x3f << 0; /* Aux Response Timeout Timer */
+
+	ret = regmap_write(tc->regmap, DP0_AUXCFG1, dp0_auxcfg1);
+	if (ret)
+		goto err;
 
 	return 0;
 err:
@@ -764,16 +774,16 @@ static int tc_wait_link_training(struct tc_data *tc, u32 *error)
 			      LT_LOOPDONE, 1, 1000);
 	if (ret) {
 		dev_err(tc->dev, "Link training timeout waiting for LT_LOOPDONE!\n");
-		goto err;
+		return ret;
 	}
 
-	tc_read(DP0_LTSTAT, &value);
+	ret = regmap_read(tc->regmap, DP0_LTSTAT, &value);
+	if (ret)
+		return ret;
 
 	*error = (value >> 8) & 0x7;
 
 	return 0;
-err:
-	return ret;
 }
 
 static int tc_main_link_enable(struct tc_data *tc)
@@ -789,13 +799,19 @@ static int tc_main_link_enable(struct tc_data *tc)
 
 	dev_dbg(tc->dev, "link enable\n");
 
-	tc_write(DP0CTL, 0);
+	ret = regmap_write(tc->regmap, DP0CTL, 0);
+	if (ret)
+		return ret;
 
-	tc_write(DP0_SRCCTRL, tc_srcctrl(tc));
+	ret = regmap_write(tc->regmap, DP0_SRCCTRL, tc_srcctrl(tc));
+	if (ret)
+		return ret;
 	/* SSCG and BW27 on DP1 must be set to the same as on DP0 */
-	tc_write(DP1_SRCCTRL,
+	ret = regmap_write(tc->regmap, DP1_SRCCTRL,
 		 (tc->link.spread ? DP0_SRCCTRL_SSCG : 0) |
 		 ((tc->link.base.rate != 162000) ? DP0_SRCCTRL_BW27 : 0));
+	if (ret)
+		return ret;
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
@@ -815,27 +831,36 @@ static int tc_main_link_enable(struct tc_data *tc)
 		return -EINVAL;
 	}
 	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	tc_write(SYS_PLLPARAM, value);
+	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	if (ret)
+		return ret;
 
 	/* Setup Main Link */
 	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN | PHY_M0_EN;
 	if (tc->link.base.num_lanes == 2)
 		dp_phy_ctrl |= PHY_2LANE;
-	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
+
+	ret = regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
+	if (ret)
+		return ret;
 
 	/* PLL setup */
-	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	if (ret)
+		return ret;
 	tc_wait_pll_lock(tc);
 
-	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	if (ret)
+		return ret;
 	tc_wait_pll_lock(tc);
 
 	/* Reset/Enable Main Links */
 	dp_phy_ctrl |= DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;
-	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
+	ret = regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
 	usleep_range(100, 200);
 	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
-	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
+	ret = regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
 
 	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
 	if (ret) {
@@ -847,7 +872,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	/* Set misc: 8 bits per color */
 	ret = regmap_update_bits(tc->regmap, DP0_MISC, BPC_8, BPC_8);
 	if (ret)
-		goto err;
+		return ret;
 
 	/*
 	 * ASSR mode
@@ -899,55 +924,68 @@ static int tc_main_link_enable(struct tc_data *tc)
 	/* LINK TRAINING PATTERN 1 */
 
 	/* Set DPCD 0x102 for Training Pattern 1 */
-	tc_write(DP0_SNKLTCTRL, DP_LINK_SCRAMBLING_DISABLE | DP_TRAINING_PATTERN_1);
+	ret = regmap_write(tc->regmap, DP0_SNKLTCTRL, DP_LINK_SCRAMBLING_DISABLE | DP_TRAINING_PATTERN_1);
+	if (ret)
+		return ret;
 
-	tc_write(DP0_LTLOOPCTRL,
-		 (15 << 28) |	/* Defer Iteration Count */
-		 (15 << 24) |	/* Loop Iteration Count */
-		 (0xd << 0));	/* Loop Timer Delay */
+	ret = regmap_write(tc->regmap, DP0_LTLOOPCTRL,
+			   (15 << 28) |	/* Defer Iteration Count */
+			   (15 << 24) |	/* Loop Iteration Count */
+			   (0xd << 0));	/* Loop Timer Delay */
+	if (ret)
+		return ret;
 
-	tc_write(DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS | DP0_SRCCTRL_AUTOCORRECT |
-		 DP0_SRCCTRL_TP1);
+	ret = regmap_write(tc->regmap, DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS | DP0_SRCCTRL_AUTOCORRECT |
+			   DP0_SRCCTRL_TP1);
+	if (ret)
+		return ret;
 
 	/* Enable DP0 to start Link Training */
-	tc_write(DP0CTL,
-		 ((tc->link.base.capabilities & DP_LINK_CAP_ENHANCED_FRAMING) ? EF_EN : 0) |
-		 DP_EN);
+	ret = regmap_write(tc->regmap, DP0CTL,
+			   ((tc->link.base.capabilities & DP_LINK_CAP_ENHANCED_FRAMING) ? EF_EN : 0) |
+			   DP_EN);
+	if (ret)
+		return ret;
 
 	/* wait */
 	ret = tc_wait_link_training(tc, &error);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (error) {
 		dev_err(tc->dev, "Link training phase 1 failed: %s\n",
 			training_pattern1_errors[error]);
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	/* LINK TRAINING PATTERN 2 */
 
 	/* Set DPCD 0x102 for Training Pattern 2 */
-	tc_write(DP0_SNKLTCTRL, DP_LINK_SCRAMBLING_DISABLE | DP_TRAINING_PATTERN_2);
+	ret = regmap_write(tc->regmap, DP0_SNKLTCTRL, DP_LINK_SCRAMBLING_DISABLE | DP_TRAINING_PATTERN_2);
+	if (ret)
+		return ret;
 
-	tc_write(DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS | DP0_SRCCTRL_AUTOCORRECT |
-		 DP0_SRCCTRL_TP2);
+	ret = regmap_write(tc->regmap, DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS | DP0_SRCCTRL_AUTOCORRECT |
+			   DP0_SRCCTRL_TP2);
+	if (ret)
+		return ret;
 
 	/* wait */
 	ret = tc_wait_link_training(tc, &error);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (error) {
 		dev_err(tc->dev, "Link training phase 2 failed: %s\n",
 			training_pattern2_errors[error]);
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	/* Clear Training Pattern, set AutoCorrect Mode = 1 */
-	tc_write(DP0_SRCCTRL, tc_srcctrl(tc) | DP0_SRCCTRL_AUTOCORRECT);
+	ret = regmap_write(tc->regmap, DP0_SRCCTRL, tc_srcctrl(tc) |
+			   DP0_SRCCTRL_AUTOCORRECT);
+	if (ret)
+		return ret;
 
 	/* Clear DPCD 0x102 */
 	/* Note: Can Not use DP0_SNKLTCTRL (0x06E4) short cut */
@@ -991,7 +1029,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 		dev_err(dev, "0x0205 SINK_STATUS:               0x%02x\n", tmp[3]);
 		dev_err(dev, "0x0206 ADJUST_REQUEST_LANE0_1:    0x%02x\n", tmp[4]);
 		dev_err(dev, "0x0207 ADJUST_REQUEST_LANE2_3:    0x%02x\n", tmp[5]);
-		goto err;
+		return ret;
 	}
 
 	return 0;
@@ -1000,7 +1038,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 	return ret;
 err_dpcd_write:
 	dev_err(tc->dev, "Failed to write DPCD: %d\n", ret);
-err:
 	return ret;
 }
 
@@ -1010,12 +1047,11 @@ static int tc_main_link_disable(struct tc_data *tc)
 
 	dev_dbg(tc->dev, "link disable\n");
 
-	tc_write(DP0_SRCCTRL, 0);
-	tc_write(DP0CTL, 0);
+	ret = regmap_write(tc->regmap, DP0_SRCCTRL, 0);
+	if (ret)
+		return ret;
 
-	return 0;
-err:
-	return ret;
+	return regmap_write(tc->regmap, DP0CTL, 0);
 }
 
 static int tc_stream_enable(struct tc_data *tc)
@@ -1030,22 +1066,24 @@ static int tc_stream_enable(struct tc_data *tc)
 		ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
 				    1000 * tc->mode.clock);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	ret = tc_set_video_mode(tc, &tc->mode);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* Set M/N */
 	ret = tc_stream_clock_calc(tc);
 	if (ret)
-		goto err;
+		return ret;
 
 	value = VID_MN_GEN | DP_EN;
 	if (tc->link.base.capabilities & DP_LINK_CAP_ENHANCED_FRAMING)
 		value |= EF_EN;
-	tc_write(DP0CTL, value);
+	ret = regmap_write(tc->regmap, DP0CTL, value);
+	if (ret)
+		return ret;
 	/*
 	 * VID_EN assertion should be delayed by at least N * LSCLK
 	 * cycles from the time VID_MN_GEN is enabled in order to
@@ -1055,18 +1093,20 @@ static int tc_stream_enable(struct tc_data *tc)
 	 */
 	usleep_range(500, 1000);
 	value |= VID_EN;
-	tc_write(DP0CTL, value);
+	ret = regmap_write(tc->regmap, DP0CTL, value);
+	if (ret)
+		return ret;
 	/* Set input interface */
 	value = DP0_AUDSRC_NO_INPUT;
 	if (tc_test_pattern)
 		value |= DP0_VIDSRC_COLOR_BAR;
 	else
 		value |= DP0_VIDSRC_DPI_RX;
-	tc_write(SYSCTRL, value);
+	ret = regmap_write(tc->regmap, SYSCTRL, value);
+	if (ret)
+		return ret;
 
 	return 0;
-err:
-	return ret;
 }
 
 static int tc_stream_disable(struct tc_data *tc)
@@ -1075,13 +1115,13 @@ static int tc_stream_disable(struct tc_data *tc)
 
 	dev_dbg(tc->dev, "stream disable\n");
 
-	tc_write(DP0CTL, 0);
+	ret = regmap_write(tc->regmap, DP0CTL, 0);
+	if (ret)
+		return ret;
 
 	tc_pxl_pll_dis(tc);
 
 	return 0;
-err:
-	return ret;
 }
 
 static void tc_bridge_pre_enable(struct drm_bridge *bridge)
@@ -1258,7 +1298,9 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
 	int ret;
 	bool conn;
 
-	tc_read(GPIOI, &val);
+	ret = regmap_read(tc->regmap, GPIOI, &val);
+	if (ret)
+		return connector_status_unknown;
 
 	conn = val & BIT(0);
 
@@ -1269,9 +1311,6 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
 		return connector_status_connected;
 	else
 		return connector_status_disconnected;
-
-err:
-	return connector_status_unknown;
 }
 
 static const struct drm_connector_funcs tc_connector_funcs = {
-- 
2.20.1

