Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6CC47E49
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D7121D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USBcrqb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfKDOz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:55:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:55:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so17418681wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x0xctCv2ZXCL79AMXPVjCqXbn5s/U7pml38dAOXy2E4=;
        b=USBcrqb55X8IEr9R+6PEy76ot8zTTG60JR1BqHAr5P8UdlA3pVqDIW4NynvFTyMjff
         lCRl5lvpAW4dzz4BzMP9+TmtW6My7rCHvitpZyk+4IaHp16+XKOht0Nk+unbOTf0AZ59
         AdW14SilzJrZjigDLRva0Gopu57xRfMWNDtOWhazNDi104gHFiosI66RXydndE/r4qoA
         n98gA+YtBTzBppurjsv21dhHNKKTQet8Om52TQ64Vzq6BAyi8uX5WSfNP1dj+d8NSfZf
         LhydcUAE34aJu/NNtKXrof6fgyKwMZYS9H92A57ExYNj+MvorwghUCGuITuSA2I5BcE+
         UHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x0xctCv2ZXCL79AMXPVjCqXbn5s/U7pml38dAOXy2E4=;
        b=SdHqlqIrEpprSIq6Ft/1rmuO83SrvtmWmk08ZZZguOP66p4yJvHannno0EBeFiN6ki
         DFx3Ep94kAarCSRjSh4duP+6jAepsVUquXpaVw4TlZZQAagym+iVswI1Wpn2SZeqld5w
         hZHVSvcSZ93vNk7F+o/HAk1+usXAi4fmXBGNAYiwIAn1yftK/NJeqaKdv3+G2lkoUVz/
         UwSY1I4n2iqsVbSBMo2woztwnjx/uQ7VW4YzQPZALvTo1A569Fg+MkmNhPqXUGDqwKgR
         b96DNkwWw2iYdcRX7PxkqNj4r/D/FyoAUaJtJv04CzidKCaPkMbNYNFFyVo0c1s6O0Ko
         qh7w==
X-Gm-Message-State: APjAAAVzfu1LWfIzpGqIjF8J3gYIwOaWFgcmWpL3kuFuE2fMCDSzobBw
        7f57SLLaSkJZ9XO3nUG8MyGnpw==
X-Google-Smtp-Source: APXvYqxGTS8lxAdtVp22O/xmTQi31hcZy866LHn7jJTH/eFiE4pgUGCrcG0pKGOj1MnkDLxkOIOn/g==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr6160594wra.194.1572879353332;
        Mon, 04 Nov 2019 06:55:53 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:58da:b044:f184:d281])
        by smtp.gmail.com with ESMTPSA id f143sm18490907wme.40.2019.11.04.06.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 06:55:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 1/2] clocksource/drivers/mediatek: Fix error handling
Date:   Mon,  4 Nov 2019 15:55:42 +0100
Message-Id: <20191104145543.2523-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2210d602-bdab-5256-57b4-6e499c4b7644@linaro.org>
References: <2210d602-bdab-5256-57b4-6e499c4b7644@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

When timer_of_init fails, it cleans up after itself by undoing
everything it did during the initialization function.

mtk_syst_init and mtk_gpt_init both call timer_of_cleanup if
timer_of_init fails. timer_of_cleanup try to release the resource
taken.  Since these resources have already been cleaned up by
timer_of_init, we end up getting a few warnings printed:

