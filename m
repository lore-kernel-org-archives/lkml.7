Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C189C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C3927B6E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfFCOpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:45:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbfFCOpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:45:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5E9311A6A4288644CC;
        Mon,  3 Jun 2019 22:45:11 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 22:45:09 +0800
Subject: Re: [PATCH v2] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
To:     Miroslav Benes <mbenes@suse.cz>
References: <20190515161212.28040-1-yuehaibing@huawei.com>
 <20190530134304.4976-1-yuehaibing@huawei.com>
 <alpine.LSU.2.21.1906031351150.1468@pobox.suse.cz>
CC:     <jeyu@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <paulmck@linux.ibm.com>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <27d47cab-b40b-3566-1a01-db11ada9815b@huawei.com>
Date:   Mon, 3 Jun 2019 22:45:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1906031351150.1468@pobox.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/3 20:11, Miroslav Benes wrote:
> On Thu, 30 May 2019, YueHaibing wrote:
> 
>> In module_add_modinfo_attrs if sysfs_create_file
>> fails, we forget to free allocated modinfo_attrs
>> and roll back the sysfs files.
>>
>> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: free from '--i' instead of 'i--'  
>> ---
>>  kernel/module.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 6e6712b..78e21a7 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1723,15 +1723,29 @@ static int module_add_modinfo_attrs(struct module *mod)
>>  		return -ENOMEM;
>>  
>>  	temp_attr = mod->modinfo_attrs;
>> -	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
>> +	for (i = 0; (attr = modinfo_attrs[i]); i++) {
>>  		if (!attr->test || attr->test(mod)) {
>>  			memcpy(temp_attr, attr, sizeof(*temp_attr));
>>  			sysfs_attr_init(&temp_attr->attr);
>>  			error = sysfs_create_file(&mod->mkobj.kobj,
>>  					&temp_attr->attr);
>> +			if (error)
>> +				goto error_out;
>>  			++temp_attr;
>>  		}
>>  	}
>> +
>> +	return 0;
>> +
>> +error_out:
>> +	for (; (attr = &mod->modinfo_attrs[i]) && i >= 0; --i) {
>> +		if (!attr->attr.name)
>> +			break;
>> +		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
>> +		if (attr->free)
>> +			attr->free(mod);
>> +	}
>> +	kfree(mod->modinfo_attrs);
>>  	return error;
>>  }
> 
> Hi,
> 
> would not be better to reuse the existing code in 
> module_remove_modinfo_attrs() instead of duplication? You could add a new 
> parameter "limit" or something and call the function here. I suppose the 
> order does not matter and if it does you could rename it "start" and go 
> backwards like in your patch.

This make sense, try do it in v3, thanks!

> 
> Btw, looking more into it, it would also be possible to let 
> mod_sysfs_setup() go to out_unreg_modinfo_attrs in case of an error from 
> module_add_modinfo_attrs() (and then clean the error handling in 
> mod_sysfs_setup() a bit). module_remove_modinfo_attrs() almost does the 
> right thing, because it checks attr->attr.name. The only problem is the
> last failing attribute, because it would have attr.name set, but its 
> sysfs_create_file() failed. So calling sysfs_remove_file() and the rest 
> would not be correct in that case.
> 
> Miroslav
> 
> .
> 

