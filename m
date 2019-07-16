Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B7C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ED7206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="s0jW7HHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfGPEdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:33:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37982 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731933AbfGPEdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:33:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so14517162oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBVLD8FyKgT6SsKBtjQIHWzc2KidSI6XthY/YMB8EBo=;
        b=s0jW7HHMZZ06Pnd+l+c+Nga/bKl9JGwArhxxRfJ5+xwGF1l1jKEd98wa2C6K7uUUa8
         gPZHfXh2pDZpwK8Zrv6fhTGWRTm0nn+G0vaUXB5EMz+XUAKYKqeo/2yuF1OWOm8ZM6Xk
         9lw+3yq/bZfuBuCbHjoNwDxwmJP8YVVfT6k02SEHztTIWZL25CK6sk1tXagVmXYbwDhK
         GML9sW9uHhMKiNXyHGcZh+qVG3P10D1BnLYtBQ3rzN6HzdAr/PfjlXm7wxmDRqza+dMz
         9OPgdFdB9GXn/YlNtV9ZbyVVPQxo78nnYIoblnoTz+IbB7UyEPaxt2+C6WoZT3p9KEnO
         o8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBVLD8FyKgT6SsKBtjQIHWzc2KidSI6XthY/YMB8EBo=;
        b=qvbSAkJbtHHrV2cWZ1Qn4MbF97HoZwDqWFwKEL3iTph5a6SRaWd71rk/JOnqWZ+mRI
         wFeS2rnLDg1PSFPpMCM9/je6/KMbDRO/2zgyHdSyGxRupOSRsjIxWAWJc6VpxY1L5to8
         FUrF5KXmK7nfsGUvSnUpdizReOUEN8QAwEcvSw+W4wgLC4VEHvLN6cWJ7Tb6MU4mWcLL
         yl9SBmeuOnZoYwBeknh6+DcolAk+LfM3rE9Ni3rrQZcgFhTnt37yevdoYAEDjNfSiQ1h
         fcA7ThhXhhhSrkl2rjl3COBZ0mAyLwOb+1w2WknK1S7RIOWtczIn+QTfFVMFWQaJebcf
         8k4A==
X-Gm-Message-State: APjAAAXV9nJaK4If0aQ2qKN3StKCvTkwdUSEir+4+JwhA+LZA5rJwGJM
        EiUcR2UhF4NG9tUHgj12lNsO86OJFsk9yAsKPGHWbzPK
X-Google-Smtp-Source: APXvYqwdAs273+zThaXtnthQnsSuA9ZucHUwlLKNfCaVtbLGHxXDRC+l4/3o+aTsLW2iF/B+6rqVusxTGhsI9bWaQGA=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr15055837oii.0.1563251620193;
 Mon, 15 Jul 2019 21:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190715081549.32577-1-osalvador@suse.de> <20190715081549.32577-2-osalvador@suse.de>
In-Reply-To: <20190715081549.32577-2-osalvador@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Jul 2019 21:33:29 -0700
Message-ID: <CAPcyv4hT6w_=-6AVPvf24=bGJUy=XTOSjNeZ8b56r=Uukpiz8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm,sparse: Fix deactivate_section for early sections
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 1:16 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> deactivate_section checks whether a section is early or not
> in order to either call free_map_bootmem() or depopulate_section_memmap().
> Being the former for sections added at boot time, and the latter for
> sections hotplugged.
>
> The problem is that we zero section_mem_map, so the last early_section()
> will always report false and the section will not be removed.
>
> Fix this checking whether a section is early or not at function
> entry.
>
> Fixes: mmotm ("mm/sparsemem: Support sub-section hotplug")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/sparse.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 3267c4001c6d..1e224149aab6 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -738,6 +738,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>         DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>         DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
>         struct mem_section *ms = __pfn_to_section(pfn);
> +       bool section_is_early = early_section(ms);
>         struct page *memmap = NULL;
>         unsigned long *subsection_map = ms->usage
>                 ? &ms->usage->subsection_map[0] : NULL;
> @@ -772,7 +773,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>         if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
>                 unsigned long section_nr = pfn_to_section_nr(pfn);
>
> -               if (!early_section(ms)) {
> +               if (!section_is_early) {
>                         kfree(ms->usage);
>                         ms->usage = NULL;
>                 }
> @@ -780,7 +781,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>                 ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
>         }
>
> -       if (early_section(ms) && memmap)
> +       if (section_is_early && memmap)
>                 free_map_bootmem(memmap);
>         else
>                 depopulate_section_memmap(pfn, nr_pages, altmap);

Reviewed-by: Dan Williams <dan.j.wiliams@intel.com>

In fact, this bug was re-introduced between v9 and v10 as I had seen
this bug before, but did not write a reproducer for the unit test.
