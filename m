Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353A4C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1DF21855
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeXjRzGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbfGRTpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:45:12 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41724 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403987AbfGRTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:11 -0400
Received: by mail-pl1-f201.google.com with SMTP id i3so14475156plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JVVIIgLtDOBKlqbr3dAhxhQOQv6A3XP76vT4880U/G8=;
        b=SeXjRzGuTikZ6KQwoTivnohUXmbA9jZtlGvnhbW5Gf6eGO+4VFd29B9NCWSdujqhu/
         8fh2j1Om1PhG29VKxAvPHvHEnsKA9M4CYYYG/Lu9Hp+oZek3BD7S8Mig7S68+6KmwG1c
         /xo6cEaF8hx9fJlpJ/R/SstDqmbSIAXSy9NQlEtsI+j+VydsrXaPd4V0Beh16tfWRfGg
         F7FfxfLwPdOpWRZpLyOlY+tC4JNNX68ecbgofIWwHOVea/cuOB6mklZYjtyQQINP37o7
         1nsCU4lqB4gv/44OPNg1qrVANEr2JgFG1OziWfA8hG4f0UGUfVWeP4bgBBn0aAiyTeRO
         foKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JVVIIgLtDOBKlqbr3dAhxhQOQv6A3XP76vT4880U/G8=;
        b=FTC6owbdUNnkHtp7AMFE5CFFKPSehU/PmjqPbu6lcpCm9wK8acMXK91xNfayRt2wz3
         7JSbj+Qrib1hSxb7M+JZ63XHOb+pmTKMw1qAd16vgQH0wIdGmFz1ERTfxVoWmlmL3t5A
         HoVqhSrfRnn3ZCAa37GNsRgp381lTbQFdr+gWhYFKJ243t/19Fpzz8WQG8yO4XjZ1Q4W
         UylwFj8WvTz+VwlsrtZy9btqxV/P1Exl+WJZpFcQylYdnQbgjqc0EgrecGa6oHx6URFL
         6RJuVqgjTnFmExIJf0Lm7dRzvMzTHjKIRrNz6YaRi2UXU2kUdq+d1ALzTlv518BharY1
         KuQA==
X-Gm-Message-State: APjAAAWuxR+MX54zp1raDUzw399F5RaEUr0klOMc4Uplt3/a76HwCzg6
        LH6cEzyq4+TZQXwbEvQ08l8X8cWT5zIngSaA4OXnjA==
X-Google-Smtp-Source: APXvYqyrMfaHa+wsv0nlaqRsdZ00CNxJSF2ky+cOy/8f3LYHWhlJwVQ8Qy4eVKCExKgmZMrlPSjOjbjg7/Xdu0/lTFJ7Wg==
X-Received: by 2002:a63:20a:: with SMTP id 10mr49075232pgc.226.1563479110182;
 Thu, 18 Jul 2019 12:45:10 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:06 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 20/29] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space. This is
a runtime check rather than buildtime in order to allow configurations
where the same kernel may be run in both locked down or permissive modes
depending on local policy.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---
 arch/x86/mm/testmmiotrace.c  | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index 0881e1ff1e58..a8bd952e136d 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mmiotrace.h>
+#include <linux/security.h>
 
 static unsigned long mmio_address;
 module_param_hw(mmio_address, ulong, iomem, 0);
@@ -115,6 +116,10 @@ static void do_test_bulk_ioremapping(void)
 static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
+	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
+
+	if (ret)
+		return ret;
 
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
diff --git a/include/linux/security.h b/include/linux/security.h
index 43fa3486522b..3f7b6a4cd65a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -114,6 +114,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5177938cfa0d..37b7d7e50474 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -29,6 +29,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
+	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

