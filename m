Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D7C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E29D2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9TAlZ5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfFUBU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:20:29 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51453 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfFUBUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id d2so2651756pla.18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ad/yNjk/bvrZoco4Mw8YoxzrZODyqSCNyrUtVdvZI0s=;
        b=b9TAlZ5KNSkYjsrvs/PzLlMDftAEdoVj8mEsBEzleqTi807SU2DjvF7a8CmhiMbuxb
         Hzn6NmDTyehRi4XpCLIg5IgZdnBCugdvbJRkEvBW6m/v9TfQlimXc8K7QlV9RPWQRBPT
         f4Ow8iVgacQqNXu0wQ8l7Do9OM6r9JSh1nQhJUQ3jHXWewrXQMQLMtMJjSrDMiEn5ekc
         a9MHX4SMQ/Opp1EiBA117qOw/ds+Xy9wXhODb0amjF3lM2AQlR4odDrH9d2dUW2FZGj0
         QwDvuDjnhYK5u/K0KLCvqWRKIKOFif4rqul98NbkhtZ9j4dkupr+HqgzrEz0ZKv83ZAB
         IHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ad/yNjk/bvrZoco4Mw8YoxzrZODyqSCNyrUtVdvZI0s=;
        b=XRdxMSiHBp1wAtc3geygDYbe04kPDJuL8Pgz0gNGNF+M6qbrVJ03NBd+zNZ7aM3oNw
         /rOSbZ9WP2zGnC0V9T0Eoboy/2LMmArvNKni5qXD9tscZLrfE8oKoYXFflutOTTOiLAH
         8To8J50aNluKZ2U0F906ppk5WXzeYhFBQJurdBqSVtCXsl2nMnb4hzGy4zzYCNx4tbtt
         wW9h+j9YHF9O6/T9/41AoH+GNz4xRFq/Et3W2pwlMArGPKLhOZKy8KZLq+yQsygkHMl1
         3s3TYXTKkRqH76DdpcLwmh9X/vrGP74Bf1i/lqNg6OMlqBWRuofF0iw2fQVag0uAyPen
         639w==
X-Gm-Message-State: APjAAAV7XmA8qmPUcBLko+2+p/SwI0mF0df1Sub/3JcX6n2/3a1rlkDe
        pRJkaxCpBZs/Ty7IOjDkVHWYRe2yBT1Zv9+H9lNvPA==
X-Google-Smtp-Source: APXvYqxiWB8RGelDojcowMZSvi/aE6GUQF8hluI7DbVZsjcNnSvnBPNmxITR2+IuuuJY/CSZdRz9iOw/4EPHdhzOxcl1XA==
X-Received: by 2002:a63:360d:: with SMTP id d13mr15523401pga.80.1561080022714;
 Thu, 20 Jun 2019 18:20:22 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:25 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 14/30] x86/msr: Restrict MSR access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
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
index 4588414e2561..72f0ed5a93c3 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -84,6 +85,9 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	if (security_is_locked_down(LOCKDOWN_MSR))
+		return -EPERM;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +139,10 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		if (security_is_locked_down(LOCKDOWN_MSR)) {
+			err = -EPERM;
+			break;
+		}
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
diff --git a/include/linux/security.h b/include/linux/security.h
index 59f0ac7adfa6..81c0968e485f 100644
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
index 6e426887bb23..a01301972290 100644
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

