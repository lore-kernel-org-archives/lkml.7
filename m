Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D83C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE13D218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JE/uXwNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGCIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:17:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfGCIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:17:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x638HZjw3200458
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 01:17:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x638HZjw3200458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562141855;
        bh=IzrOAt7Xi7dGQlZSI/K+wCcLknyWLq6rRj9PvT1aIfk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JE/uXwNQVsyuUrznElk9ijBS0ccYVSYz378lIvzxSdqzJp4T8yErjeXYeJ5a185yl
         mN++SqI6jSueEGNwYNBjUnKnIY261ICnE5YGw4iSmSE0IUzszzfqNwCl9gD7AQAcdd
         h2NWN88Tww1t/hQ2YrgRnpfcRb1YgSRgRQC8uaVu63xv5a+k0hkDBVdnxkTBkgINl9
         p+chPR/62AzkK5IK8LImuENHHOJHxA/hY1JPxP4nUR1L5+51xCJIUP5Wzq9EQbkZCI
         KQu8sYfH5H7LGsUzDhN7LEQHDIyWnSI13dWCHuayYGT0jHoIB6OQGmRQGCJmQX5p8M
         rnIdQcogcUt4A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x638HYgB3200455;
        Wed, 3 Jul 2019 01:17:34 -0700
Date:   Wed, 3 Jul 2019 01:17:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-62e0468650c30f0298822c580f382b16328119f6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        Robert.Hodaszi@digi.com, hpa@zytor.com, tglx@linutronix.de,
        marc.zyngier@arm.com
Reply-To: linux-kernel@vger.kernel.org, Robert.Hodaszi@digi.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          marc.zyngier@arm.com
In-Reply-To: <20190628111440.279463375@linutronix.de>
References: <20190628111440.279463375@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] genirq: Add optional hardware synchronization for
 shutdown
Git-Commit-ID: 62e0468650c30f0298822c580f382b16328119f6
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

Commit-ID:  62e0468650c30f0298822c580f382b16328119f6
Gitweb:     https://git.kernel.org/tip/62e0468650c30f0298822c580f382b16328119f6
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 28 Jun 2019 13:11:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 10:12:29 +0200

genirq: Add optional hardware synchronization for shutdown

free_irq() ensures that no hardware interrupt handler is executing on a
different CPU before actually releasing resources and deactivating the
interrupt completely in a domain hierarchy.

But that does not catch the case where the interrupt is on flight at the
hardware level but not yet serviced by the target CPU. That creates an
interesing race condition:

   CPU 0                  CPU 1               IRQ CHIP

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
     release_resources()
                          do_IRQ()
                            -> resources are not available

That might be harmless and just trigger a spurious interrupt warning, but
some interrupt chips might get into a wedged state.

Utilize the existing irq_get_irqchip_state() callback for the
synchronization in free_irq().

synchronize_hardirq() is not using this mechanism as it might actually
deadlock unter certain conditions, e.g. when called with interrupts
disabled and the target CPU is the one on which the synchronization is
invoked. synchronize_irq() uses it because that function cannot be called
from non preemtible contexts as it might sleep.

No functional change intended and according to Marc the existing GIC
implementations where the driver supports the callback should be able
to cope with that core change. Famous last words.

Fixes: 464d12309e1b ("x86/vector: Switch IOAPIC to global reservation mode")
Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190628111440.279463375@linutronix.de

---
 kernel/irq/internals.h |  4 +++
 kernel/irq/manage.c    | 75 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 9c957f8b1198..3a948f41ab00 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -97,6 +97,10 @@ static inline void irq_mark_irq(unsigned int irq) { }
 extern void irq_mark_irq(unsigned int irq);
 #endif
 
+extern int __irq_get_irqchip_state(struct irq_data *data,
+				   enum irqchip_irq_state which,
+				   bool *state);
+
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
 
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 44fc505815d6..fad61986f35c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,8 +35,9 @@ static int __init setup_forced_irqthreads(char *arg)
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
-static void __synchronize_hardirq(struct irq_desc *desc)
+static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
+	struct irq_data *irqd = irq_desc_get_irq_data(desc);
 	bool inprogress;
 
 	do {
@@ -52,6 +53,20 @@ static void __synchronize_hardirq(struct irq_desc *desc)
 		/* Ok, that indicated we're done: double-check carefully. */
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		inprogress = irqd_irq_inprogress(&desc->irq_data);
+
+		/*
+		 * If requested and supported, check at the chip whether it
+		 * is in flight at the hardware level, i.e. already pending
+		 * in a CPU and waiting for service and acknowledge.
+		 */
+		if (!inprogress && sync_chip) {
+			/*
+			 * Ignore the return code. inprogress is only updated
+			 * when the chip supports it.
+			 */
+			__irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE,
+						&inprogress);
+		}
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 		/* Oops, that failed? */
@@ -74,13 +89,18 @@ static void __synchronize_hardirq(struct irq_desc *desc)
  *	Returns: false if a threaded handler is active.
  *
  *	This function may be called - with care - from IRQ context.
+ *
+ *	It does not check whether there is an interrupt in flight at the
+ *	hardware level, but not serviced yet, as this might deadlock when
+ *	called with interrupts disabled and the target CPU of the interrupt
+ *	is the current CPU.
  */
 bool synchronize_hardirq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, false);
 		return !atomic_read(&desc->threads_active);
 	}
 
@@ -98,13 +118,17 @@ EXPORT_SYMBOL(synchronize_hardirq);
  *
  *	Can only be called from preemptible code as it might sleep when
  *	an interrupt thread is associated to @irq.
+ *
+ *	It optionally makes sure (when the irq chip supports that method)
+ *	that the interrupt is not pending in any CPU and waiting for
+ *	service.
  */
 void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, true);
 		/*
 		 * We made sure that no hardirq handler is
 		 * running. Now verify that no threaded handlers are
@@ -1730,8 +1754,12 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 
 	unregister_handler_proc(irq, action);
 
-	/* Make sure it's not being used on another CPU: */
-	synchronize_hardirq(irq);
+	/*
+	 * Make sure it's not being used on another CPU and if the chip
+	 * supports it also make sure that there is no (not yet serviced)
+	 * interrupt in flight at the hardware level.
+	 */
+	__synchronize_hardirq(desc, true);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
@@ -2589,6 +2617,28 @@ out:
 	irq_put_desc_unlock(desc, flags);
 }
 
+int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
+			    bool *state)
+{
+	struct irq_chip *chip;
+	int err = -EINVAL;
+
+	do {
+		chip = irq_data_get_irq_chip(data);
+		if (chip->irq_get_irqchip_state)
+			break;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+		data = data->parent_data;
+#else
+		data = NULL;
+#endif
+	} while (data);
+
+	if (data)
+		err = chip->irq_get_irqchip_state(data, which, state);
+	return err;
+}
+
 /**
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
@@ -2607,7 +2657,6 @@ int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 {
 	struct irq_desc *desc;
 	struct irq_data *data;
-	struct irq_chip *chip;
 	unsigned long flags;
 	int err = -EINVAL;
 
@@ -2617,19 +2666,7 @@ int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 
 	data = irq_desc_get_irq_data(desc);
 
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (chip->irq_get_irqchip_state)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
-
-	if (data)
-		err = chip->irq_get_irqchip_state(data, which, state);
+	err = __irq_get_irqchip_state(data, which, state);
 
 	irq_put_desc_busunlock(desc, flags);
 	return err;
