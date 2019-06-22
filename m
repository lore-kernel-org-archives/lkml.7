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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89648C48BE3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBC820656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFwCQU3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfFVAEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:55 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45317 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfFVAEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id i27so5310192pfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PrHz11Fkohxiw/KAEo+rgP52AAtQBps1BcwB0CKo3qA=;
        b=JFwCQU3VW6N8fQbj5QygplLOospCB4WZ2mimGCOP6n+WOhSurcQpgYKoX9iw+cZ2K6
         lfr0JV9a5FEYabcfgKFD2n6Oe6+2jlR6WwmG5IJWl6TSHGZbMzYhWldPaBoWulWPSt2Q
         n6nwq8yowPRfRHqRBFYCGiKeHVxfu8hk5JpXAy9ZSyUlF8mKnwxIGeYB/JaeT0mfCdVH
         jsnv53RcgGR+gNUsAtx76M4TpYdiprXQiVmjKDZ3WUiyWxBtk+IPYE4Tqu3u+i1Sl/Bv
         2XAbs7AoszictGZ1JEiOzfUFw9KrUEgZ3ZX1sk/r5opiNHJKIXKeADFd8BG+XePh9aML
         4/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PrHz11Fkohxiw/KAEo+rgP52AAtQBps1BcwB0CKo3qA=;
        b=UxvS7uFChpaDRvxtFmmk5baeJrwr8cdcYZkW0+5q3viJirFwUXbziJHr5mx7db/Rzk
         1qf+w+4zkKf9gAXq6QoPk3/CnJSpct7eowchKGWJEPt3ZTuVxl3d9lvh9eMKxGYt4Ic6
         uGOicV8sipzB9b2qcCDKoQmdBpCkRbOWixG3gdPQpD2ANXPyPToTVsaB0vEcWWCy1Nzo
         kbgQ91zkSLroJTtUFnh6RgFVH9RK+WzyEi/0DzlStOOobwcPx2qRPL/gl3sDClX/2Rio
         WeherWEbB/ATXewRAk/MtCtTGHD+VkAvPGdvSzqSMLk94eXBa0YgA5cddBGMxfncLJdA
         PxFw==
X-Gm-Message-State: APjAAAXgSUSm/SJe/PbfJKm2emSE3AA//yyAP8OBXM4ja2kYRrUL0Hb5
        kHolYXJ2yTiEcbPb9tBM/h3ASUAsgfqxrFXy5zUavw==
X-Google-Smtp-Source: APXvYqxHPrRmaCO3xqjug+sv8qg9vhcJoBN5OdWTZlBjLu//lwEN4PjtXf5eSjG7q2BsNifXC/ydRjwvulqX9FFBZNjGHQ==
X-Received: by 2002:a63:6146:: with SMTP id v67mr15959623pgb.116.1561161892042;
 Fri, 21 Jun 2019 17:04:52 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:49 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 20/29] x86/mmiotrace: Lock down the testmmiotrace module
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
index f6ae6830b341..6b9486baa2e9 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mmiotrace.h>
+#include <linux/security.h>
 
 static unsigned long mmio_address;
 module_param_hw(mmio_address, ulong, iomem, 0);
@@ -114,6 +115,10 @@ static void do_test_bulk_ioremapping(void)
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
index 88064d7f6827..c649cb91e762 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -93,6 +93,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d03c4c296af7..cd86ed9f4d4b 100644
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
2.22.0.410.gd8fdbe21b5-goog

