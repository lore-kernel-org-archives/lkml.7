Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701D2C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6E620678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="V3XQ1DaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgAGKUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:20:02 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36852 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgAGKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:20:01 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 4D48A2E0AF1;
        Tue,  7 Jan 2020 13:19:57 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 5RNHgShfHB-JudOLcWq;
        Tue, 07 Jan 2020 13:19:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578392397; bh=SfZstHrbtjR/LipvtxYFtLO8RuvHkj9qkEOgd+AGIyc=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=V3XQ1DaYjyEpCGsFkd+8AOuKeCRE59MbfTuQp+mIBHn2V/C6KrIDZzC6ghtsnhEnF
         SVxgcTQfR2EJ/Y6oDOj4Y+515TcHac5uoUvBG2eoBe32HLujA506bsQ97VXIPXX2/1
         SIWKrhfhJi/wAZvytOi/0Kd0VDX7hlXNv38Q0g4Y=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6407::1:5])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id CadqU3Oesa-JuVSf9Zg;
        Tue, 07 Jan 2020 13:19:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable anon_vma
 as parent when fork
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Cc:     Rik van Riel <riel@redhat.com>, Li Xinhai <lixinhai.lxh@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Tue, 07 Jan 2020 13:19:56 +0300
Message-ID: <157839239609.694.10268055713935919822.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some misconceptions in commit 4e4a9eb92133 ("mm/rmap.c: reuse
mergeable anon_vma as parent when fork"). It merges anon-vma in unexpected
way but fortunately still produces valid anon-vma tree, so nothing crashes.

If in parent VMAs: SRC1 SRC2 .. SRCn share anon-vma ANON0, then after fork
before all patches in child process related VMAs: DST1 DST2 .. DSTn will
fork indepndent anon-vmas: ANON1 ANON2 .. ANONn (each is child of ANON0).
Before this patch only DST1 will fork new ANON1 and following DST2 .. DSTn
will share parent's ANON0 (i.e. anon-vma tree is valid but isn't optimal).
With this patch DST1 will create new ANON1 and DST2 .. DSTn will share it.

Root problem caused by initialization order in dup_mmap(): vma->vm_prev
is set after calling anon_vma_fork(). Thus in anon_vma_fork() it points to
previous VMA in parent mm.

Second problem is hidden behind first one: assumption "Parent has vm_prev,
which implies we have vm_prev" is wrong if first VMA in parent mm has set
flag VM_DONTCOPY. Luckily prev->anon_vma doesn't dereference NULL pointer
because in current code 'prev' actually is same as 'pprev'.

Third hidden problem is linking between VMA and anon-vmas whose pages it
could contain. Loop in anon_vma_clone() attaches only parent's anon-vmas,
shared anon-vma isn't attached. But every mapped page stays reachable in
rmap because we erroneously share anon-vma from parent's previous VMA.

This patch moves sharing logic out of anon_vma_clone() into more specific
anon_vma_fork() because this supposed to work only at fork() and simply
reuses anon_vma from previous VMA if it is forked from the same anon-vma.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reported-by: Li Xinhai <lixinhai.lxh@gmail.com>
Fixes: 4e4a9eb92133 ("mm/rmap.c: reuse mergeable anon_vma as parent when fork")
Link: https://lore.kernel.org/linux-mm/CALYGNiNzz+dxHX0g5-gNypUQc3B=8_Scp53-NTOh=zWsdUuHAw@mail.gmail.com/T/#t
---
 include/linux/rmap.h |    3 ++-
 kernel/fork.c        |    2 +-
 mm/rmap.c            |   23 +++++++++--------------
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 988d176472df..560e4480dcd0 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -143,7 +143,8 @@ void anon_vma_init(void);	/* create anon_vma_cachep */
 int  __anon_vma_prepare(struct vm_area_struct *);
 void unlink_anon_vmas(struct vm_area_struct *);
 int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
-int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
+int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma,
+		  struct vm_area_struct *prev);
 
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..c33626993831 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -556,7 +556,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			tmp->anon_vma = NULL;
 			if (anon_vma_prepare(tmp))
 				goto fail_nomem_anon_vma_fork;
-		} else if (anon_vma_fork(tmp, mpnt))
+		} else if (anon_vma_fork(tmp, mpnt, prev))
 			goto fail_nomem_anon_vma_fork;
 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
 		tmp->vm_next = tmp->vm_prev = NULL;
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..3c1e04389291 100644
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
@@ -332,7 +319,8 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
  * the corresponding VMA in the parent process is attached to.
  * Returns 0 on success, non-zero on failure.
  */
-int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
+int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma,
+		  struct vm_area_struct *prev)
 {
 	struct anon_vma_chain *avc;
 	struct anon_vma *anon_vma;
@@ -342,6 +330,13 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	if (!pvma->anon_vma)
 		return 0;
 
+	/* Share anon_vma with previous VMA if it has the same parent. */
+	if (prev && prev->anon_vma &&
+	    prev->anon_vma->parent == pvma->anon_vma) {
+		vma->anon_vma = prev->anon_vma;
+		return anon_vma_clone(vma, prev);
+	}
+
 	/* Drop inherited anon_vma, we'll reuse existing or allocate new. */
 	vma->anon_vma = NULL;
 

