Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E1BC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08052792C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 13:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmTIPegk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFBNqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 09:46:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44267 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 09:46:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so11487236lfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HXePg+U9wYisFggCp2Pzqg3Rwj+xqMpwFPX/mLExcw=;
        b=kmTIPegkoSpcJ8hqye1lqSBQSA7MkeiqNch0W+2HBj7RSol1Jvtjj5QrIzwitU+hIz
         akckmxjuwIQxq3CoddMUkYVUqOsjhEbSterRG+2EC4tTyQYt8H/bvNP1aGKC+dk3FBfT
         8TCZkeexa5fDIsp599kOGla3jttCqBINBPmBrQlTpBsiNSlMbb00/fPdJffvjz8ajOYK
         iVwNJT5Ay/bdeUz64mIMnz31e0pXEQ79gMjuYSMlZwFKh72N+UDjLCVPQQ42LnlMZ+XA
         8J2/dJaI806P5fVy7F0wT32fW/RGcjS4b1Fv+/oRdSFGssK5AG7MnV5OUlsMZKpVYIfA
         cp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HXePg+U9wYisFggCp2Pzqg3Rwj+xqMpwFPX/mLExcw=;
        b=YWNaWjrco32DWBk+3MOviObrFfi8HmalyR6vnqTCBt/P2xqR+yeovo0uencLgGB2EZ
         0zxxHrVVE1G1bTdAsteAW3oC8ntnOK+DrRBz9cfQ6tC0sZboBqGRys86w39rfYBL5HQ1
         ukETd3Vdy/qgv01TcTpXRyoRRIV+IWwSgzio2gSjk4eu7LghrJW9kCLJlKKSK2Ih3Rbg
         bIS5s76rnaEBTLfkE1XakrU2Vz/BNUFnR/Z4m+r1ICDG8D0t0UC70gaWOFnCLMEjTsV7
         xLd3zvyA1vgCLqqf6l4n1N/Oiy8K85I9r7s0RXCIUhYALzCvHkJV1SWByYy0+/8M3Qvu
         4rbw==
X-Gm-Message-State: APjAAAUUtsNJhRrLpUkYdGwu1DJTscI9Y6HtJiW9vmNjPNc0Aw3v92aj
        qJv/h+JQ6aV6qJrxgNw3V/D6BVEtUW8hzwbFYpm6mg==
X-Google-Smtp-Source: APXvYqz6WY5pxflKsXHSMYl4mX+ysp3I0qjeB0QZKykytlcSBEDK9daj1SeTNDVgSkwE6Ex68afJYUMfuStOy42vDGM=
X-Received: by 2002:a19:ae09:: with SMTP id f9mr11059917lfc.60.1559483171545;
 Sun, 02 Jun 2019 06:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190529145322.20630-1-thierry.reding@gmail.com> <20190529145322.20630-2-thierry.reding@gmail.com>
In-Reply-To: <20190529145322.20630-2-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jun 2019 15:46:00 +0200
Message-ID: <CACRpkdb5vB6OwcAxtjsKLzHt9V27juEOEEDqqQczKT-3r+7X-g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: Add support for hierarchical IRQ domains
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lina Iyer <ilina@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 4:53 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Hierarchical IRQ domains can be used to stack different IRQ controllers
> on top of each other. One specific use-case where this can be useful is
> if a power management controller has top-level controls for wakeup
> interrupts. In such cases, the power management controller can be a
> parent to other interrupt controllers and program additional registers
> when an IRQ has its wake capability enabled or disabled.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - use irq_create_fwspec_mapping() instead of irq_domain_alloc_irqs()
> - add missing kerneldoc for new parent_domain field
> - keep IRQ_DOMAIN dependency for clarity
>
> Changes in v2:
> - select IRQ_DOMAIN_HIERARCHY to avoid build failure
> - move more code into the gpiolib core

This is looking really good!

>  config GPIOLIB_IRQCHIP
>         select IRQ_DOMAIN
> +       select IRQ_DOMAIN_HIERARCHY
>         bool

Hm OK I guess. It would be ugly to ifdef all hierarchy
code in gpiolib.

>  static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
>  {
> +       struct irq_domain *domain = chip->irq.domain;
> +
>         if (!gpiochip_irqchip_irq_valid(chip, offset))
>                 return -ENXIO;
>
> +       if (irq_domain_is_hierarchy(domain)) {
> +               struct irq_fwspec spec;
> +
> +               spec.fwnode = domain->fwnode;
> +               spec.param_count = 2;
> +               spec.param[0] = offset;
> +               spec.param[1] = IRQ_TYPE_NONE;
> +
> +               return irq_create_fwspec_mapping(&spec);
> +       }
> +
>         return irq_create_mapping(chip->irq.domain, offset);

This is looking really good!

> +       /*
> +        * Allow GPIO chips to override the ->to_irq() if they really need to.
> +        * This should only be very rarely needed, the majority should be fine
> +        * with gpiochip_to_irq().
> +        */
> +       if (!gpiochip->to_irq)
> +               gpiochip->to_irq = gpiochip_to_irq;

Please drop this. The default .to_irq() should be good for everyone.
Also patch 2/2 now contains a identical copy of the gpiolib
.to_irq() which I suspect you indended to drop, actually.

Other than that I'm ready to merge the v3 of this!

Yours,
Linus Walleij
