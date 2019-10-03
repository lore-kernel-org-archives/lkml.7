Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC91721783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LutUDiEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbfJCVg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:36:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43098 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733154AbfJCVg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:36:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so5724259qtv.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pI1KmVNKpDj+42btITh2dqoDTCysg2+scSwiPIPFiPs=;
        b=LutUDiEMx/r3GUlDEZoQxxNrRPwRc4xUSrKAXOPYu5xVXn+VfeNBlV6lhujzvRtAaQ
         U2ePBJV1fEAzOyEjaeT+l37LwOnYLPkyg/yXBFVcpu2XJBQFI+npX2r4lnEC/qxLJKBS
         L/UJGl8J9qKKak4NQvd70mEFbnIHE0ieXLtIZiB9XqHExT7wD1vn5jtSZZBhOYMUbfsi
         i+KJlXUqfK/BS4mJGe8viFm7jV/XhFDwPHqcz5e2NtihmFux0FLvJwJII8w1XUSRgdSa
         bxi/cB8KERhgNPrAxUvxPzaXr/+8xMyTaXNeQMWaxNCbGyVS5rm7HOXv1k7VjfzgeHdW
         ODkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pI1KmVNKpDj+42btITh2dqoDTCysg2+scSwiPIPFiPs=;
        b=jh1CkU7M1rZBK/OJLHdgz08YuXtDQX9Yc7pW2cA6e/GomnXxw2CblmBbeS/zXnIaH0
         RmbboplZBhkrqc1AWe6dQE9gpAFljtda8GuLehpg+NKSg3BEJsVg+C/a3/KpLyxIm9Rg
         utnCzAgyIH+Hz3/m7mJzIZ4vA7T+fvB+k3ns1eh/LWb1/dKWrNpR+cmr2tplItrCIK3c
         8rwT6WO8uxBi5uU2ZDMQtqj2R91DIaI4s6KPRr2p2unQygfIcG30M0YU9mg9+c3hcjlN
         G1MxooQKWco7SUOa640EQ3sk0PH+RkUK5M2o5v2TCkqZb2oqhhOBx9PBj9N5K54EqvF+
         rA9w==
X-Gm-Message-State: APjAAAV4kbj+tIRa113DyAnrjv58gq37LF+c3dx8Ejz99UmJYjY4xcCc
        hWZ+mITkCfYCLlvfyrQvM/dYlQ==
X-Google-Smtp-Source: APXvYqw6ZTxd6WgEr2A+6PQqwM+gDjISutNBa2bvT0qivUnj6X0lc4Zg+Q2W8sLvy5V2Xcm8KvCn5A==
X-Received: by 2002:ac8:38ef:: with SMTP id g44mr12548987qtc.277.1570138613608;
        Thu, 03 Oct 2019 14:36:53 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h68sm2047396qkf.2.2019.10.03.14.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:36:52 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] s390/mm: fix -Wunused-but-set-variable warnings
Date:   Thu,  3 Oct 2019 17:36:36 -0400
Message-Id: <1570138596-11913-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert two functions to static inline to get ride of W=1 GCC warnings
like,

mm/gup.c: In function 'gup_pte_range':
mm/gup.c:1816:16: warning: variable 'ptem' set but not used
[-Wunused-but-set-variable]
  pte_t *ptep, *ptem;
                ^~~~

mm/mmap.c: In function 'acct_stack_growth':
mm/mmap.c:2322:16: warning: variable 'new_start' set but not used
[-Wunused-but-set-variable]
  unsigned long new_start;
                ^~~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/s390/include/asm/hugetlb.h | 9 +++++++--
 arch/s390/include/asm/pgtable.h | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index bb59dd964590..de8f0bf5f238 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -12,8 +12,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
-
-#define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range			free_pgd_range
 #define hugepages_supported()			(MACHINE_HAS_EDAT1)
 
@@ -23,6 +21,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
+static inline bool is_hugepage_only_range(struct mm_struct *mm,
+					  unsigned long addr,
+					  unsigned long len)
+{
+	return false;
+}
+
 /*
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 36c578c0ff96..19c2cf001df3 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1269,7 +1269,8 @@ static inline pte_t *pte_offset(pmd_t *pmd, unsigned long address)
 
 #define pte_offset_kernel(pmd, address) pte_offset(pmd, address)
 #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
-#define pte_unmap(pte) do { } while (0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
 {
-- 
1.8.3.1

