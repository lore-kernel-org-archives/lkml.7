Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD67C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15022491F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEaGh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39996 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfEaGhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so5557918pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cHAe+Cc9EZywy9mFCxxE1VGk9R752a9j3rJ2WfFTzM=;
        b=dUEsLdakEW8GKvl+684eBngzjL/fcYx8/tceyhSdS98a+Z9P/14dG8Suo+BAeKyUez
         hyPyEIIivL2Oq0ngN8218VigEdUeZXJiNwm3XG26qGmUu7ICrwJfW3+3O3XNBUAx3ftt
         rvcjrPtfroNglk/qjkiIgjwckdG+tY2/QM+UGpeZz9v2agruynN6g5VJVGY09bS5U+Xu
         h5d8vzZedbYxJyoGfwUVEuKsjzByq4O681SnoIlKMk6G6V9DTWN8T5PICQuXV4D9W6g7
         MjaCnMtUK3WV5OvD0gjEDBv9Nu6exK5vioE7Hq3+2s3qRzhOHV2U5+Gl9D5UvsqicMpO
         qG5A==
X-Gm-Message-State: APjAAAUBZY8U3R7mVxcQWjjXjpeZPdgaI/VohYh5Rc7mm/5GLQ9peuBB
        64dSAF9H5220uv2qJ+5hhw8=
X-Google-Smtp-Source: APXvYqxaKyl0Ta7HqpqIWxa9M/iNdzEjv6ZNCN7bb+4zw1uAiMN1AUzNXDOYyeaa05+U4jqYDJiDEA==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr7277360pgi.438.1559284633776;
        Thu, 30 May 2019 23:37:13 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:37:13 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages for flushing
Date:   Thu, 30 May 2019 23:36:44 -0700
Message-Id: <20190531063645.4697-12-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we flush userspace mappings, we can defer the TLB flushes, as long
the following conditions are met:

1. No tables are freed, since otherwise speculative page walks might
   cause machine-checks.

2. No one would access userspace before flush takes place. Specifically,
   NMI handlers and kprobes would avoid accessing userspace.

Use the new SMP support to execute remote function calls with inlined
data for the matter. The function remote TLB flushing function would be
executed asynchronously and the local CPU would continue execution as
soon as the IPI was delivered, before the function was actually
executed. Since tlb_flush_info is copied, there is no risk it would
change before the TLB flush is actually executed.

Change nmi_uaccess_okay() to check whether a remote TLB flush is
currently in progress on this CPU by checking whether the asynchronously
called function is the remote TLB flushing function. The current
implementation disallows access in such cases, but it is also possible
to flush the entire TLB in such case and allow access.

When page-tables are freed or when kernel PTEs are removed, perform
synchronous TLB flushes. But still inline the data with the IPI data,
although the performance gains in this case are likely to be much
smaller.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
 arch/x86/mm/tlb.c               | 15 +++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index a1fea36d5292..75e4c4263af6 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -245,6 +245,10 @@ struct tlb_state_shared {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 
+DECLARE_PER_CPU(smp_call_func_t, async_func_in_progress);
+
+extern void flush_tlb_func_remote(void *info);
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
@@ -259,6 +263,14 @@ static inline bool nmi_uaccess_okay(void)
 
 	VM_WARN_ON_ONCE(!loaded_mm);
 
+	/*
+	 * If we are in the middle of a TLB flush, access is not allowed. We
+	 * could have just flushed the entire TLB and allow access, but it is
+	 * easier and safer just to disallow access.
+	 */
+	if (this_cpu_read(async_func_in_progress) == flush_tlb_func_remote)
+		return false;
+
 	/*
 	 * The condition we want to check is
 	 * current_mm->pgd == __va(read_cr3_pa()).  This may be slow, though,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 755b2bb3e5b6..fd7e90adbe43 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -644,7 +644,7 @@ static void flush_tlb_func_local(void *info)
 	flush_tlb_func_common(f, true, reason);
 }
 
-static void flush_tlb_func_remote(void *info)
+void flush_tlb_func_remote(void *info)
 {
 	const struct flush_tlb_info *f = info;
 
@@ -730,7 +730,7 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 */
 	if (info->freed_tables)
 		__smp_call_function_many(cpumask, flush_tlb_func_remote,
-					 flush_tlb_func_local, (void *)info, 1);
+				flush_tlb_func_local, (void *)info, sizeof(*info), 1);
 	else {
 		/*
 		 * Although we could have used on_each_cpu_cond_mask(),
@@ -753,8 +753,10 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
 			if (tlb_is_not_lazy(cpu))
 				__cpumask_set_cpu(cpu, cond_cpumask);
 		}
+
 		__smp_call_function_many(cond_cpumask, flush_tlb_func_remote,
-					 flush_tlb_func_local, (void *)info, 1);
+					 flush_tlb_func_local, (void *)info,
+					 sizeof(*info), 0);
 	}
 }
 
@@ -915,7 +917,12 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 
 		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
 
-		on_each_cpu(do_kernel_range_flush, info, 1);
+		/*
+		 * We have to wait for the remote shootdown to be done since it
+		 * is kernel space.
+		 */
+		__on_each_cpu_mask(cpu_online_mask, do_kernel_range_flush,
+				   info, sizeof(*info), 1);
 
 		put_flush_tlb_info();
 	}
-- 
2.20.1

