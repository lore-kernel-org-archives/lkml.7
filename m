Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C30420835
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfCVNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:39:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728119AbfCVNjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:39:37 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 323F1982A746CDEA4EBA;
        Fri, 22 Mar 2019 21:39:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 21:39:32 +0800
Subject: Re: [PATCH] dccp: Fix memleak in __feat_register_sp
To:     Mukesh Ojha <mojha@codeaurora.org>, <davem@davemloft.net>,
        <gerrit@erg.abdn.ac.uk>
References: <20190321141058.14580-1-yuehaibing@huawei.com>
 <21f94a25-949a-1a6a-2ba2-59c829edeb04@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dccp@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a714b91a-fc8b-841b-6e9e-b4c18894fec7@huawei.com>
Date:   Fri, 22 Mar 2019 21:39:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <21f94a25-949a-1a6a-2ba2-59c829edeb04@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/22 19:52, Mukesh Ojha wrote:
> 
> On 3/21/2019 7:40 PM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> If dccp_feat_push_change fails, we forget free the mem
>> which is alloced by kmemdup in dccp_feat_clone_sp_val.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   net/dccp/feat.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/dccp/feat.c b/net/dccp/feat.c
>> index f227f00..083e012 100644
>> --- a/net/dccp/feat.c
>> +++ b/net/dccp/feat.c
>> @@ -738,7 +738,12 @@ static int __feat_register_sp(struct list_head *fn, u8 feat, u8 is_local,
>>       if (dccp_feat_clone_sp_val(&fval, sp_val, sp_len))
>>           return -ENOMEM;
>>   -    return dccp_feat_push_change(fn, feat, is_local, mandatory, &fval);
>> +    if (dccp_feat_push_change(fn, feat, is_local, mandatory, &fval)) {
>> +        kfree(val->sp.vec);
> 
> Please atleast check the compilation first, don't  just rush into sending patch.
> 
> s/val/fval

A copy-paste typo, will fix it. Thanks!

> 
> 
> Thanks,
> Mukesh
> 
>> +        return -ENOMEM;
>> +    }
>> +
>> +    return 0;
>>   }
>>     /**
> 
> .
> 