[    0.001935] WARNING: CPU: 0 PID: 0 at __clk_put+0xe8/0x128
[    0.002650] Modules linked in:
[    0.003058] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.67+ #1
[    0.003852] Hardware name: MediaTek MT8183 (DT)
[    0.004446] pstate: 20400085 (nzCv daIf +PAN -UAO)
[    0.005073] pc : __clk_put+0xe8/0x128
[    0.005555] lr : clk_put+0xc/0x14
[    0.005988] sp : ffffff80090b3ea0
[    0.006422] x29: ffffff80090b3ea0 x28: 0000000040e20018
[    0.007121] x27: ffffffc07bfff780 x26: 0000000000000001
[    0.007819] x25: ffffff80090bda80 x24: ffffff8008ec5828
[    0.008517] x23: ffffff80090bd000 x22: ffffff8008d8b2e8
[    0.009216] x21: 0000000000000001 x20: fffffffffffffdfb
[    0.009914] x19: ffffff8009166180 x18: 00000000002bffa8
[    0.010612] x17: ffffffc012996980 x16: 0000000000000000
[    0.011311] x15: ffffffbf004a6800 x14: 3536343038393334
[    0.012009] x13: 2079726576652073 x12: 7eb9c62c5c38f100
[    0.012707] x11: ffffff80090b3ba0 x10: ffffff80090b3ba0
[    0.013405] x9 : 0000000000000004 x8 : 0000000000000040
[    0.014103] x7 : ffffffc079400270 x6 : 0000000000000000
[    0.014801] x5 : ffffffc079400248 x4 : 0000000000000000
[    0.015499] x3 : 0000000000000000 x2 : 0000000000000000
[    0.016197] x1 : ffffff80091661c0 x0 : fffffffffffffdfb
[    0.016896] Call trace:
[    0.017218]  __clk_put+0xe8/0x128
[    0.017654]  clk_put+0xc/0x14
[    0.018048]  timer_of_cleanup+0x60/0x7c
[    0.018551]  mtk_syst_init+0x8c/0x9c
[    0.019020]  timer_probe+0x6c/0xe0
[    0.019469]  time_init+0x14/0x44
[    0.019893]  start_kernel+0x2d0/0x46c
[    0.020378] ---[ end trace 8c1efabea1267649 ]---
[    0.020982] ------------[ cut here ]------------
[    0.021586] Trying to vfree() nonexistent vm area ((____ptrval____))
[    0.022427] WARNING: CPU: 0 PID: 0 at __vunmap+0xd0/0xd8
[    0.023119] Modules linked in:
[    0.023524] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.67+ #1
[    0.024498] Hardware name: MediaTek MT8183 (DT)
[    0.025091] pstate: 60400085 (nZCv daIf +PAN -UAO)
[    0.025718] pc : __vunmap+0xd0/0xd8
[    0.026176] lr : __vunmap+0xd0/0xd8
[    0.026632] sp : ffffff80090b3e90
[    0.027066] x29: ffffff80090b3e90 x28: 0000000040e20018
[    0.027764] x27: ffffffc07bfff780 x26: 0000000000000001
[    0.028462] x25: ffffff80090bda80 x24: ffffff8008ec5828
[    0.029160] x23: ffffff80090bd000 x22: ffffff8008d8b2e8
[    0.029858] x21: 0000000000000000 x20: 0000000000000000
[    0.030556] x19: ffffff800800d000 x18: 00000000002bffa8
[    0.031254] x17: 0000000000000000 x16: 0000000000000000
[    0.031952] x15: ffffffbf004a6800 x14: 3536343038393334
[    0.032651] x13: 2079726576652073 x12: 7eb9c62c5c38f100
[    0.033349] x11: ffffff80090b3b40 x10: ffffff80090b3b40
[    0.034047] x9 : 0000000000000005 x8 : 5f5f6c6176727470
[    0.034745] x7 : 5f5f5f5f28282061 x6 : ffffff80091c86ef
[    0.035443] x5 : ffffff800852b690 x4 : 0000000000000000
[    0.036141] x3 : 0000000000000002 x2 : 0000000000000002
[    0.036839] x1 : 7eb9c62c5c38f100 x0 : 7eb9c62c5c38f100
[    0.037536] Call trace:
[    0.037859]  __vunmap+0xd0/0xd8
[    0.038271]  vunmap+0x24/0x30
[    0.038664]  __iounmap+0x2c/0x34
[    0.039088]  timer_of_cleanup+0x70/0x7c
[    0.039591]  mtk_syst_init+0x8c/0x9c
[    0.040060]  timer_probe+0x6c/0xe0
[    0.040507]  time_init+0x14/0x44
[    0.040932]  start_kernel+0x2d0/0x46c

This commit remove the calls to timer_of_cleanup when timer_of_init
fails since it is unnecessary and actually cause warnings to be printed.

Fixes: a0858f937960 ("mediatek: Convert the driver to timer-of")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/linux-arm-kernel/20190919191315.25190-1-fparent@baylibre.com/
---
 drivers/clocksource/timer-mediatek.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index a562f491b0f8..9318edcd8963 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -268,15 +268,12 @@ static int __init mtk_syst_init(struct device_node *node)
 
 	ret = timer_of_init(node, &to);
 	if (ret)
-		goto err;
+		return ret;
 
 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
 					TIMER_SYNC_TICKS, 0xffffffff);
 
 	return 0;
-err:
-	timer_of_cleanup(&to);
-	return ret;
 }
 
 static int __init mtk_gpt_init(struct device_node *node)
@@ -293,7 +290,7 @@ static int __init mtk_gpt_init(struct device_node *node)
 
 	ret = timer_of_init(node, &to);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* Configure clock source */
 	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
@@ -311,9 +308,6 @@ static int __init mtk_gpt_init(struct device_node *node)
 	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
 
 	return 0;
-err:
-	timer_of_cleanup(&to);
-	return ret;
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
 TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
-- 
2.17.1

