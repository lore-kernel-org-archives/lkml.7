Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBEDC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DB92070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgAHCcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:32:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:26755 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHCcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:32:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 18:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; 
   d="scan'208";a="370821123"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2020 18:32:08 -0800
Date:   Wed, 8 Jan 2020 10:32:11 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Rik van Riel <riel@redhat.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable
 anon_vma as parent when fork
Message-ID: <20200108023211.GC13943@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <157839239609.694.10268055713935919822.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157839239609.694.10268055713935919822.stgit@buzz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 01:19:56PM +0300, Konstantin Khlebnikov wrote:
>This fixes some misconceptions in commit 4e4a9eb92133 ("mm/rmap.c: reuse
>mergeable anon_vma as parent when fork"). It merges anon-vma in unexpected
>way but fortunately still produces valid anon-vma tree, so nothing crashes.
>
>If in parent VMAs: SRC1 SRC2 .. SRCn share anon-vma ANON0, then after fork
>before all patches in child process related VMAs: DST1 DST2 .. DSTn will
>fork indepndent anon-vmas: ANON1 ANON2 .. ANONn (each is child of ANON0).
>Before this patch only DST1 will fork new ANON1 and following DST2 .. DSTn
>will share parent's ANON0 (i.e. anon-vma tree is valid but isn't optimal).
>With this patch DST1 will create new ANON1 and DST2 .. DSTn will share it.
>
>Root problem caused by initialization order in dup_mmap(): vma->vm_prev
>is set after calling anon_vma_fork(). Thus in anon_vma_fork() it points to
>previous VMA in parent mm.
>
>Second problem is hidden behind first one: assumption "Parent has vm_prev,
>which implies we have vm_prev" is wrong if first VMA in parent mm has set
>flag VM_DONTCOPY. Luckily prev->anon_vma doesn't dereference NULL pointer
>because in current code 'prev' actually is same as 'pprev'.
>
>Third hidden problem is linking between VMA and anon-vmas whose pages it
>could contain. Loop in anon_vma_clone() attaches only parent's anon-vmas,
>shared anon-vma isn't attached. But every mapped page stays reachable in
>rmap because we erroneously share anon-vma from parent's previous VMA.
>
>This patch moves sharing logic out of anon_vma_clone() into more specific
>anon_vma_fork() because this supposed to work only at fork() and simply
>reuses anon_vma from previous VMA if it is forked from the same anon-vma.
>
>Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>Reported-by: Li Xinhai <lixinhai.lxh@gmail.com>
>Fixes: 4e4a9eb92133 ("mm/rmap.c: reuse mergeable anon_vma as parent when fork")
>Link: https://lore.kernel.org/linux-mm/CALYGNiNzz+dxHX0g5-gNypUQc3B=8_Scp53-NTOh=zWsdUuHAw@mail.gmail.com/T/#t
>---
> include/linux/rmap.h |    3 ++-
> kernel/fork.c        |    2 +-
> mm/rmap.c            |   23 +++++++++--------------
> 3 files changed, 12 insertions(+), 16 deletions(-)
>
>diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>index 988d176472df..560e4480dcd0 100644
>--- a/include/linux/rmap.h
>+++ b/include/linux/rmap.h
>@@ -143,7 +143,8 @@ void anon_vma_init(void);	/* create anon_vma_cachep */
> int  __anon_vma_prepare(struct vm_area_struct *);
> void unlink_anon_vmas(struct vm_area_struct *);
> int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
>-int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
>+int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma,
>+		  struct vm_area_struct *prev);
>
> static inline int anon_vma_prepare(struct vm_area_struct *vma)
> {
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 2508a4f238a3..c33626993831 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -556,7 +556,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
> 			tmp->anon_vma = NULL;
> 			if (anon_vma_prepare(tmp))
> 				goto fail_nomem_anon_vma_fork;
>-		} else if (anon_vma_fork(tmp, mpnt))
>+		} else if (anon_vma_fork(tmp, mpnt, prev))
> 			goto fail_nomem_anon_vma_fork;
> 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
> 		tmp->vm_next = tmp->vm_prev = NULL;
>diff --git a/mm/rmap.c b/mm/rmap.c
>index b3e381919835..3c1e04389291 100644
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
>@@ -332,7 +319,8 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>  * the corresponding VMA in the parent process is attached to.
>  * Returns 0 on success, non-zero on failure.
>  */
>-int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>+int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma,
>+		  struct vm_area_struct *prev)
> {
> 	struct anon_vma_chain *avc;
> 	struct anon_vma *anon_vma;
>@@ -342,6 +330,13 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
> 	if (!pvma->anon_vma)
> 		return 0;
>
>+	/* Share anon_vma with previous VMA if it has the same parent. */
>+	if (prev && prev->anon_vma &&
>+	    prev->anon_vma->parent == pvma->anon_vma) {
>+		vma->anon_vma = prev->anon_vma;
>+		return anon_vma_clone(vma, prev);
>+	}
>+

I am afraid this one change the intended behavior. Let's put a chart to
describe.

Commit 4e4a9eb92133 ("mm/rmap.c: reusemergeable anon_vma as parent when
fork") tries to improve the following situation.

Before the commit, the behavior is like this:

Parent process:

      +-----+            
      | pav |<-----------------+----------------------+
      +-----+                  |                      |
                               |                      |
                   +-----------+          +-----------+
                   |pprev      |          |pvma       |
                   +-----------+          +-----------+

Child Process


      +-----+                     +-----+
      | av1 |<-----------------+  | av2 |<------------+
      +-----+                  |  +-----+             |
                               |                      |
                   +-----------+          +-----------+
                   |prev       |          |vma        |
                   +-----------+          +-----------+


Parent pprev and pvma share the same anon_vma due to
find_mergeable_anon_vma(). While the anon_vma_clone() would pick up different
anon_vma for child process's vma.

The purpose of my commit is to give child process the following shape.

      +-----+                            
      | av  |<-----------------+----------------------+
      +-----+                  |                      |
                               |                      |
                   +-----------+          +-----------+
                   |prev       |          |vma        |
                   +-----------+          +-----------+

After this, we reduce the extra "av2" for child process. But yes, because of
the two reasons you found, it didn't do the exact thing.

While if my understanding is correct, the anon_vma_clone() would pick up any
anon_vma in its process tree, except parent's. If this fails to get a reusable
one, anon_vma_fork() would allocate one, whose parent is pvma->anon_vma.

Let me summarise original behavior:

  * if anon_vma_clone succeed, it find one anon_vma in the process tree, but
    it could not be pvma->anon_vma
  * if anon_vma_clone fail, it will allocate a new anon_vma and its parent is
    pvma->anon_vam

Then take a look into your code here.

"prev->anon_vma->parent == pvma->anon_vma" means prev->anon_vma parent is
pvma's anon_vma. If my understanding is correct, this just match the second
case. For "prev", we didn't find a reusable anon_vma and allocate a new one. 

But how about the first case? prev reuse an anon_vma in the process tree which
is not parent's?

> 	/* Drop inherited anon_vma, we'll reuse existing or allocate new. */
> 	vma->anon_vma = NULL;
>

--
Wei Yang
Help you, Help me
