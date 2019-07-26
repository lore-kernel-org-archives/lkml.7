Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37164C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0754822BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL08XvlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGZU2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:28:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43481 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfGZU2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:28:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so9576502qto.10;
        Fri, 26 Jul 2019 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRwRthds5sxGM5kfR5jug7OQtqPlV1fvrZmHuKtivu4=;
        b=RL08XvlNq8d34uXmoAGids7utM9j0vfFLnJJu2H6dAgiCfcdLMiXIz0OnK1b9SQeha
         v9HXyQZ9Q7ZnShzlMlRVIXWGiaUC9xBelNgH0xnFIbUdUVaQESvv9C6LVA6wZ+344Q4a
         Ru358BRKySgvEYQew4jvPGam+cr4PUGJlO1/H9RiYZly56tjs2+6on7TUW7jK901mx7e
         HhbM0Nwim7agX87fRH8Zw7rv/NkiQMOXJVPbGE8jkUo/T9oYfQRlpMXFI0hXt7bhT4DI
         w2iRUwlh4DjGMVZDLm8qbRdnAfaVLbuyfxHVbkwi7ARmgfEHgg3ZodegvZees/p+OT5l
         2yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRwRthds5sxGM5kfR5jug7OQtqPlV1fvrZmHuKtivu4=;
        b=JIS3zbiZklARm6Gx642d4vCEITdYJNjR6AMJgyTrD5OMk/vF9pWLFPLmRTn2uFwtLW
         tUbrSINiXtFG0Ou7IEyduwTmXBJHkYMcSyyD2hAV9JMlHc1G+ckNF9NBHoii0fUU204I
         mgqnMmoZ/NFM48/sfwzIXmkz0ngoZYQPmeF8Qyc6cZZiYvBgoZTUqUImBfvey/Z0YyGe
         swOZOxVfw9ww4vDEte814RyxmJHeCd/FpvF4TkBVNRgzLmib7tbz+bXK18aZzdM+gjok
         KlKbHtOVqOAAcplUGAMC40X+Lw3DnZOgXcWRSDlH96jjts7IaDQ09+7P0F9yox1dtz9m
         2GIw==
X-Gm-Message-State: APjAAAX2k6I1+oiICG6umkFadY/4QNKcH2OBWRizwgODgKuKY2QcIUxb
        m/GFzXP8DOazhXsQOCBtxtD35WRDzgtnuEEMc1SN6Q==
X-Google-Smtp-Source: APXvYqyN9uAoG3/56GbpRR2bJQadMzuyWHXyuiQK1fINq5tDnhyPXmV9Fi2yXbv5G4D9dNdsZYFSNOBumz+tCqdP9p8=
X-Received: by 2002:ac8:34aa:: with SMTP id w39mr69149026qtb.118.1564172898646;
 Fri, 26 Jul 2019 13:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190723204155.71531-1-andriy.shevchenko@linux.intel.com>
 <20190726164823.GB9224@smile.fi.intel.com> <F7CF9393-B366-4810-B127-876C6D5A72A1@fb.com>
 <20190726185825.GC9224@smile.fi.intel.com>
In-Reply-To: <20190726185825.GC9224@smile.fi.intel.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 26 Jul 2019 13:28:07 -0700
Message-ID: <CAPhsuW5Y8XB7tWU+gLN=Z6aXiQm=TNX6jGsJDuZbpoJ7ALcE2g@mail.gmail.com>
Subject: Re: [PATCH v1] md: Convert to use int_pow()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Song Liu <songliubraving@fb.com>, Shaohua Li <shli@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 12:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 26, 2019 at 05:18:09PM +0000, Song Liu wrote:
> >
> >
> > > On Jul 26, 2019, at 9:48 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Jul 23, 2019 at 11:41:55PM +0300, Andy Shevchenko wrote:
> > >> Instead of linear approach to calculate power of 10, use generic int_pow()
> > >> which does it better.
> > >
> > > I took into Cc drivers/dm guys as they might have known something about md raid
> > > state of affairs. Sorry if I mistakenly added somebody.
> > >
> > > Who is doing this?
> > > Should it be orphaned?
> > >
> > > (I got a bounce from Shaohua address)
> >
> > I process the patch. Sorry for the delay.
>
> Ah, no problem, thanks!
>
> Perhaps someone can update MAINTAINERS data base?

I will discuss this with Jens.

I applied this patch to my local branch. It will go to Jens' tree for 5.4.

Thanks,
Song
