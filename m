Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904ACC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ABD216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quGzWel8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfGaWTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:19:15 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34730 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbfGaWRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:00 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so44194541pfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q3etb4lqcpfoYcLMBUBDWWlC5fl/teVFWCZH3Y1QNdw=;
        b=quGzWel87vKpTW4m4ti6UC5lPNM8poQ5r/5Gcx2k+UB1of3DzW/ygjWMG+qe/Fd4uM
         cDTpYU+PDwUIfPSRoB6CQIQj14vfKG771ql+UsouBTpmPik0ygjY67XRnFdi9Kxcg7ZS
         +bQ9M+2CNh/LhLV+HYPRlRvvArey+z6EEfT82xg/+VTjZ6i//Lq5auWIhNehcWDM1krg
         UtiiHS1J2R7eUNf8pXRVBs907DgLQKa70qAYzpZJfVOFrM+OBJyVIDoMThdLqXErL6Do
         Um1IJ+0Apei97QMgGp8BKBMTadz8Hvrz8eHjCdW6y1/DwlwDIl4hwCQ7BCxBPWQ+qcdb
         GZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q3etb4lqcpfoYcLMBUBDWWlC5fl/teVFWCZH3Y1QNdw=;
        b=ibbAxY8FA8p8XCNAwHJFTcKHGYRSFIgyvi6bhyBQcephi2shvAWDf91KBGwdmHzRcS
         oMZ0o0G+CRnSnPpesygImuvYk8jlmxigkckikb3dmn969z/bG5LzRvpj5cSL5EGOjMk6
         ni2LO20rPMfgZxmGY6v95E8i9ap842wbIzXcHrwiahlzPsilnDJI+1cBNO2vULU9daIj
         Pfr4LQ+h4xXaEVS513ey+yCipkp6S82XXE63TQUUMYG1dWmmQnQcpqz88EweHbgUTgS5
         /uBORWDFTx+P056CiHMf7uOlYyfGIkbyT+z2nJa6JjYXLDw+PjO70dxDy/P3G4GBcS0h
         tziQ==
X-Gm-Message-State: APjAAAVwiNqZWWmY+rAJNRyTTwTBcsI39wmqxFL+wvR5Y0leH9wyYbsI
        B3/EbTalHb+1tzWe9gE2ou0YOSrLhKdwScqQYfE7yQ==
X-Google-Smtp-Source: APXvYqy4ds11BOZ1ZwNIDQc3p6kAWpXPQHkBqVxVp8RzbiUM4j34Y4iiH1c07QLZF/c58qzuumf7YAJNTWdC2BSj0z0cCw==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr26982787pgf.340.1564611419264;
 Wed, 31 Jul 2019 15:16:59 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:01 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 13/29] x86/msr: Restrict MSR access when the kernel is
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
index 3db2252b958d..1547be359d7f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -79,6 +80,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	err = security_locked_down(LOCKDOWN_MSR);
+	if (err)
+		return err;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -130,6 +135,9 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
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
index 79250b2ffb8f..155ff026eca4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -109,6 +109,7 @@ enum lockdown_reason {
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
+	LOCKDOWN_MSR,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 316f7cf4e996..d99c0bee739d 100644
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
2.22.0.770.g0f2c4a37fd-goog

