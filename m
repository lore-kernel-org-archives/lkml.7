Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB2BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709F720644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o51zeIqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfH1RoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:44:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38778 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfH1RoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:44:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so116541pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94qXpyDS0THtDB4WwXpF5NYofHpbK853mMaCrKH08oM=;
        b=o51zeIqcgVO6XFBOHsGkXHI9eeRg/kCORZP7XWGbUheVDyBBM2P4l0hhh5v7/lW4Fh
         /BoFhmwS0DOaaW2h8Hap//X+4QGMXUnx+Xzz6IntmHCaJfSE3obLQYBEGe1DB6ugUGoo
         187CxLdT4hE4uF3QL8ysoCmkBexkp5qW52gCbIuAPoU/rdx/9E5M+S0Fk3yHkhsBtFJZ
         9RVIQHxsjqIUvfDohrYhN7A7cOwUE1sz5ZRcIMfgBkOH+goBi/O1ePCpfIEt7j/2vel1
         WQFgofcRJko1f6UyzH2zJy95gHdN1v2I7bLPjQjuQBc7/j8hoGn/do3SHZgLcIZkNVko
         NpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94qXpyDS0THtDB4WwXpF5NYofHpbK853mMaCrKH08oM=;
        b=DNEDVqyxD9GkLuKLz243YuKbvlnegX3LdnCg5Mb7BtlD8sRqE9xShp0XPOZNxb+RPu
         FZMyQ6JBH3dK+raVlk5En2HNjhp/k6YgfYrMks+7d5dCl7Di9BcyOiA8UWpqPs/cvOTD
         g+3iVnLPf9pdhwqMFfhqYaRBz7EY2nJJ3oa6tLi3kqVqS91qr1ys/9Kes1hYYoO9egRy
         6pFsRbe4NMYO4oG009z3psm2lSQRbj5P0gYoMUJxzDcMqFngmg0HoPKeF5H7pDNGGJFC
         BxT7+9naKwVD/OgYaxjXLX/bZ/iPJCK56pxdbo96tx0++CtKX5Lr5xCyMI0gvusrKP5T
         wY9Q==
X-Gm-Message-State: APjAAAU4rD2cVhzBphQuErGWQLX2CujenA8Martz8dzgX+VKvu+eePrj
        RQdzfO2Dj1bwRE8bxrLaPuGnJhQu2WO3VZsg7x/QoQ==
X-Google-Smtp-Source: APXvYqxUoj2b1JtWGXB1HZKQs9OM6muwZaa8rYV9vepLadTGApisRJFpy3gzexw1zj9C9HU5EgImTlUmQvJ0m617STE=
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr5499971pjq.134.1567014263717;
 Wed, 28 Aug 2019 10:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190815225844.145726-1-nhuck@google.com> <20190827004155.11366-1-natechancellor@gmail.com>
 <CAK7LNATHj5KrnFa0fvHjuC-=5mV8VBT14vrpPMfuNKWw7wabag@mail.gmail.com>
 <CANiq72ndWZWD-KBT1s-mUxQNa1jaD7oDaCB2+NPiT1chf14Z_g@mail.gmail.com> <CAKwvOdkuDPfOusJRneeTzg7tZ4VKxaRCNg2SgmjVas58cDwe8w@mail.gmail.com>
In-Reply-To: <CAKwvOdkuDPfOusJRneeTzg7tZ4VKxaRCNg2SgmjVas58cDwe8w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 10:44:12 -0700
Message-ID: <CAKwvOdnOo3RXm3cx5YDtPyM=9Ry7kss-i4HzjxQkK4pjE-n9Lw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Do not enable -Wimplicit-fallthrough for clang
 for now
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Aug 28, 2019 at 9:45 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Wed, Aug 28, 2019 at 6:21 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > Applied to linux-kbuild. Thanks.
> > >
> > > (If other clang folks give tags, I will add them later.)
> >
> > Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> I verified that GCC didn't get support for -Wimplicit-fallthrough
> until GCC ~7.1 release, so the cc-option guard is still required.
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Thanks for the patch Nathan.

Also, there's an inconsistency between Makefile vs
scripts/Makefile.extrawarn that's been bugging me: it seems we enable
GCC only flags in Makefile, then disable certain Clang flags in
scripts/Makefile.extrawarn.  Not necessary to fix here and now, but I
hope one day to have one file that has all of the compiler specific
flags in one place (maybe its own file), so I only have to look in one
place.  I know, I know, "patches welcome." ;)

-- 
Thanks,
~Nick Desaulniers
