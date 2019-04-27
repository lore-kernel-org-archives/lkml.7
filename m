Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442272087E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfD0Urg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:47:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37392 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfD0Urf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:47:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so3918750qkk.4;
        Sat, 27 Apr 2019 13:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bkiA6cWFfvKZGfeD6fCJT7YhaAu5sHw91dR8QStbhuQ=;
        b=LDE0SHiX98Km4YGVNloqIind++Yoh89hFfM70RMOi/qpQknHSHdva5cT23YWB65pkz
         92PFO1+S82PHxpOTD5K7X/xuF2znlF5M1ovc2mQjKdj5J+V8jyvQeQOA+5z2nlWwaWgq
         3cH19PI8IzQETlOnA14eSbs+10W4QL48+i4rJH5zhrawnIQWXeCNzLwho9pdB6NgruMm
         cfDkKCW96pj3g2tF06CPT34swosBh/nQBSj7iWYjJhaFou/0f4LeebWtg9Fy6XVvd1fl
         9u9r2dYn8qbuZ5m97afmsNoCVCHdnyv0t70oFebNpV5YD+Cb26Wfd0Aeg1Lffy5EdBOj
         tuXg==
X-Gm-Message-State: APjAAAVCcF9h79/i1nPb6/EX/3+fJ/waaLFtCHR/MhYsUiyHOyqgj+C2
        fpc9GFanFkNnSxJkarC4+IGfggstwzxHxS0voS0=
X-Google-Smtp-Source: APXvYqyQjSsgNN0aFL+jLHOQN0PQWXJqaymk8KMgu8D70SJCeZPQw5iXwIolA+xrbYY3zC2btbW2SoeXAEL3c75XQFI=
X-Received: by 2002:ae9:ee15:: with SMTP id i21mr38217586qkg.107.1556398054542;
 Sat, 27 Apr 2019 13:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190426142531.1378357-1-arnd@arndb.de> <20190427004653.3cecd1cb@jawa>
 <20190427095418.344yoomf5nwznatd@sghpc.golosunov.pp.ru> <20190427170613.38bdfbbd@jawa>
In-Reply-To: <20190427170613.38bdfbbd@jawa>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 27 Apr 2019 22:47:17 +0200
Message-ID: <CAK8P3a0rdByED8ZsCSm4biuvOhkKs3o9_wFnGnSHk0hOhu-vsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] y2038: make CONFIG_64BIT_TIME unconditional
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Stepan Golosunov <stepan@golosunov.pp.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 5:06 PM Lukasz Majewski <lukma@denx.de> wrote:
> > 27.04.2019 в 00:46:53 +0200 Lukasz Majewski написал:
> > (I am wondering whether such trucation is undefined behaviour in C
>
> According to [1] - Chapter 6.3.1.3 - Point 3 it is
> implementation-defined.

The kernel relies on the sane behavior for integer overflow in many
places already, and it is built with -fno-strict-overflow to also make
sure gcc doesn't optimize cases that would be undefined otherwise.

> > and
> > whether there should be sign-extension instead of zeroing-out for the
> > in_compat_syscall() case though.)
>
> What I've found is that "typically" the high order bits are discarded.
>
> However, it is still "implementation dependent".

I think the question was whether we should use

          kts.tv_nsec = (int)kts.tv_nsec;

instead of

          kts.tv_nsec &= 0xfffffffful;

Both have a clearly defined meaning in the C dialect we use in the
kernel, but differ in the upper 32 bits for negative input values.

I would say that using sign-extension indeed makes more sense
here, but we don't need to change it for linux-5.1, since none of the
callers of get_timespec64() care -- any negative 32-bit tv_nsec
value results in -EINVAL, including the utimensat() syscall that
has two special cases outside of the 0...999999999 range.

      Arnd
