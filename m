Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B640218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfCOI1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:27:20 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44692 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCOI1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:27:20 -0400
Received: by mail-vk1-f193.google.com with SMTP id q189so2006947vkq.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edV51IMGqi37Bq2Ov795/4uUFjHDrNZKnaa7EIRiumk=;
        b=biWLV4UO8ZF5M1WELMu+bJruN3z039zOJc59O3m6assfANVh2mNuLsymLXQ+bkinmU
         2CPNiT6VyK1mZqx3Q6+GHBVnNof38Prr83RM5VU6MECzQmhgWv/nLPR5abWGkQz092rH
         uf2T2HJ2NjAt4fcVZW9j4BJahThi9N4jGzNEjQFVr86Aq7aNrVYkCVNiy2KudDa1clcT
         pLD1q5OCbRKEUJdcE2GWC1j8Ad1p9lhkoyy8v6kmWmVO8lH8if4U5Tleuo9R2HhTeR3k
         8BPF0Q7vhTgjyDz3by/R0nC1F/mz95+9xZ3YavNfjDbzQeJ5CXH4TUqR/KYRBqUZMDdf
         NS/A==
X-Gm-Message-State: APjAAAVlWRSPfFSqalMQEyF8LG9xwuD9OnQ+ugxM29QQX6iv0Bkaj17a
        WHKwhniW/ADfJsm8fnhmpR38jmqKG0Ajn7I23Lg=
X-Google-Smtp-Source: APXvYqzjvBgHPirIikYuBs4jRprm/slQSun4dBpyqxSzw0EjK+LxxNP+ZNB2YKXsWz2oDU/zYksOxIL1irge5WG8dPg=
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr1441787vke.40.1552638438944;
 Fri, 15 Mar 2019 01:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552097842.git.lkml@sdf.org> <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
 <20190309140653.GO9224@smile.fi.intel.com> <201903091553.x29FrfMR018600@sdf.org>
 <20190314092958.GV9224@smile.fi.intel.com> <201903141009.x2EA9q1Z025888@sdf.org>
 <CAMuHMdW0jd-oNtgBf=aHfzVoBbVh0OJYC6ELhDv3VrcGwUECwA@mail.gmail.com>
 <201903141153.x2EBrtKi000133@sdf.org> <20190314121811.GY9224@smile.fi.intel.com>
 <1145741552593595@sas2-2074c606c35d.qloud-c.yandex.net> <201903150335.x2F3ZUgS024157@sdf.org>
In-Reply-To: <201903150335.x2F3ZUgS024157@sdf.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Mar 2019 09:27:06 +0100
Message-ID: <CAMuHMdVB+OgR9-rc+pksAc05vx5jeCwFF+LvBOnvmXO=VQKq2Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
To:     George Spelvin <lkml@sdf.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Abramov <st5pub@yandex.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Dave Chinner <dchinner@redhat.com>,
        Don Mullis <don.mullis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Fri, Mar 15, 2019 at 4:36 AM George Spelvin <lkml@sdf.org> wrote:
> >> swap_bytes / swap_4byte_words / swap_8byte_words
> >> swap_bytes / swap_ints / swap_longs
> >> swap_1 / swap_4 / swap_8
> >> Pistols at dawn?
>
> On Thu, 14 Mar 2019 at 22:59:55 +0300, Andrey Abramov wrote:
> > Yes, in my opinion, swap_bytes / swap_ints / swap_longs are the
> > most readable because we have both swap_ints and swap_longs functions
> > (in one file near each other), so I don't think that there will be
> > any confusion about size.
>
> Yes, that's what I thought.  They're three related but different
> functions, suffixed _bytes, _ints, and _longs.  What could the
> difference possibly be?  And if anyone has any lingering doubts,
> the functions are right there, with exquisitely clear comments.
>
> No to mention where they're used.  Is "is_aligned(base, size, 8)"
> remotely obscure?  Especially in context:
>
>                 if (is_aligned(base, size, 8))
>                         swap_func = swap_longs;
>                 else if (is_aligned(base, size, 4))
>                         swap_func = swap_ints;
>                 else
>                         swap_func = swap_bytes;
>
> What subtle and mysterious code.
>
> > But actually, it doesn't matter which name will you take, because
> > the meaning of each, in my opinion, is obvious enough, so I don't
> > mind about any of these options.
>
> I'm just amazed that this piece of bikeshedding is the most
> contentious thing about the patch series.
>
> I mean, if I'd named them:
>         llanfairpwllgwyngyll()
>         shravanabelagola()
>         zheleznodorozhny()
> or
>         peckish()
>         esuriant()
>         hungry()
> then yes, those would be bad names.
>
> I prefer the shorter _ints and _longs names, but this is just
> not a hill I want to die on.

Argument of least surprise: don't call something a duck if it's not
guaranteed to behave like a duck.

If I read "long", this triggers a warning flag in my head: be careful, this is
32-bit on 32-bit platforms, and 64-bit on 64-bit platforms.

There's a reason the newer I/O ioread{8,16,32} accessors use explicit
sizes, unlike the ancient x86-centric read[bwl]().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
