Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB13C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144CB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GmtwfGFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442058AbfIXXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:25:22 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:52868 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393729AbfIXXZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:25:21 -0400
Received: by mail-vk1-f201.google.com with SMTP id 70so320274vki.19
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W6ANTbXC/5tTOAaJaqjhpWRd4RlgZ8urEFF8tzHfF70=;
        b=GmtwfGFWEmM5rBrJZ3zL/rMurfIJHKW3DPe1mpCFLhK2FzPz/sdblXdmkhCzzDEr1p
         c1CRp4xcJFw1WGCy4uVkAynF2k0tQwMR21q8qe53S5JjRk0+bNxUy6BDvxJ2ED6mNRbC
         gF5SJ8uZ1yGe3Axb+WL3xWOM6fqQpzVFaHdkrIB/dkLyBO4RlaB+DJTctzG9y55IFbV1
         AQGwyJ0PFRLXPKejau/Zp/XV1pF1eDXX5oIG0w+mPl8fjnJGR2sTiSwKsEAWfCaZUrzs
         EShJxvaMFLPOV0NoZ+Ut9VsP7qr8bxn3HanFveOEApilFTtmrqhoEZ+MyTs2T/leHskp
         T64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W6ANTbXC/5tTOAaJaqjhpWRd4RlgZ8urEFF8tzHfF70=;
        b=rQz5GXeZJf6LAe22clHpvwsQjIRUI3+XLti3LCPHine2JqNa35EonRBTcDJhFzKsNZ
         xCUOh19X+IzGmv1kHOgwUl616n/6FMZ/rYdCTlROvNY5/39YCbAqIBhmiWhINB6CcbQR
         mu57eGd21OdP1j6hPjeMv6dL5yN728OiUUtzJdljTJBV1xfHskCpsXBndMZd272q8LlD
         huGGhuihqFwkSuCdB03zQMPRoN+t0P4Yrv4lu48hqlSP/vWluPkdIfuq8bc2UJGRkiq8
         /rmLsmDXyeMoPE4DWu2JGPieIhIKXd7Pp3BlGwk4bePO3jLFt0WFPkECTvYDJN8Vl/Bs
         Wxgw==
X-Gm-Message-State: APjAAAVOyJ9QHaJUlWR4NTI/ZZLgJCa9vV1K0jQaKudIT/heos7yGZJf
        hNMVO5/vEQRSgUWcxAtkKb0exCgi660=
X-Google-Smtp-Source: APXvYqyjV5ELtfxTEDN6T4GvPwrc1VD3sg7ZOW3l6KFpc18OtkYspLxzhnkSZhs+S8ZRWaXFVNPkcGEjrTA=
X-Received: by 2002:a67:dc95:: with SMTP id g21mr3113756vsk.164.1569367519578;
 Tue, 24 Sep 2019 16:25:19 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:24:57 -0600
In-Reply-To: <20190924232459.214097-1-yuzhao@google.com>
Message-Id: <20190924232459.214097-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20190914070518.112954-1-yuzhao@google.com> <20190924232459.214097-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3 2/4] mm: don't expose hugetlb page to fast gup prematurely
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to expose a hugetlb page to the fast gup running on a
remote CPU before the local non-atomic op __SetPageUptodate() is
visible first.

For a hugetlb page, there is no memory barrier between the non-atomic
op and set_huge_pte_at(). Therefore, the page can appear to the fast
gup before the flag does. There is no evidence this would cause any
problem, but there is no point risking the race either.

This patch simply replace 3 uses of the non-atomic op with its atomic
version though out mm/hugetlb.c. The only one left in
hugetlbfs_fallocate() is safe because huge_add_to_page_cache() serves
as a valid write barrier.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/hugetlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d7296dd11b8..0be5b7937085 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3693,7 +3693,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	copy_user_huge_page(new_page, old_page, address, vma,
 			    pages_per_huge_page(h));
-	__SetPageUptodate(new_page);
+	SetPageUptodate(new_page);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, haddr,
 				haddr + huge_page_size(h));
@@ -3879,7 +3879,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			goto out;
 		}
 		clear_huge_page(page, address, pages_per_huge_page(h));
-		__SetPageUptodate(page);
+		SetPageUptodate(page);
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
@@ -4180,11 +4180,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	}
 
 	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * The memory barrier inside SetPageUptodate makes sure that
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__SetPageUptodate(page);
+	SetPageUptodate(page);
 
 	mapping = dst_vma->vm_file->f_mapping;
 	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
-- 
2.23.0.351.gc4317032e6-goog

