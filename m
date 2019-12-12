Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14562C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFB22067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="S2vM1eFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLLPRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:17:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33766 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfLLPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:17:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so1312942pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hw7pbm5ZSn/YgWBhazKTeiCLvFMpKrZ3mbIvcxopwH8=;
        b=S2vM1eFBJ5BtH8zNbmu8DjgSQRleESkKe5JJ86KfwXlSAZVsGV1xwzrWLNLBABM6nC
         3nCHiEDrC97cSMiHlZbzRL5zOCchNNKBn18aky0NarJ5dA1XSEtQKrbYDTGDDHZZ0/fg
         8Yrftimr1c2yf3dNdkhW4XOiMziHanksMcaXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hw7pbm5ZSn/YgWBhazKTeiCLvFMpKrZ3mbIvcxopwH8=;
        b=CkM8MS0TrIzYzpnk3p4PbUM0aN+alfQubRGPs1QrGKOKtMosFqIoM8z5GgJPEeRErP
         34GJQBqJVglBN/2cHbxHFOnbVelxRUjO+qYlXQ+XYblEJu1mz08ESRCgsVVk64TgJm8F
         fq95I5FCXd2/phGF9oRsSVnHgDFzl6Td2tLztLA4IIUP8m69+wKuzGR9h2mvOqcmxGpB
         n5Bz+i4FbFKkP9z/E0x/OeXckDXn4gx8tYVqcMVYG6v7iv3e055na+M/B/3JvogsSPPn
         eXBJ3RPuq/DAdg+JGGmscMA8o9sR7gSKDbO+1x2NEM3Poru4LL2zllSvystxoxQuxgMc
         Focg==
X-Gm-Message-State: APjAAAXjTwrvYEvrsmRdNKKoOlxQxkuqqkWZyrWTQpunWYLrSFaaXnBH
        WKUHf8eNM7Y3X71W0H/GTo6uQvQ3kZ8=
X-Google-Smtp-Source: APXvYqzEdXKvn+N/jgRKT6qMy2CoUs2FPHkLqDRkoyXAaNRKOnYhHOZvNGOZ7lbqgihNler/7RGK+w==
X-Received: by 2002:a63:1106:: with SMTP id g6mr10842363pgl.13.1576163826623;
        Thu, 12 Dec 2019 07:17:06 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b116-2689-a4a9-76f8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b116:2689:a4a9:76f8])
        by smtp.gmail.com with ESMTPSA id d24sm7941034pfq.75.2019.12.12.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 07:17:05 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 1/3] kasan: define and use MAX_PTRS_PER_* for early shadow tables
Date:   Fri, 13 Dec 2019 02:16:54 +1100
Message-Id: <20191212151656.26151-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212151656.26151-1-dja@axtens.net>
References: <20191212151656.26151-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc has a variable number of PTRS_PER_*, set at runtime based
on the MMU that the kernel is booted under.

This means the PTRS_PER_* are no longer constants, and therefore
breaks the build.

Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
As KASAN is the only user at the moment, just define them in the kasan
header, and have them default to PTRS_PER_* unless overridden in arch
code.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Suggested-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 18 +++++++++++++++---
 mm/kasan/init.c       |  6 +++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index e18fe54969e9..70865810d0e7 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,10 +14,22 @@ struct task_struct;
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
 
+#ifndef MAX_PTRS_PER_PTE
+#define MAX_PTRS_PER_PTE PTRS_PER_PTE
+#endif
+
+#ifndef MAX_PTRS_PER_PMD
+#define MAX_PTRS_PER_PMD PTRS_PER_PMD
+#endif
+
+#ifndef MAX_PTRS_PER_PUD
+#define MAX_PTRS_PER_PUD PTRS_PER_PUD
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
-extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
-extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
-extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
+extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE];
+extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
+extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 
 int kasan_populate_early_shadow(const void *shadow_start,
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ce45c491ebcd..8b54a96d3b3e 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -46,7 +46,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
-pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
+pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
 static inline bool kasan_pud_table(p4d_t p4d)
 {
 	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
@@ -58,7 +58,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
 static inline bool kasan_pmd_table(pud_t pud)
 {
 	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
@@ -69,7 +69,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 	return false;
 }
 #endif
-pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
+pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE] __page_aligned_bss;
 
 static inline bool kasan_pte_table(pmd_t pmd)
 {
-- 
2.20.1

