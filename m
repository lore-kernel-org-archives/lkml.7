Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844DBC04AAE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5865B21744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="MLZ+PiNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEIDKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 23:10:09 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38429 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfEIDKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:10:08 -0400
Received: by mail-it1-f194.google.com with SMTP id i63so444897ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 20:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzFejlNEzzPWI2r7iGHhXKbUYOinWB90ZjCR6lplpJM=;
        b=MLZ+PiNhFL5hha/66D5ODFUNYQ/skp7nsqd36wDgUuqDzaQcdCDnVSKy7otHyCgg7G
         /NskfxkW9Ea4pf7FxQozEFB7iQjQLi+UFdUQCmrsgke5a6AqmoyJcHH5M6DuOItu9Qym
         T68sJkaE1MQp9UqhHSJ+lEkmbqbBI4A4vIVvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzFejlNEzzPWI2r7iGHhXKbUYOinWB90ZjCR6lplpJM=;
        b=YewAFpl+gNBWw3OWf4wVtsj6BD/MixMWCaPR9fdiMr1g9lTqU7xSw8lerWBjmWGgt0
         8W4BviFitSw1yBJk9YgqWUDQYA8PUgdDZWzqRcjbdHy5zQJI0RUBwigSBf11E0tN3hIs
         6kuPGNCC38gmvqD9e/UZytjcHaiz7zmpS4paooRJWlXD8F6nesummTV8bePzfa/9uDmJ
         gtd0wbvtgoPTChG8b3OxkgFLspNIg7YFWtKMJMAbW5aT98ChSwCRLvEsp4dXWQbYeyVS
         4XPXcjjCNY4KstfHZ/weTq/JIMo4UO7SDMa9rlOmJ/MaCSOsLulFWgZfzyQeJb1/AxeG
         59qg==
X-Gm-Message-State: APjAAAXkzdQXASZ1x58CbG/Y6Bv53UoF8ztWIXmhlU+ozajcHBmCup+D
        LhmbPUENGNEltX7YbO1cmQBtfMr7XizfigXwqRHuGw==
X-Google-Smtp-Source: APXvYqyqeTraiqcoBgrs1Y5Hn4sTqYBHZrLGAU/Y2T6uREISJrV6U8WvJa1xGGDNCYO4MkT7gMND0OlRjiDLAomEYuU=
X-Received: by 2002:a02:3b24:: with SMTP id c36mr1346624jaa.52.1557371407664;
 Wed, 08 May 2019 20:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com> <1557344128-690-3-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1557344128-690-3-git-send-email-eajames@linux.ibm.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 9 May 2019 11:09:56 +0800
Message-ID: <CAJCx=gn0Yv+oP56HQQNm-9JbH2aoZuEQ-73b1grLTVNfbYsDsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: dps310: Temperature measurement errata
To:     Eddie James <eajames@linux.ibm.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, joel@jms.id.au,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 3:36 AM Eddie James <eajames@linux.ibm.com> wrote:
>
> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>
> Add a manufacturer's suggested workaround to deal with early revisions
> of chip that don't indicate correct temperature. Readings can be in the
> ~60C range when they should be in the ~20's.
>
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/iio/pressure/dps310.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 7afaa88..c42808e 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -221,6 +221,9 @@ static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
>         case DPS310_MEAS_CFG:
>         case DPS310_CFG_REG:
>         case DPS310_RESET:
> +       case 0x0e:
> +       case 0x0f:
> +       case 0x62:

What is with the magic values? Are they not documented to what they
are, and hence not defining enum values for them?

- Matt

>                 return true;
>         default:
>                 return false;
> @@ -237,6 +240,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
>         case DPS310_TMP_B1:
>         case DPS310_TMP_B2:
>         case DPS310_MEAS_CFG:
> +       case 0x32:
>                 return true;
>         default:
>                 return false;
> @@ -314,7 +318,7 @@ static int dps310_read_raw(struct iio_dev *iio,
>         .writeable_reg = dps310_is_writeable_reg,
>         .volatile_reg = dps310_is_volatile_reg,
>         .cache_type = REGCACHE_RBTREE,
> -       .max_register = 0x29,
> +       .max_register = 0x62,
>  };
>
>  static const struct iio_info dps310_info = {
> @@ -322,6 +326,47 @@ static int dps310_read_raw(struct iio_dev *iio,
>         .write_raw = dps310_write_raw,
>  };
>
> +/*
> + * Some verions of chip will read temperatures in the ~60C range when
> + * its actually ~20C. This is the manufacturer recommended workaround
> + * to correct the issue.
> + */
> +static int dps310_temp_workaround(struct dps310_data *data)
> +{
> +       int r, reg;
> +
> +       r = regmap_read(data->regmap, 0x32, &reg);
> +       if (r < 0)
> +               return r;
> +
> +       /*
> +        * If bit 1 is set then the device is okay, and the workaround does not
> +        * need to be applied
> +        */
> +       if (reg & BIT(1))
> +               return 0;
> +
> +       r = regmap_write(data->regmap, 0x0e, 0xA5);
> +       if (r < 0)
> +               return r;
> +
> +       r = regmap_write(data->regmap, 0x0f, 0x96);
> +       if (r < 0)
> +               return r;
> +
> +       r = regmap_write(data->regmap, 0x62, 0x02);
> +       if (r < 0)
> +               return r;
> +
> +       r = regmap_write(data->regmap, 0x0e, 0x00);
> +       if (r < 0)
> +               return r;
> +
> +       r = regmap_write(data->regmap, 0x0f, 0x00);
> +
> +       return r;
> +}
> +
>  static int dps310_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
> @@ -383,6 +428,10 @@ static int dps310_probe(struct i2c_client *client,
>         if (r < 0)
>                 goto err;
>
> +       r = dps310_temp_workaround(data);
> +       if (r < 0)
> +               return r;
> +
>         r = devm_iio_device_register(&client->dev, iio);
>         if (r)
>                 goto err;
> --
> 1.8.3.1
>
