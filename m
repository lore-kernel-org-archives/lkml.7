Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63437C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FE621955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDjyv2RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbfGVW7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:59:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41466 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfGVW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:59:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id 2so27520748vso.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6gUbUP/R00uoc9Oz2jeql1BpGA/m6qMkrIPJ3QlddQ=;
        b=eDjyv2RY6Bx4fYO+npn5oQzh2ioB1kdfEs/Vgg+MCADFjd7DVetXClfe1YfjcOwMog
         E+L3nvfN9zYRTtr1CiJKRxNrxV8ziXeUzOXNCId2D6ggLKsAyivk7Ojru+RDhqPGbjvh
         tT5F3RjcXTnIxoaor4LJNJ4j4Kzp3ZxBP3vrA+5g6kI8GDfg5ey9XALTNZM40w4U17Sz
         kNKuvAYA1ZznLYUO2LQODUZOTgttZr7BL801Nlel9KEpUqRLemKEVv5e31nJcynHl/ys
         fKUr3KHOx9nRztN90OSTcELT4hLQQeWQxt7/KOw7ujuPb07mFENrFJZ4JChjO0wtcgVe
         1b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6gUbUP/R00uoc9Oz2jeql1BpGA/m6qMkrIPJ3QlddQ=;
        b=es5RbOAQQ8FDLhXFUV4j1714rLTB5x/ssO1C18mlNfEA9dIdbUwVknjLM9RtCWug1L
         MWjvMnRdN2aUaEIdEUg0ivF4BLXUBtzLCE7W0alogPVNVFk3GXgE1X1MU5dNt07t7eOQ
         L7i0mVkQmR5JOqRSc2br9iW0Vs0r++7jGdeSl0iXdfCALVxxbqDgOy3WL6tcjsRn7Duh
         n+UbxClMSsIqBvjAgbtFXhmwh8yJWPhsOAG2JTu7oEe5OGN3MHb4RqcehFn8L+M5f7J+
         N7mgrSRTDJLcw0AqbN6SSO496cqSg/j/NUXC3z3fwxt1vLDyjDHIpgVx8xC2LDgE6Uk4
         0kmw==
X-Gm-Message-State: APjAAAX03d7/kSgLHSbT5BqjvipzerIcwLWqU7LrO0gMSjw1RMl7C5T3
        c9M9fmgIqvHodIN9Fs/D+pJWoyRujHpel1CXrhMSFg==
X-Google-Smtp-Source: APXvYqwpzobo+k9xTUdhuWur2J3vnVuV41nS4xgFn1mj3wzSYgKZ7x9fW/TARiZSFh2NVZ7R0iZprQhyNfOjwxh8UCU=
X-Received: by 2002:a67:a209:: with SMTP id l9mr49107102vse.125.1563836344002;
 Mon, 22 Jul 2019 15:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
 <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
 <75B428FC-734C-4B15-B1A7-A3FC5F9F2FE5@lca.pw> <20190718.162928.124906203979938369.davem@davemloft.net>
 <1563572871.11067.2.camel@lca.pw> <1563829996.11067.4.camel@lca.pw>
In-Reply-To: <1563829996.11067.4.camel@lca.pw>
From:   James Y Knight <jyknight@google.com>
Date:   Mon, 22 Jul 2019 18:58:34 -0400
Message-ID: <CAA2zVHqXDuMzBC6dD5AbepZc63nPdJ3WLYmjinjq01erqH+HXA@mail.gmail.com>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
To:     Qian Cai <cai@lca.pw>
Cc:     David Miller <davem@davemloft.net>,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        natechancellor@gmail.com, Jakub Jelinek <jakub@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 5:13 PM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-07-19 at 17:47 -0400, Qian Cai wrote:
> > On Thu, 2019-07-18 at 16:29 -0700, David Miller wrote:
> > > From: Qian Cai <cai@lca.pw>
> > > Date: Thu, 18 Jul 2019 19:26:47 -0400
> > >
> > > >
> > > >
> > > > > On Jul 18, 2019, at 5:21 PM, Bill Wendling <morbo@google.com> wrote:
> > > > >
> > > > > [My previous response was marked as spam...]
> > > > >
> > > > > Top-of-tree clang says that it's const:
> > > > >
> > > > > $ gcc a.c -O2 && ./a.out
> > > > > a is a const.
> > > > >
> > > > > $ clang a.c -O2 && ./a.out
> > > > > a is a const.
> > > >
> > > >
> > > >
> > > > I used clang-7.0.1. So, this is getting worse where both GCC and clang
> > > > will
> > >
> > > start to suffer the
> > > > same problem.
> > >
> > > Then rewrite the module parameter macros such that the non-constness
> > > is evident to all compilers regardless of version.
> > >
> > > That is the place to fix this, otherwise we will just be adding hacks
> > > all over the place rather than in just one spot.
> >
> > The problem is that when the compiler is compiling be_main.o, it has no
> > knowledge about what is going to happen in load_module().  The compiler can
> > only
> > see that a "const struct kernel_param_ops" "__param_ops_rx_frag_size" at the
> > time with
> >
> > __param_ops_rx_frag_size.arg = &rx_frag_size
> >
> > but only in load_module()->parse_args()->parse_one()->param_set_ushort(), it
> > changes "__param_ops_rx_frag_size.arg" which in-turn changes the value
> > of "rx_frag_size".
>
> Even for an obvious case, the compilers still go ahead optimizing a variable as
> a constant. Maybe it is best to revert the commit d66acc39c7ce ("bitops:
> Optimise get_order()") unless some compiler experts could improve the situation.
>
> #include <stdio.h>
>
> int a = 1;
>
> int main(void)
> {
>         int *p;
>
>         p = &a;
>         *p = 2;
>
>         if (__builtin_constant_p(a))
>                 printf("a is a const.\n");
>
>         printf("a = %d\n", a);
>
>         return 0;
> }
>
> # gcc -O2 const.c -o const
>
> # ./const
> a is a const.
> a = 2

This example (like the former) is showing correct behavior. At the
point of invocation of __builtin_constant_p here, the compiler knows
that 'a' is 2, because you've just assigned it (through 'p', but that
indirection trivially disappears in optimization).
