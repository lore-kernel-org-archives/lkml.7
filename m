Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD8CC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318462183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyvDfTTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfDRA4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:56:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45426 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRA43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:56:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so327931pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NCTHDha1xM/aVhgZQjb426tHN47IE4D29YS6s+8P+hI=;
        b=lyvDfTTaK38CqH1AhVyLFO5T4uwMdNwEKxMXlLK6Lpa3f85mFo4McQeMf8zqhAOhXR
         bzNV3fMbnmQTCPuPsop6W2MbELV/HdTm6TOmNhicM5OpKt617ir9uMXZrm/aeE6mqS5L
         oklQjol5CW+xUvNOci0gOlMPa9X3RKaSzvTkVFmkzQY2lWFnqOHn7FxqyQ4Oj0HuraTQ
         48vTGo0JB5aRwV8wjJ5WwkcKvyQZo37HI+uoUGXoZC5IMnUw4yLuM3/v1Buyc4F0Eh3a
         1Y12KICsKkRC1RIdvDEd91/cvpPoYk6CmhGJol4zWVvuRNpJbKCSRXH/I9FAtZxQkgki
         GyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NCTHDha1xM/aVhgZQjb426tHN47IE4D29YS6s+8P+hI=;
        b=c+rnl7lCEihCm2tRmBoDliRR8ubiuFDMRJn1BWRRvfW1sRNVhVPisCmpd0qjzDmYN/
         MMk0UXp62WmZJcRgVI7PMFx73pDXeQTz7lkITkwl/Ng6GURiuHjTI4toKnKhLFKVpp4S
         JDbAbiAetQY/XQSzHXRuWfbVW2pmS+VSsTcf1kIC4vWB3TGnLf7bn0vu8nYhxPYDnZiB
         GeOUPNLUMkZPsRFUwH+aoQUsiU14xnO358FXEddna5GcVX2pajzl/pN1Tat2M4104h6D
         KGli/6xINKuxGWlFLnhr6poghXgVbs1oIXlVavK8ff695NZ40s6AuUlv38lDc+PxWO/X
         S86Q==
X-Gm-Message-State: APjAAAWCHcmgG0yRI0H7N6qM475OfSU1M/7Q2fUz5aSIIAdIllkKwvYK
        cJeSm6pfd/y+Uc2lpAaMdVo=
X-Google-Smtp-Source: APXvYqwzKcJWAZA8gk9S1Rf9zj2fXvswUwesJyaWKSO+DGtnzhnROt1yEAC+FUIf//a2bzMHhUBTCA==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr85610316pgb.302.1555548989107;
        Wed, 17 Apr 2019 17:56:29 -0700 (PDT)
Received: from pcliush.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id p14sm535622pfa.26.2019.04.17.17.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 17:56:28 -0700 (PDT)
From:   damon <liush.damon@gmail.com>
To:     palmer@sifive.com
Cc:     aou@eecs.berkeley.edu, anup.patel@wdc.com, liush.damon@gmail.com,
        rppt@linux.ibm.com, sorear2@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: redefine PTRS_PER_PGD/PTRS_PER_PMD/PTRS_PER_PTE
Date:   Thu, 18 Apr 2019 08:56:15 +0800
Message-Id: <1555548975-7011-1-git-send-email-liush.damon@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the number of addresses to define the relevant macros.

Signed-off-by: damon <liush.damon@gmail.com>
---
 arch/riscv/include/asm/pgtable-32.h | 2 ++
 arch/riscv/include/asm/pgtable-64.h | 3 ++-
 arch/riscv/include/asm/pgtable.h    | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index d61974b7..93607f6 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -17,8 +17,10 @@
 #include <asm-generic/pgtable-nopmd.h>
 #include <linux/const.h>
 
+#define MAX_USER_VA_BITS	32
 /* Size of region mapped by a page global directory */
 #define PGDIR_SHIFT     22
+#define PMD_SHIFT       PGDIR_SHIFT
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
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
index 1141364..d9cb3c8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -33,9 +33,9 @@
 #endif /* CONFIG_64BIT */
 
 /* Number of entries in the page global directory */
-#define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
+#define PTRS_PER_PGD (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
 /* Number of entries in the page table */
-#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
+#define PTRS_PER_PTE   (1 << (PMD_SHIFT - PAGE_SHIFT))
 
 /* Number of PGD entries that a user-mode program can use */
 #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
-- 
1.9.1

