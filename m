Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD25CC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A830721852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGDHPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:15:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40528 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGDHPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:15:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so5002994otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIJ6I4kylF0BPBkwVx1NeJTqIv5Ok8DYkWpGVavV2KA=;
        b=tcmWJHHI14296PqkiKK/MXLf+dXKsBbJrlR42OA8OJ7GF9ouW2gxSftQk8DUZZmYva
         HOmTKqAS5hey7DRi3ojJgImCFWC8+vx0+dZauLMdTxAAV3Qe6OvGT/wOHrqZzWLY/Aq9
         E4hpjjqtQItYMb5fHT/fx3uj5eAHPsBg65K9yBJ3v8/cqqZxdeSvbaDyz9nY4g5J1H7F
         KT6inQBIHFFTVLs0fSPule0eK+0iJIXYNWhsdglV/yhg7FmRlL+PecGTUxEj/39GGgHm
         Oy5h4NKYYQzwCOqMnXLmCEKrAhSXf3hDp00s30X8LrsIlhiIVsEpRZXdAB+XE85tjEiP
         iSFQ==
X-Gm-Message-State: APjAAAUnffibV6s5bC+4kysfy5BuOAz/aUBTxWUJ2Ls1anUqgEhEgqln
        kYT5lT2gofEAOHnDv9q7Ph7qsl4owrHhm1IPq8g=
X-Google-Smtp-Source: APXvYqwRR5UTh1n5Wb4zp4t58gm3siYOJBWZnUuHSrPJ10zSpDGUZlxY94sfN3zdbAXzFqFykcUksOOqiqtwmyDKkx0=
X-Received: by 2002:a9d:704f:: with SMTP id x15mr12209735otj.297.1562224501509;
 Thu, 04 Jul 2019 00:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190626093943.49780-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWm7ftYNVQfjLdPxvzZQLa6mWQvjE8vGo98-QOGeyjZFQ@mail.gmail.com> <20190703143728.GS9224@smile.fi.intel.com>
In-Reply-To: <20190703143728.GS9224@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Jul 2019 09:14:50 +0200
Message-ID: <CAMuHMdXZzgbGoZvbAcQoe-h9_SNyppLm_Z0YZk4Jax6qhVZY3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kernel.h: Update comment about simple_strto<foo>() functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Jul 3, 2019 at 4:37 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Jun 26, 2019 at 01:00:45PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Jun 26, 2019 at 11:39 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> >
> > > @@ -437,7 +435,15 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
> > >         return kstrtoint_from_user(s, count, base, res);
> > >  }
> > >
> > > -/* Obsolete, do not use.  Use kstrto<foo> instead */
> > > +/*
> > > + * Use kstrto<foo> instead.
> > > + *
> > > + * NOTE: The simple_strto<foo> does not check for overflow and,
> > > + *      depending on the input, may give interesting results.
> > > + *
> > > + * Use these functions if and only if the code will need in place
> > > + * conversion and otherwise looks very ugly. Keep in mind above caveat.
> >
> > What do you mean by "in place conversion"?
> > The input buffer is const, and not modified by the callee.
> > Do you mean that these functions do not require NUL termination (just
> > after the number), and the characters making up the number don't have to
> > be copied to a separate buffer to make them NUL-terminated?
>
> The second one, could you propose better wording for that?

What about:

"Use these functions if and only if you cannot use kstrto<foo>, because
 the number is not immediately followed by a NUL-character in the buffer.
 Keep in mind above caveat."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
