Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569DFC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2684E20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568232217;
	bh=eSKBQHqQuPyuwFll+C6Zb6SdP4uQ0WS5aQBuZWqqssA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1SwbYFTytGlzfqo2JujIZ68W3VZIuVr+tG+Hx/0GCsXPxcQ+CTYzt3Ga/v8tl/YPd
	 XtYqZCuPQ/83x9CWdXg5WoYGMy2C7m9+xhqAHwaSlNH9dKWkb3paDetpkwbB8cbrky
	 RJ7YtgOkVVD0ao9nzwmIoXB19mXviW9JQeP6lNzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfIKUDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKUDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:03:36 -0400
Received: from linux-8ccs (ip5f5ade65.dynamic.kabel-deutschland.de [95.90.222.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A327720838;
        Wed, 11 Sep 2019 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568232214;
        bh=eSKBQHqQuPyuwFll+C6Zb6SdP4uQ0WS5aQBuZWqqssA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xCryCJ0R2qM9TW2HITS6Ma2TGvXtGjkDLNlVYvIchTTsiyqYKwyfp2nyFjStrJOUp
         6DRFGV96bAema6+6JfxSw+7YzsYRuL870wTlTrwEgrLZQthLb5OcC+SIdedbfx4bVy
         2txnPXlCv+yiGbj8EJ54vG+b7qjfhfYyisVBZ3/Q=
Date:   Wed, 11 Sep 2019 22:03:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     rusty@rustcorp.com.au, kay.sievers@vrfy.org,
        clabbe.montjoie@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        wangxiaogang3@huawei.com, zhoukang7@huawei.com,
        Mingfangsen <mingfangsen@huawei.com>
Subject: Re: [PATCH v3] module: add link_flag pram in ref_module func to
 decide whether add usage link
Message-ID: <20190911200328.GC640@linux-8ccs>
References: <48019b31-3a74-1821-8ad3-72c9ef1219ba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <48019b31-3a74-1821-8ad3-72c9ef1219ba@huawei.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Zhiqiang Liu [20/07/19 22:40 +0800]:
>Users can call ref_module func in their modules to construct
>relationships with other modules. However, the holders
>'/sys/module/<mod-name>/holders' of the target module donot include
>the users` module. So lsmod command misses detailed info of 'Used by'.
>
>When load module, the process is given as follows,
>load_module()
>	-> mod_sysfs_setup()
>		-> add_usage_links
>	-> do_init_module
>		-> mod->init()
>
>add_usage_links func creates holders of target modules linking to
>this module. If ref_module is called in mod->init() func, the usage
>links cannot be added.
>
>Consider that add_module_usage and add usage_link may separate, the
>link_flag pram is added in ref_module func to decide whether add usage
>link after add_module_usage. If link_flag is true, it means usage link
>of a to b's holder_dir should be created immediately after add_module_usage.
>
>V2->V3:
>- add link_flag pram in ref_module func to decide whether add usage link
>
>V1->V2:
>- remove incorrect Fixes tag
>- fix error handling of sysfs_create_link as suggested by Jessica Yu
>
>Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>Suggested-by: Jessica Yu <jeyu@kernel.org>
>Reviewed-by: Kang Zhou <zhoukang7@huawei.com>
>---
> include/linux/module.h |  2 +-
> kernel/module.c        | 27 ++++++++++++++++++++-------
> 2 files changed, 21 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 188998d3dca9..9ec04b9e93e8 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -632,7 +632,7 @@ static inline void __module_get(struct module *module)
> #define symbol_put_addr(p) do { } while (0)
>
> #endif /* CONFIG_MODULE_UNLOAD */
>-int ref_module(struct module *a, struct module *b);
>+int ref_module(struct module *a, struct module *b, bool link_flag);
>
> /* This is a #define so the string doesn't get put in every .o file */
> #define module_name(mod)			\
>diff --git a/kernel/module.c b/kernel/module.c
>index 80c7c09584cf..00e4862a8ef7 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -837,25 +837,26 @@ static int already_uses(struct module *a, struct module *b)
>  *    'b' can walk the list to see who sourced them), and of 'a'
>  *    targets (so 'a' can see what modules it targets).
>  */
>-static int add_module_usage(struct module *a, struct module *b)
>+static struct module_use *add_module_usage(struct module *a, struct module *b)
> {
> 	struct module_use *use;
>
> 	pr_debug("Allocating new usage for %s.\n", a->name);
> 	use = kmalloc(sizeof(*use), GFP_ATOMIC);
> 	if (!use)
>-		return -ENOMEM;
>+		return NULL;
>
> 	use->source = a;
> 	use->target = b;
> 	list_add(&use->source_list, &b->source_list);
> 	list_add(&use->target_list, &a->target_list);
>-	return 0;
>+	return use;
> }
>
> /* Module a uses b: caller needs module_mutex() */
>-int ref_module(struct module *a, struct module *b)
>+int ref_module(struct module *a, struct module *b, bool link_flag)
> {
>+	struct module_use *use;
> 	int err;
>
> 	if (b == NULL || already_uses(a, b))
>@@ -866,9 +867,21 @@ int ref_module(struct module *a, struct module *b)
> 	if (err)
> 		return err;
>
>-	err = add_module_usage(a, b);
>+	use = add_module_usage(a, b);
>+	if (!use) {
>+		module_put(b);
>+		return -ENOMEM;
>+	}
>+
>+	if (!link_flag)
>+		return 0;
>+
>+	err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
> 	if (err) {
> 		module_put(b);
>+		list_del(&use->source_list);
>+		list_del(&use->target_list);
>+		kfree(use);
> 		return err;
> 	}
> 	return 0;
>@@ -1152,7 +1165,7 @@ static inline void module_unload_free(struct module *mod)
> {
> }
>
>-int ref_module(struct module *a, struct module *b)
>+int ref_module(struct module *a, struct module *b, bool link_flag)
> {
> 	return strong_try_module_get(b);
> }
>@@ -1407,7 +1420,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
> 		goto getname;
> 	}
>
>-	err = ref_module(mod, owner);
>+	err = ref_module(mod, owner, false);

Thanks a lot for pinging me. If I'm remembering correctly, we had to
do this because sysfs intialization is being done too late in
load_module(). The last time I was tinkering with a solution, I think
I was able to avoid needing this extra link_flag param by moving the
mod_sysfs_setup() call earlier in load_module(). It just looks a lot
cleaner that way, without that extra param. Have you looked into
trying that? I would prefer that solution rather than adding another
argument to ref_module().

Thanks,

Jessica
