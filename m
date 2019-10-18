Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA93ACA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29B8222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BEa8jHfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505010AbfJRIJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:09:00 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45219 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504985AbfJRII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:08:57 -0400
Received: by mail-il1-f194.google.com with SMTP id u1so4700776ilq.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYeo0xAdWe0VE7AGn4vUOp9/RKxdCHKwx1Hu2VD3ZFI=;
        b=BEa8jHfR8SLog4bfpTOtrnQrMMUZBlhhUaquTKSNM7bfhJ7AOHEXm7j9Zne8jWG/ng
         AnjL8tJG5d1U9kBCJUZxb+aV9smKps16+5fuh+d9GHuWTvfu2FZfyGXWqKFjqa26pG9X
         jaSOi3e62owzJIefigq1rNPMcgEnyafB1+39k8jaXeyuzNrQ6UtSiUFfBczA7kCzhmEe
         dAN9Js/v1W8g0Y0d5bP4Uov1eJQv5kBb6zcUVWaWY7o5SQs459EncVLFAea6MKZYMkV4
         v2tW7buAa3LTtYKfwtkL8z4YFdtNIKHRi9ji6IhD2XzfgUvn6SoRwoNuqnHLEFjI/zwn
         0HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYeo0xAdWe0VE7AGn4vUOp9/RKxdCHKwx1Hu2VD3ZFI=;
        b=c2FefWuMNTFKpR4euSiKJLswUfvZPJ+8UPZqiiynVJtC3FO4anUUciSCum/Ox86P0m
         6fWmK7GLN+UxsucNuXMFOg4TYmkKhwBDghqDMGVIQA1UimgxCXf0a2AXoUwqwoWMU6tN
         jQ4HUN4dEBiAD2m0NXp3aK+dhXZjDOBUpfsfySi++lsl82g+iFkCZuZSPlJXTOkMi76i
         zdwLwDMXkb5lER8CeNoof/t6L93LdVO78jcyc4Ve55ymktcH3W4GUBmbdivZPimqy/kM
         +hcNW/lXt+zN8en+pJgSEo7aPqPgyPR+ueN3/aE+TJYtAwUHXz0mMC0wziWtquapPM6h
         q3dA==
X-Gm-Message-State: APjAAAXd7/YLUdy52SRZaPvNcQA+9WOFdW+U+xFBxCWaavlVq/p+Uuyh
        OlSygzOVDnlo2QkTtJQGGbaDVA==
X-Google-Smtp-Source: APXvYqyuLyK6QOrpyjN95pmAmKgcGMj9sSZrO/kmSBeQ12P0BdNjQwxsuihuLXs59+Es22lnPyDCjw==
X-Received: by 2002:a92:4a05:: with SMTP id m5mr3584987ilf.91.1571386136597;
        Fri, 18 Oct 2019 01:08:56 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:08:56 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] riscv: mark some code and data as file-static
Date:   Fri, 18 Oct 2019 01:08:38 -0700
Message-Id: <20191018080841.26712-6-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018080841.26712-1-paul.walmsley@sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
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

