Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3FCC46484
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA81218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfGDQeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfGDQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gQ-0005gz-W4; Thu, 04 Jul 2019 18:34:07 +0200
Message-Id: <20190704155610.049832295@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:03 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 18/25] x86/apic: Provide and use helper for
 send_IPI_allbutself()
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support IPI shorthands wrap invocations of apic->send_IPI_allbutself()
in a helper function, so the static key controlling the shorthand mode is
only in one place.

Fixup all callers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/apic.h |    2 ++
 arch/x86/kernel/apic/ipi.c  |   12 ++++++++++++
 arch/x86/kernel/kgdb.c      |    2 +-
 arch/x86/kernel/reboot.c    |    7 +------
 arch/x86/kernel/smp.c       |    4 ++--
 5 files changed, 18 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -177,6 +177,8 @@ extern void lapic_assign_legacy_vector(u
 extern void lapic_online(void);
 extern void lapic_offline(void);
 
+extern void apic_send_IPI_allbutself(unsigned int vector);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -50,6 +50,18 @@ void apic_smt_update(void)
 		static_branch_enable(&apic_use_ipi_shorthand);
 	}
 }
+
+void apic_send_IPI_allbutself(unsigned int vector)
+{
+	if (num_online_cpus() < 2)
+		return;
+
+	if (static_branch_likely(&apic_use_ipi_shorthand))
+		apic->send_IPI_allbutself(vector);
+	else
+		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+}
+
 #endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -424,7 +424,7 @@ static void kgdb_disable_hw_debug(struct
  */
 void kgdb_roundup_cpus(void)
 {
-	apic->send_IPI_allbutself(VECTOR_NMI);
+	apic_send_IPI_allbutself(VECTOR_NMI);
 }
 #endif
 
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -828,11 +828,6 @@ static int crash_nmi_callback(unsigned i
 	return NMI_HANDLED;
 }
 
-static void smp_send_nmi_allbutself(void)
-{
-	apic->send_IPI_allbutself(NMI_VECTOR);
-}
-
 /*
  * Halt all other CPUs, calling the specified function on each of them
  *
@@ -861,7 +856,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb
 	 */
 	wmb();
 
-	smp_send_nmi_allbutself();
+	apic_send_IPI_allbutself(NMI_VECTOR);
 
 	/* Kick CPUs looping in NMI context. */
 	WRITE_ONCE(crash_ipi_issued, 1);
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -209,7 +209,7 @@ static void native_stop_other_cpus(int w
 		/* sync above data before sending IRQ */
 		wmb();
 
-		apic->send_IPI_allbutself(REBOOT_VECTOR);
+		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
 		 * Don't wait longer than a second if the caller
@@ -233,7 +233,7 @@ static void native_stop_other_cpus(int w
 
 		pr_emerg("Shutting down cpus with NMI\n");
 
-		apic->send_IPI_allbutself(NMI_VECTOR);
+		apic_send_IPI_allbutself(NMI_VECTOR);
 
 		/*
 		 * Don't wait longer than a 10 ms if the caller


