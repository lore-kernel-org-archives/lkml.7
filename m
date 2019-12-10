Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDBC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D762073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575971782;
	bh=grqW5MwSwh5bfeTqGe2eaMDZCFxjfCnPVlS3K00LND8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CYziBC8n9gdygYIkkeGXnmdOWA4pSHpV3LyvdW44E2phJ7HogwW2iWcK8y1jNyRDT
	 JPEMYaDQvOOUUd8AikevOf6/Iwswj9VZaCqB2y1/r5EZnv46kjM85vyi7NPr0kp17h
	 /kzwZK/V2HZoczV7w8Ohtyxs3LW+koP+SsBYWY+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLJJ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:56:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38637 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfLJJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:56:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so19277094wrh.5;
        Tue, 10 Dec 2019 01:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wiDeNqk4JUYH6LbyjP3mNqGyXwUCv0yPtvfwbu07E84=;
        b=AvZkSkayyZiR5bZRlkYLVnUBcZtoQOsZgZkxrM+X0LrkuvAbiq72iFEbzB6MutpNYL
         W7SmqP3ANY7p+WD6rbzocvhNLVcclLks3X9Cj2oDRv7sYK8oxlJ3EBvmiVbip5N9Q6jz
         8Ax0U3Qoqy2LHuMqRvlpgFtVqkEyuJi//2LcNeSUNCOn5KU+6KE6Lbn382dEzEr5KQnN
         YL45bngPQU3SI0/NuOVEqyXTYpFrprVy+kqnu3H/xncUYjm0bfWeZiqLbi5h+o8NyAT6
         nQlWtvRPT6PGk1htM8lFSLSiV2vDLMesqM/tRuA7Nb8VCY+4WQwmfPUVu1EFd/g4XCYd
         AY1g==
X-Gm-Message-State: APjAAAU1d/12fkybi+de6lst4oQjBDulGdBO2fzc2hLQ6m50kxoQE8YO
        QVJsp46K5kd2agfzkTcEeSU=
X-Google-Smtp-Source: APXvYqyOvGHL/dLqIEko15VM3eCGbjurIUWfw6wjXgmK+XRllFbX0OjTyzcaIccFUw979KzcsTh8+w==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr2324107wrr.82.1575971777315;
        Tue, 10 Dec 2019 01:56:17 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u18sm2642900wrt.26.2019.12.10.01.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:56:16 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:56:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the
 pgprot_t in arch_add_memory()
Message-ID: <20191210095615.GB10404@dhcp22.suse.cz>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <20191209204128.GC7658@dhcp22.suse.cz>
 <e0f9c1e1-4968-f48f-ec09-853fc8fc779b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f9c1e1-4968-f48f-ec09-853fc8fc779b@deltatee.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-12-19 14:24:22, Logan Gunthorpe wrote:
> 
> 
> On 2019-12-09 1:41 p.m., Michal Hocko wrote:
> > On Mon 09-12-19 13:24:19, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
> >>> On 09.12.19 20:13, Logan Gunthorpe wrote:
> >>>> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
> >>>> struct page mappings for IO memory. At present, these mappings are created
> >>>> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, on
> >>>> x86, an mtrr register will typically override this and force the cache
> >>>> type to be UC-. In the case firmware doesn't set this register it is
> >>>> effectively WB and will typically result in a machine check exception
> >>>> when it's accessed.
> >>>>
> >>>> Other arches are not currently likely to function correctly seeing they
> >>>> don't have any MTRR registers to fall back on.
> >>>>
> >>>> To solve this, add an argument to arch_add_memory() to explicitly
> >>>> set the pgprot value to a specific value.
> >>>>
> >>>> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
> >>>> simple change to pass the pgprot_t down to their respective functions
> >>>> which set up the page tables. For x86_32, set the page tables explicitly
> >>>> using _set_memory_prot() (seeing they are already mapped). For sh, reject
> >>>> anything but PAGE_KERNEL settings -- this should be fine, for now, seeing
> >>>> sh doesn't support ZONE_DEVICE anyway.
> >>>>
> >>>> Cc: Dan Williams <dan.j.williams@intel.com>
> >>>> Cc: David Hildenbrand <david@redhat.com>
> >>>> Cc: Michal Hocko <mhocko@suse.com>
> >>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>>> ---
> >>>>  arch/arm64/mm/mmu.c            | 4 ++--
> >>>>  arch/ia64/mm/init.c            | 5 ++++-
> >>>>  arch/powerpc/mm/mem.c          | 4 ++--
> >>>>  arch/s390/mm/init.c            | 4 ++--
> >>>>  arch/sh/mm/init.c              | 5 ++++-
> >>>>  arch/x86/mm/init_32.c          | 7 ++++++-
> >>>>  arch/x86/mm/init_64.c          | 4 ++--
> >>>>  include/linux/memory_hotplug.h | 2 +-
> >>>>  mm/memory_hotplug.c            | 2 +-
> >>>>  mm/memremap.c                  | 2 +-
> >>>>  10 files changed, 25 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >>>> index 60c929f3683b..48b65272df15 100644
> >>>> --- a/arch/arm64/mm/mmu.c
> >>>> +++ b/arch/arm64/mm/mmu.c
> >>>> @@ -1050,7 +1050,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
> >>>>  }
> >>>>  
> >>>>  #ifdef CONFIG_MEMORY_HOTPLUG
> >>>> -int arch_add_memory(int nid, u64 start, u64 size,
> >>>> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
> >>>>  			struct mhp_restrictions *restrictions)
> >>>
> >>> Can we fiddle that into "struct mhp_restrictions" instead?
> >>
> >> Yes, if that's what people want, it's pretty trivial to do. I chose not
> >> to do it that way because it doesn't get passed down to add_pages() and
> >> it's not really a "restriction". If I don't hear any objections, I will
> >> do that for v2.
> > 
> > I do agree that restriction is not the best fit. But I consider prot
> > argument to complicate the API to all users even though it is not really
> > clear whether we are going to have many users really benefiting from it.
> > Look at the vmalloc API and try to find how many users of __vmalloc do
> > not use PAGE_KERNEL.
> > 
> > So I can see two options. One of them is to add arch_add_memory_prot
> > that would allow to have give and extra prot argument or simply call
> > an arch independent API to change the protection after arch_add_memory.
> > The later sounds like much less code. The memory shouldn't be in use by
> > anybody at that stage yet AFAIU. Maybe there even is an API like that.
> 
> Yes, well, we tried something like this by calling set_memory_wc()
> inside memremap_pages(); but on large bars (tens of GB) it was too slow
> (taking several seconds to complete) and on some hosts actually hit CPU
> watchdog errors.

Which looks like something to fix independently.

> So at the very least we'd have to add some cpu_relax() calls to that
> path. And it's also the case that set_memory_wc() is x86 only right now.
> So we'd have to create a new general interface to walk and fixup page
> tables for all arches.
> 
> But, in my opinion, setting up all those page tables twice is too large
> of an overhead and it's better to just add them correctly the first
> time. The changes I propose to do this aren't really a lot of code and
> probably less than creating a new interface for all arches.

OK, fair enough. Then I would suggest going with arch_add_memory_prot
then unless there is a wider disagreement witht that.
-- 
Michal Hocko
SUSE Labs
