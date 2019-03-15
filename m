Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D784221871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YXRVDKn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfCOPO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:14:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33042 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfCOPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:14:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2FFEnWp126702;
        Fri, 15 Mar 2019 10:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552662889;
        bh=4Bju1g6oUo8suraX68u2phqSTvNGr0/v4obV7zLLMf4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=YXRVDKn7PKYKxHMEP/YLff98PbNx0fn01KplzaPZC2+Dh87yFpz0PiWyl59tE7LW7
         WoOn25bw+ep/lTbkT189fd67JCH6P1ugU3lKQYV/R3YcK9XWHZMfzz0J9CropzxE5E
         YEm5yxQqNfE6c++L6WVO7AknU8WmNPc2hrRevo7s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2FFEnQH035934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 10:14:49 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 15
 Mar 2019 10:14:48 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 15 Mar 2019 10:14:48 -0500
Received: from [172.22.118.207] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2FFEmlm019617;
        Fri, 15 Mar 2019 10:14:48 -0500
Subject: Re: [PATCH v9 1/4] can: m_can: Create a m_can platform framework
From:   Dan Murphy <dmurphy@ti.com>
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190313162629.11937-1-dmurphy@ti.com>
 <87f14a09-244e-c698-1372-f8b49e60faee@grandegger.com>
 <a578dd22-a581-8421-fac4-605fa8f63d1a@ti.com>
 <470e0028-7e4c-b1ba-7c50-7464f4904801@grandegger.com>
 <af88fad4-37a9-1ccb-0e06-70db34fff562@ti.com>
Message-ID: <7433cda9-5b44-cef0-b84e-8d8a0d93af8a@ti.com>
Date:   Fri, 15 Mar 2019 10:14:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <af88fad4-37a9-1ccb-0e06-70db34fff562@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 3/15/19 9:51 AM, Dan Murphy wrote:
> On 3/14/19 9:38 AM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> Am 14.03.19 um 15:04 schrieb Dan Murphy:
>>> Hello
>>>
>>> On 3/14/19 2:26 AM, Wolfgang Grandegger wrote:
>>>> Hello Dan,
>>>>
>>>> we are close...
>>>>
>>>> Am 13.03.19 um 17:26 schrieb Dan Murphy:
>>>>> Create a m_can platform framework that peripherial
>>>>> devices can register to and use common code and register sets.
>>>>> The peripherial devices may provide read/write and configuration
>>>>> support of the IP.
>>>>>
>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>> ---
>>>>>
>>>>> v9 - Added back the CSR clearing as this is needed for TCAN device, fixed clean
>>>>> function to clean index for version > 30, removed extra skb free and fixed work
>>>>> handler to handle FIFO full for perpheral devices - https://lore.kernel.org/patchwork/patch/1050120/
>>>>>
>>>>> v8 - Added a clean function for the tx_skb, cleaned up skb on BUS_OFF and on xmit
>>>>> BUSY - https://lore.kernel.org/patchwork/patch/1047980/
>>>>> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
>>>>> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
>>>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>>>
>>>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>>>  drivers/net/can/m_can/m_can.c          | 733 +++++++++++++------------
>>>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>>>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>>>>>  5 files changed, 714 insertions(+), 345 deletions(-)
>>>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>>>
>>>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>>>> index 04f20dd39007..f7119fd72df4 100644
>>>>> --- a/drivers/net/can/m_can/Kconfig
>>>>> +++ b/drivers/net/can/m_can/Kconfig
>>>>> @@ -1,5 +1,14 @@
>>>>>  config CAN_M_CAN
>>>>> +	tristate "Bosch M_CAN support"
>>>>> +	---help---
>>>>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>>>>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>>>>> +
>>>>> +config CAN_M_CAN_PLATFORM
>>>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>>>  	depends on HAS_IOMEM
>>>>> -	tristate "Bosch M_CAN devices"
>>>>> +	depends on CAN_M_CAN
>>>>>  	---help---
>>>>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>>>>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>>>> +	  This support is for devices that have the Bosch M_CAN controller
>>>>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>>>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>>>> index 8bbd7f24f5be..057bbcdb3c74 100644
>>>>> --- a/drivers/net/can/m_can/Makefile
>>>>> +++ b/drivers/net/can/m_can/Makefile
>>>>> @@ -3,3 +3,4 @@
>>>>>  #
>>>>>  
>>>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>>>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>>>> index 9b449400376b..56336aefc567 100644
>>>>> --- a/drivers/net/can/m_can/m_can.c
>>>>> +++ b/drivers/net/can/m_can/m_can.c
>> ...  snip ...
>>
>>>>> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>>>> +				    struct net_device *dev)
>>>>> +{
>>>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>>>> +
>>>>> +	if (can_dropped_invalid_skb(dev, skb))
>>>>> +		return NETDEV_TX_OK;
>>>>> +
>>>>> +	if (priv->is_peripherial) {
>>>>> +		if (priv->tx_skb) {
>>>>> +			netdev_err(dev, "hard_xmit called while tx busy\n");
>>>>> +			return NETDEV_TX_BUSY;
>>>>> +		}
>>>>> +
>>>>> +		if (priv->can.state == CAN_STATE_BUS_OFF) {
>>>>> +			m_can_clean(dev);
>>>>> +		} else {
>>>>> +			priv->tx_skb = skb;
>>>>> +			queue_work(priv->tx_wq, &priv->tx_work);
>>>>
>>>> You removed "netif_stop_queue(cdev->net)" here. Does that work with just
>>>> *one* "tx_skb"? I think you need an array then!? I'm afraid, this will
>>>> require quite some changes and you should also measure the benefit of
>>>> queuing outgoing messages first. For the time being, it would be fine
>>>> for me to stop the queue here and add an appropriate comment.
>>>>
>>>
>>> Yes I removed this in favor of allowing the work handler to stop the queue.
>>>
>>> If the version is < 30 then the queue is stopped immediately.  If the version > 30 then the queue is
>>> only stopped if FIFO is full.
>>
>> Yes, and the next call to m_can_start_xmit() will probably return with
>> NETDEV_TX_BUSY. You should at least add a "netif_stop_queue(cdev->net)"
>> before returning NETDEV_TX_BUSY, otherwice the upper layer will retry
>> immediately resulting in high CPU load. Anyway, the purpose of this
>> return code is to signal errors/bugs in the start/stop flow control:
>>
> 
> Ack
> 
>> https://elixir.bootlin.com/linux/latest/source/Documentation/networking/netdevices.txt#L81
>>
>>>
>>> I did see the message "tcan4x5x spi1.0 can0: hard_xmit called while tx busy" 
>>> more with no gap and no polling in the cangen request.
>>
>> You usually should never see that message.
>>
>>>
>>>> BTW, how big is the FIFO size on your system:
>>>>
>>>
>>> This value is set to 1.
>>>
>>>>   tx_fifo_size = mram_config_vals[7];
>>
>> Then I'm surprised that you see "hard_xmit called while tx busy" at all.
>> Are you sure that "cdev->version" is 32 on the tcan4x5?
>>
> 
> tcan4x5x spi1.0 can0: Version of M_CAN is 32
> 

UGH!  I just found that I spelled peripheral wrong so I am making that change in the code as
well

Dan


>> Wolfgang
>>
> 
> 


-- 
------------------
Dan Murphy
