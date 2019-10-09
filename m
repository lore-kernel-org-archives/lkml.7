Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E9B206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="InKPrTMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfJIVwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:52:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33397 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfJIVwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:52:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so2295210pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97UEnZkq1363enDKYmWWwRqD4DtS+tvynceFknVUyPM=;
        b=InKPrTMa1e+FdIdNqHTz6q5ntOS2TrnoAYbmW5rmZYhz/Xd468AHt+nDruAX4im8yd
         kp8hdhrpOoDT+6VAmNnsYsS95oMWgUU1hvT/qR6wz3KBzWLB+SJjoBUTzCJKCxJpHO4g
         Mm5LZv6e86yVL3WjjtncdqED1RU6EDsgGs0ZDTyvsK0ewcfrHUTwhJ2BMVLscZA8KAyZ
         i1YRwlQXNGubbaLPYmP5p8gLfAMntJ9NIY6/MPIBs2GRh+X7xa2ukf+gQVt0dAOFYAfE
         nhYDXgkfsIz/da3KJMbIHXqmPWJNPKVW5xFAyVEmCphH/jobx5Msdq62kQ2UnUWLgAHy
         piag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97UEnZkq1363enDKYmWWwRqD4DtS+tvynceFknVUyPM=;
        b=eSPJHeLXEWAL5FNscYNu01dFxJP4LDhSv5gkSAZ2AgZlAYp/ig6nUjJ0V03vpBzbx1
         2jRyv50s02t+pvBgrMBRWTLOWR13alv5yA6KzU/40qc74hlEw+u3F4/o27LINpib9LaR
         pasjlrh/3UjMrxDmqCRulGUivNbnWtmXyWZY9SC97vQpX35bw8bXx46RY5ZMSptJtlY5
         IzA5xZg6d0A/xPcheeW3ppYP+DzEhZzJPQBRcQTsCaTDTHliK2isyeYISScfJN6HbgTD
         ZrZsgC5G5iPQw9pGVKcnY6ehQ5+IrQJuZGm2Gm5eHTqB9ChW/2DK4Lxbk4SigfyLrWDM
         e+sA==
X-Gm-Message-State: APjAAAWBBwqL8e0q02KU2+npI+Ot8weOD7mXz6XlZ4JaQsLugkO9H5w6
        zQVAG8L2IeN8l4g03wFU42y2dS+e9lUHMV2O3OrLQA==
X-Google-Smtp-Source: APXvYqyYmg74kA+ZWKX9kiYOJ1AMY8piMfZHJZXRGpX39gd4Zdj8mePRHNpEP6oLPbJP2HAssHN1Q87KYFoUuC+pQd4=
X-Received: by 2002:a63:ef51:: with SMTP id c17mr6596833pgk.10.1570657918818;
 Wed, 09 Oct 2019 14:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <09a42c7275afa7e6e9e3fc57a15122201fccd6f7.1570292505.git.joe@perches.com>
 <CANiq72=KMcYmcHL442OKwDBJj3czey-XtjtOBTLqh_HAsoJAzA@mail.gmail.com>
In-Reply-To: <CANiq72=KMcYmcHL442OKwDBJj3czey-XtjtOBTLqh_HAsoJAzA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Oct 2019 14:51:46 -0700
Message-ID: <CAKwvOdmuk_3AJKoiQi2feMD=3cHcTYFCfxuQ53VS_aHWeDEh9g@mail.gmail.com>
Subject: Re: [PATCH 3/4] Documentation/process: Add fallthrough pseudo-keyword
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 10:48 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 5, 2019 at 6:47 PM Joe Perches <joe@perches.com> wrote:
> >
> > +When the C17/C18  [[fallthrough]] syntax is more commonly supported by
>
> Note that C17/C18 does not have [[fallthrough]]. C++17 introduced it,
> as it is mentioned above. I would keep the
> __attribute__((fallthrough)) -> [[fallthrough]] change you did,
> though, since that is indeed the standard syntax (given the paragraph
> references C++17).
>
> I was told by Aaron Ballman (who is proposing them for C) that it is
> more or less likely that it becomes standardized in C2x. However, it
> is still not added to the draft (other attributes are already,
> though). See N2268 and N2269:
>
>     http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf (fallthrough)
>     http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2269.pdf
> (attributes in general)
>

Interesting. I think those links might be useful to include, or drop
the section on C++ style attributes outright. Either way:
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
