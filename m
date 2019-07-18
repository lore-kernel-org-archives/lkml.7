Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AD0C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D097321852
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qB9l0rlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391723AbfGRToy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:44:54 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:45023 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391413AbfGRTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:50 -0400
Received: by mail-yb1-f202.google.com with SMTP id w200so12612543ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RqpfjquZ0GE2zpg4eJx3Cd128lI5VFuP5LKKMsWaFSI=;
        b=qB9l0rlZdf1ZSzaRrkTDiiRPVJ59qbbPv/eC3uB0Eygb7kg3fkemSZwjWZu4/V2e7r
         RqGqRUuCJJpwr+tC6Eqans0mir3JuYlFXe9OUuCjNjx7dr94sdMzyJssS6GNXaJPaLA2
         jLr1mPI6iXVmtCKOQzDzXuWUR9KeIUX1YwugsPZbbx+3aYnwWBr4Tm8dKeznrou7F3zH
         +6GQwehAYwQ91AzLcAQxko+dJauQHFA+gVoaiM5xlaraqYrmD2AVzvat1ZR2i34hY6F4
         vPdulwSobVmL4QVh4zui3Jy23qYxvfpcYiXoLPjoqjIFO9noO62KTo1vNCi8XTqGvDDk
         JNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RqpfjquZ0GE2zpg4eJx3Cd128lI5VFuP5LKKMsWaFSI=;
        b=f1yDZ1lTpU4+viugVwcC1mKnFOhHaOZ+yJmbYiwywTtLuiGb9SF4FlLL9Yvs6CRgBV
         WC2eKqoiGPXCjvQ6etGflOYC0rvtzAS1wdkQLntyjyszrZaoAglmKJoASgGjgNu4GDPp
         YPaFkyfDxif942ibPvU7o3tbNrk5zNLRzttxmusR5itcQjLHVZ/8eEJIOR73y+jWvGta
         M9R6cEnZnF8kkBUxUQbyGX3sbMweaJWpupVip/hTVVf+3X05OawG+MWLa2OR15ovtnqC
         EKWf/HIit3Tj5cTE0Sh/64BeQNZpCVyj2+wcMwDUGmbA8B+sLjwAL6q+6+QlV5BH21r1
         5M4A==
X-Gm-Message-State: APjAAAVUKNEPIFPAHKXraOe341z6LtUmt/lk9o67hGZkKYIpUIkV6ZTL
        hYLR8gAl3OUQIUv/WBSo+tgB4aJDAKfdGSwpMug82A==
X-Google-Smtp-Source: APXvYqy/t8VeuQfO2ZAGyoAVYFHwDJHul3AKIzmL6DhaskBsqNip8Z6iUGnuploP6DNyyDk+p2NwIaUJnDyntsETVXfrxw==
X-Received: by 2002:a25:2a56:: with SMTP id q83mr27205767ybq.299.1563479089832;
 Thu, 18 Jul 2019 12:44:49 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:58 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 12/29] x86: Lock down IO port access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

IO port access would permit users to gain access to PCI configuration
registers, which in turn (on a lot of hardware) give access to MMIO
register space. This would potentially permit root to trigger arbitrary
DMA, so lock it down by default.

This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
KDDISABIO console ioctls.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: x86@kernel.org
---
 arch/x86/kernel/ioport.c     | 7 +++++--
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 0fe1c8782208..61a89d3c0382 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
+#include <linux/security.h>
 #include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/slab.h>
@@ -31,7 +32,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
+			security_locked_down(LOCKDOWN_IOPORT)))
 		return -EPERM;
 
 	/*
@@ -126,7 +128,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    security_locked_down(LOCKDOWN_IOPORT))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
diff --git a/include/linux/security.h b/include/linux/security.h
index 8adbd62b7669..79250b2ffb8f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -108,6 +108,7 @@ enum lockdown_reason {
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
+	LOCKDOWN_IOPORT,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 655fe388e615..316f7cf4e996 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -23,6 +23,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
+	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

