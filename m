Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105BFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2321D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="s275THCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390320AbfKHTOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:14:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46792 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbfKHTOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:14:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so6176318oie.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvdTNvqH26wTJGXzTUajOuQ5X7gI5KuWrrDUcv/SSVU=;
        b=s275THCxLMpiEae9K4Cyiww9QPLJP+xkcYKqjam+OTgjoJEykSbnoqtRs25ieLXlSZ
         H7+L5Sval9DluEDJKahHXV6esSjrzYUIKw6ztFljNkdq9Z2kdpla8Q7x9RI2uE1ZNFoh
         1N8uqRTeMLB53JwSggEVZfdGPJLtdm0BDf6kyTivWKD/gzGYGZiCfSUfiq2Deivaun6U
         EN43s8hTxhRZ6gLn54PVt7HrZFgZKYiDpg/czQqqIcPqnr6YxvA4qxczjSXb7FCvAxzD
         FKfmoNs95sJjZp3uWyJPwYs4RLnGzRojIjAb0zQnG8ewXbsSmg32glMDUH0Yjn9rpuRV
         s0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvdTNvqH26wTJGXzTUajOuQ5X7gI5KuWrrDUcv/SSVU=;
        b=qqJMCHzxlljbaUjqchdAvPegWXMoiEN/4nAH9lGGECj2IvbwnKCKyzLD5ewmFFhnDc
         RraYyRRCmZevVKy772c7zulidipoaG8OFn0h5PhyyXvjWdUNHu+cHbYoHDkxJVHOVTTe
         wkRI+QpY+jPNiU1HGe+bUgE9IMvPre/h5B1h3mluExXsSL0mfhOIumqTD3P/cO7+mlYB
         Z0PeiTPKFF8xXg2OrRF3J9L9+pJMG6rfl/oz8CR3uomMlyXRbTLh+zxiGUu+VVZ/ElaG
         1FFMCpFyppGJ6fYSztA++8/sVkNYEg2cMucHVv8qSPBU18jECUaDeLF4QMOVrVg3OxB4
         AEpw==
X-Gm-Message-State: APjAAAWeGVwuTMftCQ+fhhNsBpfAIuZbdjGHweF2U8lxPG/jd6COJIb+
        rcAn1lSXDGaW941Bxtqk5WJsGAxNQYhYVFobbhSkzw==
X-Google-Smtp-Source: APXvYqxiVzHFpziPlBB8G0GQs786Fsp9mrZzg3zAL1TIJ7MwGe0E9weFin9+o+XGc09kjNAGJcsu5qfk6GnBxzrZGA0=
X-Received: by 2002:aca:1910:: with SMTP id l16mr10705887oii.73.1573240446300;
 Fri, 08 Nov 2019 11:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com> <20191108000855.25209-3-t-fukasawa@vx.jp.nec.com>
