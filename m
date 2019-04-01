Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D17C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022E120828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDAIpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:45:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfDAIpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:45:54 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 97F7CB9E5222BF692E0D;
        Mon,  1 Apr 2019 16:44:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Apr 2019
 16:44:36 +0800
Subject: Re: [PATCH] dccp: Fix memleak in __feat_register_sp
To:     Mukesh Ojha <mojha@codeaurora.org>, <davem@davemloft.net>,
        <gerrit@erg.abdn.ac.uk>
References: <20190401013554.17488-1-yuehaibing@huawei.com>
 <4ad301d4-7af2-87e4-9b52-9c4eee09b79c@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dccp@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <2022d726-4785-5d64-c8b5-37171d2dc220@huawei.com>
Date:   Mon, 1 Apr 2019 16:44:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4ad301d4-7af2-87e4-9b52-9c4eee09b79c@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/1 16:24, Mukesh Ojha wrote:
> 
> On 4/1/2019 7:05 AM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> If dccp_feat_push_change fails, we forget free the mem
>> which is alloced by kmemdup in dccp_feat_clone_sp_val.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
>> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> 
> 
> I don't think it is the first version. Do keep in mind to put detail here .

Yes, this is the v3 resend.

> 
> -Mukesh
> 
>>   net/dccp/feat.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/dccp/feat.c b/net/dccp/feat.c
>> index f227f00..db87d9f 100644
>> --- a/net/dccp/feat.c
>> +++ b/net/dccp/feat.c
>> @@ -738,7 +738,12 @@ static int __feat_register_sp(struct list_head *fn, u8 feat, u8 is_local,
>>       if (dccp_feat_clone_sp_val(&fval, sp_val, sp_len))
>>           return -ENOMEM;
>>   -    return dccp_feat_push_change(fn, feat, is_local, mandatory, &fval);
>> +    if (dccp_feat_push_change(fn, feat, is_local, mandatory, &fval)) {
>> +        kfree(fval.sp.vec);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    return 0;
>>   }
>>     /**
> 
> 

