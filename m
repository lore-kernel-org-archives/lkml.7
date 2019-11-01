Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE78CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B765C208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfKABRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 21:17:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbfKABRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 21:17:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72B76F7F7557A3374BC9;
        Fri,  1 Nov 2019 09:17:49 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 09:17:40 +0800
Subject: Re: [PATCH net-next 8/9] net: hns3: cleanup some print format warning
To:     Joe Perches <joe@perches.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Guojia Liao <liaoguojia@huawei.com>
References: <1572521004-36126-1-git-send-email-tanhuazhong@huawei.com>
 <1572521004-36126-9-git-send-email-tanhuazhong@huawei.com>
 <4541e77d257685c649f5f994e673a409a3634f50.camel@perches.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <ce0c5f5f-08b7-7e38-b156-954a8398abfa@huawei.com>
Date:   Fri, 1 Nov 2019 09:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <4541e77d257685c649f5f994e673a409a3634f50.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/31 19:53, Joe Perches wrote:
> On Thu, 2019-10-31 at 19:23 +0800, Huazhong Tan wrote:
>> From: Guojia Liao <liaoguojia@huawei.com>
>>
>> Using '%d' for printing type unsigned int or '%u' for
>> type int would cause static tools to give false warnings,
>> so this patch cleanups this warning by using the suitable
>> format specifier of the type of variable.
>>
>> BTW, modifies the type of some variables and macro to
>> synchronize with their usage.
> 
> What tool is this?

Sorry, it is my mistake, as confirmed, this patch is
advised by internal code review.

> 
> I think this static warning is excessive as macro
> defines with a small positive number are common
> 

yes, it seems ok.
The reason we do this modification is that
printing resp_data_len with '%u' and printing
HCLGE_MBX_MAX_RESP_DATA_SIZE with '%d' seems a little odd.

  	if (resp_data_len > HCLGE_MBX_MAX_RESP_DATA_SIZE) {
  		dev_err(&hdev->pdev->dev,
-			"PF fail to gen resp to VF len %d exceeds max len %d\n",
+			"PF fail to gen resp to VF len %u exceeds max len %u\n",
  			resp_data_len,
  			HCLGE_MBX_MAX_RESP_DATA_SIZE);

Thanks for your suggestion.

>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
> []
>> @@ -72,7 +72,7 @@ enum hclge_mbx_vlan_cfg_subcode {
>>   };
>>   
>>   #define HCLGE_MBX_MAX_MSG_SIZE	16
>> -#define HCLGE_MBX_MAX_RESP_DATA_SIZE	8
>> +#define HCLGE_MBX_MAX_RESP_DATA_SIZE	8U
>>   #define HCLGE_MBX_RING_MAP_BASIC_MSG_NUM	3
>>   #define HCLGE_MBX_RING_NODE_VARIABLE_NUM	3
> 
> like this one
> 
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> []
>> @@ -57,68 +57,68 @@ static int hns3_dbg_queue_info(struct hnae3_handle *h,
>>   					   HNS3_RING_RX_RING_BASEADDR_H_REG);
>>   		base_add_l = readl_relaxed(ring->tqp->io_base +
>>   					   HNS3_RING_RX_RING_BASEADDR_L_REG);
>> -		dev_info(&h->pdev->dev, "RX(%d) BASE ADD: 0x%08x%08x\n", i,
>> +		dev_info(&h->pdev->dev, "RX(%u) BASE ADD: 0x%08x%08x\n", i,
> 
> so using %d is correct enough.
> 
> 
> 
> .
> 

