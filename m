Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34354C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E4420878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yXa9OeV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfDXDlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:41:53 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:39541 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfDXDlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:41:53 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3O3fOQN020791;
        Wed, 24 Apr 2019 12:41:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3O3fOQN020791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556077285;
        bh=YN5R4J8MFslfEWj4/fJ8NFzh/Uc6ypge5CDtrk7AyuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yXa9OeV5MiUdoVbJHssVEmuZCLL1f8KVovbIqfsrBQQvnQm6u+VArc3zD1GEsNLET
         Ux11nkMBUqvqDTJQjq4KslKC6DGysS9H8fkN0TrA4DzVrZ7w5qLWA6aNHpgAGqkl/0
         6oZp6XEbNpa4uxHb7rdkLQtPTuH+WYWCnqmEZ9OQX4xnGBIh6hy2xBDSLOaacRNoKA
         8/cSZ51RvyTwRY1ZmQsLr8iOR7maM2oNw/6wh5COjd0NR3qee3HSx7UgQIwaxKWY6j
         Pw6pGYumjrFz8Ar+k9t5qNQv3Ow9/uklBmGjB7fm2CNknpbK67i7A+QAEEhF8DhDyW
         CJMh7Zzz/Jicw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id n4so9579175vsm.3;
        Tue, 23 Apr 2019 20:41:25 -0700 (PDT)
X-Gm-Message-State: APjAAAXHwmoE4p+SEnnO/rNdV6QzcVKnvL7Qy1dL9CZEWJT9735r0f3A
        HZ7QFvg/HVQKeTwq5pJgxbyCVWWBKIaRK7NBhEw=
X-Google-Smtp-Source: APXvYqxx3r1xD63gAPsaYHPYeMnzp2CFH9E5rZDblkAF/RYMykC3yiTACWe3SBQ+E87CktgZeEYQiQpElJR2L1qtdFA=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr16393701vsc.54.1556077284286;
 Tue, 23 Apr 2019 20:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com> <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 12:40:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYXE6R+ZPCP_3D3YPczbsmeqHUFN-r0NhFu_TPYz99Qw@mail.gmail.com>
Message-ID: <CAK7LNAQYXE6R+ZPCP_3D3YPczbsmeqHUFN-r0NhFu_TPYz99Qw@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 8:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Apr 23, 2019 at 11:47 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Hmm.  I suppose an alternative would be for vdso_install to fail if
> > the vdso isn't built?
>
> I absolutely abhor even the concept of building the kernel as root,
> and I think it should be actively disallowed. Our build system is
> good, but it's good as in "clever and complex" rather than necessarily
> good as in "very secure".
>
> So anybody who builds the kernel as root is doing something seriously
> wrong, in my opinion.
>
> That's partly exactly _because_ we have a lot of magical and very
> powerful build rules, and complicated implicit things going on.
>
> For example, our dependencies aren't even about just the files in the
> kernel repository itself, we have clever things like "if the compiler
> has been updated and features or version changes, we'll automatically
> rebuild, because it's part of our clever build system checks".
>
> But that is also part of the reason why I absolutely do *not* want any
> root-building to happen, because our build setup is simply way too
> clever.
>
> If root builds stuff, you'll end up with root-owned generated
> subdirectories or various config files etc, and even if you don't have
> security issues, it can complicate the build later as a regular user.
>
> I've had the build occasionally fail in odd ways, because some
> root-owned file was now no longer removable (usually it's the
> auto-generated header files in the directory, and the root-generated
> and owned directory is now not writable by the developer any more).
> And every time it happens, I shudder.
>
> So all of that simply boils down to "root should not be running those
> complex rules for our config and dependency magic".
>
> At the same time, "make install" obviously needs to be done as root.
>
> All of which is why I opine that "make install" should never build
> anything at all, it should purely be used as a "install previously
> built files".
>
> So yes, I'd much prefer just failing over trying to build as root (or
> even trying to figure out dependencies as root).
>
> > What's the ideal outcome here?
>
> I'd basically like the rule for "make install" to be that it never
> ever generates a single file in the build tree, so that there are
> never any root-owned (or root-overwritten) files there.
>
> So "make install" should even avoid all dependency checking, for the
> simple reason that if you happen to do a system update between "make"
> and "make install", our smart dependencies should never say "oh, the
> compiler version has changed, so now I'll rebuild everything as root
> just because 'make install'".
>
> So I think the ideal outcome is just "fail if you can't find the files
> to install".
>
>                      Linus

I assume this is ACK to change vdso Makefiles.
I will send patches.

Thanks.

-- 
Best Regards
Masahiro Yamada
