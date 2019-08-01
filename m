Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E24CC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2521726
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564646653;
	bh=iJ/jDfwskDyOu7dIT3HxTBTvS8lKujAL4owl/fbXJzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bJsIGnoLk9DvmbLfLoje97JygBd9BRHzoyFa/pSHCZYTcDvPL7W+2DJc1AJxkzXce
	 dRxMBlxnbqM2asueTa/lLPdPZoRjqXq2iwY1hsLXsUQX2sS7XIWYYRXGqjvwvCh+xa
	 +A0DkyjrjKq/LyewgIaMju1qvQ3T5AkFDQpV/UjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfHAIEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:04:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbfHAIEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:04:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 468E0AC91;
        Thu,  1 Aug 2019 08:04:10 +0000 (UTC)
Date:   Thu, 1 Aug 2019 10:04:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rashmica Gupta <rashmica.g@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190801080407.GJ11627@dhcp22.suse.cz>
References: <20190702074806.GA26836@linux>
 <CAC6rBskRyh5Tj9L-6T4dTgA18H0Y8GsMdC-X5_0Jh1SVfLLYtg@mail.gmail.com>
 <20190731120859.GJ9330@dhcp22.suse.cz>
 <4ddee0dd719abd50350f997b8089fa26f6004c0c.camel@gmail.com>
 <20190801071709.GE11627@dhcp22.suse.cz>
 <9bcbd574-7e23-5cfe-f633-646a085f935a@redhat.com>
 <20190801072430.GF11627@dhcp22.suse.cz>
 <e654aa97-6ab1-4069-60e6-fc099539729e@redhat.com>
 <20190801073407.GG11627@dhcp22.suse.cz>
 <7c12f0b1-61a5-ed6f-2c64-4058e47860a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c12f0b1-61a5-ed6f-2c64-4058e47860a3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 09:50:29, David Hildenbrand wrote:
> On 01.08.19 09:34, Michal Hocko wrote:
> > On Thu 01-08-19 09:26:35, David Hildenbrand wrote:
> >> On 01.08.19 09:24, Michal Hocko wrote:
> >>> On Thu 01-08-19 09:18:47, David Hildenbrand wrote:
> >>>> On 01.08.19 09:17, Michal Hocko wrote:
> >>>>> On Thu 01-08-19 09:06:40, Rashmica Gupta wrote:
> >>>>>> On Wed, 2019-07-31 at 14:08 +0200, Michal Hocko wrote:
> >>>>>>> On Tue 02-07-19 18:52:01, Rashmica Gupta wrote:
> >>>>>>> [...]
> >>>>>>>>> 2) Why it was designed, what is the goal of the interface?
> >>>>>>>>> 3) When it is supposed to be used?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>> There is a hardware debugging facility (htm) on some power chips.
> >>>>>>>> To use
> >>>>>>>> this you need a contiguous portion of memory for the output to be
> >>>>>>>> dumped
> >>>>>>>> to - and we obviously don't want this memory to be simultaneously
> >>>>>>>> used by
> >>>>>>>> the kernel.
> >>>>>>>
> >>>>>>> How much memory are we talking about here? Just curious.
> >>>>>>
> >>>>>> From what I've seen a couple of GB per node, so maybe 2-10GB total.
> >>>>>
> >>>>> OK, that is really a lot to keep around unused just in case the
> >>>>> debugging is going to be used.
> >>>>>
> >>>>> I am still not sure the current approach of (ab)using memory hotplug is
> >>>>> ideal. Sure there is some overlap but you shouldn't really need to
> >>>>> offline the required memory range at all. All you need is to isolate the
> >>>>> memory from any existing user and the page allocator. Have you checked
> >>>>> alloc_contig_range?
> >>>>>
> >>>>
> >>>> Rashmica mentioned somewhere in this thread that the virtual mapping
> >>>> must not be in place, otherwise the HW might prefetch some of this
> >>>> memory, leading to errors with memtrace (which checks that in HW).
> >>>
> >>> Does anything prevent from unmapping the pfn range from the direct
> >>> mapping?
> >>
> >> I am not sure about the implications of having
> >> pfn_valid()/pfn_present()/pfn_online() return true but accessing it
> >> results in crashes. (suspend, kdump, whatever other technology touches
> >> online memory)
> > 
> > If those pages are marked as Reserved then nobody should be touching
> > them anyway.
> 
> Which is not true as I remember we already discussed - I even documented
> what PG_reserved can mean after that discussion in page-flags.h (e.g.,
> memmap of boot memory) - that's why we introduced PG_offline after all.

Sorry, my statement was imprecise. What I meant is what we have
documented:
 * PG_reserved is set for special pages. The "struct page" of such a page
 * should in general not be touched (e.g. set dirty) except by its owner.

the owner part is important.
-- 
Michal Hocko
SUSE Labs
