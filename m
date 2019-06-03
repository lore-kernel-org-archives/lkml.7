Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808AB25364
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFCMLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:11:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727154AbfFCMLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:11:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D093AF0F;
        Mon,  3 Jun 2019 12:11:17 +0000 (UTC)
Date:   Mon, 3 Jun 2019 14:11:16 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     jeyu@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, paulmck@linux.ibm.com
Subject: Re: [PATCH v2] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
In-Reply-To: <20190530134304.4976-1-yuehaibing@huawei.com>
Message-ID: <alpine.LSU.2.21.1906031351150.1468@pobox.suse.cz>
References: <20190515161212.28040-1-yuehaibing@huawei.com> <20190530134304.4976-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, YueHaibing wrote:

> In module_add_modinfo_attrs if sysfs_create_file
> fails, we forget to free allocated modinfo_attrs
> and roll back the sysfs files.
> 
> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: free from '--i' instead of 'i--'  
> ---
>  kernel/module.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 6e6712b..78e21a7 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1723,15 +1723,29 @@ static int module_add_modinfo_attrs(struct module *mod)
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
>  			++temp_attr;
>  		}
>  	}
> +
> +	return 0;
> +
> +error_out:
> +	for (; (attr = &mod->modinfo_attrs[i]) && i >= 0; --i) {
> +		if (!attr->attr.name)
> +			break;
> +		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
> +		if (attr->free)
> +			attr->free(mod);
> +	}
> +	kfree(mod->modinfo_attrs);
>  	return error;
>  }

Hi,

would not be better to reuse the existing code in 
module_remove_modinfo_attrs() instead of duplication? You could add a new 
parameter "limit" or something and call the function here. I suppose the 
order does not matter and if it does you could rename it "start" and go 
backwards like in your patch.

Btw, looking more into it, it would also be possible to let 
mod_sysfs_setup() go to out_unreg_modinfo_attrs in case of an error from 
module_add_modinfo_attrs() (and then clean the error handling in 
mod_sysfs_setup() a bit). module_remove_modinfo_attrs() almost does the 
right thing, because it checks attr->attr.name. The only problem is the
last failing attribute, because it would have attr.name set, but its 
sysfs_create_file() failed. So calling sysfs_remove_file() and the rest 
would not be correct in that case.

Miroslav
