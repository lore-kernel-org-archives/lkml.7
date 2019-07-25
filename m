Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F9C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E4821901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hYxvFG8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfGYOeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:34:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49345 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGYOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:34:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEY9eC1041420
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:34:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEY9eC1041420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065249;
        bh=iYoUH19j4pwqA+H6m+3l13JhH+e6TQIKvuWIlwoBWgA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hYxvFG8NTf/S6vCeAMGhJWAVMiPfq4Xic7W0YGRBgTwvkJMUT1J/GoseF1meaLS/7
         T2Q/Bv90n1fXAC1obtZHS20yo+efASSl6Mq3RWjr6ZJHQssWTMTyh3rULmCcsQSvFo
         F0e5FLmMCXIRBi1WiGJ/rV+XGVvcJuJjuw11mRxwlMldMy9jFOerWRYCHeruyvKrqR
         vTkHJ1rfv6N1WhM4dP+RKFZlCbjL4ySGvqFIvaBtE6vd/oUACdZGBeAZtdfePgfw57
         3dezEwjTRMUxZCthiqfiSqpF/JSjM8p7pOfatgCGTP7j/AfjY7Y6tqiXAOUq+oAR//
         Q37uufYMFXdAw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEY8Yl1041416;
        Thu, 25 Jul 2019 07:34:08 -0700
Date:   Thu, 25 Jul 2019 07:34:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-832df3d47badcbc860aef617105b6bc1c9459304@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, namit@vmware.com,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, namit@vmware.com,
          peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190722105220.768238809@linutronix.de>
References: <20190722105220.768238809@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/smp: Enhance native_send_call_func_ipi()
Git-Commit-ID: 832df3d47badcbc860aef617105b6bc1c9459304
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

Commit-ID:  832df3d47badcbc860aef617105b6bc1c9459304
Gitweb:     https://git.kernel.org/tip/832df3d47badcbc860aef617105b6bc1c9459304
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:26 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:01 +0200

x86/smp: Enhance native_send_call_func_ipi()

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.768238809@linutronix.de

---
 arch/x86/kernel/apic/ipi.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index eaac65bf58f0..117ee2323f59 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -83,23 +83,21 @@ void native_send_call_func_single_ipi(int cpu)
 
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
