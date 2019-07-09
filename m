Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE6C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D77C2171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562688647;
	bh=sZeMD4oVQwPrdMKxyv7QW1fVkzIcKk8DIBHqtvwcWPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OTUXQZ1k40RYtUdcDdIDtY3j6bsZgF2xdXUlutVpa82X9ZXBfKVW5UJniSfLuWGUS
	 18rA1IFlZuZUcaXEOakU5ciOfsXUIOthUbZdrSZ/5+tPjr//T8amIJoEYV4KSn+1+o
	 lZdBl7OdKy9cm+zqjs9S7RojqmiQLd1BajSo96I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGIQKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfGIQKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:10:46 -0400
Received: from linux-8ccs (ip5f5adbef.dynamic.kabel-deutschland.de [95.90.219.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67EB720656;
        Tue,  9 Jul 2019 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562688645;
        bh=sZeMD4oVQwPrdMKxyv7QW1fVkzIcKk8DIBHqtvwcWPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ar5tnU95snb3l/W5KYlNQP9YQ1KcXM5zwJ7JQjzNWOjLwiCytDHRWgQyjFt0Oi0GP
         IF+CW2oXBDXZem/WACI2CXhMNKEaXo3h4WE9cSLKzxIpjD3daJ+RWmC4r7aqgFuYkn
         T7jI/n2nFLhON2jr2Ygkg+lAcr+VSrOnAKF19Nwc=
Date:   Tue, 9 Jul 2019 18:10:39 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     rusty@rustcorp.com.au, kay.sievers@vrfy.org,
        clabbe.montjoie@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        wangxiaogang3@huawei.com, zhoukang7@huawei.com,
        Mingfangsen <mingfangsen@huawei.com>
Subject: Re: [PATCH v2] module: add usage links when calling ref_module func
Message-ID: <20190709161039.GA3501@linux-8ccs>
References: <4fec6c3b-03b8-dd57-4009-99431105a8a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4fec6c3b-03b8-dd57-4009-99431105a8a5@huawei.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Zhiqiang Liu [03/07/19 10:09 +0800]:
>From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>
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
>Here, we will add usage link of a to b's holder_dir.
>
>V1->V2:
>- remove incorrect Fixes tag
>- fix error handling of sysfs_create_link as suggested by Jessica Yu
>
>Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>Suggested-by: Jessica Yu <jeyu@kernel.org>
>Reviewed-by: Kang Zhou <zhoukang7@huawei.com>
>---
> kernel/module.c | 18 ++++++++++++++----
> 1 file changed, 14 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 80c7c09584cf..672abce2222c 100644
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
> int ref_module(struct module *a, struct module *b)
> {
>+	struct module_use *use;
> 	int err;
>
> 	if (b == NULL || already_uses(a, b))
>@@ -866,9 +867,18 @@ int ref_module(struct module *a, struct module *b)
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
>+	err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);

Sigh. This ultimately doesn't work because in load_module(), we use
ref_module() in resolve_symbol(), and mod->mkobj.kobj doesn't get
initialized until mod_sysfs_init(), which happens much later in
load_module(). So what happens is that the ref_module(mod, owner) call
in resolve_symbol() returns an error because sysfs_create_link() fails here.
We could *maybe* move sysfs initialization earlier in load_module()
but that is an entirely untested idea and I would need to think about
that more.

> 	if (err) {
> 		module_put(b);
>+		list_del(&use->source_list);
>+		list_del(&use->target_list);
>+		kfree(use);
> 		return err;
> 	}
> 	return 0;
>-- 
>2.19.1
>
