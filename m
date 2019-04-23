Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDADC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B3921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UIoYEyIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfDWTmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:42:05 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34389 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:42:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id n17so695729vsr.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfae1L7qQtGmcEC0kaUhc8lAK/W6bAcsEpn3yxXkxig=;
        b=UIoYEyIFIWQgCLjOzYoQ6qTU+folQszrYetmsA9uX1etgnIt/SniEXJwDIr+waZZBy
         u7oyknqBHgkluOmDWiVGxLC/JLF862NLsCuWt/cC2ebLFszfLNOoxcd1OgHzFLE3Yp3O
         4HTySG1EgUuCUJ9tbK0cmMBdiR2/bEN9lpvCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfae1L7qQtGmcEC0kaUhc8lAK/W6bAcsEpn3yxXkxig=;
        b=gwnsFbM843CZ05/VHA5ya2Exk50SARxD1RopapDXAPJ1qinhGM24Y62TUR6r5t78xC
         96pMKxNukRhA1JaEGWvzJ7u7H4iwrOvGeDGtqyCaz+LoBKLsz0/fh7VPZj8Tai1IX5VI
         GHiK9yIP5joAn5BiRFBqqlvSCVVqnL58ZNWoZuzzTv1RZL7Akdau4S0NkAmBkAl4Hgj7
         9G4IPaEZUKLhb9/KOT6QFwKrA0KFB5xcoOPqtI27/e+S+5t03yAfQGq1cDmRnKmIVA/S
         fvAwGtUGA4zBVtcVwEPTnqT0mxraoF4nqdp/YwoLIGIqz9EdxZWFtHmrfWOzqAo2wbSU
         cb2Q==
X-Gm-Message-State: APjAAAX3SbIGRYTiMrrYaIFsrglqlnmsg0tABHxHPA8OKSG9/4Jn/GAp
        103AkKtdb5zc+utpB4zt6pgibakQq2w=
X-Google-Smtp-Source: APXvYqzuA5T1oHsfFLUOccoFuIa9lUP6pTDlokjk5Dl/lTiYmtvI74Q3co7fYcnrpw4BinH8MDiPDA==
X-Received: by 2002:a67:ea53:: with SMTP id r19mr14684987vso.12.1556048523856;
        Tue, 23 Apr 2019 12:42:03 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 2sm18645652vke.27.2019.04.23.12.42.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:42:03 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id d8so8943328vsp.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:42:03 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr14431245vsp.188.1556048215473;
 Tue, 23 Apr 2019 12:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190411180117.27704-1-keescook@chromium.org> <20190411180117.27704-2-keescook@chromium.org>
 <CAK7LNATvNJprA94Qypfub2rpbEEJkAeV3yqVyuk2aNEraDKZ6w@mail.gmail.com>
In-Reply-To: <CAK7LNATvNJprA94Qypfub2rpbEEJkAeV3yqVyuk2aNEraDKZ6w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 12:36:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLNwFfG-x-_Q6nTdU21t5B9z7dCgBekRiJ+MnUE14J12A@mail.gmail.com>
Message-ID: <CAGXu5jLNwFfG-x-_Q6nTdU21t5B9z7dCgBekRiJ+MnUE14J12A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] security: Create "kernel hardening" config area
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Thu, Apr 11, 2019 at 6:39 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Apr 12, 2019 at 3:01 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Right now kernel hardening options are scattered around various Kconfig
> > files. This can be a central place to collect these kinds of options
> > going forward. This is initially populated with the memory initialization
> > options from the gcc-plugins.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  scripts/gcc-plugins/Kconfig | 74 +++--------------------------
> >  security/Kconfig            |  2 +
> >  security/Kconfig.hardening  | 93 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+), 67 deletions(-)
> >  create mode 100644 security/Kconfig.hardening
> >
> > diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> > index 74271dba4f94..84d471dea2b7 100644
> > --- a/scripts/gcc-plugins/Kconfig
> > +++ b/scripts/gcc-plugins/Kconfig
> > @@ -13,10 +13,11 @@ config HAVE_GCC_PLUGINS
> >           An arch should select this symbol if it supports building with
> >           GCC plugins.
> >
> > -menuconfig GCC_PLUGINS
> > -       bool "GCC plugins"
> > +config GCC_PLUGINS
> > +       bool
> >         depends on HAVE_GCC_PLUGINS
> >         depends on PLUGIN_HOSTCC != ""
> > +       default y
> >         help
> >           GCC plugins are loadable modules that provide extra features to the
> >           compiler. They are useful for runtime instrumentation and static analysis.
> > @@ -25,6 +26,8 @@ menuconfig GCC_PLUGINS
> >
> >  if GCC_PLUGINS
> >
> > +menu "GCC plugins"
> > +
>
>
>
> Just a tip to save "if" ... "endif" block.
>
>
> If you like, you can write like follows:
>
>
> menu "GCC plugins"
>           depends on GCC_PLUGINS
>
>   <menu body>
>
> endmenu

Ah yes, thanks! Adjusted.

> > +menu "Memory initialization"
> > +
> > +choice
> > +       prompt "Initialize kernel stack variables at function entry"
> > +       depends on GCC_PLUGINS
>
> On second thought,
> this 'depends on' is unnecessary
> because INIT_STACK_NONE should be always visible.

Oh yes, excellent point. Adjusted.

> Another behavior change is
> GCC_PLUGIN_STRUCTLEAK was previously enabled by all{yes,mod}config,
> and in the compile-test coverage.

I could set the defaults based on CONFIG_COMPILE_TEST, though? I.e.:

        prompt "Initialize kernel stack variables at function entry"
        default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
        default INIT_STACK_ALL if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT
        default INIT_STACK_NONE

>
> It will be disabled for all{yes,mod}config with this patch.
>
> This is up to you. Just FYI.

Thanks for looking this over!

-- 
Kees Cook
