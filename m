Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A3C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC5920637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575924095;
	bh=J8F8RCp9r27NoKCTUog9TaanNrMeS/DI6tbWRSvGTRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jt/LlDhIskh9aqrm/7vn33GFMbjs6QoR+5SOY+rNFXXc1FwJl+5raP48Q4dETItEl
	 VaQVz/E3QtolaBcO7s1P1i2lLZWnXsO4qo9yEZG61m2510UNCdijojZEhY820x8pvp
	 K2daw9FSTN1COlokYRrCif6zr0itxhPDRaFKcpRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLIUle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:41:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35666 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIUld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:41:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id c20so764738wmb.0;
        Mon, 09 Dec 2019 12:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSbUiS7EP2tldG1YzNxaAsQzPlJ8BCKd2KYUFJ680IM=;
        b=bBFGVIw1Ov0VGztRkBBzyf/sRFlv/tfBhiWXTZgSSAGVfkRT3/fkRRZkXies5r5CfD
         KOxTgLH8E3rf91wx6MmxQdHkXyoQVC+IvEVrTSj/4csx1zZWEY092sxtKlRa8NzxSMNx
         DWyZx6dTI8brd1yUiZxtpvAu0FcIiHVlS5wJ/U3nXshJ3F7wfKuBcIGVqY9ebqTKgmJj
         vQFUl1S4f9jUrcIvprnflg4jKSHiw2XOjd0qYPtbBEw4LrKo5pURTjVLo42LqmieIwPD
         48fgq7eiwrtuF99FKATevTA4AtSUoj0AC3Ge8M3jwpr/lIEQfzSX989W/JyLqga5HYQz
         Ddvw==
X-Gm-Message-State: APjAAAVTIHzTUcJ4QeupZ0/3no70RAN7GJFmZNjTKMRPYO3xy0uhsuJa
        PW9U0gtWokBlNSd+dcyqiGw=
X-Google-Smtp-Source: APXvYqyLft4TxSNFH48B5L3G63KfAdrp5DrYOJ1M1gqSEHOOdcj01DiA+cYxABOqwwT0LyX2UQKe5g==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr1018119wmm.24.1575924091072;
        Mon, 09 Dec 2019 12:41:31 -0800 (PST)
Received: from localhost (ip-37-188-170-11.eurotel.cz. [37.188.170.11])
        by smtp.gmail.com with ESMTPSA id p5sm668853wrt.79.2019.12.09.12.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 12:41:30 -0800 (PST)
Date:   Mon, 9 Dec 2019 21:41:28 +0100
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
Message-ID: <20191209204128.GC7658@dhcp22.suse.cz>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-12-19 13:24:19, Logan Gunthorpe wrote:
> 
> 
> On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
> > On 09.12.19 20:13, Logan Gunthorpe wrote:
> >> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
> >> struct page mappings for IO memory. At present, these mappings are created
> >> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, on
> >> x86, an mtrr register will typically override this and force the cache
> >> type to be UC-. In the case firmware doesn't set this register it is
> >> effectively WB and will typically result in a machine check exception
> >> when it's accessed.
> >>
> >> Other arches are not currently likely to function correctly seeing they
> >> don't have any MTRR registers to fall back on.
> >>
> >> To solve this, add an argument to arch_add_memory() to explicitly
> >> set the pgprot value to a specific value.
> >>
> >> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
> >> simple change to pass the pgprot_t down to their respective functions
> >> which set up the page tables. For x86_32, set the page tables explicitly
> >> using _set_memory_prot() (seeing they are already mapped). For sh, reject
> >> anything but PAGE_KERNEL settings -- this should be fine, for now, seeing
> >> sh doesn't support ZONE_DEVICE anyway.
> >>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >> ---
> >>  arch/arm64/mm/mmu.c            | 4 ++--
> >>  arch/ia64/mm/init.c            | 5 ++++-
> >>  arch/powerpc/mm/mem.c          | 4 ++--
> >>  arch/s390/mm/init.c            | 4 ++--
> >>  arch/sh/mm/init.c              | 5 ++++-
> >>  arch/x86/mm/init_32.c          | 7 ++++++-
> >>  arch/x86/mm/init_64.c          | 4 ++--
> >>  include/linux/memory_hotplug.h | 2 +-
> >>  mm/memory_hotplug.c            | 2 +-
> >>  mm/memremap.c                  | 2 +-
> >>  10 files changed, 25 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index 60c929f3683b..48b65272df15 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> >> @@ -1050,7 +1050,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
> >>  }
> >>  
> >>  #ifdef CONFIG_MEMORY_HOTPLUG
> >> -int arch_add_memory(int nid, u64 start, u64 size,
> >> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
> >>  			struct mhp_restrictions *restrictions)
> > 
> > Can we fiddle that into "struct mhp_restrictions" instead?
> 
> Yes, if that's what people want, it's pretty trivial to do. I chose not
> to do it that way because it doesn't get passed down to add_pages() and
> it's not really a "restriction". If I don't hear any objections, I will
> do that for v2.

I do agree that restriction is not the best fit. But I consider prot
argument to complicate the API to all users even though it is not really
clear whether we are going to have many users really benefiting from it.
Look at the vmalloc API and try to find how many users of __vmalloc do
not use PAGE_KERNEL.

So I can see two options. One of them is to add arch_add_memory_prot
that would allow to have give and extra prot argument or simply call
an arch independent API to change the protection after arch_add_memory.
The later sounds like much less code. The memory shouldn't be in use by
anybody at that stage yet AFAIU. Maybe there even is an API like that.
-- 
Michal Hocko
SUSE Labs
