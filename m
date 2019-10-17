Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F287ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C5621928
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391791AbfJQAyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:54:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388082AbfJQAyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:54:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 28EAFA16A269D42F243C;
        Thu, 17 Oct 2019 08:54:37 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 08:54:29 +0800
Subject: Re: [PATCH net-next 11/12] net: hns3: do not allocate linear data for
 fraglist skb
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
References: <1571210231-29154-1-git-send-email-tanhuazhong@huawei.com>
 <1571210231-29154-12-git-send-email-tanhuazhong@huawei.com>
 <20191016101817.725b6d28@cakuba.netronome.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <2bf7e500-66e0-1b24-f940-5f8c4952038a@huawei.com>
Date:   Thu, 17 Oct 2019 08:54:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191016101817.725b6d28@cakuba.netronome.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/17 1:18, Jakub Kicinski wrote:
> On Wed, 16 Oct 2019 15:17:10 +0800, Huazhong Tan wrote:
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>>
>> Currently, napi_alloc_skb() is used to allocate skb for fraglist
>> when the head skb is not enough to hold the remaining data, and
>> the remaining data is added to the frags part of the fraglist skb,
>> leaving the linear part unused.
>>
>> So this patch passes length of 0 to allocate fraglist skb with
>> zero size of linear data.
>>
>> Fixes: 81ae0e0491f3 ("net: hns3: Add skb chain when num of RX buf exceeds MAX_SKB_FRAGS")
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> 
> Is this really a fix? I just wastes memory, right?

It is a minor optimizations. This fix tag is a mistake.
Thanks.

> 
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index 6172eb2..14111af 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> @@ -2866,8 +2866,7 @@ static int hns3_add_frag(struct hns3_enet_ring *ring, struct hns3_desc *desc,
>>   			return -ENXIO;
>>   
>>   		if (unlikely(ring->frag_num >= MAX_SKB_FRAGS)) {
>> -			new_skb = napi_alloc_skb(&ring->tqp_vector->napi,
>> -						 HNS3_RX_HEAD_SIZE);
>> +			new_skb = napi_alloc_skb(&ring->tqp_vector->napi, 0);
>>   			if (unlikely(!new_skb)) {
>>   				hns3_rl_err(ring_to_netdev(ring),
>>   					    "alloc rx fraglist skb fail\n");
> 
> 
> .
> 

