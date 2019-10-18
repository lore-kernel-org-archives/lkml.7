Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D749CA9ECA
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374EF222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="e7FqzvY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408818AbfJRAt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:49:59 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35449 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407271AbfJRAt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:58 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so3959652ilr.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYeo0xAdWe0VE7AGn4vUOp9/RKxdCHKwx1Hu2VD3ZFI=;
        b=e7FqzvY5kEG/Xv9dIUQ1oCTbqcLEHSai2TGkF9G5GOVHJOR/JRSwHHyKyxE9Y+S1Uq
         Hb8dlvw9i96xctpHBYqQBqf2k8TItk5GeFtah91bVmtekmsMQyuy9hvZ1tzGZWmJ7Q3R
         GEgHJm5NtXAKDGR/rADOJZgrY8yLRaSwrpHj7qmYP1C9npIOGGSsJ+sEx/8+SF3AxHF1
         zj95h/38bh57/dIL1N0pBQ8+GEsb3385SjPqW4Z2u+/mmYHQM1sgPI/92NHMZR+yr4pf
         eRB3BIF3i8o0joYNAcCb+1rjlG2oHRXmv5wiiqOCHq94DPnpSd9btuAuXXXApfSK7fB1
         Y/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYeo0xAdWe0VE7AGn4vUOp9/RKxdCHKwx1Hu2VD3ZFI=;
        b=uVMNU0Kc8HLyzsV+LVb71a3tYy72XkzlFA1KYcftWHaPPn53ydYP7n4L0zQPPDtTss
         ypeBIzU8nPJxxK+BoKy6sH4w9JxX5OUc41z45AL6rMg6irZT8tLiBJTb+LJ+eTunrEt7
         IyPp5zlH7I84qSLV7SYjK0jyV72Dz9hzvRBbRlLhw3hnoBgJLMLAleF6pgOitgV+4y9a
         AKHHvesJ2FNto1UbPm76DdfSBNCoHeU2dLI59xlmhl0Zmf7FNQFJf0x1juIflRHmmu+9
         COKLoYR5S3Nm7HLEWiC5drYBBGPXLAIvdoTyALANVUJQ35aYXe4gAZ26SfV86gAQLlh3
         OnGw==
X-Gm-Message-State: APjAAAWNT9EZ9qXydv4j2cm3pWukLZl38SaV/eZ0FzGeXeFlG3jFbOBu
        C8qaetuH+mmWqc2wQiO2Oz52VSf3hNo=
X-Google-Smtp-Source: APXvYqyQCKT5vl5G9xMEmMO1JlNfzDH207v1XKhgNJtHaIqaSHj8HG+prF2g3ggA3i8umXodoDGJGA==
X-Received: by 2002:a92:9f8c:: with SMTP id z12mr7348576ilk.111.1571359797398;
        Thu, 17 Oct 2019 17:49:57 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:57 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] riscv: mark some code and data as file-static
Date:   Thu, 17 Oct 2019 17:49:27 -0700
Message-Id: <20191018004929.3445-7-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions and arrays which are only used in the files in which
they are declared are missing "static" qualifiers.  Warnings for these
symbols are reported by sparse:

arch/riscv/kernel/stacktrace.c:22:14: warning: symbol 'walk_stackframe' was not declared. Should it be static?
arch/riscv/kernel/vdso.c:28:18: warning: symbol 'vdso_data' was not declared. Should it be static?
arch/riscv/mm/init.c:42:6: warning: symbol 'setup_zero_page' was not declared. Should it be static?
arch/riscv/mm/init.c:152:7: warning: symbol 'fixmap_pte' was not declared. Should it be static?
arch/riscv/mm/init.c:211:7: warning: symbol 'trampoline_pmd' was not declared. Should it be static?
arch/riscv/mm/init.c:212:7: warning: symbol 'fixmap_pmd' was not declared. Should it be static?
arch/riscv/mm/init.c:219:7: warning: symbol 'early_pmd' was not declared. Should it be static?
arch/riscv/mm/sifive_l2_cache.c:145:12: warning: symbol 'sifive_l2_init' was not declared. Should it be static?

Resolve these warnings by marking them as static.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/stacktrace.c  |  6 ++++--
 arch/riscv/kernel/vdso.c        |  2 +-
 arch/riscv/mm/init.c            | 12 +++++++-----
 arch/riscv/mm/sifive_l2_cache.c |  2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 0940681d2f68..fd908baed51c 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -19,8 +19,10 @@ struct stackframe {
 	unsigned long ra;
 };
 
-void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-			     bool (*fn)(unsigned long, void *), void *arg)
+static void notrace walk_stackframe(struct task_struct *task,
+				    struct pt_regs *regs,
+				    bool (*fn)(unsigned long, void *),
+				    void *arg)
 {
 	unsigned long fp, sp, pc;
 
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index c9c21e0d5641..e24fccab8185 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -25,7 +25,7 @@ static union {
 	struct vdso_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
+static struct vdso_data *vdso_data = &vdso_data_store.data;
 
 static int __init vdso_init(void)
 {
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe68e94ea946..79cfb35f1e0e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -40,7 +40,7 @@ static void __init zone_sizes_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
-void setup_zero_page(void)
+static void setup_zero_page(void)
 {
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 }
@@ -150,7 +150,7 @@ EXPORT_SYMBOL(pfn_base);
 void *dtb_early_va;
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
+static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 static bool mmu_enabled;
 
 #define MAX_EARLY_MAPPING_SIZE	SZ_128M
@@ -209,15 +209,17 @@ static void __init create_pte_mapping(pte_t *ptep,
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
-pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
+static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
+static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 
 #if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
 #define NUM_EARLY_PMDS		1UL
 #else
 #define NUM_EARLY_PMDS		(1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
 #endif
-pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
+
+#define NUM_EARLY_PMDS_PTRS	(PTRS_PER_PMD * NUM_EARLY_PMDS)
+static pmd_t early_pmd[NUM_EARLY_PMDS_PTRS] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt(phys_addr_t pa)
 {
diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
index 2e637ad71c05..a9ffff3277c7 100644
--- a/arch/riscv/mm/sifive_l2_cache.c
+++ b/arch/riscv/mm/sifive_l2_cache.c
@@ -142,7 +142,7 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 	return IRQ_HANDLED;
 }
 
-int __init sifive_l2_init(void)
+static int __init sifive_l2_init(void)
 {
 	struct device_node *np;
 	struct resource res;
-- 
2.23.0

