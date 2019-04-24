Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE1DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD86F218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSYYeM2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfDXHv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:51:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41905 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfDXHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:51:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so8868110pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MUzBcZSYyjNmVAln4pH9+hDa+BhI195V73WdadLwrkU=;
        b=WSYYeM2z+eSgl8RJu1kf4xsUmWL7TbV5E6Ksim/kAqfLPjA9PZ2Ruuvb75pEEBqmaO
         hmWO8ZJfjNoZbzzYPXrRpUjgt+lJD3bGSmVjVYN2/NEqvqoD8j0iKTDs2o+VhkFoWGds
         2h1UGZnLo647Fkru6r8zZyfQfjZNFXTKr9jQeyHFnKf7ysfUwJ7XjFtutT1KGrKFfwRs
         +1WMMPH3DzHK5klPDLqH4FpXyp+8fnxG4KLx4sguNKZYUyYmi4AeFPShJ9wO/0d1Aky0
         sdobm3ERFskuhlTX5kM4GeTCYdI9x1W8Jb5znHsCNaQYZE9DWOvN6IULgWk6dDXp8VfP
         Tagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MUzBcZSYyjNmVAln4pH9+hDa+BhI195V73WdadLwrkU=;
        b=MC9ilCj33wD/atcWKFdJEWGHqJr2H0zcZd+kQCYbimazJCT4Zm06ZTt40ec2THEK8W
         BRGVkt2GYFm3b4fen/igHlWUY2qceM4iUR9ByteCB+D9ctgd7N8ZjbZy5UEhVbbBSvom
         nLSBOzdO/+elD0+HaiOREeID23ZXK+Js4SqFGQN4kYpVnd5Ag2WSo4/q2aK9O4Vg96SJ
         j3d/leVc34eItF9Ka4EykX9CtEUgoAr6Rlpkz1zfCE1nXzazliNFFHgEgVW3+LrdanP5
         4lML6+DUvWJCRsX8/wX7dU5Ydg8jNKo86rKtDv1OqML2NxfJLWhrIq8wyMU7PpSEw8lO
         bcPw==
X-Gm-Message-State: APjAAAU+fbXJj6w5q1uS8kUYmp32YErh84aYwWByXugBTtcl/ao6/2Hq
        SGPKe7Bzf7SDWCqJ+EonuAI=
X-Google-Smtp-Source: APXvYqxujmGRGHIEdw7D/0pkEzjunqAgdRRM4DDeb4gBYviMbCW/tf7YM7mgvUfEu4nd/i+ZrtWk2g==
X-Received: by 2002:a63:6e88:: with SMTP id j130mr6603072pgc.452.1556092285074;
        Wed, 24 Apr 2019 00:51:25 -0700 (PDT)
Received: from pcliush.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id y23sm26230823pfn.25.2019.04.24.00.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 00:51:24 -0700 (PDT)
From:   damon <liush.damon@gmail.com>
To:     palmer@sifive.com
Cc:     aou@eecs.berkeley.edu, anup.patel@wdc.com, liush.damon@gmail.com,
        rppt@linux.ibm.com, sorear2@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: redefine PTRS_PER_PGD/PTRS_PER_PMD/PTRS_PER_PTE
Date:   Wed, 24 Apr 2019 15:51:08 +0800
Message-Id: <1556092268-4646-1-git-send-email-liush.damon@gmail.com>
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
 arch/riscv/include/asm/pgtable.h    | 8 ++++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index d61974b7..433886b 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -17,6 +17,8 @@
 #include <asm-generic/pgtable-nopmd.h>
 #include <linux/const.h>
 
+#define __PAGETABLE_PMD_FOLDED    1
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

