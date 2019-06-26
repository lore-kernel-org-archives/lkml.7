Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8D0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B10C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFZRF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:05:56 -0400
Received: from foss.arm.com ([217.140.110.172]:37366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZRFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:05:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A682B;
        Wed, 26 Jun 2019 10:05:53 -0700 (PDT)
Received: from [192.168.3.111] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 248973F706;
        Wed, 26 Jun 2019 10:05:52 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
To:     Peng Fan <peng.fan@nxp.com>, Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
 <AM0PR04MB4481210CE83416353575C3D988E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <20c6cd30-642d-5f6e-15b8-2ef925ed90a6@arm.com>
Date:   Wed, 26 Jun 2019 18:05:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481210CE83416353575C3D988E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2019 08:20, Peng Fan wrote:
> Hi Jassi,
> 
>> -----Original Message-----
>> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>> Sent: 2019年6月21日 0:50
>> To: Peng Fan <peng.fan@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
>> <mark.rutland@arm.com>; Sudeep Holla <sudeep.holla@arm.com>; Florian
>> Fainelli <f.fainelli@gmail.com>; , Sascha Hauer <kernel@pengutronix.de>;
>> dl-linux-imx <linux-imx@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
>> festevam@gmail.com; Devicetree List <devicetree@vger.kernel.org>; Linux
>> Kernel Mailing List <linux-kernel@vger.kernel.org>;
>> linux-arm-kernel@lists.infradead.org; Andre Przywara
>> <andre.przywara@arm.com>; van.freenix@gmail.com
>> Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
>>
>> On Mon, Jun 3, 2019 at 3:28 AM <peng.fan@nxp.com> wrote:
>>>
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> This mailbox driver implements a mailbox which signals transmitted
>>> data via an ARM smc (secure monitor call) instruction. The mailbox
>>> receiver is implemented in firmware and can synchronously return data
>>> when it returns execution to the non-secure world again.
>>> An asynchronous receive path is not implemented.
>>> This allows the usage of a mailbox to trigger firmware actions on SoCs
>>> which either don't have a separate management processor or on which
>>> such a core is not available. A user of this mailbox could be the SCP
>>> interface.
>>>
>>> Modified from Andre Przywara's v2 patch
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
>>> .kernel.org%2Fpatchwork%2Fpatch%2F812999%2F&amp;data=02%7C01%7
>> Cpeng.fa
>>>
>> n%40nxp.com%7C1237677cb01044ad714508d6f59f648f%7C686ea1d3bc2b4
>> c6fa92cd
>>>
>> 99c5c301635%7C0%7C0%7C636966462272457978&amp;sdata=Hzgeu43m5
>> ZkeRMtL8Bx
>>> gUm3%2B6FBObib1OPHPlSccE%2B0%3D&amp;reserved=0
>>>
>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V2:
>>>  Add interrupts notification support.
>>>
>>>  drivers/mailbox/Kconfig                 |   7 ++
>>>  drivers/mailbox/Makefile                |   2 +
>>>  drivers/mailbox/arm-smc-mailbox.c       | 190
>> ++++++++++++++++++++++++++++++++
>>>  include/linux/mailbox/arm-smc-mailbox.h |  10 ++
>>>  4 files changed, 209 insertions(+)
>>>  create mode 100644 drivers/mailbox/arm-smc-mailbox.c  create mode
>>> 100644 include/linux/mailbox/arm-smc-mailbox.h
>>>
>>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
>>> 595542bfae85..c3bd0f1ddcd8 100644
>>> --- a/drivers/mailbox/Kconfig
>>> +++ b/drivers/mailbox/Kconfig
>>> @@ -15,6 +15,13 @@ config ARM_MHU
>>>           The controller has 3 mailbox channels, the last of which can be
>>>           used in Secure mode only.
>>>
>>> +config ARM_SMC_MBOX
>>> +       tristate "Generic ARM smc mailbox"
>>> +       depends on OF && HAVE_ARM_SMCCC
>>> +       help
>>> +         Generic mailbox driver which uses ARM smc calls to call into
>>> +         firmware for triggering mailboxes.
>>> +
>>>  config IMX_MBOX
>>>         tristate "i.MX Mailbox"
>>>         depends on ARCH_MXC || COMPILE_TEST diff --git
>>> a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile index
>>> c22fad6f696b..93918a84c91b 100644
>>> --- a/drivers/mailbox/Makefile
>>> +++ b/drivers/mailbox/Makefile
>>> @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)      += mailbox-test.o
>>>
>>>  obj-$(CONFIG_ARM_MHU)  += arm_mhu.o
>>>
>>> +obj-$(CONFIG_ARM_SMC_MBOX)     += arm-smc-mailbox.o
>>> +
>>>  obj-$(CONFIG_IMX_MBOX) += imx-mailbox.o
>>>
>>>  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)    +=
>> armada-37xx-rwtm-mailbox.o
>>> diff --git a/drivers/mailbox/arm-smc-mailbox.c
>>> b/drivers/mailbox/arm-smc-mailbox.c
>>> new file mode 100644
>>> index 000000000000..fef6e38d8b98
>>> --- /dev/null
>>> +++ b/drivers/mailbox/arm-smc-mailbox.c
>>> @@ -0,0 +1,190 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2016,2017 ARM Ltd.
>>> + * Copyright 2019 NXP
>>> + */
>>> +
>>> +#include <linux/arm-smccc.h>
>>> +#include <linux/device.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/mailbox_controller.h> #include
>>> +<linux/mailbox/arm-smc-mailbox.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +#define ARM_SMC_MBOX_USE_HVC   BIT(0)
>>> +#define ARM_SMC_MBOX_USB_IRQ   BIT(1)
>>> +
>> IRQ bit is unused (and unnecessary IMO)
> 
> This will be removed in next version.
> 
>>
>>> +struct arm_smc_chan_data {
>>> +       u32 function_id;
>>> +       u32 flags;
>>> +       int irq;
>>> +};
>>> +
>>> +static int arm_smc_send_data(struct mbox_chan *link, void *data) {
>>> +       struct arm_smc_chan_data *chan_data = link->con_priv;
>>> +       struct arm_smccc_mbox_cmd *cmd = data;
>>> +       struct arm_smccc_res res;
>>> +       u32 function_id;
>>> +
>>> +       if (chan_data->function_id != UINT_MAX)
>>> +               function_id = chan_data->function_id;
>>> +       else
>>> +               function_id = cmd->a0;
>>> +
>> Not sure about chan_data->function_id.  Why restrict from DT?
>> 'a0' is the function_id register, let the user pass func-id via the 'a0' like other
>> values via 'a[1-7]'
>>
>>
>>> +       if (chan_data->flags & ARM_SMC_MBOX_USE_HVC)
>>> +               arm_smccc_hvc(function_id, cmd->a1, cmd->a2,
>> cmd->a3, cmd->a4,
>>> +                             cmd->a5, cmd->a6, cmd->a7, &res);
>>> +       else
>>> +               arm_smccc_smc(function_id, cmd->a1, cmd->a2,
>> cmd->a3, cmd->a4,
>>> +                             cmd->a5, cmd->a6, cmd->a7, &res);
>>> +
>>> +       if (chan_data->irq)
>>> +               return 0;
>>> +
>> This irq thing seems like oob signalling, that is, a protocol thing.
>> And then it provides lesser info via chan_irq_handler (returns NULL) than
>> res.a0 - which can always be ignored if not needed.
>> So the irq should be implemented in the upper layer if the protocol needs it.
> 
> The interrupts was added here because in v1, Florian suggest
> "
> I would just put a
> provision in the binding to support an optional interrupt such that
> asynchronism gets reasonably easy to plug in when it is available (and
> desirable).
> "
> 
> So I introduced interrupt in V2. In my testcase, after smc call done,
> it means firmware->smc mailbox->firmware done. Interrupt notification
> from firmware->Linux, means firmware has done the operation.
> 
> When using interrupts, we could not know res.a0 as smc sync call.
> 
> Interrupts is not a must in my testcase, Florian, Andre, do you have
> any comments? Should I keep interrupts in V3 or drop it as Jassi comments?

The smc mailbox is by its very design a one-way channel - and it's
synchronous. I think this is all the mailbox driver should be concerned
about. The fact that there is a protocol user that would benefit from a
return channel is a separate issue.
The SCMI binding explicitly mentions *two* mailboxes, one TX, one RX, so
the return channel could be very well implemented by a separate driver.
I am wondering if we get away without a functioning return channel, at
least for a subset of SCMI functionality? Can we use some dummy driver?
Or specify another smc channel with some unhandled/ignored channel ID
for that purpose?

So I would leave the IRQ return channel out for now, unless we
desperately need it.

Cheers,
Andre.
