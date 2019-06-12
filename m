Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8C5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EC32086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlNjNQLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfFLIds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43074 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408641AbfFLIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so8521170pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOBTu7k51hnvRTEMXk6cCC9yyhEc8M5AYxFi2UI0Je8=;
        b=TlNjNQLy5QEdEHGKMdc8GdhkvesgOfZhS5ONJuqYpL7KCBCyteAmvuUrcB9UEtxd4o
         QC9pXUidu0IdG7ecWazNCiVAhbmJqkT4S9y7qF2Wyj3GAmENKPSzWsSO9yI4zf8Bkxh4
         rk+nbaiyLBxwwn21hP6584o5mBoHZknXcsVNgKXQJqSPBteiAZtqt/bYJa6zvMjUiD+x
         pvE4Vc1TvZedrcpX7EnHEuW4BXxbrQkEbuL/+Mreo6sN5A+YE1wPZdn3AhcHxHlkjd11
         EXOK61SNHayGsssRUAtcB5nbyx0lOiEaQcR3kp4U8tjc6oaaVqhzeE2igAfiRtVvBWsI
         RJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOBTu7k51hnvRTEMXk6cCC9yyhEc8M5AYxFi2UI0Je8=;
        b=f5756GFQQWqFN6gXcG2imle/gFf4NCU1apmzwAzEaLSelYOIhGrvcP4+RwLu+2jayv
         9LKyQ+6BXjYg2ZMRfUdU8mHagHF9MlUbkQyS8D2MThjx+YNoJbqwnZ1z2zDi8k1JzLRC
         d0lPzQe8c2XlJu2kcowPNgvYhDc9JhSGjm04O1Um9VVwb9UB+VKJ5zMXfyqHHouA9W+e
         gXJMKsmhi/T2BP8AvQS0G/nZMJOcNwbnl8/irHaQxiLq7tHAlkxo7IxLNg35Jfm8wGW5
         41/ojEuRix7+0GPc+LOJ75+19j/aSNKtXKCM5sV75bo6RWBYdUQ8jHCcgPta1byJyT7C
         4Ucw==
X-Gm-Message-State: APjAAAUit5Y2lT2BiECcLcdETfHNyeSrfYQDu4Stz+jihRA+qtXReQvJ
        CYX9RadeYnlKkqigzhj0C1Q=
X-Google-Smtp-Source: APXvYqzZJzylRZUgkeSpqZ4nCtyIo+PFX8dLpdiI8fU2VojR5nFA4Pbmsr3qXOqRU6y5RaCc7AR2zA==
X-Received: by 2002:a17:90a:fa12:: with SMTP id cm18mr31456486pjb.137.1560328404386;
        Wed, 12 Jun 2019 01:33:24 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/15] drm/bridge: tc358767: Introduce tc_pllupdate()
Date:   Wed, 12 Jun 2019 01:32:49 -0700
Message-Id: <20190612083252.15321-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tc_wait_pll_lock() is always called as a follow-up for updating
PLLUPDATE and PLLEN bit of a given PLL control register. To simplify
things, merge the two operation into a single helper function
tc_pllupdate() and convert the rest of the code to use it. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ac55b59249e3..28df53f7c349 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -443,10 +443,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
 	return reg;
 }
 
-static void tc_wait_pll_lock(struct tc_data *tc)
+static int tc_pllupdate(struct tc_data *tc, unsigned int pllctrl)
 {
+	int ret;
+
+	ret = regmap_write(tc->regmap, pllctrl, PLLUPDATE | PLLEN);
+	if (ret)
+		return ret;
+
 	/* Wait for PLL to lock: up to 2.09 ms, depending on refclk */
 	usleep_range(3000, 6000);
+
+	return 0;
 }
 
 static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
@@ -546,13 +554,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
 		return ret;
 
 	/* Force PLL parameter update and disable bypass */
-	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLUPDATE | PLLEN);
-	if (ret)
-		return ret;
-
-	tc_wait_pll_lock(tc);
-
-	return 0;
+	return tc_pllupdate(tc, PXL_PLLCTRL);
 }
 
 static int tc_pxl_pll_dis(struct tc_data *tc)
@@ -626,15 +628,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	 * Initially PLLs are in bypass. Force PLL parameter update,
 	 * disable PLL bypass, enable PLL
 	 */
-	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate(tc, DP0_PLLCTRL);
 	if (ret)
 		goto err;
-	tc_wait_pll_lock(tc);
 
-	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate(tc, DP1_PLLCTRL);
 	if (ret)
 		goto err;
-	tc_wait_pll_lock(tc);
 
 	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
 	if (ret == -ETIMEDOUT) {
@@ -914,15 +914,13 @@ static int tc_main_link_enable(struct tc_data *tc)
 		return ret;
 
 	/* PLL setup */
-	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate(tc, DP0_PLLCTRL);
 	if (ret)
 		return ret;
-	tc_wait_pll_lock(tc);
 
-	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate(tc, DP1_PLLCTRL);
 	if (ret)
 		return ret;
-	tc_wait_pll_lock(tc);
 
 	/* Reset/Enable Main Links */
 	dp_phy_ctrl |= DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;
-- 
2.21.0

