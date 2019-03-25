Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD90BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B0C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfCYHdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:33:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35984 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfCYHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:33:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id y36so9167556qtb.3;
        Mon, 25 Mar 2019 00:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MqoVO4GdF3K6sehfp7D7I5RtwnxGYYTVEiIQ0OI5sQ=;
        b=KDHhDkNPbfPYTa179Umicum9j8+V8SyYignlqvG+6M226VYe44ZLh94flHfli+mFL6
         J2UxIqyLWYJT51nB1KU/q0l79FIZzzAGrUcMz5fmIiLAXm6iKIV2ih7gMK6w5tx0DWtp
         U0NRC7ZQFSVEUg8fevu0M7+oZkNb8zTwJW4/lPEuh3rYWEuigF5I5fUMslyLSxo3uYKs
         jB1BD1igL7aK5UrivwU8wf1oEMRxgnzb2c3cWQZFjosJ3JgWbQWj3gdYKkL3Oq5nqWy3
         Qw7MTV+NKWr8G+QzK/cH2eo4Q7jFUTXyl6XdNgow/cEMse6vXsRU0xghQmf8NbRcVjlx
         nBlA==
X-Gm-Message-State: APjAAAWH/QcGDgB5Bi/+Zu2d7s9lEi4UqqpQZLmYOS0N9mY89ZTPOE9r
        Cli6zcrePqyyWEtdaHKcI8/60Ta8DvAbOE+OjTc=
X-Google-Smtp-Source: APXvYqxKEsoDhNlT5+1LqguQotzzoYfh33c3j/RJW0lHblejN8SPJQgxr41seRZPVPQ7PbwWXyRFPtHB2ovD82Zw4eY=
X-Received: by 2002:a0c:9487:: with SMTP id j7mr18527311qvj.180.1553499185439;
 Mon, 25 Mar 2019 00:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com> <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Mar 2019 08:32:48 +0100
Message-ID: <CAK8P3a1P812avY8reSSguYB0jPzgjs+30dSJpKZCnWwzyLoSVQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 7:11 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Wed, Mar 20, 2019 at 10:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > I've added your patch to my randconfig test setup and will let you
> > > know if I see anything noticeable. I'm currently testing clang-arm32,
> > > clang-arm64 and gcc-x86.
> >
> > This is the only additional bug that has come up so far:
> >
> > `.exit.text' referenced in section `.alt.smp.init' of
> > drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> > `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
> >
> > diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
> > index 201100226301..84b12e33104d 100644
> > --- a/arch/arm/kernel/atags.h
> > +++ b/arch/arm/kernel/atags.h
> > @@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
> >  const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
> >         unsigned int machine_nr);
> >  #else
> > -static inline const struct machine_desc *
> > +static __always_inline const struct machine_desc *
> >  setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
> >  {
> >         early_print("no ATAGS support: can't continue\n");
> >
>
>
> I do not know why to reproduce it,
> but is "__init __noreturn" more sensible than
> "__always_inline" here?

It's in a header file, so it has to be 'inline'. We could make it
static inline __init __noreturn, but I don't see an advantage over
__always_inline there.

        Arnd
