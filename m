Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25853C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D4520665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392083AbfHBKbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730143AbfHBKbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D090981F07;
        Fri,  2 Aug 2019 10:31:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 043E860925;
        Fri,  2 Aug 2019 10:31:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Aug 2019 12:31:15 +0200 (CEST)
Date:   Fri, 2 Aug 2019 12:31:13 +0200
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
Subject: Re: [PATCH v2 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Message-ID: <20190802103112.GA20111@redhat.com>
References: <20190731183331.2565608-1-songliubraving@fb.com>
 <20190731183331.2565608-2-songliubraving@fb.com>
 <20190801145032.GB31538@redhat.com>
 <36D3C0F0-17CE-42B9-9661-B376D608FA7D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36D3C0F0-17CE-42B9-9661-B376D608FA7D@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 02 Aug 2019 10:31:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Song Liu wrote:
>
>
> > On Aug 1, 2019, at 7:50 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 07/31, Song Liu wrote:
> >>
> >> +static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> >> +					 unsigned long addr)
> >> +{
> >> +	struct mm_slot *mm_slot;
> >> +	int ret = 0;
> >> +
> >> +	/* hold mmap_sem for khugepaged_test_exit() */
> >> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> >> +	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
> >> +
> >> +	if (unlikely(khugepaged_test_exit(mm)))
> >> +		return 0;
> >> +
> >> +	if (!test_bit(MMF_VM_HUGEPAGE, &mm->flags) &&
> >> +	    !test_bit(MMF_DISABLE_THP, &mm->flags)) {
> >> +		ret = __khugepaged_enter(mm);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >
> > could you explain why do we need mm->mmap_sem, khugepaged_test_exit() check
> > and __khugepaged_enter() ?
>
> If the mm doesn't have a mm_slot, we would like to create one here (by
> calling __khugepaged_enter()).

I can be easily wrong, I never read this code before, but this doesn't
look correct.

Firstly, mm->mmap_sem cam ONLY help if a) the task already has mm_slot
and b) this mm_slot is khugepaged_scan.mm_slot. Otherwise khugepaged_exit()
won't take mmap_sem for writing and thus we can't rely on test_exit().

and this means that down_read(mmap_sem) before khugepaged_add_pte_mapped_thp()
is pointless and can't help; this mm was found by vma_interval_tree_foreach().

so __khugepaged_enter() can race with khugepaged_exit() and this is wrong
in any case.

> This happens when the THP is created by another mm, or by tmpfs with
> "huge=always"; and then page table of this mm got split by split_huge_pmd().
> With current kernel, this happens when we attach/detach uprobe to a file
> in tmpfs with huge=always.

Well. In this particular case khugepaged_enter() was likely already called
by shmem_mmap() or khugepaged_enter_vma_merge(), or madvise.

(in fact I think do_set_pmd() or shmem_fault() should call _enter() too,
 like do_huge_pmd_anonymous_page() does, but this is another story).


And I forgot to mention... I don't understand why
khugepaged_collapse_pte_mapped_thps() has to be called with khugepaged_mm_lock.

Oleg.

