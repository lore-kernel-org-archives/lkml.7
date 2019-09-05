Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A2C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707B22173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfIELCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:02:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731215AbfIELCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:02:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 324E2C1412B37ADEF3DF;
        Thu,  5 Sep 2019 19:01:59 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 19:01:50 +0800
Subject: Re: [PATCH net-next 4/7] net: hns3: add client node validity judgment
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Peng Li <lipeng321@huawei.com>
References: <1567606006-39598-1-git-send-email-tanhuazhong@huawei.com>
 <1567606006-39598-5-git-send-email-tanhuazhong@huawei.com>
 <b0aa6da6-cd42-dd31-8ff7-ca3f48de58ff@cogentembedded.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <88ca250d-0eb5-a150-0142-32b41b89c703@huawei.com>
Date:   Thu, 5 Sep 2019 19:01:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <b0aa6da6-cd42-dd31-8ff7-ca3f48de58ff@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/5 18:12, Sergei Shtylyov wrote:
> On 04.09.2019 17:06, Huazhong Tan wrote:
> 
>> From: Peng Li <lipeng321@huawei.com>
>>
>> HNS3 driver can only unregister client which included in 
>> hnae3_client_list.
>> This patch adds the client node validity judgment.
>>
>> Signed-off-by: Peng Li <lipeng321@huawei.com>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hnae3.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c 
>> b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
>> index 528f624..6aa5257 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
>> @@ -138,12 +138,28 @@ EXPORT_SYMBOL(hnae3_register_client);
>>   void hnae3_unregister_client(struct hnae3_client *client)
>>   {
>> +    struct hnae3_client *client_tmp;
>>       struct hnae3_ae_dev *ae_dev;
>> +    bool existed = false;
>>       if (!client)
>>           return;
>>       mutex_lock(&hnae3_common_lock);
>> +
>> +    list_for_each_entry(client_tmp, &hnae3_client_list, node) {
>> +        if (client_tmp->type == client->type) {
>> +            existed = true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!existed) {
>> +        mutex_unlock(&hnae3_common_lock);
>> +        pr_err("client %s not existed!\n", client->name);
> 
>     Did not exist, you mean?
> 

yes

> [...]
> 
> MBR, Sergei
> 
> .
> 

