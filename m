Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE3EC49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803D32084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfILDLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 23:11:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:9955 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfILDLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 23:11:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 20:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179224490"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 11 Sep 2019 20:11:18 -0700
Date:   Thu, 12 Sep 2019 11:10:58 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: rb_parent is not necessary in __vma_link_list
Message-ID: <20190912031058.GC25169@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190813032656.16625-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813032656.16625-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:26:56AM +0800, Wei Yang wrote:
>Now we use rb_parent to get next, while this is not necessary.
>
>When prev is NULL, this means vma should be the first element in the
>list. Then next should be current first one (mm->mmap), no matter
>whether we have parent or not.
>
>After removing it, the code shows the beauty of symmetry.
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Ping~

>---
> mm/internal.h | 2 +-
> mm/mmap.c     | 2 +-
> mm/nommu.c    | 2 +-
> mm/util.c     | 8 ++------
> 4 files changed, 5 insertions(+), 9 deletions(-)
>
>diff --git a/mm/internal.h b/mm/internal.h
>index e32390802fd3..41a49574acc3 100644
>--- a/mm/internal.h
>+++ b/mm/internal.h
>@@ -290,7 +290,7 @@ static inline bool is_data_mapping(vm_flags_t flags)
> 
> /* mm/util.c */
> void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
>-		struct vm_area_struct *prev, struct rb_node *rb_parent);
>+		struct vm_area_struct *prev);
> 
> #ifdef CONFIG_MMU
> extern long populate_vma_page_range(struct vm_area_struct *vma,
>diff --git a/mm/mmap.c b/mm/mmap.c
>index f7ed0afb994c..b8072630766f 100644
>--- a/mm/mmap.c
>+++ b/mm/mmap.c
>@@ -632,7 +632,7 @@ __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
> 	struct vm_area_struct *prev, struct rb_node **rb_link,
> 	struct rb_node *rb_parent)
> {
>-	__vma_link_list(mm, vma, prev, rb_parent);
>+	__vma_link_list(mm, vma, prev);
> 	__vma_link_rb(mm, vma, rb_link, rb_parent);
> }
> 
>diff --git a/mm/nommu.c b/mm/nommu.c
>index fed1b6e9c89b..12a66fbeb988 100644
>--- a/mm/nommu.c
>+++ b/mm/nommu.c
>@@ -637,7 +637,7 @@ static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
> 	if (rb_prev)
> 		prev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
> 
>-	__vma_link_list(mm, vma, prev, parent);
>+	__vma_link_list(mm, vma, prev);
> }
> 
> /*
>diff --git a/mm/util.c b/mm/util.c
>index e6351a80f248..80632db29247 100644
>--- a/mm/util.c
>+++ b/mm/util.c
>@@ -264,7 +264,7 @@ void *memdup_user_nul(const void __user *src, size_t len)
> EXPORT_SYMBOL(memdup_user_nul);
> 
> void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
>-		struct vm_area_struct *prev, struct rb_node *rb_parent)
>+		struct vm_area_struct *prev)
> {
> 	struct vm_area_struct *next;
> 
>@@ -273,12 +273,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
> 		next = prev->vm_next;
> 		prev->vm_next = vma;
> 	} else {
>+		next = mm->mmap;
> 		mm->mmap = vma;
>-		if (rb_parent)
>-			next = rb_entry(rb_parent,
>-					struct vm_area_struct, vm_rb);
>-		else
>-			next = NULL;
> 	}
> 	vma->vm_next = next;
> 	if (next)
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
