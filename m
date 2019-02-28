Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1545218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfB1Tlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:41:52 -0500
Received: from mailproxy07.manitu.net ([217.11.48.71]:47680 "EHLO
        mailproxy07.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfB1Tlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:41:52 -0500
Received: from [192.168.178.20] (aftr-88-217-180-92.dynamic.mnet-online.de [88.217.180.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id E15CCC8115;
        Thu, 28 Feb 2019 20:42:59 +0100 (CET)
Subject: Re: [PATCH v5 2/5] can: m_can: Migrate the m_can code to use the
 framework
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190214182754.30721-1-dmurphy@ti.com>
 <20190214182754.30721-3-dmurphy@ti.com>
 <0f5f732a-945c-da56-1086-00fb2c621331@grandegger.com>
 <639f316a-1190-1e0e-0a1d-6008a1c332d7@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <bae8adda-8cca-c865-d010-24084e13c2ce@grandegger.com>
Date:   Thu, 28 Feb 2019 20:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <639f316a-1190-1e0e-0a1d-6008a1c332d7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

Am 28.02.19 um 18:57 schrieb Dan Murphy:
> Wolfgang
> 
> On 2/28/19 11:33 AM, Wolfgang Grandegger wrote:
>> Am 14.02.19 um 19:27 schrieb Dan Murphy:
>>> Migrate the m_can code to use the m_can_platform framework
>>> code.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v5 - Updated copyright, change m_can_classdev to m_can_priv, removed extra
>>> KCONFIG flag - https://lore.kernel.org/patchwork/patch/1033095/
>>>
>>>  drivers/net/can/m_can/Kconfig  |   8 +-
>>>  drivers/net/can/m_can/Makefile |   1 +
>>>  drivers/net/can/m_can/m_can.c  | 745 ++++++++++++++++-----------------
>>>  3 files changed, 367 insertions(+), 387 deletions(-)
>>>
>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>> index 04f20dd39007..66e31022a5fa 100644
>>> --- a/drivers/net/can/m_can/Kconfig
>>> +++ b/drivers/net/can/m_can/Kconfig
>>> @@ -1,5 +1,11 @@
>>>  config CAN_M_CAN
>>> +	tristate "Bosch M_CAN support"
>>> +	---help---
>>> +	  Say Y here if you want to support for Bosch M_CAN controller.
>>
>> Typo?
>>
> 
> Maybe like you pointed out to update the help.

I was just not sure if it's correct English... but you know better!

> 
>>> +
>>> +config CAN_M_CAN_PLATFORM
>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>  	depends on HAS_IOMEM
>>> -	tristate "Bosch M_CAN devices"
>>> +	depends on CAN_M_CAN
>>>  	---help---
>>>  	  Say Y here if you want to support for Bosch M_CAN controller.
>>
>> Please update the help.
> 
> Ack
>>
>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>> index 8bbd7f24f5be..057bbcdb3c74 100644
>>> --- a/drivers/net/can/m_can/Makefile
>>> +++ b/drivers/net/can/m_can/Makefile
>>> @@ -3,3 +3,4 @@
>>>  #
>>>  
>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>> index 9b449400376b..2ceccb870557 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c
... snip ...
>>> @@ -924,6 +885,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>>>  		}
>>>  	}
>>>  
>>> +	if (priv->ops->clr_dev_interrupts)
>>> +		priv->ops->clr_dev_interrupts(priv);
>>
>> post_irq _handler?
>>
> 
> I can clear them on entry as well

OK!

...snip...

>>> -	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
>>> -					  (cccr_poll == cccr_reg), 0, 10);
>>> +	for (i = 0; i <= 10; i++) {
>>> +		cccr_poll = m_can_read(priv, M_CAN_CCCR);
>>> +		if (cccr_poll == cccr_reg)
>>> +			niso_timeout = 0;
>>> +	}
>>
>> There is no break and delay in the loop? What was the reason why you
>> can't use readl_poll_timeout()?
>>
> 
> OK a break if NISO is supported then and probably could add a 1us delay original code on
> line 1232 had no delay but timeout at 10us.
> 
> readl_poll_timeout is for iomapped devices.  How would this work for peripherial devices?

Well, it takes much more time to read the register via SPI... maybe using

	if (priv->is_peripherial) ...

to handle the different timings would make sense here.

>>>  
>>>  	/* Clear NISO */
>>>  	cccr_reg &= ~(CCCR_NISO);
>>> @@ -1242,107 +1210,95 @@ static bool m_can_niso_supported(const struct m_can_priv *priv)
>>>  	return !niso_timeout;
>>>  }
... snip...

>>> -static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>> -				    struct net_device *dev)
>>> +static void m_can_tx_handler(struct m_can_priv *priv)
>>>  {
>>> -	struct m_can_priv *priv = netdev_priv(dev);
>>> -	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>>> +	struct canfd_frame *cf = (struct canfd_frame *)priv->skb->data;
>>> +	struct net_device *dev = priv->net;
>>> +	struct sk_buff *skb = priv->skb;
>>
>> Maybe "tx_skb" is a clearer member name..
> 
> Again this was named skb to minimize deltas from original code.

I mean "priv->tx_skb"!

> skb was passed into the start_xmit function and used throughout the function.
> 
> Since there was little delta in this function I opt'd to keep the names as is.
> 

Wolfgang.
