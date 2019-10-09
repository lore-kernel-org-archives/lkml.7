Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD16C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EF821721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJIM2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:28:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45038 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727878AbfJIM2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:28:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9F1BDB972E4E356DC9F2;
        Wed,  9 Oct 2019 20:28:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 20:28:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] userfaultfd: remove set but not used variable 'h'
Date:   Wed, 9 Oct 2019 12:27:40 +0000
Message-ID: <20191009122740.70517-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
mm/userfaultfd.c:217:17: warning:
 variable 'h' set but not used [-Wunused-but-set-variable]

It is not used since commit 78911d0e18ac ("userfaultfd: use vma_pagesize
for all huge page size calculation")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/userfaultfd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4cb4ef3d9128..1b0d7abad1d4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -214,7 +214,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	struct hstate *h;
 	unsigned long vma_hpagesize;
 	pgoff_t idx;
 	u32 hash;
@@ -271,8 +270,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 	}
 
-	h = hstate_vma(dst_vma);
-
 	while (src_addr < src_start + len) {
 		pte_t dst_pteval;



