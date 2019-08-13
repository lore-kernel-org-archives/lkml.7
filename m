Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B366AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F172084D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfHMOF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfHMOF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA76930860C6;
        Tue, 13 Aug 2019 14:05:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 03BC71000324;
        Tue, 13 Aug 2019 14:05:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 13 Aug 2019 16:05:55 +0200 (CEST)
Date:   Tue, 13 Aug 2019 16:05:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Song Liu <songliubraving@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Message-ID: <20190813140552.GB6971@redhat.com>
References: <20190807233729.3899352-6-songliubraving@fb.com>
 <20190808163303.GB7934@redhat.com>
 <770B3C29-CE8F-4228-8992-3C6E2B5487B6@fb.com>
 <20190809152404.GA21489@redhat.com>
 <3B09235E-5CF7-4982-B8E6-114C52196BE5@fb.com>
 <4D8B8397-5107-456B-91FC-4911F255AE11@fb.com>
 <20190812121144.f46abvpg6lvxwwzs@box>
 <20190812132257.GB31560@redhat.com>
 <20190812144045.tkvipsyit3nccvuk@box>
 <20190813133034.GA6971@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813133034.GA6971@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 13 Aug 2019 14:05:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13, Oleg Nesterov wrote:
>
> On 08/12, Kirill A. Shutemov wrote:
> >
> > On Mon, Aug 12, 2019 at 03:22:58PM +0200, Oleg Nesterov wrote:
> > > On 08/12, Kirill A. Shutemov wrote:
> > > >
> > > > On Fri, Aug 09, 2019 at 06:01:18PM +0000, Song Liu wrote:
> > > > > +		if (pte_none(*pte) || !pte_present(*pte))
> > > > > +			continue;
> > > >
> > > > You don't need to check both. Present is never none.
> > >
> > > Agreed.
> > >
> > > Kirill, while you are here, shouldn't retract_page_tables() check
> > > vma->anon_vma (and probably do mm_find_pmd) under vm_mm->mmap_sem?
> > >
> > > Can't it race with, say, do_cow_fault?
> >
> > vma->anon_vma can race, but it doesn't matter. False-negative is fine.
> > It's attempt to avoid taking mmap_sem where it can be not productive.
>
> I guess I misunderstood the purpose of this check or your answer...
>
> Let me reword my question. Why can retract_page_tables() safely do
> pmdp_collapse_flush(vma) without additional checks similar to what
> collapse_pte_mapped_thp() does?
>
> I thought that retract_page_tables() checks vma->anon_vma to ensure that
> this vma doesn't have a cow'ed PageAnon() page. And I still can't understand
> why can't it race with __handle_mm_fault() paths.
>
> Suppose that shmem_file was mmaped with PROT_READ|WRITE, MAP_PRIVATE.
> To simplify, suppose that a non-THP page was already faulted in,
> pte_present() == T.
>
> Userspace writes to this page.
>
> Why __handle_mm_fault()->handle_pte_fault()->do_wp_page()->wp_page_copy()
> can not cow this page and update pte after the vma->anon_vma chech and
> before down_write_trylock(mmap_sem) ?

OK, probably this is impossible, collapse_shmem() does unmap_mapping_pages(),
so handle_pte_fault() will call shmem_fault() which iiuc should block in
find_lock_entry() because new_page is locked, and thus down_write_trylock()
can't succeed.

Nevermind, I am sure I missed something. Perhaps you can update the comments
to make this more clear.

Oleg.

