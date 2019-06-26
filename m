Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981DBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7212920663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfFZLQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:16:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34736 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZLQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:16:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so315443otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oUsCfiwRANQZCtoGbfBH6uCohdW7HJeSi/lsFWf0E0=;
        b=fS56MueZwVxIzV2UYq1fF8UjT52D7SnwV4uDNWw0Wm+giZPeZpYldHLJvE9JifjGu9
         2N61+udiTRREipDphZWlT1T53OhIaOvkeugJNDY3j9WWpBKFCt9BLPkzV0G01DE10ERZ
         hhiRPKAbENzMmJazlQf84/VTsnrusYrpSF2E+B4nTb6rnSN6GD0EKxwvfR4Wvk2wO9CD
         M4wRky2XzYoq0QbahV9EZtp1M5Skmvb57U8n8WRuXtQUOAKFpBvEoJoeSKNFWMtGa2i9
         uGoLemXi3jnLkv2TjYaVt6zyJGq037Km8HOvS8QTs2uYgrnX5HLoMz6EJJzeCakFuOyL
         Dyag==
X-Gm-Message-State: APjAAAWFwBAEJottQUBOAgDJqQlL4f+woyw45wZDi8l/J5Qar1X3GDED
        WsfvtVlBducuydKdHi9a8VNWqAKtHTCeROfYUNbWjA==
X-Google-Smtp-Source: APXvYqz75HUBVj9WdgyDb9x38SdmsS3/BxiDHe7/zH9MTMUgcYrAo9lziykUzYZO/O1Zx5o7x7iz2eduDibHF1dBtH8=
X-Received: by 2002:a9d:529:: with SMTP id 38mr2852025otw.145.1561547779905;
 Wed, 26 Jun 2019 04:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190417115350.20479-1-pmladek@suse.com> <20190417115350.20479-8-pmladek@suse.com>
 <CAMuHMdVX+2tRjCabqVNR9HcnWE+EU0bR55KAW9bbD=GBEoE-=w@mail.gmail.com> <20190626104633.arpobvevpxnkrt5k@pathway.suse.cz>
In-Reply-To: <20190626104633.arpobvevpxnkrt5k@pathway.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jun 2019 13:16:08 +0200
Message-ID: <CAMuHMdW6wD0G1Nzf_0T+G8rBmUNwM-C2LdL=QdS=7hLd0DUCGA@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] vsprintf: Consolidate handling of unknown
 pointer specifiers
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Wed, Jun 26, 2019 at 12:46 PM Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2019-06-25 12:59:57, Geert Uytterhoeven wrote:
> > On Wed, Apr 17, 2019 at 1:56 PM Petr Mladek <pmladek@suse.com> wrote:
> > > There are few printk formats that make sense only with two or more
> > > specifiers. Also some specifiers make sense only when a kernel feature
> > > is enabled.
> > >
> > > The handling of unknown specifiers is inconsistent and not helpful.
> > > Using WARN() looks like an overkill for this type of error. pr_warn()
> > > is not good either. It would by handled via printk_safe buffer and
> > > it might be hard to match it with the problematic string.
> > >
> > > A reasonable compromise seems to be writing the unknown format specifier
> > > into the original string with a question mark, for example (%pC?).
> > > It should be self-explaining enough. Note that it is in brackets
> > > to follow the (null) style.
> > >
> > > Note that it introduces a warning about that test_hashed() function
> > > is unused. It is going to be used again by a later patch.
> > >
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> >
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -1706,7 +1712,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
> > >  #ifdef CONFIG_COMMON_CLK
> > >                 return string(buf, end, __clk_get_name(clk), spec);
> > >  #else
> > > -               return ptr_to_id(buf, end, clk, spec);
> > > +               return string_nocheck(buf, end, "(%pC?)", spec);
> >
> > What's the reason behind this change? This is not an error case,
> > but for printing the clock pointer as a distinguishable ID when using
> > the legacy clock framework, which does not store names with clocks.
>
> You are right. We should put back ptr_to_id() there.

Thanks for the confirmation!

> Would you like to send a patch?

Sure, will do.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
