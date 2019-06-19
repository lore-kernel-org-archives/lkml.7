Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F156C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B2121479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560930583;
	bh=cIQLRAO7rIi5Bv5S/yL9Ooh+kpELTVwlk4a16wrGacw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xz9nxGdgwvKeS7jXygfrijQWx4NTLwmTnrsIr9o1htEs8S9l5YZWQcLwJX3c/kFxt
	 LbEZWEJTQLZw+7NYpJSb8P41+hVZQz/cbxHh+ytwn+qXT3DfRCF5Ky+EsmiK+MSy8O
	 1Vxso58SmEqmhADT2Vz9nFW7kfDx9gtRwXJTfyHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfFSHtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731287AbfFSHti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:49:38 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD4EC21479;
        Wed, 19 Jun 2019 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560930577;
        bh=cIQLRAO7rIi5Bv5S/yL9Ooh+kpELTVwlk4a16wrGacw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HP6G9pTt1YrEwl4bydXf0UMuJrW6M3JgLElgqKyYRMHuSiCpGBdNJrZadsj2gtVDU
         NwkcGM1YLrynMDYe1duBK6wlyuIHcyz6PJZg7qxX1tO63DoQJPctS2NXEJaOxheQwO
         Gmuv478hcr8EKI9jcgFcM29dMgi2IQBe3clbn2zY=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 4/4] csky: Improve tlb operation with help of asid
Date:   Wed, 19 Jun 2019 15:49:13 +0800
Message-Id: <1560930553-26502-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560930553-26502-1-git-send-email-guoren@kernel.org>
References: <1560930553-26502-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

There are two generations of tlb operation instruction for C-SKY.
First generation is use mcr register and it need software do more
things, second generation is use specific instructions, eg:
 tlbi.va, tlbi.vas, tlbi.alls

We implemented the following functions:

 - flush_tlb_range (a range of entries)
 - flush_tlb_page (one entry)

 Above functions use asid from vma->mm to invalid tlb entries and
 we could use tlbi.vas instruction for newest generation csky cpu.

 - flush_tlb_kernel_range
 - flush_tlb_one

 Above functions don't care asid and it invalid the tlb entries only
 with vpn and we could use tlbi.vaas instruction for newest generat-
 ion csky cpu.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/tlb.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 4 deletions(-)

diff --git a/arch/csky/mm/tlb.c b/arch/csky/mm/tlb.c
index efae81c..eb3ba6c 100644
--- a/arch/csky/mm/tlb.c
+++ b/arch/csky/mm/tlb.c
@@ -10,6 +10,13 @@
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 
+/*
+ * One C-SKY MMU TLB entry contain two PFN/page entry, ie:
+ * 1VPN -> 2PFN
+ */
+#define TLB_ENTRY_SIZE		(PAGE_SIZE * 2)
+#define TLB_ENTRY_SIZE_MASK	(PAGE_MASK << 1)
+
 void flush_tlb_all(void)
 {
 	tlb_invalid_all();
@@ -17,27 +24,148 @@ void flush_tlb_all(void)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
+#ifdef CONFIG_CPU_HAS_TLBI
+	asm volatile("tlbi.asids %0"::"r"(cpu_asid(mm)));
+#else
 	tlb_invalid_all();
+#endif
 }
 
+/*
+ * MMU operation regs only could invalid tlb entry in jtlb and we
+ * need change asid field to invalid I-utlb & D-utlb.
+ */
+#ifndef CONFIG_CPU_HAS_TLBI
+#define restore_asid_inv_utlb(oldpid, newpid) \
+do { \
+	if (oldpid == newpid) \
+		write_mmu_entryhi(oldpid + 1); \
+	write_mmu_entryhi(oldpid); \
+} while (0)
+#endif
+
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	tlb_invalid_all();
+	unsigned long newpid = cpu_asid(vma->vm_mm);
+
+	start &= TLB_ENTRY_SIZE_MASK;
+	end   += TLB_ENTRY_SIZE - 1;
+	end   &= TLB_ENTRY_SIZE_MASK;
+
+#ifdef CONFIG_CPU_HAS_TLBI
+	while (start < end) {
+		asm volatile("tlbi.vas %0"::"r"(start | newpid));
+		start += 2*PAGE_SIZE;
+	}
+	sync_is();
+#else
+	{
+	unsigned long flags, oldpid;
+
+	local_irq_save(flags);
+	oldpid = read_mmu_entryhi() & ASID_MASK;
+	while (start < end) {
+		int idx;
+
+		write_mmu_entryhi(start | newpid);
+		start += 2*PAGE_SIZE;
+		tlb_probe();
+		idx = read_mmu_index();
+		if (idx >= 0)
+			tlb_invalid_indexed();
+	}
+	restore_asid_inv_utlb(oldpid, newpid);
+	local_irq_restore(flags);
+	}
+#endif
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	tlb_invalid_all();
+	start &= TLB_ENTRY_SIZE_MASK;
+	end   += TLB_ENTRY_SIZE - 1;
+	end   &= TLB_ENTRY_SIZE_MASK;
+
+#ifdef CONFIG_CPU_HAS_TLBI
+	while (start < end) {
+		asm volatile("tlbi.vaas %0"::"r"(start));
+		start += 2*PAGE_SIZE;
+	}
+	sync_is();
+#else
+	{
+	unsigned long flags, oldpid;
+
+	local_irq_save(flags);
+	oldpid = read_mmu_entryhi() & ASID_MASK;
+	while (start < end) {
+		int idx;
+
+		write_mmu_entryhi(start | oldpid);
+		start += 2*PAGE_SIZE;
+		tlb_probe();
+		idx = read_mmu_index();
+		if (idx >= 0)
+			tlb_invalid_indexed();
+	}
+	restore_asid_inv_utlb(oldpid, oldpid);
+	local_irq_restore(flags);
+	}
+#endif
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	tlb_invalid_all();
+	int newpid = cpu_asid(vma->vm_mm);
+
+	addr &= TLB_ENTRY_SIZE_MASK;
+
+#ifdef CONFIG_CPU_HAS_TLBI
+	asm volatile("tlbi.vas %0"::"r"(addr | newpid));
+	sync_is();
+#else
+	{
+	int oldpid, idx;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	oldpid = read_mmu_entryhi() & ASID_MASK;
+	write_mmu_entryhi(addr | newpid);
+	tlb_probe();
+	idx = read_mmu_index();
+	if (idx >= 0)
+		tlb_invalid_indexed();
+
+	restore_asid_inv_utlb(oldpid, newpid);
+	local_irq_restore(flags);
+	}
+#endif
 }
 
 void flush_tlb_one(unsigned long addr)
 {
-	tlb_invalid_all();
+	addr &= TLB_ENTRY_SIZE_MASK;
+
+#ifdef CONFIG_CPU_HAS_TLBI
+	asm volatile("tlbi.vaas %0"::"r"(addr));
+	sync_is();
+#else
+	{
+	int oldpid, idx;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	oldpid = read_mmu_entryhi() & ASID_MASK;
+	write_mmu_entryhi(addr | oldpid);
+	tlb_probe();
+	idx = read_mmu_index();
+	if (idx >= 0)
+		tlb_invalid_indexed();
+
+	restore_asid_inv_utlb(oldpid, oldpid);
+	local_irq_restore(flags);
+	}
+#endif
 }
 EXPORT_SYMBOL(flush_tlb_one);
-- 
2.7.4

