Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E287C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ABD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSA3jV9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfCZS23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:29 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:37389 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732726AbfCZS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:26 -0400
Received: by mail-yw1-f74.google.com with SMTP id x185so19969069ywd.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XYPTV88x6bsM2+0bDxThxX+PqaKMYNT/2nzbQ6HoL14=;
        b=QSA3jV9BWatdGl7hVSyhHwxLAxTneVkVg14uAJ/VF/6Frih2P7oXfTEv9kMP9G6XvB
         HEOGTc5uUxEQVWGmCh16CeR2IwnyK1KEWe+pwfhYfgXyj7bxXTdw9tKhsEjRGPG6ArGf
         qjggUxIgwpRtfAPv2l9cbaEcSWEgwDoxZkkEkMYKJh+bakWOkmpkPFLrGS1LnsvYGQuo
         Wh2GSZNqJwd+KUkfQlegDvzkqx/b3gLT9LlY1/YbcrJdfresNx4cOhRBgKV40TW1CyVL
         y8hFknGmWJARHvfiwFgL/XqzMwUY7qIZmWfCXy3Y6k4nk5qc1EVpbSGWzm9iUJ2bhVMd
         QkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XYPTV88x6bsM2+0bDxThxX+PqaKMYNT/2nzbQ6HoL14=;
        b=azma4+XaGVZbU+es5nEzMKAY/0wN41+ooo8J8qolXH9nZdQIGymWWbuHXqXK9ZbHDP
         0pqnsuyz0l7fsmC8+FP8xfw1XAH4BiXJ7rIoKQ4i6BWX5Io78XlOxMrABc6Ef3d98YM+
         PiENffw+1sGlIur7+kaZ/zWv+H9cWP3dH2T6fEU8DeVFtPwid76wdeAJXvUvDqHZ+k/r
         qM3kv1chvbsNV8+7x58mwmgUaXisTnhiwiGy8OllyCsCFAVW+0aef5EoqSoPK2MthNR4
         r7hgeNTN9Z6SnfIko/4RQloQONM6RfFdbyD899M/MHQZ+iEyMmmYe6HYyzd9RJp1krXz
         Uutw==
X-Gm-Message-State: APjAAAX7fewpqZowlYcY5kl53U0A/pEP+cshLPHhs+Zhw/yY0vJYW7dZ
        sjUwFoiZZYl9S71BKC03ocN89k8T6+FJf1Ggq07YXA==
X-Google-Smtp-Source: APXvYqwzBhCfjCntQfOahXU56F0snMQq9ElS1KJwPE0d2nevxhWZdfF4MEC3IHuSvBuLMVlduS6O46rzOWmCP057ftS/gA==
X-Received: by 2002:a25:1d04:: with SMTP id d4mr2412901ybd.517.1553624905627;
 Tue, 26 Mar 2019 11:28:25 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:28 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 12/25] x86/msr: Restrict MSR access when the kernel is
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

