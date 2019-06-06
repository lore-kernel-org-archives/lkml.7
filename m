Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47220C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2127620866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559833793;
	bh=SXQbPAaM9RvZp3lW3NXitKVEdsSpDOda2A6XmXtgK9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oQO+TRzW7dDdTiky+tZiwFH6215p+yBViV2e7evgI9MqNZeGdQ6JAA8P3pv/p+fpd
	 sRj9tTVAJjmy5LfDLTKGgefSZZM11XZoFBpMAoXPnowiS/PyIZxV95auWarttaOiCd
	 lWbfAkAzNR8qHEfuv9S4g00YRT1oKWgGfiK6cO4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfFFPJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfFFPJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:09:52 -0400
Received: from linux-8ccs (ip5f5ade8c.dynamic.kabel-deutschland.de [95.90.222.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E293F2083E;
        Thu,  6 Jun 2019 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559833791;
        bh=SXQbPAaM9RvZp3lW3NXitKVEdsSpDOda2A6XmXtgK9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8AchtX68ZQEgL43k9PKAyaIxr1puxpZjBpfXaJsM3G9UTVi4Ft5mQBKClINjsF7f
         /ojTk+8Da4VDAsJvPi5rbkfU5CMy32hmzLpjxaXv6GYYMnzJH7SKeqT4oSt1fRGlAf
         ablifYRY+8cU+hXFTvzyKkX6LywgYOcx8DdAj2CY=
Date:   Thu, 6 Jun 2019 17:09:46 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH modules 1/2] module: allow arch overrides for .exit
 section names
Message-ID: <20190606150946.GA27669@linux-8ccs>
References: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
 <20190603105726.22436-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190603105726.22436-2-matthias.schiffer@ew.tq-group.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Schiffer [03/06/19 12:57 +0200]:
>Some archs like ARM store unwind information for .exit.text in sections
>with unusual names. As this unwind information refers to .exit.text, it
>must not be loaded when .exit.text is not loaded (when CONFIG_MODULE_UNLOAD
>is unset); otherwise, loading a module can fail due to relocation failures.
>
>Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>---
> include/linux/moduleloader.h | 8 ++++++++
> kernel/module.c              | 2 +-
> 2 files changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>index 31013c2effd3..cddbd85fb659 100644
>--- a/include/linux/moduleloader.h
>+++ b/include/linux/moduleloader.h
>@@ -5,6 +5,7 @@
>
> #include <linux/module.h>
> #include <linux/elf.h>
>+#include <linux/string.h>
>
> /* These may be implemented by architectures that need to hook into the
>  * module loader code.  Architectures that don't need to do anything special
>@@ -93,4 +94,11 @@ void module_arch_freeing_init(struct module *mod);
> #define MODULE_ALIGN PAGE_SIZE
> #endif
>
>+#ifndef HAVE_ARCH_MODULE_EXIT_SECTION
>+static inline bool module_exit_section(const char *name)
>+{
>+	return strstarts(name, ".exit");
>+}
>+#endif
>+

Hi Matthias,

For sake of consistency, could we implement this as an arch-overridable
__weak symbol like the rest of the module arch-overrides in moduleloader.h?

> #endif
>diff --git a/kernel/module.c b/kernel/module.c
>index 6e6712b3aaf5..e8e4cd0a471f 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2924,7 +2924,7 @@ static int rewrite_section_headers(struct load_info *info, int flags)
>
> #ifndef CONFIG_MODULE_UNLOAD
> 		/* Don't load .exit sections */
>-		if (strstarts(info->secstrings+shdr->sh_name, ".exit"))
>+		if (module_exit_section(info->secstrings+shdr->sh_name))
> 			shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
> #endif
> 	}
>-- 
>2.17.1
>
