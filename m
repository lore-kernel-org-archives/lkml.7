Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53760C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFD221873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfGSA7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:59:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38082 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfGSA7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so14729771plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52ff2sVTRVrMNzSgbFtfzdvqT9duS14nn7AZNdI5P58=;
        b=R0dMofgFuB9tGLyb1bCOmFvWmNVN8OzvG5oXEHtclzZvBA3iGbXjXe8SCiL4QGgmOk
         I4DQi7SDL0puNtRJz9Ck55+VCL4FVgoVOX3RtlKcP4klc+BO8ArPBsFq8Js/oHT4FNDs
         xG4evPzPF7o254jUU2TGIndJYiHvb8dbVV5QqBl4S5x+uWViW2kfY8Cr0YQzutOmwJIe
         7YCzDTTocNI75mERHRm1q4yjSII8AbRfjkvMo1/g1n8LrWUnOfySH2/p8qFik2aUH2kY
         Ffup9BzT1BhjlDeicc5QfPHVtJx5K/yMLdyJbB18pEDmbxQkU5YvOby7oElYVSBUGHqb
         NAHQ==
X-Gm-Message-State: APjAAAVZr2MqI7/CcuoEamzvrtXmOY+vS9RqBneJraHD2NsMUKFQ1KFP
        I3wYFk9EpBlAO3yYT8JziX8=
X-Google-Smtp-Source: APXvYqwgvmFAAZeUOCJVaWzoi5gOB7p0agOZpFL8PR+2GsrX/PxxBRib/dGvzFOHlYO69suenKb+Ow==
X-Received: by 2002:a17:902:1566:: with SMTP id b35mr54832410plh.147.1563497950525;
        Thu, 18 Jul 2019 17:59:10 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.59.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:59:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 9/9] x86/mm/tlb: Remove unnecessary uses of the inline keyword
Date:   Thu, 18 Jul 2019 17:58:37 -0700
Message-Id: <20190719005837.4150-10-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 40daad52ec7d..2ddc32e787f3 100644
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
@@ -748,7 +748,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
 static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
 #endif
 
-static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
+static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int stride_shift, bool freed_tables,
 			u64 new_tlb_gen)
@@ -774,7 +774,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	return info;
 }
 
-static inline void put_flush_tlb_info(void)
+static void put_flush_tlb_info(void)
 {
 #ifdef CONFIG_DEBUG_VM
 	/* Complete reentrency prevention checks */
-- 
2.20.1

