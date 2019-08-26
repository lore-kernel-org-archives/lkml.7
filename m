Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E7C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F11020874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566804330;
	bh=9e+p/BWsx25dSVUNZKmdugGuWVVrFYNsrSAhvu7HR30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nflXkz9DYWpR8vqZ1dcAQuILnLj9+Z1SqPmOhMnNsPTkPF3CiGZFQBTU+guHXwnUi
	 4Fo00heHYjLLDevHe/+FCcswNM56+I0Fgl91nG21htt37TXsqBC+BKxOAKGc/LJOt3
	 qbOwheGbsiJtfRJVKYJ9Ss7mV0E1OoIuKtSks9+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfHZHZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:25:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727963AbfHZHZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:25:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29254ADF1;
        Mon, 26 Aug 2019 07:25:27 +0000 (UTC)
Date:   Mon, 26 Aug 2019 09:25:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        pankaj.suryawanshi@einfochips.com
Subject: Re: How cma allocation works ?
Message-ID: <20190826072526.GC7538@dhcp22.suse.cz>
References: <CACDBo56W1JGOc6w-NAf-hyWwJQ=vEDsAVAkO8MLLJBpQ0FTAcA@mail.gmail.com>
 <20190822130219.GK12785@dhcp22.suse.cz>
 <CACDBo57oFDEYY-GR1NEZEXKS409BkEx+RYywMNwuUn5f5Sz76A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo57oFDEYY-GR1NEZEXKS409BkEx+RYywMNwuUn5f5Sz76A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-08-19 00:17:22, Pankaj Suryawanshi wrote:
> On Thu, Aug 22, 2019 at 6:32 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 21-08-19 22:58:03, Pankaj Suryawanshi wrote:
> > > Hello,
> > >
> > > Hard time to understand cma allocation how differs from normal
> > > allocation ?
> >
> > The buddy allocator which is built for order-N sized allocations and it
> > is highly optimized because it used from really hot paths. The allocator
> > also involves memory reclaim to get memory when there is none
> > immediatelly available.
> >
> > CMA allocator operates on a pre reserved physical memory range(s) and
> > focuses on allocating areas that require physically contigous memory of
> > larger sizes. Very broadly speaking. LWN usually contains nice writeups
> > for many kernel internals. E.g. quick googling pointed to
> > https://lwn.net/Articles/486301/
> >
> > > I know theoretically how cma works.
> > >
> > > 1. How it reserved the memory (start pfn to end pfn) ? what is bitmap_*
> > > functions ?
> >
> > Not sure what you are asking here TBH
> I know it reserved memory at boot time from start pfn to end pfn, but when
> i am requesting memory from cma it has different bitmap_*() in cma_alloc()
> what they are ?
> because we pass pfn and pfn+count to alloc_contig_range and pfn is come
> from bitmap_*() function.
> lets say i have reserved 100MB cma memory at boot time (strart pfn to end
> pfn) and i am requesting allocation of 30MB from cma area then what is pfn
> passed to alloc_contig_range() it is same as start pfn or
> different.(calucaled by bitmap_*()) ?

I am not deeply familiar with the CMA implementation but from a very
brief look it seems that the bitmap simply denotes which portions of the
reserved area are used and therefore it is easy to find portions of the
requested size by scanning it.

> > Have you checked the code? It simply tries to reclaim and/or migrate
> > pages off the pfn range.
> >
> What is difference between migration, isolation and reclamation of pages ?

Isolation will set the migrate type to MIGRATE_ISOLATE, btw the comment
in the code I referred to says this:
 * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
 * the range will never be allocated. Any free pages and pages freed in the
 * future will not be allocated again. If specified range includes migrate types
 * other than MOVABLE or CMA, this will fail with -EBUSY. For isolating all
 * pages in the range finally, the caller have to free all pages in the range.
 * test_page_isolated() can be used for test it.

Reclaim part will simply drop all pages that are easily reclaimable
(e.g. a clean pagecache) and migration will move existing allocations to
a different physical location + update references to it from other data
structures (e.g. page tables to point to a new location).

> > > 5.what isolate_migratepages_range(), reclaim_clean_pages_from_list(),
> > >  migrate_pages() and shrink_page_list() is doing ?
> >
> > Again, have you checked the code/comments? What exactly is not clear?
> >
> Why again migrate_isolate_range() ?
> (reclaim_clean_pages_fron_list) if we are reclaiming only clean pages then
> pages will not contiguous ? we have only clean pages which are not
> contiguous ?

reclaim_clean_pages_from_list is a simple wrapper on top of shrink_page_list.
It simply takes clean page cache pages to reclaim it because that might
be less expensive than migrating that memory.

> What is work of shrink_page_list() ?

This is a core of the memory reclaim. It unmaps/frees pages and try to
free them.

> please explain all flow with taking
> one allocation for example let say reserved cma 100MB and then request
> allocation of 30MB then how all the flow/function will work ?

I would recommend to read the code carefully and following the git
history of the code is very helpful as well. This is not a rocket
science, really.
-- 
Michal Hocko
SUSE Labs
