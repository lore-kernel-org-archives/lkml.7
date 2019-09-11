Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821DFC49ED7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 03:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BED32171F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 03:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfIKDR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 23:17:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfIKDR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 23:17:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 751608BE641628B3B9F7;
        Wed, 11 Sep 2019 11:17:24 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 11:17:16 +0800
Subject: Re: [PATCH v3] module: add link_flag pram in ref_module func to
 decide whether add usage link
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     Jessica Yu <jeyu@kernel.org>, <rusty@rustcorp.com.au>,
        <kay.sievers@vrfy.org>, <clabbe.montjoie@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <wangxiaogang3@huawei.com>,
        <zhoukang7@huawei.com>, Mingfangsen <mingfangsen@huawei.com>
References: <48019b31-3a74-1821-8ad3-72c9ef1219ba@huawei.com>
Message-ID: <c9b837f9-4d70-107e-52d4-0eb2f7d2d99c@huawei.com>
Date:   Wed, 11 Sep 2019 11:16:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <48019b31-3a74-1821-8ad3-72c9ef1219ba@huawei.com>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly Ping...

On 2019/7/20 22:40, Zhiqiang Liu wrote:
> Users can call ref_module func in their modules to construct
> relationships with other modules. However, the holders
> '/sys/module/<mod-name>/holders' of the target module donot include
> the users` module. So lsmod command misses detailed info of 'Used by'.
> 
> When load module, the process is given as follows,
> load_module()
> 	-> mod_sysfs_setup()
> 		-> add_usage_links
> 	-> do_init_module
> 		-> mod->init()
> 
> add_usage_links func creates holders of target modules linking to
> this module. If ref_module is called in mod->init() func, the usage
> links cannot be added.
> 
> Consider that add_module_usage and add usage_link may separate, the
> link_flag pram is added in ref_module func to decide whether add usage
> link after add_module_usage. If link_flag is true, it means usage link
> of a to b's holder_dir should be created immediately after add_module_usage.
> 
> V2->V3:
> - add link_flag pram in ref_module func to decide whether add usage link
> 
> V1->V2:
> - remove incorrect Fixes tag
> - fix error handling of sysfs_create_link as suggested by Jessica Yu
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Suggested-by: Jessica Yu <jeyu@kernel.org>
> Reviewed-by: Kang Zhou <zhoukang7@huawei.com>
> ---
>  include/linux/module.h |  2 +-
>  kernel/module.c        | 27 ++++++++++++++++++++-------
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 188998d3dca9..9ec04b9e93e8 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -632,7 +632,7 @@ static inline void __module_get(struct module *module)
>  #define symbol_put_addr(p) do { } while (0)
> 
>  #endif /* CONFIG_MODULE_UNLOAD */
> -int ref_module(struct module *a, struct module *b);
> +int ref_module(struct module *a, struct module *b, bool link_flag);
> 
>  /* This is a #define so the string doesn't get put in every .o file */
>  #define module_name(mod)			\
> diff --git a/kernel/module.c b/kernel/module.c
> index 80c7c09584cf..00e4862a8ef7 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -837,25 +837,26 @@ static int already_uses(struct module *a, struct module *b)
>   *    'b' can walk the list to see who sourced them), and of 'a'
>   *    targets (so 'a' can see what modules it targets).
>   */
> -static int add_module_usage(struct module *a, struct module *b)
> +static struct module_use *add_module_usage(struct module *a, struct module *b)
>  {
>  	struct module_use *use;
> 
>  	pr_debug("Allocating new usage for %s.\n", a->name);
>  	use = kmalloc(sizeof(*use), GFP_ATOMIC);
>  	if (!use)
> -		return -ENOMEM;
> +		return NULL;
> 
>  	use->source = a;
>  	use->target = b;
>  	list_add(&use->source_list, &b->source_list);
>  	list_add(&use->target_list, &a->target_list);
> -	return 0;
> +	return use;
>  }
> 
>  /* Module a uses b: caller needs module_mutex() */
> -int ref_module(struct module *a, struct module *b)
> +int ref_module(struct module *a, struct module *b, bool link_flag)
>  {
> +	struct module_use *use;
>  	int err;
> 
>  	if (b == NULL || already_uses(a, b))
> @@ -866,9 +867,21 @@ int ref_module(struct module *a, struct module *b)
>  	if (err)
>  		return err;
> 
> -	err = add_module_usage(a, b);
> +	use = add_module_usage(a, b);
> +	if (!use) {
> +		module_put(b);
> +		return -ENOMEM;
> +	}
> +
> +	if (!link_flag)
> +		return 0;
> +
> +	err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
>  	if (err) {
>  		module_put(b);
> +		list_del(&use->source_list);
> +		list_del(&use->target_list);
> +		kfree(use);
>  		return err;
>  	}
>  	return 0;
> @@ -1152,7 +1165,7 @@ static inline void module_unload_free(struct module *mod)
>  {
>  }
> 
> -int ref_module(struct module *a, struct module *b)
> +int ref_module(struct module *a, struct module *b, bool link_flag)
>  {
>  	return strong_try_module_get(b);
>  }
> @@ -1407,7 +1420,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
>  		goto getname;
>  	}
> 
> -	err = ref_module(mod, owner);
> +	err = ref_module(mod, owner, false);
>  	if (err) {
>  		sym = ERR_PTR(err);
>  		goto getname;
> 

