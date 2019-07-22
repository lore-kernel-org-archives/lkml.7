Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998C6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7419E2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfGVS5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:57:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38191 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbfGVS5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:16 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUn-0002T4-T4; Mon, 22 Jul 2019 20:57:13 +0200
Message-Id: <20190722105221.042964120@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:29 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 24/25] x86/apic/flat64: Remove the IPI shorthand decision
 logic
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of apic->send_IPI_all() and apic->send_IPI_allbutself() contain
the decision logic for shorthand invocation already and invoke
send_IPI_mask() if the prereqisites are not satisfied.

Remove the now redundant decision logic in the APIC code and the duplicate
helper in probe_64.c.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove the decision logic now that it is already done in the callers
    Drop the duplicate helper
---
 arch/x86/include/asm/apic.h         |    4 --
 arch/x86/kernel/apic/apic_flat_64.c |   49 ++++--------------------------------
 arch/x86/kernel/apic/probe_64.c     |    7 -----
 3 files changed, 6 insertions(+), 54 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -468,10 +468,6 @@ static inline unsigned default_get_apic_
 #define TRAMPOLINE_PHYS_LOW		0x467
 #define TRAMPOLINE_PHYS_HIGH		0x469
 
-#ifdef CONFIG_X86_64
-extern void apic_send_IPI_self(int vector);
-#endif
-
 extern void generic_bigsmp_probe(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -76,33 +76,6 @@ flat_send_IPI_mask_allbutself(const stru
 	_flat_send_IPI_mask(mask, vector);
 }
 
-static void flat_send_IPI_allbutself(int vector)
-{
-	int cpu = smp_processor_id();
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || vector == NMI_VECTOR) {
-		if (!cpumask_equal(cpu_online_mask, cpumask_of(cpu))) {
-			unsigned long mask = cpumask_bits(cpu_online_mask)[0];
-
-			if (cpu < BITS_PER_LONG)
-				__clear_bit(cpu, &mask);
-
-			_flat_send_IPI_mask(mask, vector);
-		}
-	} else if (num_online_cpus() > 1) {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-	}
-}
-
-static void flat_send_IPI_all(int vector)
-{
-	if (vector == NMI_VECTOR) {
-		flat_send_IPI_mask(cpu_online_mask, vector);
-	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-	}
-}
-
 static unsigned int flat_get_apic_id(unsigned long x)
 {
 	return (x >> 24) & 0xFF;
@@ -164,9 +137,9 @@ static struct apic apic_flat __ro_after_
 	.send_IPI			= default_send_IPI_single,
 	.send_IPI_mask			= flat_send_IPI_mask,
 	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		= flat_send_IPI_allbutself,
-	.send_IPI_all			= flat_send_IPI_all,
-	.send_IPI_self			= apic_send_IPI_self,
+	.send_IPI_allbutself		= default_send_IPI_allbutself,
+	.send_IPI_all			= default_send_IPI_all,
+	.send_IPI_self			= default_send_IPI_self,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
@@ -216,16 +189,6 @@ static void physflat_init_apic_ldr(void)
 	 */
 }
 
-static void physflat_send_IPI_allbutself(int vector)
-{
-	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
-}
-
-static void physflat_send_IPI_all(int vector)
-{
-	default_send_IPI_mask_sequence_phys(cpu_online_mask, vector);
-}
-
 static int physflat_probe(void)
 {
 	if (apic == &apic_physflat || num_possible_cpus() > 8 ||
@@ -267,9 +230,9 @@ static struct apic apic_physflat __ro_af
 	.send_IPI			= default_send_IPI_single_phys,
 	.send_IPI_mask			= default_send_IPI_mask_sequence_phys,
 	.send_IPI_mask_allbutself	= default_send_IPI_mask_allbutself_phys,
-	.send_IPI_allbutself		= physflat_send_IPI_allbutself,
-	.send_IPI_all			= physflat_send_IPI_all,
-	.send_IPI_self			= apic_send_IPI_self,
+	.send_IPI_allbutself		= default_send_IPI_allbutself,
+	.send_IPI_all			= default_send_IPI_all,
+	.send_IPI_self			= default_send_IPI_self,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -36,13 +36,6 @@ void __init default_setup_apic_routing(v
 		x86_platform.apic_post_init();
 }
 
-/* Same for both flat and physical. */
-
-void apic_send_IPI_self(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
-}
-
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 	struct apic **drv;


