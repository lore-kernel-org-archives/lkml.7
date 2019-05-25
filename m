Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5BC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7791D2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEYIW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:22:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39634 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfEYIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:22:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so6315572pgi.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lw/xJ4sUfF0PL59NitOOD48j0ji7hMX9XqzlL67vWpw=;
        b=dcX1JF1FKOZ3q1jP7SG8Ulye9UVGJ/hXN0Y0/2Q+lCs28IN7DQqV3szmLuxKrjwksy
         /fJy95HzGD7+3nxE6Ab76GzH/feqr1JeZ6D70GspeG4IYX0awZ9HdSxLr/hVEnQ33yZi
         kDfP9/Q1/D3xTTRmZhIh363JgzEc6hUuab7B4a6IufF2vlyPPFz4lm+akpJUPJXXUH2B
         AQviHBIN2XLtIj/NM7faE6TaS2LagR7AvcOjjrhA4Y2jZwlEvnJJSC1hApPXOCfj/wic
         Siji/W0Ss9v3HAAL0g770iKuG4DWp/m96+16BvTDbWsmNer4BMmJ/izGJMlCd0bXsFq0
         A50g==
X-Gm-Message-State: APjAAAUJq/5yQLD/n0l7jGimU6vJuIRM8HW5Fc57uxmoRLMI6SEUJQVT
        zGnDT91SrqsyiQnF6tqega4=
X-Google-Smtp-Source: APXvYqzBQ9GJkI0BWP3riaWPFK53g4fBElfc1WO1ZBxM5pxKJO82V+q0u1+75Gd2x4rDCd+eYVJnvg==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr107898610pgi.84.1558772532865;
        Sat, 25 May 2019 01:22:12 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e4sm1438505pgi.80.2019.05.25.01.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 01:22:11 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [RFC PATCH 4/6] x86/mm/tlb: Refactor common code into flush_tlb_on_cpus()
Date:   Sat, 25 May 2019 01:22:01 -0700
Message-Id: <20190525082203.6531-5-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525082203.6531-1-namit@vmware.com>
References: <20190525082203.6531-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_tlbbatch_flush() and flush_tlb_mm_range() have very similar code,
which is effectively the same. Extract the mutual code into a new
function flush_tlb_on_cpus().

There is one functional change, which should not affect correctness:
flush_tlb_mm_range compared loaded_mm and the mm to figure out if local
flush is needed. Instead, the common code would look at the mm_cpumask()
which should give the same result. Performance should not be affected,
since this cpumask should not change in such a frequency that would
introduce cache contention.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 55 ++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7f61431c75fb..afd2859a6966 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -733,7 +733,11 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned int stride_shift, bool freed_tables,
 			u64 new_tlb_gen)
 {
-	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
+	struct flush_tlb_info *info;
+
+	preempt_disable();
+
+	info = this_cpu_ptr(&flush_tlb_info);
 
 #ifdef CONFIG_DEBUG_VM
 	/*
@@ -761,6 +765,23 @@ static inline void put_flush_tlb_info(void)
 	barrier();
 	this_cpu_dec(flush_tlb_info_idx);
 #endif
+	preempt_enable();
+}
+
+static void flush_tlb_on_cpus(const cpumask_t *cpumask,
+			      const struct flush_tlb_info *info)
+{
+	int this_cpu = smp_processor_id();
+
+	if (cpumask_test_cpu(this_cpu, cpumask)) {
+		lockdep_assert_irqs_enabled();
+		local_irq_disable();
+		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
+		local_irq_enable();
+	}
+
+	if (cpumask_any_but(cpumask, this_cpu) < nr_cpu_ids)
+		flush_tlb_others(cpumask, info);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
@@ -769,9 +790,6 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 {
 	struct flush_tlb_info *info;
 	u64 new_tlb_gen;
-	int cpu;
-
-	cpu = get_cpu();
 
 	/* Should we flush just the requested range? */
 	if ((end == TLB_FLUSH_ALL) ||
@@ -786,18 +804,9 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
 				  new_tlb_gen);
 
-	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
-		lockdep_assert_irqs_enabled();
-		local_irq_disable();
-		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
-		local_irq_enable();
-	}
-
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), info);
+	flush_tlb_on_cpus(mm_cpumask(mm), info);
 
 	put_flush_tlb_info();
-	put_cpu();
 }
 
 
@@ -832,13 +841,11 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		struct flush_tlb_info *info;
 
-		preempt_disable();
 		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
 
 		on_each_cpu(do_kernel_range_flush, info, 1);
 
 		put_flush_tlb_info();
-		preempt_enable();
 	}
 }
 
@@ -856,21 +863,11 @@ static const struct flush_tlb_info full_flush_tlb_info = {
 
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	int cpu = get_cpu();
-
-	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
-		lockdep_assert_irqs_enabled();
-		local_irq_disable();
-		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
-		local_irq_enable();
-	}
-
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, &full_flush_tlb_info);
+	preempt_disable();
+	flush_tlb_on_cpus(&batch->cpumask, &full_flush_tlb_info);
+	preempt_enable();
 
 	cpumask_clear(&batch->cpumask);
-
-	put_cpu();
 }
 
 static ssize_t tlbflush_read_file(struct file *file, char __user *user_buf,
-- 
2.20.1

