Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9953CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F7D2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfGSA7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:59:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46756 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfGSA7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so14712168plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhCXbFBZdBSYAVTLnQXQCobyPbDeP1lcGb6SP8K3wTw=;
        b=MW4kDk+tejqTt2NvoGLlc25Z+oLsDnV+2KWZ97KFq06iRfk5a21ZZnGdInxe5O2c8z
         x4otHAJrhLPcNWGWW1+cpg1Mr5Xj+xuuFf41GkqADQgOJwlOBM4oXATi6lJPr1UizN38
         1lbgqJu+3CZTvvPVq6M+gfnBUJFRnpZ4HCTYdnnPoSzj3Jhh2XcSwrGAxF3CzaY9xKcb
         N8sg4EBcT5dW1/QMmpB6u/HAaDk4loEvjjnjbnV+FBwcbg4PnMRIQsTkjoHighQEVsCI
         qyqAUskOx9wgvPPCV6vY2DqvA+XGpL+mIM52B3SO8UIiup2IE/n4UbW+4Vg8Av38UOLI
         sblQ==
X-Gm-Message-State: APjAAAVPNZTR11hyzm1aQd2mWCVGsUpI4ZJbUB10KaWxylW8ZR/vEevy
        M7M2V/+W7bdjlaIv5lY51Ms=
X-Google-Smtp-Source: APXvYqwrf8krBM7nXmynpUOr9TKiVEiBQmvapeepEP5bDOaGNBv8d4oHjhWTsfuIabIwcjPHG4NxeQ==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr53757985plt.233.1563497942056;
        Thu, 18 Jul 2019 17:59:02 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.59.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:59:01 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
Date:   Thu, 18 Jul 2019 17:58:31 -0700
Message-Id: <20190719005837.4150-4-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open-code on_each_cpu_cond_mask() in native_flush_tlb_others() to
optimize the code. Open-coding eliminates the need for the indirect branch
that is used to call is_lazy(), and in CPUs that are vulnerable to
Spectre v2, it eliminates the retpoline. In addition, it allows to use a
preallocated cpumask to compute the CPUs that should be.

This would later allow us not to adapt on_each_cpu_cond_mask() to
support local and remote functions.

Note that calling tlb_is_not_lazy() for every CPU that needs to be
flushed, as done in native_flush_tlb_multi() might look ugly, but it is
equivalent to what is currently done in on_each_cpu_cond_mask().
Actually, native_flush_tlb_multi() does it more efficiently since it
avoids using an indirect branch for the matter.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 233f3d8308db..abbf55fa8b81 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -658,11 +658,13 @@ static void flush_tlb_func_remote(void *info)
 	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
 }
 
-static bool tlb_is_not_lazy(int cpu, void *data)
+static bool tlb_is_not_lazy(int cpu)
 {
 	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
 }
 
+static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
+
 void native_flush_tlb_others(const struct cpumask *cpumask,
 			     const struct flush_tlb_info *info)
 {
@@ -706,12 +708,38 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables) {
 		smp_call_function_many(cpumask, flush_tlb_func_remote,
 			       (void *)info, 1);
-	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
-				(void *)info, 1, GFP_ATOMIC, cpumask);
+	} else {
+		/*
+		 * Although we could have used on_each_cpu_cond_mask(),
+		 * open-coding it has performance advantages, as it eliminates
+		 * the need for indirect calls or retpolines. In addition, it
+		 * allows to use a designated cpumask for evaluating the
+		 * condition, instead of allocating one.
+		 *
+		 * This code works under the assumption that there are no nested
+		 * TLB flushes, an assumption that is already made in
+		 * flush_tlb_mm_range().
+		 *
+		 * cond_cpumask is logically a stack-local variable, but it is
+		 * more efficient to have it off the stack and not to allocate
+		 * it on demand. Preemption is disabled and this code is
+		 * non-reentrant.
+		 */
+		struct cpumask *cond_cpumask = this_cpu_ptr(&flush_tlb_mask);
+		int cpu;
+
+		cpumask_clear(cond_cpumask);
+
+		for_each_cpu(cpu, cpumask) {
+			if (tlb_is_not_lazy(cpu))
+				__cpumask_set_cpu(cpu, cond_cpumask);
+		}
+		smp_call_function_many(cond_cpumask, flush_tlb_func_remote,
+					 (void *)info, 1);
+	}
 }
 
 /*
@@ -865,7 +893,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(&full_flush_tlb_info);
+		flush_tlb_func_local((void *)&full_flush_tlb_info);
 		local_irq_enable();
 	}
 
-- 
2.20.1

