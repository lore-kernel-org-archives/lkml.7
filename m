Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170032070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JdC/wqP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfCDTMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:12:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54454 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:12:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x24JCh6f091953;
        Mon, 4 Mar 2019 13:12:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551726763;
        bh=tnzJ5+2wjPcdVBoXDlvuLvsY0D+m3CLeO7LorOB7Wp8=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=JdC/wqP6oxAOsM3xTpfYgGnpKow8vefO1Q4cPBfZCzK+B2fjmM6cfmgG4nRmc+R/0
         Blh1uyRBMW6qZ8ntHfxL4q2F+DnNO8jPAcOeoLEg0ZaG3NC3XxPms0JTAL7VqN5Ilh
         F5xzcn5O8gS+yEBLlMqzbExvTdaLc+pr8+7xOz50=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x24JChtF034475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 13:12:43 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Mar 2019 13:12:42 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Mar 2019 13:12:42 -0600
Received: from [172.22.87.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x24JCgxg030442;
        Mon, 4 Mar 2019 13:12:42 -0600
From:   Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v6 1/4] can: m_can: Create a m_can platform framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190301185043.9037-1-dmurphy@ti.com>
 <7ffc0639-de4a-87da-68e0-2d170c241824@grandegger.com>
 <5b0959b9-58b7-cc3c-7014-b7cdb883a7cf@ti.com>
 <2863c42d-065d-39e8-ed20-8279f76f00ae@grandegger.com>
Message-ID: <cc3d0c0c-f56f-0bb5-e90b-a09cdf761f3c@ti.com>
Date:   Mon, 4 Mar 2019 13:12:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <2863c42d-065d-39e8-ed20-8279f76f00ae@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 3/4/19 12:13 PM, Wolfgang Grandegger wrote:
> 
> 
> Am 04.03.19 um 18:22 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 3/4/19 10:56 AM, Wolfgang Grandegger wrote:
>>> Hello Dan,
>>>
>>> the series already looks quite good. I still realized a few (minor)
>>> issues while browsing the patch/code...
>>>
>>
>> Thanks for the review.  It is getting there.
>>
>>> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>>>> Create a m_can platform framework that peripherial
>>>> devices can register to and use common code and register sets.
>>>> The peripherial devices may provide read/write and configuration
>>>> support of the IP.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>
>>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>>
>>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>>  drivers/net/can/m_can/m_can.c          | 702 +++++++++++++------------
>>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>>  drivers/net/can/m_can/m_can_platform.c | 198 +++++++
>>>>  5 files changed, 681 insertions(+), 343 deletions(-)
>>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>>
>>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>>> index 04f20dd39007..f7119fd72df4 100644
>>>> --- a/drivers/net/can/m_can/Kconfig
>>>> +++ b/drivers/net/can/m_can/Kconfig
>>>> @@ -1,5 +1,14 @@
>>>>  config CAN_M_CAN
>>>> +	tristate "Bosch M_CAN support"
>>>> +	---help---
>>>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>>>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>>>> +
>>>> +config CAN_M_CAN_PLATFORM
>>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>>  	depends on HAS_IOMEM
>>>> -	tristate "Bosch M_CAN devices"
>>>> +	depends on CAN_M_CAN
>>>>  	---help---
>>>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>>>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>>> +	  This support is for devices that have the Bosch M_CAN controller
>>>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>>> index 8bbd7f24f5be..057bbcdb3c74 100644
>>>> --- a/drivers/net/can/m_can/Makefile
>>>> +++ b/drivers/net/can/m_can/Makefile
>>>> @@ -3,3 +3,4 @@
>>>>  #
>>>>  
>>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>>> index 9b449400376b..b37d0886f9cb 100644
>>>> --- a/drivers/net/can/m_can/m_can.c
>>>> +++ b/drivers/net/can/m_can/m_can.c
> 
> ...snip...
> 
>>>> @@ -1451,7 +1459,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>>>  			netif_stop_queue(dev);
>>>>  			netdev_warn(dev,
>>>>  				    "TX queue active although FIFO is full.");
>>>> -			return NETDEV_TX_BUSY;
>>>> +			return;
>>>
>>> m_can_start_xmit() doesn't return NETDEV_TX_BUSY but NETDEV_TX_OK and
>>> the queue is stopped! Also the skb is not freed! The code states 
>>> "/* This shouldn't happen */" but then it just prints a warning. Did
>>> you see that message?
>>>
>>
>> No I have not seen this warning but I will re-check to be sure.
> 
> If we don't return NETDEV_TX_BUSY but NETDEV_TX_OK, we must handle it
> differently.
> 

OK.  I see the diff between the perp and io mapped.  I will update the code
appropriately.


> ...snip...
> 
>>>> +struct m_can_priv;
>>>> +struct m_can_ops {
>>>> +	/* Device specific call backs */
>>>> +	int (*clr_dev_interrupts)(struct m_can_priv *m_can_class);
>>>
>>> Why not just "clear_interrupt"... to be consistant with the names below.
>>
>> I wanted to be clear in the M_CAN code that these are device interrupts and not M_CAN interrupts.
>>
>> I can change it to clear_interrupt if you think it makes more sense.
> 
> Well, like for "read_reg" etc, I think it's clear that it's a
> device-specific function/ops:
> 
> 	cdev->read_reg
> 	cdev->clear_interrupt
> 

OK

>>>> +	u32 (*read_reg)(struct m_can_priv *m_can_class, int reg);
>>>> +	int (*write_reg)(struct m_can_priv *m_can_class, int reg, int val);
>>>> +	u32 (*read_fifo)(struct m_can_priv *m_can_class, int addr_offset);
>>>> +	int (*write_fifo)(struct m_can_priv *m_can_class, int addr_offset,
>>>> +			  int val);
>>>> +	int (*device_init)(struct m_can_priv *m_can_class);
> 
> And the same here:
> 
> 	cdev->init
> 

OK

>>>> +	int pm_clock_support;
>>>
>>> A "bool" would be more appropriate, I think.
>>
>>
>> I was abiding by this checkpatch warning I got on the is_peripherial.
>>
>> CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
>> #94: FILE: drivers/net/can/m_can/m_can.h:94:
>> +	bool is_peripherial;
>>
> 
> Ah, right! I was also surprised to get that warning. The kernel is full
> of bool's, but well, we should make "checkpatch" happy (and Linus).
> 
> Wolfgang
> 


-- 
------------------
Dan Murphy
