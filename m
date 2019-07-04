Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D0C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7445D218CA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGDQeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfGDQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:11 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gT-0005iE-1h; Thu, 04 Jul 2019 18:34:09 +0200
Message-Id: <20190704155610.325211809@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 21/25] x86/smp: Enhance native_send_call_func_ipi()
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav noticed that the cpumask allocations in native_send_call_func_ipi()
are noticeable in microbenchmarks.

Use the new cpumask_or_equal() function to simplify the decision whether
the supplied target CPU mask is either equal to cpu_online_mask or equal to
cpu_online_mask except for the CPU on which the function is invoked.

cpumask_or_equal() or's the target mask and the cpumask of the current CPU
together and compares it to cpu_online_mask.

If the result is false, use the mask based IPI function, otherwise check
whether the current CPU is set in the target mask and invoke either the
send_IPI_all() or the send_IPI_allbutselt() APIC callback.

Make the shorthand decision also depend on the static key which enables
shorthand mode. That allows to remove the extra cpumask comparison with
cpu_callout_mask.

Reported-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/apic/ipi.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -83,23 +83,21 @@ void native_send_call_func_single_ipi(in
 
 void native_send_call_func_ipi(const struct cpumask *mask)
 {
-	cpumask_var_t allbutself;
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
+		unsigned int cpu = smp_processor_id();
 
-	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+		if (!cpumask_or_equal(mask, cpumask_of(cpu), cpu_online_mask))
+			goto sendmask;
+
+		if (cpumask_test_cpu(cpu, mask))
+			apic->send_IPI_all(CALL_FUNCTION_VECTOR);
+		else if (num_online_cpus() > 1)
+			apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 		return;
 	}
 
-	cpumask_copy(allbutself, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), allbutself);
-
-	if (cpumask_equal(mask, allbutself) &&
-	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
-		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
-	else
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-
-	free_cpumask_var(allbutself);
+sendmask:
+	apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 }
 
 #endif /* CONFIG_SMP */


