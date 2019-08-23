Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A0C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FAB2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHXGCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:02:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39901 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXGCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so7046776pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9qpnddjEpcg5EK8TSQ7WHiEt5YkJmLqg0h/2ymRIff0=;
        b=d4yxqo31yf4FEOqOjGecc/IrzYI/gmPXp3/F0KWQ5X62Y8VXdWeHj9XeGQ8AvfoNRG
         H9i6voOx5TS2wgVtGATcBdAcDQPx4ayWS4/S+7AA9PI4OmXEbUGZOx4F7UaFGFLO/1iY
         GaJja1vrfJiCcw5jXID2JbdG0uH6s/TZCENx8AUYbdbmeTOdilWk1m+pyFxTtn/X6Hxc
         cnmasheQDXgXZrZkeleXyr+PJimcd5rrpUNK7l3rhZSdoLq63tQqKb1AiEvdmTwsyA7G
         Ohra0HJJD2qdl90GvpOZY8vlE9VphM9b8xx7cwlRX741xOKPvI3eqCY+xLMyxMGYVQWC
         UOxg==
X-Gm-Message-State: APjAAAWLdqYhicJMfx9VlaX2UrUu765FO1lMD0lHNio2Sj4wkPPMpVIL
        F06PhKAm3Inx1PhnI+/rPzo=
X-Google-Smtp-Source: APXvYqypOifZ1yufZ3m6nT/AEwi7n+d6AcPc7Vk261t9W1QdRAgtcHzW//cYtkRCS9yt1yfxnhuAsA==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr5578419pgr.62.1566626566996;
        Fri, 23 Aug 2019 23:02:46 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:46 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
Date:   Fri, 23 Aug 2019 15:41:47 -0700
Message-Id: <20190823224153.15223-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
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

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2674f55ed9a1..c3ca3545d78a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -653,11 +653,13 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
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
@@ -701,12 +703,36 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
-		smp_call_function_many(cpumask, flush_tlb_func,
-			       (void *)info, 1);
-	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
-				(void *)info, 1, GFP_ATOMIC, cpumask);
+	if (info->freed_tables) {
+		smp_call_function_many(cpumask, flush_tlb_func, (void *)info, 1);
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
+		smp_call_function_many(cond_cpumask, flush_tlb_func, (void *)info, 1);
+	}
 }
 
 /*
-- 
2.17.1

