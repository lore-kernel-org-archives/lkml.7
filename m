Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55F8C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9789C2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8lPKBk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfG1WuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:50:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45927 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfG1WuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:50:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so1932689lfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwCF4p4VJOYW2fmasUHku9SIAZNAmSFsTVp1MLzDwBc=;
        b=S8lPKBk7MGxLYkzW+Fm7fThFpteW8gkhIdKVXCqd61fnPmB83li1zsgzhOuUwj0wRv
         ng/NIisIiMqFAMmzX9wIGqBtpWZmJkoaRdgWxZj6eU3hy+cVAhHdZLkl8nZbzaVYugGE
         27H0I+11dYP8OPq/HT9D4ivhkZqWb3mjm4puUAGfDvfnqsqCxM/hJxK+JBWrKCk4o5kv
         24kOVug9dV5ZtDZA4/aTLa5P/WWcvnQJy5r/XH0NQ1B2E+lHhJWy5N4B5OV6sPpBpFAR
         VWKk/lFGJ92mNbXGsBAEpblLcuDBUeYosa2eSt+wgxvwJggShGhvC5aanSOY/GV7jIGk
         GmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwCF4p4VJOYW2fmasUHku9SIAZNAmSFsTVp1MLzDwBc=;
        b=tYgDyg22MlqrHcfIZy8hPifCIEOrvLOTCfBxYhfiTPgVkHtogroU7O/+G5aREs9ryu
         I4yOazZCWGsG9YsPN2IsDrg804gPwiCSqRHS9IdvtyHgQ9SFQjqQXIRaGZMuJOeTy/+j
         H0ztr1zEmaXSS2tlznTTufmYUCV1j+G678xyfMqw8Ne8YWuO0sXaceJ5ewqbArlPAQXf
         hLe4YMEXpXPitxQDz10ZtkB4san4aYyNDSuORp3dwZTWfTHoywSk3Hydww2bKIi3W1bQ
         nXtZpjlzdPANOP6RFuLaYAArgFvohxklDmAU11HD5IeI5251sUQ7sn4rNFA1AmZuNeg/
         NxUQ==
X-Gm-Message-State: APjAAAU+5prEBP+VyPTqzZVE6hKyD5kRsBgjXQOZGW4YqvmMyXHjtnrp
        K6M3R1Rj7gqIs9ZPYyuNfuz8eVpPldQgErEa8OEL1A==
X-Google-Smtp-Source: APXvYqwMmSxRLZ4pSDUT9udZ/Ee8CPLGtbgmC8jc/n4gBckLOQTH7U/l1CdNjEAxtyqR+gyfqDlEZb/M4iQp7r4wYac=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr49703565lfu.141.1564354206607;
 Sun, 28 Jul 2019 15:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190708110138.24657-1-masneyb@onstation.org> <20190708110138.24657-3-masneyb@onstation.org>
In-Reply-To: <20190708110138.24657-3-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:49:55 +0200
Message-ID: <CACRpkdZn-czbOOTrRs5ZgR7qTtf2A4i_L4J8_vk+kJiBuAnikg@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: allow customizing hierarchical IRQ chips
To:     Brian Masney <masneyb@onstation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>, linux-tegra@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thierry Reding <treding@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 1:01 PM Brian Masney <masneyb@onstation.org> wrote:

> Now that the GPIO core has support for hierarchical IRQ chips, let's add
> support for three new callbacks in struct gpio_irq_chip:
>
> populate_parent_fwspec:
>     This optional callback populates the struct irq_fwspec for the
>     parent's IRQ domain. If this is not specified, then
>     gpiochip_populate_parent_fwspec_twocell will be used. A four-cell
>     variant named &gpiochip_populate_parent_fwspec_twocell is also
>     available.
>
> child_pin_to_irq:
>     This optional callback is used to translate the child's GPIO pin
>     number to an IRQ number for the GPIO to_irq() callback. If this is
>     not specified, then a default callback will be provided that
>     returns the pin number.
>
> child_irq_domain_ops:
>     The IRQ domain operations that will be used for this GPIO IRQ
>     chip. If no operations are provided, then default callbacks will
>     be populated to setup the IRQ hierarchy. Some drivers need to
>     supply their own translate function.
>
> These will be initially used by Qualcomm's spmi-gpio and ssbi-gpio.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

This is overall looking very appetizing!

I want to apply this on top of my patch and respin it
with some of Masahiro's comments as well and then let's
try to just apply all of this.

> Note: checkpatch doesn't like that child_irq_domain_ops is not const.

Hm? I suspect some janitor will find the problem and patch it for us.

> +static void gpiochip_add_default_irq_domain_ops(struct irq_domain_ops *ops)
> +{
> +       if (!ops->activate)
> +               ops->activate = gpiochip_irq_domain_activate;
> +
> +       if (!ops->deactivate)
> +               ops->deactivate = gpiochip_irq_domain_deactivate;
> +
> +       if (!ops->translate)
> +               ops->translate = gpiochip_hierarchy_irq_domain_translate;
> +
> +       if (!ops->alloc)
> +               ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
> +
> +       if (!ops->free)
> +               ops->free = irq_domain_free_irqs_common;
> +}

I'm fine with translate(), this seems to be what Lina needs too.

But do we really need to make them all optional? activate() and
deactivate() will require the driver to lock the irq etc which is hairy.

Yours,
Linus Walleij
