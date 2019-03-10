Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URI_HEX autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC0BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42008206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=post.cz header.i=@post.cz header.b="WgfI/0y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCJNt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:49:56 -0400
Received: from mxc2.seznam.cz ([77.75.77.23]:26042 "EHLO mxc2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfCJNt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 09:49:56 -0400
X-Greylist: delayed 813 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Mar 2019 09:49:54 EDT
Received: from email.seznam.cz
        by email-smtpc6a.ng.seznam.cz (email-smtpc6a.ng.seznam.cz [10.23.10.165])
        id 61f4d8e60e7863d462bdf3b2;
        Sun, 10 Mar 2019 14:49:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz; s=beta;
        t=1552225793; bh=wtsxlbBjcxVfZ0eiSnungx+cQTrDHHozfu4bX+E0+Q4=;
        h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WgfI/0y/CnNMYTow8FARdJ6F7z2ou6aEDw7P4fMwp8dscIIhJh5/EN78Prja0SEoP
         vQfHfbKCH+rRvMX3TItWSnjbk6hfTo6NylNAJ1MZyUGPcHoZh508cIMH5LgGhP4Am8
         nKBg4/W+0UC/eiPL6cLZt1nR/BQItNL9mQW9vdnU=
Received: from [192.168.1.81] (static-cl188134234222.unet.cz [188.134.234.222])
        by email-relay5.ng.seznam.cz (Seznam SMTPD 1.3.103) with ESMTP;
        Sun, 10 Mar 2019 14:36:12 +0100 (CET)  
Subject: Re: [PATCH] net: can: Increase tx queue length
To:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Andre Naujoks <nautsch2@gmail.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Sojka <sojkam1@fel.cvut.cz>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
 <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
From:   Martin Jerabek <ma.jer@post.cz>
Message-ID: <61d9d998-37f7-6f99-60d4-b1973e13e6ef@post.cz>
Date:   Sun, 10 Mar 2019 14:36:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 03. 19 15:40, Appana Durga Kedareswara Rao wrote:
> Hi Andre,
> 
> <Snip> 
>>
>> On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
>>> While stress testing the CAN interface on xilinx axi can in loopback
>>> mode getting message "write: no buffer space available"
>>> Increasing device tx queue length resolved the above mentioned issue.
>>
>> No need to patch the kernel:
>>
>> $ ip link set <dev-name> txqueuelen 500
>>
>> does the same thing.
> 
> Thanks for the review... 
> Agree but it is not an out of box solution right?? 
> Do you have any idea for socket can devices why the tx queue length is 10 whereas
> for other network devices (ex: ethernet) it is 1000 ?? 
> 
> Regards,
> Kedar.

There was already a patch for this in the past [1], together with a thorough
analysis, but for some reason the discussion died out.

Even if the defaults are not changed, it would be nice to at least see it
mentioned in Documentation/networking/can.txt to save people some time while
looking for the solution.

Regards,
Martin


[1] http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html


>>
>>>
>>> Signed-off-by: Appana Durga Kedareswara rao
>>> <appana.durga.rao@xilinx.com>
>>> ---
>>> --> Network devices default tx_queue_len is 1000 but for socket
>>> can device it is 10 any reason for it??
>>>
>>>  drivers/net/can/dev.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
>>> c05e4d5..32bd5be 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -642,7 +642,7 @@ static void can_setup(struct net_device *dev)
>>>  	dev->mtu = CAN_MTU;
>>>  	dev->hard_header_len = 0;
>>>  	dev->addr_len = 0;
>>> -	dev->tx_queue_len = 10;
>>> +	dev->tx_queue_len = 500;
>>>
>>>  	/* New-style flags. */
>>>  	dev->flags = IFF_NOARP;
>>>
> 
