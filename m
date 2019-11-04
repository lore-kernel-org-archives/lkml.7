Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F85CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F3920B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfKDRyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:54:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:54:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRgYQ-0002ZK-Lo; Mon, 04 Nov 2019 18:54:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4AE6F1C0426;
        Mon,  4 Nov 2019 18:54:14 +0100 (CET)
Date:   Mon, 04 Nov 2019 17:54:14 -0000
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/renesas-ostm: Use unique
 device name instead of ostm
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016144747.29538-5-geert+renesas@glider.be>
References: <20191016144747.29538-5-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <157289005402.29376.6102945736763616341.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b35a5e5961f814799b75a97a16c9b51e0d477c06
Gitweb:        https://git.kernel.org/tip/b35a5e5961f814799b75a97a16c9b51e0d477c06
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 16 Oct 2019 16:47:47 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 04 Nov 2019 10:38:46 +01:00

clocksource/drivers/renesas-ostm: Use unique device name instead of ostm

Currently all OSTM devices are called "ostm", also in kernel messages.

As there can be multiple instances in an SoC, this can confuse the user.
Hence construct a unique name from the DT node name, like is done for
platform devices.

On RSK+RZA1, the boot log changes like:

    -clocksource: ostm: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 57352151442 ns
    +clocksource: timer@fcfec000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 57352151442 ns
     sched_clock: 32 bits at 33MHz, resolution 30ns, wraps every 64440619504ns
    -ostm: used for clocksource
    -ostm: used for clock events
    +/soc/timer@fcfec000: used for clocksource
    +/soc/timer@fcfec400: used for clock events
     ...
    -clocksource: Switched to clocksource ostm
    +clocksource: Switched to clocksource timer@fcfec000

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-5-geert+renesas@glider.be
---
 drivers/clocksource/renesas-ostm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 46012d9..3d06ba6 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -64,9 +64,9 @@ static int __init ostm_init_clksrc(struct timer_of *to)
 	writeb(CTL_FREERUN, timer_of_base(to) + OSTM_CTL);
 	writeb(TS, timer_of_base(to) + OSTM_TS);
 
-	return clocksource_mmio_init(timer_of_base(to) + OSTM_CNT, "ostm",
-				     timer_of_rate(to), 300, 32,
-				     clocksource_mmio_readl_up);
+	return clocksource_mmio_init(timer_of_base(to) + OSTM_CNT,
+				     to->np->full_name, timer_of_rate(to), 300,
+				     32, clocksource_mmio_readl_up);
 }
 
 static u64 notrace ostm_read_sched_clock(void)
@@ -190,13 +190,13 @@ static int __init ostm_init(struct device_node *np)
 			goto err_cleanup;
 
 		ostm_init_sched_clock(to);
-		pr_info("ostm: used for clocksource\n");
+		pr_info("%pOF: used for clocksource\n", np);
 	} else {
 		ret = ostm_init_clkevt(to);
 		if (ret)
 			goto err_cleanup;
 
-		pr_info("ostm: used for clock events\n");
+		pr_info("%pOF: used for clock events\n", np);
 	}
 
 	return 0;
