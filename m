Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE38C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CF020652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZRcrCjA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfEBQM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:12:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45754 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfEBQM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:12:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so2591942edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmuDEks26u7TosMg6YO9rFojJhi017p7aPym+WIjY/s=;
        b=ZRcrCjA5yDrtzuhuaxGA218aPuy8sioowVXNbMz96fmtX1Q3YhAiRGlzgamPi0mAvB
         nixiSO3SdAXaNwXkkyRiwjWAOPYOnlW3ZaGc3IMwRN6X6T0kJBBIeKpYX6/gW3tvhj2v
         tvfJ/mI0Ws/aUUfRVyG59bggwQfeK8Xo8ncypTOvY/rJGjB4xOUAk10lU9CKRYTM6Nss
         qYhP5n+dg2IjGEpOo0V8UzIRXLskytJ1Quc1RDZAozElxiQIMW+tW/Jmc5ffpKQiTnp1
         eTJ5SHTsoZHRFQxKrcXR5/EFeOHgq/xPq8bvxS678Opw86soN2msVgRGObpkLlonfB/7
         eVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmuDEks26u7TosMg6YO9rFojJhi017p7aPym+WIjY/s=;
        b=TFsdXVEdk1GFwKB66aEQa/+qEee4FISXW6E7tCZMiL55lP23SNhPKjz0T5P5HrS+6j
         0zdnJna3505fH75h6YnTmqWDwuW4AA6GD3EMi06FE/Kqvag8IcLAyF3V7gW6PK3q6U+d
         2CcOTzc+4q0kTmmBZHAHIwd5RGnIW3fgh7EfDQu1TUrXDEFNBHB+sIzAv54YME6jDzUk
         NZONcDXcRJ//ag2TBGwanQiyWIeMlh3okS2ffyJJbvGsE3HTNtbltceM3vv7Es/7jZf/
         F289idHR+BSC6/C7iYOhvYxQRx+2aTYFLaN8AFOS6jQSl86J0Qpvc0rW/b5puIhHi6AF
         bRFA==
X-Gm-Message-State: APjAAAWJ533XrKOX+UmgNkoJlvg7RzVGKrlIVboV86+OyqHxOYi0PtPB
        1kHtnnM6LFQ/DMYwsTqms0dT/sQn37txYmyWoePL3KOtVBo=
X-Google-Smtp-Source: APXvYqwyYTUtFEmJ3Pk1Kxl+N/9cXpVtziHTpF16SYo8jOemVRi2MW8HQ4q0f3So4cyRee2cDlyFYKUmjwTvJxrP1fU=
X-Received: by 2002:a17:906:4988:: with SMTP id p8mr2289364eju.220.1556813545671;
 Thu, 02 May 2019 09:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552635098.2015392.5460028594173939000.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552635098.2015392.5460028594173939000.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 12:12:14 -0400
Message-ID: <CA+CK2bAfnCVYz956jPTNQ+AqHJs7uY1ZqWfL8fSUFWQOdKxHcg@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> section active bitmask, each bit representing 2MB (SECTION_SIZE (128M) /
> map_active bitmask length (64)). If it turns out that 2MB is too large
> of an active tracking granularity it is trivial to increase the size of
> the map_active bitmap.

Please mention that 2M on Intel, and 16M on Arm64.

