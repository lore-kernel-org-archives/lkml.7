Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C5A206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c+nMPYIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLPLD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:03:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34498 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfLPLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:03:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so5449819qtz.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KyT8iX33k7sFRkYd4RU7rY84Ij+yNZq0ApEE/O2fu+4=;
        b=c+nMPYIjLlikLb2ZpmWU4U9s9hyYGvdF3o6ckh0KkdQWhoWxbaPpDXJjUfQoEjL4hs
         JiqsWAkvw7+QhnYVC6Hm589MhvP5vdsHr/5C7CCmG19vVxIFQ8vQOct17sSzVFBr+E9w
         WFZ53+XrUR+uIO3iN0ibxCexTTT377SJSCEV3v8jLXqTN1pJmxZz6+r8cnSemfqwTKtg
         lN8RVRkPGWkVjY9s7IVZsYQfZ6VNmu+6leKlecJSTaLumd7U5JjtK1V1VzQIyZpbPQE1
         9hXv3CvWDoV2MBW6kEiIztHmOeAZWFr6dl7BYg39nXpZM9umvUJBAdNswAK4F/Jp0GIj
         GNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KyT8iX33k7sFRkYd4RU7rY84Ij+yNZq0ApEE/O2fu+4=;
        b=Nfdk0KNw0tVK5PvvSYZqUB5yMdJbwJdST1hhQofHAJTOGsygDIuIe0lGneCvEE9Qha
         YSYNn7Yqq4meuTl4Pk00tHbkkRjlHtS63F3mRhXNIcWYj4XCkJwoSY7WbndFwsQcVxcW
         z/GaqO4V7CjkVW11DnBOXn1/vN/MRtbhRyCvP7DVa7MTp/xUzXvkeDrQeG85sfAr4BUx
         N9e0lhqG86T2cl0T+Q5zLW6P0DyT9kSHxI3OuTsWZGy6DX5eMdLds94MjVhX7a8dg+Kt
         qN0vBifW0a0HJ/kFHNqlmeKu5D88IGOXT4GzNDuSy5NYM1vMr7bgTTmb2u69y0ruX/3B
         ZF/w==
X-Gm-Message-State: APjAAAWO9Il4kG579pr1DmD/+KX53lZhJ2ZzMDZVTodCBPJxtYHEl4cr
        GGHQVA9Fr6cvgnGpYH8CjhwydKdSI2Aa1D/SFvYVcA==
X-Google-Smtp-Source: APXvYqzw6JZzysee+REdRGrquVmuOvAlaSakT5VJ1hcbEefqMpv5n487ZNnV9cdF1eId5+6AYmJ11V8kLlSsj2qNIv0=
X-Received: by 2002:ac8:5208:: with SMTP id r8mr23685802qtn.131.1576494234130;
 Mon, 16 Dec 2019 03:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-5-ktouil@baylibre.com>
 <CACRpkdbHLv2R+XvCjCaEgaztUqpmHWCmSAqHABkkstJREkmfVw@mail.gmail.com>
In-Reply-To: <CACRpkdbHLv2R+XvCjCaEgaztUqpmHWCmSAqHABkkstJREkmfVw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 16 Dec 2019 12:03:42 +0100
Message-ID: <CAMpxmJWGRskDudwLpzVZKvYb=Gbcxy6s0gCLUUFkgLq-CYEiZg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] eeprom: at24: remove the write-protect pin support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Khouloud Touil <ktouil@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        baylibre-upstreaming@groups.io,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 16 gru 2019 o 09:13 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrot=
e:
>
> > NVMEM framework is an interface for the at24 EEPROMs as well as for
> > other drivers, instead of passing the wp-gpios over the different
> > drivers each time, it would be better to pass it over the NVMEM
> > subsystem once and for all.
> >
> > Removing the support for the write-protect pin after adding it to the
> > NVMEM subsystem.
> >
> > Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
>
> I wonder if this needs to be in the same patch that adds it to
> the NVMEM subsystem, so as to avoid both code paths being
> taken between the two patches (bisectability..)
>
> However that is not the biggest thing in the universe and I'm
> no bisectability-perfectionist, so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

AFAIK Khouloud tested it and it's bisectable thanks to using the
optional gpiod_get() variant.

Best regards,
Bartosz Golaszewski
