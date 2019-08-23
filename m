Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ADAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D692070B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfHXGDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:03:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32790 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfHXGC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so8053208pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F+nj3E/Xs8M7qxtN9qZbU1CEqcrINAxu4k53hreWaAI=;
        b=EVwFOFRCLghWrV0B+Fgrf9sXqIz31luQckRhXbCogqE/cNfM8k73Y6HwKDlmIq8A+G
         HxcNwPCzKijsvwc/Bn+fqZfhonidiEMLuxFuX78RAJBwA17y0sCbzBw0nu4pS6JAgu/I
         K80zgOkAlrkJFSSsAaMQ+qDw2E7o7qVfbNUf6Ta3hZl1V2lRL+J8suLqtOVnaKLoznnB
         b3rcKY9fA2bOQ3lONgofr+nWhtQmbtlFVdJgFaHleHDZEaVDZcV8+xcU/H0FckNlZ7t3
         J506fuTyCqwLIK4SnhCYJRTlNjyNmc4TlGWJ4F0PZAjQX0JIQIBZRZ7SRtvGt5mGQKPf
         qAxA==
X-Gm-Message-State: APjAAAX8QhyRU+smPAdkQFExWpcywLC19839EVNeLf2k03oa7hVVwc3r
        iJ8JaEYNOAS0S2Rj6ic+u8Y=
X-Google-Smtp-Source: APXvYqwoSY1YsQL7ykK2Wm70uU0BpfKji/wNiOEP4B4MY7NXWa87XMT8TEerNMfzR/+iHEWz7ovu3A==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr7190158pgt.365.1566626576692;
        Fri, 23 Aug 2019 23:02:56 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:55 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v4 9/9] x86/mm/tlb: Remove unnecessary uses of the inline keyword
Date:   Fri, 23 Aug 2019 15:41:53 -0700
Message-Id: <20190823224153.15223-10-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is smart enough without these hints.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 3dca146edcf1..0addc6e84126 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -189,7 +189,7 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 	}
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
@@ -741,7 +741,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
 static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
 #endif
 
-static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
+static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int stride_shift, bool freed_tables,
 			u64 new_tlb_gen)
@@ -768,7 +768,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	return info;
 }
 
-static inline void put_flush_tlb_info(void)
+static void put_flush_tlb_info(void)
 {
 #ifdef CONFIG_DEBUG_VM
 	/* Complete reentrency prevention checks */
-- 
2.17.1

