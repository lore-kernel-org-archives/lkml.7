Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBC2206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="mTekDiyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK0PKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:10:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41028 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:10:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id a21so19911595edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edWCWNJl31yQrbW0RZTxPYG82aTNE1yVNktB5ng+jf4=;
        b=mTekDiyG/xSD58MUN5RTKNnzPqxt+1ORlhcDVQSCtgZD7sNjGt7a7DEpyDJLCHSio+
         3duP0FXDUc/mOAzY3EV2Wa2JzDM2Z6fS8MEMH3ayihsodOPFsYkMEIBd7LfOfZB6anIx
         lM37RhXs12XiLUpTvHp3EPdsIp/U+F7GUFDci+3U9wwSRjHah2bgF25bCd+pqiRnIpVx
         SSVZOZFYRGW9qiOgMuEt9xfCdXkVY79xtc1sUWMxJbK2jnkeRKtKhnSTEbh8wAreQAAq
         LSHHTXHfzKolX04pR5vPDEdVs+lUuicziBwzYA/5s3QiUQiy3q1ddUB9m+130YMPSr77
         GYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edWCWNJl31yQrbW0RZTxPYG82aTNE1yVNktB5ng+jf4=;
        b=lRtcDuNtDOdFJ07hr/Gi9k6nl1fhJ2nSZ/r3abIoUgJ4dpw0WKMZ0F5+bnFyVnq3wj
         Pg382fdnMFlztyfDDt4081zQKoMH3OXAVeVfgrZxBHKcg6FtDutvnSzTG6xRK7vki1SC
         U1xFsunCaOQqAiNkf2xNnzZ3mHqWudVtTnyDu8F9NUz6C0UDOZ6XzzKAVs8/ekOUdE6t
         D2J5UzK1ysrPzap6Ns5l6YKDjKJjLhddrqdhHvBQBz5rFc0FJof2sQurwLTvWnG3FRD5
         enPyes/KBiTE0IrJlI4r/PtJm00DaOanyBecrEX3l9p7xUNyL4MXAbKnx3OSPSwm9ArO
         ZTMQ==
X-Gm-Message-State: APjAAAVOAUgnDBn3Kll8GZ2JNOHJAbxHokD9HxMrK1eCFmbHzTnv3oXm
        mOIdDV3S/AksnaxOU8Vt5Ed3ZBTcDXABRlF9fw+oUw==
X-Google-Smtp-Source: APXvYqyPH1e9Ql392wF4i1O7GHWfwg6/A8SLFBgaaht+RqQI1k7Yx/GSlGoDs4aBwXnGTvjkilYo3d8M41CYZdYnigY=
X-Received: by 2002:a05:6402:324:: with SMTP id q4mr32625784edw.108.1574867419153;
 Wed, 27 Nov 2019 07:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-3-pasha.tatashin@soleen.com> <20191127150137.GB51937@lakrids.cambridge.arm.com>
In-Reply-To: <20191127150137.GB51937@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Nov 2019 10:10:07 -0500
Message-ID: <CA+CK2bBvgDe5zVur7EYJgYhoZesuQkZVeyRxPCBSySqsR=-YPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: remove uaccess_ttbr0 asm macros from cache functions
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for reviewing this work.

> A commit message should provide rationale, rather than just a
> description of the patch. Something like:
>
> | We currently duplicate the logic to enable/disable uaccess via TTBR0,
> | with C functions and assembly macros. This is a maintenenace burden
> | and is liable to lead to subtle bugs, so let's get rid of the assembly
> | macros, and always use the C functions. This requires refactoring
> | some assembly functions to have a C wrapper.

Thank you for suggestion, I will fix my commit log.
>
> [...]
>
> > +static inline int invalidate_icache_range(unsigned long start,
> > +                                       unsigned long end)
> > +{
> > +     int rv;
> > +#if ARM64_HAS_CACHE_DIC
> > +     rv = arch_invalidate_icache_range(start, end);
> > +#else
> > +     uaccess_ttbr0_enable();
> > +     rv = arch_invalidate_icache_range(start, end);
> > +     uaccess_ttbr0_disable();
> > +#endif
> > +     return rv;
> > +}
>
> This ifdeffery is not the same as an alternative_if, and even if it were
> the ARM64_HAS_CACHE_DIC behaviour is not the same as the existing
> assembly.
>
> This should be:
>
> static inline int invalidate_icache_range(unsigned long start,
>                                           unsigned long end)
> {
>         int ret;
>
>         if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
>                 isb();
>                 return 0;
>         }
>
>         uaccess_ttbr0_enable();
>         ret = arch_invalidate_icache_range(start, end);
>         uaccess_ttbr0_disable();
>
>         return ret;
> }

I will fix it, thanks.

>
> The 'arch_' prefix should probably be 'asm_' (or have an '_asm' suffix),
> since this is entirely local to the arch code, and even then should only
> be called from the C wrappers.

Sure, I can change it to asm_*, I was using arch_* to be consistent
with __arch_copy_from_user() and friends.

Thank you,
Pasha
