Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FDCC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEC32133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559916176;
	bh=yANB6XpweTjBX/1ZhMGTcILFCBjA6g8yFg9pmt84a2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xD+qKx3rJJ/RjG6UjVN7Vsn+py+kAiYJwiMJFjC2yZQT718siKdbo/nbqq8wGq+nO
	 Hzk+WeiihF0Lc/O+FTBpvNX2GvaRjhZheH0HwGPqrG9IZ5oBcgpsQdR5mxAZbSSLMq
	 AtxQ3HmtT9mumTmGoK/PKubvWHILZp3/FjqPJq8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfFGOCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfFGOCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:02:55 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE132208E3;
        Fri,  7 Jun 2019 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559916173;
        bh=yANB6XpweTjBX/1ZhMGTcILFCBjA6g8yFg9pmt84a2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xf4RGhvOB+GfodvUhSWUM0Ps9zCJzbmqMyi5WIzZLyDKA8FgQxHcVgHPCWZDlA4nb
         s1ffLNX1MNPhbnDaVNE94P6T7yPXl3nhq2eDAJbaugFeGY1Nv4WhO/TG2GYqg1IEQ3
         Fc6EdmJ5OvxBo0W/lDrKpO/IhJ0t5HMpzoO2cGn4=
Date:   Fri, 7 Jun 2019 16:02:50 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     YueHaibing <yuehaibing@huawei.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
Message-ID: <20190607140250.GB4211@linux-8ccs>
References: <20190530134304.4976-1-yuehaibing@huawei.com>
 <20190603144554.18168-1-yuehaibing@huawei.com>
 <alpine.LSU.2.21.1906041107510.16030@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1906041107510.16030@pobox.suse.cz>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [04/06/19 12:46 +0200]:
>On Mon, 3 Jun 2019, YueHaibing wrote:
>
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
>>  kernel/module.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>
>I'm afraid it is not completely correct.
>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 80c7c09..c6b8912 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1697,6 +1697,8 @@ static int add_usage_links(struct module *mod)
>>  	return ret;
>>  }
>>
>> +static void module_remove_modinfo_attrs(struct module *mod, int end);
>> +
>>  static int module_add_modinfo_attrs(struct module *mod)
>>  {
>>  	struct module_attribute *attr;
>> @@ -1711,24 +1713,33 @@ static int module_add_modinfo_attrs(struct module *mod)
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
>
>sysfs_create_file() failed, so we need to clear all previously processed
>attrs and not the current one.
>
>>  			++temp_attr;
>>  		}
>>  	}
>> +
>> +	return 0;
>> +
>> +error_out:
>> +	module_remove_modinfo_attrs(mod, --i);
>
>It says "call sysfs_remove_file() on all attrs ending with --i included
>(all correctly processed attrs).
>
>>  	return error;
>>  }
>>
>> -static void module_remove_modinfo_attrs(struct module *mod)
>> +static void module_remove_modinfo_attrs(struct module *mod, int end)
>>  {
>>  	struct module_attribute *attr;
>>  	int i;
>>
>>  	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
>> +		if (end >= 0 && i > end)
>> +			break;
>
>If end == 0, you break the loop without calling sysfs_remove_file(), which
>is a bug if you called module_remove_modinfo_attrs(mod, 0).
>
>Calling module_remove_modinfo_attrs(mod, i); in module_add_modinfo_attrs()
>under error_out label and changing the condition here to
>
>if (end >= 0 && i >= end)
>	break;
>
>should work as expected.
>
>But let me ask another question and it might be more to Jessica. Why is
>there even a call to attr->free(mod); (if it exists) in
>module_remove_modinfo_attrs()? The same is in free_modinfo() (as opposed
>to setup_modinfo() where attr->setup(mod) is called. Is it because
>free_modinfo() is called only in load_module()'s error path, while
>module_remove_modinfo_attrs() is called even in free_module() path?
>
>kfree() checks for NULL pointer, so there is no bug, but it is certainly
>not nice and it calls for cleanup. But I may be missing something.

No, you are right in that it is a bit clumsy and and the sysfs error
path handling is asymmetrical. I think it could be cleaned up a bit.

IMO, I think the attr->free() calls should either be (1) removed from
module_remove_modinfo_attrs() as free_modinfo() takes care of that,
otherwise we could potentially call attr->free() twice (once in the
internal error handling of mod_sysfs_setup() and once again in the
free_modinfo: label in load_module()) or option (2) would be to merge
the attr->setup() calls into module_add_modinfo_attrs() so that it is
symmetrical to module_remove_modinfo_attrs(). I'm leaning towards
option 2 but have not carefully checked yet if moving the
attr->setup() calls into module_add_modinfo_attrs() would break
anything. In any case I will prepare some cleanup patches for this.

Thanks!

Jessica
