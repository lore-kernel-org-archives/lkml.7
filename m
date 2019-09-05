Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B030C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2FC2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPq9707g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbfIEPw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:52:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41914 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389115AbfIEPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:52:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id j4so2452819lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7k75Od2gh5LmViyuPr3vhw7Ofp/g49ZOss6B4NPSWM=;
        b=FPq9707giVrG4ysDfw7c8kDWCpm5XtS/zj9wkNncf5wWV7GRxTjPpVycERPPbqt8jm
         X5hfp3nF454H676p+DmhNaAfUIUkyK1jffE+b4OsOMEFVr7hyKCFaoTppQGz49k3cIDQ
         koertEzb7gAJnCno/XyJ7MIGzTATCivJrEHnr2sED309rwYf4k2Gk/HW8GTPzyKkXi7c
         +rmkhfdNXKHSGgpUP0kbGcTochyAYB5YfurrC7A2sQQmsLVrcxtQUl6IbFNKn8xf6RCc
         JyZnhry0M9ePYM1NWmUz3I1tvlJt6+YqL/HYVoyr5PaxCLGE3meENdmzh1MfofAyndE+
         TY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7k75Od2gh5LmViyuPr3vhw7Ofp/g49ZOss6B4NPSWM=;
        b=H6hI7XhyksmUDyM9PkxVwhgAFQAfPB++gr0kp4PuhIyI9nVC4EL4Fc9VM7xiwwmhg/
         12bc+Jq5QjxH/wrrMnsK6rgqyGwBfeEHkxyPyk4lQGDiW17kQdiqxHb10zsP3k0jUwCz
         Hasnb9sScmcXLd7y89bNYXh969nLZcdlxaD3nJwPgoF4daXnJJZE5dui3A9HNNxqnbeN
         xR3TEgOyRl9i/S2QqNTmJKOiNA1fsJZeLDDz1cTNSbXbgVhWQpSuqTS8sKZiCSv42R9k
         I9e2agGjsRDnfPAmOsnLydRhKlXuUc0U9pIKxNNsj/AvEbHJ9dXWGS2HfoxR0QOZ0IG/
         C3hQ==
X-Gm-Message-State: APjAAAV3l/rvHgLfJk+2hBzvmJPq5EAVB8NpKjCwF98P2U6dLUY50kl+
        2y0CCSo20cWCajT9EC3I5F56Chg0gN36VVbyqCQ=
X-Google-Smtp-Source: APXvYqxCeGrCu4fGXFpAMcIqfQHML6ClQAORbDr1B2ZS00zN552YDERemH4ioM1JkAFHPAyAB28LsqNEYX79c0krItw=
X-Received: by 2002:ac2:5090:: with SMTP id f16mr3008694lfm.66.1567698775732;
 Thu, 05 Sep 2019 08:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org>
In-Reply-To: <20190905134535.GP9749@gate.crashing.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Sep 2019 17:52:44 +0200
Message-ID: <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 3:45 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> [ That's not what a feature test macro is; a feature test macro allows the
>   user to select some optional behaviour.  Things like _GNU_SOURCE.  ]

Yes and no. GNU libc defines feature test macros like you say, but
C++'s feature macros are like Rasmus/Nick are saying. I think libc's
definition is weird, I would call those "feature selection macros"
instead, because the user is selecting between some features (whether
to enable or not, for instance), rather than testing for the features.

> Why would GCC want to have macros for all features it has?  That would be
> quite a few new ones every release.

Maybe GCC wouldn't, but its users, they surely would. For anything
that 1) is a new language feature, 2) breaks backwards-compatibility
with previous (or other compilers) and 3) is expected to be used by
end users, yes, it would be very useful to have.

For the same reasons C++ is adding feature test macros all over the
place nowadays and it is considered good practice (see SD-6: SG10
Feature Test Recommendations).

Cheers,
Miguel
