Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0EDC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122B2217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Zt8jGCiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfEJTi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:38:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37393 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfEJTi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:38:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id 143so5377922oii.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zZWqRpm0G05NjcSiIIAbzIcEiDmVjoOHWcOK0h9db0=;
        b=Zt8jGCiU6tsVp+EvLvEH/lbyUyD0S8Rz6P6AcA7tfrddxC67ogCCxcpPcWKqgoNncU
         u26bqCA1xFFK3nyrZN3NSXUnii3hhRz1OnCgLU3OXi6fDoMD5goKG2VunEj/pVe4FDNR
         QWnGG1KfiHfJLEKn0I9/4BJxx+uOFgBoX9aBBimHHlyeYvWdcOJyEhcMttB9M8QYkZLH
         MS3cw9AXYX4vA5p5vI7ijwbkyNNbhf0SFF8kFb3hQfgh5pyEgogzeKxd+k4VgtyD3l1c
         7WAqnGYDb0k77o8owtjnxY+4cVmWwK1z8YK89qYEpPpQWF45MSURi+S4GYD5g23Yj2rm
         ZtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zZWqRpm0G05NjcSiIIAbzIcEiDmVjoOHWcOK0h9db0=;
        b=n7l6sN6EtOEtZ57tADoPIABSp/lcDt5KI8A77Vj5ZO+r+hyZQu2HV0Rvpis4q06XEw
         m70n2skjVrfDuGGaIZ79orFCRL3dZ69yR0tgYfjVKVU/UkChe4OWGLzcSfVsEy5Yx/Bq
         lDa9qcQUnOYTxrLKgNq8q6/oyRTvh1F5mIszjWrZmqbSzsa4bOyV2hBr1tqBjYOMR7nE
         VC6ixLi1Kzzx6Y/WzhMoWkogpmUITEzD6CUNZkadlNZj2RTYATMQchL4M7xQTMyZUkQ6
         AL8pjtUEx2qzNCXnMR/iU9mA4FzvMK3X71zk6G2cGWG9EoI3N7Daq/fmmASS/Law3qiX
         Pxnw==
X-Gm-Message-State: APjAAAXgxTbWHlawSUmUbPzuNc50TBibQzz1x6kCPWMPBUs86wjOqnre
        oAo1asur9u/ByNbjjpdfZ0mBFcb5KkvNxfdiBBdP5A==
X-Google-Smtp-Source: APXvYqyXAc2U9OVVTkJlhijyyyFcw3I1yzqRpW/J5S9roDJzRnWHqxvYbqh6OC5OXma3KlWvNDW/uVv/L6RXEOBtXtU=
X-Received: by 2002:aca:de57:: with SMTP id v84mr6606243oig.149.1557517135140;
 Fri, 10 May 2019 12:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155718597192.130019.7128788290111464258.stgit@dwillia2-desk3.amr.corp.intel.com>
 <dd7b53bd986d79a94ac0b08e32336e44@suse.de>
In-Reply-To: <dd7b53bd986d79a94ac0b08e32336e44@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 May 2019 12:38:43 -0700
Message-ID: <CAPcyv4i1zQb-D-8iB3hr8ipMHH2yV8ssxh+Zeh2aeMw0ZJASfg@mail.gmail.com>
Subject: Re: [PATCH v8 01/12] mm/sparsemem: Introduce struct mem_section_usage
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        owner-linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 6:30 AM <osalvador@suse.de> wrote:
>
> On 2019-05-07 01:39, Dan Williams wrote:
> > Towards enabling memory hotplug to track partial population of a
> > section, introduce 'struct mem_section_usage'.
> >
> > A pointer to a 'struct mem_section_usage' instance replaces the
> > existing
> > pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> > 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> > house a new 'subsection_map' bitmap.  The new bitmap enables the memory
> > hot{plug,remove} implementation to act on incremental sub-divisions of
> > a
> > section.
> >
> > The default SUBSECTION_SHIFT is chosen to keep the 'subsection_map' no
> > larger than a single 'unsigned long' on the major architectures.
> > Alternatively an architecture can define ARCH_SUBSECTION_SHIFT to
> > override the default PMD_SHIFT. Note that PowerPC needs to use
> > ARCH_SUBSECTION_SHIFT to workaround PMD_SHIFT being a non-constant
> > expression on PowerPC.
> >
> > The primary motivation for this functionality is to support platforms
> > that mix "System RAM" and "Persistent Memory" within a single section,
> > or multiple PMEM ranges with different mapping lifetimes within a
> > single
> > section. The section restriction for hotplug has caused an ongoing saga
> > of hacks and bugs for devm_memremap_pages() users.
> >
> > Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> > from a section, and updates to usemap allocation path, there are no
> > expected behavior changes.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/powerpc/include/asm/sparsemem.h |    3 +
> >  include/linux/mmzone.h               |   48 +++++++++++++++++++-
> >  mm/memory_hotplug.c                  |   18 ++++----
> >  mm/page_alloc.c                      |    2 -
> >  mm/sparse.c                          |   81
> > +++++++++++++++++-----------------
> >  5 files changed, 99 insertions(+), 53 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/sparsemem.h
> > b/arch/powerpc/include/asm/sparsemem.h
> > index 3192d454a733..1aa3c9303bf8 100644
> > --- a/arch/powerpc/include/asm/sparsemem.h
> > +++ b/arch/powerpc/include/asm/sparsemem.h
> > @@ -10,6 +10,9 @@
> >   */
> >  #define SECTION_SIZE_BITS       24
> >
> > +/* Reflect the largest possible PMD-size as the subsection-size
> > constant */
> > +#define ARCH_SUBSECTION_SHIFT 24
> > +
>
> I guess this is done because PMD_SHIFT is defined at runtime rather at
> compile time,
> right?

