Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF16C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F48D2464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZIFFnJBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfLENrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:47:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43531 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfLENrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:47:41 -0500
Received: by mail-io1-f66.google.com with SMTP id s2so3616469iog.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F1r6bkuEgTVPA/sHRf3ZXJ9F5TKgMqD4MX5r/fBzobg=;
        b=ZIFFnJBqLN/6IdRGI1+Ng6EjWxgJf3yiAG6DhscHjReQD9TQQIXwNwSSFtRP9WbWNH
         a9538vG9HoGCIdi7owZ1/+7GuxawncmtBAB5kf3W4Znhs6gOJjBM36o4kj1DqU2GvLup
         tkShLaHnbrqfB5Yo8zyZS+F1OwBNhRt+N0wERiwDBkSTSEQUzDMrskKy+wlDWuRCqfHB
         TTctxqHrTTUh/2O5NQIS6zh6L2c0MKEsy7kJshChlQ1Jmg35IGZmOgCApEA3gJI1paiI
         aP8z8ZyM6F5aCw584lIP/Qr6fdNO2yd3K1I+sahsr9VtxLJMfPyg9RYyuctnwnlv6DSW
         W9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F1r6bkuEgTVPA/sHRf3ZXJ9F5TKgMqD4MX5r/fBzobg=;
        b=P3nj3jlEa4Ye199CRu3Em2k6SRAIu06AYOVmqqlypGWzbH/P98SYOBQLODZsXnX3Hg
         z0ylkkXpEuEpZo0aDtDeYkB6TLPBQHtx6qdM0uSHUdxLxMdIu32PJerAbV3JwtbwmZOT
         DFoQoXOn8ZSIXfk7PPU6cvxK+Hlb5HNqchdPA9O2FRju/boSWNxQKRrnEZOm1YJENfHR
         ZIWtnUsZzESv/37BreFC07ybjQcaAe+gi8v43uxlh4XCApYnXs9IfFkRJ3T+dE0GPgrS
         ad/0N39B//eBA33+xZbJQmEc3GCH7cVV6ORx9aRbiYxxQIenGvtA4cK3ePdI4jHomEHZ
         L8rg==
X-Gm-Message-State: APjAAAUisxBdCO2fm+E08Kxa2o/9U+gnBYDOgRKNuSaoxDyYWV1iAp4y
        u1CKzKyychfEbrLdp0kfxMnH2VcnJhd5GgtnRy0mjw==
X-Google-Smtp-Source: APXvYqyX2J+9mYLKnKDUFzFsIxp+qagIuJC+HCi1QrsAVJB60kZK6B/lWE85l8QMRomb26AbU0vc7CWrtBC2EmOL8p0=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr1175995iom.6.1575553660941;
 Thu, 05 Dec 2019 05:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20191204155941.17814-1-brgl@bgdev.pl> <CAHp75VdiAtHtdrUP2EmLULh86oO37ha8si10gFKYRavXCEwRRQ@mail.gmail.com>
 <CAMpxmJVXVVVMPA_hRbs3mUsFs=s_VtQK9SvvYK3Xc5X27NPTKw@mail.gmail.com> <CAHp75VfXc88Fa6=zs=9iToz27QdXHqRCDPQwBPs2P-rsBF8nHw@mail.gmail.com>
In-Reply-To: <CAHp75VfXc88Fa6=zs=9iToz27QdXHqRCDPQwBPs2P-rsBF8nHw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Dec 2019 14:47:29 +0100
Message-ID: <CAMRc=Me4xWsQggmr=BvJrA9-FnPkxFkOYsRTsSXCtyNwFnsHNw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] gpiolib: add new ioctl() for monitoring changes
 in line info
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 5 gru 2019 o 11:27 Andy Shevchenko <andy.shevchenko@gmail.com> napisa=
=C5=82(a):
>
> On Thu, Dec 5, 2019 at 11:42 AM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > =C5=9Br., 4 gru 2019 o 23:34 Andy Shevchenko <andy.shevchenko@gmail.com=
> napisa=C5=82(a):
> > > On Wed, Dec 4, 2019 at 6:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
>
> > > > +struct gpioline_info_changed {
> > > > +       __u64 timestamp;
> > > > +       __u32 event_type;
> > > > +       struct gpioline_info info;
> > > > +       __u32 padding[4]; /* for future use */
> > > > +};
> > >
> > > Has this been tested against 64-bit kernel / 32-bit userspace case?
> > >
> >
> > No. Since this is a new thing - do you think it's possible to simply
> > arrange the fields or add padding such that the problem doesn't even
> > appear in the first place?
>
> Yes. this can be done, though be careful about potential endianess
> issues (the ABI must be tested on BE as well).
>
> So, the test cases, I can imagine of, should include (k - kernel, u - use=
r):
> - 64k-64u: LE and BE
> - 64k-32u: LE and BE
> - 32k-32u: LE and BE

I usually use qemu VMs built with yocto for testing but I don't see
any way of creating a 32-bit user-space with 64-bit kernel. Any ideas
on how to prepare a testing environment?

Bart

>
> --
> With Best Regards,
> Andy Shevchenko
