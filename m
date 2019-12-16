Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57851C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34484206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfLPNW2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:22:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40390 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfLPNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:22:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id 6so3277560oix.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JawXd/NOVI0T+kjRC7W+KjOmHqd9T1rGdITq8d6PplQ=;
        b=WoeubUdUyi7h+Z9u9pGulmGjq61NuiTaMzt0TI78PAQfrhiR31oo7Wilp7cG65Vhfs
         lFnbVvFbiX0LFpYR9Z7zIvOHV0HBIvvQbMCCMzyFIlXIKFQrFlb5e8UDmI2UzTFC6Tb/
         KmLwRxWaBY9I4qlr4I8m6wrlOczdSYRCUCIKtaR6DXkK3qLwN9/ct40zPlgs5afgpx46
         Arw0IC7y/oayrfLTO6E0w3cyKuGLpMIS5x6T2tY3ldRkr6TRRua6YrK8km752Nn7walv
         ht4jRpHgUkM4I1x/7YHTHPfSWBNZerzE51P/BX1H4iraXCZ5XIvbp2W3l44ieun7oQv/
         waxA==
X-Gm-Message-State: APjAAAVReXm+1daym35URMl1/0VZkS6GUqqKNHSyhXUWdT9ujD9AKVIU
        pWEPGmekOmrvHNsuETpDE3XvjpTrKDgZj9Bz2JIptg==
X-Google-Smtp-Source: APXvYqxSD5VVJ4lNUbCTPHVVtvS3hNg+xoQwBMqO9hpFO+TmvNY0uSGpkRz+QC4RbmLRXBVKTNp1RJND16zi4H5TzrU=
X-Received: by 2002:aca:4e87:: with SMTP id c129mr8806320oib.153.1576502546665;
 Mon, 16 Dec 2019 05:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
 <20191212135724.331342-4-linux@dominikbrodowski.net> <20191216013536.5wyvq4vjv5efd35n@core.my.home>
 <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com> <20191216051300.GB908@sol.localdomain>
In-Reply-To: <20191216051300.GB908@sol.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Dec 2019 14:21:55 +0100
Message-ID: <CAMuHMdUF1jXizp3Tz46YDJnzzmJDG_vE3xf-0o+OJiKx-waShw@mail.gmail.com>
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Dec 16, 2019 at 6:13 AM Eric Biggers <ebiggers@kernel.org> wrote:
> On Sun, Dec 15, 2019 at 07:50:23PM -0800, Linus Torvalds wrote:
> > On Sun, Dec 15, 2019 at 5:35 PM Ondřej Jirman <megi@xff.cz> wrote:
> > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> >
> > Duh. So much for the trivial obvious conversion.
> >
> > It didn't take "data might be NULL" into account.
> >
> > A patch like this, perhaps? Untested..

> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -391,17 +391,19 @@ static int __init do_mount_root(const char *name, const char *fs,
> >                                const int flags, const void *data)
> >  {
> >       struct super_block *s;
> > -     char *data_page;
> > -     struct page *p;
> > +     struct page *p = NULL;
> > +     char *data_page = NULL;
> >       int ret;
> >
> > -     /* do_mount() requires a full page as fifth argument */
> > -     p = alloc_page(GFP_KERNEL);
> > -     if (!p)
> > -             return -ENOMEM;
> > -
> > -     data_page = page_address(p);
> > -     strncpy(data_page, data, PAGE_SIZE - 1);
> > +     if (data) {
> > +             /* do_mount() requires a full page as fifth argument */
> > +             p = alloc_page(GFP_KERNEL);
> > +             if (!p)
> > +                     return -ENOMEM;
> > +             data_page = page_address(p);
> > +             strncpy(data_page, data, PAGE_SIZE - 1);
> > +             data_page[PAGE_SIZE - 1] = '\0';
> > +     }
> >
> >       ret = do_mount(name, "/root", fs, flags, data_page);
> >       if (ret)
> > @@ -417,7 +419,8 @@ static int __init do_mount_root(const char *name, const char *fs,
> >              MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
> >
> >  out:
> > -     put_page(p);
> > +     if (p)
> > +             put_page(p);
> >       return ret;
>
> I'm seeing the boot crash too, and Linus' patch fixes it.

#metoo ;-)

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> Note that adding the line
>
>                 data_page[PAGE_SIZE - 1] = '\0';
>
> is not necessary since do_mount() already does it.

Indeed. So the "-1" can be dropped from the strncpy() call, which brings
it even more in-line with the "full page" comment.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