Correct, PowerPC has:

    #define PMD_SHIFT (PAGE_SHIFT + PTE_INDEX_SIZE)
    #define PTE_INDEX_SIZE  __pte_index_size

...where __pte_index_size is variable established at kernel init time.

> >  #endif /* CONFIG_SPARSEMEM */
> >
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 70394cabaf4e..ef8d878079f9 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1160,6 +1160,44 @@ static inline unsigned long
> > section_nr_to_pfn(unsigned long sec)
> >  #define SECTION_ALIGN_UP(pfn)        (((pfn) + PAGES_PER_SECTION - 1) &
> > PAGE_SECTION_MASK)
> >  #define SECTION_ALIGN_DOWN(pfn)      ((pfn) & PAGE_SECTION_MASK)
> >
> > +/*
> > + * SUBSECTION_SHIFT must be constant since it is used to declare
> > + * subsection_map and related bitmaps without triggering the
> > generation
> > + * of variable-length arrays. The most natural size for a subsection
> > is
> > + * a PMD-page. For architectures that do not have a constant PMD-size
> > + * ARCH_SUBSECTION_SHIFT can be set to a constant max size, or
> > otherwise
> > + * fallback to 2MB.
> > + */
> > +#if defined(ARCH_SUBSECTION_SHIFT)
> > +#define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
> > +#elif defined(PMD_SHIFT)
> > +#define SUBSECTION_SHIFT (PMD_SHIFT)
> > +#else
> > +/*
> > + * Memory hotplug enabled platforms avoid this default because they
> > + * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant,
> > but
> > + * this is kept as a backstop to allow compilation on
> > + * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
> > + */
> > +#define SUBSECTION_SHIFT 21
> > +#endif
> > +
> > +#define PFN_SUBSECTION_SHIFT (SUBSECTION_SHIFT - PAGE_SHIFT)
> > +#define PAGES_PER_SUBSECTION (1UL << PFN_SUBSECTION_SHIFT)
> > +#define PAGE_SUBSECTION_MASK ((~(PAGES_PER_SUBSECTION-1)))
> > +
> > +#if SUBSECTION_SHIFT > SECTION_SIZE_BITS
> > +#error Subsection size exceeds section size
> > +#else
> > +#define SUBSECTIONS_PER_SECTION (1UL << (SECTION_SIZE_BITS -
> > SUBSECTION_SHIFT))
> > +#endif
>
> On powerpc, SUBSECTIONS_PER_SECTION will equal 1 (so one big section),
> is that to be expected?

Yes, it turns out that PowerPC has no real need for subsection support
since they were already using small 16MB sections from day one.

> Will subsection_map_init handle this right?

Yes, should work as subsection_map_index() will always return 0. Which
means that 'end' will always be 0:

    pfns = min(nr_pages, PAGES_PER_SECTION
        - (pfn & ~PAGE_SECTION_MASK));
    end = subsection_map_index(pfn + pfns - 1);

...and then the bitmap manipulation:

    bitmap_set(ms->usage->subsection_map, idx, end - idx + 1);

...will only ever set bit0.