In-Reply-To: <20191108000855.25209-3-t-fukasawa@vx.jp.nec.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 8 Nov 2019 11:13:55 -0800
Message-ID: <CAPcyv4h+++k1VTB2xKWHXjC4LC0N=nvDUMcdbGAsDBmwMob5dw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
To:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 4:15 PM Toshiki Fukasawa
<t-fukasawa@vx.jp.nec.com> wrote:
>
> Currently, there is no way to identify pfn on ZONE_DEVICE.
> Identifying pfn on system memory can be done by using a
> section-level flag. On the other hand, identifying pfn on
> ZONE_DEVICE requires a subsection-level flag since ZONE_DEVICE
> can be created in units of subsections.
>
> This patch introduces a new bitmap subsection_dev_map so that
> we can identify pfn on ZONE_DEVICE.
>
> Also, subsection_dev_map is used to prove that struct pages
> included in the subsection have been initialized since it is
> set after memmap_init_zone_device(). We can avoid accessing
> pages currently being initialized by checking subsection_dev_map.
>
> Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
> ---
>  include/linux/mmzone.h | 19 +++++++++++++++++++
>  mm/memremap.c          |  2 ++
>  mm/sparse.c            | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index bda2028..11376c4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1174,11 +1174,17 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>
>  struct mem_section_usage {
>         DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> +#ifdef CONFIG_ZONE_DEVICE
> +       DECLARE_BITMAP(subsection_dev_map, SUBSECTIONS_PER_SECTION);
> +#endif

Hi Toshiki,

There is currently an effort to remove the PageReserved() flag as some
code is using that to detect ZONE_DEVICE. In reviewing those patches
we realized that what many code paths want is to detect online memory.
So instead of a subsection_dev_map add a subsection_online_map. That
way pfn_to_online_page() can reliably avoid ZONE_DEVICE ranges. I
otherwise question the use case for pfn_walkers to return pages for
ZONE_DEVICE pages, I think the skip behavior when pfn_to_online_page()
== false is the right behavior.


>         /* See declaration of similar field in struct zone */
>         unsigned long pageblock_flags[0];
>  };
>
>  void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
> +#ifdef CONFIG_ZONE_DEVICE
> +void subsections_mark_device(unsigned long start_pfn, unsigned long size);
> +#endif
>
>  struct page;
>  struct page_ext;
> @@ -1367,6 +1373,19 @@ static inline int pfn_present(unsigned long pfn)
>         return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
>  }
>
> +static inline int pfn_zone_device(unsigned long pfn)
> +{
> +#ifdef CONFIG_ZONE_DEVICE
> +       if (pfn_valid(pfn)) {
> +               struct mem_section *ms = __pfn_to_section(pfn);
> +               int idx = subsection_map_index(pfn);
> +
> +               return test_bit(idx, ms->usage->subsection_dev_map);
> +       }
> +#endif
> +       return 0;
> +}
> +
>  /*
>   * These are _only_ used during initialisation, therefore they
>   * can use __initdata ...  They could have names to indicate
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 03ccbdf..8a97fd4 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -303,6 +303,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>         memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>                                 PHYS_PFN(res->start),
>                                 PHYS_PFN(resource_size(res)), pgmap);
> +       subsections_mark_device(PHYS_PFN(res->start),
> +                               PHYS_PFN(resource_size(res)));
>         percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
>         return __va(res->start);
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1..a3fc9e0a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -603,6 +603,31 @@ void __init sparse_init(void)
>         vmemmap_populate_print_last();
>  }
>
> +#ifdef CONFIG_ZONE_DEVICE
> +void subsections_mark_device(unsigned long start_pfn, unsigned long size)
> +{
> +       struct mem_section *ms;
> +       unsigned long *dev_map;
> +       unsigned long sec, start_sec, end_sec, pfns;
> +
> +       start_sec = pfn_to_section_nr(start_pfn);
> +       end_sec = pfn_to_section_nr(start_pfn + size - 1);
> +       for (sec = start_sec; sec <= end_sec;
> +            sec++, start_pfn += pfns, size -= pfns) {
> +               pfns = min(size, PAGES_PER_SECTION
> +                       - (start_pfn & ~PAGE_SECTION_MASK));
> +               if (WARN_ON(!valid_section_nr(sec)))
> +                       continue;
> +               ms = __pfn_to_section(start_pfn);
> +               if (!ms->usage)
> +                       continue;
> +
> +               dev_map = &ms->usage->subsection_dev_map[0];
> +               subsection_mask_set(dev_map, start_pfn, pfns);
> +       }
> +}
> +#endif
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>
>  /* Mark all memory sections within the pfn range as online */
> @@ -782,7 +807,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>                 memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
>                 ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
>         }
> +#ifdef CONFIG_ZONE_DEVICE
> +       /* deactivation of a partial section on ZONE_DEVICE */
> +       if (ms->usage) {
> +               unsigned long *dev_map = &ms->usage->subsection_dev_map[0];
>
> +               bitmap_andnot(dev_map, dev_map, map, SUBSECTIONS_PER_SECTION);
> +       }
> +#endif
>         if (section_is_early && memmap)
>                 free_map_bootmem(memmap);
>         else
> --
> 1.8.3.1
>
