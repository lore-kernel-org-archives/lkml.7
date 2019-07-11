Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0AFC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817B6208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfGKGJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:09:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfGKGJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:09:03 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06F992214731C6D96050;
        Thu, 11 Jul 2019 14:08:59 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 14:08:50 +0800
Subject: Re: [PATCH v2] module: add usage links when calling ref_module func
To:     Jessica Yu <jeyu@kernel.org>
CC:     <rusty@rustcorp.com.au>, <kay.sievers@vrfy.org>,
        <clabbe.montjoie@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        <wangxiaogang3@huawei.com>, <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>
References: <4fec6c3b-03b8-dd57-4009-99431105a8a5@huawei.com>
 <20190709161039.GA3501@linux-8ccs>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <de919fd8-afd8-244c-d316-19d5a3895406@huawei.com>
Date:   Thu, 11 Jul 2019 14:03:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190709161039.GA3501@linux-8ccs>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/10 0:10, Jessica Yu wrote:
> +++ Zhiqiang Liu [03/07/19 10:09 +0800]:
>> From: Zhiqiang Liu <liuzhiqiang26@huawei.com
>>
>> V1->V2:
>> - remove incorrect Fixes tag
>> - fix error handling of sysfs_create_link as suggested by Jessica Yu
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> Suggested-by: Jessica Yu <jeyu@kernel.org>
>> Reviewed-by: Kang Zhou <zhoukang7@huawei.com>
>> ---
>> kernel/module.c | 18 ++++++++++++++----
>> 1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 80c7c09584cf..672abce2222c 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -837,25 +837,26 @@ static int already_uses(struct module *a, struct module *b)
>>  *    'b' can walk the list to see who sourced them), and of 'a'
>>  *    targets (so 'a' can see what modules it targets).
>>  */
>> /* Module a uses b: caller needs module_mutex() */
>> int ref_module(struct module *a, struct module *b)
>> {
>> +    struct module_use *use;
>>     int err;
>>
>>     if (b == NULL || already_uses(a, b))
>> @@ -866,9 +867,18 @@ int ref_module(struct module *a, struct module *b)
>>     if (err)
>>         return err;
>>
>> -    err = add_module_usage(a, b);
>> +    use = add_module_usage(a, b);
>> +    if (!use) {
>> +        module_put(b);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
> 
> Sigh. This ultimately doesn't work because in load_module(), we use
> ref_module() in resolve_symbol(), and mod->mkobj.kobj doesn't get
> initialized until mod_sysfs_init(), which happens much later in
> load_module(). So what happens is that the ref_module(mod, owner) call
> in resolve_symbol() returns an error because sysfs_create_link() fails here.
> We could *maybe* move sysfs initialization earlier in load_module()
> but that is an entirely untested idea and I would need to think about
> that more.

Thank you for the reply.
I have tested the patch through livepatch. Maybe I miss somethings.
I will rewrite the patch and test it entirely before sending the v3 patch.

Thanks again.


