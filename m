Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D332073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq6ex/zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDPF0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:26:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44874 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfDPF0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:26:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so10818565vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSYFPZsuygOoy6qVoHRdTD0eecXLgTWkf1fF93D5ArI=;
        b=iq6ex/ztcBBjmyWJkRDzDRheabCvVhqZ4aBUg+MF6YDPB+VwE9+zAPyILCfdoS9kTX
         +05Na0Z8mK54KOnjsfSKTpw0KjVa8L6MYaujwLV5Us6Tc1/uMnsIZmGNw/55Hd0gSFLX
         e7l3tHsNhrWhuvj6ClET2UkmnanmBwpBsOyrZtqvR8boMCfgivNeonvz1J08NTfTereM
         rZ+okabsEfa2WlT6Z3hltCOnVZTzUuz6d5Gqw90GVTkHsbAIz3pyb7Advc7XlaivueAY
         GJa+sLWqUueKbOkJwV00UHzbx3OdFodRk/DQ8K8HrzFAUCncGtsPxu93UNAs2lxVbeC4
         e/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSYFPZsuygOoy6qVoHRdTD0eecXLgTWkf1fF93D5ArI=;
        b=W7HagnKNJ/1bgxVBww7YHcf0LXVftSToJKsJxZOsYeDQL3EwOHxyoXh3JWoCm4Xst8
         b8ba0ttKBFsHHkDA4AOdCjRNii4p2hTY5x3mHvH0Lgmkd84+aaDWTE0adqT2/jXRhD6r
         2aBsf4IY0Lcf6P3IqRxqO1fziBAhLHTZQbMIyfr//IF95wIzJvBmo/VmgCJCSnvHef03
         PbwrGKbPVwDwerY87SE6j99LK3zSlPRKrz2ZO8ZedKHH/cVX4Y+N4bBzr5FRzO/TOl0g
         rdanN5p+V79dOipigb0jnwUZSwBfuasNxEqNJTjB7eCGllwDM6RuDh31eYBf6L3m9+K3
         bvfg==
X-Gm-Message-State: APjAAAXmxYObcmuEJctZaFe5/3X+5Z02FhaX9VQs+CzTdj/ST5EAepb/
        zXPcfu5eO4EaTmyCZR/QtL8WqxolVHlfWaA+dF4=
X-Google-Smtp-Source: APXvYqz2o6DoARyz+eb1XG/GdmnWaCaMHDcVM9ts3E53/f5WeFThGPgp0frF/5EfmAUH+rOUCAo1/QH3Z29BsctEqmw=
X-Received: by 2002:a67:870a:: with SMTP id j10mr41704482vsd.161.1555392371376;
 Mon, 15 Apr 2019 22:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190408163319.10382-1-vichy.kuo@gmail.com>
In-Reply-To: <20190408163319.10382-1-vichy.kuo@gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Tue, 16 Apr 2019 13:26:00 +0800
Message-ID: <CAOVJa8HapyX3PUJmkO0h8cZDB-zmZBt0erX+ykrdmA4QRSXYyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kaslr: shift linear region randomization ahead of memory_limit
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi will and all:
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

Would you mind to give some comment and suggestion for these v3 patches?
https://lkml.org/lkml/2019/4/8/682
https://lkml.org/lkml/2019/4/8/683

Sincerely appreciate your kind help,
