Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE855C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD2521848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoVKbHiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfHVGrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:47:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44933 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfHVGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:47:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so6324605qtg.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 23:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CiMrxH8Gt5JqK2uyEB2GoUe1c7zMq8bWNGPXsYgidV4=;
        b=IoVKbHizFjYoCYCvT4CCkXOM23WvHv7K77ZyHJaPwNCm+lOMDDebTTybNmTF+guhDO
         HuQHKqJNJPeEbVBtdObOCo4ho97PgUXlVSwWnBcqjfb+f4vKJAAjOWpF4pkOxqumh1xz
         7Sx6M9pJOxlvxVQYLoNXQpaRqu82sKt5yxVx2fePB8z03vuzNO8nf4gfqTGXcss0do/m
         y9La9YOkoRozJYT0OWlB+4izCKV+4/08EAVepe5QhuKi9HB/2gRgWSFAFfyZ8wzrkMNC
         ZLn4BZS55uGf+TNSuMkWe+Z7t9DQt/rcyIqWAljuFMNBIbPMJBLaFoQevHXrWOOuXGeY
         0teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CiMrxH8Gt5JqK2uyEB2GoUe1c7zMq8bWNGPXsYgidV4=;
        b=dV0LCVw4jAopQeAHYV4Fo8EqizA7vKg4YjvKC3ID7x/7N73Erjuc+YovI3eCteAwS/
         AD89DOAwuHffFt11SOJvpxXGMqzRsbOG/bfiQtqSVl7fraMB+QdYAM2QSd/NuPQpEPyb
         6x6+Z0tp54j0FR2FqZNQRQIKWhAlS3LZdujZ7sNHNKMiZothxnNeBooIorJ8QdBQpw8+
         AoMcIf+YIU8XNpbJE9i01N41ZzuIcayJb6Kcos7anbSCPSAcKB6B3+Vnhwxco+8kMdii
         XrjhY8lK9v2gWcm5wPrnbVFyx2PSaEh+hpGp47q89y16HqKmYLEtnvRCStpMnaZaxraK
         mhMQ==
X-Gm-Message-State: APjAAAW8Tz1tnFcs5Vvan9tykyuZXFI/ZdcsUb1RQYLpSGN4fbvq/f+9
        eCFor4PUsJo7Rb/TuWUrDB15TGgGSfVIDKR8e70Gmg==
X-Google-Smtp-Source: APXvYqzVZr5rxY/jF/ZIvY6R713POrJMcRKXoPUsyOPVlTBUb5JhOiBady0RJ/T1F9HZGjNMy0GEICmD6KxFV1jsr28=
X-Received: by 2002:aed:21b6:: with SMTP id l51mr35436677qtc.184.1566456421037;
 Wed, 21 Aug 2019 23:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190822034425.25899-1-clin@suse.com> <20190822035920.GA27154@linux-8mug>
 <20190822064406.GC18872@rapoport-lnx>
In-Reply-To: <20190822064406.GC18872@rapoport-lnx>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 22 Aug 2019 09:46:50 +0300
Message-ID: <CAKv+Gu8F6n7RWsosOTjtDQ9qJNNERyhRHD0ncWABgpdAW5B9Aw@mail.gmail.com>
Subject: Re: [PATCH] arm: skip nomap memblocks while finding the
 lowmem/highmem boundary
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Chester Lin <clin@suse.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Gary Lin <GLin@suse.com>, Joey Lee <JLee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 at 09:44, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Aug 22, 2019 at 03:59:42AM +0000, Chester Lin wrote:
> > On Thu, Aug 22, 2019 at 11:45:34AM +0800, Chester Lin wrote:
> > > adjust_lowmem_bounds() checks every memblocks in order to find the boundary
> > > between lowmem and highmem. However some memblocks could be marked as NOMAP
> > > so they are not used by kernel, which should be skipped while calculating
> > > the boundary.
> > >
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > > ---
> > >  arch/arm/mm/mmu.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index 426d9085396b..b86dba44d828 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -1181,6 +1181,9 @@ void __init adjust_lowmem_bounds(void)
> > >             phys_addr_t block_start = reg->base;
> > >             phys_addr_t block_end = reg->base + reg->size;
> > >
> > > +           if (memblock_is_nomap(reg))
> > > +                   continue;
> > > +
> > >             if (reg->base < vmalloc_limit) {
> > >                     if (block_end > lowmem_limit)
> > >                             /*
> > > --
> > > 2.22.0
> > >
> >
> > Hi Russell, Mike and Ard,
> >
> > Per the discussion in the thread "[PATH] efi/arm: fix allocation failure ...",
> > (https://lkml.org/lkml/2019/8/21/163), I presume that the change to disregard
> > NOMAP memblocks in adjust_lowmem_bounds() should be separated as a single patch.
> >
> > Please let me know if any suggestion, thank you.
>
> Let's add this one to the series:
>
> From 06a986e79d60c310c804b3e550bd50316597aec5 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Thu, 22 Aug 2019 09:27:40 +0300
> Subject: [PATCH] arm: ensure that usable memory in bank 0 starts from a
>  PMD-aligned address
>
> The calculation of memblock_limit in adjust_lowmem_bounds() assumes that
> bank 0 starts from a PMD-aligned address. However, the beginning of the
> first bank may be NOMAP memory and the start of usable memory
> will be not aligned to PMD boundary. In such case the memblock_limit will
> be set to the end of the NOMAP region, which will prevent any memblock
> allocations.
>
> Mark the region between the end of the NOMAP area and the next PMD-aligned
> address as NOMAP as well, so that the usable memory will start at
> PMD-aligned address.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/mm/mmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4495a26..25da9b2 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1177,6 +1177,22 @@ void __init adjust_lowmem_bounds(void)
>          */
>         vmalloc_limit = (u64)(uintptr_t)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
>
> +       /*
> +        * The first usable region must be PMD aligned. Mark its start
> +        * as MEMBLOCK_NOMAP if it isn't
> +        */
> +       for_each_memblock(memory, reg) {
> +               if (!memblock_is_nomap(reg)) {
> +                       if (!IS_ALIGNED(reg->base, PMD_SIZE)) {
> +                               phys_addr_t len;
> +
> +                               len = round_up(reg->base, PMD_SIZE) - reg->base;
> +                               memblock_mark_nomap(reg->base, len);
> +                       }
> +                       break;
> +               }
> +       }
> +
>         for_each_memblock(memory, reg) {
>                 phys_addr_t block_start = reg->base;
>                 phys_addr_t block_end = reg->base + reg->size;
> --
> 2.7.4
>
>
> --
> Sincerely yours,
> Mike.
>
