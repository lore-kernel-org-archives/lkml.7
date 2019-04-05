Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E99BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1574521773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfDETPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:15:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44108 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDETPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:15:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 48A8F1496ED21;
        Fri,  5 Apr 2019 12:15:31 -0700 (PDT)
Date:   Fri, 05 Apr 2019 12:15:29 -0700 (PDT)
Message-Id: <20190405.121529.675930084772235847.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     andrew.hendry@gmail.com, khc@pm.waw.pl, isdn@linux-pingi.de,
        edumazet@google.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] wan/hdlc_x25: fix skb handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cf0354c31dd1a20c07d38bd465df5896@dev.tdt.de>
References: <20190403050118.12785-2-ms@dev.tdt.de>
        <20190404.173240.1338878948110207179.davem@davemloft.net>
        <cf0354c31dd1a20c07d38bd465df5896@dev.tdt.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Apr 2019 12:15:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Fri, 05 Apr 2019 08:56:44 +0200

> On 2019-04-05 02:32, David Miller wrote:
>> From: Martin Schiller <ms@dev.tdt.de>
>> Date: Wed,  3 Apr 2019 07:01:16 +0200
>> 
>>>  	/* X.25 to LAPB */
>>>  	switch (skb->data[0]) {
>>>  	case X25_IFACE_DATA:	/* Data to be transmitted */
>>> -		skb_pull(skb, 1);
>>> -		if ((result = lapb_data_request(dev, skb)) != LAPB_OK)
>>> -			dev_kfree_skb(skb);
>>> -		return NETDEV_TX_OK;
>>> +		skbn = skb_copy(skb, GFP_ATOMIC);
>>> +		skb_pull(skbn, 1);
>>> +		skb_reset_network_header(skbn);
>>> +		if ((result = lapb_data_request(dev, skbn)) != LAPB_OK)
>>> +			dev_kfree_skb(skbn);
>> This leaks 'skb'.
> 
> What exactly do you mean?
> 'skb' will get freed at the end of x25_xmit() function:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wan/hdlc_x25.c#n129

Then why was it freed here in the original code?
