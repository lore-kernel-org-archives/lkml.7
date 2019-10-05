Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22059C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65AE218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAdTY2oD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfJERbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 13:31:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46860 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbfJERbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 13:31:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so6541723lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOh5bVUrX7IAKn3pEX/4xVW+6D3JWxfK2nPxatwmrpk=;
        b=mAdTY2oDYHf6xdorYAFu7JcUueB/Fpp4HUWnuqJmOjAB0RFgw5XokM2AMcB/SwG6Re
         5o8XmCTh0q9kYHWMsXfZN+G7BnuP+Ur4iol/Nu30Wl5m2TdJtqYithbmlACOYqkP+q6o
         LFvKVDSiqlW9NDFc3aHa98hyfEF8fXvCoq16KX+NCpTzrkELg5McXe+b48pAyyLgwArB
         zCyoQ7Zl/jJx+3KNlQUZ6+IYXmux0MGM686Iva7bV+oYTh/pyyjUAQZFTC9bZMCriCMI
         9WHMUi7fIR14V1AIkkyFak9B4S1FaJlTwqIxB7pWcGdEs4zCQs3rALsYBTO7wUoWzehL
         H+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOh5bVUrX7IAKn3pEX/4xVW+6D3JWxfK2nPxatwmrpk=;
        b=NnBTBaowTu98r3DYpHIIw9qYKN8PsZs9mzhcmo8NFWIktvuFQAs2cnwPgB0o3G3Urg
         LaXmIM5hvy+FTYujuxDAM1SduQzZCEQzEZ5W1B462JYfQs8l+0vbznpbRKd20Mz/Q1Zr
         CdMS1Z/uuheDftK8czAbYwS5wBq/yy6TN1mYWAGeW13Fz9mlOfsphX71b2CGxPkaRVot
         R4f37d1pTRgqQ5ifWpxiuTeAb1mSIGYHJFUgmh5Kxi3jQpWGjv5iyRZiBQLEEDSoaWgU
         rGnfUvucEJjYidyOyJbeo/eMs2/c8JbMv4f4IUxd/HZgC2o6O6QZ4ROnSiKHg6eTYqov
         QXOQ==
X-Gm-Message-State: APjAAAWnwhqrVyICSRWEzuOjDdWgVJn5cnvA5+b60+C1aGrTI2K6lj2o
        MtNboMR3+9Q38JHLConwz/bvpbJTihIho56usU4INH4f+ic=
X-Google-Smtp-Source: APXvYqyrbjdgIF7JbjenDM4muBLuuZlH557ZG8z+BsEd6hH/84FODxVpedVR6lCVz2ZfNqiSEvkWttOlbtBnGsHEv9Q=
X-Received: by 2002:a19:5515:: with SMTP id n21mr12819882lfe.131.1570296701406;
 Sat, 05 Oct 2019 10:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
In-Reply-To: <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 5 Oct 2019 19:31:30 +0200
Message-ID: <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
Subject: Re: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in
 various ways
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
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

Hi Joe,

On Sat, Oct 5, 2019 at 6:47 PM Joe Perches <joe@perches.com> wrote:
>
> diff --git a/scripts/cvt_style.pl b/scripts/cvt_style.pl
> new file mode 100755
> index 000000000000..fcbda0b1c67a
> --- /dev/null
> +++ b/scripts/cvt_style.pl
> @@ -0,0 +1,808 @@
> +#!/usr/bin/perl -w

Nit: #!/usr/bin/env perl instead?

> +
> +# Change some style elements of a source file
> +# An imperfect source code formatter.
> +# Might make trivial patches a bit easier.
> +#
> +# usage: perl scripts/cvt_kernel_style.pl <files>
> +#
> +# Licensed under the terms of the GNU GPL License version 2

Nit: use # SPDX-License-Identifier: GPL-2.0-only instead

As for the commit itself: while I am sure this tool is very useful
(and certainly you put a *lot* of effort into this tool), I don't see
how it is related to the fallthrough remapping (at least the
non-fallthrough parts).

Also, we should consider whether we want more tools like this now or
simply put the efforts into moving to clang-format.

Cheers,
Miguel
