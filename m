Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8289AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2472083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Gz7G1JiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfFFSQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:16:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44628 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfFFSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:16:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so2831948otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFTusPVhpfiYDlM0cF7USTGMzoOymuyGD1PoRmf3vY4=;
        b=Gz7G1JiJnLX/6xII/oyzd8Mk94n6nVLGrgbdbhDqr4Dis4ST4qcabAQL+i/iKj5gyq
         ErzL+a3p6d1VkNlfwAuwWnGsTu2M/ET/by+e8dWL05Gt4vg3jMlOAufnxyapEzib6TlN
         hLONYh8TIEvqZ+KQGcAQXHcbapftgGvXItMjTZMux1pD5Ov1cFWfZ63uGBq4Tyd4+ZmC
         HQPYUSTgJUBHOcDcyazfWZv0D5dVEFX5zu5JI8Z1d4Ho3rsHvETHnmo5LcaG4TYaaIkq
         xFz16zm3QydA/VBCMGuYmQZkMstuNeFMgfwP+tPC8uUdiMD+iSJdw1LZm/ClHFq0HxDe
         fNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFTusPVhpfiYDlM0cF7USTGMzoOymuyGD1PoRmf3vY4=;
        b=FcIIbaq/zObxVnmVcY9n8i7rDCWueMSYHPWpVk4dYRhz17PaSA0rLaRz5TR1n7qaRn
         fwiYhdmERwyaniUa57HKUmphStCpVkaUjybcoLbiXotPj57pZ7qoh7s9hUAFf6LeEJfJ
         LpeB3NaQrPm6ag+Q0JEUr79+RErLrb0+glmIdEbA2Q/2DaxM4UVtmSy6kZm9zb6ikYSQ
         ciDRhEMsCJ54nmQMYoskNVQB9s7jZqqSyiY1rehdx8VHMhyQNiznkP16ndWPt/ntY+ye
         7+gX036hn+sSiejVf2kv8KmAN3vVCL11dwXoWC4iV4tr8t3HblCr8z9u0xpQAd15gPZE
         asew==
X-Gm-Message-State: APjAAAUvzfJckwMRkgCo/QZuAMMGfS9Jv0MfEUPR6Rha0RnwS1/aSRmM
        smyuieK1NR5pLiN1fh7NJsfOmx5o9mO4Tc3bO5gr+g==
X-Google-Smtp-Source: APXvYqzq12PqN/4fGA6npNZeNZT1mnGgPW8x4nWGby/gAe0sYyFomK8fvZ89O7QQ/4vBEBBt6v4K/FhuFrg/EXjx2EA=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr15628006otr.207.1559845003058;
 Thu, 06 Jun 2019 11:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977191770.2443951.1506588644989416699.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190606172110.GC31194@linux>
In-Reply-To: <20190606172110.GC31194@linux>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Jun 2019 11:16:31 -0700
Message-ID: <CAPcyv4jy-TN9xzWd_tJW0ezbZoXJCQozWwcQcTfJwzTcy2BGMQ@mail.gmail.com>
Subject: Re: [PATCH v9 07/12] mm/sparsemem: Prepare for sub-section ranges
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 10:21 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jun 05, 2019 at 02:58:37PM -0700, Dan Williams wrote:
> > Prepare the memory hot-{add,remove} paths for handling sub-section
> > ranges by plumbing the starting page frame and number of pages being
> > handled through arch_{add,remove}_memory() to
> > sparse_{add,remove}_one_section().
> >
> > This is simply plumbing, small cleanups, and some identifier renames. No
> > intended functional changes.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/memory_hotplug.h |    5 +-
> >  mm/memory_hotplug.c            |  114 +++++++++++++++++++++++++---------------
> >  mm/sparse.c                    |   15 ++---
> >  3 files changed, 81 insertions(+), 53 deletions(-)
> >
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 79e0add6a597..3ab0282b4fe5 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -348,9 +348,10 @@ extern int add_memory_resource(int nid, struct resource *resource);
> >  extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> >               unsigned long nr_pages, struct vmem_altmap *altmap);
> >  extern bool is_memblock_offlined(struct memory_block *mem);
> > -extern int sparse_add_one_section(int nid, unsigned long start_pfn,
> > -                               struct vmem_altmap *altmap);
> > +extern int sparse_add_section(int nid, unsigned long pfn,
> > +             unsigned long nr_pages, struct vmem_altmap *altmap);
> >  extern void sparse_remove_one_section(struct mem_section *ms,
> > +             unsigned long pfn, unsigned long nr_pages,
> >               unsigned long map_offset, struct vmem_altmap *altmap);
> >  extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
> >                                         unsigned long pnum);
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 4b882c57781a..399bf78bccc5 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -252,51 +252,84 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> >  }
> >  #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
> >
> > -static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
> > -                                struct vmem_altmap *altmap)
> > +static int __meminit __add_section(int nid, unsigned long pfn,
> > +             unsigned long nr_pages, struct vmem_altmap *altmap)
> >  {
> >       int ret;
> >
> > -     if (pfn_valid(phys_start_pfn))
> > +     if (pfn_valid(pfn))
> >               return -EEXIST;
> >
> > -     ret = sparse_add_one_section(nid, phys_start_pfn, altmap);
> > +     ret = sparse_add_section(nid, pfn, nr_pages, altmap);
> >       return ret < 0 ? ret : 0;
> >  }
> >
> > +static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
> > +             const char *reason)
> > +{
> > +     /*
> > +      * Disallow all operations smaller than a sub-section and only
> > +      * allow operations smaller than a section for
> > +      * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> > +      * enforces a larger memory_block_size_bytes() granularity for
> > +      * memory that will be marked online, so this check should only
> > +      * fire for direct arch_{add,remove}_memory() users outside of
> > +      * add_memory_resource().
> > +      */
> > +     unsigned long min_align;
> > +
> > +     if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> > +             min_align = PAGES_PER_SUBSECTION;
> > +     else
> > +             min_align = PAGES_PER_SECTION;
> > +     if (!IS_ALIGNED(pfn, min_align)
> > +                     || !IS_ALIGNED(nr_pages, min_align)) {
> > +             WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
> > +                             reason, pfn, pfn + nr_pages - 1);
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
>
>
> This caught my eye.
> Back in patch#4 "Convert kmalloc_section_memmap() to populate_section_memmap()",
> you placed a mis-usage check for !CONFIG_SPARSEMEM_VMEMMAP in
> populate_section_memmap().
>
> populate_section_memmap() gets called from sparse_add_one_section(), which means
> that we should have passed this check, otherwise we cannot go further and call
> __add_section().
>
> So, unless I am missing something it seems to me that the check from patch#4 could go?
> And I think the same applies to depopulate_section_memmap()?

Yes, good catch, I can kill those extra checks in favor of this one.

> Besides that, it looks good to me:

Thanks Oscar!

>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> --
> Oscar Salvador
> SUSE L3
