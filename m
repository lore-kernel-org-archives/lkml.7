Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A27C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEF120820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HgcQ1K4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437477AbfIWIOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:14:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43089 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406607AbfIWIN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:13:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id u3so9358263lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lD0e8xFBv1AR2F4JhSacxWgoKrl7ntnXXGEiOwHJH74=;
        b=HgcQ1K4tr0a4wAHLWjvdmktJUM3BVu3dL17gzfeF3nAdsClcj6wJpQRG6DTVB1hHUz
         Ocxoxx1M7JSEGyy/x1h5RDBNGIkNUresJDZanlEHiG4f+3mLRDMjpRIMk4Ihi6/cdnfz
         LY3qlvifzD2By4oG01tO2WS6ZIhOkjr2PMAdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lD0e8xFBv1AR2F4JhSacxWgoKrl7ntnXXGEiOwHJH74=;
        b=n6Jqt+Hfuxu3isXkoGKHE0kzTtMLTZR+YZ57d3Ubeas3ijoxUVnqZrZQotXfeDcByA
         oZtOZzwB/33tZr06zN5dmF+ki1MzmJg+lyAn0d50naaSykTkLDMtRFKSY/IcB7za1VWz
         Q8RUcUnStK6XNqstHNEH2iD6YKUHzmXA3U0F6BhFlwsaSvMjvXqgISwmYGfWZYykYqDw
         5z3Dh5yjRI9fOhWfV5k7F3VtTrVfm47yVF8yxHFsZfRqX2ntGrJeRD3r0IXTls3YrEgo
         WNvISv8mfjzZGpi8HVAAD7LwHwknwu/FDqe0+Wrhoe++s3T2pxK3a9S92pd0Z3h8FgbX
         miqw==
X-Gm-Message-State: APjAAAUhcvZPzc3rk+UDQY7glhedjDT+IXWYGu7bobkOe7YZkdkkDmLb
        377OBSEfEPMvqngJD0PiEzmJCw==
X-Google-Smtp-Source: APXvYqw1MEjTQxg98Niosegmp9jqiu0UU9wKr4JajogIk6AZhpzsknKDrE5TkAC9EB5KWFhVZyxHSQ==
X-Received: by 2002:a19:6455:: with SMTP id b21mr16301336lfj.167.1569226434462;
        Mon, 23 Sep 2019 01:13:54 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:54 -0700 (PDT)
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
Subject: [PATCH 2/4] pwm: mxs: remove legacy methods
Date:   Mon, 23 Sep 2019 10:13:46 +0200
Message-Id: <20190923081348.6843-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now have ->apply, these are no longer relevant.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pwm/pwm-mxs.c | 77 -------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index c70c26a9ff68..284107784dad 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -102,85 +102,8 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			  int duty_ns, int period_ns)
-{
-	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
-	int ret, div = 0;
-	unsigned int period_cycles, duty_cycles;
-	unsigned long rate;
-	unsigned long long c;
-
-	rate = clk_get_rate(mxs->clk);
-	while (1) {
-		c = rate / cdiv[div];
-		c = c * period_ns;
-		do_div(c, 1000000000);
-		if (c < PERIOD_PERIOD_MAX)
-			break;
-		div++;
-		if (div >= PERIOD_CDIV_MAX)
-			return -EINVAL;
-	}
-
-	period_cycles = c;
-	c *= duty_ns;
-	do_div(c, period_ns);
-	duty_cycles = c;
-
-	/*
-	 * If the PWM channel is disabled, make sure to turn on the clock
-	 * before writing the register. Otherwise, keep it enabled.
-	 */
-	if (!pwm_is_enabled(pwm)) {
-		ret = clk_prepare_enable(mxs->clk);
-		if (ret)
-			return ret;
-	}
-
-	writel(duty_cycles << 16,
-			mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
-	writel(PERIOD_PERIOD(period_cycles) | PERIOD_ACTIVE_HIGH |
-	       PERIOD_INACTIVE_LOW | PERIOD_CDIV(div),
-			mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
-
-	/*
-	 * If the PWM is not enabled, turn the clock off again to save power.
-	 */
-	if (!pwm_is_enabled(pwm))
-		clk_disable_unprepare(mxs->clk);
-
-	return 0;
-}
-
-static int mxs_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
-	int ret;
-
-	ret = clk_prepare_enable(mxs->clk);
-	if (ret)
-		return ret;
-
-	writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
-
-	return 0;
-}
-
-static void mxs_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
-
-	writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
-
-	clk_disable_unprepare(mxs->clk);
-}
-
 static const struct pwm_ops mxs_pwm_ops = {
 	.apply = mxs_pwm_apply,
-	.config = mxs_pwm_config,
-	.enable = mxs_pwm_enable,
-	.disable = mxs_pwm_disable,
 	.owner = THIS_MODULE,
 };
 
-- 
2.20.1

