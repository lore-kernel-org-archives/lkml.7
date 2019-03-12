Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA5C10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9BC2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oedD/egg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfCLA6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:58:20 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:53162 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfCLA6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:58:08 -0400
Received: by mail-it1-f201.google.com with SMTP id z131so786209itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=srduQGUMd+1T0rMo1nAAhODDuDFnWSZKCOfw6uJonls=;
        b=oedD/eggmV+SIgYB11JrwAoZLhFWdb50S/XNtFqL8BtNX+SDe5Glssl7AopEbDqcNA
         HCKLJ/V3bjISgT2y2KxWp3VykVnCmF5Y6Eu7pAUj8ZigjSaNi2yJ90jUlcOctuxB1Fbm
         A3C127QaAa54k+3O0L7KF5QaqVgnfjPJr6a85bI04USgXp04seBuyvB1LjH9V5YVSO4n
         9poZ+ZPTh65xeVRUyWd030y18tK6PcucnaLZg/I1TUKe2kC6W9D9AdSqG6CQmwyqYYKV
         4olxX5RbFrrKkNYKcwWg7HTaRF8nnkjP+yLqbV7GoSTMRn558HpMjY8QWgCmjB5DLMAj
         nSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=srduQGUMd+1T0rMo1nAAhODDuDFnWSZKCOfw6uJonls=;
        b=tB0Hi8UyPjVRw1Fia51cI1dZKsHTTLBnzaa4vFxgI2VdYE6aAgTNnH9fp6FnluaWw+
         GnX7lx6eNY2J9o24PFFaBntaqSbqzNQIjLzq0tdJgEFCQkn/VE6vdE08GN3iOPQ2FxSW
         4E/A5yql2KTzHMes22FjmMQ1YgKRCilDAq3olq0ZH/HZ6iG5ljHRcms904Cs1YBKDD/O
         PMBDbP8eFbtDyS7CmSXWkEjDzvT/0Lc+y1p+iYjOI0HhFPjHc+98S9CeTmw3nfedGyqT
         u6lLAMKlZe2Wdi2+e7mvBV0Q6PF886krwowOJmPG9xAJUdk729scp9jxUNNe+Fyp1U9o
         lYWw==
X-Gm-Message-State: APjAAAXl3sijyUxOQi1Hop98H+3KdX2l0lCkNedMUnFtE8t8dFvvv4YU
        HaRzgvsHrmoZkL+s1LtPsbJxry5WZLU=
X-Google-Smtp-Source: APXvYqxqCOwYBxF/7ICjEeopmZPTb2uYLa3V2NjdBJYx9miVxqzRT+/6zNK7zIhloXUYTCZtvdQJhkLhhWk=
X-Received: by 2002:a24:e984:: with SMTP id f126mr583102ith.1.1552352287403;
 Mon, 11 Mar 2019 17:58:07 -0700 (PDT)
Date:   Mon, 11 Mar 2019 18:57:48 -0600
In-Reply-To: <20190312005749.30166-1-yuzhao@google.com>
Message-Id: <20190312005749.30166-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20190310011906.254635-1-yuzhao@google.com> <20190312005749.30166-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v4 3/4] arm64: mm: call ctor for stage2 pmd page
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call pgtable_pmd_page_dtor() for pmd page allocated by
mmu_memory_cache_alloc() so kernel won't crash when it's freed
through stage2_pmd_free()->pmd_free()->pgtable_pmd_page_dtor().

This is needed if we are going to enable split pmd pt lock.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/include/asm/stage2_pgtable.h | 15 ++++++++++++---
 virt/kvm/arm/mmu.c                      | 13 +++++++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 5412fa40825e..0d9207144257 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -174,10 +174,19 @@ static inline bool stage2_pud_present(struct kvm *kvm, pud_t pud)
 		return 1;
 }
 
-static inline void stage2_pud_populate(struct kvm *kvm, pud_t *pud, pmd_t *pmd)
+static inline int stage2_pud_populate(struct kvm *kvm, pud_t *pud, pmd_t *pmd)
 {
-	if (kvm_stage2_has_pmd(kvm))
-		pud_populate(NULL, pud, pmd);
+	if (!kvm_stage2_has_pmd(kvm))
+		return 0;
+
+	/* paired with pgtable_pmd_page_dtor() in pmd_free() below */
+	if (!pgtable_pmd_page_ctor(virt_to_page(pmd))) {
+		free_page((unsigned long)pmd);
+		return -ENOMEM;
+	}
+
+	pud_populate(NULL, pud, pmd);
+	return 0;
 }
 
 static inline pmd_t *stage2_pmd_offset(struct kvm *kvm,
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e9d28a7ca673..11922d84be83 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1037,6 +1037,7 @@ static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			     phys_addr_t addr)
 {
+	int ret;
 	pud_t *pud;
 	pmd_t *pmd;
 
@@ -1048,7 +1049,9 @@ static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 		if (!cache)
 			return NULL;
 		pmd = mmu_memory_cache_alloc(cache);
-		stage2_pud_populate(kvm, pud, pmd);
+		ret = stage2_pud_populate(kvm, pud, pmd);
+		if (ret)
+			return ERR_PTR(ret);
 		get_page(virt_to_page(pud));
 	}
 
@@ -1061,6 +1064,9 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 	pmd_t *pmd, old_pmd;
 
 	pmd = stage2_get_pmd(kvm, cache, addr);
+	if (IS_ERR(pmd))
+		return PTR_ERR(pmd);
+
 	VM_BUG_ON(!pmd);
 
 	old_pmd = *pmd;
@@ -1198,6 +1204,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			  phys_addr_t addr, const pte_t *new_pte,
 			  unsigned long flags)
 {
+	int ret;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
@@ -1227,7 +1234,9 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
 		pmd = mmu_memory_cache_alloc(cache);
-		stage2_pud_populate(kvm, pud, pmd);
+		ret = stage2_pud_populate(kvm, pud, pmd);
+		if (ret)
+			return ret;
 		get_page(virt_to_page(pud));
 	}
 
-- 
2.21.0.360.g471c308f928-goog

