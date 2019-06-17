Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA171C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfFQOoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:44:21 -0400
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:12781 "EHLO
        mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFQOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:44:20 -0400
Received: from yt-mxauth.gw.nic.fujitsu.com (unknown [192.168.229.68]) by mgwym01.jp.fujitsu.com with smtp
         id 1c09_eb57_aa02a947_48dd_4ea2_ab88_ef5a392e83a8;
        Mon, 17 Jun 2019 23:32:58 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id D48F3AC019B;
        Mon, 17 Jun 2019 23:32:57 +0900 (JST)
Received: from G01JPEXCHKW15.g01.fujitsu.local (G01JPEXCHKW15.g01.fujitsu.local [10.0.194.54])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id A8711BD66E6;
        Mon, 17 Jun 2019 23:32:56 +0900 (JST)
Received: from localhost.localdomain (10.17.204.146) by
 G01JPEXCHKW15.g01.fujitsu.local (10.0.194.54) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 23:32:55 +0900
From:   Takao Indoh <indou.takao@jp.fujitsu.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        QI Fuli <qi.fuli@fujitsu.com>,
        "Takao Indoh" <indou.takao@fujitsu.com>
Subject: [PATCH 1/2] arm64: mm: Restore mm_cpumask (revert commit 38d96287504a ("arm64: mm: kill mm_cpumask usage"))
Date:   Mon, 17 Jun 2019 23:32:54 +0900
Message-ID: <20190617143255.10462-2-indou.takao@jp.fujitsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takao Indoh <indou.takao@fujitsu.com>

mm_cpumask was deleted by the commit 38d96287504a ("arm64: mm: kill
mm_cpumask usage") because it was not used at that time. Now this is needed
to find appropriate CPUs for TLB flush, so this patch reverts this commit.

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
Signed-off-by: Takao Indoh <indou.takao@fujitsu.com>
---
 arch/arm64/include/asm/mmu_context.h | 7 ++++++-
 arch/arm64/kernel/smp.c              | 6 ++++++
 arch/arm64/mm/context.c              | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 2da3e478fd8f..21ef11590bcb 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -241,8 +241,13 @@ static inline void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	  struct task_struct *tsk)
 {
-	if (prev != next)
+	unsigned int cpu = smp_processor_id();
+
+	if (prev != next) {
 		__switch_mm(next);
+		cpumask_clear_cpu(cpu, mm_cpumask(prev));
+		local_flush_tlb_mm(prev);
+	}
 
 	/*
 	 * Update the saved TTBR0_EL1 of the scheduled-in task as the previous
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index bb4b3f07761a..12a922d1cdd7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -218,6 +218,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	mmgrab(mm);
 	current->active_mm = mm;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
@@ -320,6 +321,11 @@ int __cpu_disable(void)
 	 */
 	irq_migrate_all_off_this_cpu();
 
+	/*
+	 * Remove this CPU from the vm mask set of all processes.
+	 */
+	clear_tasks_mm_cpumask(cpu);
+
 	return 0;
 }
 
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 1f0ea2facf24..ff3ab2924074 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -188,6 +188,7 @@ static u64 new_context(struct mm_struct *mm)
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
+	cpumask_clear(mm_cpumask(mm));
 	return idx2asid(asid) | generation;
 }
 
@@ -239,6 +240,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 switch_mm_fastpath:
 
 	arm64_apply_bp_hardening();
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
 	/*
 	 * Defer TTBR0_EL1 setting for user threads to uaccess_enable() when
-- 
2.20.1

