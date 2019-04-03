Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F66C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5DE2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwXHHRv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfDCQok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:44:40 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41795 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbfDCQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:44:38 -0400
Received: by mail-vs1-f68.google.com with SMTP id g187so10377497vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZnHtpKJZJ2fuBkhwsJTbda3w/jemBvyjKtIF9cE10g=;
        b=MwXHHRv1h5zn3S6HC6fai6jO3G3rtmj8JO8H6Jz+9C204Yu46Pn4cYIW9hPe8LoNhU
         pMDb+l5gi2mKJHXkUc0nOJAzlnJWE321TkYYkHVYSWQBGZvdSpHv6W7qe8GZxSfhaztf
         GNICr04ymwYTg4bAAtUjuSHkVveNkYvpIxTWJWD5il3RUyaao1KZIa23BSYNM8WFw7pX
         iuMhTVdPn6uowS8IdDJ41TdWdHPr4yUbGYu4FC0Tp/BZypo9M6XTHGokazScv1T3N55d
         8oC/HDkHHDusn9UdKmKYVHamkvad5Z+hE/JLU1SjwPHN4LemW54FPFVngMacgxIt1+fc
         UTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZnHtpKJZJ2fuBkhwsJTbda3w/jemBvyjKtIF9cE10g=;
        b=LlNUXb8N552B6rzb1QuJBY2/qm/SV92ONqiSATRMM9I4MFumE/n/Mzmzzb5VES0DsL
         8/5TRS5QtWim+EKH11D5yrt7V7iB2g7OJazJ2S4oZHJC30XMwwiSuSk3Ol9HBE3ypfet
         SiMAaci6cv1hGGUpYOLlbDSSWrYkj9DEFrcR2IUDrOqsb+8tY6LXg0F1tjHGqaPp/GgZ
         7OxVZx68KX1Y0CxJHeHIRfnpSL2NRVXc80xEswBKjOX5nSZLHs1XEUmjzsKFuCQxEcRh
         OApBeyF7ZM4UL7uSNg4+EcfXDf6hFdEd+aOo4IviNJ36kFWkIKgkwHwybzUYUyoQ6Hrc
         kZ6g==
X-Gm-Message-State: APjAAAUasYc/fLdQ6q5vqKfcSVLUB2tNVhtXFnmnUkMxs1hbvc4TdsDl
        l8PREasEeS9bk6p5DNtRRk6DJNmSI2p9Qu3zqR8=
X-Google-Smtp-Source: APXvYqz+W8X9zWW0hjnbKwAzSJIl89dxsHD/VXJbVa8vquq1YiaHmYUV7ColocxfIuqgoQxhKpKlTii1d+hleevuVy4=
X-Received: by 2002:a67:e256:: with SMTP id w22mr972728vse.173.1554309877071;
 Wed, 03 Apr 2019 09:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190314032047.15790-1-vichy.kuo@gmail.com> <20190319153114.GI59586@arrakis.emea.arm.com>
 <CAOVJa8HSB34ggku=96KAb6qju3G5-uGYFxCE6O2eQRMwU4bd1A@mail.gmail.com>
 <CAOVJa8Eefs7cEneNwV0VCrr8GLVb0AweJEb0Qo4TucgXTNuNWg@mail.gmail.com> <20190401153810.GC6884@fuggles.cambridge.arm.com>
In-Reply-To: <20190401153810.GC6884@fuggles.cambridge.arm.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Thu, 4 Apr 2019 00:44:25 +0800
Message-ID: <CAOVJa8EcjQO2GuojwBxfFG25+T-z6BR6ytZBdcV2W2XusyW08g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Will:
>
> [+Ard in case I'm missing something]
>
> On Mon, Apr 01, 2019 at 10:59:53PM +0800, pierre kuo wrote:
> > > > With CONFIG_RANDOMIZE_BASE we can get a further change to memstart_addr
> > > > after the place where you moved the initrd_{start,end} setting, which
> > > > would result in a different value for __phys_to_virt(phys_initrd_start).
> > >
> > > I found what you mean, since __phys_to_virt will use PHYS_OFFSET
> > > (memstart_addr) for calculating.
> > > How about moving CONFIG_RANDOMIZE_BASE part of code ahead of
> > > CONFIG_BLK_DEV_INITRD checking?
> > >
> > > That means below (d) moving ahead of (c)
> > > prvious:
> > > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
> > > if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
> > > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
> > > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
> > >
> > > now:
> > > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) { ---(a)
> > > if (memory_limit != PHYS_ADDR_MAX) {}              ----------------(b)
> > > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}  --------------(d)
> > > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}  ---(c)
> > >
> >
> > After tracing the kernel code,
> > is it even possible to move CONFIG_RANDOMIZE_BASE part of code ahead
> > of memory_limit?
> >
> > that mean the flow may look like below:
> > now2:
> > if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
> > if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
> > if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
> > if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
> >
> > in (b), the result of __pa_symbol(_text), memory_limit,
> > memblock_mem_limit_remove_map and  memblock_add
> > are not depended on memsart_addr.
> > So the now2 flow can grouping modification of memstart_address, put
> > (a) and (d) together.
>
> I'm afraid that you've lost me with this.
welcome for ur kind suggestion ^^

>Why isn't it just as simple as
> the diff below?
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index c29b17b520cd..ec3487c94b10 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -377,7 +377,7 @@ void __init arm64_memblock_init(void)
>                          base + size > memblock_start_of_DRAM() +
>                                        linear_region_size,
>                         "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
> -                       initrd_start = 0;
> +                       phys_initrd_size = 0;
>                 } else {
>                         memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>                         memblock_add(base, size);

This patch will also fix the issue, but it still needs 2 "if
comparisions" for getting initrd_start/initrd_end.
By possible grouping modification of memstart_address, and put
initrd_start/initrd_end to be calculated only when linear mapping check
pass. Maybe (just if) can let the code be more concise.

Sincerely appreciate all of yours great comment.
