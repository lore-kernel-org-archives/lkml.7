Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C78BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02E620820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Dmz12yDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437317AbfIWIOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:14:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39357 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437137AbfIWIN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:13:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so9376914lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpSGZcyphX33tWCKZj2QOnhjatCzwqevQiSu1wJE2ec=;
        b=Dmz12yDsnTHknKDr1XIwQJzBNJZC5mwE32fKsldiBd0BPRnRCP/JDhpKbkpmTJ/YI0
         lWJ2pDKTAJpMq0DDGE3z6CdrSFhrHWthYPadNJwG9XE9mcYDMkus6zlYs25YCTTVepKO
         s0wT37trgWtLnZcKMzxVshRBGxB08/MIq/lfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpSGZcyphX33tWCKZj2QOnhjatCzwqevQiSu1wJE2ec=;
        b=S+9uTwqshO2esdCj9txuYdj+QfbhBOLLqB/ZwDT/uRBS99WMwDM8eCJdo5p6olbkpu
         MnqS39/nOnNPVLXnQB987X7GjJ6yBbuTv2jtDrRJ8OW6xeXvQQy9J97TrG61w+tmCHOK
         xIBrMGhA8pH9e0pT7wm9T/HxX6yMkhbuos+QVLllIttj4kzCSLiAEp0V2TIohNTffEBV
         /gOaJO/kOQDpAzXe9HhOycM5EaOZ027Fm4WLrapX+m1vxAqiWUwYROZ/LZXsvSPouKgE
         rl5vNFXXoZl9FW9Yw5J3FAFAb8ND5wtJ+WWlgbvioBmGn3AgJhVtjbz/ByE+zUOwwJcR
         5Asw==
X-Gm-Message-State: APjAAAVQCiWmcgBWXoKzUQYxO9W+r5X9B8AlMMQev/J6KOAzTYe5crgh
        /eh4Dm4zYQFGCe7DPlDstAA4pg==
X-Google-Smtp-Source: APXvYqyRCHU11hssheYtvH+avbpnrQ3CA/+RFZKG1MN2UvDqgVLTYcR3tSNxmjLfxzRrao5PKLPLeQ==
X-Received: by 2002:ac2:51ce:: with SMTP id u14mr14611494lfm.72.1569226435700;
        Mon, 23 Sep 2019 01:13:55 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:55 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] pwm: mxs: add support for inverse polarity
Date:   Mon, 23 Sep 2019 10:13:47 +0200
Message-Id: <20190923081348.6843-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I'm reading of_pwm_xlate_with_flags() right, existing device trees
that set #pwm-cells = 2 will continue to work.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pwm/pwm-mxs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 284107784dad..c46697acaf11 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -25,8 +25,11 @@
 #define  PERIOD_PERIOD(p)	((p) & 0xffff)
 #define  PERIOD_PERIOD_MAX	0x10000
 #define  PERIOD_ACTIVE_HIGH	(3 << 16)
+#define  PERIOD_ACTIVE_LOW	(2 << 16)
+#define  PERIOD_INACTIVE_HIGH	(3 << 18)
 #define  PERIOD_INACTIVE_LOW	(2 << 18)
 #define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LOW)
+#define  PERIOD_POLARITY_INVERSE	(PERIOD_ACTIVE_LOW | PERIOD_INACTIVE_HIGH)
 #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
 #define  PERIOD_CDIV_MAX	8
 
@@ -50,9 +53,7 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int period_cycles, duty_cycles;
 	unsigned long rate;
 	unsigned long long c;
-
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -ENOTSUPP;
+	unsigned int pol_bits;
 
 	rate = clk_get_rate(mxs->clk);
 	while (1) {
@@ -81,9 +82,12 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return ret;
 	}
 
+	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
+		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
+
 	writel(duty_cycles << 16,
 	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
-	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
+	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
 	       mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
 
 	if (state->enabled) {
@@ -129,6 +133,8 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 
 	mxs->chip.dev = &pdev->dev;
 	mxs->chip.ops = &mxs_pwm_ops;
+	mxs->chip.of_xlate = of_pwm_xlate_with_flags;
+	mxs->chip.of_pwm_n_cells = 3;
 	mxs->chip.base = -1;
 
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
-- 
2.20.1

