Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC225C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97776206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390565AbfFKObG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:31:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389253AbfFKObG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:31:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4F516FEE0235508DC7CC;
        Tue, 11 Jun 2019 22:31:02 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 22:30:56 +0800
Subject: Re: [PATCH v3] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
To:     Jessica Yu <jeyu@kernel.org>
References: <20190530134304.4976-1-yuehaibing@huawei.com>
 <20190603144554.18168-1-yuehaibing@huawei.com>
 <20190611133344.GA9114@linux-8ccs>
CC:     <gregkh@linuxfoundation.org>, <mbenes@suse.cz>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <362632a8-9fa8-e72a-e4f5-1bd459b922fc@huawei.com>
Date:   Tue, 11 Jun 2019 22:30:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190611133344.GA9114@linux-8ccs>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/11 21:33, Jessica Yu wrote:
> +++ YueHaibing [03/06/19 22:45 +0800]:
>> In module_add_modinfo_attrs if sysfs_create_file
>> fails, we forget to free allocated modinfo_attrs
>> and roll back the sysfs files.
>>
>> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v3: reuse module_remove_modinfo_attrs
>> v2: free from '--i' instead of 'i--'
>> ---
>> kernel/module.c | 21 ++++++++++++++++-----
>> 1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 80c7c09..c6b8912 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1697,6 +1697,8 @@ static int add_usage_links(struct module *mod)
>>     return ret;
>> }
>>
>> +static void module_remove_modinfo_attrs(struct module *mod, int end);
>> +
>> static int module_add_modinfo_attrs(struct module *mod)
>> {
>>     struct module_attribute *attr;
>> @@ -1711,24 +1713,33 @@ static int module_add_modinfo_attrs(struct module *mod)
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
>> +    module_remove_modinfo_attrs(mod, --i);
> 
> Gah, I think there is another issue here - if sysfs_create_file()
> fails on the first iteration of the loop (so i = 0), then we will go
> to error_out and end up calling module_remove_modinfo_attrs(mod, -1),
> which, for i = 0, will call sysfs_remove_file() since attr->attr.name
> had already been set before the failed call to sysfs_create_file().
> Perhaps we need to check that i > 0 before calling
> module_remove_modinfo_attrs() under error_out?

Indeed, this should be checked, thanks!

> 
>>     return error;
>> }
>>
>> -static void module_remove_modinfo_attrs(struct module *mod)
>> +static void module_remove_modinfo_attrs(struct module *mod, int end)
>> {
>>     struct module_attribute *attr;
>>     int i;
>>
>>     for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
>> +        if (end >= 0 && i > end)
>> +            break;
>>         /* pick a field to test for end of list */
>>         if (!attr->attr.name)
>>             break;
>> @@ -1816,7 +1827,7 @@ static int mod_sysfs_setup(struct module *mod,
>>     return 0;
>>
>> out_unreg_modinfo_attrs:
>> -    module_remove_modinfo_attrs(mod);
>> +    module_remove_modinfo_attrs(mod, -1);
>> out_unreg_param:
>>     module_param_sysfs_remove(mod);
>> out_unreg_holders:
>> @@ -1852,7 +1863,7 @@ static void mod_sysfs_fini(struct module *mod)
>> {
>> }
>>
>> -static void module_remove_modinfo_attrs(struct module *mod)
>> +static void module_remove_modinfo_attrs(struct module *mod, int end)
>> {
>> }
>>
>> @@ -1868,7 +1879,7 @@ static void init_param_lock(struct module *mod)
>> static void mod_sysfs_teardown(struct module *mod)
>> {
>>     del_usage_links(mod);
>> -    module_remove_modinfo_attrs(mod);
>> +    module_remove_modinfo_attrs(mod, -1);
>>     module_param_sysfs_remove(mod);
>>     kobject_put(mod->mkobj.drivers_dir);
>>     kobject_put(mod->holders_dir);
>> -- 
>> 1.8.3.1
>>
>>
> 
> .
> 

