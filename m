Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD8C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B272206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLCE2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 23:28:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfLCE2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 23:28:31 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3AF1518A4BC35D85D188;
        Tue,  3 Dec 2019 12:28:29 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 12:28:22 +0800
Subject: Re: [PATCH net 1/3] net: hns3: fix for TX queue not restarted problem
To:     David Miller <davem@davemloft.net>, <tanhuazhong@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>
References: <1575342535-2981-1-git-send-email-tanhuazhong@huawei.com>
 <1575342535-2981-2-git-send-email-tanhuazhong@huawei.com>
 <20191202.192539.1290120247243731738.davem@davemloft.net>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2f017ae3-ddec-928c-16b7-5ed59e6fc8d6@huawei.com>
Date:   Tue, 3 Dec 2019 12:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191202.192539.1290120247243731738.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/3 11:25, David Miller wrote:
> From: Huazhong Tan <tanhuazhong@huawei.com>
> Date: Tue, 3 Dec 2019 11:08:53 +0800
> 
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index ba05368..b2bb8e2 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> @@ -1286,13 +1286,16 @@ static bool hns3_skb_need_linearized(struct sk_buff *skb, unsigned int *bd_size,
>>  	return false;
>>  }
>>  
>> -static int hns3_nic_maybe_stop_tx(struct hns3_enet_ring *ring,
>> +static int hns3_nic_maybe_stop_tx(struct net_device *netdev,
>>  				  struct sk_buff **out_skb)
>>  {
>> +	struct hns3_nic_priv *priv = netdev_priv(netdev);
>>  	unsigned int bd_size[HNS3_MAX_TSO_BD_NUM + 1U];
>>  	struct sk_buff *skb = *out_skb;
>> +	struct hns3_enet_ring *ring;
>>  	unsigned int bd_num;
>>  
>> +	ring = &priv->ring[skb->queue_mapping];
> 
> Please just pass the ring pointer into hns3_nic_maybe_stop_tx() instead of
> needlessly recalculating it.

The reason that I am passing the netdev instead of ring pointer is
that the netif_start_subqueue() need a netdev parameter, and the
netdev can not be derived from the ring pointer.

Do you think it is better to keep it as this patch, or add a new
netdevice parameter? like below:

static int hns3_nic_maybe_stop_tx(struct net_device *netdev,
				  struct hns3_enet_ring *ring,
				  struct sk_buff **out_skb)



> 
> Thank you.
> 
> .
> 

