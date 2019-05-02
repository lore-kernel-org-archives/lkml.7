Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6A0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1715E205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2Fb0VEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfEBM22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:28:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39863 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:28:27 -0400
Received: by mail-it1-f194.google.com with SMTP id t200so3014696itf.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qS8OB3VzoLdC268eCczKcFn55LM1oxTu+ok9okBkG08=;
        b=u2Fb0VEiEPKYS2lyoP0w+zDLAxdc0Y+Lu+XmbcPk0hOncu35cxJdVQNfyR1Kr9iRSl
         D6JqBV6XIUH2J/LuCfg1+m5IEzBmvJJ0LeGtTyII1hnKt7v8PXLmZHuXbYiyhFG6LvKy
         ACa2kX+fyH0aZWvCQTmRIjYpux7MJDyJu1zn0Qr2qLEnd2RTyjioyd87O4DbcyyW9UHg
         UvnXg7LMBYNhVpCL5q9PZgHSpiFLT0O3NJ/wc8YHO5+cMQO6HjjL4M1KGaW6OIQQus5F
         w8vm6injChmckOvBLbP6YhWBQEZKZ9cynhjTXoDTX6YDOzmkHyMp9zqA8vgN5EtIB7aG
         T8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qS8OB3VzoLdC268eCczKcFn55LM1oxTu+ok9okBkG08=;
        b=UNXxs8OEZCpSpZArj2z0csjty0svB038DgR9xsnY6p0imnDuQJUrB5IIIFR6qjpHG2
         gPBPUXZ497VPHe6Ppj2y5u2sqyyrrZDYghxhIKEx890bJoPAeLwI2HgREDpzwUU15xV7
         pfIFcm3m0w1M/6YHcBHvMAsLu+OJBpCky+UdocNWDvKfhD7uDKLbrsXZV6k92sCYrZ3r
         ILwHCOWsTf4LC1X+eGdAYBxkd0TxWC529QB9678bM0EydtYWsp3YqlnP4necvI66KPgb
         4K5Jv9wfOBDOIA2MuWZWpFavfkx7sfKL04UDxcxux4kDciZmRNm0OJn7shPDEpEzE3Gn
         EKtw==
X-Gm-Message-State: APjAAAWgHu6CbU8E04+qQBXiQrxdsYhSo1WBPIwp9sS+oxf9Rs/kU7b/
        UffqAkVMjWJwwh/jhqJIWHj6+ry5eWAVuH0vyW27NA==
X-Google-Smtp-Source: APXvYqwJETuC7vw+qurNB5pJo86YjOPjRJ86zJ3FKV/99cEXgbC9zDaW7HI8pfE7rfIP+OLD3HQncoxYMtEUhye/4pc=
X-Received: by 2002:a24:59c1:: with SMTP id p184mr2312120itb.158.1556800106816;
 Thu, 02 May 2019 05:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190408163319.10382-1-vichy.kuo@gmail.com>
In-Reply-To: <20190408163319.10382-1-vichy.kuo@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 May 2019 14:28:15 +0200
Message-ID: <CAKv+Gu9gfq6PdwwLJd-zXYTiVT0oKtkhJHG4+AaOdD+N0k6c=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kaslr: shift linear region randomization ahead of memory_limit
To:     pierre Kuo <vichy.kuo@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        steven.price@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 at 18:33, pierre Kuo <vichy.kuo@gmail.com> wrote:
>
> The following is schematic diagram of the program before and after the
> modification.
>
> Before:
> if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} --(a)
> if (memory_limit != PHYS_ADDR_MAX) {}                               --(b)
> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}       --(c)
> if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}                           --(d)*
>
> After:
> if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} --(a)
> if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}                           --(d)*
> if (memory_limit != PHYS_ADDR_MAX) {}                               --(b)
> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}       --(c)
>
> After grouping modification of memstart_address by moving linear region
> randomization ahead of memory_init, driver can safely using macro,
> __phys_to_virt, in (b) or (c), if necessary.
>

Why is this an advantage?

> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
> Changes in v2:
> - add Fixes tag
>
> Changes in v3:
> - adding patch of shifting linear region randomization ahead of
>  memory_limit
>
>  arch/arm64/mm/init.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7205a9085b4d..5142020fc146 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -389,6 +389,23 @@ void __init arm64_memblock_init(void)
>                 memblock_remove(0, memstart_addr);
>         }
>
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> +               extern u16 memstart_offset_seed;
> +               u64 range = linear_region_size -
> +                           (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +
> +               /*
> +                * If the size of the linear region exceeds, by a sufficient
> +                * margin, the size of the region that the available physical
> +                * memory spans, randomize the linear region as well.
> +                */
> +               if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> +                       range /= ARM64_MEMSTART_ALIGN;
> +                       memstart_addr -= ARM64_MEMSTART_ALIGN *
> +                                        ((range * memstart_offset_seed) >> 16);
> +               }
> +       }
> +
>         /*
>          * Apply the memory limit if it was set. Since the kernel may be loaded
>          * high up in memory, add back the kernel region that must be accessible
> @@ -428,22 +445,6 @@ void __init arm64_memblock_init(void)
>                 }
>         }
>
> -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> -               extern u16 memstart_offset_seed;
> -               u64 range = linear_region_size -
> -                           (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> -
> -               /*
> -                * If the size of the linear region exceeds, by a sufficient
> -                * margin, the size of the region that the available physical
> -                * memory spans, randomize the linear region as well.
> -                */
> -               if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> -                       range /= ARM64_MEMSTART_ALIGN;
> -                       memstart_addr -= ARM64_MEMSTART_ALIGN *
> -                                        ((range * memstart_offset_seed) >> 16);
> -               }
> -       }
>
>         /*
>          * Register the kernel text, kernel data, initrd, and initial
> --
> 2.17.1
>
