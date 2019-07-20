Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A57C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B9C20578
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VXbYG3+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfGTSD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 14:03:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34037 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfGTSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:03:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id l12so26716904oil.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fV6Yxz5phWkhQA6DReninzloQxSLe34uuPheQWujNzU=;
        b=VXbYG3+WE8sblpJmTKNLu27EzPYP1iHM+AmcY9VHfuzbAgVjQkz9y0QKaeEEfwrAHz
         rVGvnj49z5kKX5trEK7cFHuxIwjHd2Xf+FBoXjf39hoWGusOH86ZLwQ/G+OBWkAHHxIq
         7gX7zpJWMe4dxmb4EuIA/vnipwgiWI7bmoBaPnvp2OjDy+ID06w0UouPwCIPV6qRTZSn
         u1RUZ4fJzRwfmG+fMyFsNxKodWBMVTDcHHpYmnNdPeGr+KB2Dpskra3FjhMQ44ed8YWK
         ZM5YZlk6fHu/Ju6bkiJH8X/ojj+BsYCRbIMW2iItZ08jFMsy88worwZIg8QRRE/p/cXe
         M3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fV6Yxz5phWkhQA6DReninzloQxSLe34uuPheQWujNzU=;
        b=LCc6Mn7qdlelQY6uGsSQOTQq7yEKqIgPeXoMti0M41tHQi05JIDuqlCDiO+hcm+kzF
         2iUb1fJFecPHr8IkUo+S7lCoP45uqaZi2idLGbQtp6ZN12lnh5OE03s88PpzFPApQPvJ
         /iNQiZYO7lCmzZTTgaaV73C/qxngoiY9rEuvsUmGZgH+W8yqzC9heSVR5//i32qO/RQg
         UdPuYsmJua1ckFLb2pSPXWDrrRv0Za0vk3HOEquRZNFY1BILuiZwOdFMaC/8mQ75BfPd
         claTtF8Yc+6dVPPYpY1BiNMhjWA1oeqfCkuwK5nhwJau8yJMBPocpwzw59D0iYRaCNaw
         6Log==
X-Gm-Message-State: APjAAAUqsjf5gKPRadTYFDfs4jxlTY18hyukk1pypU8OX4wrtj3SahM0
        QFo5wnmwY/Vzx26mRdT5C0RYEB41LB7srFaE9CLilg==
X-Google-Smtp-Source: APXvYqwHVk7vHOw+xBU078uF3hkUUhazrYDOeBwuccwt3X+aE2K5ej+DaAT8WkGp2/wh8W/LqW7Xq6xnV+k898hUyjo=
X-Received: by 2002:a05:6808:d4:: with SMTP id t20mr9504688oic.170.1563645804556;
 Sat, 20 Jul 2019 11:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190708082343.30726-1-brgl@bgdev.pl> <CACRpkdb5xKHZja0mkd-wZJ+YHZpGJaDrkA0dv60MNYKXFcPK4w@mail.gmail.com>
 <CAMRc=MfB9R70QDqtjG5a5Roq1roeL78Ss5noytrY-7P=tY1OHA@mail.gmail.com> <CACRpkdaiZgK1EoaUxDtbm_GJHVjZU56e_qBQ-OF0mmwb5W8+tg@mail.gmail.com>
In-Reply-To: <CACRpkdaiZgK1EoaUxDtbm_GJHVjZU56e_qBQ-OF0mmwb5W8+tg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sat, 20 Jul 2019 20:03:13 +0200
Message-ID: <CAMpxmJWDTkhuWhfSJ-fkJ6r+7a3kErXafQ_sJLVgMf=cA=1+aQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: don't WARN() on NULL descs if gpiolib is disabled
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Claus H . Stovgaard" <cst@phaseone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 16 lip 2019 o 23:46 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Tue, Jul 9, 2019 at 4:20 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > wt., 9 lip 2019 o 15:30 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> > > I was thinking something like this in the stubs:
> > >
> > > gpiod_get[_index]() {
> > >     return POISON;
> > > }
> > >
> > > gpiod_get[_index]_optional() {
> > >    return NULL;
> > > }
> >
> > This is already being done.
>
> Ah it is.
>
> > > This way all gpiod_get() and optional calls are properly
> > > handled and the semantic that only _optional calls
> > > can return NULL is preserved. (Your patch would
> > > violate this.)
> > >
> >
> > Maybe I'm missing something, but I don't quite see how my patch
> > violates this behavior. :(
>
> I missed that we actually do pass a poison from the strict
> *get functions, mea culpa.
>
> Let's apply this, will you send me a pull request or shall I
> just try to apply it?
>
> Yours,
> Linus Walleij

I'll apply it to my local tree and send it for v5.3-rc2.

Bart
