Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0699AC5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 06:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96C22089C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 06:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGFGSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 02:18:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfGFGSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 02:18:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 55ECC99253F3C03CB4B3;
        Sat,  6 Jul 2019 14:18:17 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 6 Jul 2019
 14:18:10 +0800
Subject: Re: [PATCH v2] module: add usage links when calling ref_module func
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     Jessica Yu <jeyu@kernel.org>, <rusty@rustcorp.com.au>,
        <kay.sievers@vrfy.org>, <clabbe.montjoie@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <wangxiaogang3@huawei.com>,
        <zhoukang7@huawei.com>, Mingfangsen <mingfangsen@huawei.com>
References: <4fec6c3b-03b8-dd57-4009-99431105a8a5@huawei.com>
Message-ID: <7c865af8-a178-a10f-bdcb-7750ab27c2ce@huawei.com>
Date:   Sat, 6 Jul 2019 14:17:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <4fec6c3b-03b8-dd57-4009-99431105a8a5@huawei.com>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping ...

On 2019/7/3 10:09, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
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
> Here, we will add usage link of a to b's holder_dir.
> 
> V1->V2:
> - remove incorrect Fixes tag
> - fix error handling of sysfs_create_link as suggested by Jessica Yu
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Suggested-by: Jessica Yu <jeyu@kernel.org>
> Reviewed-by: Kang Zhou <zhoukang7@huawei.com>
> ---
>  kernel/module.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 80c7c09584cf..672abce2222c 100644
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
>  int ref_module(struct module *a, struct module *b)
>  {
> +	struct module_use *use;
>  	int err;
> 
>  	if (b == NULL || already_uses(a, b))
> @@ -866,9 +867,18 @@ int ref_module(struct module *a, struct module *b)
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
> +	err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
>  	if (err) {
>  		module_put(b);
> +		list_del(&use->source_list);
> +		list_del(&use->target_list);
> +		kfree(use);
>  		return err;
>  	}
>  	return 0;
> 

