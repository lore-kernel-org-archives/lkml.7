Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F60CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5DD222D3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0/myShTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfKDJVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:21:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39352 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfKDJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:21:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id v138so13466783oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 01:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7BzvCFGFyHem7aNvDILp+YA5kEio7GlXJNf7u1ymYOQ=;
        b=0/myShTiuQ4rArcEWL8wQRtTTKVsb2N3NQXnwQYMfPFcyhRTMJ+0vpsq7Ox2xr39VA
         8Awfq4VwFqUYLI92qKeUN9UC5PMacNHQkAY3l7dNZG1YTRsele9Hidoet2llNrWOLQ12
         9UFYDzesbB56fdWwSOlfYYULjDeyT0GFbeq8tyl9f/93zbi6BanBbX7nCf13V/36sLKg
         XoVSaK5XUbT+hVwZ0YGEOILxL/yUKSo+ttq/bxjtjG8lBrSthpTKYrolEofmCTOrGrlp
         759BLOJ30Grp4iGtIEzNCS7mATs3NjGyCkIPoEqizBGoQhkakbOxsKzk0bgGDICkzyOJ
         qG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7BzvCFGFyHem7aNvDILp+YA5kEio7GlXJNf7u1ymYOQ=;
        b=tMDUbGhkIQWjVa+B3J3laa2LznQPl1OmSAx3mTUgjTDdY4+NPvBNE728TpXCVJEHfV
         C5C+G/8eKggt9VgUp7p9fqgGm/8mOs/9f5LYPcz56YWmiyKAMsdSX55UhByuwHeC9ZkT
         Cvx4PJw4Zo1Aldk4Bb8S54vumb5pDDHc0Ab3nyAa7ExTfInAAcXCait1dkfTMhfG7Ame
         7NMmZW4/vcSdD/z0Ua8zrt4Y1qPd5ivyeEC61wIdeGLy7YzBZCGafVzq/GC1mbKIVU0D
         Vjz97rHjJhzx5L3jyMWoI1XviqGsbC6IoITEq9vfpbmfpG7nESsYx2xowwyCx+4j4qtL
         xJ8w==
X-Gm-Message-State: APjAAAVoTjMEE1a4SD1XNyQ5n4G0AZEjv/3Okb9RyVmbglaYE4MP0qyP
        45YJ5n7JHqHpw9TAb8hX1uxcL95k0v/bAgfm1JRo6A==
X-Google-Smtp-Source: APXvYqyQ0vp3yLB+4K20lpmZqH2Zh3Z1GRej9tMUGvHlMZYtobNN2gwGszngK6ROtXBsWD+0NaiVD2cotrXFaCG0vS0=
X-Received: by 2002:a05:6808:498:: with SMTP id z24mr3440549oid.114.1572859293807;
 Mon, 04 Nov 2019 01:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20190930130246.4860-1-brgl@bgdev.pl> <20190930130246.4860-6-brgl@bgdev.pl>
 <20191104090904.GA12355@duo.ucw.cz>
In-Reply-To: <20191104090904.GA12355@duo.ucw.cz>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 4 Nov 2019 10:21:23 +0100
Message-ID: <CAMpxmJWc6G6d5zR9kbGoKckMmGwXHB6o4AbFA56sjcyUZrNXjQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: leds: max77650: convert the binding
 document to yaml
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 4 lis 2019 o 10:09 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Convert the binding document for max77650 LED module to yaml.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>

Hi Pavel,

thanks for the Ack, but a much modified version of this is already in
Rob's branch.

Bart

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
