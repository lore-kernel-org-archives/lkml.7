Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A8820675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBq8bKtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbfDROTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:19:36 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39947 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389278AbfDROTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:19:34 -0400
Received: by mail-vk1-f193.google.com with SMTP id l17so488997vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eV2vUS51UMgePfSSxCuXJhq0Gtq0aUu2F6TTcKETz0=;
        b=FBq8bKtw8jKgNvkAesGOL5wEhVUfIvOVZLawNU9Os5filzXur33S5KXLGi3G59zEmJ
         MNxbw1dkanZJyl6+Bh/X7hbbi4DCuJUT+N82rjvvIQb1baWE98HINAsh1KYITkSEbQsv
         WkyhKK/r8PDat9cP9eHISsDMRa0TxCyHkKPk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eV2vUS51UMgePfSSxCuXJhq0Gtq0aUu2F6TTcKETz0=;
        b=hjrXu5rLBJ4//ry+cVYc2CzwF4eD4+MZE6vdC3cpAaaHD5KoYH6rgonLYYPz0Jod1S
         ZG/g9JsVoQzs6p7IV39VTMy2cOGdYPly8LrJ6SC7UP7aFhyaFxdZrW05QkczI8RSRpUQ
         eqWsspKhC1L7zefdLyeY5JnzZkNJ8/hs16+eO8y9L8d5zw9aK6TawpXiryVJYB/sLi6w
         ameE76WBlXSst9H+F39Zs/fBzYhOU7gJWEMUrveSpGQ2FDMoq3TgoeZzPEI7oM8i2a+A
         1Qjy8Jd+cwQkjAY9sLAfaxiABSHgDmrfgVv0HznZ1t34DfZWu6ViVzDDpkumbJodZZlJ
         20Qg==
X-Gm-Message-State: APjAAAUywTnkSXS1gqXTozgTAiIq+uRHbodaID6O5tYbytYxwM+5d5HZ
        ApvFqPYmbP2SN3HlbP3AiwgDRkHuFhs=
X-Google-Smtp-Source: APXvYqycS943ckmwWFUDXCzxaJsmmF05s60d3YiCrixLrIMZiLRQ9+UVz7C6MDVv7/KE3X4U/zk4Uw==
X-Received: by 2002:a1f:c446:: with SMTP id u67mr51760887vkf.52.1555597172387;
        Thu, 18 Apr 2019 07:19:32 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id t207sm647716vkb.21.2019.04.18.07.19.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:19:31 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id x194so498327vke.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:19:30 -0700 (PDT)
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr50481033vku.44.1555597170338;
 Thu, 18 Apr 2019 07:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-5-alex@ghiti.fr>
 <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com> <fd2b02b3-5872-ccf6-9f52-53f692fba02d@ghiti.fr>
In-Reply-To: <fd2b02b3-5872-ccf6-9f52-53f692fba02d@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 09:19:18 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
Message-ID: <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] arm64, mm: Move generic mmap layout functions to mm
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:55 AM Alex Ghiti <alex@ghiti.fr> wrote:
> Regarding the help text, I agree that it does not seem to be frequent to
> place
> comment above config like that, I'll let Christoph and you decide what's
> best. And I'll
> add the possibility for the arch to define its own STACK_RND_MASK.

Yeah, I think it's very helpful to spell out the requirements for new
architectures with these kinds of features in the help text (see
SECCOMP_FILTER for example).

> > I think CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT should select
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE. It would mean moving
>
>
> I don't think we should link those 2 features together: an architecture
> may want
> topdown mmap and don't care about randomization right ?

Given that the mmap randomization and stack randomization are already
coming along for the ride, it seems weird to make brk randomization an
optional feature (especially since all the of the architectures you're
converting include it). I'd also like these kinds of security features
to be available by default. So, I think one patch to adjust the MIPS
brk randomization entropy and then you can just include it in this
move.

> Actually, I had to add those ifdefs for mmap_rnd_compat_bits, not
> is_compat_task.

Oh! In that case, use CONFIG_HAVE_ARCH_MMAP_RND_BITS. :) Actually,
what would be maybe cleaner would be to add mmap_rnd_bits_min/max
consts set to 0 for the non-CONFIG_HAVE_ARCH_MMAP_RND_BITS case at the
top of mm/mmap.c.

I really like this clean-up! I think we can move x86 to it too without
too much pain. :)

-- 
Kees Cook
