Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E82DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645DE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1BZ4TCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbfDQN7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:59:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34319 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfDQN7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:59:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so14384054qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RJK/OXbOLwSkl4kFszwfj+QheAbq4xdID7Xf2T785o=;
        b=v1BZ4TCTQlKaiMK7OvoNZNm0OcZA5UTzBMq1nCEYhs+s8RllOjm9OqUHZ10pQMdIhk
         nQDb31Fvji0FtabKyOUXZkNjPc+aou8vdGox7Fj/AFkBETy+9rJzJpyDh0w8DQMLq9Xa
         LdDMhhfeJGc1PsNDIqL2NIOn4XsA+pqpuz/yYQWabVmtSdLom+UynLAyVI1/WEI/Ygfv
         DtZLxmd9g6TBx4cWxow5+VF/9z2LKK9L6Ad9gVRBdd3K6NWXgJZSB7ZQNJIKdjV8dBK5
         kcanX9O8Q6Dv7xw+WV0JG1NTxIPbCqu6+RPtNCojyIpMEV78YuhKtf2zYWGAN6Nf/tl+
         5Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RJK/OXbOLwSkl4kFszwfj+QheAbq4xdID7Xf2T785o=;
        b=cFgAwYFtezQnUQB7qnImF3sgPUtSMVsAdKG4YVKSMJRd63mSiTNvSsRscw8LntaLg1
         1bMTzLZydcxopHET7x7rlHPIFwbVIUsPdN3SKPgFqBjD6fbmjEFYJKGYnV+kd4e2s3DW
         hOrHLIVG6crs4wbB5FF89Ep6gR19AExj11ndTt075g0ooruzeCu8ZaNN6slBgi/k3kEP
         nUZfV1tjTPWIl4Y+V/vHCaofTO6RHMUwaX7+GBiI2wsJc09MV+iuaUFVA670+AGI5VO/
         R0JY8j05yWAJHpmYwmCWufaxagty6+vrrb9eaFc/OQkLANMb/AIsbrAUJHUVkvXlso+6
         n7JA==
X-Gm-Message-State: APjAAAXxEKnDMZ2zsF2RLY1nHKSN4R1+iepwiY+8lAjFK1NDaInC//O7
        8D42wBAEFF/d9KzkcA71zASwMzNZ5HZOqg5q541FsVq4l6c=
X-Google-Smtp-Source: APXvYqwzmZTcuUJqd6dgDmRdPpkOESO7iaNxU+0+2Hi2/iUkdmRXFRq8f8kEbpw/HXHfJvV5Ra38qIDEhEeUb9ffDpY=
X-Received: by 2002:a37:aad8:: with SMTP id t207mr64821208qke.42.1555509546844;
 Wed, 17 Apr 2019 06:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190313211844.29416-1-ilina@codeaurora.org> <20190313211844.29416-8-ilina@codeaurora.org>
 <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
 <20190316113948.1d180259@why.wild-wind.fr.eu.org> <155320527587.20095.3351235428610314272@swboyd.mtv.corp.google.com>
