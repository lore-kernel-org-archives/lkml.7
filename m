Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FAAC46460
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B990921655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="k/vXWgUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfEHNso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:48:44 -0400
Received: from node.akkea.ca ([192.155.83.177]:36446 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfEHNso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:48:44 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 9B7234E204B; Wed,  8 May 2019 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557323323; bh=SKj/DNrvkazDxcFBqphuIYlPgfO+U4yhSZPmkX4DW10=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=k/vXWgUIbCxjgEglHBOKfalx0V8B+86U7nnpXBGF666BoYzW8H0+9Z9evXXXMG3qe
         OHKvVA8IHwCzVOVLrHb3Zuv7gXHFoIIfiSjLTzFaXRlUAx4wFN+qzittAWfySzp/UY
         nLJtpkGck0gaz8PsyWVcHcDLJwJQZ0x9wmk9CWdY=
To:     Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] usb: typec: tcpci: Clear the fault status register
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 08 May 2019 07:48:43 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>, linux-imx@nxp.com
In-Reply-To: <3918f78b-15ec-9204-b2fc-f371157bc29c@roeck-us.net>
References: <20190508002749.14816-1-angus@akkea.ca>
 <20190508002749.14816-2-angus@akkea.ca>
 <aed487a4-3f7c-55e8-9c84-feaa1c7f583d@roeck-us.net>
 <3fd046562f3bea2cb85354f8d3c420fc@www.akkea.ca>
 <3918f78b-15ec-9204-b2fc-f371157bc29c@roeck-us.net>
Message-ID: <b1e568714632bc3be89f1452299873d2@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

On 2019-05-07 23:18, Guenter Roeck wrote:
> On 5/7/19 7:49 PM, Angus Ainslie wrote:
>> On 2019-05-07 20:03, Guenter Roeck wrote:
>>> On 5/7/19 5:27 PM, Angus Ainslie (Purism) wrote:
>>>> If the fault status register doesn't get cleared then
>>>> the ptn5110 interrupt gets stuck on. As the fault register gets
>>>> set everytime the ptn5110 powers on the interrupt is always stuck.
>>>> 
>>>> Fixes: fault status register stuck
>>>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>>>> ---
>>>>   drivers/usb/typec/tcpm/tcpci.c | 11 +++++++++++
>>>>   1 file changed, 11 insertions(+)
>>>> 
>>>> diff --git a/drivers/usb/typec/tcpm/tcpci.c 
>>>> b/drivers/usb/typec/tcpm/tcpci.c
>>>> index c1f7073a56de..a5746657b190 100644
>>>> --- a/drivers/usb/typec/tcpm/tcpci.c
>>>> +++ b/drivers/usb/typec/tcpm/tcpci.c
>>>> @@ -463,6 +463,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>>>>       else if (status & TCPC_ALERT_TX_FAILED)
>>>>           tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
>>>>   +    if (status & TCPC_ALERT_FAULT) {
>>> 
>>> Wait - the driver doesn't set TCPC_ALERT_FAULT in the alert mask
>>> register. How can the chip report it if fault alerts are not enabled 
>>> ?
>> 
>> Well that I didn't check. But I know this code gets executed so 
>> something must be turning it on.
>> 
>> Also if I don't clear it I get an unlimited number of interrupts.
>> 
>>> What am I missing here ?
>> 
>> Can the power on fault be masked ?
>> 
> 
> There is a TCPC_ALERT_FAULT mask bit, so I would think so.
> Can you dump register contents in the irq function and at the end of
> tcpci_init() ?
> 

Ok so this seems to be related to imx8mq errata e7805:

I2C: When the I2C clock speed is configured for 400 kHz, the SCL low 
period violates the I2C spec of
1.3 uS min

The work around suggested by NXP is to set the clock to 384 kHz so that 
is what I did and this is the output:

[    4.091512] device: 'tcpm-source-psy-0-0052': device_add
[    4.091581] PM: Adding info for No Bus:tcpm-source-psy-0-0052
[    4.091596] device: 'tcpm-source-psy-0-0052': dev_uevent: class 
uevent() returned -11
[    4.094774] tcpci 0-0052: ALERT MASK 0x7f
[    4.107869] driver: 'tcpci': driver_bound: bound to device '0-0052'
[    4.107935] bus: 'i2c': really_probe: bound device 0-0052 to driver 
tcpci
[    4.110994] tcpci 0-0052: ALERT MASK 0x7f
[    4.115511] tcpci 0-0052: FAULT ALERT status 0x80
[    4.126332] tcpci 0-0052: ALERT MASK 0x7f
[    4.130784] tcpci 0-0052: FAULT ALERT status 0x0

The first "ALERT MASK" is in the init function immediately after setting

         reg = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_FAILED |
                 TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_RX_STATUS |
                 TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;
         if (tcpci->controls_vbus)
                 reg |= TCPC_ALERT_POWER_STATUS;
         ret = tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);


So it looks like the register is correct but the fault interrupt still 
fires. At 200 kHz I get the following output.

[    4.136845] device: 'tcpm-source-psy-0-0052': device_add
[    4.136943] PM: Adding info for No Bus:tcpm-source-psy-0-0052
[    4.136966] device: 'tcpm-source-psy-0-0052': dev_uevent: class 
uevent() returned -11
[    4.178510] tcpci 0-0052: ALERT MASK 0x7f
[    4.217197] driver: 'tcpci': driver_bound: bound to device '0-0052'
[    4.217371] bus: 'i2c': really_probe: bound device 0-0052 to driver 
tcpci

So this is what is expected no fault interrupt.

Maybe errata e7805 needs an update.

Sorry for the noise.

Cheers
Angus


> Thanks,
> Guenter
> 
>> Angus
>> 
>>> 
>>> Thanks,
>>> Guenter
>>> 
>>>> +        u16 fault_status;
>>>> +
>>>> +        tcpci_read16(tcpci, TCPC_FAULT_STATUS, &fault_status);
>>>> +
>>>> +        dev_warn(tcpci->dev, "FAULT ALERT status 0x%x\n", 
>>>> fault_status);
>>>> +
>>>> +        /* clear the fault status */
>>>> +        tcpci_write16(tcpci, TCPC_FAULT_STATUS, fault_status);
>>>> +    }
>>>> +
>>>>       return IRQ_HANDLED;
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(tcpci_irq);
>>>> 
>> 
>> 

