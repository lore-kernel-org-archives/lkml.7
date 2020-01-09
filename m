Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97007C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79286206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgAIReC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:34:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55129 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgAIReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:34:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipbgz-00005T-Fi; Thu, 09 Jan 2020 18:33:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 134BE1C2CEF;
        Thu,  9 Jan 2020 18:33:57 +0100 (CET)
Date:   Thu, 09 Jan 2020 17:33:56 -0000
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/sched_clock: Disable interrupts in
 sched_clock_register()
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200107010630.954648-1-paul@crapouillou.net>
References: <20200107010630.954648-1-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <157859123687.30329.9990387106834700222.tip-bot2@tip-bot2>
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

Commit-ID:     479c296303e8d29711a5153f0fc4b67faa6d9866
Gitweb:        https://git.kernel.org/tip/479c296303e8d29711a5153f0fc4b67faa6d9866
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Tue, 07 Jan 2020 02:06:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jan 2020 18:28:34 +01:00

time/sched_clock: Disable interrupts in sched_clock_register()

Instead of issueing a warning if sched_clock_register() is called from a
context where IRQs are enabled, the code now ensures that IRQs are indeed
disabled.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200107010630.954648-1-paul@crapouillou.net

---
 kernel/time/sched_clock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index dbd6905..e4332e3 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -169,14 +169,15 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
-	unsigned long r;
+	unsigned long r, flags;
 	char r_unit;
 	struct clock_read_data rd;
 
 	if (cd.rate > rate)
 		return;
 
-	WARN_ON(!irqs_disabled());
+	/* Cannot register a sched_clock with interrupts on */
+	local_irq_save(flags);
 
 	/* Calculate the mult/shift to convert counter ticks to ns. */
 	clocks_calc_mult_shift(&new_mult, &new_shift, rate, NSEC_PER_SEC, 3600);
@@ -233,6 +234,8 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	if (irqtime > 0 || (irqtime == -1 && rate >= 1000000))
 		enable_sched_clock_irqtime();
 
+	local_irq_restore(flags);
+
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
 
