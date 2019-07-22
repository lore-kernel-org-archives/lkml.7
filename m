Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC519C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C7822389
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfGVS5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:57:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbfGVS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:11 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUi-0002RO-TU; Mon, 22 Jul 2019 20:57:09 +0200
Message-Id: <20190722105220.386410643@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 17/25] x86/apic: Add static key to Control IPI shorthands
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPI shorthand functionality delivers IPI/NMI broadcasts to all CPUs in
the system. This can have similar side effects as the MCE broadcasting when
CPUs are waiting in the BIOS or are offlined.

The kernel tracks already the state of offlined CPUs whether they have been
brought up at least once so that the CR4 MCE bit is set to make sure that
MCE broadcasts can't brick the machine.

Utilize that information and compare it to the cpu_present_mask. If all
present CPUs have been brought up at least once then the broadcast side
effect is mitigated by disabling regular interrupt/IPI delivery in the APIC
itself and by the cpu_ignore_nmi check at the begin of the NMI handler.

Use a static key to switch between broadcasting via shorthands or sending
the IPI/NMI one by one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h  |    2 ++
 arch/x86/kernel/apic/ipi.c   |   24 +++++++++++++++++++++++-
 arch/x86/kernel/apic/local.h |    6 ++++++
 arch/x86/kernel/cpu/common.c |    2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -505,8 +505,10 @@ extern int default_check_phys_apicid_pre
 
 #ifdef CONFIG_SMP
 bool apic_id_is_primary_thread(unsigned int id);
+void apic_smt_update(void);
 #else
 static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
+static inline void apic_smt_update(void) { }
 #endif
 
 extern void irq_enter(void);
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -5,6 +5,8 @@
 
 #include "local.h"
 
+DEFINE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
@@ -28,7 +30,27 @@ static int __init print_ipi_mode(void)
 	return 0;
 }
 late_initcall(print_ipi_mode);
-#endif
+
+void apic_smt_update(void)
+{
+	/*
+	 * Do not switch to broadcast mode if:
+	 * - Disabled on the command line
+	 * - Only a single CPU is online
+	 * - Not all present CPUs have been at least booted once
+	 *
+	 * The latter is important as the local APIC might be in some
+	 * random state and a broadcast might cause havoc. That's
+	 * especially true for NMI broadcasting.
+	 */
+	if (apic_ipi_shorthand_off || num_online_cpus() == 1 ||
+	    !cpumask_equal(cpu_present_mask, &cpus_booted_once_mask)) {
+		static_branch_disable(&apic_use_ipi_shorthand);
+	} else {
+		static_branch_enable(&apic_use_ipi_shorthand);
+	}
+}
+#endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
 {
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -7,6 +7,9 @@
  * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
  * (c) 2002,2003 Andi Kleen, SuSE Labs.
  */
+
+#include <linux/jump_label.h>
+
 #include <asm/apic.h>
 
 /* APIC flat 64 */
@@ -22,6 +25,9 @@ int x2apic_phys_pkg_id(int initial_apici
 void x2apic_send_IPI_self(int vector);
 
 /* IPI */
+
+DECLARE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
+
 static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 					 unsigned int dest)
 {
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1913,4 +1913,6 @@ void arch_smt_update(void)
 {
 	/* Handle the speculative execution misfeatures */
 	cpu_bugs_smt_update();
+	/* Check whether IPI broadcasting can be enabled */
+	apic_smt_update();
 }


