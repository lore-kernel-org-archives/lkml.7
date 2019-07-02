Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF68C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0421897
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGCHOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:14:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42245 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfGCHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:14:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so717036pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2mFcMeeg2rlqe6ogUMwdbY/ZnqwhxbuwUlkai/MVFEE=;
        b=dMiL352Hfs+GGD89/KamAPwbt5Me9eY0Gzx8JOa3JCTAyZD6jNSvMzsJkE6vsJSIsn
         SYDtIf4W1gfOINpyMZiclnhWLdrKWSPyCKNbgIFWpTr2wnlu/P5piPWZnmp5ArIuOJmL
         4XnBYAiSq86ayAPk3qWtFOUUmFGkvAvdGjceLaFKy3LQafoI6ilKiIaDhl8xA8rtae/+
         dvMVNRzen16TCszPCDrlAN4m5ep7jQfaJi7lF7ZBLnkOs+Sjnty3sHQ40v+0ExuLtunt
         tNmWPhjWy/aZfGVNF3eOUrT3PjCScJ62+0i1fGp1STWNWfVNcDx41/nZ5XxmB7A1nGBI
         2NSA==
X-Gm-Message-State: APjAAAX3Cgv6Vzr4axlH6U2v6hAv6n/2ZmFJ7pbqqb74IjfbBWaBR8gd
        Mb74IUs24AP3dASm5GFo64Q=
X-Google-Smtp-Source: APXvYqw5vV3O21zW/rXAzHJ9pIMSV9OmHLcHJAc1EuNS2SZp3kQEJYPIo8EDpxrSbqY4jGnr565dzA==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id x15mr10588302pjt.82.1562138045528;
        Wed, 03 Jul 2019 00:14:05 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21sm1256593pfh.86.2019.07.03.00.14.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:14:04 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 2/9] x86/mm/tlb: Remove reason as argument for flush_tlb_func_local()
Date:   Tue,  2 Jul 2019 16:51:44 -0700
Message-Id: <20190702235151.4377-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702235151.4377-1-namit@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use flush_tlb_func_local() as an argument to
__smp_call_function_many() we need it to have a single (void *)
parameter. Eliminate the second parameter and deduce the reason for the
flush.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 91f6db92554c..8a957b58525f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -635,9 +635,12 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
 }
 
-static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
+static void flush_tlb_func_local(void *info)
 {
 	const struct flush_tlb_info *f = info;
+	enum tlb_flush_reason reason;
+
+	reason = (f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN : TLB_LOCAL_MM_SHOOTDOWN;
 
 	flush_tlb_func_common(f, true, reason);
 }
@@ -790,7 +793,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
+		flush_tlb_func_local(info);
 		local_irq_enable();
 	}
 
@@ -862,7 +865,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
+		flush_tlb_func_local(&full_flush_tlb_info);
 		local_irq_enable();
 	}
 
-- 
2.17.1

