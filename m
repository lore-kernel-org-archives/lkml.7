Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52098C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C95D22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ICHURx0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfGYOdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:33:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfGYOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:33:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEXPUo1041320
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:33:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEXPUo1041320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065206;
        bh=Aaj0vWujqzqpFjmQS3JzUmdNp9XlQRB0IiBuxqP3Cps=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ICHURx0M+1yVLOYU8z4XN1MKY/CScKDCx7Q3oJSEfG9MElgU9NnbE57RDGcFWbuqF
         meqiCkcJyOLOCmRcGEhs0EanfNeb8jKscCkmYqBg26N3ZCMkuRfXBKF9moSjlXW7kg
         UawtDeWSvSjG7NDyEUfXfKvs414TeeP65eemDUt0DAdj2BgTCNVofuRS8/ykNbxUTo
         uGj7Qh6f05/NBtX0C6SOgAdMDoHq9YmIT15SJ0mSsoUl1cuFcC5ye2ef1sSEC6MpUw
         dmW8Nf/akYpRWyBsuZrax6BQwIlWjd+G8DBKC7LXEVxDcG72pDU+uwP7OjuJrcjeHP
         OdvrLOe3c9+fA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEXPH11041317;
        Thu, 25 Jul 2019 07:33:25 -0700
Date:   Thu, 25 Jul 2019 07:33:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d0a7166bc7ac4feac5c482ebe8b2417aa3302ef4@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20190722105220.677835995@linutronix.de>
References: <20190722105220.677835995@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/smp: Move smp_function_call implementations into
 IPI code
Git-Commit-ID: d0a7166bc7ac4feac5c482ebe8b2417aa3302ef4
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

Commit-ID:  d0a7166bc7ac4feac5c482ebe8b2417aa3302ef4
Gitweb:     https://git.kernel.org/tip/d0a7166bc7ac4feac5c482ebe8b2417aa3302ef4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:25 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:01 +0200

x86/smp: Move smp_function_call implementations into IPI code

Move it where it belongs. That allows to keep all the shorthand logic in
one place.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.677835995@linutronix.de

---
 arch/x86/include/asm/smp.h |  1 +
 arch/x86/kernel/apic/ipi.c | 40 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smp.c      | 40 ----------------------------------------
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e1356a3b8223..e15f364efbcc 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -143,6 +143,7 @@ void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
+void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index f53de3e0145e..eaac65bf58f0 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -62,6 +62,46 @@ void apic_send_IPI_allbutself(unsigned int vector)
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 }
 
+/*
+ * Send a 'reschedule' IPI to another CPU. It goes straight through and
+ * wastes no time serializing anything. Worst case is that we lose a
+ * reschedule ...
+ */
+void native_smp_send_reschedule(int cpu)
+{
+	if (unlikely(cpu_is_offline(cpu))) {
+		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
+		return;
+	}
+	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
+}
+
+void native_send_call_func_single_ipi(int cpu)
+{
+	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
+}
+
+void native_send_call_func_ipi(const struct cpumask *mask)
+{
+	cpumask_var_t allbutself;
+
+	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
+		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+		return;
+	}
+
+	cpumask_copy(allbutself, cpu_online_mask);
+	__cpumask_clear_cpu(smp_processor_id(), allbutself);
+
+	if (cpumask_equal(mask, allbutself) &&
+	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
+		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	else
+		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+
+	free_cpumask_var(allbutself);
+}
+
 #endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b8ad1876a081..b8d4e9c3c070 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -115,46 +115,6 @@
 static atomic_t stopping_cpu = ATOMIC_INIT(-1);
 static bool smp_no_nmi_ipi = false;
 
-/*
- * this function sends a 'reschedule' IPI to another CPU.
- * it goes straight through and wastes no time serializing
- * anything. Worst case is that we lose a reschedule ...
- */
-static void native_smp_send_reschedule(int cpu)
-{
-	if (unlikely(cpu_is_offline(cpu))) {
-		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
-		return;
-	}
-	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
-}
-
-void native_send_call_func_single_ipi(int cpu)
-{
-	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
-}
-
-void native_send_call_func_ipi(const struct cpumask *mask)
-{
-	cpumask_var_t allbutself;
-
-	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-		return;
-	}
-
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
-}
-
 static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
 	/* We are registered on stopping cpu too, avoid spurious NMI */
