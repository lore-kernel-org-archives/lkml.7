Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E564C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0140217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfDQO2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732007AbfDQO2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BD6130842AC;
        Wed, 17 Apr 2019 14:28:39 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 878585DA38;
        Wed, 17 Apr 2019 14:28:37 +0000 (UTC)
Date:   Wed, 17 Apr 2019 10:28:35 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "riel@surriel.com" <riel@surriel.com>
Subject: Re: [PATCH 2/9] mm: Add an apply_to_pfn_range interface
Message-ID: <20190417142835.GB3229@redhat.com>
References: <20190412160338.64994-1-thellstrom@vmware.com>
 <20190412160338.64994-3-thellstrom@vmware.com>
 <20190412210743.GA19252@redhat.com>
 <ba1f1f97259e09cd3cc6377cad89b036285c0272.camel@vmware.com>
 <20190416144657.GA3254@redhat.com>
 <2dd9b36444dc92f409b44c74667b6d63dc1713a8.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dd9b36444dc92f409b44c74667b6d63dc1713a8.camel@vmware.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Apr 2019 14:28:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:15:52AM +0000, Thomas Hellstrom wrote:
> On Tue, 2019-04-16 at 10:46 -0400, Jerome Glisse wrote:
> > On Sat, Apr 13, 2019 at 08:34:02AM +0000, Thomas Hellstrom wrote:
> > > Hi, Jérôme
> > > 
> > > On Fri, 2019-04-12 at 17:07 -0400, Jerome Glisse wrote:
> > > > On Fri, Apr 12, 2019 at 04:04:18PM +0000, Thomas Hellstrom wrote:

[...]

> > > > > -/*
> > > > > - * Scan a region of virtual memory, filling in page tables as
> > > > > necessary
> > > > > - * and calling a provided function on each leaf page table.
> > > > > +/**
> > > > > + * apply_to_pfn_range - Scan a region of virtual memory,
> > > > > calling a
> > > > > provided
> > > > > + * function on each leaf page table entry
> > > > > + * @closure: Details about how to scan and what function to
> > > > > apply
> > > > > + * @addr: Start virtual address
> > > > > + * @size: Size of the region
> > > > > + *
> > > > > + * If @closure->alloc is set to 1, the function will fill in
> > > > > the
> > > > > page table
> > > > > + * as necessary. Otherwise it will skip non-present parts.
> > > > > + * Note: The caller must ensure that the range does not
> > > > > contain
> > > > > huge pages.
> > > > > + * The caller must also assure that the proper mmu_notifier
> > > > > functions are
> > > > > + * called. Either in the pte leaf function or before and after
> > > > > the
> > > > > call to
> > > > > + * apply_to_pfn_range.
> > > > 
> > > > This is wrong there should be a big FAT warning that this can
> > > > only be
> > > > use
> > > > against mmap of device file. The page table walking above is
> > > > broken
> > > > for
> > > > various thing you might find in any other vma like THP, device
> > > > pte,
> > > > hugetlbfs,
> > > 
> > > I was figuring since we didn't export the function anymore, the
> > > warning
> > > and checks could be left to its users, assuming that any other
> > > future
> > > usage of this function would require mm people audit anyway. But I
> > > can
> > > of course add that warning also to this function if you still want
> > > that?
> > 
> > Yeah more warning are better, people might start using this, i know
> > some poeple use unexported symbol and then report bugs while they
> > just were doing something illegal.
> > 
> > > > ...
> > > > 
> > > > Also the mmu notifier can not be call from the pfn callback as
> > > > that
> > > > callback
> > > > happens under page table lock (the change_pte notifier callback
> > > > is
> > > > useless
> > > > and not enough). So it _must_ happen around the call to
> > > > apply_to_pfn_range
> > > 
> > > In the comments I was having in mind usage of, for example
> > > ptep_clear_flush_notify(). But you're the mmu_notifier expert here.
> > > Are
> > > you saying that function by itself would not be sufficient?
> > > In that case, should I just scratch the text mentioning the pte
> > > leaf
> > > function?
> > 
> > ptep_clear_flush_notify() is useless ... i have posted patches to
> > either
> > restore it or remove it. In any case you must call mmu notifier range
> > and
> > they can not happen under lock. You usage looked fine (in the next
> > patch)
> > but i would rather have a bit of comment here to make sure people are
> > also
> > aware of that.
> > 
> > While we can hope that people would cc mm when using mm function, it
> > is
> > not always the case. So i rather be cautious and warn in comment as
> > much
> > as possible.
> > 
> 
> OK. Understood. All this actually makes me tend to want to try a bit
> harder using a slight modification to the pagewalk code instead. Don't
> really want to encourage two parallel code paths doing essentially the
> same thing; one good and one bad.
> 
> One thing that confuses me a bit with the pagewalk code is that callers
> (for example softdirty) typically call
> mmu_notifier_invalidate_range_start() around the pagewalk, but then if
> it ends up splitting a pmd, mmu_notifier_invalidate_range is called
> again, within the first range. Docs aren't really clear whether that's
> permitted or not. Is it?

It is mandatory ie you have to call mmu_notifier_invalidate_range()
in some cases. This is all documented in mmu_notifier.h see struct
mmu_notifier_ops comments and also Documentation/vm/mmu_notifier.rst

Roughly anytime you go from one valid pte (pmd/pud/p4d) to another
valid pte (pmd/pud/p4d) with a different page then you have to call
after clearing pte (pmd/pud/p4d) and before replacing it with its
new value. Changing permission on same page ie going from read and
write to read only, or read only to read and write, does not require
any extra call to mmu_notifier_invalidate_range()

The mmu_notifier_invalidate_range() is important for IOMMU with ATS/
PASID as it is when the flush the TLB and remote device TLB. So you
must flush those secondary TLB after clearing entry so that it can
not race to repopulate the TLB and before setting the new entry so
that at no point in time any hardware can wrongly access old page
while a new page is just now active.

Hopes that clarify it, between if you see any improvement to mmu-
notifier doc it would be more than welcome. I try to put comments
in enough places that people should see at least one of them but
maybe i miss a place where i should have put a comments to point
to the doc :)

Cheers,
Jérôme
