Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C8C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D258120821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfDSU6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:58:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:35560 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfDSU6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:58:43 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hHTOT-0008G9-GU; Fri, 19 Apr 2019 16:17:29 +0300
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
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c2c270d9-29c0-b993-84c5-4c994608f7c8@virtuozzo.com>
Date:   Fri, 19 Apr 2019 16:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/19 9:55 PM, Eric Dumazet wrote:
> 
> 
> On 04/18/2019 11:05 AM, Andrey Ryabinin wrote:
>> In some workloads we have noticed packets being dropped by
>> sk_filter_trim_cap() because the 'skb' was allocated from pfmemalloc
>> reserves:
>>
>> 	/*
>> 	 * If the skb was allocated from pfmemalloc reserves, only
>> 	 * allow SOCK_MEMALLOC sockets to use it as this socket is
>> 	 * helping free memory
>> 	 */
>> 	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
>> 		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
>> 		return -ENOMEM;
>> 	}
>>
>> Memalloc sockets are used for stuff like swap over NBD or NFS
>> and only memalloc sockets can process memalloc skbs. Since we
>> don't have any memalloc sockets in our setups we shouldn't have
>> memalloc skbs either. It simply doesn't make any sense to waste
>> memory reserves on skb which will be dropped anyway.
>>
>> It appears that __dev_alloc_pages() unconditionally uses
>> __GFP_MEMALLOC, so unless caller added __GFP_NOMEMALLOC, the
>> __dev_alloc_pages() may dive into memory reserves.
>> Later build_skb() or __skb_fill_page_desc() sets skb->pfmemalloc = 1
>> so this skb always dropped by sk_filter_trim_cap().
>>
>> Instead of wasting memory reserves we simply shouldn't use them in the
>> case of absence memalloc sockets in the system. Do this by adding
>> the  __GFP_MEMALLOC only when such socket is present in the system.
>>
>> Fixes: 0614002bb5f7 ("netvm: propagate page->pfmemalloc from skb_alloc_page to skb")
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> ---
>>  include/linux/skbuff.h | 17 ++++++++++++++++-
>>  include/net/sock.h     | 15 ---------------
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>>
> 
> Hi Andrey
> 
> Are you targeting net or net-next tree ?
> 

I think it's up to Dave to decide where the patches should go. They apply cleanly on both trees.
The last two patches just minor cleanups so they are definitely net-next material.

> AFAIK, drivers allocate skbs way before a frame is actually received,
> (at RX ring buffer initialization or refill)
> 
> So sk_memalloc_socks() might be false at that time, but true later.
> 

I don't see why that would be a problem. If refill failed because we didn't have
access to reserves, then there going to be an another refill attempt, right?
And the next refill attempt will be with access to the reserves if memalloc socket was created.
We can't predict the future, so until the memalloc socket appeared we must assume that those
RX ring buffers won't be used to reclaim memory (and that is actually true in 99% of cases).




