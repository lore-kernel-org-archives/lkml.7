Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE4AC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111042082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="z8K+qZbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDCSJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:09:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34624 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:09:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so14394924oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLfeTHYa0RD16P6+TGw1835NRm1Z2mjwVm5mp+9PwC4=;
        b=z8K+qZbKKB0CPbds0ctgzT6yvbDSyne4jzF+g9MQDqHCPB5OPh0qk2XXWxoiT8uT9G
         zzAZBBgiwvP3s3WO+yER7TdXgooNtVJn+bJrYtKWk0AUmM4gMN9g2NYXSa+GjS+RD4qh
         8xENTTZm8SgBjQ9esMCmbOP5N89LgbdkK2DEsHPY7bvoNzu4jgR80ZG3HLSzPxh0WrY5
         S0JNoxdJG64cPYngeWk+znmXW9+iCzcbLOjAVOekrPZVxNPgEekx0LW/gdB8hbrAEi1G
         xsvjGauCjnbGtT2gFDUKoUQw5H1XawOs5hYrgAV4dxTSwt6qZz7tP5wZXt4VslUi4kvi
         mGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLfeTHYa0RD16P6+TGw1835NRm1Z2mjwVm5mp+9PwC4=;
        b=oPEO4b5T3LBLSft58XQWsWOr/U9pn1eLhla2PLqseS2+k4YdLS4j8rXiO2npvFdJkZ
         kMNbIsxely8ALouyOTfsUjx1veZu96wgcVHsrJU4qj6OKxqSjU/zaV+LfyuyE3UvhwiI
         J33PAq/rZBwYIzvTkexNHr2X7YkW79vhwO6xkHMh6SVpx7RZgG3Yl4ILINITGQMMoH0y
         p5d8EyU05oOI2u+GP1Gpu4OabN/Vdv+wH+jTV15esnbPlM3gu3Oi8KQzrsuDbla60OO0
         S1mY8UOgzs/D3ZuH5cZ4cmIKu2c1IMLL02MyH6ZEeGe9qqeRMTpkXrc3Dx5u3qBSjzj5
         54ww==
X-Gm-Message-State: APjAAAVaZVOxdsMh8vzfP0uZlDvNdgzwnk2XoQvbDbKrAXm40ex/e9W1
        /h8UYW2El5rV7+RLkHPEmqPkmUgzgx+KmsJnm1N/Cw==
X-Google-Smtp-Source: APXvYqzusb0p4qiWWjm2CpnwMPhzr5akGYhKWUDDAJTvVOvkzYZTem1qs/kZxvPv4FWYtmfE1KTFPIoKblD2l9anuTo=
X-Received: by 2002:aca:f581:: with SMTP id t123mr589000oih.0.1554314944750;
 Wed, 03 Apr 2019 11:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Apr 2019 11:08:53 -0700
Message-ID: <CAPcyv4gdz7L20nSMEBNLDWgUzr-GjaBhecF3i8Q4D_O=ug0qNw@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm64/mm: Enable memory hot remove and ZONE_DEVICE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>, james.morse@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, cpandya@codeaurora.org,
        arunks@codeaurora.org, osalvador@suse.de,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>, cai@lca.pw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 9:30 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This series enables memory hot remove on arm64, fixes a memblock removal
> ordering problem in generic __remove_memory(), enables sysfs memory probe
> interface on arm64. It also enables ZONE_DEVICE with struct vmem_altmap
> support.
>
> Testing:
>
> Tested hot remove on arm64 for all 4K, 16K, 64K page config options with
> all possible VA_BITS and PGTABLE_LEVELS combinations. Tested ZONE_DEVICE
> with ARM64_4K_PAGES through a dummy driver.
>
> Build tested on non arm64 platforms. I will appreciate if folks can test
> arch_remove_memory() re-ordering in __remove_memory() on other platforms.
>
> Dependency:
>
> V5 series in the thread (https://lkml.org/lkml/2019/2/14/1096) will make
> kernel linear mapping loose pgtable_page_ctor() init. When this happens
> the proposed functions free_pte|pmd|pud_table() in [PATCH 2/6] will have
> to stop calling pgtable_page_dtor().

Hi Anshuman,

I'd be interested to integrate this with the sub-section hotplug
support [1]. Otherwise the padding implementation in libnvdimm can't
be removed unless all ZONE_DEVICE capable archs also agree on the
minimum arch_add_memory() granularity. I'd prefer not to special case
which archs support which granularity, but it unfortunately
complicates what you're trying to achieve.

I think at a minimum we, mm hotplug co-travellers, need to come to a
consensus on whether sub-section support is viable for v5.2 and / or a
pre-requisite for new arch-ZONE_DEVICE implementations.
