Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50041C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60222173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="Pa5F+EMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfC1Ial (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:30:41 -0400
Received: from mail.synology.com ([211.23.38.101]:47243 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfC1Iak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:30:40 -0400
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id 0147919E11DD9;
        Thu, 28 Mar 2019 16:30:38 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1553761838; bh=43O5l/0CuFlE2pz4eX/9oa1SfybBrHo+D2fpzUZWcic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Pa5F+EMpbAsLzKcRmNy5jy6Pztm5SrXrTZSUqR4bqUT2Y7NzY8pO/2tnangQtzNNQ
         EI2Tu+57QRAZFfw/mjohUxPIIyQyqPirBmFd+877fcRP5LFxXg7TNwEJZd5p89tmLj
         +I3BVHAzKvC7XRVvm03CRsjBb0NeFKI2Cx+zJg+s=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 28 Mar 2019 16:30:37 +0800
From:   lifonghsu <lifonghsu@synology.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: fix routing encapsulated packets when binding a socket to a
 tunnel interface
In-Reply-To: <20190327.134454.1623767882107215644.davem@davemloft.net>
References: <1553236198-5955-1-git-send-email-lifonghsu@synology.com>
 <20190327.134454.1623767882107215644.davem@davemloft.net>
Message-ID: <6143cbeaab4f37bc2314caa3690063d4@synology.com>
X-Sender: lifonghsu@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller 於 2019-03-28 04:44 寫到:
> From: lifonghsu <lifonghsu@synology.com>
> Date: Fri, 22 Mar 2019 14:29:58 +0800
> 
>> From: LiFong Hsu <lifonghsu@synology.com>
>> 
>> When binding a socket to a 4in6/6in4 tunnel interface, the kernel 
>> sends
>> the packet to the tunnel interface without any problem, e.g.,
>> ping 8.8.8.8 -I 4in6. However, after the 4in6/6in4 tunnel 
>> encapsulation,
>> the encapsulated packet could be sent to the tunnel interface again 
>> when
>> some fields of the skb were changed in mangle table's output chain,
>> such as skb->mark and src/dest IP address. Sending to the tunnel 
>> interface
>> twice is unexpected, since there are no corresponding routing rules on
>> the tunnel interface for the encapsulated packet. Eventually, the 
>> encapsulated
>> packet will be dropped by the tunnel interface.
>> 
>> This commit stops referring to sk_bound_dev_if while re-routing a 
>> packet
>> with skb_iif!=0 which indicates that the packet has already been sent 
>> to
>> the interface specified by sk_bound_dev_if. Instead, this commit sends
>> the packet to the underlying network device.
>> 
>> Signed-off-by: LiFong Hsu <lifonghsu@synology.com>
>> Reviewed-by: JianJhen Chen <kchen@synology.com>
> 
> If you do not respond to my feedback, I am going to drop your patch.
> 
> You have 24 hours to respond before that happens.

Sorry for the late reply.

> skb->skb_iif is a receive side indication, why would it be changed on 
> transmit?
Indeed, skb_iif is used as receive site indication to present "device 
the packet arrived on".
This commit keeps the previous arrived device (similar to the concept of 
"device the packet arrived on") in skb_iif field to prevent kernel from 
referring sk_bound_dev_if again. Otherwise, we might need to add a new 
field to sk_buff structure for our purpose.

An example of how this commit works with 4in6 tunnel device is listed as 
follows:
socket bind 4in6 device (e.g. ping -I 4in6 8.8.8.8)
-> skb is transmitted to 4in6 device by referring sk_bound_dev_if
-> encapsulate the IPv4 packet to an IPv6 packet
-> "this commit sets skb_iif to 4in6 device as a flag"
-> ip6tunnel_xmit
-> re-route the encapsulated IPv6 packet
-> "this commit prevents kernel from referring sk_bound_dev_if again by 
checking skb_iif, so the encapsulated IPv6 packet will be sent to the 
underlying device instead of the 4in6 device"
-> underlying device

> I see mac802154 doing this, but what it's doing is somewhat broken and 
> that doesn't come into play in your example.

We have not tested mac802154, but we think this commit should be 
compatible with mac802154. Considering mac802154 is an underlying device 
in the above mentioned example. The skb_iif will be overwritten by 
mac802154 at the end. So the behavior of mac802154 should not be 
affected by this commit.

Thanks.

