Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A2C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66A82072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="S6iDG8Pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAFKmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:42:45 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:42482 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726281AbgAFKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:42:44 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 47ED62E1430;
        Mon,  6 Jan 2020 13:42:41 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 2E6fIXUjzS-gePakUEF;
        Mon, 06 Jan 2020 13:42:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578307361; bh=bRVeZsD0ssI2ITrXsE3HS5bNXpMA/dOYQCa6X9aIh44=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=S6iDG8PdFlivCb3idaunrZXUk+s8cjKe00WFd8ruvOMteYgbxUMcvKxRnlwLlCPKL
         jU7SyUXe7aEgJLKnKqk1uaR3LB0HyOftX67mVpzB8SiQBqjkJYUB8v+rxmDONr4rQD
         lIdx4c9TkLnzrdKTviHiYQOcxTF6gews81MRLPKg=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6708::1:7])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id j38nwkNrq9-geV4IAKt;
        Mon, 06 Jan 2020 13:42:40 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/rmap: fix reusing mergeable anon_vma as parent when fork
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Mon, 06 Jan 2020 13:42:40 +0300
Message-ID: <157830736034.8148.7070851958306750616.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes couple misconceptions in commit 4e4a9eb92133 ("mm/rmap.c: reuse
mergeable anon_vma as parent when fork").

First problem caused by initialization order in dup_mmap(): vma->vm_prev
is set after calling anon_vma_fork(). Thus in anon_vma_fork() it points to
previous VMA in parent mm. This is fixed by rearrangement in dup_mmap().

If in parent VMAs: SRC1 SRC2 .. SRCn share anon-vma ANON0, then after fork
before all patches in child process related VMAs: DST1 DST2 .. DSTn will
use different anon-vmas: ANON1 ANON2 .. ANONn. Before this patch only DST1
will fork new ANON1 and following DST2 .. DSTn will share parent's ANON0.
With this patch DST1 will create new ANON1 and DST2 .. DSTn will share it.

Also this patch moves sharing logic out of anon_vma_clone() into more
specific anon_vma_fork() because this supposed to work only at fork().
Function anon_vma_clone() is more generic is also used at splitting VMAs.

Second problem is hidden behind first one: assumption "Parent has vm_prev,
which implies we have vm_prev" is wrong if first VMA in parent mm has set
flag VM_DONTCOPY. Luckily prev->anon_vma doesn't dereference NULL pointer
because in current code 'prev' actually is same as 'pprev'. To avoid that
this patch just checks pointer and compares vm_start to verify relation
between previous VMAs in parent and child.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 4e4a9eb92133 ("mm/rmap.c: reuse mergeable anon_vma as parent when fork")
---
 kernel/fork.c |    4 ++--
 mm/rmap.c     |   25 ++++++++++++-------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..04ee5e243f65 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -548,6 +548,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (retval)
 			goto fail_nomem_policy;
 		tmp->vm_mm = mm;
+		tmp->vm_prev = prev;	/* anon_vma_fork use this */
+		tmp->vm_next = NULL;
 		retval = dup_userfaultfd(tmp, &uf);
 		if (retval)
 			goto fail_nomem_anon_vma_fork;
@@ -559,7 +561,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
-		tmp->vm_next = tmp->vm_prev = NULL;
 		file = tmp->vm_file;
 		if (file) {
 			struct inode *inode = file_inode(file);
@@ -592,7 +593,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		 */
 		*pprev = tmp;
 		pprev = &tmp->vm_next;
-		tmp->vm_prev = prev;
 		prev = tmp;
 
 		__vma_link_rb(mm, tmp, rb_link, rb_parent);
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..77b3aa38d5c2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -269,19 +269,6 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 {
 	struct anon_vma_chain *avc, *pavc;
 	struct anon_vma *root = NULL;
-	struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
-
-	/*
-	 * If parent share anon_vma with its vm_prev, keep this sharing in in
-	 * child.
-	 *
-	 * 1. Parent has vm_prev, which implies we have vm_prev.
-	 * 2. Parent and its vm_prev have the same anon_vma.
-	 */
-	if (!dst->anon_vma && src->anon_vma &&
-	    pprev && pprev->anon_vma == src->anon_vma)
-		dst->anon_vma = prev->anon_vma;
-
 
 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma;
@@ -334,6 +321,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
  */
 int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 {
+	struct vm_area_struct *prev = vma->vm_prev, *pprev = pvma->vm_prev;
 	struct anon_vma_chain *avc;
 	struct anon_vma *anon_vma;
 	int error;
@@ -345,6 +333,17 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	/* Drop inherited anon_vma, we'll reuse existing or allocate new. */
 	vma->anon_vma = NULL;
 
+	/*
+	 * If parent shares anon_vma with its vm_prev, keep this sharing.
+	 *
+	 * Previous VMA could be missing or not match previuos in parent
+	 * if VM_DONTCOPY is set: compare vm_start to avoid this case.
+	 */
+	if (pvma->anon_vma && pprev && prev &&
+	    pprev->anon_vma == pvma->anon_vma &&
+	    pprev->vm_start == prev->vm_start)
+		vma->anon_vma = prev->anon_vma;
+
 	/*
 	 * First, attach the new VMA to the parent VMA's anon_vmas,
 	 * so rmap can find non-COWed pages in child processes.

