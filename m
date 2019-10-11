Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8780C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DD12089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfJKFV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:21:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:60995 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfJKFV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:21:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 22:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="200682314"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Oct 2019 22:21:24 -0700
Date:   Fri, 11 Oct 2019 13:21:07 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        khlebnikov@yandex-team.ru, cai@lca.pw, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 1/2] mm/rmap.c: don't reuse anon_vma if we just want a
 copy
Message-ID: <20191011052107.GA22714@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191011025841.16801-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011025841.16801-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:58:40AM +0800, Wei Yang wrote:
>Before commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma
>hierarchy"), anon_vma_clone() doesn't change dst->anon_vma. While after
>this commit, anon_vma_clone() will try to reuse an exist one on forking.
>
>But this commit go a little bit further for the case not forking.
>anon_vma_clone() is called from __vma_split(), __split_vma(), copy_vma()
>and anon_vma_fork(). For the first three places, the purpose here is get
>a copy of src and we don't expect to touch dst->anon_vma even it is
>NULL. While after that commit, it is possible to reuse an anon_vma when
>dst->anon_vma is NULL. This is not we intend to have.
>
>This patch stop reuse anon_vma for non-fork cases.
>
>Fix commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma
>hierarchy")
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>---
>v3:
>  * use dst->anon_vma and src->anon_vma to get reuse state
>    pointed by Konstantin Khlebnikov
>---
> mm/rmap.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/mm/rmap.c b/mm/rmap.c
>index d9a23bb773bf..fc0aba7fb9b9 100644
>--- a/mm/rmap.c
>+++ b/mm/rmap.c
>@@ -250,7 +250,13 @@ static inline void unlock_anon_vma_root(struct anon_vma *root)
>  * Attach the anon_vmas from src to dst.
>  * Returns 0 on success, -ENOMEM on failure.
>  *
>- * If dst->anon_vma is NULL this function tries to find and reuse existing
>+ * anon_vma_clone() is called by __vma_split(), __split_vma(), copy_vma() and
>+ * anon_vma_fork(). The first three want an exact copy of src, while the last
>+ * one, anon_vma_fork(), may try to reuse an existing anon_vma to prevent
>+ * endless growth of anon_vma. Since dst->anon_vma is set to NULL before call,
>+ * we can identify this case by (reuse = !dst->anon_vma && src->anon_vma).
>+ *
>+ * If reuse is true, this function tries to find and reuse existing
>  * anon_vma which has no vmas and only one child anon_vma. This prevents
>  * degradation of anon_vma hierarchy to endless linear chain in case of
>  * constantly forking task. On the other hand, an anon_vma with more than one
>@@ -262,6 +268,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
> {
> 	struct anon_vma_chain *avc, *pavc;
> 	struct anon_vma *root = NULL;
>+	bool reuse = !dst->anon_vma && src->anon_vma;
> 
> 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
> 		struct anon_vma *anon_vma;
>@@ -286,8 +293,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
> 		 * will always reuse it. Root anon_vma is never reused:
> 		 * it has self-parent reference and at least one child.
> 		 */
>-		if (!dst->anon_vma && anon_vma != src->anon_vma &&
>-				anon_vma->degree < 2)
>+		if (reuse && anon_vma != src->anon_vma && anon_vma->degree < 2)
> 			dst->anon_vma = anon_vma;

What a shame.

dst->anon_vma would be changed in the loop, so we only need to assign it when
dst->anon_vma == NULL.

> 	}
> 	if (dst->anon_vma)
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
