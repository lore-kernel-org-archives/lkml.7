Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF89BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDD820685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jdgUBmgC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="boVxiw1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfDVW61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:58:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfDVW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:58:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2882B61637; Mon, 22 Apr 2019 22:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555973905;
        bh=ogJvh7xESNQds26SlkHNHZxYq6DZITjmgoMw0x41fqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdgUBmgC6fQst9sxSOMX6uqA1kkodPsBxgISX97F9C2Khs2mvcNN7fB2pN+kehTXb
         iRJmKZS+Y2TLBnWONyvOlKI/uBwlqoOVrmyV8gxOhu72isge9wwqyL86OKkJjbxT/S
         NyHvnI3lECrfgkskqYw+wZPg/kGiIrSr0sLGeeLY=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92DB26115B;
        Mon, 22 Apr 2019 22:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555973903;
        bh=ogJvh7xESNQds26SlkHNHZxYq6DZITjmgoMw0x41fqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boVxiw1iyRpO1++uPuaNzyWFmHYjtQSnCq99VP9VKknYCDiGwyail3E/638YpSTXY
         SsA1Tg+0h41ssfaE0ERFG4BWUxxhwNLwIOOHBZDe2RgmHSubf2zeLtu311n0Mv+PKk
         ERCmW70GojA0S79JIRYQ2PATb8GAvUckfzlgzLJ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92DB26115B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 22 Apr 2019 16:58:22 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Evan Green <evgreen@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
Message-ID: <20190422225822.GA25744@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-8-ilina@codeaurora.org>
 <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
 <20190316113948.1d180259@why.wild-wind.fr.eu.org>
 <155320527587.20095.3351235428610314272@swboyd.mtv.corp.google.com>
 <CACRpkdYF=ibjisyedZy7eK2D5ovVcGsbFBaDBmDyEQ1NuEO+rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACRpkdYF=ibjisyedZy7eK2D5ovVcGsbFBaDBmDyEQ1NuEO+rA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17 2019 at 07:59 -0600, Linus Walleij wrote:
