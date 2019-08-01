Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D4C20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564676383;
	bh=fQ0l92+Ki1tGSH+LI6NQ4n0BXRy7dsmDoydI/zFviEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N1H0kzsCixUuI5RWqPFJZbDRujmlHNiRi6JEAUw/kKDhSdD1uS58CAhk3lNO0e1FC
	 lXpNf8Trzgtm0cv4T7uXi8ltENtpfuctmPm/abaS4iqh7gGkLPPCg728BWtemlwLkH
	 oqxkfz9tS1vxA2rh5riENW8xbU8mNH2loLXubTk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfHAQTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:19:39 -0400
Received: from linux-8ccs (ip5f5adbcc.dynamic.kabel-deutschland.de [95.90.219.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB5D20838;
        Thu,  1 Aug 2019 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564676378;
        bh=fQ0l92+Ki1tGSH+LI6NQ4n0BXRy7dsmDoydI/zFviEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJVn98ftRRmA0r6PFyM8iGovjbk4JlUwz/DuX+8G7nm5tS2mm3D+JDvyZNDbT1Pkb
         jpaBbjQqyhsygYJUoBqWk1E2W3M03g9GdyZMyBe/WRH8Ypnr4zxYzVLf4k8jsLL+fM
         MbUlq+sZ2yYb5gcOpEeBWfYfK6wFXVpjaY/uYB5o=
Date:   Thu, 1 Aug 2019 18:19:33 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V37 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
Message-ID: <20190801161933.GB5834@linux-8ccs>
References: <20190731221617.234725-1-matthewgarrett@google.com>
 <20190731221617.234725-20-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190731221617.234725-20-matthewgarrett@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthew Garrett [31/07/19 15:16 -0700]:
>From: David Howells <dhowells@redhat.com>
>
>Provided an annotation for module parameters that specify hardware
>parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
>dma buffers and other types).
>
>Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
>Signed-off-by: David Howells <dhowells@redhat.com>
>Signed-off-by: Matthew Garrett <mjg59@google.com>
>Reviewed-by: Kees Cook <keescook@chromium.org>
>Cc: Jessica Yu <jeyu@kernel.org>
>---
> include/linux/security.h     |  1 +
> kernel/params.c              | 28 +++++++++++++++++++++++-----
> security/lockdown/lockdown.c |  1 +
> 3 files changed, 25 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/security.h b/include/linux/security.h
>index 8f7048395114..43fa3486522b 100644
>--- a/include/linux/security.h
>+++ b/include/linux/security.h
>@@ -113,6 +113,7 @@ enum lockdown_reason {
> 	LOCKDOWN_ACPI_TABLES,
> 	LOCKDOWN_PCMCIA_CIS,
> 	LOCKDOWN_TIOCSSERIAL,
>+	LOCKDOWN_MODULE_PARAMETERS,
> 	LOCKDOWN_INTEGRITY_MAX,
> 	LOCKDOWN_CONFIDENTIALITY_MAX,
> };
>diff --git a/kernel/params.c b/kernel/params.c
>index cf448785d058..f2779a76d39a 100644
>--- a/kernel/params.c
>+++ b/kernel/params.c
>@@ -12,6 +12,7 @@
> #include <linux/err.h>
> #include <linux/slab.h>
> #include <linux/ctype.h>
>+#include <linux/security.h>
>
> #ifdef CONFIG_SYSFS
> /* Protects all built-in parameters, modules use their own param_lock */
>@@ -96,13 +97,20 @@ bool parameq(const char *a, const char *b)
> 	return parameqn(a, b, strlen(a)+1);
> }
>
>-static void param_check_unsafe(const struct kernel_param *kp)
>+static bool param_check_unsafe(const struct kernel_param *kp,
>+			       const char *doing)

Hm, I don't think the doing parameter ended up being used in this function?

> {
>+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
>+	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
>+		return false;
>+
> 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
> 		pr_notice("Setting dangerous option %s - tainting kernel\n",
> 			  kp->name);
> 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> 	}
>+
>+	return true;
> }
>
> static int parse_one(char *param,
>@@ -132,8 +140,10 @@ static int parse_one(char *param,
> 			pr_debug("handling %s with %p\n", param,
> 				params[i].ops->set);
> 			kernel_param_lock(params[i].mod);
>-			param_check_unsafe(&params[i]);
>-			err = params[i].ops->set(val, &params[i]);
>+			if (param_check_unsafe(&params[i], doing))
>+				err = params[i].ops->set(val, &params[i]);
>+			else
>+				err = -EPERM;
> 			kernel_param_unlock(params[i].mod);
> 			return err;
> 		}
>@@ -541,6 +551,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
> 	return count;
> }
>
>+#ifdef CONFIG_MODULES
>+#define mod_name(mod) ((mod)->name)
>+#else
>+#define mod_name(mod) "unknown"
>+#endif
>+
> /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
> static ssize_t param_attr_store(struct module_attribute *mattr,
> 				struct module_kobject *mk,
>@@ -553,8 +569,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
> 		return -EPERM;
>
> 	kernel_param_lock(mk->mod);
>-	param_check_unsafe(attribute->param);
>-	err = attribute->param->ops->set(buf, attribute->param);
>+	if (param_check_unsafe(attribute->param, mod_name(mk->mod)))
>+		err = attribute->param->ops->set(buf, attribute->param);
>+	else
>+		err = -EPERM;
> 	kernel_param_unlock(mk->mod);
> 	if (!err)
> 		return len;
>diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
>index 00a3a6438dd2..5177938cfa0d 100644
>--- a/security/lockdown/lockdown.c
>+++ b/security/lockdown/lockdown.c
>@@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
> 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
> 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
> 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
>+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
> 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
> 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
> };
>-- 
>2.22.0.770.g0f2c4a37fd-goog
>
