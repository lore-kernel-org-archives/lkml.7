Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CCDFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B4B205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCbDGIfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393172AbfJPMlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:41:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37322 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390395AbfJPMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:41:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so22580941qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qm75DokwzXjTKEsie0o+9Iq4HWwxwsH9v5bQoEbr1/o=;
        b=GCbDGIfZj92w5Qr0xsU4UFCGnAPsKp2B0SiNcm4fP+CM+kqIY+pbss57O7snZ/Jb7u
         p2qiS7Jr7qstgGUIAFsOvcZM3Rf6mEogb9Po9PUh3Dvni6D8KifmK5EFUraMLpG7XOpd
         LbLUl93c+tyAA4l00tH09WvmkUDo6Wa+qLUXglL+/RbwD5H7DE/BrHT/qvB1FGuV/Suw
         Ze2a8Aph6z4KM+O3/6CPiHRwfmWjJ8qS8SvURsTHjnO3O6Q33w21FEa6oE6QvnAO+RJl
         Fp1bm83FJt4fMoxFEkftNFuuNpN7fPAjE+j3TRVHaP+sAkRtfw4Tbs4NgiQlgSYhsahl
         XwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qm75DokwzXjTKEsie0o+9Iq4HWwxwsH9v5bQoEbr1/o=;
        b=s5d/G3KAuhUOht124Cwi+0Txa9fDjLsjUtjCo/Gtuu41EFJtd1zbGIYbl039aX2KAo
         JM18U879O9zBjuUJNLPkoLsvZVdaGCp1W+ed+4ns0bqDufE7uCrmJee/QiUBXL4R5tDF
         vqh4GWDn252dgY+/oSI92OVJngmF4YtTGOsVYVKNQQXn+cjwoBZr5STI+Uz6I8eX3ejv
         gQ3r3WisDQu82oYAxU+G9Z4PDdUXiKuP8psaM0hNBygYu/LqY48CzTdDDOmL0ynz6GQQ
         RJiHuK8fpYIFioFgYKX21X9eGs6+POiT1LsbJWpLadegtRHCptQzbvV+Kmk7uwGCTvV3
         1Zmw==
X-Gm-Message-State: APjAAAUUJbLCEKP2DVRO3WCKJ+q0+tZd9V9zE48g/M6D7Ohvj893cACw
        ESog59qiCCzPpfmTQqCnI6PS1WUhsZZAT+CNVsoU2w==
X-Google-Smtp-Source: APXvYqxJshG3708iZ8DdRzTqOCKqoWAZClhQq8BFfkn1xeAaY0P671YgWTPOt5msWwuM1JD2JtXAOJkXdiETud2QSVI=
X-Received: by 2002:a05:620a:751:: with SMTP id i17mr39873356qki.340.1571229703313;
 Wed, 16 Oct 2019 05:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org> <20191015173026.9962-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191015173026.9962-4-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:41:32 +0200
Message-ID: <CACRpkdZRY138RAf8N2xGam89r66ik2vW44OZx0bDcCt4P2GBLA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: Add RDA Micro GPIO controller support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan!

Thanks for your patch!

On Tue, Oct 15, 2019 at 7:30 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add support for GPIO controller from RDA Micro.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Please use a little bit more verbose commit message, who
made this hardware and what is it for. If you know!

> +config GPIO_RDA
> +       bool "RDA Micro GPIO controller support"
> +       depends on ARCH_RDA || COMPILE_TEST
> +       depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP

select GPIO_GENERIC

> +#include <linux/bitops.h>

Do you need this or just <linux/bits.h>?

> +#define RDA_GPIO_OEN_VAL               0x00
> +#define RDA_GPIO_OEN_SET_OUT           0x04
> +#define RDA_GPIO_OEN_SET_IN            0x08
> +#define RDA_GPIO_VAL                   0x0c
> +#define RDA_GPIO_SET                   0x10
> +#define RDA_GPIO_CLR                   0x14
> +#define RDA_GPIO_INT_CTRL_SET          0x18
> +#define RDA_GPIO_INT_CTRL_CLR          0x1c
> +#define RDA_GPIO_INT_CLR               0x20
> +#define RDA_GPIO_INT_STATUS            0x24

