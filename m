Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A744ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7246121721
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LDIPIlBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfJNUyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:54:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35166 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbfJNUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:54:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so11054271pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=95ESZvb6hY/1oI03oQhYfYM4zdjk2hIsXx4a/gPdDg0=;
        b=LDIPIlBMzwu89BYY277hY2x1yQ6+BbzLmB02F76DS3jp9EF27RWfpAGf6PCW/Zt6PK
         W3rvy9pT/uJTuI9zriXHphkOreHYFYZ/TccSgt3DupK0Z8liwntFavnqti6aJYmA3auB
         RT2Z7fYZyy133IoITNtgtJbGg4Nv8H/llzUuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=95ESZvb6hY/1oI03oQhYfYM4zdjk2hIsXx4a/gPdDg0=;
        b=gp+/jrtSRcnoYoQsMJy2FomdeGjP9SWSk3G+pgtwiSrKY1QM5b1GqflXCuDcUD9cLc
         cW9Fn/7qkwsOow99LAAmW3Jq5gGn5ZxjC0uHNYFQTxbKaJvplCFpULd/OmDd4ZoJc/iJ
         ob7528Q//PkYAYHaW3/iUxdicVG62hRTKVXdmHgjqAkkYWVyltFbcWKMaQJrBQcthrBq
         3GZUHJMiUT9UD8qwxn9Gj8CrKboD74DQHS6Il/79iso6NpjiWv1rKsc+WYajRaG/jN59
         5Mp9BMRvxVLkxmIH9H86jQ7voPt/dGNsBwQRf+FD6ATmh192mLF4CV6nnASFhnxPdkf5
         BxYg==
X-Gm-Message-State: APjAAAX4zvLjMqQdwyPonkjj5+1pRO3WtdeuJzeqpksxrXQvVD+pg+a8
        6ctQwM2D87Kl7FoHSirRRnoQlQ==
X-Google-Smtp-Source: APXvYqze6dhlWjrga/yBdXEdpzKX+Qt8+IQ23tHt2i0c5hknDE1KOExAQ1qoVzk2cd889pMAIxeHVw==
X-Received: by 2002:a17:90a:5d0f:: with SMTP id s15mr37927966pji.126.1571086469798;
        Mon, 14 Oct 2019 13:54:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 11sm18080943pgd.0.2019.10.14.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 13:54:28 -0700 (PDT)
Message-ID: <5da4e084.1c69fb81.567f9.4b9c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75Vebn48hbzqKWzV3aj4NEBCta_Fn7zOQHzsznW4=6cXLsQ@mail.gmail.com>
References: <20191004214334.149976-1-swboyd@chromium.org> <20191004214334.149976-2-swboyd@chromium.org> <CAHp75Vebn48hbzqKWzV3aj4NEBCta_Fn7zOQHzsznW4=6cXLsQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Riku Voipio <riku.voipio@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH 01/10] leds: pca953x: Use of_device_get_match_data()
User-Agent: alot/0.8.1
Date:   Mon, 14 Oct 2019 13:54:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2019-10-14 10:50:06)
> On Sat, Oct 5, 2019 at 12:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > This driver can use the of_device_get_match_data() API to simplify the
> > code. Replace calls to of_match_device() with this newer API under the
> > assumption that where it is called will be when we know the device is
> > backed by a DT node. This nicely avoids referencing the match table when
> > it is undefined with configurations where CONFIG_OF=3Dn.
>=20
> > +       devid =3D (int)(uintptr_t)of_device_get_match_data(dev);
>=20
> > +               devid =3D (int)(uintptr_t)of_device_get_match_data(&cli=
ent->dev);
>=20
> This still leaves it OF-centric.
> Better to use device_get_match_data().
>=20
> Also, I'm thinking that following may help to clean a lot of the i2c
> client drivers
>=20
> static inline // perhaps no
> const void *i2c_device_get_match_data(struct i2c_client *client, const
> struct i2c_device_id *id)
> {
>   if (id)
>     return (const void *)id->driver_data;
>   return device_get_match_data(&client->dev);
> }
>=20

Looks alright to me. Maybe device_get_match_data() can look at the bus
and call some bus op if the firmware match isn't present? Then we can
replace a bunch of these calls with device_get_match_data() and it will
"do the right thing" regardless of what bus or firmware the device is
running on.

