Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C007420811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfDYGGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:06:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfDYGGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:06:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EB78C4F7AB050DFD9CA7;
        Thu, 25 Apr 2019 14:06:16 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Apr 2019
 14:06:08 +0800
Subject: Re: [PATCH V2 net-next 08/12] net: hns3: stop schedule reset service
 while unloading driver
To:     Neil Horman <nhorman@redhat.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Peng Li <lipeng321@huawei.com>
References: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
 <1556103931-64031-9-git-send-email-tanhuazhong@huawei.com>
 <20190424135524.GE6661@hmswarspite.think-freely.org>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <be5ba555-31bb-8803-66fa-51bfab70bde8@huawei.com>
Date:   Thu, 25 Apr 2019 14:06:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190424135524.GE6661@hmswarspite.think-freely.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/24 21:55, Neil Horman wrote:
> On Wed, Apr 24, 2019 at 07:05:27PM +0800, Huazhong Tan wrote:
>> This patch uses HCLGE_STATE_REMOVING/HCLGEVF_STATE_REMOVING flag to
>> indicate that the driver is unloading, and we should stop new coming
>> reset service to be scheduled, otherwise, reset service will access
>> some resource which has been freed by unloading.
>>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
>> Signed-off-by: Peng Li <lipeng321@huawei.com>
>> ---
>> V1->V2: fixes a flag setting error
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 +++-
>>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 +++-
>>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 1 +
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> index 4d5568e..ead8308 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -2175,7 +2175,8 @@ static void hclge_mbx_task_schedule(struct hclge_dev *hdev)
>>   
>>   static void hclge_reset_task_schedule(struct hclge_dev *hdev)
>>   {
>> -	if (!test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
>> +	if (!test_bit(HCLGE_STATE_REMOVING, &hdev->state) &&
>> +	    !test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
>>   		schedule_work(&hdev->rst_service_task);
>>   }
>>   
> 
> In what use case do you need an extra bit for this?  From my read, this work
> task only gets scheduled from:
> 1) Interrupt handlers
> 2) Its own service task
> 
> Based on the fact that you are calling cancel_work_sync(...rst_service_task)
> from the pci teardown routine, irqs should all be disabled on your devices
> already (meaning interrupts shouldn't schedule it), and cancel_work_sync
> guarantees that rearming cant happen from within its own service task.
> 
> Neil
>

Beside these two cases, when the client detects an error and requests a 
reset, it will call hclge_reset_event and schedule the reset work task 
to deal with the request. This may happen after calling 
cancel_work_sync(...rst_service_task) from the pci teardown routine.

Best Regards, Huazhong

> 
> .
> 

