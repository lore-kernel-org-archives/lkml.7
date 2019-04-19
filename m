Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B6C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B82F2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfDSU6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:58:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:35560 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfDSU6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:58:45 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hHWJj-0000tZ-Rm; Fri, 19 Apr 2019 19:24:48 +0300
Subject: Re: [PATCH 1/4] net/skbuff: don't waste memory reserves
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
 <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com>
 <c2c270d9-29c0-b993-84c5-4c994608f7c8@virtuozzo.com>
 <a80606cf-3076-b01d-0442-ccff3c462276@gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6651d0b9-4ddf-ef6d-6f53-e1290b7aeeee@virtuozzo.com>
Date:   Fri, 19 Apr 2019 19:25:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a80606cf-3076-b01d-0442-ccff3c462276@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 4:41 PM, Eric Dumazet wrote:
> On 04/19/2019 06:17 AM, Andrey Ryabinin wrote:
>>
> 
>> I don't see why that would be a problem. If refill failed because we didn't have
>> access to reserves, then there going to be an another refill attempt, right?
>> And the next refill attempt will be with access to the reserves if memalloc socket was created.
>> We can't predict the future, so until the memalloc socket appeared we must assume that those
>> RX ring buffers won't be used to reclaim memory (and that is actually true in 99% of cases).
>>
> 
> I just said that the alloc might be attempted "in the past"
> 
> Yes, we can not predict the future, this is why we need to access the reserve _now_ and not
> at the time the packet is received.
> 
> The 'being true in 99% of cases' argument is not really convincing.
> 
> You want the NIC to be ready to receive packets even before sk_memalloc_socks() becomes true.

The fact that we allocate pages before the socket created I completely understand.

But why that failed allocation is such a problem?

1. sk_memalloc_socks() false
2. NIC driver tries to allocate pages and fails
3. swapon /nfs/swap_file /* memalloc_socket created */
4. We may be loosing some packets because of 2. But there will be retransmit, I suppose NIC driver will
try to allocate pages again, and this time with access to reserves, so eventually we all good.

So what is the problem? Potential lost of some packets for some period of time after swapon?


> If a NIC driver has a bug, please fix it.
> 

I don't follow, what kind of bug are you talking about?
The problem I'm trying to fix is entirely in __dev_alloc_pages():
1. sk_memalloc_socks() false all the time.
2. NIC takes pages from memory reserves
3. The fact that we occupying memory reserves increases the chances that the next page will be also taken from reserves as well,
which means more dropped packets than we would have without using the reserves.
