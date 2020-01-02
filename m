Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE39DC47409
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A0B20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004198;
	bh=gFmiTIFanl6uDAvj8mEMHH0JSvxZewluyRxF6kMjtPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVD+A5m7knhMVCn0fDvJ51Qx5ylDny+AiZruIBFUqxJyOgLEEFooZS516ojaPf7rK
	 ujT9pZCfb/PjujVYSc71Rwa0TLSUkVk9dsZTXAltc6NcAoBkd2UFfMTJ4Nx4xaIJEz
	 ut2LzFicvQlHiURTtiojnI4RkRFwigUsiiLQKf/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgABW36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:29:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbgABW3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960AB20863;
        Thu,  2 Jan 2020 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004191;
        bh=gFmiTIFanl6uDAvj8mEMHH0JSvxZewluyRxF6kMjtPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZtYQPKl7iABZgkwVSmz/rhokJVmcRzdKvflbN1cf6/ryclnBxRzFZVZhSAsWCWJ1
         7/pfBCXfhTCC6ORBTsZrz5/8k+6Zz9bZHREFUIREZD0gXDFgqQvCRY59ayC8CnaGaL
         tz0q5E7njmHkRwZ8GBxGlZHEqLI7jbcXu6AdndHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 041/171] x86/ioapic: Prevent inconsistent state when moving an interrupt
Date:   Thu,  2 Jan 2020 23:06:12 +0100
Message-Id: <20200102220552.675021311@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit df4393424af3fbdcd5c404077176082a8ce459c4 ]

There is an issue with threaded interrupts which are marked ONESHOT
and using the fasteoi handler:

  if (IS_ONESHOT())
    mask_irq();
  ....
  cond_unmask_eoi_irq()
    chip->irq_eoi();
      if (setaffinity_pending) {
         mask_ioapic();
         ...
	 move_affinity();
	 unmask_ioapic();
      }

So if setaffinity is pending the interrupt will be moved and then
unconditionally unmasked at the ioapic level, which is wrong in two
aspects:

 1) It should be kept masked up to the point where the threaded handler
    finished.

 2) The physical chip state and the software masked state are inconsistent

Guard both the mask and the unmask with a check for the software masked
state. If the line is marked masked then the ioapic line is also masked, so
both mask_ioapic() and unmask_ioapic() can be skipped safely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Fixes: 3aa551c9b4c4 ("genirq: add threaded interrupt handler support")
Link: https://lkml.kernel.org/r/20191017101938.321393687@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 09dd95cabfc2..3401b28f1312 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1712,9 +1712,10 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 
 static inline bool ioapic_irqd_mask(struct irq_data *data)
 {
-	/* If we are moving the irq we need to mask it */
+	/* If we are moving the IRQ we need to mask it */
 	if (unlikely(irqd_is_setaffinity_pending(data))) {
-		mask_ioapic_irq(data);
+		if (!irqd_irq_masked(data))
+			mask_ioapic_irq(data);
 		return true;
 	}
 	return false;
@@ -1751,7 +1752,9 @@ static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
 		 */
 		if (!io_apic_level_ack_pending(data->chip_data))
 			irq_move_masked_irq(data);
-		unmask_ioapic_irq(data);
+		/* If the IRQ is masked in the core, leave it: */
+		if (!irqd_irq_masked(data))
+			unmask_ioapic_irq(data);
 	}
 }
 #else
-- 
2.20.1



