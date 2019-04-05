Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D43BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3F20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfDEG4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:56:48 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:9089
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbfDEG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:56:47 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id B3FE32081D;
        Fri,  5 Apr 2019 06:56:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Apr 2019 08:56:44 +0200
From:   Martin Schiller <ms@dev.tdt.de>
To:     David Miller <davem@davemloft.net>
Cc:     andrew.hendry@gmail.com, khc@pm.waw.pl, isdn@linux-pingi.de,
        edumazet@google.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] wan/hdlc_x25: fix skb handling
Organization: TDT GmbH
In-Reply-To: <20190404.173240.1338878948110207179.davem@davemloft.net>
References: <20190403050118.12785-1-ms@dev.tdt.de>
 <20190403050118.12785-2-ms@dev.tdt.de>
 <20190404.173240.1338878948110207179.davem@davemloft.net>
Message-ID: <cf0354c31dd1a20c07d38bd465df5896@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-05 02:32, David Miller wrote:
> From: Martin Schiller <ms@dev.tdt.de>
> Date: Wed,  3 Apr 2019 07:01:16 +0200
> 
>>  	/* X.25 to LAPB */
>>  	switch (skb->data[0]) {
>>  	case X25_IFACE_DATA:	/* Data to be transmitted */
>> -		skb_pull(skb, 1);
>> -		if ((result = lapb_data_request(dev, skb)) != LAPB_OK)
>> -			dev_kfree_skb(skb);
>> -		return NETDEV_TX_OK;
>> +		skbn = skb_copy(skb, GFP_ATOMIC);
>> +		skb_pull(skbn, 1);
>> +		skb_reset_network_header(skbn);
>> +		if ((result = lapb_data_request(dev, skbn)) != LAPB_OK)
>> +			dev_kfree_skb(skbn);
> 
> This leaks 'skb'.

What exactly do you mean?
'skb' will get freed at the end of x25_xmit() function:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wan/hdlc_x25.c#n129

> 
> No way I'm applying this stuff.

