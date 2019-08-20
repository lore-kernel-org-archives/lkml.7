Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC729C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8182C22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAB/CxVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfHTM2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:28:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32864 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfHTM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:28:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so2298809wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD0Co8FG/hJyJAYUqVEMglsK3T7bNz9NWAIKm1yXSok=;
        b=IAB/CxVy5OTM+bm1P/vwQO5e1zYJhw5W+8ZMfEr0TwRT2EHai9xEb7z0JLGvQL+AEM
         noesBxet+SdZXcyD+TDMiDedkuNJmvs0pynLhCizA0UKehvY/U9nfrqf3O3c50RdYmHc
         EgXw+nNiCh+Jqg7tX3pehf5oIkz3QOguhxAmmqUBwDTwZURbQrU1MliR4D+sVI/Dws45
         /wPIeJtLO2Bq1hSk5IZ6nNWF4wkRDFhE2tHy/FDvCFmeq3K+tWEMzX5g+jIp+xLZV1MA
         bPVJnH/qV91SbwdsFTlvnaGFPw3OEGc2X0UvXAcuGwYmdjhJpONCMhMRLJlRJAWxww/3
         gCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD0Co8FG/hJyJAYUqVEMglsK3T7bNz9NWAIKm1yXSok=;
        b=eMUrOFNrdLQSdALcMxWRxrS5zjKKh4PoAJJegatt9Yxhl8/PWJGOUPTwbI82sRIOy7
         q4X+bATIJeF0uZr2Xo6oQaOYEn7/GbMnGbxcGaNDa1T/3ZX1Uh7Jq6W4JcI7jwQzix48
         yU7F3D4hkZqH/lciplBAbzMReXdN+d6TeJi54RSQ6vvhJCAPBkRcLltntnLgeST7ZiXU
         njrz/vIaMrwF0uuQCwwCGAlaoTiBJ7BNRQqAVQrRH/x15AE3gp8P71hIE91XYKyRNlpb
         0tQycUXdOOZxsGX89AuPtdrCcgKJxNQhoQzbKjE/J+fPYW5sXvpcJ7pj9jya2SzJkuxW
         sROw==
X-Gm-Message-State: APjAAAWx4vojpofDe2b5Sz+wt0NDpC2/iPschRAmqGCV0iZ3c0w37qMb
        fs3XU+TEGLpqxWScN4pKAglrcvrF7KQCzy7Myw1wjg==
X-Google-Smtp-Source: APXvYqwSKf9shWqXFfBH3UvF0PUWc/5bjTYYsXrXLzFdNVsyC2m1uK+Ysr6+BUjAuYl3vNvngGtA/b2r1ypTsOqz4Ps=
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr25055919wmm.119.1566304116782;
 Tue, 20 Aug 2019 05:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <20190820115645.GP13294@shell.armlinux.org.uk>
In-Reply-To: <20190820115645.GP13294@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 20 Aug 2019 15:28:25 +0300
Message-ID: <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Chester Lin <clin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        Juergen Gross <JGross@suse.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Joey Lee <JLee@suse.com>, Gary Lin <GLin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index f3ce34113f89..909b11ba48d8 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> >               phys_addr_t block_start = reg->base;
> >               phys_addr_t block_end = reg->base + reg->size;
> >
> > +             if (memblock_is_nomap(reg))
> > +                     continue;
> > +
> >               if (reg->base < vmalloc_limit) {
> >                       if (block_end > lowmem_limit)
> >                               /*
>
> I think this hunk is sane - if the memory is marked nomap, then it isn't
> available for the kernel's use, so as far as calculating where the
> lowmem/highmem boundary is, it effectively doesn't exist and should be
> skipped.
>

I agree.

Chester, could you explain what you need beyond this change (and my
EFI stub change involving TEXT_OFFSET) to make things work on the
RPi2?
