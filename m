Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3609AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3E420665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nMkbt/qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392831AbfGXUMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:12:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42628 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388645AbfGXUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:12:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so49179861otn.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PNL04KYvInZXteiwuvvVomp7psYL1Kl+T8ycx6EmRk=;
        b=nMkbt/qriVy9O40AoW5FYNfDVr8RyGGaYJ40joGq40jdmhquOlREtNDZ/xeGpk9EHD
         gXIrt4W1XVVNC6/Rd2cAvNqLFpGVzBldC5FrJdtpyV4dVO8ZxSE8mfwUvBpjKm1jzl17
         krrSZj+MzqvjS3VrNAzKy8wM81/5FUxqLeDnL3zJG6EW31/OdglL16Ms8Uggn9Qz2FUQ
         y4aYlFANRwJZE2ZsU9dZEqXS7iUWtbd/J+qYJcO23brfsDmTeNV2Rw9ByujWw5xbW40z
         0ldixykjhsbNKz/35tArF46weN+pr4TRfpajnHEBiwS7hXFUaIYfGGIyG3ZPouMGNZhX
         vamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PNL04KYvInZXteiwuvvVomp7psYL1Kl+T8ycx6EmRk=;
        b=sECSvh1FwyZuee+JIm7ja9MpsECaRjvjcLoMqHb249N4R9PInje++CxaRrzJ6chDTv
         kx5NE50zng1WRVCtzHJ+jKgWlJaQU+PiYzaT4NvmyL/YFIGcjbOmDHrBY6VZ4Tl4imT5
         yyw4b/tAy9+wC8dtsjLaTi4/inD3Av/YKkrnolCZgY7Mejrd8+t5dm+a+sxOc3sEsd7q
         SEb7yL5isAsR6dKaKLkp9eS6sWTKsjuQzbvfq2b8l7ZEqiOb2E8uj8t95XFkgb40rxse
         65EQOdGfkZxHFqtffMkKMdoQDTxGJK4pgKpa7GINdXdUubq1kG5ZscdsFZQAVSiJT15c
         Z5wg==
X-Gm-Message-State: APjAAAXuNJ2UPWuLRd+j6+/T+0V9/vCj0TAi/R3OXq6nmHMglpv1wchE
        kBhD2/ueFc5vnkd1gcVjxFtR5jy108c74NkDEzKbcQ==
X-Google-Smtp-Source: APXvYqyVnJ52FSRiRxNb5fXzbbBT2vQjm4rcB9LwDsWmIAgcWVuBgRfFtQALre7fkjgKI2r2zo6w17KkSkKZppNPmvs=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr36294684oto.207.1563999124513;
 Wed, 24 Jul 2019 13:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190625075227.15193-1-osalvador@suse.de> <20190625075227.15193-3-osalvador@suse.de>
In-Reply-To: <20190625075227.15193-3-osalvador@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jul 2019 13:11:52 -0700
Message-ID: <CAPcyv4hvu+wp4tJJNW70jp2G_rNabyvzGMvDTS3PzkDCAFztYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm,memory_hotplug: Introduce MHP_VMEMMAP_FLAGS
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:53 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> This patch introduces MHP_MEMMAP_DEVICE and MHP_MEMMAP_MEMBLOCK flags,
> and prepares the callers that add memory to take a "flags" parameter.
> This "flags" parameter will be evaluated later on in Patch#3
> to init mhp_restrictions struct.
>
> The callers are:
>
> add_memory
> __add_memory
> add_memory_resource
>
> Unfortunately, we do not have a single entry point to add memory, as depending
> on the requisites of the caller, they want to hook up in different places,
> (e.g: Xen reserve_additional_memory()), so we have to spread the parameter
> in the three callers.
>
> The flags are either MHP_MEMMAP_DEVICE or MHP_MEMMAP_MEMBLOCK, and only differ
> in the way they allocate vmemmap pages within the memory blocks.
>
> MHP_MEMMAP_MEMBLOCK:
>         - With this flag, we will allocate vmemmap pages in each memory block.
>           This means that if we hot-add a range that spans multiple memory blocks,
>           we will use the beginning of each memory block for the vmemmap pages.
>           This strategy is good for cases where the caller wants the flexiblity
>           to hot-remove memory in a different granularity than when it was added.
>
>           E.g:
>                 We allocate a range (x,y], that spans 3 memory blocks, and given
>                 memory block size = 128MB.
>                 [memblock#0  ]
>                 [0 - 511 pfns      ] - vmemmaps for section#0
>                 [512 - 32767 pfns  ] - normal memory
>
>                 [memblock#1 ]
>                 [32768 - 33279 pfns] - vmemmaps for section#1
>                 [33280 - 65535 pfns] - normal memory
>
>                 [memblock#2 ]
>                 [65536 - 66047 pfns] - vmemmap for section#2
>                 [66048 - 98304 pfns] - normal memory
>
> MHP_MEMMAP_DEVICE:
>         - With this flag, we will store all vmemmap pages at the beginning of
>           hot-added memory.
>
>           E.g:
>                 We allocate a range (x,y], that spans 3 memory blocks, and given
>                 memory block size = 128MB.
>                 [memblock #0 ]
>                 [0 - 1533 pfns    ] - vmemmap for section#{0-2}
>                 [1534 - 98304 pfns] - normal memory
>
> When using larger memory blocks (1GB or 2GB), the principle is the same.
>
> Of course, MHP_MEMMAP_DEVICE is nicer when it comes to have a large contigous
> area, while MHP_MEMMAP_MEMBLOCK allows us to have flexibility when removing the
> memory.

Concept and patch looks good to me, but I don't quite like the
proliferation of the _DEVICE naming, in theory it need not necessarily
be ZONE_DEVICE that is the only user of that flag. I also think it
might be useful to assign a flag for the default 'allocate from RAM'
case, just so the code is explicit. So, how about:

MHP_MEMMAP_PAGE_ALLOC
MHP_MEMMAP_MEMBLOCK
MHP_MEMMAP_RESERVED

...for the 3 cases?

Other than that, feel free to add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
