Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33658C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075042173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="J837pIAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbfGPVUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:20:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44451 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPVUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:20:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so15764555qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCMqjQY1EfB7z90CfIGKFyQABHocaWBggoSAQglurII=;
        b=J837pIADAVioQ6H3B4TYC0CHRPniTEJRdH4Can2qTTAk4+G5byFhjUshtUTl0qVl6g
         4UiCgMJbOMjUYa5Ru73VAG9+mmUUNC3jXhxsvy776WUHYjrONGGzCI+u1cg1wKXETmOY
         EZIoyJ55cRABEx+KunN5IkQg19+YL/Jx+IG8wRuAkqpEPI9dr47AdGPyE49Nn3U3uQab
         s305IkLZyXuihsRvfg3ShbFrNE6o0D3bHpnPcMt8YeZlK0XXlj336yASFuvEohq23VML
         r/gN1BAxMw4O2/lH1Zq4Iy/evsWSo1are0iog9HWCQp9F7VIMcd5BDk2qFa0ALh8pgLt
         o/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCMqjQY1EfB7z90CfIGKFyQABHocaWBggoSAQglurII=;
        b=Ms8KC8uXZUm4fqujlJakOGNGGoc2FPdk2lnAV2adYHTVzBdA4y8SL6WuqmfF2guBcC
         J7o5A7Wc+bMuOt8bWPGhmWJN+mkt8DHdF7ubKUC1wf0Q2DwyhP5dq+w8KI3ggp66FdBq
         j/nZMSuwAxEIBy2U7atv1yMU7yBaOIWbQs2+r3tHad4BA32f5XIoswUm9nmK8kBZ6pVe
         XM4Nqgp+qfb/iP4XMBGMITNKGW2EjPNjmO1FobYd3RbzRJZLiRo7j3+66aRjtatn/Z5l
         v6lNve/itUk8qa3en9tTEZv665nt5CNWzL8P4e/GfnoK0aRwXDwme6MX5ERba6NCE83N
         DpLA==
X-Gm-Message-State: APjAAAVpamMdTcjE7lJGZXp6LGI/jQsVPtZJkO+LSSGoXY251XhjsAWv
        AdDoOAVIR9qQDj184KRaMUToE/FqFlYiH98lPm0=
X-Google-Smtp-Source: APXvYqyTznyrfvSwPy+AeBVy04uHSVru3FAa2BJAaZpEYuk8L32Bdr3bUcKY7DDCWW19b6hUMglBoftG6843YnJ9FbY=
X-Received: by 2002:a37:a2cc:: with SMTP id l195mr22218469qke.362.1563312016936;
 Tue, 16 Jul 2019 14:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de> <20190716195957.GA38495@archlinux-threadripper>
In-Reply-To: <20190716195957.GA38495@archlinux-threadripper>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 16 Jul 2019 22:20:06 +0100
Message-ID: <CAHbf0-GjYKZtV2786d5n2EEnVM9TW6cZbxjG3mtqm_bw=1CThA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 at 21:00, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Jul 16, 2019 at 09:47:27PM +0200, Thomas Gleixner wrote:
> > The gold linker has known issues of failing the build both in random and in
> > predictible ways:
> >
> >  - The x86/X32 VDSO build fails with:
> >
> >    arch/x86/entry/vdso/vclock_gettime-x32.o:vclock_gettime.c:function do_hres:
> >    error: relocation overflow: reference to 'hvclock_page'
> >
> >    That's a known issue for years and the usual workaround is to disable
> >    CONFIG_X86_32
> >
> >  - A recent build failure is caused by turning a relocation into an
> >    absolute one for unknown reasons. See link below.
> >
> >  - There are a couple of gold workarounds applied already, but reports
> >    about broken builds with ld.gold keep coming in on a regular base and in
> >    most cases the root cause is unclear.
> >
> > In context of the most recent fail H.J. stated:
> >
> >   "Since building a workable kernel for different kernel configurations
> >    isn't a requirement for gold, I don't recommend gold for kernel."
> >
> > So instead of dealing with attempts to duct tape gold support without
> > understanding the root cause and without support from the gold folks, fail
> > the build when gold is detected.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com
>
> Based on the crude little testing script I wrote below:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>
> $ cat test.sh
> #!/bin/bash
>
> # ld.bfd (expected to pass)
> make distclean defconfig || exit ${?}
>
> # ld.gold explicitly (expected to fail)
> make LD=ld.gold distclean defconfig && exit ${?}
>
> # ld.gold as if it were the system linker (expected to fail)
> ln -fs /usr/bin/ld.gold ld
> PATH=${PWD}:${PATH} make distclean defconfig && exit ${?}
>
> # ld.lld (expected to pass)
> make LD=ld.lld distclean defconfig || exit ${?}

Hi

Would it be possible to force ld.bfd with -fuse-ld=bfd when gold is detected?

Are there gold bug reports for any of the issues that have been seen
with gold? It's been my default system linker for years and I've had
very few issues with it and it's a big improvement when linking with
LTO

Cheers

Mike
