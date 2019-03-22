Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B75021904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7yFMsfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfCVD3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42495 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVD3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so522384pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgrTJQtYJ1/aH4LpCAiSuAxdXzKMohH0iux2BQdEBug=;
        b=i7yFMsfyCuMTnPdoR87/xpAEM2URtLQqTHeIYQzc3S2cuXZQG6EGXTZF44Tj2aMiPV
         Jy4DBPCzutSqX3OlTHqwH3BDqNMOZYL9tvqvXIRob/UJLbYaSUx6Kir9n+wHM8r0LFdC
         CcI+YQWI2fX1Gs2cKByWXfehZwD0XdYcwNtsQf6zcWTUFhi5n6U8Dgv8sFj7sCa6lFSu
         qAGA+mIVb2UtoOb8T0I8/REWtDPyS8s6EzWOGtjftDLsuKQlMM6NNFve+g034YW8e8VV
         zBs5Ec5XJbmEQiHJyM6Jlo8t9RJ4IT1i8xk3FpmWn9BUgZJyORMb1oCV51mW0Kr2KC5p
         fdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgrTJQtYJ1/aH4LpCAiSuAxdXzKMohH0iux2BQdEBug=;
        b=b13MksD4HD+52WOwe49fgs3Z2igrzvOoU9Oe+sxmpFoPvM1kkyFkjgVeS7lOc+tMi4
         S8ZAXuRAR7gXW01nj4XDnAvbE/lWezhUrhCXvfBR23P8m8LDqv/NuLAPrYO2NLyJkNVT
         s586gPNBEyG8VoevrP/Y5S3kY9R+O1KhKdx/RbjRD23YY8JxPFtkxAsJFya0h4rZedwh
         duoH0opNFuIhLxuzZ1v1yr703gB8ypBfwPV7GTPSqR3wIEKzXeeBRrXvzevQfKf+F/bs
         lYyyLKDfl9wkdX3T1chwDxKTfuQs5TqLjj5AO/NVY5sEnTzvyARCwll4hcd2ceHh01pj
         HbQw==
X-Gm-Message-State: APjAAAVLLM1nI2Di4+fDsNd41oOqwuyjFnnv+9On5ZnyC4zbG6bDTq/Z
        DZLfTUX5jvNsBR8h/39QDp0=
X-Google-Smtp-Source: APXvYqzPnGZiimk2onzvBJyUA/WOTswBZDqDHnwlKF4cQApQwbuHELjdvxG9aN82b3GFKbJUWf0XJg==
X-Received: by 2002:a63:f544:: with SMTP id e4mr6773018pgk.145.1553225370827;
        Thu, 21 Mar 2019 20:29:30 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:30 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/15] drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
Date:   Thu, 21 Mar 2019 20:28:58 -0700
Message-Id: <20190322032901.12045-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tc_wait_pll_lock() is always called as a follow-up for updating
PLLUPDATE and PLLEN bit of a given PLL control register. To simplify
things, merge the two operation into a single helper function
tc_pllupdate_pllen() and convert the rest of the code to use it. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 32 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 976a9861e537..f66a1c4a2047 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -447,10 +447,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
 	return reg;
 }
 
-static void tc_wait_pll_lock(struct tc_data *tc)
+static int tc_pllupdate_pllen(struct tc_data *tc, unsigned int pllctrl)
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
@@ -550,13 +558,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
 		return ret;
 
 	/* Force PLL parameter update and disable bypass */
-	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLUPDATE | PLLEN);
-	if (ret)
-		return ret;
-
-	tc_wait_pll_lock(tc);
-
-	return 0;
+	return tc_pllupdate_pllen(tc, PXL_PLLCTRL);
 }
 
 static int tc_pxl_pll_dis(struct tc_data *tc)
@@ -615,7 +617,6 @@ static int tc_set_syspllparam(struct tc_data *tc)
 static int tc_aux_link_setup(struct tc_data *tc)
 {
 	int ret;
-	u32 dp_phy_ctrl;
 	u32 dp0_auxcfg1;
 
 	/* Setup DP-PHY / PLL */
@@ -630,15 +631,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	 * Initially PLLs are in bypass. Force PLL parameter update,
 	 * disable PLL bypass, enable PLL
 	 */
-	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
 	if (ret)
 		goto err;
-	tc_wait_pll_lock(tc);
 
-	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
 	if (ret)
 		goto err;
-	tc_wait_pll_lock(tc);
 
 	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
 	if (ret == -ETIMEDOUT) {
@@ -823,6 +822,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 {
 	struct drm_dp_aux *aux = &tc->aux;
 	struct device *dev = tc->dev;
+	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
 	u8 tmp[8];
@@ -858,15 +858,13 @@ static int tc_main_link_enable(struct tc_data *tc)
 		return ret;
 
 	/* PLL setup */
-	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
 	if (ret)
 		return ret;
-	tc_wait_pll_lock(tc);
 
-	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
 	if (ret)
 		return ret;
-	tc_wait_pll_lock(tc);
 
 	/* Reset/Enable Main Links */
 	dp_phy_ctrl |= DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;
-- 
2.20.1

