Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD87C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D0B2072C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Xkb2KUrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgAGBGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:06:43 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43056 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGBGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578359200; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=uuPoFu94bXU8ga+nCw2n/9tI2bxLR09q5XkKmFis3Ls=;
        b=Xkb2KUrKYd6yVOa0G9rLFCaEXj7b3mb8r7Aco0Mu5Gfzj+vbyLja7cly02aFXeqNlVwvZx
        KPrgebJVAHzXGFXgy9YM32fO6R9YIX13uIzxGuYlqGEiGvld7uQY9LP8MfbuUkqPRghx09
        SiZHEdJ58amNDPFJ6KBOK922bKQOgOk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] time/sched_clock: Disable interrupts in sched_clock_register
Date:   Tue,  7 Jan 2020 02:06:29 +0100
Message-Id: <20200107010630.954648-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of issueing a warning if sched_clock_register is called from a
context where IRQs are enabled, the code now ensures that IRQs are
indeed disabled.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 kernel/time/sched_clock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index dbd69052eaa6..e4332e3e2d56 100644
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
 
-- 
2.24.1

