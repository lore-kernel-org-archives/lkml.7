Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2CCC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5B021907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfIRN6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:58:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfIRN6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:58:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 331341000;
        Wed, 18 Sep 2019 06:58:37 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFDE23F67D;
        Wed, 18 Sep 2019 06:58:35 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:58:32 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20190918145832.0bb72e16@donnerap.cambridge.arm.com>
In-Reply-To: <CABb+yY2G8s9gV8Pu+f__8-bubjCJsVQrQikbVMZXmpTwSMBxiQ@mail.gmail.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
        <1568626884-5189-3-git-send-email-peng.fan@nxp.com>
        <20190917183856.2342beed@donnerap.cambridge.arm.com>
        <AM0PR04MB44813D62FF7E6762BB17460E888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <20190918110037.4edefb2f@donnerap.cambridge.arm.com>
        <CABb+yY2G8s9gV8Pu+f__8-bubjCJsVQrQikbVMZXmpTwSMBxiQ@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 08:31:57 -0500
Jassi Brar <jassisinghbrar@gmail.com> wrote:

Hi,

> On Wed, Sep 18, 2019 at 5:00 AM Andre Przywara <andre.przywara@arm.com> wrote:
> 
> > >  
> > > >  
> > > > > + };
> > > > > +};  
> > > >
> > > > If this is the data structure that this mailbox controller uses, I would expect
> > > > this to be documented somewhere, or even exported.  
> > >
> > > Export this structure in include/linux/mailbox/smc-mailbox.h?  
> >
> > For instance, even though I am not sure this is really desired or helpful, since we expect a generic mailbox client (the SCPI or SCMI driver) to deal with that mailbox.
> >
> > But at least the expected format should be documented, which could just be in writing, not necessarily in code.
> >  
> Yes, the packet format is specified by the controller and defined in
> some header for clients to include. Other platforms do that already.

Yeah, I saw some examples as well, but not every driver was following this apparently.
I guess since we have a fixed data format we should export the struct then, maybe with a remark that the actual usage of registers is up to the protocol (within the SMCCC limits), so is optional.

> > > > > +
> > > > > +typedef unsigned long (smc_mbox_fn)(unsigned int, unsigned long,
> > > > > +                             unsigned long, unsigned long,
> > > > > +                             unsigned long, unsigned long,
> > > > > +                             unsigned long);
> > > > > +static smc_mbox_fn *invoke_smc_mbox_fn;
> > > > > +
> > > > > +static int arm_smc_send_data(struct mbox_chan *link, void *data) {
> > > > > + struct arm_smc_chan_data *chan_data = link->con_priv;
> > > > > + struct arm_smccc_mbox_cmd *cmd = data;
> > > > > + unsigned long ret;
> > > > > + u32 function_id;
> > > > > +
> > > > > + function_id = chan_data->function_id;
> > > > > + if (!function_id)
> > > > > +         function_id = cmd->function_id;
> > > > > +
> > > > > + if (function_id & BIT(30)) {  
> > > >
> > > >     if (ARM_SMCCC_IS_64(function_id)) {  
> > >
> > > ok
> > >  
> > > >  
> > > > > +         ret = invoke_smc_mbox_fn(function_id, cmd->args_smccc64[0],
> > > > > +                                  cmd->args_smccc64[1],
> > > > > +                                  cmd->args_smccc64[2],
> > > > > +                                  cmd->args_smccc64[3],
> > > > > +                                  cmd->args_smccc64[4],
> > > > > +                                  cmd->args_smccc64[5]);
> > > > > + } else {
> > > > > +         ret = invoke_smc_mbox_fn(function_id, cmd->args_smccc32[0],
> > > > > +                                  cmd->args_smccc32[1],
> > > > > +                                  cmd->args_smccc32[2],
> > > > > +                                  cmd->args_smccc32[3],
> > > > > +                                  cmd->args_smccc32[4],
> > > > > +                                  cmd->args_smccc32[5]);
> > > > > + }
> > > > > +
> > > > > + mbox_chan_received_data(link, (void *)ret);
> > > > > +
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > +static unsigned long __invoke_fn_hvc(unsigned int function_id,
> > > > > +                              unsigned long arg0, unsigned long arg1,
> > > > > +                              unsigned long arg2, unsigned long arg3,
> > > > > +                              unsigned long arg4, unsigned long arg5) {
> > > > > + struct arm_smccc_res res;
> > > > > +
> > > > > + arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4,
> > > > > +               arg5, 0, &res);
> > > > > + return res.a0;
> > > > > +}
> > > > > +
> > > > > +static unsigned long __invoke_fn_smc(unsigned int function_id,
> > > > > +                              unsigned long arg0, unsigned long arg1,
> > > > > +                              unsigned long arg2, unsigned long arg3,
> > > > > +                              unsigned long arg4, unsigned long arg5) {
> > > > > + struct arm_smccc_res res;
> > > > > +
> > > > > + arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4,
> > > > > +               arg5, 0, &res);
> > > > > + return res.a0;
> > > > > +}
> > > > > +
> > > > > +static const struct mbox_chan_ops arm_smc_mbox_chan_ops = {
> > > > > + .send_data      = arm_smc_send_data,
> > > > > +};
> > > > > +
> > > > > +static int arm_smc_mbox_probe(struct platform_device *pdev) {
> > > > > + struct device *dev = &pdev->dev;
> > > > > + struct mbox_controller *mbox;
> > > > > + struct arm_smc_chan_data *chan_data;
> > > > > + int ret;
> > > > > + u32 function_id = 0;
> > > > > +
> > > > > + if (of_device_is_compatible(dev->of_node, "arm,smc-mbox"))
> > > > > +         invoke_smc_mbox_fn = __invoke_fn_smc;
> > > > > + else
> > > > > +         invoke_smc_mbox_fn = __invoke_fn_hvc;
> > > > > +
> > > > > + mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> > > > > + if (!mbox)
> > > > > +         return -ENOMEM;
> > > > > +
> > > > > + mbox->num_chans = 1;
> > > > > + mbox->chans = devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
> > > > > + if (!mbox->chans)
> > > > > +         return -ENOMEM;
> > > > > +
> > > > > + chan_data = devm_kzalloc(dev, sizeof(*chan_data), GFP_KERNEL);
> > > > > + if (!chan_data)
> > > > > +         return -ENOMEM;
> > > > > +
> > > > > + of_property_read_u32(dev->of_node, "arm,func-id", &function_id);
> > > > > + chan_data->function_id = function_id;
> > > > > +
> > > > > + mbox->chans->con_priv = chan_data;
> > > > > +
> > > > > + mbox->txdone_poll = false;
> > > > > + mbox->txdone_irq = false;  
> > > >
> > > > Don't we need to provide something to confirm reception to the client? In our
> > > > case we can set this as soon as the smc/hvc returns.  
> > >
> > > As smc/hvc returns, it means the transfer is over and receive is done.  
> >
> > I understand that, but was wondering if the Linux mailbox framework knows about that? In my older version I was calling mbox_chan_received_data() after the smc call returned.
> >  
> The code already does that at the end of  send_data

True, for some reason I totally missed that line, sorry for that.
 
> > Also there is mbox_chan_txdone() with which a controller driver can signal TX completion explicitly.
> >  
> No. Controller can use that only if it has specified txdone_irq, which
> is not the case here.

I see. So does the framework handle the case where both txdone_poll and txdone_irq are false?

Cheers,
Andre.
