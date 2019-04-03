Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4182147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCJwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:52:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfDCJwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:52:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [10.3.19.206])
        by Forcepoint Email with ESMTP id B48853930F7FA0E15889;
        Wed,  3 Apr 2019 17:52:44 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 17:52:34 +0800
Subject: Re: [PATCH net-next 04/12] net: hns3: return 0 and print warning when
 hit duplicate MAC
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Peng Li <lipeng321@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
 <1554260881-44948-5-git-send-email-tanhuazhong@huawei.com>
 <4b40bd6e-a732-bc8b-4085-56520677b6ea@cogentembedded.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <f61c271a-a7ef-de6e-76cd-ea666734cd87@huawei.com>
Date:   Wed, 3 Apr 2019 17:52:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <4b40bd6e-a732-bc8b-4085-56520677b6ea@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.149.191]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/3 17:15, Sergei Shtylyov wrote:
> On 03.04.2019 6:07, Huazhong Tan wrote:
> 
>> From: Peng Li <lipeng321@huawei.com>
>>
>> When set 2 same MAC to different function of one port, IMP
>> will return error as the later one may modify the origin one.
>> This will cause bond fail for 2 VFs of one port.
>>
>> Driver just print warning and return 0 with this patch, so
>> if set same MAC address, it will return 0 but do not really
>> configure to HW.
> 
>     "To" not needed here.
> 

ok, thanks.

>> Signed-off-by: Peng Li <lipeng321@huawei.com>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c 
>> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> index e742a05..d45789e 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -5962,8 +5962,11 @@ int hclge_add_uc_addr_common(struct hclge_vport 
>> *vport,
>>       }
>>       /* check if we just hit the duplicate */
>> -    if (!ret)
>> -        ret = -EINVAL;
>> +    if (!ret) {
>> +        dev_warn(&hdev->pdev->dev, "VF %d mac(%pM) has been existed\n",
> 
>     Maybe just "exists"? The grammar is certainly wrong as is. :-)
> 
>> +             vport->vport_id, addr);
>> +        return 0;
>> +    }
>>       dev_err(&hdev->pdev->dev,
>>           "PF failed to add unicast entry(%pM) in the MAC table\n",
> 
> MBR, Sergei
> 

ok, thanks.

> .
> 

