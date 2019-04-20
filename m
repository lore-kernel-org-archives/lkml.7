Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3017CC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7A21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfDTBGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:06:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfDTBGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:06:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5485057E19D4A52ED96E;
        Sat, 20 Apr 2019 09:06:05 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Sat, 20 Apr 2019
 09:05:57 +0800
Subject: Re: [PATCH net-next 10/12] net: hns3: Add handling of MAC tunnel
 interruption
To:     Neil Horman <nhorman@redhat.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>
References: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
 <1555643147-52407-11-git-send-email-tanhuazhong@huawei.com>
 <20190419112902.GA31368@hmswarspite.think-freely.org>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <fa85b5e9-2005-e977-af2a-b308ac6a86a2@huawei.com>
Date:   Sat, 20 Apr 2019 09:05:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190419112902.GA31368@hmswarspite.think-freely.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/19 19:29, Neil Horman wrote:
> On Fri, Apr 19, 2019 at 11:05:45AM +0800, Huazhong Tan wrote:
>> From: Weihang Li <liweihang@hisilicon.com>
>>
>> MAC tnl interruptions are different from other type of RAS and MSI-X
>> errors, because some bits, such as OVF/LR/RF will occur during link up
>> and down.
>>
>> The drivers should clear status of all MAC tnl interruption bits but
>> shouldn't print any message that would mislead the users.
>>
>> In case that link down and re-up in a short time because of some reasons,
>> we record when they occurred, and users can query them by debugfs.
>>
>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>> Signed-off-by: Peng Li <lipeng321@huawei.com>
>> ---
>> <snip>>
>>   					     bool en)
>>   {
>> @@ -1611,6 +1636,7 @@ pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev)
>>   int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
>>   			       unsigned long *reset_requests)
>>   {
>> +	struct hclge_mac_tnl_stats mac_tnl_stats;
>>   	struct device *dev = &hdev->pdev->dev;
>>   	u32 mpf_bd_num, pf_bd_num, bd_num;
>>   	enum hnae3_reset_type reset_level;
>> @@ -1745,6 +1771,31 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
>>   		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
>>   	}
>>   
>> +	/* query and clear mac tnl interruptions */
>> +	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_QUERY_MAC_TNL_INT,
>> +				   true);
>> +	ret = hclge_cmd_send(&hdev->hw, &desc[0], 1);
> Is this running in interrupt context ever?  I don't think it is, but the
> function name makes me think otherwise.  If it is, this could be unsafe as you
> take a spinlock in hclge_cmd_send, which is protected against bottom halves, but
> not interrupts.  That could cause a deadlock if there is a path to get here
> directly from an interrupt context.
> Neil
> 

This function is not running in interrupt context. When the driver 
recieve the msix interrupt, the irq_handler will schedule a task to call 
this function for querying more information about the msix interrupt.

Best Regards, Huazhong

> 
> .
> 

