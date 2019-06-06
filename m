Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC287C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3CB20874
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFFNVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:21:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47256 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfFFNVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:21:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 226E3374;
        Thu,  6 Jun 2019 06:21:07 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B99BE3F5AF;
        Thu,  6 Jun 2019 06:21:04 -0700 (PDT)
Date:   Thu, 6 Jun 2019 14:20:56 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     peng.fan@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jassisinghbrar@gmail.com, sudeep.holla@arm.com,
        kernel@pengutronix.de, linux-imx@nxp.com, shawnguo@kernel.org,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        van.freenix@gmail.com
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20190606142056.68272dc0@donnerap.cambridge.arm.com>
In-Reply-To: <866db682-785a-e0a6-b394-bb65c7a694c6@gmail.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <866db682-785a-e0a6-b394-bb65c7a694c6@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 09:32:42 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

Hi,

> On 6/3/19 1:30 AM, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > This mailbox driver implements a mailbox which signals transmitted data
> > via an ARM smc (secure monitor call) instruction. The mailbox receiver
> > is implemented in firmware and can synchronously return data when it
> > returns execution to the non-secure world again.
> > An asynchronous receive path is not implemented.
> > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > which either don't have a separate management processor or on which such
> > a core is not available. A user of this mailbox could be the SCP
> > interface.
> > 
> > Modified from Andre Przywara's v2 patch
> > https://lore.kernel.org/patchwork/patch/812999/
> > 
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---  
> 
> [snip]
> 
> +#define ARM_SMC_MBOX_USB_IRQ	BIT(1)
> 
> That flag appears unused.
> 
> > +static int arm_smc_mbox_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mbox_controller *mbox;
> > +	struct arm_smc_chan_data *chan_data;
> > +	const char *method;
> > +	bool use_hvc = false;
> > +	int ret, irq_count, i;
> > +	u32 val;
> > +
> > +	if (!of_property_read_u32(dev->of_node, "arm,num-chans", &val)) {
> > +		if (val < 1 || val > INT_MAX) {
> > +			dev_err(dev, "invalid arm,num-chans value %u of %pOFn\n", val, pdev->dev.of_node);

Isn't the of_node parameter redundant, because dev_err() already takes care of that?

> > +			return -EINVAL;
> > +		}
> > +	}  
> 
> Should not the upper bound check be done against UINT_MAX since val is
> an unsigned int?

But wouldn't that be somewhat pointless, given that val is a u32? So I
guess we could just condense this down to:
...
		if (!val) {
...

> > +
> > +	irq_count = platform_irq_count(pdev);
> > +	if (irq_count == -EPROBE_DEFER)
> > +		return irq_count;
> > +
> > +	if (irq_count && irq_count != val) {
> > +		dev_err(dev, "Interrupts not match num-chans\n");  
> 
> Interrupts property does not match \"arm,num-chans\" would be more correct.

Given that interrupts are optional, do we have to rely on this? Do we
actually need one interrupt per channel?

> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!of_property_read_string(dev->of_node, "method", &method)) {
> > +		if (!strcmp("hvc", method)) {
> > +			use_hvc = true;
> > +		} else if (!strcmp("smc", method)) {
> > +			use_hvc = false;
> > +		} else {
> > +			dev_warn(dev, "invalid \"method\" property: %s\n",
> > +				 method);
> > +
> > +			return -EINVAL;
> > +		}  
> 
> Having at least one method specified does not seem to be checked later
> on in the code, so if I omitted to specify that property, we would still
> register the mailbox and default to use "smc" since the
> ARM_SMC_MBOX_USE_HVC flag would not be set, would not we want to make
> sure that we do have in fact a valid method specified given the binding
> documents that property as mandatory?
> 
> [snip]
> 
> > +	mbox->txdone_poll = false;
> > +	mbox->txdone_irq = false;
> > +	mbox->ops = &arm_smc_mbox_chan_ops;
> > +	mbox->dev = dev;
> > +
> > +	ret = mbox_controller_register(mbox);
> > +	if (ret)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, mbox);  
> 
> I would move this above mbox_controller_register() that way there is no
> room for race conditions in case another part of the driver expects to
> have pdev->dev.drvdata set before the mbox controller is registered.
> Since you use devm_* functions for everything, you may even remove that
> call.
> 
> [snip]
> 
> > +#ifndef _LINUX_ARM_SMC_MAILBOX_H_
> > +#define _LINUX_ARM_SMC_MAILBOX_H_
> > +
> > +struct arm_smccc_mbox_cmd {
> > +	unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
> > +};  
> 
> Do you expect this to be used by other in-kernel users? If so, it might
> be good to document how a0 can have a special meaning and be used as a
> substitute for the function_id?

I don't think we should really expose this outside of the driver. From a mailbox point of view this is just the payload, transported according to the SMCCC. Also using "long" here sounds somewhat troublesome.

Also, looking at the SMCCC, I only see six parameters in addition to the function identifier. Shall we reflect this here?

Cheers,
Andre.