In-Reply-To: <155320527587.20095.3351235428610314272@swboyd.mtv.corp.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 Apr 2019 15:58:52 +0200
Message-ID: <CACRpkdYF=ibjisyedZy7eK2D5ovVcGsbFBaDBmDyEQ1NuEO+rA@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
To:     Stephen Boyd <swboyd@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Marc Zyngier (2019-03-16 04:39:48)> > On Fri, 15 Mar 2019 09:28:31 -0700
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > Quoting Lina Iyer (2019-03-13 14:18:41)
> > > > @@ -994,6 +1092,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
> > > >         pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
> > > >         pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
> > > >
> > > > +       chip->irq.chip = &pctrl->irq_chip;
> > > > +       chip->irq.domain_ops = &msm_gpio_domain_ops;
> > > > +       chip->irq.handler = handle_edge_irq;
> > > > +       chip->irq.default_type = IRQ_TYPE_EDGE_RISING;
> > >
> > > This also changed from v3. It used to be IRQ_TYPE_NONE. Specifying this
> > > here seems to cause gpiolib to print a WARN.
> > >
> > >
> > >         /*
> > >          * Specifying a default trigger is a terrible idea if DT or ACPI is
> > >          * used to configure the interrupts, as you may end up with
> > >          * conflicting triggers. Tell the user, and reset to NONE.
> > >          */
> > >         if (WARN(np && type != IRQ_TYPE_NONE,
> > >                  "%s: Ignoring %u default trigger\n", np->full_name, type))
> > >                 type = IRQ_TYPE_NONE;
> > >
> > >
> > > So I guess this change should be dropped. Or at the least, it should be
> > > split out to it's own patch and the motivations can be discussed in the
> > > commit text.
> >
> > It is something I requested (although I expected this to be a
> > different patch, and even a clarification would have been OK).
> >
> > One way or another, the default trigger must match the flow handler. If
> > we set it up with IRQ_TYPE_NONE, what does it mean? The fact that
> > IRQ_TYPE_NONE acts as a wildcard doesn't mean the handle_edge_irq flow
> > handler is a good match for all interrupt types (it is rarely OK for
> > level interrupts).
>
> I think this is a question for Thierry or Linus. I'm not sure why this
> check was put in place in the code. I tried to dig into it really quick
> but I didn't find anything obvious and then I gave up.
>
> Maybe with hierarchical irqdomains we can drop this check? I don't think
> the gpiolib core ever uses this 'default_type' or 'handler' for anything
> once we replace the irqdomain that's used for a particular gpiochip with
> a custom irqdomain. The only user I see, gpiochip_irq_map(), won't ever
> be called so it really ends up being a thing that the driver specific
> irqdomains should check for and reject when parsing the DT and it sees
> IRQ_TYPE_NONE come out.
>
> ------8<-------
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 144af0733581..fe2f7888c473 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1922,7 +1922,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
>          * used to configure the interrupts, as you may end up with
>          * conflicting triggers. Tell the user, and reset to NONE.
>          */
> -       if (WARN(np && type != IRQ_TYPE_NONE,
> +       if (WARN(!gpiochip->irq.domain_ops && np && type != IRQ_TYPE_NONE,
>                  "%s: Ignoring %u default trigger\n", np->full_name, type))
>                 type = IRQ_TYPE_NONE;

Sorry for taking long time to answer... this got lost in some mail
storms.

It's a bit of Marc Z question really but I try to answer and
he can correct me.

We are now getting used to ACPI and DT always specifying
the IRQ trigger type on the consumer handle: a device tells
the irqchip what kind of edge or level it wants.

Things weren't always like that.

Some boards in the kernel is still using board files. (Yeah
please help in modernizing them, I am doing my part.)

Old machines with GPIO irqchip jitted to the SoC irq controller
sometimes had a hardcoded behavior such as edge, and the
consumers would only issue something really legacy
like

request_irq(42, myhandler, 0, "myirq", data);

and expect it to work, since 0 means use the default flags,
it might have a platform device with this irq number passed
as a resource, but that is a really dumb platform device still,
and it might not have set any irqflags for the irq number
it passes. It probably doesn't even know that the irq number
is backed by an irq descriptor.

Since the code that e.g. DT has inside drivers/of/platform.c
irq_of_parse_and_map(), will incidentally create an irq
descriptor and set up these flags from the consumer flags in the
device tree and call the irqchip to set up the trigger through
.set_type() whenever the interrupt is requested, this is no
problem for DT. Or ACPI.

But on a board file, the .set_type() will eventually be called
with IRQ_TYPE_NONE, which will cause a bug, or no IRQs
or something like that.

So a bunch of GPIO irqchips are created passing
IRQ_TYPE_EDGE_* or IRQ_TYPE_LEVEL_* to set up a default
trigger, because all the irqs on this chip use the same trigger
anyway, and they only have one flow handler anyway.
Everything is edge, or everything is level or so.
irq_set_irq_type() will be called when mapping the GPIO to
an irq, including calls from gpiod_to_irq() and friends that
get used a lot in legacy code.

This happened by simply factoring custom GPIO irqchips
into the gpiolib over time.

No-one has really gotten around to tracking down
all the offending callers of request_irq() and their respective
interrupt providers and make sure the descriptors for all these
IRQs get set up properly in drivers or board files. As far
as I know. (INTERESTING WORK!)

It is a mess, really hard to fix, essentially everything need to
be modernized or deleted for us to get rid of the possibility
to pass a default trigger.

I guess it is possible to check all gpiochip_irqchip_add*
and see if there are still chips passing something else than
IRQ_TYPE_NONE. It would take some time to look at all of
them, maybe it isn't used by anything anymore? Then
we can simply delete this and assume it will always be
set up orderly. We have modernized quite a few systems
recently.

Yours,
Linus Walleij
