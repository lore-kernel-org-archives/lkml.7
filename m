Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A5C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87942184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGSA7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:59:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37156 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfGSA7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so13386956pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1sm9mhwP26+QnRayYXabG3U+1e73/drVapKRImJlZE=;
        b=R3A8QgQLceDgCo2/ZgKsVVVoVKHnVHPNiZdj3CX8Jy3hOgN5n2fxU7GDzqL36wgC5e
         0givLqOIeSkk+y3pbhsdV4Z2yCD3iEj2CysZGR5KC7UQnptlz3E8ejEzyR2LH44XUaxo
         +kkQvpYFsBXwjdv49BkcNYiqMuushGSsfxRTiP6ey8RhT08VkLRUxl4rsraOHCUg02nF
         JJMbm2CUEaq7uCDUESO0/KRNMUVpXdHHNodFZaJDqqiHacolozLlEDERs8vdgWmtHRn5
         dfTDWmShE+5dV9Bm45dda6UqHVVVuw5uY+8w+QgqqG9/GFmIUnkfaJgTA8AV3ndYI25a
         /bYg==
X-Gm-Message-State: APjAAAUULTp5tmnWbfnI2WxH/mU0GtxQjURamgmNv5ZQJhGoVSSCnVCy
        4FZXbzYrObYUtCNj+G6xj6C0mpi2TE0=
X-Google-Smtp-Source: APXvYqwSK0BSakzW6YgOFWXbS4YOo0Ip8pAqocXt2l9bwy0yeeViaAT8pxqfC5IMoOtQruSQ+trPAQ==
X-Received: by 2002:a17:90a:ff17:: with SMTP id ce23mr54148261pjb.47.1563497940792;
        Thu, 18 Jul 2019 17:59:00 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.58.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:58:59 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 2/9] x86/mm/tlb: Remove reason as argument for flush_tlb_func_local()
Date:   Thu, 18 Jul 2019 17:58:30 -0700
Message-Id: <20190719005837.4150-3-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 4de9704c4aaf..233f3d8308db 100644
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
2.20.1

