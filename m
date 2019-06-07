Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC0C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1474208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTS9Fg43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFGErS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:47:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46788 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfFGEqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so440698pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0v+BcQmulHNucpxyA52yB5gSwLum7NLCDQmJ1Ymhrs=;
        b=LTS9Fg434BEKRayzjptrBJ29XhWEJGNMFsVAg3qpTKOB5bGAqjMjz7t/7CvdCFb+Mi
         uS8wTDThTjnehndfcu/GX8U7JWEoa16OmKqPtHJFvevcQAbDJTu2+n1PbVB55z48LNsP
         enwQ6MpJs7JgrRRPohn1lMpTR0BNRZj3BV7GhpFe0mR/QEDR5EZrNLdzBe+7PVBv0pys
         Kih2pu+r5vVOfG6Dln7BqXqXDrAbmBiavviREDBwiIkVrIdFIwzNa3Wp2Jfsn4QWlbX9
         UvD81VKrFp/qQkNSeJzFIaAnLZSmsYgmiC94ewD4+tw5VG+FlTbXeacp65A5lqf279HR
         1XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0v+BcQmulHNucpxyA52yB5gSwLum7NLCDQmJ1Ymhrs=;
        b=l3UD30Mpsz9ILT5WNpElNbwSOqK7fKFUejqy/sU499XxS7SLADM7dAMRf+RCq8pbUp
         MjQP59JH43eKfhKbkIPkpAvVotBv9KWouCccC7cv/rCHTj52Jyz/Y2LS1hqDl9Wb8J3M
         RJGAeBGnuSYI9Ij/wVA71qyCGBHAWpPUxdMmXcw5u/8O4hNmqfNS9knT+IGLpP0qqAji
         NJMOP/avhOYn11X2CCXCnnlI1aER6TbxCa6y2IlWyScpbnmbhby/BQN4ckHJIAkNCRNA
         0Vb0W3FOpwiClh2D4wNwejnOF9yELItRP+msGjp6rlb7X0P4rosysxjuptgrLPgl1DDY
         luwQ==
X-Gm-Message-State: APjAAAVsJQoBdwdVbzkuP2ECE6VIcSbIkSxCsl99lKYgViZvEMBVMdp2
        ElC23c/MjwPdsqhEXzpucCM=
X-Google-Smtp-Source: APXvYqzxyVVp8a9lLqSU21sCFMJSkbdNaHS0sfCrksAYL3DjVX9PjRMND4e8PDoWnzViGDq3c/MTgw==
X-Received: by 2002:a63:5009:: with SMTP id e9mr1102316pgb.396.1559882804937;
        Thu, 06 Jun 2019 21:46:44 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:44 -0700 (PDT)
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
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/15] drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
Date:   Thu,  6 Jun 2019 21:45:47 -0700
Message-Id: <20190607044550.13361-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
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
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ac55b59249e3..c994c72eb330 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -443,10 +443,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
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
+	return tc_pllupdate_pllen(tc, PXL_PLLCTRL);
 }
 
 static int tc_pxl_pll_dis(struct tc_data *tc)
@@ -626,15 +628,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
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
@@ -914,15 +914,13 @@ static int tc_main_link_enable(struct tc_data *tc)
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
2.21.0

