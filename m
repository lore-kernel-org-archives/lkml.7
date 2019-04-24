Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD60C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B87206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCjQK8Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfDXIMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:12:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37431 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDXIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:12:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so8908955pfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Gec7FRhM0jPCKhXUciEsB2cjoFyID0e5GFvyWjnfN4=;
        b=dCjQK8OcVo/BGC+YpF5QV6FTDvl2SzV3/l2XEOsfYJgkMIars4bzVLJPHuJrW1DNXv
         11aWwm8hsIOAeorJ/EOJPZDjbKIiTkRXZaqjdhYDaC2UDTm9kX8eKEeDv1dWYiRyD/+k
         pdEQaj60j5DI8JWWbmjT/NDNFamuZEASVync54AttusmyaFBW+QuYqFHXmFUJXti1M6a
         H7PdQ9ghgGEGhl5bYH4HSNJhVn3oW3JOD6na/I+awwSrAPLMiRClIw/onShGLlRyzcyF
         0UAhU8e8nI64XoL6OCWahJIvJTLfu0czabityXv8MoYUZgxflnqWKwRKQh3AEBl9JOsZ
         fBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Gec7FRhM0jPCKhXUciEsB2cjoFyID0e5GFvyWjnfN4=;
        b=b6Fr3HLirXy+/HOk8k65iTrydm+MhTYWjhH/ESo8vypzjbK9OBa3JLK7dunKtvg5d0
         K7jaZVQztxymcYEm3tt3zCDpn2dhNT0zzaRK3iBhhTkMBYjBOfdoflkdb+8fVTwrdQzI
         SkvRkF05i5OdYUXJ8C0+rZLnRwX/8N22m73JVWZ8z4FBBChSawPMAtuWAuZQvSqyEBNF
         PP/SCLRxIW+APbT2NGWa0kOkCy0Z6aEw3tHSoBkmMcnxqeu/xUBPhnaSl276CCK9ZJW8
         AmXZGb84iBRV2GCPj8nGLX2SvEfZx3gxmz88ZBc0wYXlgCbmv93+nooLvRoI1zh41n+8
         KnmA==
X-Gm-Message-State: APjAAAW8rxYTTMf7MSP3w6qqAyEJ2HEnj7dpxOIrPRA+XFLjrxqSjSJY
        J8tNzH9XE28JM5p1d0+dX+1CVbi6
X-Google-Smtp-Source: APXvYqwsIxdzfP1eNqHUpfaavJFf5wQCyrZyT7TWrKfDB97alOnVEKBAZwYJr0a25tNYojn+R5vlmg==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr28384250pgf.336.1556093525519;
        Wed, 24 Apr 2019 01:12:05 -0700 (PDT)
Received: from pcliush.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id u6sm26930469pfm.10.2019.04.24.01.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 01:12:05 -0700 (PDT)
From:   damon <liush.damon@gmail.com>
To:     palmer@sifive.com
Cc:     aou@eecs.berkeley.edu, anup.patel@wdc.com, liush.damon@gmail.com,
        rppt@linux.ibm.com, sorear2@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: redefine PTRS_PER_PGD/PTRS_PER_PMD/PTRS_PER_PTE
Date:   Wed, 24 Apr 2019 16:11:52 +0800
Message-Id: <1556093512-5006-1-git-send-email-liush.damon@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the number of addresses to define the relevant macros.

Signed-off-by: damon <liush.damon@gmail.com>
---
 arch/riscv/include/asm/pgtable-32.h | 1 +
 arch/riscv/include/asm/pgtable-64.h | 3 ++-
 arch/riscv/include/asm/pgtable.h    | 8 ++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index d61974b7..c9c8ca8 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -17,6 +17,7 @@
 #include <asm-generic/pgtable-nopmd.h>
 #include <linux/const.h>
 
+#define MAX_USER_VA_BITS	32
 /* Size of region mapped by a page global directory */
 #define PGDIR_SHIFT     22
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7aa0ea9..a56d4d0 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -16,6 +16,7 @@
 
 #include <linux/const.h>
 
+#define MAX_USER_VA_BITS	39
 #define PGDIR_SHIFT     30
 /* Size of region mapped by a page global directory */
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
@@ -34,7 +35,7 @@
 #define pmd_val(x)      ((x).pmd)
 #define __pmd(x)        ((pmd_t) { (x) })
 
-#define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
+#define PTRS_PER_PMD    (1 << (PGDIR_SHIFT - PMD_SHIFT))
 
 static inline int pud_present(pud_t pud)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1141364..9148043 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -33,9 +33,13 @@
 #endif /* CONFIG_64BIT */
 
 /* Number of entries in the page global directory */
-#define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
+#define PTRS_PER_PGD (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
 /* Number of entries in the page table */
-#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
+#ifdef __PAGETABLE_PMD_FOLDED
+#define PTRS_PER_PTE   (1 << (PGDIR_SHIFT - PAGE_SHIFT))
+#else
+#define PTRS_PER_PTE   (1 << (PMD_SHIFT - PAGE_SHIFT))
+#endif
 
 /* Number of PGD entries that a user-mode program can use */
 #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
-- 
1.9.1

