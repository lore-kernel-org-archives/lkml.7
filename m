Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF054C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEC020715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgAGCcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:32:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:61480 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgAGCcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:32:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 18:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="422327324"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2020 18:32:17 -0800
Date:   Tue, 7 Jan 2020 10:32:22 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/rmap: fix reusing mergeable anon_vma as parent when
 fork
Message-ID: <20200107023221.GC15341@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <157830736034.8148.7070851958306750616.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157830736034.8148.7070851958306750616.stgit@buzz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 01:42:40PM +0300, Konstantin Khlebnikov wrote:
>This fixes couple misconceptions in commit 4e4a9eb92133 ("mm/rmap.c: reuse
>mergeable anon_vma as parent when fork").
>
>First problem caused by initialization order in dup_mmap(): vma->vm_prev
>is set after calling anon_vma_fork(). Thus in anon_vma_fork() it points to
>previous VMA in parent mm. This is fixed by rearrangement in dup_mmap().
>

You are right, I missed this point.

>If in parent VMAs: SRC1 SRC2 .. SRCn share anon-vma ANON0, then after fork
>before all patches in child process related VMAs: DST1 DST2 .. DSTn will
>use different anon-vmas: ANON1 ANON2 .. ANONn. Before this patch only DST1
>will fork new ANON1 and following DST2 .. DSTn will share parent's ANON0.
>With this patch DST1 will create new ANON1 and DST2 .. DSTn will share it.
>
>Also this patch moves sharing logic out of anon_vma_clone() into more
>specific anon_vma_fork() because this supposed to work only at fork().
>Function anon_vma_clone() is more generic is also used at splitting VMAs.
>
>Second problem is hidden behind first one: assumption "Parent has vm_prev,
>which implies we have vm_prev" is wrong if first VMA in parent mm has set
>flag VM_DONTCOPY. Luckily prev->anon_vma doesn't dereference NULL pointer
>because in current code 'prev' actually is same as 'pprev'. To avoid that
>this patch just checks pointer and compares vm_start to verify relation
>between previous VMAs in parent and child.
>

Correct here too.

>Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>Fixes: 4e4a9eb92133 ("mm/rmap.c: reuse mergeable anon_vma as parent when fork")
>---
> kernel/fork.c |    4 ++--
> mm/rmap.c     |   25 ++++++++++++-------------
> 2 files changed, 14 insertions(+), 15 deletions(-)
>
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 2508a4f238a3..04ee5e243f65 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -548,6 +548,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
> 		if (retval)
> 			goto fail_nomem_policy;
> 		tmp->vm_mm = mm;
>+		tmp->vm_prev = prev;	/* anon_vma_fork use this */
>+		tmp->vm_next = NULL;

How about pass prev to anon_vma_fork()? So that we limit all the difference in
anon_vma_fork().

> 		retval = dup_userfaultfd(tmp, &uf);
> 		if (retval)
> 			goto fail_nomem_anon_vma_fork;
>@@ -559,7 +561,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
> 		} else if (anon_vma_fork(tmp, mpnt))
> 			goto fail_nomem_anon_vma_fork;
> 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
>-		tmp->vm_next = tmp->vm_prev = NULL;
> 		file = tmp->vm_file;
> 		if (file) {
> 			struct inode *inode = file_inode(file);
>@@ -592,7 +593,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
> 		 */
> 		*pprev = tmp;
> 		pprev = &tmp->vm_next;
>-		tmp->vm_prev = prev;
> 		prev = tmp;
> 
> 		__vma_link_rb(mm, tmp, rb_link, rb_parent);
>diff --git a/mm/rmap.c b/mm/rmap.c
>index b3e381919835..77b3aa38d5c2 100644
>--- a/mm/rmap.c
>+++ b/mm/rmap.c
>@@ -269,19 +269,6 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
> {
> 	struct anon_vma_chain *avc, *pavc;
> 	struct anon_vma *root = NULL;
>-	struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
>-
>-	/*
>-	 * If parent share anon_vma with its vm_prev, keep this sharing in in
>-	 * child.
>-	 *
>-	 * 1. Parent has vm_prev, which implies we have vm_prev.
>-	 * 2. Parent and its vm_prev have the same anon_vma.
>-	 */
>-	if (!dst->anon_vma && src->anon_vma &&
>-	    pprev && pprev->anon_vma == src->anon_vma)
>-		dst->anon_vma = prev->anon_vma;
>-
> 
> 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
> 		struct anon_vma *anon_vma;
>@@ -334,6 +321,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>  */
> int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
> {
>+	struct vm_area_struct *prev = vma->vm_prev, *pprev = pvma->vm_prev;
> 	struct anon_vma_chain *avc;
> 	struct anon_vma *anon_vma;
> 	int error;
>@@ -345,6 +333,17 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
> 	/* Drop inherited anon_vma, we'll reuse existing or allocate new. */
> 	vma->anon_vma = NULL;
> 
>+	/*
>+	 * If parent shares anon_vma with its vm_prev, keep this sharing.
>+	 *
>+	 * Previous VMA could be missing or not match previuos in parent
>+	 * if VM_DONTCOPY is set: compare vm_start to avoid this case.
>+	 */
>+	if (pvma->anon_vma && pprev && prev &&
>+	    pprev->anon_vma == pvma->anon_vma &&
>+	    pprev->vm_start == prev->vm_start)
>+		vma->anon_vma = prev->anon_vma;
>+
> 	/*
> 	 * First, attach the new VMA to the parent VMA's anon_vmas,
> 	 * so rmap can find non-COWed pages in child processes.

-- 
Wei Yang
Help you, Help me
