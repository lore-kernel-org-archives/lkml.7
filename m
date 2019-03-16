Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E02C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CC2218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCPLjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:39:55 -0400
Received: from foss.arm.com ([217.140.101.70]:41182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfCPLjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:39:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E1D51596;
        Sat, 16 Mar 2019 04:39:54 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CF3F3F614;
        Sat, 16 Mar 2019 04:39:52 -0700 (PDT)
Date:   Sat, 16 Mar 2019 11:39:48 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
Message-ID: <20190316113948.1d180259@why.wild-wind.fr.eu.org>
In-Reply-To: <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
References: <20190313211844.29416-1-ilina@codeaurora.org>
        <20190313211844.29416-8-ilina@codeaurora.org>
        <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 09:28:31 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Lina Iyer (2019-03-13 14:18:41)
> > ---
> > Changes in v4:
> >         - Remove irq_set_wake() on summary IRQ interrupt
> > Changes in v3:
> >         - Use of_irq_domain_map() and pass PDC pin to parent irqdomain
> > Changes in v2:
> >         - Call parent mask when masking GPIO interrupt
> > Changes in v1:
> >         - Fix bug when unmasking PDC interrupt  
> [...]
> > +}
> > +
> > +/*
> > + * TODO: Get rid of this and push it into gpiochip_to_irq()
> > + */  
> 
> Any chance this TODO can be resolved?
> 
> > @@ -994,6 +1092,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
> >         pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
> >         pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
> >  
> > +       chip->irq.chip = &pctrl->irq_chip;
> > +       chip->irq.domain_ops = &msm_gpio_domain_ops;
> > +       chip->irq.handler = handle_edge_irq;
> > +       chip->irq.default_type = IRQ_TYPE_EDGE_RISING;  
> 
> This also changed from v3. It used to be IRQ_TYPE_NONE. Specifying this
> here seems to cause gpiolib to print a WARN.
> 
> 
>         /*
>          * Specifying a default trigger is a terrible idea if DT or ACPI is
>          * used to configure the interrupts, as you may end up with
>          * conflicting triggers. Tell the user, and reset to NONE.
>          */
>         if (WARN(np && type != IRQ_TYPE_NONE,
>                  "%s: Ignoring %u default trigger\n", np->full_name, type))
>                 type = IRQ_TYPE_NONE;
> 
> 
> So I guess this change should be dropped. Or at the least, it should be
> split out to it's own patch and the motivations can be discussed in the
> commit text.

It is something I requested (although I expected this to be a
different patch, and even a clarification would have been OK).

One way or another, the default trigger must match the flow handler. If
we set it up with IRQ_TYPE_NONE, what does it mean? The fact that
IRQ_TYPE_NONE acts as a wildcard doesn't mean the handle_edge_irq flow
handler is a good match for all interrupt types (it is rarely OK for
level interrupts).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
