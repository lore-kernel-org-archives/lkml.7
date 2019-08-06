Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5786C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEB5214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEamrBsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfHFT1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:27:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42424 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfHFT1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:27:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so62117802lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sqMafdo+3bOjriH2YuFYZmHmRAJQkH4tV/Jdjit5DNQ=;
        b=eEamrBsMaUWqafAsSWR1kwJZCoeQVphOKIeYxbCPTy1TKLn4TZQUoYI0vKoPyfrQNb
         QQEHzY96XAGa7Cw6v8ihKTkXRaNE9xP+1DTfxtjGhy35S3a3s4CGAz0BaSZmEx5Un3Ft
         MOgUdaeoEBmHEO+jbiMPvb/YHXkqwCe94iAeIeXF2qE0L/pWXKtm2DRRRyDwTG68xV9A
         8s6PltWbWqVpHPmhOYLpXGu21x1dqcxHFhkFjOJ09fzZ25iHrWt7Rgu5AFiQh7sSmOJ0
         9I94XG1DVCmRyMg18GsrMde7ucpbMcMFecR+RcFtiKVUJTfkXT1tY0OBC/ypTc9ripGZ
         u3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sqMafdo+3bOjriH2YuFYZmHmRAJQkH4tV/Jdjit5DNQ=;
        b=UX56pCLuq6h71fghJ2pDTT1La3wANmiq/jcHUp5uGUnvepgOHOq0BJmOvJ2b8ZAkZu
         b7S6QyR9yfjGbcGOBPDsCz7JiZs+1zgZCL1U7XD6qUB9WUY8OUK9L5NQMGfKzqXBorTY
         s7ORrmyclxsJaS5tgiXCV7af6AsjWyFi0Ask5atDa0g8FdHAsLQGy7BVjwMV5SeJe7D+
         kIer5qCrupraSY4u46Lgeli/uOgpZoEGlYQWeZSPFEmR2+5hHqxLXxrfYFJ7w8UL2zka
         8T2wiADkPfEdGYaF7EGXhHOe/JV49nD304/y7WPPe+0ZSSkoKx577hHJKczAo5ZC3BTY
         Qbpg==
X-Gm-Message-State: APjAAAWGBxz4DorLMi0qhP+JoP4u1NSmqUcipdQY/XPQWKdNZok+3bYp
        fjvZ/uee9PxFt0DHbrspcFY=
X-Google-Smtp-Source: APXvYqxbquqOg08CRHPF+p+n9QvIY7N6coNq/oGKUdqmXiTVh9jYiDDgCa68Xm4LN3FQWsFEE5d6cQ==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr3420801lfh.177.1565119652846;
        Tue, 06 Aug 2019 12:27:32 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id h4sm18166627ljj.31.2019.08.06.12.27.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 12:27:31 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 6 Aug 2019 21:27:27 +0200
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
Message-ID: <20190806192727.GA11773@rikard>
References: <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
 <20190802181853.GA809@rikard>
 <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
 <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
 <20190803183637.GA831@rikard>
 <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
 <20190805195526.GA869@rikard>
 <CAK7LNATpQDWoMv+hnPrb1DTu4HravUhuhANnQkayxaJw99_ajQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATpQDWoMv+hnPrb1DTu4HravUhuhANnQkayxaJw99_ajQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed, Aug 07, 2019 at 12:19:36AM +0900, Masahiro Yamada wrote:
> Hi Rikard,
> 
> 
> On Tue, Aug 6, 2019 at 4:55 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > On Sun, Aug 04, 2019 at 03:45:16PM +0900, Masahiro Yamada wrote:
> > > On Sun, Aug 4, 2019 at 3:36 AM Rikard Falkeborn
> > > <rikard.falkeborn@gmail.com> wrote:
> > > >
> > > > On Sat, Aug 03, 2019 at 12:12:46PM +0900, Masahiro Yamada wrote:
> > > > > On Sat, Aug 3, 2019 at 12:03 PM Masahiro Yamada
> > > > > <yamada.masahiro@socionext.com> wrote:
> > > > >
> > > > > >
> > > > > > BTW, v2 is already inconsistent.
> > > > > > If you wanted GENMASK_INPUT_CHECK() to return 'unsigned long',,
> > > > > > you would have to cast (low) > (high) as well:
> > > > > >
> > > > > >                (unsigned long)((low) > (high)), UL(0))))
> > > > > >
> > > > > > This is totally redundant, and weird.
> > > > >
> > > > > I take back this comment.
> > > > > You added (unsigned long) to the beginning of this macro.
> > > > > So, the type is consistent, but I believe all casts should be removed.
> > > >
> > > > Maybe you're right. BUILD_BUG_ON_ZERO returns size_t regardless of
> > > > inputs. I was worried that on some platform, size_t would be larger than
> > > > unsigned long (as far as I could see, the standard does not give any
> > > > guarantees), and thus all of a sudden GENMASK would be 8 bytes instead
> > > > of 4, but perhaps that is not a problem?
> > >
> > >
> > > How about adding (int) cast to BUILD_BUG_ON_ZERO() ?
> >
> > I'll have a look.
> 
> 
> 
> I found a more important problem in this patch.
> 
> You used __is_constexpr(), which is defined in <linux/kernel.h>.
> 
> This header does not include <linux/kernel.h>,
> so this header is not self-contained anymore.
> 
> The following test code fails to build:
> 
> #include <linux/bits.h>
> unsigned long foo(unsigned long in_bits)
> {
>         return in_bits & GENMASK(5, 3);
> }
> 
> 
> 
> However, you cannot include <linux/kernel.h> from <linux/bits.h>.
> See the log of 8bd9cb51daac89337295b6f037b0486911e1b408
> 
> This header was split out to not pull in <linux/bitops.h>
> Including <linux/kernel.h> pulls in <linux/bitops.h> again.
> 
> 
> In summary, please use __builtin_constant_p()
> instead of __is_constexpr().
> 
> 
> You can shorten __builtin_constant_p(high) && __builtin_constant_p(low)
> into __builtin_constant_p((low) > (high)).
> 
> 
> How about this?
> 
> 
> #define GENMASK_INPUT_CHECK(high, low) \
>        BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>               __builtin_constant_p((low) > (high)), (low) > (high), 0))
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

Thanks for the feedback, your version looks much cleaner than mine. I
*think* I had a reason for using __is_constexpr() instead of
__builtin_constant_p but I'll try a full rebuild to see if something
comes up.

Best Regards,
Rikard Falkeborn
