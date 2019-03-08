Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54A52087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LJf4JJpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCHPs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:48:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47316 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHPs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:48:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x28FmlIR048370;
        Fri, 8 Mar 2019 09:48:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552060127;
        bh=iOeE97bpsG5TTv/R9Oph7cvoBiOurgLiB1nPDCGieaE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LJf4JJpnCXwl8dVuqrSLwW7zch5HHNrNauFFSGKP/+edFqZd+SIJmVRpsA0RyEl5H
         LMearUYwlw506RttiAgp2yZXNplKh+pAWz4eqBtVlLjPncKWvhDFbMLhaq1NdZC0+3
         9hmSkjXAU6SXR8OLinCu0iO9nz0phucrBF0VvU2g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x28Fml4u104681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Mar 2019 09:48:47 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Mar 2019 09:48:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Mar 2019 09:48:46 -0600
Received: from [172.22.114.154] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x28FmkqB030656;
        Fri, 8 Mar 2019 09:48:46 -0600
Subject: Re: [PATCH v7 1/4] can: m_can: Create a m_can platform framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190305155220.14037-1-dmurphy@ti.com>
 <5065d6ba-f195-a695-77b1-b837cac1a199@grandegger.com>
 <bbc9db2f-0702-4f24-db64-a41dc0607d2d@ti.com>
 <bf2613ae-67f6-661d-0faa-786308c249a0@grandegger.com>
 <cea76d80-d85c-2963-2745-4509450e2ea9@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6016c8aa-01b6-38d5-0e1f-3a999aae6a13@ti.com>
Date:   Fri, 8 Mar 2019 09:48:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <cea76d80-d85c-2963-2745-4509450e2ea9@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 3/8/19 8:41 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> thinking more about it...
> 
> Am 08.03.19 um 14:29 schrieb Wolfgang Grandegger:
>> Hello Dan,
>>
>> Am 08.03.19 um 13:44 schrieb Dan Murphy:
>>> Wolfgang
>>>
>>> On 3/8/19 4:10 AM, Wolfgang Grandegger wrote:
>>>> Hallo Dan,
>>>>
>>>> Am 05.03.19 um 16:52 schrieb Dan Murphy:
>>>>> Create a m_can platform framework that peripherial
>>>>> devices can register to and use common code and register sets.
>>>>> The peripherial devices may provide read/write and configuration
>>>>> support of the IP.
>>>>>
>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>> ---
>>>>>
>>>>>
>>>>> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
>>>>> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
>>>>>
>>>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>>>
>>>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>>>  drivers/net/can/m_can/m_can.c          | 700 +++++++++++++------------
>>>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>>>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>>>>>  5 files changed, 682 insertions(+), 344 deletions(-)
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
>>>>> index 9b449400376b..a60278d94126 100644
>>>>> --- a/drivers/net/can/m_can/m_can.c
>>>>> +++ b/drivers/net/can/m_can/m_can.c
>>>>
>>>> ... snip...
>>>>
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
>>>>
>>>> The problem with that approach is, that the upper layer will try to
>>>> resubmit the current "skb" but not the previous "tx_skb". And the
>>>> previous "tx_skb" has not been freed yet. I would just drop and free the
>>>> skb and return NETDEV_TX_OK in m_can_tx_handler() for peripheral devices
>>>> (like can_dropped_invalid_skb() does).
>>>>
>>>
>>> OK.
>>>
>>> So would this also be a bug in the hi3110 and mcp251x drivers (line 521) as well because besides checking tx_length
>>> this is how these drivers are written.
>>
>> This is different. When entering the "start_xmit" routine, the previous
>> TX is still in progress. It will (hopefully) complete soon. Therefore
>> returning NETDEV_TX_BUSY is OK. The "start_xmit" routine will be
>> recalled soon with the same "skb". That scenario should/could also not
>> happen.
> 
> In principle, this also applies to the m_can peripheral devices. If
> tx_skb is not NULL, the TX is still in progress and returning
> NETDEV_TX_BUSY is just fine.
> 
>>
>> In contrast, in "m_can_tx_handler()", the skb could not be handled
>> because the FIFO is full. The "start_xmit" routine for peripheral
>> devices for that skb already returned NETDEV_TX_OK. Therefore the only
>> meaningful action is to drop the skb. Also this error should not happen
>> and if, something is going really wrong. Therefore I think, a
>> WARN_ONCE() would be even more appropriate. But that should be a
>> separate patch.
> 
> But that's a different issue/error. The tx_skb cannot be processed in
> "m_can_tx_handler()". Either we drop it or we re-queue it (retry later).
> 

OK I am a bit confused on this.  Are you saying this is not an issue?
Or are you saying I need to check for tx_len like the other code?

Again if this code is an issue here I believe this is an issue in the hi3110 and mcp251x

Dan


>>>
>>> In addition in the peripheral context the work queue does not report up to the upper layer the status.
>>> Again the hi3110 and mcp251x drivers are written this way.
>>>
>>> The only issue I see here is that the dropped and invalid check needs to come after the tx_skb check.
>>
>> See above.
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
