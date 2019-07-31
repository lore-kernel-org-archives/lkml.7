Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB36206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfGaPTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:19:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5399 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbfGaPSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02BE2300D20F;
        Wed, 31 Jul 2019 15:18:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 275AF196EC;
        Wed, 31 Jul 2019 15:18:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 Jul 2019 17:18:45 +0200 (CEST)
Date:   Wed, 31 Jul 2019 17:18:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 3/4] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190731151842.GB25078@redhat.com>
References: <20190730052305.3672336-1-songliubraving@fb.com>
 <20190730052305.3672336-4-songliubraving@fb.com>
 <20190730161113.GC18501@redhat.com>
 <1E2B5653-BA85-4A05-9B41-57CF9E48F14A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E2B5653-BA85-4A05-9B41-57CF9E48F14A@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 31 Jul 2019 15:18:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30, Song Liu wrote:
>
>
> > On Jul 30, 2019, at 9:11 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > So after the next patch we have a single user of FOLL_SPLIT_PMD (uprobes)
> > and a single user of FOLL_SPLIT: arch/s390/mm/gmap.c:thp_split_mm().
> >
> > Hmm.
>
> I think this is what we want. :)

We? I don't ;)

> FOLL_SPLIT is the fallback solution for users who cannot handle THP.

and again, we have a single user: thp_split_mm(). I do not know if it
can use FOLL_SPLIT_PMD or not, may be you can take a look...

> With
> more THP aware code, there will be fewer users of FOLL_SPLIT.

Fewer than 1? Good ;)

> >> @@ -399,7 +399,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >> 		spin_unlock(ptl);
> >> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> >> 	}
> >> -	if (flags & FOLL_SPLIT) {
> >> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
> >> 		int ret;
> >> 		page = pmd_page(*pmd);
> >> 		if (is_huge_zero_page(page)) {
> >> @@ -408,7 +408,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >> 			split_huge_pmd(vma, pmd, address);
> >> 			if (pmd_trans_unstable(pmd))
> >> 				ret = -EBUSY;
> >> -		} else {
> >> +		} else if (flags & FOLL_SPLIT) {
> >> 			if (unlikely(!try_get_page(page))) {
> >> 				spin_unlock(ptl);
> >> 				return ERR_PTR(-ENOMEM);
> >> @@ -420,6 +420,10 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >> 			put_page(page);
> >> 			if (pmd_none(*pmd))
> >> 				return no_page_table(vma, flags);
> >> +		} else {  /* flags & FOLL_SPLIT_PMD */
> >> +			spin_unlock(ptl);
> >> +			split_huge_pmd(vma, pmd, address);
> >> +			ret = pte_alloc(mm, pmd);
> >
> > I fail to understand why this differs from the is_huge_zero_page() case above.
>
> split_huge_pmd() handles is_huge_zero_page() differently. In this case, we
> cannot use the pmd_trans_unstable() check.

Please correct me, but iiuc the problem is not that split_huge_pmd() handles
is_huge_zero_page() differently, the problem is that __split_huge_pmd_locked()
handles the !vma_is_anonymous(vma) differently and returns with pmd_none() = T
after pmdp_huge_clear_flush_notify(). This means that pmd_trans_unstable() will
fail.

Now, I don't understand why do we need pmd_trans_unstable() after
split_huge_pmd(huge-zero-pmd), but whatever reason we have, why can't we
unify both cases?

IOW, could you explain why the path below is wrong?

Oleg.


--- x/mm/gup.c
+++ x/mm/gup.c
@@ -399,14 +399,16 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
-	if (flags & FOLL_SPLIT) {
+	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
 		int ret;
 		page = pmd_page(*pmd);
-		if (is_huge_zero_page(page)) {
+		if ((flags & FOLL_SPLIT_PMD) || is_huge_zero_page(page)) {
 			spin_unlock(ptl);
-			ret = 0;
 			split_huge_pmd(vma, pmd, address);
-			if (pmd_trans_unstable(pmd))
+			ret = 0;
+			if (pte_alloc(mm, pmd))
+				ret = -ENOMEM;
+			else if (pmd_trans_unstable(pmd))
 				ret = -EBUSY;
 		} else {
 			if (unlikely(!try_get_page(page))) {

