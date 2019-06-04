Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D76C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4150623A68
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfFDKqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:46:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:34870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfFDKqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:46:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23DF3AFAF;
        Tue,  4 Jun 2019 10:46:09 +0000 (UTC)
Date:   Tue, 4 Jun 2019 12:46:08 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     jeyu@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
In-Reply-To: <20190603144554.18168-1-yuehaibing@huawei.com>
Message-ID: <alpine.LSU.2.21.1906041107510.16030@pobox.suse.cz>
References: <20190530134304.4976-1-yuehaibing@huawei.com> <20190603144554.18168-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019, YueHaibing wrote:

> In module_add_modinfo_attrs if sysfs_create_file
> fails, we forget to free allocated modinfo_attrs
> and roll back the sysfs files.
> 
> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: reuse module_remove_modinfo_attrs
> v2: free from '--i' instead of 'i--'
> ---
>  kernel/module.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

I'm afraid it is not completely correct.
 
> diff --git a/kernel/module.c b/kernel/module.c
> index 80c7c09..c6b8912 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1697,6 +1697,8 @@ static int add_usage_links(struct module *mod)
>  	return ret;
>  }
>  
> +static void module_remove_modinfo_attrs(struct module *mod, int end);
> +
>  static int module_add_modinfo_attrs(struct module *mod)
>  {
>  	struct module_attribute *attr;
> @@ -1711,24 +1713,33 @@ static int module_add_modinfo_attrs(struct module *mod)
>  		return -ENOMEM;
>  
>  	temp_attr = mod->modinfo_attrs;
> -	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
> +	for (i = 0; (attr = modinfo_attrs[i]); i++) {
>  		if (!attr->test || attr->test(mod)) {
>  			memcpy(temp_attr, attr, sizeof(*temp_attr));
>  			sysfs_attr_init(&temp_attr->attr);
>  			error = sysfs_create_file(&mod->mkobj.kobj,
>  					&temp_attr->attr);
> +			if (error)
> +				goto error_out;

sysfs_create_file() failed, so we need to clear all previously processed 
attrs and not the current one.

>  			++temp_attr;
>  		}
>  	}
> +
> +	return 0;
> +
> +error_out:
> +	module_remove_modinfo_attrs(mod, --i);

It says "call sysfs_remove_file() on all attrs ending with --i included 
(all correctly processed attrs).

>  	return error;
>  }
>  
> -static void module_remove_modinfo_attrs(struct module *mod)
> +static void module_remove_modinfo_attrs(struct module *mod, int end)
>  {
>  	struct module_attribute *attr;
>  	int i;
>  
>  	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
> +		if (end >= 0 && i > end)
> +			break;

If end == 0, you break the loop without calling sysfs_remove_file(), which 
is a bug if you called module_remove_modinfo_attrs(mod, 0).

Calling module_remove_modinfo_attrs(mod, i); in module_add_modinfo_attrs() 
under error_out label and changing the condition here to 

if (end >= 0 && i >= end)
	break;

should work as expected.

But let me ask another question and it might be more to Jessica. Why is 
there even a call to attr->free(mod); (if it exists) in 
module_remove_modinfo_attrs()? The same is in free_modinfo() (as opposed 
to setup_modinfo() where attr->setup(mod) is called. Is it because 
free_modinfo() is called only in load_module()'s error path, while 
module_remove_modinfo_attrs() is called even in free_module() path?

kfree() checks for NULL pointer, so there is no bug, but it is certainly 
not nice and it calls for cleanup. But I may be missing something.

Regards,
Miroslav
