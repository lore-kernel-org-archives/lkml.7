Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1930C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A442077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="hPnA0eLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgAGKUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:20:05 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36950 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgAGKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:20:02 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 894F32E1479;
        Tue,  7 Jan 2020 13:19:59 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id wR5HWf8AHd-JwPGY61O;
        Tue, 07 Jan 2020 13:19:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578392399; bh=tHNiuDWCSNjv1Gat00JoTMFTmnv9MeRMDid0TscrI1I=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=hPnA0eLx475dWXpU6BH9CFAYZAu825ICzNUrgeWh7VJcPFLFT2BdzyIDeG4b4/jhr
         l0BOvHosrIuuGPGMWMDRLcStODDetoPUODo4zA2P2ZEPjVwWz6t8/lRfl8MAH1hOll
         lqR9H7AU1SYVHmxjvW1ZhSApH5XfHfN90S9ky2h0=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6407::1:5])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 5ah5C5r85j-JwVGiL5m;
        Tue, 07 Jan 2020 13:19:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 2/2] kernel/fork: set VMA's mm/prev/next right after
 vm_area_dup in dup_mmap
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Cc:     Rik van Riel <riel@redhat.com>, Li Xinhai <lixinhai.lxh@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Tue, 07 Jan 2020 13:19:58 +0300
Message-ID: <157839239842.694.2288178566540902852.stgit@buzz>
In-Reply-To: <157839239609.694.10268055713935919822.stgit@buzz>
References: <157839239609.694.10268055713935919822.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function vm_area_dup() makes exact copy of structure. It's better to stop
referencing parent structures because various helpers use these pointers.

For example if VM_WIPEONFORK is set then anon_vma_prepare() will try to
merge anon_vma with previous and next VMA. Poking parent VMAs and sharing
their anon_vma is safe for now but is not expected behavior.

Note: this will break commit 4e4a9eb92133 ("mm/rmap.c: reuse mergeable
anon_vma as parent when fork") without related fix because it contains
several flaws hidden by current initialization sequence in dup_mmap().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/fork.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index c33626993831..784c9ae56aa9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -544,10 +544,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		tmp = vm_area_dup(mpnt);
 		if (!tmp)
 			goto fail_nomem;
+		tmp->vm_mm = mm;
+		tmp->vm_prev = prev;
+		tmp->vm_next = NULL;
 		retval = vma_dup_policy(mpnt, tmp);
 		if (retval)
 			goto fail_nomem_policy;
-		tmp->vm_mm = mm;
 		retval = dup_userfaultfd(tmp, &uf);
 		if (retval)
 			goto fail_nomem_anon_vma_fork;
@@ -559,7 +561,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt, prev))
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

