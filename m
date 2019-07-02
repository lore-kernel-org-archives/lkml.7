Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033E7C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFD32187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfGCHOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:14:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38776 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGCHOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:14:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so769892pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oNzMSmaWLx00il8JQPTjgh6sfAflPGpRegLNDDXyJJ0=;
        b=ZiNslELQW1Xi/9nWDIIa/YrLX0YbpO1YLxeDZEAJs82gmIEzCESa+nOejJ5cO9h36g
         1ARSQM1LjMZ4fpHSwh5nbIjdpz3Q8Ai+aTFNCLWjncvSZJE1KB1ReFesz+odO9csJrpZ
         XgbSfx/MrnHT4pJm10j2WogsBEbeg7mUNiohCoEgEIsOgnBrNJncH4fZKW7AZoeSy6T3
         zkK07kX4T+e3U/Y5wv3anBhM81sJ/KV2XR6nvmN+fwzBIcPgaJfeJAVSX5WiPK3LWnwU
         PLBGPUd23NDjc8Ke/Bc6oQaVYXdGh0Bqj9aDrgyHcLkNGXW6Pn+78yjH8lB29wxnyP4N
         pqOw==
X-Gm-Message-State: APjAAAV39pLgL1nhhZK/Pke0Cnve6H2ezfqmrKPMSbJ80USVZ1vgPLCn
        hM9NCqOIuIgvnAxH/2R513QtELM0454ibg==
X-Google-Smtp-Source: APXvYqwnXy/YAQLW1AU5yI6w9vIkMqRRYpziNNF5aBDNrzdEo8lUlhjjiRwz4nDX+JD0+tpQiSIBJw==
X-Received: by 2002:a65:498c:: with SMTP id r12mr34526449pgs.27.1562138054782;
        Wed, 03 Jul 2019 00:14:14 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21sm1256593pfh.86.2019.07.03.00.14.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:14:14 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 9/9] x86/mm/tlb: Remove unnecessary uses of the inline keyword
Date:   Tue,  2 Jul 2019 16:51:51 -0700
Message-Id: <20190702235151.4377-10-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702235151.4377-1-namit@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is smart enough without these hints.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 64afe1215495..48a3d4453e50 100644
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
@@ -753,7 +753,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
 static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
 #endif
 
-static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
+static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int stride_shift, bool freed_tables,
 			u64 new_tlb_gen)
@@ -779,7 +779,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	return info;
 }
 
-static inline void put_flush_tlb_info(void)
+static void put_flush_tlb_info(void)
 {
 #ifdef CONFIG_DEBUG_VM
 	/* Complete reentrency prevention checks */
-- 
2.17.1

