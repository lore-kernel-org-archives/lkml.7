Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3399C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17B12075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555312239;
	bh=g22wWW72ermFm9LEnoi9m68VeyetHkEq+g30fB6hsHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JGqQmThqg4ooFzmQ4cvTL4F9rC7NCKNXgy+Gl3tKtUFPso+EiKJg15ZJjh0e4pdiL
	 fIXsQL7LxY+leAN1eUTBglDEu00LrvF9227NtyNL2LK5709TC2scjMl27qx3CR/Kvf
	 gkefoMREkkpsPHZGRkzgc9dADIViZ0r6lCp8nET8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfDOHKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfDOHKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:10:38 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3AE2077C;
        Mon, 15 Apr 2019 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555312236;
        bh=g22wWW72ermFm9LEnoi9m68VeyetHkEq+g30fB6hsHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rb/oLjGKkDUsSRefhtgh9J18QV6JaRW9180VO3sdW7aXbVSN4orXQy9ev1+XiOzko
         tNIQ8ysffsNQsLKVt3VpmeAJ4ikGSUcOlI/fWKNLHoa6IZj8JTcc7anWVtsbNYUvcX
         9VRJgBAsjSIQFvc5VcXPVndY8SqSKINMPplUucgI=
Received: by mail-lj1-f176.google.com with SMTP id h21so14530533ljk.13;
        Mon, 15 Apr 2019 00:10:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUz4IyoHwwhSRHWawuS90s4Rm1/lLTAxTo+dJq0rRB5WTa7vIfL
        wHR5epZ9iZGLJlI2T4IJHeoE05F33wt1heCZH4Q=
X-Google-Smtp-Source: APXvYqwzCLRHPK4xrIUuOctzilU65CqyuHZ7hneYqs8ZhXoV1A+ux6ay+jFOJ0Flpt/CH9hzesnMADfezBeTjH8vr5c=
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr38641964ljj.104.1555312234479;
 Mon, 15 Apr 2019 00:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br> <20190415012635.6369-2-matheus@castello.eng.br>
In-Reply-To: <20190415012635.6369-2-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 15 Apr 2019 09:10:23 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfXS_L992rPdHqitFyRmw93En9GRLVOjRRnwGgiEwV28Q@mail.gmail.com>
Message-ID: <CAJKOXPfXS_L992rPdHqitFyRmw93En9GRLVOjRRnwGgiEwV28Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: max17040: Add IRQ handler for low
 SOC alert
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

On Mon, 15 Apr 2019 at 03:49, Matheus Castello <matheus@castello.eng.br> wrote:
>
> According datasheet max17040 has a pin for alert host for low SOC.
> This pin can be used as external interrupt, so we need to check for
> interrupts assigned for device and handle it.
>
> In hadler we are checking and storing fuel gauge registers values
> and send an uevent to notificate user space, so user space can decide
> save work or turn off since the alert demonstrate that the battery may
> no have the power to keep the system turned on for much longer.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 69 +++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 91cafc7bed30..8d2f8ed3f44c 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/power_supply.h>
>  #include <linux/max17040_battery.h>
>  #include <linux/slab.h>
> @@ -160,21 +161,40 @@ static void max17040_get_status(struct i2c_client *client)
>                 chip->status = POWER_SUPPLY_STATUS_FULL;
>  }
>
> +static void max17040_check_changes(struct i2c_client *client)
> +{
> +       max17040_get_vcell(client);
> +       max17040_get_soc(client);
> +       max17040_get_online(client);
> +       max17040_get_status(client);
> +}
> +
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
>
>         chip = container_of(work, struct max17040_chip, work.work);
> -
> -       max17040_get_vcell(chip->client);
> -       max17040_get_soc(chip->client);
> -       max17040_get_online(chip->client);
> -       max17040_get_status(chip->client);
> +       max17040_check_changes(chip->client);
>
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
>                            MAX17040_DELAY);
>  }
>
> +static irqreturn_t max17040_thread_handler(int id, void *dev)
> +{
> +       struct max17040_chip *chip = dev;
> +       struct i2c_client *client = chip->client;
> +
> +       dev_warn(&client->dev, "IRQ: Alert battery low level");
> +       /* read registers */
> +       max17040_check_changes(chip->client);
> +
> +       /* send uevent */
> +       power_supply_changed(chip->battery);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static enum power_supply_property max17040_battery_props[] = {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_ONLINE,
> @@ -217,6 +237,27 @@ static int max17040_probe(struct i2c_client *client,
>                 return PTR_ERR(chip->battery);
>         }
>
> +       /* check interrupt */
> +       if (client->irq) {
> +               int ret;
> +               unsigned int flags;
> +
> +               dev_info(&client->dev, "IRQ: enabled\n");
> +               flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> +
> +               ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +                                               max17040_thread_handler, flags,
> +                                               chip->battery->desc->name,
> +                                               chip);
> +
> +               if (ret) {
> +                       client->irq = 0;
> +                       if (ret != -EBUSY)

Why not on EBUSY?

> +                               dev_warn(&client->dev,
> +                                       "Failed to get IRQ err %d\n", ret);
> +               }
> +       }
> +
>         max17040_reset(client);
>         max17040_get_version(client);
>
> @@ -224,6 +265,8 @@ static int max17040_probe(struct i2c_client *client,
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
>                            MAX17040_DELAY);
>
> +       device_init_wakeup(&client->dev, 1);

Either you parse DT for wakeup-source property and use it... or you
unconditionally enable wakeup. In the second case - there is no point
to check later for device_may_wakeup(). Instead check the return value
of device_init_wakeup().

> +
>         return 0;
>  }
>
> @@ -244,6 +287,14 @@ static int max17040_suspend(struct device *dev)
>         struct max17040_chip *chip = i2c_get_clientdata(client);
>
>         cancel_delayed_work(&chip->work);
> +
> +       if (client->irq) {
> +               if (device_may_wakeup(dev))
> +                       enable_irq_wake(client->irq);
> +               else
> +                       disable_irq_wake(client->irq);

Did you try the wakeup from suspend? You do not have a disable_irq()
here which usually was needed for interrupts to work properly on
suspend. Maybe this was fixed?

Best regards,
Krzysztof
