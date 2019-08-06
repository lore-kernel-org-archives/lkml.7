Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87E3217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfHFLWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:22:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44314 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHFLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:22:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so53031789qtg.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 04:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DJbUQsoZZ0FGjbA6AkwMY536yKOBY9a6lrqQZk65v0=;
        b=jMs9BczU1ObZYOp9UIttiGf5dwp1FUj5vYNUMRVzRqq0Fiyose106PtHngr4AwK6We
         EXiyhxGws3ubPHc+/9VTgpUOZaw3Jjt9kttxK9Tr0CkAUWYhP337RfRxri38ZeVKWN5p
         sC119/CKrYjfgPG/O/rkh384sI/7Rl0g23YqeFWLvs5bRGAUqsVWfpv2LD7bzWmxGV1/
         kPIpvL5knCYGglYnKtbmznszaZymMrlh3zYSASk+5zBH+LFOBHPa+iRZWJs0DXvELewu
         i5098yDy6ZlHW1rYjHa77x6lXGh/Dh+LI/quXhv4T1bpsSX4VGDme0eOhn9GHyT9xY1g
         WTOw==
X-Gm-Message-State: APjAAAVOjtZgyksXSwQ6491fFjk+tp+d8PiMjmovDeHZ04RD7VSjFpxp
        lQQ/38C4AAyHijyr99gW1SW+oNR2gzjjECflCCUZyrwCGtU=
X-Google-Smtp-Source: APXvYqyzWDC9GRvA8EQtedq0R4fJfnN/AsKSVutRj356sCjf6M+BBqpQ9BXvh9WD0ugKIVoNfc2WD/EqZt3Eiq4iU/0=
X-Received: by 2002:aed:3363:: with SMTP id u90mr2470862qtd.7.1565090560212;
 Tue, 06 Aug 2019 04:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190805165128.GA23762@roeck-us.net> <CAK8P3a1MLMu0qh-j9fZXmG10-q2SZrtFm9JGT_xOuuZHQm31qw@mail.gmail.com>
 <20190805185204.GA28257@roeck-us.net> <CAK8P3a1AsD8SJge-W10xNsyYrYyLqce1W2+9nMGTPdHcP5haOg@mail.gmail.com>
 <20190805201857.GA28470@roeck-us.net>
In-Reply-To: <20190805201857.GA28470@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Aug 2019 13:22:22 +0200
Message-ID: <CAK8P3a2XfFp1gjaCuKh51WF8JQyzFxh2jddvEM5jnTpYpV6gMw@mail.gmail.com>
Subject: Re: [PATCH] page flags: prioritize kasan bits over last-cpuid
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 10:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Aug 05, 2019 at 09:57:59PM +0200, Arnd Bergmann wrote:
> > On Mon, Aug 5, 2019 at 8:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On Mon, Aug 05, 2019 at 08:35:40PM +0200, Arnd Bergmann wrote:
> > >
> > > No. I see the failure in next-20190729..next-20190805.
> > >
> > > I didn't try to apply that patch, but I don't see
> > > arch/mips/vdso/vdso.h in the tree. I only see
> > >
> > > arch/mips/include/asm/vdso.h
> > > arch/mips/include/asm/vdso/vdso.h
> > >
> > > Are you sure that your patch can be applied as-is ?
> >
> > Ah, right, we now have support for the generic vdso on mips,
> > so the file got moved from arch/mips/vdso/vdso.h to
> > arch/mips/include/asm/vdso/vdso.h
> >
> > Try applying it to the new location then. I think it should still apply,
> > but have not tried it.
> >
>
> Turns out it is applied there (it looks like it was merged into
> the original patch). But it doesn't help; the build failure is
> still there. Reverting "page flags: prioritize kasan bits over
> last-cpuid" on top of next-20190805 fixes the problem for me.

I found the problem now: the vdso conversion added a new file
arch/mips/vdso/config-n32-o32-env.c that contains this block

#if defined(CONFIG_MIPS32_O32) || defined(CONFIG_MIPS32_N32)
#undef CONFIG_64BIT
#define CONFIG_32BIT 1
#define CONFIG_GENERIC_ATOMIC64 1
#endif

while the header contains

#if _MIPS_SIM != _MIPS_SIM_ABI64 && defined(CONFIG_64BIT)
/* Building 32-bit VDSO for the 64-bit kernel. Fake a 32-bit Kconfig. */
#define BUILD_VDSO32_64
#undef CONFIG_64BIT
#define CONFIG_32BIT 1
#ifndef __ASSEMBLY__
#include <asm-generic/atomic64.h>
#endif
#endif

The lsecond #if check thus never triggers as CONFIG_64BIT
is already disabled by the time we get there.

I'll send  a fixup.

      Arnd