>
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and read the sub-section
> active ranges from the bitmask.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |   29 ++++++++++++++++++++++++++++-
>  mm/page_alloc.c        |    4 +++-
>  mm/sparse.c            |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6726fc175b51..cffde898e345 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1175,6 +1175,8 @@ struct mem_section_usage {
>         unsigned long pageblock_flags[0];
>  };
>
> +void section_active_init(unsigned long pfn, unsigned long nr_pages);
> +
>  struct page;
>  struct page_ext;
>  struct mem_section {
> @@ -1312,12 +1314,36 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
>
>  extern int __highest_present_section_nr;
>
> +static inline int section_active_index(phys_addr_t phys)
> +{
> +       return (phys & ~(PA_SECTION_MASK)) / SECTION_ACTIVE_SIZE;

How about also defining SECTION_ACTIVE_SHIFT like this:

/* BITS_PER_LONG = 2^6 */
#define BITS_PER_LONG_SHIFT 6
#define SECTION_ACTIVE_SHIFT (SECTION_SIZE_BITS - BITS_PER_LONG_SHIFT)
#define SECTION_ACTIVE_SIZE (1 << SECTION_ACTIVE_SHIFT)

The return above would become:
return (phys & ~(PA_SECTION_MASK)) >> SECTION_ACTIVE_SHIFT;

> +}
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> +{
> +       int idx = section_active_index(PFN_PHYS(pfn));
> +
> +       return !!(ms->usage->map_active & (1UL << idx));
> +}
> +#else
> +static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> +{
> +       return 1;
> +}
> +#endif
> +
>  #ifndef CONFIG_HAVE_ARCH_PFN_VALID
>  static inline int pfn_valid(unsigned long pfn)
>  {
> +       struct mem_section *ms;
> +
>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>                 return 0;
> -       return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> +       ms = __nr_to_section(pfn_to_section_nr(pfn));
> +       if (!valid_section(ms))
> +               return 0;
> +       return pfn_section_valid(ms, pfn);
>  }
>  #endif
>
> @@ -1349,6 +1375,7 @@ void sparse_init(void);
>  #define sparse_init()  do {} while (0)
>  #define sparse_index_init(_sec, _nid)  do {} while (0)
>  #define pfn_present pfn_valid
> +#define section_active_init(_pfn, _nr_pages) do {} while (0)
>  #endif /* CONFIG_SPARSEMEM */
>
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f671401a7c0b..c9ad28a78018 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7273,10 +7273,12 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
>
>         /* Print out the early node map */
>         pr_info("Early memory node ranges\n");
> -       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
> +       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
>                 pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
>                         (u64)start_pfn << PAGE_SHIFT,
>                         ((u64)end_pfn << PAGE_SHIFT) - 1);
> +               section_active_init(start_pfn, end_pfn - start_pfn);
> +       }
>
>         /* Initialise every node */
>         mminit_verify_pageflags_layout();
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f87de7ad32c8..5ef2f884c4e1 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -210,6 +210,54 @@ static inline unsigned long first_present_section_nr(void)
>         return next_present_section_nr(-1);
>  }
>
> +static unsigned long section_active_mask(unsigned long pfn,
> +               unsigned long nr_pages)
> +{
> +       int idx_start, idx_size;
> +       phys_addr_t start, size;
> +
> +       if (!nr_pages)
> +               return 0;
> +
> +       start = PFN_PHYS(pfn);
> +       size = PFN_PHYS(min(nr_pages, PAGES_PER_SECTION
> +                               - (pfn & ~PAGE_SECTION_MASK)));
> +       size = ALIGN(size, SECTION_ACTIVE_SIZE);
> +
> +       idx_start = section_active_index(start);
> +       idx_size = section_active_index(size);
> +
> +       if (idx_size == 0)
> +               return -1;
> +       return ((1UL << idx_size) - 1) << idx_start;
> +}
> +
> +void section_active_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +       int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> +       int i, start_sec = pfn_to_section_nr(pfn);
> +
> +       if (!nr_pages)
> +               return;
> +
> +       for (i = start_sec; i <= end_sec; i++) {
> +               struct mem_section *ms;
> +               unsigned long mask;
> +               unsigned long pfns;
> +
> +               pfns = min(nr_pages, PAGES_PER_SECTION
> +                               - (pfn & ~PAGE_SECTION_MASK));
> +               mask = section_active_mask(pfn, pfns);
> +
> +               ms = __nr_to_section(i);
> +               pr_debug("%s: sec: %d mask: %#018lx\n", __func__, i, mask);
> +               ms->usage->map_active = mask;
> +
> +               pfn += pfns;
> +               nr_pages -= pfns;
> +       }
> +}

For some reasons the above code is confusing to me. It seems all the
code supposed to do is set all map_active to -1, and trim the first
and last sections (can be the same section of course). So, I would
replace the above two functions with one function like this:

void section_active_init(unsigned long pfn, unsigned long nr_pages)
{
        int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
        int i, idx, start_sec = pfn_to_section_nr(pfn);
        struct mem_section *ms;

        if (!nr_pages)
                return;

        for (i = start_sec; i <= end_sec; i++) {
                ms = __nr_to_section(i);
                ms->usage->map_active = ~0ul;
        }

        /* Might need to trim active pfns from the beginning and end */
        idx = section_active_index(PFN_PHYS(pfn));
        ms = __nr_to_section(start_sec);
        ms->usage->map_active &= (~0ul << idx);

        idx = section_active_index(PFN_PHYS(pfn + nr_pages -1));
        ms = __nr_to_section(end_sec);
        ms->usage->map_active &= (~0ul >> (BITS_PER_LONG - idx - 1));
}
