Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B0C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD90422459
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5Qjpvpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfJEQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:49:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34349 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfJEQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:49:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so6569915lfm.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFYXbByYhGEXfOvEgQ/Yv7O8maPlLwNPKG6/+oAaKb0=;
        b=F5Qjpvpi6G+ab+VeuCiBsb6tm18qqaMtmFRT4reLGjpmUHLQIKEy38RCdhiSjtQoYr
         gxUT6twp6LaP1bTlGnWGv4bQySjuigIwrgHhmPKCbxPGBjd7/LYxeuA+gBsCmRkysK3O
         pH/XMlhMcKe8iXOk/2VDpQk54SIR+ndpxUrBJzAe/NI5B0WdIBaj5ogYjdYehYK3cQ35
         Uz82JVR+RRWh/cH1+2hUTPNVyI31grf74MbU6CHnN01sEYQskDQY5F905me9Q1O4MIuO
         66UKqnl76X1MvlQ2KDltSwqSE5p2wZNmWRtT45rianVJwNaprLpXKDq9dfy+9WkxiBB0
         rISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFYXbByYhGEXfOvEgQ/Yv7O8maPlLwNPKG6/+oAaKb0=;
        b=IAR6gNBAtKGXHWulFAGS8S07bEMRJZTSalR01HhyRHmnATizphTV517mjaRRijxGA1
         z5qA3ZR27DUTcnaQQQ48b+zTqCzpNy+77M5MRlG1mHj7tlWaVIuiyDyf4vU4dZdImate
         Ze2WPfkk8alwuzKO6h7mUm4UdfvypcTx7rhGj4JTo52ggK9sE4edOmFnegAZ6Ye3I93n
         zXlYMK6cS82BAhKRYlqKPqeP29mUYpHPdErVOkEht+DJCYLs0Ege/0R8hnZYo2TRGCpk
         6eoWMb3KpvO0lR5rVWjmJS8BPjiCJSfuZAYEJhYfdBlmQTXnoAKBqW5zPSeeoQ4QneyO
         0JpQ==
X-Gm-Message-State: APjAAAWCZsn4sm0MSLqg42vlEAmhO8zJ6TOWOX5qmqcIPrd+9PpAdaHH
        Z+cc+DJWw3jHZ5kz00PALaVozNcEYHss5Wm8iJ4Oxw==
X-Google-Smtp-Source: APXvYqzWLIXea2bSktYcXAMWUxPBnRthWgHgKi9V9cmgUV7xXLZpltHmYaRhUSOORfu5uwvTkgz2I3T7Lp7NJCXeluc=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr12207816lfp.61.1570294190713;
 Sat, 05 Oct 2019 09:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191004122923.22674-1-amelie.delaunay@st.com>
In-Reply-To: <20191004122923.22674-1-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 18:49:37 +0200
Message-ID: <CACRpkda6CyYCt-s-VkaK856Jt3TxQg+HVDz-5Ww9T9KNHHAjaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: stmfx: add irq_request/release_resources callbacks
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:29 PM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> When an STMFX IO is used as interrupt through the interrupt-controller
> binding, the STMFX driver should configure this IO as input. Default
> value of STMFX IO direction is input, but if the IO is used as output
> before the interrupt use, it will not work without these callbacks.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

OK I see what you want to achieve.

> +static int stmfx_gpio_irq_request_resources(struct irq_data *data)
> +{
> +       struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
> +       struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
> +       int ret;
> +
> +       ret = stmfx_gpio_direction_input(&pctl->gpio_chip, data->hwirq);
> +       if (ret)
> +               return ret;
> +
> +       ret = gpiochip_lock_as_irq(&pctl->gpio_chip, data->hwirq);
> +       if (ret) {
> +               dev_err(pctl->dev, "Unable to lock gpio %lu as IRQ: %d\n",
> +                       data->hwirq, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}

Just call gpiochip_reqres_irq() instead of calling the lock etc
explicitly.

> +static void stmfx_gpio_irq_release_resources(struct irq_data *data)
> +{
> +       struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
> +       struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
> +
> +       gpiochip_unlock_as_irq(&pctl->gpio_chip, data->hwirq);
> +}

Just call gpiochip_relres_irq()

But all this duplicated a lot of code from the core which is not so nice.

> @@ -678,6 +706,8 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
>         pctl->irq_chip.irq_set_type = stmfx_pinctrl_irq_set_type;
>         pctl->irq_chip.irq_bus_lock = stmfx_pinctrl_irq_bus_lock;
>         pctl->irq_chip.irq_bus_sync_unlock = stmfx_pinctrl_irq_bus_sync_unlock;
> +       pctl->irq_chip.irq_request_resources = stmfx_gpio_irq_request_resources;
> +       pctl->irq_chip.irq_release_resources = stmfx_gpio_irq_release_resources;

What about just adding

pctl->irq_chip.irq_enable and do stmfx_gpio_direction_input()
in that callback instead? gpiolib will helpfully wrap it.

Yours,
Linus Walleij
