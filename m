Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986ABC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4D520870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDHGHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:07:06 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:33505
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbfDHGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:07:05 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 80F3820405;
        Mon,  8 Apr 2019 06:07:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Apr 2019 08:07:02 +0200
From:   Martin Schiller <ms@dev.tdt.de>
To:     David Miller <davem@davemloft.net>
Cc:     andrew.hendry@gmail.com, khc@pm.waw.pl, isdn@linux-pingi.de,
        edumazet@google.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] wan/hdlc_x25: fix skb handling
Organization: TDT GmbH
In-Reply-To: <20190405.121529.675930084772235847.davem@davemloft.net>
References: <20190403050118.12785-2-ms@dev.tdt.de>
 <20190404.173240.1338878948110207179.davem@davemloft.net>
 <cf0354c31dd1a20c07d38bd465df5896@dev.tdt.de>
 <20190405.121529.675930084772235847.davem@davemloft.net>
Message-ID: <33a61588eabfb433dcf03a61d218a81a@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-05 21:15, David Miller wrote:
> From: Martin Schiller <ms@dev.tdt.de>
> Date: Fri, 05 Apr 2019 08:56:44 +0200
> 
>> On 2019-04-05 02:32, David Miller wrote:
>>> From: Martin Schiller <ms@dev.tdt.de>
>>> Date: Wed,  3 Apr 2019 07:01:16 +0200
>>> 
>>>>  	/* X.25 to LAPB */
>>>>  	switch (skb->data[0]) {
>>>>  	case X25_IFACE_DATA:	/* Data to be transmitted */
>>>> -		skb_pull(skb, 1);
>>>> -		if ((result = lapb_data_request(dev, skb)) != LAPB_OK)
>>>> -			dev_kfree_skb(skb);
>>>> -		return NETDEV_TX_OK;
>>>> +		skbn = skb_copy(skb, GFP_ATOMIC);
>>>> +		skb_pull(skbn, 1);
>>>> +		skb_reset_network_header(skbn);
>>>> +		if ((result = lapb_data_request(dev, skbn)) != LAPB_OK)
>>>> +			dev_kfree_skb(skbn);
>>> This leaks 'skb'.
>> 
>> What exactly do you mean?
>> 'skb' will get freed at the end of x25_xmit() function:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wan/hdlc_x25.c#n129
> 
> Then why was it freed here in the original code?

In the original code, 'skb' is only freed here if lapb_data_request()
return a value != LAPB_OK, which is the case when the skb can't be
queued for transmission. Otherwise 'skb' won't be freed here in the
"X25_IFACE_DATA" case.

What my change do is, that 'skb' is copied to 'skbn' before the skb_pull
of the first byte, to fix the problem that tracing layer3 (ETH_P_X25)
packets results in a malformed first byte of the packets, because the
original "skb" will get modified before the frame reaches the tcpdump
output.

Everything else works like before.


