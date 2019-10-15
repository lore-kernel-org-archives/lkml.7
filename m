Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD4DECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07A221835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoCuT2+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfJOJCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:02:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37882 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfJOJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:02:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so9280321plq.4;
        Tue, 15 Oct 2019 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/FDmIN7D8CAH00XLKSbXEilWCinqJP7n+EcoU7otuk=;
        b=HoCuT2+lllpMGI7rxiT0hR8SrLG0PxTVSag1/oMBtvUyOxazz+MUgiI1f8MRbx46ej
         GOavSu+uhk8b6OY/Z4K8ksOea6AVOo8YvnixA0pmAn8Mj43ZoY4HXbCK5fX9F657AIpm
         Iq4zItG0MZtz4yqXJx1lRI03gq7wX7c2zG9nq9luguy0oKWRsBC89Uf2XwMAa1e0Zzgc
         h5kIKDSpesNdliArJBfcRHOcLLZERWLYirCf6ScpT36OkkoWyWhkh6eDDAYLxQ/fnYR6
         4r6LXRWVC+f7kDgeGRRcu7pFWdZ6JI5CZAipJ7DMvBp8pV14/qNA9T0F8LAIPtFD5imQ
         CQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/FDmIN7D8CAH00XLKSbXEilWCinqJP7n+EcoU7otuk=;
        b=gg7oh5ZjQGjulF3Z2xTfieQDXc84zKmcMo35UuBk5nfnSAmC4JYT5rxPQDgWxciDvd
         hERTfEdJ9DfLImmNEGGd53klHCz66hxh6G32lV9FFFnUwsgsKIuRgE1wfEkHKaI9vCdf
         YcGwxfhF5lPgkEolBj40eG/ZVaXXE/54BYwkpdY5vCwdGEpQJUZnzHBQk5W0OY21RrmO
         iHFlBKPZke4xg3ibefT9gG7Mjv1XYMatWSktp7r8P+7SaCjFnbZpHWiIL+CkeO4Ay1L+
         UeDPFGMMoqRDL4GzGNtF1gmz7UZQwta7cdt4a7klPIzsI5WYA03t/oifUbrTaIA62nH6
         j4lw==
X-Gm-Message-State: APjAAAUd2c8aQoDPpv3ILU9u3RRcreu/QZM3bMI0QUYYhcL/8KXe38gO
        SMWUrml5FmR8vibqqREqXyWqlEbAVVKZZVg1vwI=
X-Google-Smtp-Source: APXvYqwO/5hFqux5frYOwevy/NieZz1EIdQe655HuLE5hkKwfQJ49zRK0A/Mgoun/IUJoY/i+vhv9Ba0Waay4XJ8WXM=
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr35148119plp.18.1571130132022;
 Tue, 15 Oct 2019 02:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191004214334.149976-1-swboyd@chromium.org> <20191004214334.149976-2-swboyd@chromium.org>
 <CAHp75Vebn48hbzqKWzV3aj4NEBCta_Fn7zOQHzsznW4=6cXLsQ@mail.gmail.com> <5da4e084.1c69fb81.567f9.4b9c@mx.google.com>
In-Reply-To: <5da4e084.1c69fb81.567f9.4b9c@mx.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Oct 2019 12:02:01 +0300
Message-ID: <CAHp75Vcht2S7j64vUGw+DQdSEAyxuyBJ9oVwHyXxnL9bM1-wFA@mail.gmail.com>
Subject: Re: [PATCH 01/10] leds: pca953x: Use of_device_get_match_data()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Riku Voipio <riku.voipio@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Andy Shevchenko (2019-10-14 10:50:06)
> > On Sat, Oct 5, 2019 at 12:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > This driver can use the of_device_get_match_data() API to simplify the
> > > code. Replace calls to of_match_device() with this newer API under the
> > > assumption that where it is called will be when we know the device is
> > > backed by a DT node. This nicely avoids referencing the match table when
> > > it is undefined with configurations where CONFIG_OF=n.
> >
> > > +       devid = (int)(uintptr_t)of_device_get_match_data(dev);
> >
> > > +               devid = (int)(uintptr_t)of_device_get_match_data(&client->dev);
> >
> > This still leaves it OF-centric.
> > Better to use device_get_match_data().
> >
> > Also, I'm thinking that following may help to clean a lot of the i2c
> > client drivers
> >
> > static inline // perhaps no
> > const void *i2c_device_get_match_data(struct i2c_client *client, const
> > struct i2c_device_id *id)
> > {
> >   if (id)
> >     return (const void *)id->driver_data;
> >   return device_get_match_data(&client->dev);
> > }
> >
>
> Looks alright to me. Maybe device_get_match_data() can look at the bus
> and call some bus op if the firmware match isn't present? Then we can
> replace a bunch of these calls with device_get_match_data() and it will
> "do the right thing" regardless of what bus or firmware the device is
> running on.

It will be something ugly like

buses {
#ifdef I2C
&i2c_bus_type,
#endif
...
}

in the code. I won't do this.

See generic_match_buses[] for example.

-- 
With Best Regards,
Andy Shevchenko
