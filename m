Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD1C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BAA21473
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="D0gkXfvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfFGPiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:38:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46830 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfFGPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:38:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so2218815ote.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcG5IedHGloYtWaZ2NXDJbgK5lW1wffyVIm8nK8XNL8=;
        b=D0gkXfvJlxpWXNGx//EyIdVHW1yvFU/3vOxqZ1xoK0Y88ymwqyfBbwxJ60khqe20bB
         41Lq865tmc+Z581Ydstm0KlBkhqrGIt7t1Hd+Smzna8g0c4u2JW9cljEfJOkdXcUu0yu
         HECdLtU3JUkpCzqeKGGNMTqUA4mWzSc/Bd2E1qcXuSHSYNSD1H/bZTnySOvtDwGeixly
         UZF5Ux1rBl428I5Xg768mZYdR0XelT0b8MdJUbSC0K0RfMV6114Rc9RxuEMBmbRpxXsF
         uca1RAkXnEtBhs2G35NCYm5hjh7//DbhIvyno9pPoG1tVg4OpT0l2NX8BXxyCdg9dtOP
         oVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcG5IedHGloYtWaZ2NXDJbgK5lW1wffyVIm8nK8XNL8=;
        b=UjQihxJ9pvD5weZfrDnSRyTCTjx3HIQ4xgPACWGm1c6iH2L1BKnULbYvazu0E2TpKN
         c0tEloOqNdEh5XgywSx66xgrSqznTtjBJz4bZsTb40EyqNq0ZWrFElRdxof47KE+s8iS
         hyl2Y0rfXz56i/Is7bdfsCi8ZV5n2N5iOFuK/of7M/WnrNap8Pi7gBWTZL3j6oWe/IaN
         ocAhw4wc+IGU41EBv2uFtOVr6ud2EjwSicGZY+48ObjtAxdZV5mtpXqYwNPuC242ABAS
         0Q7jcNSndpmNrsGDu3iELioP1cdRbrBYUxWc9wulpoD7tzhcUjdjRW21Ar2C3vY3WZAd
         4NeA==
X-Gm-Message-State: APjAAAWkP1iLp2jEIJdhKW7s47XtOc7LDeDgIGAmE86MDJEXPFejICIz
        ADmMtKBLwXaqIc6hik5ynKYyMa9SUMxhA9jHZUPmiQ==
X-Google-Smtp-Source: APXvYqzEpslVqx/+j2jKPs/1/5uH3GJvYKkpgmgk16yOVLC+OVzONnAoS20L02NzGdFQ2EErM7fk9rg512LmNaDxFFA=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr17749465otn.247.1559921901324;
 Fri, 07 Jun 2019 08:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977192280.2443951.13941265207662462739.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190607083351.GA5342@linux>
In-Reply-To: <20190607083351.GA5342@linux>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 08:38:10 -0700
Message-ID: <CAPcyv4hgmjUvA0+uMWYJibmgSWtoLw7zM-jFuP7eRdU2xyVxOw@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] mm/sparsemem: Support sub-section hotplug
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

