Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E4D2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfDZOnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:43:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43280 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfDZOnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:43:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 297FB80D;
        Fri, 26 Apr 2019 07:43:24 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672C73F5C1;
        Fri, 26 Apr 2019 07:43:22 -0700 (PDT)
Subject: Re: [PATCH 08/12] net: ll_temac: Fix iommu/swiotlb leak
To:     Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Yang Wei <yang.wei9@zte.com.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
References: <20190426073231.4008-1-esben@geanix.com>
 <20190426073231.4008-9-esben@geanix.com> <20190426142103.GI14432@lunn.ch>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0aab6152-82c6-b53f-6b9b-0905995de43a@arm.com>
Date:   Fri, 26 Apr 2019 15:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426142103.GI14432@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 15:21, Andrew Lunn wrote:
> On Fri, Apr 26, 2019 at 09:32:27AM +0200, Esben Haabendal wrote:
>> Unmap the actual buffer length, not the amount of data received.
> 
> Hi Esben
> 
> The patch Subject does not seem to match the content?
> 
> Also, there can be performance advantages of just unmapping the
> received length. The unmap operation does a cache invalidate, which
> can be expensive. Consider the effort of unmapping a 64 byte ACK vs 9K
> jumbo frame?

If the size passed to dma_unmap_*() is not the same as was passed to the 
corresponding dma_map_*(), that is fundamentally incorrect use of the 
API and may lead to warnings, resource exhaustion, or possibly even 
corruption and crashes for some DMA API implementations.

If there's a case where you just need to look at a small part of the 
buffer right now, but can unmap the whole thing properly later. then 
dma_sync_single_*() does allow operating on partial buffers. Even 
better, if you're able to recycle buffers in your Rx pool you could 
potentially replace the unmap/map dance altogether with some careful use 
of sync_single.

Robin.

> 
>        Andrew
>   
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>   drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
>> index 309f149..56d8077 100644
>> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
>> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
>> @@ -821,7 +821,7 @@ static void ll_temac_recv(struct net_device *ndev)
>>   		length = be32_to_cpu(cur_p->app4) & 0x3FFF;
>>   
>>   		dma_unmap_single(ndev->dev.parent, be32_to_cpu(cur_p->phys),
>> -				 length, DMA_FROM_DEVICE);
>> +				 XTE_MAX_JUMBO_FRAME_SIZE, DMA_FROM_DEVICE);
>>   
>>   		skb_put(skb, length);
>>   		skb->protocol = eth_type_trans(skb, ndev);
>> -- 
>> 2.4.11
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
