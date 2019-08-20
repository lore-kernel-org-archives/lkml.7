Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B011C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514BE22CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQBvkuF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfHTASo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:44 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35161 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbfHTASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:42 -0400
Received: by mail-pf1-f201.google.com with SMTP id x1so3530003pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kCjTIca0P/GJFxU16YX7DQ4xD2nMI3cX2Z/4NQSE/Sc=;
        b=KQBvkuF/M1dzuAgHwCf82DbbRCvPK9GZf64/jVQ9LTne8ba0vruPyKkUvzKEAV4Do4
         ldosC+iLz6ETawlccozW8ItJDaAXBXZATeA1nO9KNWC66nLVSi/eQGjxAac7SxWtBt80
         F9ttqj8ulV04NpJ8P0R7xE+kPWB2SEZJlKpep9r3m0leisPBJgO+H06QZtS1RIQwOUvM
         aAAycTME7urbUMVzfSxauE7k8SqURCLc0gl2bCAw8gfpHncP4xy8sHCRp5tNJ/ikjNCp
         SBh93SgFozLEQXaTzHPp0WxbWNcOyZQqp2QWf1ydPAlK7JE3o0wgHP6nnj9xLY5ZbGVr
         0hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kCjTIca0P/GJFxU16YX7DQ4xD2nMI3cX2Z/4NQSE/Sc=;
        b=gL5ALhEYWZjB0SRxZx0ja+jJ09wn9YSS++fMXh/rkzaOVfbAVAvGb7M6DMEAIKTPvO
         Rx1SKCRAZfpgzdQt8EznvkI25JuoNYIGnXf7/k3vD0kTjfEojdg86GTI/tVyupzy7QXx
         +0P36lgtG5XqRfpUQxYounmAbcOQZ5z64MgggsKnJgtAy5gUCNBhZ46MWswkxQ514jyw
         MIOZxuoWhvulhL7dW2jKPbyzFwEQXZItJX4uQmFHwdAnUoONl/cwQ/I7qcrG5feD6Vq4
         hgaAGLNiIlaXp4FefJlrA+dqu5ss2p53hwveqe0UBR1ACj1afn5zwSIppWDpei1ZUtAr
         dPVA==
X-Gm-Message-State: APjAAAW7mTcKGNO53kTrq+aXGMGofMtOMPeoqin/fkug9mgBBl90Zsq7
        kYZimkLPI6RW1Fvc0Y9G/JxliwtJUm9+wl2d1/0b5w==
X-Google-Smtp-Source: APXvYqzr6zlVHJzTizaYjQ19faJa7QXUmz9jrhB1Y8s+sfB8qo///FW6Fvqhu5135bQUk3prCTZtpuYEGE383ZOEomAwZw==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr22683545pgc.348.1566260321339;
 Mon, 19 Aug 2019 17:18:41 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:48 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 12/29] x86: Lock down IO port access when the kernel is
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
Signed-off-by: James Morris <jmorris@namei.org>
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
index 2b763f0ee352..cd93fa5d3c6d 100644
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
index 410e90eda848..8b7d65dbb086 100644
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
2.23.0.rc1.153.gdeed80330f-goog

