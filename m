Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DCC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD4C25453
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfE3JYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:24:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfE3JYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:24:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FE9EAEEAA03EE4475B0;
        Thu, 30 May 2019 17:24:27 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 17:24:23 +0800
Subject: Re: [PATCH] kernel/module: Fix mem leak in module_add_modinfo_attrs
To:     <jeyu@kernel.org>, <gregkh@linuxfoundation.org>
References: <20190515161212.28040-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <paulmck@linux.ibm.com>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <60ececa2-2741-c4e5-c028-35d95cbeb731@huawei.com>
Date:   Thu, 30 May 2019 17:24:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190515161212.28040-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On 2019/5/16 0:12, YueHaibing wrote:
> In module_add_modinfo_attrs if sysfs_create_file
> fails, we forget to free allocated modinfo_attrs
> and roll back the sysfs files.
> 
> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/module.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 0b9aa8a..7da73c4 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1714,15 +1714,29 @@ static int module_add_modinfo_attrs(struct module *mod)
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
> +	for (; (attr = &mod->modinfo_attrs[i]) && i >= 0; i--) {
> +		if (!attr->attr.name)
> +			break;
> +		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
> +		if (attr->free)
> +			attr->free(mod);
> +	}
> +	kfree(mod->modinfo_attrs);
>  	return error;
>  }
>  
> 

