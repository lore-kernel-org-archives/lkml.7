Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A100C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692EC218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhKvdiWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfJKWZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:25:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46764 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfJKWZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 18:25:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so8041259lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QenENoNx2upQIqA236w/j+vjS4vhzOddn2duiocDbww=;
        b=VhKvdiWs5xQOQcZOpC9jmPNE/5PCieS4wuW8xs129YXY8clv0DL1rMN2T1hTE1x1S2
         NJG/BXJD2Z1TzRqCk4PB9Gvrw4lQQpHUznLQFyi1q0HIX7THUQ139kCqMS1KoBszrUQu
         wZepbWhJEIVEnBdfohF8fn04UgwQchAJ+ilJFkRPYYq9VCyZacd/fjygUV0cnAAZavuj
         /s7VjcERH62JUpMfY1Yg1+CI3nIQCbUz+bKYY0IA+QbppJYPQlnm+560Zuv/Ws7qyp+9
         jZurs/WrGipGtj20sE/fWOCC5KHgaC3UzK8+lyAUlbkIqkEV3lVSeTE6gZg3DVUNemwX
         dzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QenENoNx2upQIqA236w/j+vjS4vhzOddn2duiocDbww=;
        b=KHNQ0tNS+R6URemWwx8aFp3gTBrG1KvWg6k6Iqek7s2qLcrPIfocGZKZUACimNf11Q
         R3Ruu5vei6H+oe3LWMd05B+3Nae2QBYrFSlryIPUfEewJK1/xuZzTwPpsFXCLPlkMgKa
         tBle5sZ4sLy5Vm2+/AszXmxtt6nc+gGsLy3keVlgm/9g7iLR/klg9tjmZTRZTJbExUvz
         iYLpg7CJYvLup/og86K8WGX+ICce73uVdyX7XZBHsU2NHwoNUykxXbACJQws/Fc4cNdT
         Tne1ECV4dp5Hoa0qeOb0Pm0mf/RpShSyLh/16veHEeOudb+62wuDd/jrpRDN9dw5JblZ
         HU4Q==
X-Gm-Message-State: APjAAAXRUzLqO2LTtBBIjmNCTpvjMnwIsiD/YqNeXoWVmw145bSzPWTP
        cZj/awx+byQz7PETZ8jOgoMUp1WWFzEu+CrLZzo=
X-Google-Smtp-Source: APXvYqxxg3eRrR7Sky0FdB3MsqJsagLiYndeKaYpFOg8K2XpFHP9OR9fTrDOmUkZ9+v6R4DoA4hbePaQEs5B/th2Zfk=
X-Received: by 2002:a19:ae05:: with SMTP id f5mr9672657lfc.165.1570832748416;
 Fri, 11 Oct 2019 15:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
 <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com> <201910101334.7E09211F@keescook>
In-Reply-To: <201910101334.7E09211F@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 12 Oct 2019 00:25:37 +0200
Message-ID: <CANiq72msyinpJ0TDe=kh0Zp7jnkWBkkGdy7RYzeY_kmgVDS8=w@mail.gmail.com>
Subject: Re: [PATCH 2/4] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     Kees Cook <keescook@chromium.org>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Oct 05, 2019 at 07:17:36PM +0200, Miguel Ojeda wrote:
> > Hi Joe,
> >
> > On Sat, Oct 5, 2019 at 6:46 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> > > various case block /* fallthrough */ style comments to appear to be an
> > > actual reserved word with the same gcc case block missing fallthrough
> > > warning capability.
> > >
> > > All switch/case blocks now must end in one of:
> > >
> > >         break;
> > >         fallthrough;
> > >         goto <label>;
> > >         return [expression];
> > >         continue;
> > >
> > > fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
> > > in gcc version 7..
> >
> > Nits: double period, missing "r" in fallthough.
> >
> > > fallthrough devolves to an empty "do {} while (0)" if the compiler
> > > version (any version less than gcc 7) does not support the attribute.
> >
> > Perhaps add a short note why (empty statement warnings maybe? I don't
> > remember them but it was months ago so maybe it changed).
> >
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Please add Dan's Suggested-by and copy the things I wrote in the
> > commit message when I proposed this:
> >
> >   https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4
>
> Perhaps just take this patch directly with Miguel's authorship into the
> series and tweak the __fallthrough to fallthrough in subject and body.

Since I was going to pick it up, I would have signed-off-by anyway, but yeah ;P

Cheers,
Miguel
