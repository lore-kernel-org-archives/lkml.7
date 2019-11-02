Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2C1CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F9720862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIU0oQaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfKBKS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:18:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32795 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKBKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:18:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id u23so8041654pgo.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0VbGsz0tFOaDztQnJeXi4+/d87WrDq2JyWlH+PKmwA=;
        b=BIU0oQaLn63xipEB+oW5gRLvxLdvHmgJA2k7Dy0LQM3t0Hub22MTREtckXtr73bC7z
         RKIupjJpZgKYzZ3zOjeVK3fedZSxQRa3Cw4YPHwnN7jhA/4OC8AEBHZd4u4V3S/YFmTZ
         6V1jgsXq9WUb9oykYF7yib2wRIP9D5xbPQOf1pM2IG+6PufI/0qz2+kibt2QvGEcSIT2
         +YH2yy//HUpShADH2bNJMhGhleaR3nIz9PRratohyAaqxWGaJAN7rSGs8bdumVY0qSoR
         TUtsgcTKPwWbKmWn/VidDEkJI6KlJhHBfWWqOn3qSIdGpVnLigMSfYN7iBshJmH1/63F
         5tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0VbGsz0tFOaDztQnJeXi4+/d87WrDq2JyWlH+PKmwA=;
        b=p9SZ7Mit4124dKVhHUV5qvrJh2mLvWplQfzvtiriZleVQhlufeQILs1L7i0MNGN7v+
         JADyywlk6Fq4cifLl2i1qTIJNdFx56NruixYBteJNdgDH7uACKgR5Fo+k0PhshgBlFgh
         O1YfU8a3mlfo0jil0/Pg76kZLxWSr/PGsDvOig1F+Cwtq7H6U+B/QRsjVIW9z0VgJhK9
         w4vUcmYel21Gd8OXL2wo4SXXy7yncH3ajeJfT4bBwk0eQnaw6/xgPvjsXS3jwp4Wy7Sh
         a23GXROptD9HDBaJWgbg6Ec1THrsJhXwU4wU9KNu8G6fxeJ3WeNrXsVGBdqrvr69wlrH
         Owew==
X-Gm-Message-State: APjAAAUQ57zRTcwc8lUJCu3k/mOQVl71qV3fEEksRNz2hn11AovRG6jy
        6afw6UU1BomYCdXi7fgKz+ezJvFz2OEKm0c8j2M=
X-Google-Smtp-Source: APXvYqyrlICLR7MyyJRxIjUOUiL7oFNzG+wc+AuDOYOeNpx5jwpR3c5ie0PM9mqRWEFII8GPJNiDE+kI594wozxbD80=
X-Received: by 2002:a62:8701:: with SMTP id i1mr905972pfe.241.1572689908330;
 Sat, 02 Nov 2019 03:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191031133337.9306-1-pmladek@suse.com> <975eccc7-897c-fd14-ef4f-2486729eb67c@rasmusvillemoes.dk>
 <20191031145112.thphlpnjvnykbzyy@pathway.suse.cz> <20191031150952.3ag6qa5y4wvikd76@pathway.suse.cz>
In-Reply-To: <20191031150952.3ag6qa5y4wvikd76@pathway.suse.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Nov 2019 12:18:18 +0200
Message-ID: <CAHp75VcBL8XFBSUs=UrdbfUQw535gHbTKQkHLE4Oj3H2_UKiWg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add VSPRINTF
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 5:13 PM Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2019-10-31 15:51:12, Petr Mladek wrote:
> > On Thu 2019-10-31 14:51:24, Rasmus Villemoes wrote:
> > > On 31/10/2019 14.33, Petr Mladek wrote:
> > > > printk maintainers have been reviewing patches against vsprintf code last
> > > > few years. Most changes have been committed via printk.git last two years.
> > > >
> > > > New group is used because printk() is not the only vsprintf() user.
> > > > Also the group of interested people is not the same.
> > >
> > > Can you add
> > >
> > > R: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >
> > Sure. The more reviewers the better :-)
>
> I acutally wanted to add also
>
> R: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Ack


-- 
With Best Regards,
Andy Shevchenko
