Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25213218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgmmlbRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfB1Sv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:51:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35134 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfB1Sv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:51:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id p19so10178730plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3WCfld6VGlFUzrYb6K+01b/si8ybvGNt+u8JPbK3d0=;
        b=jgmmlbRYnFGZKW4/fw45YyX0glSTiz7z1ONodAoiHBLvEUq+iPMZHW6njHTlfVGXMD
         bLxzw9sgHFRW3cjasNFcCeSodhduFBtrovkM0QjTmr+8qJ1jYrZZMEiwCyv5dfYq2TvG
         5ideK6lwsKlX3IVSf/Rd2xjDvvH2iJLbe0DpViLR6x7E5PoR2KPsmZ5ILvQcmBhZoKru
         DBHmoEgeGvodBM6pE7j8Szj08X8Cfa3e2jzBy0WIb0mgbKv0/JNMQB+BCJ8s+EwDeHSv
         LHREjjYXotYdDpuWiF2GmwyqVM0Nrut/1fSSbENGEvBC04OBaDuxoGSNDvVCBJYEe7Ny
         Y9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3WCfld6VGlFUzrYb6K+01b/si8ybvGNt+u8JPbK3d0=;
        b=OXAmyIurWpIOJ3wkLZc7MKGoJSraBbYTjpf5SJOdyMDUCzzgY5oHvfJGEAJSTR1Wou
         L8Z2JakbsyKHKisva1HHoa2Z+L5oPi976Kknq1cxO+F0Dv8Z1XOnmkHUElNk5Sg3Od3R
         lazoGcw8kXQAzPeflDpieHJ4J6TtQjeGECS+LJqgQAThR0VQC1EddG1QY7/qo/XGoJe3
         PDKDhDig+VC+Rp2W74lDqNj3M0Fa4YCBkeAM1D/9+8wN+odOpU5o9VSnVj3isjFKBbr+
         CgZcFZXqqljciWTL8H2YKubBUyZrBC+Tzwd47pP6MXTrk23FeLvwyiUp5oTPkniCAeCf
         0Whg==
X-Gm-Message-State: APjAAAUzmYI3PufF8gcZM2dpDiuxBAtXYzSK69Z0e9a6iTQNfpmPXHcA
        U3T4NuPKlp4Q1WQqkYUMICZSopxlZaqv3YmGmrXlXg==
X-Google-Smtp-Source: APXvYqz6bcusX1/60rvdZpekr2aq1ji5EftAaMrW4Wk10ZkqN4DBKzwb/69C7gDI9xqjP4WcWbDmEf7gB6NXE5S1H8g=
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr866072plx.13.1551379888235;
 Thu, 28 Feb 2019 10:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20190226040345.202047-1-ndesaulniers@google.com>
 <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
 <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com> <b3bf85a9-85de-3800-787e-2b00d3edd939@arm.com>
In-Reply-To: <b3bf85a9-85de-3800-787e-2b00d3edd939@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Feb 2019 10:51:17 -0800
Message-ID: <CAKwvOdm=y-5XHt1V-99Cu+kMVy9Ah6KdE4h2gY+bHgr4eem15A@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:00 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 26/02/2019 20:44, Nick Desaulniers wrote:
> > On Mon, Feb 25, 2019 at 11:19 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
> >>>
> >>> Clang warns: vector initializers are not compatible with NEON intrinsics
> >>> in big endian mode [-Wnonportable-vector-initialization]
> >>>
> >>> While this is usually the case, it's not an issue for this case since
> >>> we're initializing the uint8x16_t (16x uint8_t's) with the same value.
> >>>
> >>> Instead, use vdupq_n_u8 which both compilers lower into a single movi
> >>> instruction: https://godbolt.org/z/vBrgzt
> >>>
> >>> This avoids the static storage for a constant value.
> >>>
> >>> Link: https://github.com/ClangBuiltLinux/linux/issues/214
> >>> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> >>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >>
> >> Much better, thanks,
> >>
> >> Did you double check that the intrinsic exists on 32-bit ARM as well?
> >> I assume it does, but please make sure if you haven't yet.
> >
> > Thanks for the review!
> > Looking through Clang's generated arm_neon.h, vdupq_n_u8 seems to have
> > 2 definitions predicated on __LITTLE_ENDIAN__ (not __arch64__ or
> > __ARM_ARCH >= 8 like some of the other types and functions).
> >
> > So NEON got some additions in v8?  Is there a doc that lists them?
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491g/BABDBBJB.html
> > is where I found vdupq_n_u8, but it doesn't seem to mention
> > compatibility (so I assume it's been around since the introduction of
> > NEON?).
>
> FWIW the most recent 'proper' spec document I know of is this one:
>
> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0073b/index.html

Bookmarked, thanks!
Ard, page 171 mentions armv7, armv8 for supported architectures for vdupq_n_u8.

>
>
> Apparently we have a more interactive playground on the new site, too:
>
> https://developer.arm.com/technologies/neon/intrinsics

Also bookmarked! I'm also super happy to see this; I'm familiar with
Intel's equivalent:
https://software.intel.com/sites/landingpage/IntrinsicsGuide/

Interactive sites like these are quite useful.  Reading a post
recently: https://www.sigarch.org/simd-instructions-considered-harmful/

"The IA-32 instruction set has grown from 80 to around 1400
instructions since 1978, largely fueled by SIMD."

reminded me how useful and almost necessary the interactive sites are
for navigating the large swathes of SIMD extensions.  (no comment on
the title of that article)

-- 
Thanks,
~Nick Desaulniers
