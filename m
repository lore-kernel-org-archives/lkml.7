Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BBC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4430218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xkmh8J4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfDXEG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:06:28 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23762 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDXEG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:06:28 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3O46KOO031253;
        Wed, 24 Apr 2019 13:06:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3O46KOO031253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556078781;
        bh=/KSEYoat6LdzsbxXgMcr4MX80mtIOerKRK2HdrGWHQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xkmh8J4ZfQ8Jv8ZiBZTXJiU3QlIJsOYxzUFfYTg81WqTo/LH2EkWCT0oRz8EdYjQV
         E/boOREQ++2a55DMsygvqrDs2/87jjAOnrAazIQEU1I+t8vYmFMPbH3OkbTzOa55Mx
         eKqnaHYPV5b5MBlSzbEfW+9TGdXcGb/BZHlBmqubTpWqaLFaRq47+p+GlTeATFn28Z
         eYQAoE6eEMotBg81zSv13VIpYazJPVmlyA7RvPt2dQIfbcDaw+/Ovcq5tq/ZML5tRe
         rrlq2Pw8PA9hqbW1Drw5dNIZMzxjX2og4Jtsf6aGmidFFWiEfSklGjzb6SvIq2SIaV
         PpM8CUWNiiTzQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id n17so1298198vsr.1;
        Tue, 23 Apr 2019 21:06:21 -0700 (PDT)
X-Gm-Message-State: APjAAAUgx1bK0wtHhEro+W/5AMVTURHl9H6oVjhagBg16YCFBDtUQ/FI
        mM75J0mCtizxHF+fHiL1xOR+sTxSmpqT0Uq1NSM=
X-Google-Smtp-Source: APXvYqzALNGhw0kUVzQ/vxxBoJMMNdGwmPoof2uzmOqLi+JCMfqymIAldFINWDkx5TLzX6SPUmQLskSqfHdrafYD52E=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr16435712vsc.54.1556078780008;
 Tue, 23 Apr 2019 21:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190411180117.27704-1-keescook@chromium.org> <20190411180117.27704-2-keescook@chromium.org>
 <CAK7LNATvNJprA94Qypfub2rpbEEJkAeV3yqVyuk2aNEraDKZ6w@mail.gmail.com> <CAGXu5jLNwFfG-x-_Q6nTdU21t5B9z7dCgBekRiJ+MnUE14J12A@mail.gmail.com>
In-Reply-To: <CAGXu5jLNwFfG-x-_Q6nTdU21t5B9z7dCgBekRiJ+MnUE14J12A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 13:05:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwf6Q_q-wtqxCuz7-HOYiBdQ-5QbhOCkhX8Ujh01oLNA@mail.gmail.com>
Message-ID: <CAK7LNASwf6Q_q-wtqxCuz7-HOYiBdQ-5QbhOCkhX8Ujh01oLNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] security: Create "kernel hardening" config area
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 11, 2019 at 6:39 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Fri, Apr 12, 2019 at 3:01 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Right now kernel hardening options are scattered around various Kconfig
> > > files. This can be a central place to collect these kinds of options
> > > going forward. This is initially populated with the memory initialization
> > > options from the gcc-plugins.
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  scripts/gcc-plugins/Kconfig | 74 +++--------------------------
> > >  security/Kconfig            |  2 +
> > >  security/Kconfig.hardening  | 93 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 102 insertions(+), 67 deletions(-)
> > >  create mode 100644 security/Kconfig.hardening
> > >
> > > diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> > > index 74271dba4f94..84d471dea2b7 100644
> > > --- a/scripts/gcc-plugins/Kconfig
> > > +++ b/scripts/gcc-plugins/Kconfig
> > > @@ -13,10 +13,11 @@ config HAVE_GCC_PLUGINS
> > >           An arch should select this symbol if it supports building with
> > >           GCC plugins.
> > >
> > > -menuconfig GCC_PLUGINS
> > > -       bool "GCC plugins"
> > > +config GCC_PLUGINS
> > > +       bool
> > >         depends on HAVE_GCC_PLUGINS
> > >         depends on PLUGIN_HOSTCC != ""
> > > +       default y
> > >         help
> > >           GCC plugins are loadable modules that provide extra features to the
> > >           compiler. They are useful for runtime instrumentation and static analysis.
> > > @@ -25,6 +26,8 @@ menuconfig GCC_PLUGINS
> > >
> > >  if GCC_PLUGINS
> > >
> > > +menu "GCC plugins"
> > > +
> >
> >
> >
> > Just a tip to save "if" ... "endif" block.
> >
> >
> > If you like, you can write like follows:
> >
> >
> > menu "GCC plugins"
> >           depends on GCC_PLUGINS
> >
> >   <menu body>
> >
> > endmenu
>
> Ah yes, thanks! Adjusted.
>
> > > +menu "Memory initialization"
> > > +
> > > +choice
> > > +       prompt "Initialize kernel stack variables at function entry"
> > > +       depends on GCC_PLUGINS
> >
> > On second thought,
> > this 'depends on' is unnecessary
> > because INIT_STACK_NONE should be always visible.
>
> Oh yes, excellent point. Adjusted.
>
> > Another behavior change is
> > GCC_PLUGIN_STRUCTLEAK was previously enabled by all{yes,mod}config,
> > and in the compile-test coverage.
>
> I could set the defaults based on CONFIG_COMPILE_TEST, though? I.e.:
>
>         prompt "Initialize kernel stack variables at function entry"
>         default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
>         default INIT_STACK_ALL if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT
>         default INIT_STACK_NONE

Looks a good idea to me.

Thanks.



-- 
Best Regards
Masahiro Yamada
