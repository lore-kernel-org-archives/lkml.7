Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54437CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB8A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfKDRsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:48:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37994 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfKDRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:48:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRgSm-0002TK-FF; Mon, 04 Nov 2019 18:48:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 267B91C0426;
        Mon,  4 Nov 2019 18:48:24 +0100 (CET)
Date:   Mon, 04 Nov 2019 17:48:23 -0000
From:   "tip-bot2 for Fabien Parent" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/mediatek: Fix error handling
Cc:     Fabien Parent <fparent@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157288970383.29376.7408024267562070637.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     41d49e7939de5ec532d86494185b2ca2e99c848a
Gitweb:        https://git.kernel.org/tip/41d49e7939de5ec532d86494185b2ca2e99c848a
Author:        Fabien Parent <fparent@baylibre.com>
AuthorDate:    Thu, 19 Sep 2019 21:13:15 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 16 Oct 2019 17:04:50 +02:00

clocksource/drivers/mediatek: Fix error handling

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
index a562f49..9318edc 100644
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
