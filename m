Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641662075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PcMq9iW0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CPHfzsx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfDPV0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:26:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:26:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79D6960F3C; Tue, 16 Apr 2019 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555450006;
        bh=fOhYUhfsIJPeehxvWGTsKU0jH3dtNUtmltPYktKQyVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcMq9iW0RgggPk23HLMAlGAGAA3X5vxETW+QAWTVf06bM2hBvBnL+aSVjoIAJCW8G
         VcH8iOYeS5JOFstusV+bRI3QdcShP1Bw284YrCNsltI9TSV8tAsZUDDZ6kgsRt49qQ
         1y2y/UjbY7z2DIFVjiDkFq0SnF4hMy48jcVgXsDU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FAF260746;
        Tue, 16 Apr 2019 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555450005;
        bh=fOhYUhfsIJPeehxvWGTsKU0jH3dtNUtmltPYktKQyVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPHfzsx1VQDdREqjE+JMmPRdCa2pA8TLSN4BQwT7HAGpzwCixeLyDsHSIywYIGipW
         2DxLZixWVSS66Np+RQyVd9S99rs5VlmyOZ3E8d9MUBBkSO+odhk8G8dqUyiYRN4cei
         Khs/Vv9H63TIl6+T6xHdUHmoH4o4fzhplrakI5/Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FAF260746
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 16 Apr 2019 15:26:44 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
Message-ID: <20190416212644.GD16124@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-8-ilina@codeaurora.org>
 <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
 <20190316113948.1d180259@why.wild-wind.fr.eu.org>
 <155320527587.20095.3351235428610314272@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155320527587.20095.3351235428610314272@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21 2019 at 15:54 -0600, Stephen Boyd wrote:
>Quoting Marc Zyngier (2019-03-16 04:39:48)
>> On Fri, 15 Mar 2019 09:28:31 -0700
>> Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> > Quoting Lina Iyer (2019-03-13 14:18:41)
>> > > @@ -994,6 +1092,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>> > >         pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
>> > >         pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>> > >
>> > > +       chip->irq.chip = &pctrl->irq_chip;
>> > > +       chip->irq.domain_ops = &msm_gpio_domain_ops;
>> > > +       chip->irq.handler = handle_edge_irq;
>> > > +       chip->irq.default_type = IRQ_TYPE_EDGE_RISING;
>> >
>> > This also changed from v3. It used to be IRQ_TYPE_NONE. Specifying this
>> > here seems to cause gpiolib to print a WARN.
>> >
>> >
>> >         /*
>> >          * Specifying a default trigger is a terrible idea if DT or ACPI is
>> >          * used to configure the interrupts, as you may end up with
>> >          * conflicting triggers. Tell the user, and reset to NONE.
>> >          */
>> >         if (WARN(np && type != IRQ_TYPE_NONE,
>> >                  "%s: Ignoring %u default trigger\n", np->full_name, type))
>> >                 type = IRQ_TYPE_NONE;
>> >
>> >
>> > So I guess this change should be dropped. Or at the least, it should be
>> > split out to it's own patch and the motivations can be discussed in the
>> > commit text.
>>
>> It is something I requested (although I expected this to be a
>> different patch, and even a clarification would have been OK).
>>
>> One way or another, the default trigger must match the flow handler. If
>> we set it up with IRQ_TYPE_NONE, what does it mean? The fact that
>> IRQ_TYPE_NONE acts as a wildcard doesn't mean the handle_edge_irq flow
>> handler is a good match for all interrupt types (it is rarely OK for
>> level interrupts).
>
>I think this is a question for Thierry or Linus. I'm not sure why this
>check was put in place in the code. I tried to dig into it really quick
>but I didn't find anything obvious and then I gave up.
>
>Maybe with hierarchical irqdomains we can drop this check? I don't think
>the gpiolib core ever uses this 'default_type' or 'handler' for anything
>once we replace the irqdomain that's used for a particular gpiochip with
>a custom irqdomain. The only user I see, gpiochip_irq_map(), won't ever
>be called so it really ends up being a thing that the driver specific
>irqdomains should check for and reject when parsing the DT and it sees
>IRQ_TYPE_NONE come out.
>
>------8<-------
>diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>index 144af0733581..fe2f7888c473 100644
>--- a/drivers/gpio/gpiolib.c
>+++ b/drivers/gpio/gpiolib.c
>@@ -1922,7 +1922,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
> 	 * used to configure the interrupts, as you may end up with
> 	 * conflicting triggers. Tell the user, and reset to NONE.
> 	 */
>-	if (WARN(np && type != IRQ_TYPE_NONE,
>+	if (WARN(!gpiochip->irq.domain_ops && np && type != IRQ_TYPE_NONE,
> 		 "%s: Ignoring %u default trigger\n", np->full_name, type))
> 		type = IRQ_TYPE_NONE;
>
Linus,

Any thoughts on this?

-- Lina

