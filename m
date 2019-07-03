Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2878DC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D059F218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bPki6kvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfGCITG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:19:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfGCITG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:19:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x638IuGh3200849
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 01:18:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x638IuGh3200849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562141936;
        bh=ddoQP0JjolHFL7TwTdp6LM6GVTcatzRF+OdDIPJ98Tw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bPki6kvBmwiBUgVYsnMxbz8EUG/L0a4AnSUIDAlDfzrsJdODgS10BNYRHWAMEI8YN
         p+wflLAr66DDt25X7Q03+GrfAgxwX3kGLTtqgfbtmnDiKSMEVfwF7ZEmIJ3L5FLqOv
         r+S5JcGiPVYhjIPwtK6FfeJQhpQIHMAQGDjZyVbXZ4jK/WGwbso2iedhTyqO8VvKCR
         TI9dAi0prc4W5oMEYdU9Bq4QBorn/nGQXjk8xpiN5C/DrQ7al+Q205ecXR9K1myLDL
         hzcrIGpOb1ucXqzroG4N734QsnmbxRkeWl6VmmhtmjJ6fn/keWNjq+16nc+C3I5xdw
         6EpOd7+Dq06yA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x638ItY23200846;
        Wed, 3 Jul 2019 01:18:55 -0700
Date:   Wed, 3 Jul 2019 01:18:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b7107a67f0d125459fe41f86e8079afd1a5e0b15@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        marc.zyngier@arm.com, Robert.Hodaszi@digi.com,
        linux-kernel@vger.kernel.org
Reply-To: Robert.Hodaszi@digi.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, marc.zyngier@arm.com,
          hpa@zytor.com
In-Reply-To: <20190628111440.459647741@linutronix.de>
References: <20190628111440.459647741@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/irq: Handle spurious interrupt after shutdown
 gracefully
Git-Commit-ID: b7107a67f0d125459fe41f86e8079afd1a5e0b15
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b7107a67f0d125459fe41f86e8079afd1a5e0b15
Gitweb:     https://git.kernel.org/tip/b7107a67f0d125459fe41f86e8079afd1a5e0b15
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 28 Jun 2019 13:11:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 10:12:30 +0200

x86/irq: Handle spurious interrupt after shutdown gracefully

Since the rework of the vector management, warnings about spurious
interrupts have been reported. Robert provided some more information and
did an initial analysis. The following situation leads to these warnings:

   CPU 0                  CPU 1               IO_APIC

                                              interrupt is raised
                                              sent to CPU1
			  Unable to handle
			  immediately
			  (interrupts off,
			   deep idle delay)
   mask()
   ...
   free()
     shutdown()
     synchronize_irq()
     clear_vector()
                          do_IRQ()
                            -> vector is clear

Before the rework the vector entries of legacy interrupts were statically
assigned and occupied precious vector space while most of them were
unused. Due to that the above situation was handled silently because the
vector was handled and the core handler of the assigned interrupt
descriptor noticed that it is shut down and returned.

While this has been usually observed with legacy interrupts, this situation
is not limited to them. Any other interrupt source, e.g. MSI, can cause the
same issue.

After adding proper synchronization for level triggered interrupts, this
can only happen for edge triggered interrupts where the IO-APIC obviously
cannot provide information about interrupts in flight.

While the spurious warning is actually harmless in this case it worries
users and driver developers.

Handle it gracefully by marking the vector entry as VECTOR_SHUTDOWN instead
of VECTOR_UNUSED when the vector is freed up.

If that above late handling happens the spurious detector will not complain
and switch the entry to VECTOR_UNUSED. Any subsequent spurious interrupt on
that line will trigger the spurious warning as before.

Fixes: 464d12309e1b ("x86/vector: Switch IOAPIC to global reservation mode")
Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>-
Tested-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190628111440.459647741@linutronix.de

---
 arch/x86/include/asm/hw_irq.h | 3 ++-
 arch/x86/kernel/apic/vector.c | 4 ++--
 arch/x86/kernel/irq.c         | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 32e666e1231e..626e1ac6516e 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -151,7 +151,8 @@ extern char irq_entries_start[];
 #endif
 
 #define VECTOR_UNUSED		NULL
-#define VECTOR_RETRIGGERED	((void *)~0UL)
+#define VECTOR_SHUTDOWN		((void *)~0UL)
+#define VECTOR_RETRIGGERED	((void *)~1UL)
 
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3173e07d3791..1c6d1d5f28d3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -343,7 +343,7 @@ static void clear_irq_vector(struct irq_data *irqd)
 	trace_vector_clear(irqd->irq, vector, apicd->cpu, apicd->prev_vector,
 			   apicd->prev_cpu);
 
-	per_cpu(vector_irq, apicd->cpu)[vector] = VECTOR_UNUSED;
+	per_cpu(vector_irq, apicd->cpu)[vector] = VECTOR_SHUTDOWN;
 	irq_matrix_free(vector_matrix, apicd->cpu, vector, managed);
 	apicd->vector = 0;
 
@@ -352,7 +352,7 @@ static void clear_irq_vector(struct irq_data *irqd)
 	if (!vector)
 		return;
 
-	per_cpu(vector_irq, apicd->prev_cpu)[vector] = VECTOR_UNUSED;
+	per_cpu(vector_irq, apicd->prev_cpu)[vector] = VECTOR_SHUTDOWN;
 	irq_matrix_free(vector_matrix, apicd->prev_cpu, vector, managed);
 	apicd->prev_vector = 0;
 	apicd->move_in_progress = 0;
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2ea7c2f..a975246074b5 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -246,7 +246,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	if (!handle_irq(desc, regs)) {
 		ack_APIC_irq();
 
-		if (desc != VECTOR_RETRIGGERED) {
+		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