This is a very clear cut MMIO GPIO so use GPIO_GENERIC with this
hardware.

> +static void rda_gpio_update(struct gpio_chip *chip, unsigned int offset,
> +                           u16 reg, int val)

Maybe keep this if it saves code from the IRQ callbacks,
inline it to register writes if it doesn't get called much.

> +static int rda_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> +static int rda_gpio_direction_output(struct gpio_chip *chip,
> +                                    unsigned int offset, int value)
> +static int rda_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +static void rda_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)

This can all be replaces by select GPIO_GENERIC and passing
the right offsets into bgpio_init(). Look at for example
gpio-ftgpio010.c and the documentation for bgpio_init()
in gpio-mmio.c for help.

This will also implement get/set_multiple for you for
free!

> +static void rda_gpio_irq_mask(struct irq_data *data)
> +static void rda_gpio_irq_ack(struct irq_data *data)

Looks good

> +static int rda_gpio_set_irq(struct gpio_chip *chip, u32 offset,
> +                           unsigned int flow_type)

Maybe _setup_irq()? Not sure, just that the name doesn't
obviously imply how it is used as it is called from two
places.

The rest of the IRQ code looks good!

> +static int rda_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct gpio_irq_chip *irq_chip;

Since irq_chip is the name of a struct in the kernel I usually
just call this "girq" as in "GPIO irq chip".

> +       struct rda_gpio *rda_gpio;
> +       u32 ngpios;
> +       int ret;

Create a struct device *dev = &pdev->dev; helper variable
to make the following code easier to read. (The pointer
&pdev->dev is used in many places...)

> +       /*
> +        * Not all ports have interrupt capability. For instance, on
> +        * RDA8810PL, GPIOC doesn't support interrupt. So we must handle
> +        * those also.
> +        */
> +       rda_gpio->irq = platform_get_irq(pdev, 0);
> +
> +       rda_gpio->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(rda_gpio->base))
> +               return PTR_ERR(rda_gpio->base);
> +
> +       spin_lock_init(&rda_gpio->lock);
> +
> +       rda_gpio->chip.label = dev_name(&pdev->dev);
> +       rda_gpio->chip.ngpio = ngpios;
> +       rda_gpio->chip.base = -1;
> +       rda_gpio->chip.parent = &pdev->dev;
> +       rda_gpio->chip.of_node = np;
> +       rda_gpio->chip.get = rda_gpio_get;
> +       rda_gpio->chip.set = rda_gpio_set;
> +       rda_gpio->chip.direction_input = rda_gpio_direction_input;
> +       rda_gpio->chip.direction_output = rda_gpio_direction_output;
> +
> +       if (rda_gpio->irq >= 0) {
> +               rda_gpio->irq_chip.name = "rda-gpio",
> +               rda_gpio->irq_chip.irq_ack = rda_gpio_irq_ack,
> +               rda_gpio->irq_chip.irq_mask = rda_gpio_irq_mask,
> +               rda_gpio->irq_chip.irq_unmask = rda_gpio_irq_unmask,
> +               rda_gpio->irq_chip.irq_set_type = rda_gpio_irq_set_type,
> +               rda_gpio->irq_chip.flags = IRQCHIP_SKIP_SET_WAKE,
> +
> +               irq_chip = &rda_gpio->chip.irq;
> +               irq_chip->chip = &rda_gpio->irq_chip;
> +               irq_chip->handler = handle_bad_irq;
> +               irq_chip->default_type = IRQ_TYPE_NONE;
> +               irq_chip->parent_handler = rda_gpio_irq_handler;
> +               irq_chip->parent_handler_data = rda_gpio;
> +               irq_chip->num_parents = 1;
> +               irq_chip->parents = &rda_gpio->irq;

That works but ... please devm_kzalloc() like the other drivers
do:

girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
                                     GFP_KERNEL);
        if (!girq->parents) {
                ret = -ENOMEM;
(...)

Unless you have a real good reason to optimize it. I just
want it to follow the pattern since I want to minimize
cognitive stress for the maintainers. (Me.)

Yours,
Linus Walleij
