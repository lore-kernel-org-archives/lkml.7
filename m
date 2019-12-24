Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0080C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FE52071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="y3KDEcah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfLXMJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:09:52 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41668 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfLXMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:09:52 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so16429523ils.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QhDBoTIiirz7+f0YK9tYWNUzE5UvM7uCBjdyK0UCnvg=;
        b=y3KDEcahXkPz00bBc2gzvixr4nz/dUNEvI1adQ3p6bsX05r3hhXcptXof4QPv/pnGR
         qq/H6WR1/g0BDANyfFXA4+dafm6vW4qq7o//udDWt5CZmZJjJXG6qzGnmWqEH2cAb/BU
         ni2hlBYACwJ25LtD/5XidIAZfLb1PZbh/NesV9AG8131kZyajBsvt8lT6R9+tNUGVcbC
         F2S+O+xSrkLN3/eANdD5b+RY1JKgEVmbwr/9h3Y9ytalfZR7r31oU3tb6UXHniLX+zS+
         KA2tihHzMEN5RZwhyrTd9HFE4m1zF3fibrpRBA5ayqLy7l/+5T4TpcYn+KGEWRdZqYHO
         FnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QhDBoTIiirz7+f0YK9tYWNUzE5UvM7uCBjdyK0UCnvg=;
        b=IHtV4Eqqkq7Zc9NKvU8BB+BWrsc+L5wZIDVX+RUl10v56708R/Z6MvtjdMqs10S2Qm
         E0mwA5Pqm8gp9NQVS8C2wJ9uSE+ovan16QWMBwJBerCcaFMAWz8ZbMLhXI3ZJWsffven
         We+J99FCtfHTaEmShNeBo99n2a8zqEjauS0VFkQE6FUVGiDoAB1xOFy/EvVIRMBd3Ki8
         vSXcZx5pFyG55upE60SzpNamyi0YkGKpHWgstVWt+z8iOOa3hqcAXsZiD8Tg8/MNa4pR
         RU+UNTYJLQoFBqYsav9StmjjJniEDu++V6F1OefZku7bTgZV2i62bPqRezSj1qofoxSn
         +J7A==
X-Gm-Message-State: APjAAAWqI+4+S8HC41MgroYyzuUmbDkVvG7nCe79IkzFGtIBfrfYWvoK
        aZKRWRlshzUm/SrqA23X71QQm0gGOq3sDmNvqKFhQA==
X-Google-Smtp-Source: APXvYqyZtJ0zfmx+kNah15UpNOstiDp9o76kL/FKOLcsfoCEMDezjmW4WfXYOBzXH62agFBUCQ9KKrXoQNEyEsI6uv0=
X-Received: by 2002:a92:3b98:: with SMTP id n24mr28770466ilh.189.1577189391707;
 Tue, 24 Dec 2019 04:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20191219171528.6348-1-brgl@bgdev.pl> <20191219171528.6348-13-brgl@bgdev.pl>
 <CAHp75VeMEngXiFmvTrsW7UZMz0ppR-W-J4D1xU+qKGfLXkG3kg@mail.gmail.com>
 <CAMpxmJV4UU21x8rfNMaJ6G2OiRa3qC2vYQWH4C_T+nS4b_NcUw@mail.gmail.com>
 <20191220121543.GY32742@smile.fi.intel.com> <CAMpxmJWPmhqadKcd6b62fScAs5N1TRtoXBq+5MPtC0Q=-p3ALg@mail.gmail.com>
In-Reply-To: <CAMpxmJWPmhqadKcd6b62fScAs5N1TRtoXBq+5MPtC0Q=-p3ALg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 24 Dec 2019 13:09:41 +0100
Message-ID: <CAMRc=MdECHQQ-i0dZVp_1g8H6P+vjxg1HSCmkN5ySw+8p3W0Dw@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] gpiolib: add new ioctl() for monitoring changes
 in line info
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 20 gru 2019 o 18:29 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> > > struct gpioline_info alone is 32-bit aligned but its size is 72 bytes
> > > which works for 64-bit alignment. This new structure's biggest elemen=
t
> > > in 64-bit, so it's 64-bit aligned on 64-bit arch. We have 72 bytes of
> > > gpioline_info, 8 bytes of timestamp, 32 bytes of event type and 5 * 3=
2
> > > bytes of padding. Should be fine, but I'll add comments to the header=
.
> >
> > Yes, what I meant is to add comment at least to struct gpioline_info de=
finition
> > that if somebody would like to change it there (which also might be a
> > problematic here, if there is no versioning scheme / length member).
> >
> > > > > +       __u64 timestamp;
> > > > > +       __u32 event_type;
> > > > > +       __u32 padding[5]; /* for future use */
> > > > > +};
> >
> > Offtopic a bit, had you had a chance to look at Buildroot and our scrip=
ts
> > I shared?
> >
>
> Not yet, I'll do that over the weekend.

Now tested using the buildroot image you posted. Thanks for that, I'll
make sure to use it to test the v2 API for lineevents.

Bart
