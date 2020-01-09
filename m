Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA848C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8910220721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imm5wHyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgAIVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:05:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34180 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:05:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so3806815pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pg5x4483JWBqI1Bbmsf56qLvZ2BmXpfD9hK5FoGuIvo=;
        b=Imm5wHycOANnogJCYNNwbbJaqTm625dEYfX4VQOjq9pFSv916dng3G49QQbwyY2BzT
         Grevd5V6/Jybn20m5HflcBraYzK8f5XW3mm8/SWakJYJ17fVJmbAq0uB+52gjNOnHewx
         9TpVqOLinrbAovJQDb9QIUh3eGag/TD7cdaWC/l+52We0/XGgSukM5KOX7D2KzsvhzNs
         9kY1xSyF9/rMUBct72PgUAINShfpIj8yi1ODaNxbTGGUUWS3V+Ea9RuFT6hAFspLG63P
         Sp3TP1LZE4pvhQYkNr0Q4oRD+wuK3ASAG0j5Xmfh4HMGHlGjw+JxVk71gPaACsFdFq8I
         9wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pg5x4483JWBqI1Bbmsf56qLvZ2BmXpfD9hK5FoGuIvo=;
        b=ZgG+lyq/IWUtQuWtHkBg31PPlz4YTMxw5N1pknCMEp4hAEgkuqXs0m3mdyc1FBCgDd
         sYK6vejJ4QlKNy+NZliWFGk1JwfN/lSwI3JHgIPK/LfTjWk2BKR32ewlkCiam85adSTT
         HRRjFVoYFfOAos0MRQAl0aGQ+Y/nSTbexq4ZWmRaj3LhQ9O+cFYn6S/bggwRyAGG6hKi
         X3dewEM3p8hNJjCUDL4kpFhKmqbJFPVZvJZ28fzER2eCg/FUCceP8uSKpx+gru//lzgi
         Zd/dgtzoPrPaDqj7vOOnB3r39bz9ggneNaMkWbx+9mjlUYEWp5MGj4wvLfEcIYes9AxE
         U9rw==
X-Gm-Message-State: APjAAAWZZNlxCfASQ59TQPRMOj/JwUexU2mdkjWIRSMIjfG1k01tF88l
        DrArLf3dJ5m8LX37swbrB8R9k7Cldy9h0sHMitc=
X-Google-Smtp-Source: APXvYqyOUOiQvWbT7Mn0s0sPosqtwKuh6AnBMFpJdGNTkY1X/QC3QN6ZJ+HiH8AYFddn/3ay2Z5mpcF+px2qqS4QxD4=
X-Received: by 2002:aa7:9474:: with SMTP id t20mr507237pfq.241.1578603910412;
 Thu, 09 Jan 2020 13:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20200109103601.45929-1-andriy.shevchenko@linux.intel.com>
 <20200109103601.45929-2-andriy.shevchenko@linux.intel.com> <20200109120814.27198f300bbe209cdc411fc6@linux-foundation.org>
In-Reply-To: <20200109120814.27198f300bbe209cdc411fc6@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jan 2020 23:04:59 +0200
Message-ID: <CAHp75Vd6JLjPfrA4f2ugwfiZS3fBSxN48ja7OjnZ4s_pqWJZng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/test_bitmap: Fix address space when test user buffer
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 10:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  9 Jan 2020 12:36:01 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Force address space to avoid the following warning:
> >
> > lib/test_bitmap.c:461:53: warning: incorrect type in argument 1 (different address spaces)
> > lib/test_bitmap.c:461:53:    expected char const [noderef] <asn:1> *ubuf
> > lib/test_bitmap.c:461:53:    got char const *in
>
> We did this in
>
> commit 17b6753ff08bc47f50da09f5185849172c598315
> Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> AuthorDate: Wed Dec 4 16:53:06 2019 -0800
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Wed Dec 4 19:44:14 2019 -0800
>
>     lib/test_bitmap: force argument of bitmap_parselist_user() to proper address space

This is for "parseLIST", while new patch for "parse".

>
> > --- a/lib/test_bitmap.c
> > +++ b/lib/test_bitmap.c
> > @@ -458,7 +458,8 @@ static void __init __test_bitmap_parse(int is_user)
> >
> >                       set_fs(KERNEL_DS);
> >                       time = ktime_get();
> > -                     err = bitmap_parse_user(test.in, len, bmap, test.nbits);
> > +                     err = bitmap_parse_user((__force const char __user *)test.in, len,
> > +                                             bmap, test.nbits);
> >                       time = ktime_get() - time;
> >                       set_fs(orig_fs);
> >               } else {
>
> Except your tree has `test' where mainline has `ptest'.  I'm not sure
> what has happened here?
>


-- 
With Best Regards,
Andy Shevchenko
