Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B2BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C23220820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1Y/PUQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDDAdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:32 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34610 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfDDAd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:26 -0400
Received: by mail-pf1-f202.google.com with SMTP id j1so541154pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XYPTV88x6bsM2+0bDxThxX+PqaKMYNT/2nzbQ6HoL14=;
        b=g1Y/PUQzlr8w4VbBSoNg3vi8qaTpIpeLwblcFxEbA8qgL2rreczYP6Bcjr7XsnesyH
         JqyppDVnmHCPzfeUQZjpdFAH3WIzAnSKJUHQCaN2Vphxplco+8Zi9eUJxtm7PO+crggJ
         g4Z6IBr5ZZV+k2CogsXEWfCz6cHrWFVfx6dbJRpB4n0S6gihi2EaMdTKcxudSZhrSb1j
         MFW/0KS184jEDPQeKjVqRFI8ypNBAEmtUINRkS1b8X8lQu9V9onqA0UBC7sijlTciyrz
         Jr0PefO1jwwaoQTJIFrBlWNJ0AwlLY6GVcM6v4bXpCtj/ALGGohGwP4YOH1manzxcME0
         qurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XYPTV88x6bsM2+0bDxThxX+PqaKMYNT/2nzbQ6HoL14=;
        b=BIafiIfG6zNYbn+N6gttDsrTKaUN0M3MxvVRVIeG6GSp8uxcgrMnLXYNDa99zE9WFN
         I1akH1NivXAnQ+zlSaKlxzvVS6ZGs/jmVZUpq3Eo49XDy65SlUWlMcBpEKRjzKyuk4SR
         bukOCmX9/dP6Hggym9NkwxOEMwe5MDc405NeFBFrXZYkAW2SU32nceRL+c0NebNk8Cgv
         nFYE+1EIAeyxqzUUuMfgSNEWRV4EZVxRj7KK6BGd+HBnpNfotU/2WU2LYLZcKMdIRVpH
         Fgqd1JVFMOlRlprkOwKQ2FVJS8may/q1g73LbSWsb2q38apzmw390Rf2Z29zzJqBwgrX
         AZdQ==
X-Gm-Message-State: APjAAAXGjAoMRhV8f/vao0ZTehSkvvtgjtbGMuHOHeMtBI12KsfjvkPB
        /1alh7VcIUYDNVpUIfjxYbdJN5V48Yg9VZA8wexlXw==
X-Google-Smtp-Source: APXvYqxf6ja6WDBpp/nIeSrs09Nn3VWuH4kTMGiDNVKtdM11YDUCyXx5y4Tt7mmUZ4ZNFw5Tna+rlzOcwcwYuiHPw8Mpaw==
X-Received: by 2002:a62:e103:: with SMTP id q3mr83578pfh.1.1554338005084; Wed,
 03 Apr 2019 17:33:25 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:34 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 12/27] x86/msr: Restrict MSR access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
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
 arch/x86/kernel/msr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 4588414e2561..731be1be52b6 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -84,6 +84,9 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	if (kernel_is_locked_down("Direct MSR access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +138,11 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		if (kernel_is_locked_down("Direct MSR access",
+					  LOCKDOWN_INTEGRITY)) {
+			err = -EPERM;
+			break;
+		}
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
-- 
2.21.0.392.gf8f6787159e-goog

