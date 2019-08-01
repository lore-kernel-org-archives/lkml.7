Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37DCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BF3214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUu2NGVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfHANTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:19:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39913 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfHANTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:19:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so69309236ljh.6;
        Thu, 01 Aug 2019 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RC6wKO1Isy8ssplnFFBZCldnnaBxZKmxUbojPji9Nn8=;
        b=KUu2NGVrF3CsroBiTb6xu1ZVx93LkXrT1peKf0dykpEFlk4TXLXA7TsWvS53RT4lTo
         K4juM7BZMtb6SDbbYkdwqh1AgseBQOTuTLGUQqm1vROI5EC+TR9avlR+2A/5WE/Qx8Qb
         XWc6+IL5OyWftImZreXB9VDAxlRk4GhtGSuE3eShxQ5CmYP7YV9SFJpsposFOODrqH/M
         XMddEgfFPqbmw+rwydtEpbADNt+2pztRm/8V4eNqKyDwtpRXa1tsw0GhJtxeCoHvevVw
         4YUexJXuE2KX2Dta84W+JPUzjl0DL9dlC4VnMLXsFy/fq4RrYFWAzwMLTM+5t4+IXl/5
         9EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RC6wKO1Isy8ssplnFFBZCldnnaBxZKmxUbojPji9Nn8=;
        b=CSKL8XS6jDHXd4EmHUCbRSaKztj9GgwGYsbcTpDUDE7Fmzr+gWCX0oDtItNyrEaJ7p
         viZX0ZH0/5MwOHxmE8oZfTet0VSdHrV+DqKEzCSvlgvPqe2O1wYBFV1fwwd2d1lRKkWI
         Tui2n8uWrh5O8j11irt9YnlNxwYBXPUDZWu6Nr/ZxOd3hOruZcZPdO73DB5zYB89rSN0
         2DElOtIIBb8xz4ccwDAqB4k58qicqR54OkX7kKN7yzuhgv75JeDu/7HJMqP8xnmhvZmn
         9qL4Mfxm+qIdN0pFteXhzlbxhY4r8Y/f09KhsoGwXDUWbeuEfYoX03NqpVgd45d3IItg
         Ob7Q==
X-Gm-Message-State: APjAAAW47cSuq3ZVqeG72r1XtsqXbo9upphDgey+1VXvARSat0gNSEnJ
        7znu4ma4t/zaUSW/TaR8KsjBtwpjFSVhGpDBsjw=
X-Google-Smtp-Source: APXvYqxUbh1cL9LgQJwJqmT3uKcr+dkk4jgpEBFMs3ohuwPYtfrWNXPxJw2IeNHF6fA+Gt5UlsJw2+1zolwkPA+X8KM=
X-Received: by 2002:a2e:5d1:: with SMTP id 200mr68535653ljf.10.1564665573273;
 Thu, 01 Aug 2019 06:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190801124446.15703-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190801124446.15703-1-frieder.schrempf@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 1 Aug 2019 10:19:45 -0300
Message-ID: <CAOMZO5BPRNDQG_6PunUTxK7P=NF1DqjxvM+xEVMzX+rGd=h9hA@mail.gmail.com>
Subject: Re: [PATCH] serial: mctrl_gpio: Avoid probe failures in case of
 missing gpiolib
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf,

On Thu, Aug 1, 2019 at 9:47 AM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() and
> mctrl_gpio_init_noauto() will currently return an error pointer with
> -ENOSYS. As the mctrl GPIOs are usually optional, drivers need to
> check for this condition to allow continue probing.
>
> To avoid the need for this check in each driver, we return NULL
> instead, as all the mctrl_gpio_*() functions are skipped anyway.
> We also adapt mctrl_gpio_to_gpiod() to be in line with this change.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Looks good to me:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Also adding Geert on Cc as the patch touches sh-sci.

Thanks


> ---
>  drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
>  drivers/tty/serial/serial_mctrl_gpio.h | 6 +++---
>  drivers/tty/serial/sh-sci.c            | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 2b400189be91..54c43e02e375 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                                       enum mctrl_gpio_idx gidx)
>  {
> +       if (gpios == NULL)
> +               return NULL;
> +
>         return gpios->gpio[gidx];
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
> index b7d3cca48ede..1b2ff503b2c2 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.h
> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
> @@ -114,19 +114,19 @@ static inline
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                                       enum mctrl_gpio_idx gidx)
>  {
> -       return ERR_PTR(-ENOSYS);
> +       return NULL;
>  }
>
>  static inline
>  struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
>  {
> -       return ERR_PTR(-ENOSYS);
> +       return NULL;
>  }
>
>  static inline
>  struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
>  {
> -       return ERR_PTR(-ENOSYS);
> +       return NULL;
>  }
>
>  static inline
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index d18c680aa64b..249325b65ee0 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3287,7 +3287,7 @@ static int sci_probe_single(struct platform_device *dev,
>                 return ret;
>
>         sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
> -       if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
> +       if (IS_ERR(sciport->gpios))
>                 return PTR_ERR(sciport->gpios);
>
>         if (sciport->has_rtscts) {
> --
> 2.17.1
