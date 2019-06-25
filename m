Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B12C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C0F208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561490494;
	bh=KQU6DtRDo3hq69qYXaCabKvz0AFsLEo4Om+nW8Oe1pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tFdnkeR4IE8lblmagoikIUGV5K9OtBSm305OnRHVAHyHnOjd48R/Exd2T+pVp0AFd
	 B1HStpIkib4tUOPgeGTN9yb6koVH9b/qGZXhmaK5MwfPQe3m5v/AOED6J8218hlz7K
	 mgxdtUohzDgGABvc/GWK8Hf3GaaFanbfe92wlpAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfFYTVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFYTVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:21:33 -0400
Received: from linux-8ccs (ip5f5ade86.dynamic.kabel-deutschland.de [95.90.222.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCE12086D;
        Tue, 25 Jun 2019 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561490491;
        bh=KQU6DtRDo3hq69qYXaCabKvz0AFsLEo4Om+nW8Oe1pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBbgI3b93JMMPtrCQg3sda3rEmd/fqazCAnYhjEGRmTmHCkbVfpuuRhlQCuGIMpnP
         xxEECwHI1lzT35MlOfAWxqVt5tR5TYdsrIzWB+UW6vPN4ludYROqnrWD2McjhTTblu
         zfx+7fp8CVJ8dUoW1ltjmKj4/QaQBr1TcWzReWRM=
Date:   Tue, 25 Jun 2019 21:21:15 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        namit@vmware.com, cj.chengjian@huawei.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] modules: fix compile error if don't have strict module
 rwx
Message-ID: <20190625192115.GA27913@linux-8ccs>
References: <1561455628-50795-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1561455628-50795-1-git-send-email-yangyingliang@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Yang Yingliang [25/06/19 17:40 +0800]:
>If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is not defined,
>we need stub for module_enable_nx() and module_enable_x().
>
>If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is defined, but
>CONFIG_STRICT_MODULE_RWX is disabled, we need stub for
>module_enable_nx.
>
>Move frob_text() outside of the CONFIG_STRICT_MODULE_RWX,
>because it is needed anyway.

Maybe include a fixes tag?

Fixes: 2eef1399a866 ("modules: fix BUG when load module with rodata=n")

>Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>---
> kernel/module.c | 13 +++++++++----
> 1 file changed, 9 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index c3ae34c..cfff441 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1875,7 +1875,7 @@ static void mod_sysfs_teardown(struct module *mod)
> 	mod_sysfs_fini(mod);
> }
>
>-#ifdef CONFIG_STRICT_MODULE_RWX
>+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX

Could you please explain why you introduced a new
CONFIG_ARCH_HAS_STRICT_MODULE_RWX #ifdef block instead of just moving
frob_text() and module_enable_x() outside of CONFIG_STRICT_MODULE_RWX?

I do not have anything against it, although the nested #ifdef's are a
bit painful to read. But I could not find a better way to do it :/
It's awkward because we need module_enable_x() and frob_text()
regardless of of CONFIG_STRICT_MODULE_RWX for x86, but other arches
don't need to call module_enable_x(), they usually just call the empty stub.

But I think having the CONFIG_ARCH_HAS_STRICT_MODULE_RWX block is OK,
for the reason of limiting the scope of the calls rather than
blanketly calling frob_text() andd module_enable_x() for arches that
don't need to call them. Was that your reasoning as well?

Thanks,

Jessica


> /*
>  * LKM RO/NX protection: protect module's text/ro-data
>  * from modification and any data from execution.
>@@ -1898,6 +1898,7 @@ static void frob_text(const struct module_layout *layout,
> 		   layout->text_size >> PAGE_SHIFT);
> }
>
>+#ifdef CONFIG_STRICT_MODULE_RWX
> static void frob_rodata(const struct module_layout *layout,
> 			int (*set_memory)(unsigned long start, int num_pages))
> {
>@@ -2010,15 +2011,19 @@ void set_all_modules_text_ro(void)
> 	}
> 	mutex_unlock(&module_mutex);
> }
>-#else
>+#else /* !CONFIG_STRICT_MODULE_RWX */
> static void module_enable_nx(const struct module *mod) { }
>-#endif
>-
>+#endif /*  CONFIG_STRICT_MODULE_RWX */
> static void module_enable_x(const struct module *mod)
> {
> 	frob_text(&mod->core_layout, set_memory_x);
> 	frob_text(&mod->init_layout, set_memory_x);
> }
>+#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
>+static void module_enable_nx(const struct module *mod) { }
>+static void module_enable_x(const struct module *mod) { }
>+#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
>+
>
> #ifdef CONFIG_LIVEPATCH
> /*
>-- 
>1.8.3
>