On Fri, Jun 7, 2019 at 1:34 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jun 05, 2019 at 02:58:42PM -0700, Dan Williams wrote:
> > The libnvdimm sub-system has suffered a series of hacks and broken
> > workarounds for the memory-hotplug implementation's awkward
> > section-aligned (128MB) granularity. For example the following backtrace
> > is emitted when attempting arch_add_memory() with physical address
> > ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
> > within a given section:
> >
> >  WARNING: CPU: 0 PID: 558 at kernel/memremap.c:300 devm_memremap_pages+0x3b5/0x4c0
> >  devm_memremap_pages attempted on mixed region [mem 0x200000000-0x2fbffffff flags 0x200]
> >  [..]
> >  Call Trace:
> >    dump_stack+0x86/0xc3
> >    __warn+0xcb/0xf0
> >    warn_slowpath_fmt+0x5f/0x80
> >    devm_memremap_pages+0x3b5/0x4c0
> >    __wrap_devm_memremap_pages+0x58/0x70 [nfit_test_iomap]
> >    pmem_attach_disk+0x19a/0x440 [nd_pmem]
> >
> > Recently it was discovered that the problem goes beyond RAM vs PMEM
> > collisions as some platform produce PMEM vs PMEM collisions within a
> > given section. The libnvdimm workaround for that case revealed that the
> > libnvdimm section-alignment-padding implementation has been broken for a
> > long while. A fix for that long-standing breakage introduces as many
> > problems as it solves as it would require a backward-incompatible change
> > to the namespace metadata interpretation. Instead of that dubious route
> > [1], address the root problem in the memory-hotplug implementation.
> >
> > [1]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/memory_hotplug.h |    2
> >  mm/memory_hotplug.c            |    7 -
> >  mm/page_alloc.c                |    2
> >  mm/sparse.c                    |  225 +++++++++++++++++++++++++++-------------
> >  4 files changed, 155 insertions(+), 81 deletions(-)
> >
> [...]
> > @@ -325,6 +332,15 @@ static void __meminit sparse_init_one_section(struct mem_section *ms,
> >               unsigned long pnum, struct page *mem_map,
> >               struct mem_section_usage *usage)
> >  {
> > +     /*
> > +      * Given that SPARSEMEM_VMEMMAP=y supports sub-section hotplug,
> > +      * ->section_mem_map can not be guaranteed to point to a full
> > +      *  section's worth of memory.  The field is only valid / used
> > +      *  in the SPARSEMEM_VMEMMAP=n case.
> > +      */
> > +     if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> > +             mem_map = NULL;
>
> Will this be a problem when reading mem_map with the crash-tool?
> I do not expect it to be, but I am not sure if crash internally tries
> to read ms->section_mem_map and do some sort of translation.
> And since ms->section_mem_map SECTION_HAS_MEM_MAP, it might be that it expects
> a valid mem_map?

I don't know, but I can't imagine it would because it's much easier to
do mem_map relative translations by simple PAGE_OFFSET arithmetic.

> > +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > +             struct vmem_altmap *altmap)
> > +{
> > +     DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > +     DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> > +     struct mem_section *ms = __pfn_to_section(pfn);
> > +     bool early_section = is_early_section(ms);
> > +     struct page *memmap = NULL;
> > +     unsigned long *subsection_map = ms->usage
> > +             ? &ms->usage->subsection_map[0] : NULL;
> > +
> > +     subsection_mask_set(map, pfn, nr_pages);
> > +     if (subsection_map)
> > +             bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > +
> > +     if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> > +                             "section already deactivated (%#lx + %ld)\n",
> > +                             pfn, nr_pages))
> > +             return;
> > +
> > +     /*
> > +      * There are 3 cases to handle across two configurations
> > +      * (SPARSEMEM_VMEMMAP={y,n}):
> > +      *
> > +      * 1/ deactivation of a partial hot-added section (only possible
> > +      * in the SPARSEMEM_VMEMMAP=y case).
> > +      *    a/ section was present at memory init
> > +      *    b/ section was hot-added post memory init
> > +      * 2/ deactivation of a complete hot-added section
> > +      * 3/ deactivation of a complete section from memory init
> > +      *
> > +      * For 1/, when subsection_map does not empty we will not be
> > +      * freeing the usage map, but still need to free the vmemmap
> > +      * range.
> > +      *
> > +      * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> > +      */
> > +     bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > +     if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> > +             unsigned long section_nr = pfn_to_section_nr(pfn);
> > +
> > +             if (!early_section) {
> > +                     kfree(ms->usage);
> > +                     ms->usage = NULL;
> > +             }
> > +             memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > +             ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
> > +     }
> > +
> > +     if (early_section && memmap)
> > +             free_map_bootmem(memmap);
> > +     else
> > +             depopulate_section_memmap(pfn, nr_pages, altmap);
> > +}
> > +
> > +static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > +             unsigned long nr_pages, struct vmem_altmap *altmap)
> > +{
> > +     DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > +     struct mem_section *ms = __pfn_to_section(pfn);
> > +     struct mem_section_usage *usage = NULL;
> > +     unsigned long *subsection_map;
> > +     struct page *memmap;
> > +     int rc = 0;
> > +
> > +     subsection_mask_set(map, pfn, nr_pages);
> > +
> > +     if (!ms->usage) {
> > +             usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> > +             if (!usage)
> > +                     return ERR_PTR(-ENOMEM);
> > +             ms->usage = usage;
> > +     }
> > +     subsection_map = &ms->usage->subsection_map[0];
> > +
> > +     if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> > +             rc = -EINVAL;
> > +     else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> > +             rc = -EEXIST;
> > +     else
> > +             bitmap_or(subsection_map, map, subsection_map,
> > +                             SUBSECTIONS_PER_SECTION);
> > +
> > +     if (rc) {
> > +             if (usage)
> > +                     ms->usage = NULL;
> > +             kfree(usage);
> > +             return ERR_PTR(rc);
> > +     }
>
> We should not be really looking at subsection_map stuff when running on
> !CONFIG_SPARSE_VMEMMAP, right?
> Would it make sense to hide the bitmap dance behind
>
> if(IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)) ?
>
> Sorry for nagging here

No worries, its a valid question. The bitmap dance is still valid it
will just happen on section boundaries instead of subsection. If
anything breaks that's beneficial additional testing that we got from
the SPARSEMEM sub-case for the SPARSEMEM_VMEMMAP superset-case. That's
the gain for keeping them unified, what's the practical gain from
hiding this bit manipulation from the SPARSEMEM case?

>
> >  /**
> > - * sparse_add_one_section - add a memory section
> > + * sparse_add_section - add a memory section, or populate an existing one
> >   * @nid: The node to add section on
> >   * @start_pfn: start pfn of the memory range
> > + * @nr_pages: number of pfns to add in the section
> >   * @altmap: device page map
> >   *
> >   * This is only intended for hotplug.
>
> Below this, the return codes are specified:
>
> ---
>  * Return:
>  * * 0          - On success.
>  * * -EEXIST    - Section has been present.
>  * * -ENOMEM    - Out of memory.
>  */
> ---
>
> We can get rid of -EEXIST since we do not return that anymore.

Good catch.
