Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6418CC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CE3205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uV8PXLrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfEPIiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:38:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37778 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEPIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:38:16 -0400
Received: by mail-io1-f68.google.com with SMTP id u2so1931844ioc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9JP0N9BOAKIKjnOKpvcauJRP2dUC/WHKbmpM2CzhnA=;
        b=uV8PXLrENhbYzJPMQg/GfuwTr2zlOMTnJo7nzJg05BO+KHWDwr3Gy/uxNWLBv7Kuka
         3NDIIOKcKiFBUsBMdUv3lHNHNwPeoXQ4FSdn4trrpXJVg+2yNarpb7yJgEUStTZLx+cS
         tidwhMPRDkWJAGrARxSxyE5gTccNzRGsFHOUjYS/90QUDPVTdo2humon+At1R42bVUJa
         FpcI/JbBOOXWBxyNW4GgunCPAUvgiQZHC5Z03vjL6j5oRIaVciSzG9MPfy6a69cLUnqH
         SaElm0KDWl3NEjcWzlORIUr2lLJSzpvzLtJHRrUcDk1dR1h7SC8acTT2bETRMCfSIP9W
         0ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9JP0N9BOAKIKjnOKpvcauJRP2dUC/WHKbmpM2CzhnA=;
        b=qxU6g1XAVcR1UhfkAAzU+RZC3pcLjSjQpZvX5hJdqIjmcXtN6G/Zh7lpCicUyENfiq
         VKzROssZJtMmhD3PkYvIdoqGYDy94mRnTa6bgQWFK1fASSRbp/0X/Y+djPieqscicrET
         fFFCgiqBRZgdXddffdfTpxJ7qhK7TVP11tCMYop8n9nM+TuuRdrA7ScFaKsoci8Cqws9
         xYADvcbYQOFXnI32OsJ+puJsUT7RR0tpVbVrX3Ni+MObnAQ2y8Mu2xeFVN6D8CE7PbQR
         f4g6hUE5d8V4/arUZ94+eFWZ0aTRJT6IwlVHI4Bb+O980/HRafzre8rd0nynhiZxLflS
         fIIA==
X-Gm-Message-State: APjAAAX1r4MNXto/NgUh/9b3WA7Wtw+rsG+OMKgq7axnbkCNdjncO6Bh
        mVOo/EFgvi3xLnq0iiRYyCAv8kaPddvKITcSz8j4Yw==
X-Google-Smtp-Source: APXvYqz9CmbRJ3iRRK2v6t05hYLre9i2on+joX41dk5hh0qgy7FoEcnsqERuE7gSKNj6gb2SeUu1Zka4+ya1Zbn+dDo=
X-Received: by 2002:a5d:93da:: with SMTP id j26mr26590152ioo.170.1557995895704;
 Thu, 16 May 2019 01:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com> <1557824407-19092-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1557824407-19092-4-git-send-email-anshuman.khandual@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 16 May 2019 10:38:03 +0200
Message-ID: <CAKv+Gu_ZOX8x22Pbo_XgwdauqqAh+b5U285WY8KrszXJVwwqHQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] arm64/mm: Inhibit huge-vmap with ptdump
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>, ira.weiny@intel.com,
        david@redhat.com, Robin Murphy <robin.murphy@arm.com>,
        Qian Cai <cai@lca.pw>, Logan Gunthorpe <logang@deltatee.com>,
        James Morse <james.morse@arm.com>, cpandya@codeaurora.org,
        arunks@codeaurora.org,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 at 11:00, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> From: Mark Rutland <mark.rutland@arm.com>
>
> The arm64 ptdump code can race with concurrent modification of the
> kernel page tables. At the time this was added, this was sound as:
>
> * Modifications to leaf entries could result in stale information being
>   logged, but would not result in a functional problem.
>
> * Boot time modifications to non-leaf entries (e.g. freeing of initmem)
>   were performed when the ptdump code cannot be invoked.
>
> * At runtime, modifications to non-leaf entries only occurred in the
>   vmalloc region, and these were strictly additive, as intermediate
>   entries were never freed.
>
> However, since commit:
>
>   commit 324420bf91f6 ("arm64: add support for ioremap() block mappings")
>
> ... it has been possible to create huge mappings in the vmalloc area at
> runtime, and as part of this existing intermediate levels of table my be
> removed and freed.
>
> It's possible for the ptdump code to race with this, and continue to
> walk tables which have been freed (and potentially poisoned or
> reallocated). As a result of this, the ptdump code may dereference bogus
> addresses, which could be fatal.
>
> Since huge-vmap is a TLB and memory optimization, we can disable it when
> the runtime ptdump code is in use to avoid this problem.
>

The reason I added this originally is so that we don't trigger a
warning when unmapping vmappings that use 2 MB block mappings, which
happens when we free the kernel's .init segment. The ability to create
such mappings is indeed an optimization that the kernel mapping code
does not rely on.


> Fixes: 324420bf91f60582 ("arm64: add support for ioremap() block mappings")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ef82312..37a902c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -955,13 +955,18 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
>
>  int __init arch_ioremap_pud_supported(void)
>  {
> -       /* only 4k granule supports level 1 block mappings */
> -       return IS_ENABLED(CONFIG_ARM64_4K_PAGES);
> +       /*
> +        * Only 4k granule supports level 1 block mappings.
> +        * SW table walks can't handle removal of intermediate entries.
> +        */
> +       return IS_ENABLED(CONFIG_ARM64_4K_PAGES) &&
> +              !IS_ENABLED(CONFIG_ARM64_PTDUMP_DEBUGFS);
>  }
>
>  int __init arch_ioremap_pmd_supported(void)
>  {
> -       return 1;
> +       /* See arch_ioremap_pud_supported() */
> +       return !IS_ENABLED(CONFIG_ARM64_PTDUMP_DEBUGFS);
>  }
>
>  int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
