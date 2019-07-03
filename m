Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB060C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6842063F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGCB3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:29:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfGCB3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:29:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2D9FCF20B30474FBDB7F;
        Wed,  3 Jul 2019 09:29:10 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 3 Jul 2019
 09:29:03 +0800
Subject: Re: [PATCH] module: add usage links when calling ref_module func
To:     Jessica Yu <jeyu@kernel.org>
CC:     <rusty@rustcorp.com.au>, <kay.sievers@vrfy.org>,
        <clabbe.montjoie@gmail.com>, <linux-kernel@vger.kernel.org>,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>
References: <8d7aa8b1-73a2-db7a-82c8-06917eddf235@huawei.com>
 <20190701135556.GA25484@linux-8ccs>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <4473a66b-4aee-1d22-aec8-9d6bceb5b303@huawei.com>
Date:   Wed, 3 Jul 2019 09:28:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190701135556.GA25484@linux-8ccs>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/1 21:55, Jessica Yu wrote:
> +++ Zhiqiang Liu [28/06/19 20:32 +0800]:
>> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>
>> Problem: Users can call ref_module func in their modules to construct
>> relationships with other modules. However, the holders
>> '/sys/module/<mod-name>/holders' of the target module donot include
>> the users` module. So lsmod command misses detailed info of 'Used by'.
>>
>> Here, we will add usage link of a to b's holder_dir.
>>
>> Fixes: 9bea7f239 ("module: fix bne2 "gave up waiting for init of module libcrc32c")
> 
> I think we can drop this tag; it doesn't fix a bug specifically
> introduced by that particular commit.
> 
Thanks for your reply.
I will remove the Fixes tag in v2 patch.

>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>> kernel/module.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 80c7c09584cf..11c6aff37b1f 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -871,6 +871,11 @@ int ref_module(struct module *a, struct module *b)
>>         module_put(b);
>>         return err;
>>     }
>> +
>> +    err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
>> +    if (err)
>> +        return err;
> 
> We need to fix the error handling here - the module_use struct
> allocated in the call to add_module_usage() needs to be freed (you
> could just modify add_module_usage() to return the use pointer so that
> it's easier to free from within ref_module()), module_put() needs to
> be called, and the use struct should be removed from its respective
> lists (see module_unload_free()).
> 
Thanks again for your advice.
We will modify add_module_usage func to return the use pointer as your suggestion.
In the error handling, We will call module_put() and call list_del() to remove the use.

> Thanks,
> 
> Jessica
> 
> 
> .
> 

