Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5437CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24752222B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKTBg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:36:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbfKTBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:36:56 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 608C93AEE0F3A86D25D2;
        Wed, 20 Nov 2019 09:36:54 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 09:36:44 +0800
Subject: Re: [PATCH net] net: hns3: fix a wrong reset interrupt status mask
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>
References: <1574130708-30767-1-git-send-email-tanhuazhong@huawei.com>
 <20191119.153603.2158592594523337284.davem@davemloft.net>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <707be979-7716-5669-ad91-ff0fdbcc101d@huawei.com>
Date:   Wed, 20 Nov 2019 09:36:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191119.153603.2158592594523337284.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/20 7:36, David Miller wrote:
> From: Huazhong Tan <tanhuazhong@huawei.com>
> Date: Tue, 19 Nov 2019 10:31:48 +0800
> 
>> According to hardware user manual, bits5~7 in register
>> HCLGE_MISC_VECTOR_INT_STS means reset interrupts status,
>> but HCLGE_RESET_INT_M is defined as bits0~2 now. So it
>> will make hclge_reset_err_handle() read the wrong reset
>> interrupt status.
>>
>> This patch fixes it and prints out the register value.
>>
>> Fixes: 2336f19d7892 ("net: hns3: check reset interrupt status when reset fails")
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> 
> Fix exactly _one_ thing or else you make your patch hard to review.
> 
> The bug is that the bits are wrong, just fix the bits!
> 

ok, thanks

>>   
>> +	u32 msix_sts_reg;
>> +
>> +	msix_sts_reg = hclge_read_dev(&hdev->hw, HCLGE_MISC_VECTOR_INT_STS);
>> +
>>   	if (hdev->reset_pending) {
> 
> Now you are reading a register, and potentially clearing status bits and
> causing other side effects, that would not happen in this code path
> where hdev->reset_pending is true.
> 
> Don't do stuff like this!
> 
> If you want to add code to print out the register value, that is a
> separate patch, for net-next, and it must be done properly.  In that
> you should only read the register in the same code paths you do
> previously.   Otherwise you must _clearly_ explain why reading the
> register value in new code paths is OK, and the side effects will
> not potentially cause problems for the pending reset operation.  It
> is still going to be a net-next improvement only.
> 
> Thank you.

I will separate it, and resend the fix to -net.
Thanks.

> 
> .
> 

