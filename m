Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E7DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26AA2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ic5XYoir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfDJSMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:12:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:21531 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDJSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554919922;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5butOi9NeJl54vgWkLCY0TNlHUuyACb1dguvWmKvYCE=;
        b=ic5XYoira0/qu8O0/Ne/iw0ALpdA/0C7wbRfdaoQq2UJg0BCTwUyCzBbG/29CwZWE9
        OQ7FSeNMad52p/qldFtQKzLfBZ3VdzQb05XKCsglZw+GE+hwMjc7S3xIW/hvD1qCBUcT
        9C8b4FQ+j8zaDtXa9Anq2+hXL/4MgdBZFDWlVsOZF0TZ0g2dglC0DQURSIhka+tBpx7f
        h+MgNHJzdi+MaEKIy3k5Pc1Bzu7SMZfqpMUQ6mHpLCKaQIBYCyfCypA28Vv/khtHkkhY
        ONk3jGB4H+lDqwHI9Om9DFuFMpwGXlpsXu9Akc6rsj0yFWCNT/mKe3Rnc8gPwTHPeyf1
        UvnQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGUMh5mUuF"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.200]
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id q0b361v3AIBs6mL
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 10 Apr 2019 20:11:54 +0200 (CEST)
Subject: Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN device
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <baad1868-d5aa-b4f4-0065-c6963b441403@hartkopp.net>
Date:   Wed, 10 Apr 2019 20:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.04.19 09:19, Marc Kleine-Budde wrote:
> On 4/10/19 8:27 AM, Joakim Zhang wrote:
>> CAN driver always writes registers according to "ctrlmode", and now CAN
>> framework will keep CAN ctrlmode after device closed.
>>
>> e.g. with following sequences:
>> 1)ip link set can0 type can bitrate 1000000 loopback on
>> 2)ip link set can0 up
>> 3)ip link set can0 down
>> 4)ip link set can0 type can bitrate 1000000
>> 5)ip link set can0 up
>>
>> After this sequence, we may want to test loopback for the first time and
>> not to test loopback second time. However, CAN device still keep
>> "ctrlmode" as loopback on.
> 
> Then you should configure loopback off in userspace.

ACK!

The idea is that you can set a CAN interface like this:

ip link set can0 type can bitrate 1000000 loopback on

(..)

ip link set can0 down
ip link set can0 up

and none of the configuration changes in the meanwhile.

Regards,
Oliver

> 
>> This patch intends to clean up CAN ctrlmode when close CAN device. We
>> can set which ctrlmode we need when open CAN device again.
> 
> Consider a CANFD device, where CANFD has been enabled. It will feel very
> weird if the interface looses the CANFD property by just a ifdown; ifup.
> 
>>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ---
>>   drivers/net/can/dev.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index c05e4d50d43d..4f69a8f16ba3 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -870,6 +870,7 @@ void close_candev(struct net_device *dev)
>>   	struct can_priv *priv = netdev_priv(dev);
>>   
>>   	cancel_delayed_work_sync(&priv->restart_work);
>> +	priv->ctrlmode = 0;
>>   	can_flush_echo_skb(dev);
>>   }
>>   EXPORT_SYMBOL_GPL(close_candev);
>>
> 
> Marc
> 
