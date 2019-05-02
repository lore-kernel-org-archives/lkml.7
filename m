Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68952206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NXrhseMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfEBOD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:03:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37972 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:03:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so2158211otp.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Euj/oOqbk9HuxRwDBjqia2Fr0aJCycnpu+F/zXaFzrk=;
        b=NXrhseMIXgWPGIFhlyc9Z/V4XXm1FlHayGm9On9S2QTFx1WGXViWNUmeSC1crrBq/9
         9KH14pIGNUqvbPv6FRwdD9xzBoryGcD0XT5mc3ccb3Ch4tlYtDOFtjEw8X0eeKOTlW7X
         2eu90LpR4ryOOpxkPlWd5XKCh8alHeMP5WhrZgm4q49tG60hm64olKpHPL/lkjB7aQj7
         GWkToFdWhjFK6F7I90cr69Vt4f8asXc+UbvPJWC9B827dUaKj3O0Zi4Eojxm+mkwC4qs
         /61HOWmpEQOWXvVZIQjNDilixOOdf5PWS3fV5m9RZ6UCYzU5Zx4qxlDKH7BJPXpudCpI
         geyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Euj/oOqbk9HuxRwDBjqia2Fr0aJCycnpu+F/zXaFzrk=;
        b=Rv9pNO5Oj3jRq9s4tCUloGejZsnyVpoiw7nAvh84lmVchKWLrhSceq6jQEV70BAJHN
         K/XNlqpCDfNxdR70usHtQRb37yLaYxmBbowgMYIC3CHySPvCt7IYAuQF4V6qj5QbqGwD
         QTRxmeMQOyzID5WX5dSVGOwqWkwzOP4wIh9NGlW4OeU+zgxoveEZORoRUDTata1I65SN
         WcISKWSUtsDOWRfE6sv6ILn3RpSpB6n4sv1qmh6GSEPEJhiia7YEGDAGRDbYSxaMCsDD
         ADaxNyYxjuqzf63tyd96h9Or81zSBVzj/27njMf1DDtHPq6jUwjCLAuRYNbS/rKSoqVQ
         GOBw==
X-Gm-Message-State: APjAAAXzt3oqh8klR37sM+bAvphKlxA1/gW1YfoltmQILRr1gn23cEn0
        TCW22wHMVs6wKgQlbWSNAeaqNMl12F/yLCdKVTEqKNHi6GI=
X-Google-Smtp-Source: APXvYqweuc2pQKNZE3EnaRW+bSeokBQ4JRwB71yyAF/tr2iarU5tGWhqAgHvmoE0NT4f1XcWY0zKcbOKL4pbCPmXjHM=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr1629780otn.367.1556805835280;
 Thu, 02 May 2019 07:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190502074803.GA3495@linux>
In-Reply-To: <20190502074803.GA3495@linux>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 May 2019 07:03:45 -0700
Message-ID: <CAPcyv4jPG56sf4hHaKEoacQbDEpcMrr4fJVEwkxGjcWcCmieNQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jane Chu <jane.chu@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 12:48 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, May 01, 2019 at 10:55:37PM -0700, Dan Williams wrote:
> > Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> > section active bitmask, each bit representing 2MB (SECTION_SIZE (128M) /
> > map_active bitmask length (64)). If it turns out that 2MB is too large
> > of an active tracking granularity it is trivial to increase the size of
> > the map_active bitmap.
> >
> > The implications of a partially populated section is that pfn_valid()
> > needs to go beyond a valid_section() check and read the sub-section
> > active ranges from the bitmask.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Tested-by: Jane Chu <jane.chu@oracle.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Unfortunately I did not hear back about the comments/questions I made for this
> in the previous version.

Apologies, yes, will incorporate.

>
> > ---
> >  include/linux/mmzone.h |   29 ++++++++++++++++++++++++++++-
> >  mm/page_alloc.c        |    4 +++-
> >  mm/sparse.c            |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 6726fc175b51..cffde898e345 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1175,6 +1175,8 @@ struct mem_section_usage {
> >       unsigned long pageblock_flags[0];
> >  };
> >
> > +void section_active_init(unsigned long pfn, unsigned long nr_pages);
> > +
> >  struct page;
> >  struct page_ext;
> >  struct mem_section {
> > @@ -1312,12 +1314,36 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
> >
> >  extern int __highest_present_section_nr;
> >
> > +static inline int section_active_index(phys_addr_t phys)
> > +{
> > +     return (phys & ~(PA_SECTION_MASK)) / SECTION_ACTIVE_SIZE;
> > +}
> > +
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> > +{
> > +     int idx = section_active_index(PFN_PHYS(pfn));
> > +
> > +     return !!(ms->usage->map_active & (1UL << idx));
>
> section_active_mask() also converts the value to address/size.
> Why do we need to convert the values and we cannot work with pfn/pages instead?
> It should be perfectly possible unless I am missing something.
>
> The only thing required would be to export earlier your:
>
> +#define PAGES_PER_SUB_SECTION (SECTION_ACTIVE_SIZE / PAGE_SIZE)
> +#define PAGE_SUB_SECTION_MASK (~(PAGES_PER_SUB_SECTION-1))
>
> and change section_active_index to:
>
> static inline int section_active_index(unsigned long pfn)
> {
>         return (pfn & ~(PAGE_SECTION_MASK)) / SUB_SECTION_ACTIVE_PAGES;
> }
>
> In this way we do need to shift the values every time and we can work with them
> directly.
> Maybe you made it work this way because a reason I am missing.
>
> > +static unsigned long section_active_mask(unsigned long pfn,
> > +             unsigned long nr_pages)
> > +{
> > +     int idx_start, idx_size;
> > +     phys_addr_t start, size;
> > +
> > +     if (!nr_pages)
> > +             return 0;
> > +
> > +     start = PFN_PHYS(pfn);
> > +     size = PFN_PHYS(min(nr_pages, PAGES_PER_SECTION
> > +                             - (pfn & ~PAGE_SECTION_MASK)));
>
> It seems to me that we already picked the lowest value back in
> section_active_init, so we should be fine if we drop the min() here?
>
> Another thing is why do we need to convert the values to address/size, and we
> cannot work with pfns/pages.
> Unless I am missing something it should be possible.

Right, I believe the physical address conversion was a holdover from a
previous version and these helpers can be cleaned up to be pfn based,
good catch.

>
> > +     size = ALIGN(size, SECTION_ACTIVE_SIZE);
> > +
> > +     idx_start = section_active_index(start);
> > +     idx_size = section_active_index(size);
> > +
> > +     if (idx_size == 0)
> > +             return -1;
>
> Maybe we would be better off converting that -1 into something like "FULL_SECTION",
> or at least dropping a comment there that "-1" means that the section is fully
> populated.

Agreed, I'll add a #define.

Thanks Oscar.