>On Thu, Mar 21, 2019 at 10:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>> Quoting Marc Zyngier (2019-03-16 04:39:48)> > On Fri, 15 Mar 2019 09:28:31 -0700
>> > Stephen Boyd <swboyd@chromium.org> wrote:
>> >
>> > > Quoting Lina Iyer (2019-03-13 14:18:41)
>> > > > @@ -994,6 +1092,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>> > > >         pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
>> > > >         pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>> > > >
>> > > > +       chip->irq.chip = &pctrl->irq_chip;
>> > > > +       chip->irq.domain_ops = &msm_gpio_domain_ops;
>> > > > +       chip->irq.handler = handle_edge_irq;
>> > > > +       chip->irq.default_type = IRQ_TYPE_EDGE_RISING;
>> > >
>> > > This also changed from v3. It used to be IRQ_TYPE_NONE. Specifying this
>> > > here seems to cause gpiolib to print a WARN.
>> > >
>> > >
>> > >         /*
>> > >          * Specifying a default trigger is a terrible idea if DT or ACPI is
>> > >          * used to configure the interrupts, as you may end up with
>> > >          * conflicting triggers. Tell the user, and reset to NONE.
>> > >          */
>> > >         if (WARN(np && type != IRQ_TYPE_NONE,
>> > >                  "%s: Ignoring %u default trigger\n", np->full_name, type))
>> > >                 type = IRQ_TYPE_NONE;
>> > >
>> > >
>> > > So I guess this change should be dropped. Or at the least, it should be
>> > > split out to it's own patch and the motivations can be discussed in the
>> > > commit text.
>> >
>> > It is something I requested (although I expected this to be a
>> > different patch, and even a clarification would have been OK).
>> >
>> > One way or another, the default trigger must match the flow handler. If
>> > we set it up with IRQ_TYPE_NONE, what does it mean? The fact that
>> > IRQ_TYPE_NONE acts as a wildcard doesn't mean the handle_edge_irq flow
>> > handler is a good match for all interrupt types (it is rarely OK for
>> > level interrupts).
>>
>> I think this is a question for Thierry or Linus. I'm not sure why this
>> check was put in place in the code. I tried to dig into it really quick
>> but I didn't find anything obvious and then I gave up.
>>
>> Maybe with hierarchical irqdomains we can drop this check? I don't think
>> the gpiolib core ever uses this 'default_type' or 'handler' for anything
>> once we replace the irqdomain that's used for a particular gpiochip with
>> a custom irqdomain. The only user I see, gpiochip_irq_map(), won't ever
>> be called so it really ends up being a thing that the driver specific
>> irqdomains should check for and reject when parsing the DT and it sees
>> IRQ_TYPE_NONE come out.
>>
>> ------8<-------
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 144af0733581..fe2f7888c473 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -1922,7 +1922,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
>>          * used to configure the interrupts, as you may end up with
>>          * conflicting triggers. Tell the user, and reset to NONE.
>>          */
>> -       if (WARN(np && type != IRQ_TYPE_NONE,
>> +       if (WARN(!gpiochip->irq.domain_ops && np && type != IRQ_TYPE_NONE,
>>                  "%s: Ignoring %u default trigger\n", np->full_name, type))
>>                 type = IRQ_TYPE_NONE;
>
>Sorry for taking long time to answer... this got lost in some mail
>storms.
>
>It's a bit of Marc Z question really but I try to answer and
>he can correct me.
>
>We are now getting used to ACPI and DT always specifying
>the IRQ trigger type on the consumer handle: a device tells
>the irqchip what kind of edge or level it wants.
>
>Things weren't always like that.
>
>Some boards in the kernel is still using board files. (Yeah
>please help in modernizing them, I am doing my part.)
>
>Old machines with GPIO irqchip jitted to the SoC irq controller
>sometimes had a hardcoded behavior such as edge, and the
>consumers would only issue something really legacy
>like
>
>request_irq(42, myhandler, 0, "myirq", data);
>
>and expect it to work, since 0 means use the default flags,
>it might have a platform device with this irq number passed
>as a resource, but that is a really dumb platform device still,
>and it might not have set any irqflags for the irq number
>it passes. It probably doesn't even know that the irq number
>is backed by an irq descriptor.
>
>Since the code that e.g. DT has inside drivers/of/platform.c
>irq_of_parse_and_map(), will incidentally create an irq
>descriptor and set up these flags from the consumer flags in the
>device tree and call the irqchip to set up the trigger through
>.set_type() whenever the interrupt is requested, this is no
>problem for DT. Or ACPI.
>
>But on a board file, the .set_type() will eventually be called
>with IRQ_TYPE_NONE, which will cause a bug, or no IRQs
>or something like that.
>
>So a bunch of GPIO irqchips are created passing
>IRQ_TYPE_EDGE_* or IRQ_TYPE_LEVEL_* to set up a default
>trigger, because all the irqs on this chip use the same trigger
>anyway, and they only have one flow handler anyway.
>Everything is edge, or everything is level or so.
>irq_set_irq_type() will be called when mapping the GPIO to
>an irq, including calls from gpiod_to_irq() and friends that
>get used a lot in legacy code.
>
>This happened by simply factoring custom GPIO irqchips
>into the gpiolib over time.
>
>No-one has really gotten around to tracking down
>all the offending callers of request_irq() and their respective
>interrupt providers and make sure the descriptors for all these
>IRQs get set up properly in drivers or board files. As far
>as I know. (INTERESTING WORK!)
>
>It is a mess, really hard to fix, essentially everything need to
>be modernized or deleted for us to get rid of the possibility
>to pass a default trigger.
>
>I guess it is possible to check all gpiochip_irqchip_add*
>and see if there are still chips passing something else than
>IRQ_TYPE_NONE. It would take some time to look at all of
>them, maybe it isn't used by anything anymore? Then
>we can simply delete this and assume it will always be
>set up orderly. We have modernized quite a few systems
>recently.
>
Thanks for the explanation Linus. Here is my understanding, pls. correct
me if I am wrong.

When the GPIO irqchip is in hierarchy with GIC, as in the case here a
driver would do the following -
- Read GPIO from DT
- Request virtual IRQ number from GPIO by calling gpio_to_irq()
- Request IRQ for the virtual IRQ specifying the IRQ type etc

An example from my test code -

	// Step 1
	gpio = of_get_named_gpio(pdev->dev.of_node, "test-gpios", i);
	if (!gpio_is_valid(gpio)) {
		pr_err("Invalid GPIO for error fatal %d\n", gpio);
		return -EINVAL;
	}
	// Step 2
	irq = gpio_to_irq(gpio);
	if (irq < 0) {
		pr_err("Invalid IRQ for error fatal %u\n", irq);
		return irq;
	}
	// Step 3
	ret = request_irq(irq,  test_gpio_handler,
			  IRQF_TRIGGER_HIGH, "gpio-test", NULL);
	if (ret < 0) {
		pr_err("Unable to register for error fatal IRQ handler %d",
				irq);
		return ret;
	}

Step 1 of the above, does not record the trigger type of the GPIO
Step 2 creates the IRQ mapping without knowing the trigger type
(therefore gpiolib uses IRQ_TYPE_NONE)
Step 3 knows the TYPE and sets that the trigger type on the already
created IRQ.

I was tracing this over and i think this warrants a new solution. The
issue that I see if I hardcode a specific trigger type for the GPIO in
.to_irq(), then request_irq() fails since if the driver requests a
different trigger type. And GIC-v3 warns if the IRQ type is
IRQ_TYPE_NONE as it expects the IRQ to be defined in DT and passed to
the irqchip driver as is.

I think we need a OF GPIO lib function to do step 1 and 2 in one step,
so we could read the type correctly from the DT and request instead of
IRQ_TYPE_NONE when creating the mapping. This should avoid the warning
thrown by gic_irq_domain_translate() -

	WARN_ON(*type == IRQ_TYPE_NONE && fwspec->param[0] != GIC_IRQ_TYPE_PARTITION);

and avoid the failure thrown by irq_create_fwspec_mapping()-

	pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
		hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));

Does that sound reasonable?

Thanks,
Lina
