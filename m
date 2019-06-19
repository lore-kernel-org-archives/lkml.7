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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACBC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C638215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHQ+VzdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfFSF2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:28:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39297 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbfFSF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so9019328pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kXCoWmoCY207aDmCFQDxyIujl2m7dcDq7H8SnON7e4=;
        b=pHQ+VzdXbpAkLrUC+kwkOLaeJYEz/P+MbIwRa1KSxgDw7C746OEaPUsSczK5yb4eEC
         dbSt+vxH7YZKjM/BBOJrN54PcQOZlvVbS8QBg5QY3hGGSB3tNn+N0CyvcZrlQVmds1RI
         lQnqw4ZT20f620zRXE6ZgBhrjcAKoBbGyZpIL+z6qZ8WLuKnBogKFQQslLW7P5xTDYh+
         qF4Zg3z9EnYK3NSCSq9YITWLl9oPXqQyMf46JBgMIpgh6cyUoxYiUlOGUWboQlFV8erk
         nNXCud44yZzTivpcqR6l5cbihE0wFOUBpIxRlHfMCJfM+OozI085FkUFdZ+XMOf82Clq
         aEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kXCoWmoCY207aDmCFQDxyIujl2m7dcDq7H8SnON7e4=;
        b=bXWLBIyxdZ2QbsK0M+220pOIq9k8EDX8QjirX+w9VLK7to/6o6AhO/EletELWy6bS1
         OtunMaXeOs/5hm3EzWkNxzpnDz2NFEXj0LpnngIYVhTJAaRsX5I9AMOKEYDOfetioZVn
         +9v4iE3sYUZ1wXr/Ji0dmh+v2u07lckHGrxhljbdSkZg2YGd/E+EKGM/fcexiTe2Hdle
         HXIdIt4F3hU8jQtm21u1gIhh6LrPrpCqNxVc47+7O6pNuMK7u2W9NcPO2kx5o/KGvT67
         jBUBT3p9u1vtg4TVLPCZWq+sNEDvb9JCtfSyfY/uGcHydY26tKXeKnTTBH+HrC/Td7yu
         MAUw==
X-Gm-Message-State: APjAAAU3j/FRe4PA7S6ax3qvxXsN4SAiBI7qN8Nd8z74W3NfZlitqXsX
        BxwA1u0CXXFKW0E3xZdidEU=
X-Google-Smtp-Source: APXvYqzv/yWhDaxL8rWnII5Ehvq1KgetBRjY6FMrs+08Ke20kaoBAQO2LHzabZc+U7Hn5q3xJ8HtxA==
X-Received: by 2002:a63:50a:: with SMTP id 10mr6216801pgf.213.1560922068920;
        Tue, 18 Jun 2019 22:27:48 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:48 -0700 (PDT)
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
Subject: [PATCH v6 11/15] drm/bridge: tc358767: Introduce tc_pllupdate()
Date:   Tue, 18 Jun 2019 22:27:12 -0700
Message-Id: <20190619052716.16831-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
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
index 7a3a1b2d5c56..fe672f6bba73 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -427,10 +427,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
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
@@ -530,13 +538,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
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
@@ -610,15 +612,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
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
@@ -898,15 +898,13 @@ static int tc_main_link_enable(struct tc_data *tc)
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

