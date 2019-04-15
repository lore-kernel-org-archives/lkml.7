Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5717206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555313267;
	bh=QWS5xeoMeq0unEDlGpOKZi1/HNLnq+cMZ9ErGDkVNX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YwuYvqdoLJgQcaZ7y1RF5MSr3BYxngoTN5cl3eInPg3ZWr6vQaBKGVm+sMqUGCX6q
	 WrpqP5F4cWIjd0yIWzuGKIfpTEO6V7FiIxg6+viKdyAycH2gfVzVOrba8+Lpr+TcOD
	 I+VC+squwtlSzDWm4mXqVr7jOlrwi3NqrX9uIdZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfDOH1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDOH1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:27:46 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DE620880;
        Mon, 15 Apr 2019 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555313264;
        bh=QWS5xeoMeq0unEDlGpOKZi1/HNLnq+cMZ9ErGDkVNX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hRqAlhcKw6GJWEjqe9CIbCbRfRvseBPkgCjEHqmCzBcYhB0K4EUdp21qw5ISDOstG
         qiGwOAQq2cGRWAWRmiB+x9eGQOhGbMz3p4LlI3pYQowJZHTUFdT8Xe5jTQCH14KGpU
         e0MiG5E1sNxYeBEyBmeqp2sgR/SRb17GlO3FHnng=
Received: by mail-lj1-f171.google.com with SMTP id q66so14614600ljq.7;
        Mon, 15 Apr 2019 00:27:44 -0700 (PDT)
X-Gm-Message-State: APjAAAX2wysRYyGVSKaGre2fN2WMeYSCKUy1UXLb+eyfXguQ1DBoMGFS
        Wx5JXyomi0AmRZQUl0n4PrC4OFeEec0YVdtgDsc=
X-Google-Smtp-Source: APXvYqwx/+EuH1bDwzrOmMkn0XXOu9Ga5p5gOEDE6ac0UZM6Iu31Gp0qHq1AR2gqQ9859mRsEmVK4PxHJFJ7DHyN5kw=
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr37851018lje.22.1555313262791;
 Mon, 15 Apr 2019 00:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br> <20190415012635.6369-4-matheus@castello.eng.br>
In-Reply-To: <20190415012635.6369-4-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 15 Apr 2019 09:27:31 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfZBmNATxDTOqiZm_rpjEpRL9sdGF7QAOxppG+ygRmZPQ@mail.gmail.com>
Message-ID: <CAJKOXPfZBmNATxDTOqiZm_rpjEpRL9sdGF7QAOxppG+ygRmZPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] power: supply: max17040: Config alert SOC low
 level threshold from FDT
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 03:51, Matheus Castello <matheus@castello.eng.br> wrote:
>
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
>
> Now we can use "maxim,alert-soc-level" property with the values from
> 1 up to 32 to configure alert interrupt threshold.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 56 ++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 8d2f8ed3f44c..f036f272d52f 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -29,6 +29,9 @@
>  #define MAX17040_DELAY         1000
>  #define MAX17040_BATTERY_FULL  95
>
> +#define MAX17040_ATHD_MASK             0xFFE0
> +#define MAX17040_ATHD_DEFAULT_POWER_UP 4
> +
>  struct max17040_chip {
>         struct i2c_client               *client;
>         struct delayed_work             work;
> @@ -43,6 +46,8 @@ struct max17040_chip {
>         int soc;
>         /* State Of Charge */
>         int status;
> +       /* Alert threshold from 32% to 1% of the State of Charge */
> +       u32 alert_threshold;
>  };
>
>  static int max17040_get_property(struct power_supply *psy,
> @@ -119,6 +124,27 @@ static void max17040_get_soc(struct i2c_client *client)
>         chip->soc = (soc >> 8);
>  }
>
> +static int max17040_set_soc_threshold(struct i2c_client *client, u32 level)
> +{
> +       int ret;
> +       u16 data;
> +
> +       /* check if level is between 1% and 32% */
> +       if (level > 0 && level < 33) {
> +               /* alert threshold use LSb 5 bits from RCOMP */
> +               level = 32 - level;
> +               data = max17040_read_reg(client, MAX17040_RCOMP);
> +               data &= MAX17040_ATHD_MASK;
> +               data |= level;
> +               max17040_write_reg(client, MAX17040_RCOMP, data);
> +               ret = 0;
> +       } else {
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
>  static void max17040_get_version(struct i2c_client *client)
>  {
>         u16 version;
> @@ -161,6 +187,16 @@ static void max17040_get_status(struct i2c_client *client)
>                 chip->status = POWER_SUPPLY_STATUS_FULL;
>  }
>
> +static void max17040_get_of_data(struct max17040_chip *chip)
> +{
> +       struct device *dev = &chip->client->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       if (of_property_read_u32(np, "maxim,alert-soc-level",
> +                       &chip->alert_threshold))
> +               chip->alert_threshold = MAX17040_ATHD_DEFAULT_POWER_UP;
> +}
> +
>  static void max17040_check_changes(struct i2c_client *client)
>  {
>         max17040_get_vcell(client);
> @@ -226,6 +262,7 @@ static int max17040_probe(struct i2c_client *client,
>
>         chip->client = client;
>         chip->pdata = client->dev.platform_data;
> +       max17040_get_of_data(chip);
>
>         i2c_set_clientdata(client, chip);
>         psy_cfg.drv_data = chip;
> @@ -237,16 +274,26 @@ static int max17040_probe(struct i2c_client *client,
>                 return PTR_ERR(chip->battery);
>         }
>
> +       max17040_reset(client);
> +       max17040_get_version(client);
> +
>         /* check interrupt */
>         if (client->irq) {
>                 int ret;
> -               unsigned int flags;
> +
> +               ret = max17040_set_soc_threshold(client, chip->alert_threshold);
> +               if (ret) {
> +                       dev_err(&client->dev,
> +                               "Failed to set SOC alert threshold: err %d\n",
> +                               ret);
> +                       return ret;
> +               }
>
>                 dev_info(&client->dev, "IRQ: enabled\n");
> -               flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
>
>                 ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -                                               max17040_thread_handler, flags,
> +                                               max17040_thread_handler,
> +                                               (client->flags | IRQF_ONESHOT),
>                                                 chip->battery->desc->name,
>                                                 chip);

Now I noticed that you are not clearing the ALRT status bit. Therefore
alert interrupt will be generated only once. Even if SoC goes up
(charged) and then down to alert level it will not be generated second
time. At least documentation for max77836 is saying that clearing this
bit is required.

Best regards,
Krzysztof
