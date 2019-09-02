Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41143C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F83E2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfIBOy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:54:56 -0400
Received: from foss.arm.com ([217.140.110.172]:56004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfIBOy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:54:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66DF344;
        Mon,  2 Sep 2019 07:54:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BC303F59C;
        Mon,  2 Sep 2019 07:54:54 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:54:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        gor@linux.ibm.com
Subject: Re: [PATCH v6 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20190902145445.GA12400@lakrids.cambridge.arm.com>
References: <20190902112028.23773-1-dja@axtens.net>
 <20190902112028.23773-2-dja@axtens.net>
 <20190902132220.GA9922@lakrids.cambridge.arm.com>
 <87pnkiu5ta.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnkiu5ta.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:32:49AM +1000, Daniel Axtens wrote:
> Hi Mark,
> 
> >> +static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> >> +					void *unused)
> >> +{
> >> +	unsigned long page;
> >> +
> >> +	page = (unsigned long)__va(pte_pfn(*ptep) << PAGE_SHIFT);
> >> +
> >> +	spin_lock(&init_mm.page_table_lock);
> >> +
> >> +	if (likely(!pte_none(*ptep))) {
> >> +		pte_clear(&init_mm, addr, ptep);
> >> +		free_page(page);
> >> +	}
> >> +	spin_unlock(&init_mm.page_table_lock);
> >> +
> >> +	return 0;
> >> +}
> >
> > There needs to be TLB maintenance after unmapping the page, but I don't
> > see that happening below.
> >
> > We need that to ensure that errant accesses don't hit the page we're
> > freeing and that new mappings at the same VA don't cause a TLB conflict
> > or TLB amalgamation issue.
> 
> Darn it, I knew there was something I forgot to do! I thought of that
> over the weekend, didn't write it down, and then forgot it when I went
> to respin the patches. You're totally right.
> 
> >
> >> +/*
> >> + * Release the backing for the vmalloc region [start, end), which
> >> + * lies within the free region [free_region_start, free_region_end).
> >> + *
> >> + * This can be run lazily, long after the region was freed. It runs
> >> + * under vmap_area_lock, so it's not safe to interact with the vmalloc/vmap
> >> + * infrastructure.
> >> + */
> >
> > IIUC we aim to only free non-shared shadow by aligning the start
> > upwards, and aligning the end downwards. I think it would be worth
> > mentioning that explicitly in the comment since otherwise it's not
> > obvious how we handle races between alloc/free.
> >
> 
> Oh, I will need to think through that more carefully.
> 
> I think the vmap_area_lock protects us against alloc/free races.

AFAICT, on the alloc side we only hold the vmap_area_lock while
allocating the area in __get_vm_area_node(), but we don't holding the
vmap_area_lock while we populate the page tables for the shadow in
kasan_populate_vmalloc().

So I believe that kasan_populate_vmalloc() can race with
kasan_release_vmalloc().

> I think alignment operates at least somewhat as you've described, and
> while it is important for correctness, I'm not sure I'd say it
> prevented races? I will double check my understanding of
> vmap_area_lock, and I agree the comment needs to be much clearer.

I had assumed that you were trying to only free pages which were
definitely not shared (for which there couldn't possibly be a race to
allocate), by looking at the sibling areas to see if they potentially
overlapped.

Was that not the case?

Thanks,
Mark.
