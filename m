Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37CEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BCC21BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfGVS5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:57:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38170 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbfGVS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:13 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUl-0002SO-Ku; Mon, 22 Jul 2019 20:57:11 +0200
Message-Id: <20190722105220.768238809@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 21/25] x86/smp: Enhance native_send_call_func_ipi()
References: <20190722104705.550071814@linutronix.de>
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
-	__cpumask_clear_cpu(smp_processor_id(), allbutself);
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


