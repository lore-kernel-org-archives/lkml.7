Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5500BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302452064B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfGAO6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:58:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40489 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:58:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so11209226qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYPUdrH4rwqGcTGw5ZdGUH3QSotQNpnBmXpSrhpI2OY=;
        b=Lxmr3+bz+HOS0pCs+dHq91z7fZlgt2JBJodz4/kiPg+4oMOVPTWr/ZiJDoFYXSLiGP
         zKSlJ80lEIXUm+5lsAZoWGQGGo2w/3gpQqvfoYuxFLH0d4zRP2PohPyYSz5eh1eehXkh
         3i1qhDV6lYBiCImmduB/yFX0/erEtDgc26zNgYI5OQ4UiZtJknXAZ/s8DfxDvstKc5Ul
         ekYOYF2t4j2230LbpKM0d5I2OZmhpyiLT7E/WApVNk67Hgtzo0efigblJIt6n5fw2mX9
         vz54gaizw+ImPolDytliwNIj6aUnRubaCBGWWDJhVxTIIWWBMnIMXLY0bPlifkvd6Vc6
         T00g==
X-Gm-Message-State: APjAAAVNXwK3XENUoUVyYdwwBQcHI5xb83NRsBn3o1MyWnhRPuc+tTFT
        XQ6zJWUiJr7ByElL+sjhxn6s6Tnia1wx7SpyY1M=
X-Google-Smtp-Source: APXvYqzW0scNhmgaP30TW42l5BV3v+F8ylQUDtigpiOBj0tUz731pKZzDIRDVYOsVfehdePPdz5cnTvDfz2jjGCBE0I=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr20631949qkc.394.1561993119317;
 Mon, 01 Jul 2019 07:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190628104007.2721479-1-arnd@arndb.de> <20190628124422.GA9888@infradead.org>
 <CAK8P3a1jwPQvX6f+eMZLdnF2ZawDB9obF3hjk2P9RJxDr6HUQA@mail.gmail.com>
 <20190628131738.GA994@infradead.org> <CAK8P3a0t+vGge8uDOuwex6j+ddaUqovxCXoJOO8Ec3z6_brvsg@mail.gmail.com>
 <20190628175835.hwzfrgrtwphi6kka@shell.armlinux.org.uk>
In-Reply-To: <20190628175835.hwzfrgrtwphi6kka@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 16:58:23 +0200
Message-ID: <CAK8P3a1AdseCGhg2aNkvtfCd-Wn2-rG9Z_LbvkkheGnbpT8EWA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix 32-bit linking
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 7:58 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jun 28, 2019 at 04:46:14PM +0200, Arnd Bergmann wrote:
> > On Fri, Jun 28, 2019 at 3:17 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Fri, Jun 28, 2019 at 03:09:47PM +0200, Arnd Bergmann wrote:
> > > > I came across this on arm-nommu (which disables
> > > > CONFIG_CPU_SPECTRE) during randconfig testing.
> > > >
> > > > I don't see an easy way to add this in there, short of rewriting the
> > > > whole __get_user_err() function. Any suggestions?
> > >
> > > Can't we just fall back to using copy_from_user with a little wrapper
> > > that switches based on sizeof()?
> >
> > I came up with something now. It's not pretty, but seems to satisfy the
> > compiler. Not a proper patch yet, but let me know if you find a bug.
>
> Have you checked what the behaviour is when "ptr" is a pointer to a
> pointer?  I think you'll end up with a compiler warning for every
> case, complaining about casting an unsigned long long to a pointer.

I have built lots of kernels using this patch as a test, though my autobuilder
is currently configured to use clang-8, and other compilers or versions
might show more warnings.

> >         uaccess_restore(__ua_flags);                                    \
> > -       (x) = (__typeof__(*(ptr)))__gu_val;                             \
> > +       (x) = __builtin_choose_expr(sizeof(*(ptr)) == 8,                \
> > +               (__typeof__(*(ptr)))__gu_val8,                          \
> > +               (__typeof__(*(ptr)))__gu_val);                          \
> >  } while (0)

The __builtin_choose_expr() here is supposed to take care of the case
of a pointer type, gcc and clang should both ignore the non-taken
branch and only produce warnings for the case they actually use.

       Arnd
