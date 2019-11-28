Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F57206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o53h6oqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfK1Jdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:33:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38752 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1Jdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:33:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so3269177lfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3l+cg2W4Xzdxsp+mO41BTJTyFXhrTFXLxXk55wVztoc=;
        b=o53h6oqwdTFdFdpQJ4rPt/uwDFMLcQi6W2SsTIRxRA+cb3N1zxxRCT1DYA0Dou/K1U
         eL+eERBjRRcwoYQhPkVR8g6ffKBym31VtlYS2R6D9TlR6w5cOldeSsL4XHD5m6QwT8ZB
         C9XvYZIFK58guPV649jhbAeoa6yZEYoifOahcjmHZQ6HK1vH0wTpMoFsXORNTb/ijd6B
         RwTBo+wkE0n7Wc7qTQuWO+I9YjhzZSDZotA+i5Aar/F5w02ebc+rULPqgNr4eHISQ3Rk
         aej24Wz+HOIlgB9SPG4fuZ3msiYD14wR/wQA6JL0qwcPJKg+rQkABmwJngwipWvG4Vzb
         +cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3l+cg2W4Xzdxsp+mO41BTJTyFXhrTFXLxXk55wVztoc=;
        b=NNe7nWtikgHlCTUpeI3b8iel2FeBzUb2pT5gGX10Cl41fzA4+r8M9uR5bRYmQBX2O6
         TSf/H2EbE0SPnnboxnxBsePhCpgk2aqxoQ8mIy3R0oeuGmpmLfwceof/U/qSqSN41SqY
         QQfF5VsRh5w56owFz1Q6llo3y3cmFIRiOTyx64XLhacuqN+EhJ3n/JiZJ/FSW+1sV6dW
         IBwaAQ3uRf5Mb3yvg0ytDacekPhJMH3ObdiXx6D0sHK3iqA9uueh/LPoJtvhWnLovYyY
         RMoMVKiroaEQGt3+xQiUPY46HXIdL6x02r7jtBHB/i+iXQncUKKx+Y7lxZu30GcZADi3
         yc6A==
X-Gm-Message-State: APjAAAXN3GRyMpIiYXdQ83xgheKc6OLK0ZmRLPrgnEN5OXYP+yjWUUBh
        eGDOVvZnf4/1XAg/fbCH6bpvP3A9VmGx/47dHoGCMA==
X-Google-Smtp-Source: APXvYqxfbj5pxG5YMqROUBTxW/+eod2ag0rTzoIBQOB9GKAdn4qaMOxEDphfz+rX9eoAZbteFkAt71MY9iWGiAEBwKA=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr4426002lfi.135.1574933631692;
 Thu, 28 Nov 2019 01:33:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574277614.git.jan.kiszka@siemens.com> <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
In-Reply-To: <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 10:33:40 +0100
Message-ID: <CACRpkdbE_gkm4n3_V3_D0mKL4dF1pYC1ORbg07YSk24TpYrjTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: sch: Add edge event support
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

thanks for your patch!

On Wed, Nov 20, 2019 at 8:20 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Add the required infrastructure consisting of an irq_chip_generic with
> its irq_chip_type callbacks to enable and report edge events of the pins
> to the gpio core. The actual hook-up of the event interrupt will happen
> separately.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Please resend after the merge window, some comments:

First I'm pretty sure this driver can select GPIOLIB_IRQCHIP
and use infrastructure from the core to handle interrupts.

The fact that you register your own irq handler does not
stop that. See for example the solution in
drivers/gpio/gpio-mt7621.c
where we set the ->parent_handler to NULL to let
the driver handle the IRQs itself.

I will try to make this more explicit in the API as we work
with this.

>  struct sch_gpio {
>         struct gpio_chip chip;
>         spinlock_t lock;
>         unsigned short iobase;
>         unsigned short resume_base;
> +       int irq_base;

Why are you keeping this around in the state?
Why not just a local variable?

> +static int sch_gpio_to_irq(struct gpio_chip *gpio, unsigned int offset)
> +{
> +       struct sch_gpio *sch = gpiochip_get_data(gpio);
> +       return sch->irq_base + offset;
> +}
(...)
> +       .to_irq                 = sch_gpio_to_irq,
(...)
> +       irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, sch->chip.ngpio,
> +                                       NUMA_NO_NODE);
> +       if (irq_base < 0)
> +               return irq_base;
> +       sch->irq_base = irq_base;
> +
> +       gc = devm_irq_alloc_generic_chip(&pdev->dev, "sch_gpio", 1, irq_base,
> +                                        NULL, handle_simple_irq);
> +       if (!gc)
> +               return -ENOMEM;
(...)
> +       ret = devm_irq_setup_generic_chip(&pdev->dev, gc,
> +                                         IRQ_MSK(sch->chip.ngpio),
> +                                         0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> +       if (ret)
> +               return ret;

So I think you can avoid this complexity by jus doing what
gpio-mt7621.c is doing,
use devm_request_irq(), populate girq = &gc->irq; before
registering the gpio_chip pass a handle_simple_irq
and reuse core gpio irqchip infrastructure.

But I don't know everything so let's test and see!

Yours,
Linus Walleij
