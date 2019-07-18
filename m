Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF1FC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A542D208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhUTX2qU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403823AbfGRTo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:44:56 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44528 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391709AbfGRTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:53 -0400
Received: by mail-pl1-f201.google.com with SMTP id n1so14427692plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=minBZuRPisw7H2/W4JdDr67L/DoNl62iO6bi7/9H078=;
        b=BhUTX2qUiiL6RrJB93H+27tuRITeSctfUT6CBbrO9oyZLQ9WchkTXMgKEVUQS1edP+
         fnH6lELvdBHrqVkpYSwTLqF4XOqKrWQoWMgiTHJWMlKEr067Nw966u80Wx1wLCmQaYPS
         4fSvOVKYEGi+P/fLlUJUPh0qpkgKfhmmqmLwlU0mQWb4CbGE1qzTw3DA82a+SWTbOMXf
         EZ1hgCpbC2npvG2bdJaXPxv56ovd/haE4mI+ou/oP76+qfKRitD9VOlNSYFwsyhdu8xX
         pVKq+7iKlxCV7Tca/y2BBcYCWjr5A8jJkpzCvb8Qjm6CRYneVJ6iU4Ku5DQB5jOVVQW0
         SBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=minBZuRPisw7H2/W4JdDr67L/DoNl62iO6bi7/9H078=;
        b=sbrkeSFt4e7CGh+qrOy79nb6MwWy36evjalm1MW5S86B3kW6HkWmzBZj1GFgAKXajG
         AtiO/Ynd5HxcOeVGXvY1/x1O80G2h0e1lXo0OPexqwCB2yjwwGBNiL2Ggfy9cj/2dw45
         ZaH6lAI/QelNxqfF2ALoQ0b03HUgbcqeTbg+qn8Y5y1SZfU11BhfXgWocedygDxWKOmq
         jzuX1QdaLsiLtd7fw3mzlG/pjGZ5L9Jhmd0tcUWk47d0cY/xjlAtW66wRLknw682CscI
         RSPIz9qaZZI9pSmTz9WdKpmP8lsr/O6gm96XqIYs11uwCN0RpAcNXRwYgwj3/XNVxTwE
         bxxw==
X-Gm-Message-State: APjAAAXCo8r5oOs7FHFzqF/WmZntjB/scjaBwfcX3LwDLTElkUgh16eJ
        9PCZCsTg3lwmtP+/YDndSTHYk587P1ufryQX21KMwA==
X-Google-Smtp-Source: APXvYqwDe+hjJ1l+N8oUy6ZAG2SYpCvM6947euWdk10aGOnm3bxMab6zPHzcMIIEn7Y+WkCc0Jsxg/KpVQ7JTli1NY22bw==
X-Received: by 2002:a63:593:: with SMTP id 141mr48453401pgf.78.1563479092164;
 Thu, 18 Jul 2019 12:44:52 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:59 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 13/29] x86/msr: Restrict MSR access when the kernel is
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
2.22.0.510.g264f2c817a-goog

