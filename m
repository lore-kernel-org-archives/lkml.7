Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D12C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642020881
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDF1wRh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFVAEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:39 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56220 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfFVAEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:36 -0400
Received: by mail-vk1-f201.google.com with SMTP id b85so3016385vke.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h2S4TyM7CDyJMzOjQbRR8ZxxuMRjDhoCrTzyxHQF79A=;
        b=wDF1wRh7YRdkWENFBegReRPWg8Ckd32u7DCN0+IKAyery8b1+s7dI+zT3p8kB6IsBS
         5ib5OAxiJgbnyubCe8ihMsjXCVgjsTjfbb1f3vFEpfT5YYOdxv9l2B5NGb/b7nhGNKyK
         Ibh8t5mZvnavG9IT55dA1L9Uk4eK3afpzt5DPbSJFHyBwYP4ct439OguaEVPITJLKpLE
         OAMCezhOu1zvy1uc46JxSLEBLHZ5r5I5Bewf9BckvkjTBLbmYQw3EIzELHSaNbnr0Hxn
         aeE9u8eiAhIPpTR0XzbZL3CmimTaGzMLgzXV576COBT89EzENtfZbTVKlCjDiDg30Yow
         lbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h2S4TyM7CDyJMzOjQbRR8ZxxuMRjDhoCrTzyxHQF79A=;
        b=qrzu8lokc9krIngdW0kTW6Xy4MN13EkTof+fwfEZG2ZrcHG0vGNlMoC9qHZPqFeV3J
         3heib+OMo+4iopEMgp5NlBGW90luZNaCElBMQ9FBY9ZsgSYdkVh5SkWW90Bx+/5O9Y9J
         HTmBSDCT7HZktM84ERS/71lpqXgUQlOtNzPteQYpIc/EZ7jPEus51kOGFyC6KYmiGhAf
         J5P0BVlHPP/FcV0DBcYXeiceTmve6hCo/FHOZ0zlgpJJOgLE8MDD8PFcWJoquyJq/MO6
         jhRAkTCxn8ySMliY7Soj7JAzg40/3oNznrKMj5UWAsM7kiZOxBfKkvjbr3jqC3LXGM5j
         E24g==
X-Gm-Message-State: APjAAAVE0ygqny8Upl7ccDw2Mm+F5rwX9MwnxaCyxpq4zAtrZDXQ8JYY
        vjpGopJMPCIj0JR9tsxiOQ8DF6U5UCRueGOoEG/K/g==
X-Google-Smtp-Source: APXvYqwS2MgA1SXOj6fV/hh/k0TpKrnXr6zcFgypgeQp/ElwyjlX3xUnkgtDu8Nw/KiSDM52/+plAywMWgkcmWo34zOLNw==
X-Received: by 2002:a67:13c3:: with SMTP id 186mr57496678vst.8.1561161874880;
 Fri, 21 Jun 2019 17:04:34 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:42 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 13/29] x86/msr: Restrict MSR access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Writing to MSRs should not be allowed if the kernel is locked down, since
it could lead to execution of arbitrary code in kernel mode.  Based on a
patch by Kees Cook.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
cc: x86@kernel.org
---
 arch/x86/kernel/msr.c        | 8 ++++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 4588414e2561..131861b4e447 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -84,6 +85,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	err = security_locked_down(LOCKDOWN_MSR);
+	if (err)
+		return err;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +140,9 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		err = security_locked_down(LOCKDOWN_MSR);
+		if (err)
+			break;
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
diff --git a/include/linux/security.h b/include/linux/security.h
index 60569b7e9465..30bc6f058926 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -88,6 +88,7 @@ enum lockdown_reason {
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
+	LOCKDOWN_MSR,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 895ef3ba1b4c..297a065e6261 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -24,6 +24,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
+	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

