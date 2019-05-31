Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84466C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598562646F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfEaGhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35175 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfEaGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id t1so3481925pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0WRW/Kt/AIwleAaIBXC73QurXubTlVRqc1nj0oe3EQ=;
        b=doLWHHI5xVG30JCu21WTbDvOht6qJU/8enCZjahuiwL/Gdw4gQyMFeWaBlEodp6kbG
         G0Xzv2zHj2es6PEvXnjG3igYZLY6vV9CMC0+P5yk/vNqUNDhOaww1r3b8HMZpMIurqTX
         39plxAJDE02y3FpaMz5woHsyitdWCKSfyA6Szku6qVQX+AnEuP3Zx7iMHkIeXovpQPat
         CK7IuXojSCOAu/uTCMmxOQkH/tPUAoaQH+4ITiCxI9nEzBiScU1GzsjAuWlA81LdGrOz
         Yx+GxhCVEOXmJkxjnfPIRGjoiVlJL3vhvDzR7fCd68rIsbwLsWfqDPOSsV5L1tB4UQIS
         GJbQ==
X-Gm-Message-State: APjAAAVGuEZKzVWFE+T1yMFiXxaP2MqeFbPQkV1dd+QPdqv8EU1NcwzP
        7nD3KunIkX4U/JLjczXi48k=
X-Google-Smtp-Source: APXvYqyBh27ZMnEcB/90TQtV+HJjubiQugyfIf1HeG0YgujFcOJAydhA87adZ1olre4n9PgjfbYHHg==
X-Received: by 2002:a17:90a:cb10:: with SMTP id z16mr7031982pjt.81.1559284635358;
        Thu, 30 May 2019 23:37:15 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:37:14 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@surriel.com>
Subject: [RFC PATCH v2 12/12] x86/mm/tlb: Reverting the removal of flush_tlb_info from stack
Date:   Thu, 30 May 2019 23:36:45 -0700
Message-Id: <20190531063645.4697-13-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partially revert 3db6d5a5eca ("x86/mm/tlb: Remove 'struct
flush_tlb_info' from the stack").

Now that we copy flush_tlb_info and inline it with the IPI information,
we can put it back onto the stack. This simplifies the code and should be
slightly more robust. The stack is also a bit more likely to be cached
than a global variable.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index fd7e90adbe43..81170fd6b1dd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -827,15 +827,17 @@ static inline void put_flush_tlb_info(void)
 static void flush_tlb_on_cpus(const cpumask_t *cpumask,
 			      const struct flush_tlb_info *info)
 {
-	int this_cpu = smp_processor_id();
 	bool flush_others = false;
+	int this_cpu;
+
+	this_cpu = get_cpu();
 
 	if (cpumask_any_but(cpumask, this_cpu) < nr_cpu_ids)
 		flush_others = true;
 
 	if (static_branch_likely(&flush_tlb_multi_enabled) && flush_others) {
 		flush_tlb_multi(cpumask, info);
-		return;
+		goto out;
 	}
 
 	if (cpumask_test_cpu(this_cpu, cpumask)) {
@@ -847,27 +849,33 @@ static void flush_tlb_on_cpus(const cpumask_t *cpumask,
 
 	if (flush_others)
 		flush_tlb_others(cpumask, info);
+
+out:
+	put_cpu();
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables)
 {
-	struct flush_tlb_info *info;
-	u64 new_tlb_gen;
+	struct flush_tlb_info info = {
+		.mm		= mm,
+		.stride_shift	= stride_shift,
+		.freed_tables	= freed_tables,
+	};
 
 	/* Should we flush just the requested range? */
 	if ((end == TLB_FLUSH_ALL) ||
 	    ((end - start) >> stride_shift) > tlb_single_page_flush_ceiling) {
-		start = 0;
-		end = TLB_FLUSH_ALL;
+		info.start = 0;
+		info.end = TLB_FLUSH_ALL;
+	} else {
+		info.start = start;
+		info.end = end;
 	}
 
 	/* This is also a barrier that synchronizes with switch_mm(). */
-	new_tlb_gen = inc_mm_tlb_gen(mm);
-
-	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
-				  new_tlb_gen);
+	info.new_tlb_gen = inc_mm_tlb_gen(mm);
 
 	/*
 	 * Assert that mm_cpumask() corresponds with the loaded mm. We got one
@@ -878,9 +886,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 			(mm == this_cpu_read(cpu_tlbstate.loaded_mm)) ||
 			mm == &init_mm);
 
-	flush_tlb_on_cpus(mm_cpumask(mm), info);
-
-	put_flush_tlb_info();
+	flush_tlb_on_cpus(mm_cpumask(mm), &info);
 }
 
 
@@ -913,18 +919,18 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
 		on_each_cpu(do_flush_tlb_all, NULL, 1);
 	} else {
-		struct flush_tlb_info *info;
-
-		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
+		struct flush_tlb_info info = {
+			.mm		= NULL,
+			.start		= start,
+			.end		= end,
+		};
 
 		/*
 		 * We have to wait for the remote shootdown to be done since it
 		 * is kernel space.
 		 */
 		__on_each_cpu_mask(cpu_online_mask, do_kernel_range_flush,
-				   info, sizeof(*info), 1);
-
-		put_flush_tlb_info();
+				   &info, sizeof(info), 1);
 	}
 }
 
@@ -942,9 +948,7 @@ static const struct flush_tlb_info full_flush_tlb_info = {
 
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	preempt_disable();
 	flush_tlb_on_cpus(&batch->cpumask, &full_flush_tlb_info);
-	preempt_enable();
 
 	cpumask_clear(&batch->cpumask);
 }
-- 
2.20.1

