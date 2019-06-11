Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCA3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C331212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560260032;
	bh=mtodXsL+vYdy+dQoc9hpdK+N5BRAnJKhn34N192VzYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rcCu9ZRnmo1a5KxLs+WhANde6Zkrs+rS0nZp+oVYlqb1ocG8J+NdMjpZxKGv3rfXo
	 /2rKA7O6ggzyNoAeqX4Y0+ZN7VpwYbzQohkuPdeBJJ3EFeE81WCLvab7DQhbLP3X5J
	 IWCTSUDIuqjc82L0w55yjHw8VrB9b1Q3LW3u5ayc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbfFKNdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387683AbfFKNdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:33:51 -0400
Received: from linux-8ccs (ip5f5ade90.dynamic.kabel-deutschland.de [95.90.222.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2962063F;
        Tue, 11 Jun 2019 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560260029;
        bh=mtodXsL+vYdy+dQoc9hpdK+N5BRAnJKhn34N192VzYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiJIujdeMjHRStoZkNO7OxmNEgAk6m8UVzJbVUzi88GzJMhyg5lYsRescW31p6828
         Mft3VNQsHonsABPiVBYUtC0FoV1sPI5gxs6x9epIg7CxvbDzmXbyQbw4AgILxJXAok
         9C6SpkvpQ4e74Y9dPzQma/Zuwx4bF4NCHpHVfy6M=
Date:   Tue, 11 Jun 2019 15:33:45 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, mbenes@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
Message-ID: <20190611133344.GA9114@linux-8ccs>
References: <20190530134304.4976-1-yuehaibing@huawei.com>
 <20190603144554.18168-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190603144554.18168-1-yuehaibing@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ YueHaibing [03/06/19 22:45 +0800]:
>In module_add_modinfo_attrs if sysfs_create_file
>fails, we forget to free allocated modinfo_attrs
>and roll back the sysfs files.
>
>Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>---
>v3: reuse module_remove_modinfo_attrs
>v2: free from '--i' instead of 'i--'
>---
> kernel/module.c | 21 ++++++++++++++++-----
> 1 file changed, 16 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 80c7c09..c6b8912 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1697,6 +1697,8 @@ static int add_usage_links(struct module *mod)
> 	return ret;
> }
>
>+static void module_remove_modinfo_attrs(struct module *mod, int end);
>+
> static int module_add_modinfo_attrs(struct module *mod)
> {
> 	struct module_attribute *attr;
>@@ -1711,24 +1713,33 @@ static int module_add_modinfo_attrs(struct module *mod)
> 		return -ENOMEM;
>
> 	temp_attr = mod->modinfo_attrs;
>-	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
>+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
> 		if (!attr->test || attr->test(mod)) {
> 			memcpy(temp_attr, attr, sizeof(*temp_attr));
> 			sysfs_attr_init(&temp_attr->attr);
> 			error = sysfs_create_file(&mod->mkobj.kobj,
> 					&temp_attr->attr);
>+			if (error)
>+				goto error_out;
> 			++temp_attr;
> 		}
> 	}
>+
>+	return 0;
>+
>+error_out:
>+	module_remove_modinfo_attrs(mod, --i);

Gah, I think there is another issue here - if sysfs_create_file()
fails on the first iteration of the loop (so i = 0), then we will go
to error_out and end up calling module_remove_modinfo_attrs(mod, -1),
which, for i = 0, will call sysfs_remove_file() since attr->attr.name
had already been set before the failed call to sysfs_create_file().
Perhaps we need to check that i > 0 before calling
module_remove_modinfo_attrs() under error_out?

> 	return error;
> }
>
>-static void module_remove_modinfo_attrs(struct module *mod)
>+static void module_remove_modinfo_attrs(struct module *mod, int end)
> {
> 	struct module_attribute *attr;
> 	int i;
>
> 	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
>+		if (end >= 0 && i > end)
>+			break;
> 		/* pick a field to test for end of list */
> 		if (!attr->attr.name)
> 			break;
>@@ -1816,7 +1827,7 @@ static int mod_sysfs_setup(struct module *mod,
> 	return 0;
>
> out_unreg_modinfo_attrs:
>-	module_remove_modinfo_attrs(mod);
>+	module_remove_modinfo_attrs(mod, -1);
> out_unreg_param:
> 	module_param_sysfs_remove(mod);
> out_unreg_holders:
>@@ -1852,7 +1863,7 @@ static void mod_sysfs_fini(struct module *mod)
> {
> }
>
>-static void module_remove_modinfo_attrs(struct module *mod)
>+static void module_remove_modinfo_attrs(struct module *mod, int end)
> {
> }
>
>@@ -1868,7 +1879,7 @@ static void init_param_lock(struct module *mod)
> static void mod_sysfs_teardown(struct module *mod)
> {
> 	del_usage_links(mod);
>-	module_remove_modinfo_attrs(mod);
>+	module_remove_modinfo_attrs(mod, -1);
> 	module_param_sysfs_remove(mod);
> 	kobject_put(mod->mkobj.drivers_dir);
> 	kobject_put(mod->holders_dir);
>-- 
>1.8.3.1
>
>
