Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB7C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5485C215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOV1Py2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfFSF1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:27:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43193 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbfFSF1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so8960982pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3azL3W8aECugncjqHtY+kqD7WaDuHbuCaFEu1OGnwg=;
        b=qOV1Py2zpsvamHrouGGaPf4EIv82LZbwIl9ntHtz6B7ZpmdkfN2mhOyx2LOFvnzdS+
         KrcUBGMLmQsV/gDqw4Day24vGjCx+1n8H1G/IuGZv1l9ViFAyhUjwjVPIf7Tb//A6ayH
         ef3Yr4HVz9e/IpwL4DZEy4kJxrPIBlzvFCDbnIe2Q1bu8VzUUhimAeFSeC3SzmfBmLMN
         6eUNz6llh8HhzRVSuuJ/i1cya//sWgJy+0AVsOwkb23ztlK/itxmH+40qaMBbU0YTmNq
         F7Gjm+CNLzlz3cu53oyNJ02v/tUhlsryaRPrOa87Qxg2lhIxVFf4JNURiAl16AmxNRJw
         e1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3azL3W8aECugncjqHtY+kqD7WaDuHbuCaFEu1OGnwg=;
        b=YqyS6ZDlfGtsUMnbPojzKDCX6KmnZFGzqFPWLcijrncUasxMRgOx5KhVGOeePb9ReN
         L7PVZdFejD9jDxYYqN8hoEGKzo6l96wr1b02NJZO0u4SSD6eoKly/9wqND/Gyqo49yKP
         FuhaEpJXuYpkYg6XeIaDvo9n9AgWhdO28BE6rpXHFK8kuQ0gpuedB2ImlZMaAKX7Hwn9
         HKB197vmUPPgXgV8ew9JVqo4wtOXohNdSf5ousMzG/vZvkvDMAmfviLQlwUXB/TjPTIN
         JNBXSagajp0f7pPU1ylgXm4rf9cSEqrPjh7q5XNjVC4rvfbScNiMGeuIZ8Z9c3zOHftM
         MNzA==
X-Gm-Message-State: APjAAAWkQw8pYBGZ5RiRJui+7zmxBH3jpzft2Gw7/xsAtcxIVUWa+gy9
        ep974rlzSiqKSXL2S87ZaIlzBlFIx0o=
X-Google-Smtp-Source: APXvYqx+sbfkzIncexlHUWyP7+glgUeMN/W5Y4ZeR5hh8JjKLRcsO98Xx24AQBU5yL9J91D7Uo6q4A==
X-Received: by 2002:a63:87c8:: with SMTP id i191mr6137310pge.131.1560922066899;
        Tue, 18 Jun 2019 22:27:46 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/15] drm/bridge: tc358767: Introduce tc_set_syspllparam()
Date:   Tue, 18 Jun 2019 22:27:11 -0700
Message-Id: <20190619052716.16831-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common code converting clock rate to an appropriate constant and
configuring SYS_PLLPARAM register into a separate routine and convert
the rest of the code to use it. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 46 +++++++++++--------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index b01c1c8341e1..7a3a1b2d5c56 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -565,35 +565,40 @@ static int tc_stream_clock_calc(struct tc_data *tc)
 	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
 }
 
-static int tc_aux_link_setup(struct tc_data *tc)
+static int tc_set_syspllparam(struct tc_data *tc)
 {
 	unsigned long rate;
-	u32 dp0_auxcfg1;
-	u32 value;
-	int ret;
+	u32 pllparam = SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
 	case 38400000:
-		value = REF_FREQ_38M4;
+		pllparam |= REF_FREQ_38M4;
 		break;
 	case 26000000:
-		value = REF_FREQ_26M;
+		pllparam |= REF_FREQ_26M;
 		break;
 	case 19200000:
-		value = REF_FREQ_19M2;
+		pllparam |= REF_FREQ_19M2;
 		break;
 	case 13000000:
-		value = REF_FREQ_13M;
+		pllparam |= REF_FREQ_13M;
 		break;
 	default:
 		dev_err(tc->dev, "Invalid refclk rate: %lu Hz\n", rate);
 		return -EINVAL;
 	}
 
+	return regmap_write(tc->regmap, SYS_PLLPARAM, pllparam);
+}
+
+static int tc_aux_link_setup(struct tc_data *tc)
+{
+	int ret;
+	u32 dp0_auxcfg1;
+
 	/* Setup DP-PHY / PLL */
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
 	if (ret)
 		goto err;
 
@@ -852,7 +857,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 {
 	struct drm_dp_aux *aux = &tc->aux;
 	struct device *dev = tc->dev;
-	unsigned int rate;
 	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
@@ -880,25 +884,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	if (ret)
 		return ret;
 
-	rate = clk_get_rate(tc->refclk);
-	switch (rate) {
-	case 38400000:
-		value = REF_FREQ_38M4;
-		break;
-	case 26000000:
-		value = REF_FREQ_26M;
-		break;
-	case 19200000:
-		value = REF_FREQ_19M2;
-		break;
-	case 13000000:
-		value = REF_FREQ_13M;
-		break;
-	default:
-		return -EINVAL;
-	}
-	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
-	ret = regmap_write(tc->regmap, SYS_PLLPARAM, value);
+	ret = tc_set_syspllparam(tc);
 	if (ret)
 		return ret;
 
-- 
2.21.0

