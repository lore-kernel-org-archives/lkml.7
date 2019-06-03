Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C32C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE772807D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfFCMlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:41:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfFCMlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:41:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54A4B40C7BBAC10F9B8E;
        Mon,  3 Jun 2019 20:41:33 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 20:41:32 +0800
Subject: Re: [PATCH v2] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
To:     Jessica Yu <jeyu@kernel.org>
References: <20190515161212.28040-1-yuehaibing@huawei.com>
 <20190530134304.4976-1-yuehaibing@huawei.com>
 <20190603104716.GA21759@linux-8ccs>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <paulmck@linux.ibm.com>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <131515d0-652a-c292-ec17-0722e2a4d465@huawei.com>
Date:   Mon, 3 Jun 2019 20:41:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190603104716.GA21759@linux-8ccs>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/6/3 18:47, Jessica Yu wrote:
> +++ YueHaibing [30/05/19 21:43 +0800]:
>> In module_add_modinfo_attrs if sysfs_create_file
>> fails, we forget to free allocated modinfo_attrs
>> and roll back the sysfs files.
>>
>> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: free from '--i' instead of 'i--'
>> ---
>> kernel/module.c | 16 +++++++++++++++-
>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 6e6712b..78e21a7 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1723,15 +1723,29 @@ static int module_add_modinfo_attrs(struct module *mod)
>>         return -ENOMEM;
>>
>>     temp_attr = mod->modinfo_attrs;
>> -    for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
>> +    for (i = 0; (attr = modinfo_attrs[i]); i++) {
>>         if (!attr->test || attr->test(mod)) {
>>             memcpy(temp_attr, attr, sizeof(*temp_attr));
>>             sysfs_attr_init(&temp_attr->attr);
>>             error = sysfs_create_file(&mod->mkobj.kobj,
>>                     &temp_attr->attr);
>> +            if (error)
>> +                goto error_out;
>>             ++temp_attr;
>>         }
>>     }
>> +
>> +    return 0;
>> +
>> +error_out:
>> +    for (; (attr = &mod->modinfo_attrs[i]) && i >= 0; --i) {
> 
> The increment step is executed after the body of the loop, so this is
> still starting at i instead of i - 1. I think we need:
> 
>     for (--i; (attr = &mod->modinfo_attrs[i]) && i >= 0; i--)

oops, my bad, will fix it.

> 
> Thanks,
> 
> Jessica
> 
>> +        if (!attr->attr.name)
>> +            break;
>> +        sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
>> +        if (attr->free)
>> +            attr->free(mod);
>> +    }
>> +    kfree(mod->modinfo_attrs);
>>     return error;
>> }
>>
>> -- 
>> 2.7.4
>>
>>
> 
> .
> 

