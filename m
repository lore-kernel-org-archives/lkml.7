Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E9C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810322469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfKLLYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:24:20 -0500
Received: from foss.arm.com ([217.140.110.172]:60540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfKLLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:24:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 088E831B;
        Tue, 12 Nov 2019 03:24:19 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A44EA3F6C4;
        Tue, 12 Nov 2019 03:24:17 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:24:14 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V10 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20191112112414.10f3f88e@donnerap.cambridge.arm.com>
In-Reply-To: <2c8fa412-33c2-57c7-20b7-37b3b70ce524@gmail.com>
References: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
 <1569824287-4263-3-git-send-email-peng.fan@nxp.com>
 <2c8fa412-33c2-57c7-20b7-37b3b70ce524@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 09:32:43 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

Hi Florian,

> On 9/29/19 11:20 PM, Peng Fan wrote:
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
> 
> Sorry for not spotting this, or rather asking this earlier, but I do
> have one question below.
> 
> [snip]
> 
> > +static int arm_smc_send_data(struct mbox_chan *link, void *data)
> > +{
> > +	struct arm_smc_chan_data *chan_data = link->con_priv;
> > +	struct arm_smccc_mbox_cmd *cmd = data;
> > +	unsigned long ret;
> > +
> > +	if (ARM_SMCCC_IS_64(chan_data->function_id)) {
> > +		ret = chan_data->invoke_smc_mbox_fn(chan_data->function_id,
> > +						    cmd->args_smccc64[0],
> > +						    cmd->args_smccc64[1],
> > +						    cmd->args_smccc64[2],
> > +						    cmd->args_smccc64[3],
> > +						    cmd->args_smccc64[4],
> > +						    cmd->args_smccc64[5]);
> > +	} else {
> > +		ret = chan_data->invoke_smc_mbox_fn(chan_data->function_id,
> > +						    cmd->args_smccc32[0],
> > +						    cmd->args_smccc32[1],
> > +						    cmd->args_smccc32[2],
> > +						    cmd->args_smccc32[3],
> > +						    cmd->args_smccc32[4],
> > +						    cmd->args_smccc32[5]);
> > +	}  
> 
> Why did not we use unsigned long for the args_smccc[] array to be bit
> width independent, this is what the PSCI infrastructure does and it
> looks a lot nicer IMHO. More question below.

Huh, interestingly I think this comes from the combination of the two problems you point out, which evolved separately:
Earlier we had no exported interface between the transport driver and the mailbox client, just a void pointer. So using "long" in the structure would not work, because it would behave differently between arm32 and arm64 kernels. But the firmware interface would always be fixed to one of the two calling conventions, regardless of the kernel "bitness", as advertised by the upper bits of the function ID.
So we introduced explicit types that are used depending on the firmware-advertised calling convention. The idea was that any packed data any client would provide would always end up in consecutive registers in the firmware.
Now we explicitly advertise the expected message structure in the new header file, so we could go back to unsigned long here, indeed. A 32-bit kernel could never use the 64-bit calling convention, so long would fit. In a 64-bit kernel the compiler would either downgrade the long argument to the 32-bit arguments the firmware expects, or keep it long.
So it might be worth a short to go back to long.

> 
> [snip]
> 
> > +
> > +#ifndef _LINUX_ARM_SMCCC_MBOX_H_
> > +#define _LINUX_ARM_SMCCC_MBOX_H_
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * struct arm_smccc_mbox_cmd - ARM SMCCC message structure
> > + * @args_smccc32/64:	actual usage of registers is up to the protocol
> > + *			(within the SMCCC limits)
> > + */
> > +struct arm_smccc_mbox_cmd {
> > +	union {
> > +		u32 args_smccc32[6];
> > +		u64 args_smccc64[6];
> > +	};
> > +};  
> 
> Why is this being moved to a separate header file and not within the
> driver's main file? It is not like we offer the ability for a driver to
> embed this ARM SMC mailbox driver as a library, and customize the values
> of the SMC arguments (maybe we should do that, as a later patch) except
> for the function_id.

I wouldn't call it a "library", but indeed we expose the transport protocol to the mailbox client. It seems that the mailbox framework is not really clear here, it just states that (at least in many cases) the mailbox client knows about the transport protocol, even though the separation between the two suggests otherwise. This probably stems back from the days, where mailboxes were directly used by their users, without providing any kind of abstraction.
So going with this, the SMC mailbox transport driver enforces a specific transport protocol for the payload, namely the six SMCCC defined registers. So we make this available, so any mailbox client knows what to expect. At the end of the day on the other end there will be some firmware probably expecting specific data in specific registers - or no data at all, as in the simple doorbell case we intend to use for SCPI/SCMI.

> If you have a "public" header, there is usually a
> service or some configuration that your driver would offer, which is not
> the case here.

If you want to use the mailbox just as a doorbell (as in our case), it doesn't matter, so we can as well expose the underlying transport protocol.

Cheers,
Andre.
