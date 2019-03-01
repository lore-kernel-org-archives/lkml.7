Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7001C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7D1218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MOHJiXeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfCAAtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:49:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33951 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCAAtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:49:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id w4so25957035qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3zaAc4AkyYlmNHrBEr4XOgXYMne+k8U/cWFaLP79Juw=;
        b=MOHJiXeGPN8iY0eIT5lF3Mxy5lun1L4+DZDbqOBS02rxnV+dZ1SiS6KZkGj++5xet+
         ZakVbbOHwWlivX0cZ4Vj441ijOwVIiRMfSVqrrgVxC+yP2MZ2HWJJ/TcfYGm55ht0hRo
         BjoXpyhEw3ppAAa8buPCteihj7kxVqNG6QYWfZBTNcQCOQ1wBFfkB+DxbAKc+Xl6jEYb
         kAyJH65nsKLaORU7CRygORAqKpaOpWs9zH8zYLlm3i+nZtuYRVXx7YL54B/2v+qQ0F11
         Xk6sQNKaXlPuyNQL7ti1oxL2MDAUgOMK/YUHUGOiyCg8fTITWaQltlTvSlPJi9uEerol
         Ozww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3zaAc4AkyYlmNHrBEr4XOgXYMne+k8U/cWFaLP79Juw=;
        b=eawcmqXHxxh+9SkEUVyQMbQ0kqZ0ZLToDHfBaVdLIXeMkzmrsWu4VneKUwkUVGj3l+
         NSRQGhZBDa5qFkW7HSdZaIsU6c9A6z3/Rf0rl3pAZlOZSydyERle0RUglXIANUPeEQ3L
         Hf1pPlmX69FwxRD5KLPnlHYAAVN9jh4Agv3mqDqNpj7AL3XkSVUHcFMJfENLD9Kj8s2y
         1eJqusYng5DbN3U7WoLR3wdvdjvU2VvJyrjuURK+sHNwzronTR+Xu/VRL4qnlNMh06bS
         WxHFkrZWP/DTu1KKeHEoanKsNJVAYGK+A4abja5WlmhJu8ekIW2JcJtMyGvXmvjNHod+
         O3Sg==
X-Gm-Message-State: APjAAAXiqzckZEgXlxm6NhXfC+xlr0CRtjWufD1LvsnFgCJw98rvnkVZ
        wvOa9QjfLfUEpxtm5tAMtHFA0Q==
X-Google-Smtp-Source: APXvYqwLalUyIj1++3RJLmJq+1Z9CujJWMbxVlRb9u6ZUDzfDCT+f3+pu+iAuj3b4e3ATUMDdQG6NA==
X-Received: by 2002:ac8:3464:: with SMTP id v33mr1839555qtb.65.1551401354288;
        Thu, 28 Feb 2019 16:49:14 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v26sm12683985qtk.22.2019.02.28.16.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 16:49:13 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/hugepages: fix "orig_pud" set but not used
Date:   Thu, 28 Feb 2019 19:49:03 -0500
Message-Id: <20190301004903.89514-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent
hugepages") introduced pudp_huge_get_and_clear_full() but no one uses
its return code, so just make it void.

mm/huge_memory.c: In function 'zap_huge_pud':
mm/huge_memory.c:1982:8: warning: variable 'orig_pud' set but not used
[-Wunused-but-set-variable]
  pud_t orig_pud;
        ^~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/pgtable.h | 8 ++++----
 mm/huge_memory.c              | 4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 05e61e6c843f..17b789557afe 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -167,11 +167,11 @@ static inline pmd_t pmdp_huge_get_and_clear_full(struct mm_struct *mm,
 #endif
 
 #ifndef __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR_FULL
-static inline pud_t pudp_huge_get_and_clear_full(struct mm_struct *mm,
-					    unsigned long address, pud_t *pudp,
-					    int full)
+static inline void pudp_huge_get_and_clear_full(struct mm_struct *mm,
+						unsigned long address,
+						pud_t *pudp, int full)
 {
-	return pudp_huge_get_and_clear(mm, address, pudp);
+	pudp_huge_get_and_clear(mm, address, pudp);
 }
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index faf357eaf0ce..9f57a1173e6a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1979,7 +1979,6 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
-	pud_t orig_pud;
 	spinlock_t *ptl;
 
 	ptl = __pud_trans_huge_lock(pud, vma);
@@ -1991,8 +1990,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * pgtable_trans_huge_withdraw after finishing pudp related
 	 * operations.
 	 */
-	orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud,
-			tlb->fullmm);
+	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
 	if (vma_is_dax(vma)) {
 		spin_unlock(ptl);
-- 
2.17.2 (Apple Git-113)

