Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E1AC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680FD21872
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkgIbIkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfHHAHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:40 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55649 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbfHHAHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:38 -0400
Received: by mail-pg1-f201.google.com with SMTP id g126so10047417pgc.22
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YL983DZYCsDH2/bxBW55mkIkXEZ4iV1BlOwZ0Y9UQbo=;
        b=ZkgIbIkxpkM6RHrVJ5F5wRRahbvNebuI+iYB5sBF/gbF7hJXYGn/E3enNeek2yvj7a
         zXnup1xUD1a+bDexnXrqRyg3zVYGJk0D5Z3/7uiaGtXK8sAodqIGziYCJxXYBrL/qRsK
         qn/6gQuzuvnpFoCsujfhY4Q+lzB88RGoFVmSlIbX8gy54nAOx/X4o3An99MFbOLbY3fF
         VEb4KOlGU8qxfLu5MrcKE4PvVdf9vvugdNeTmWM9eip5ojht/Dte+ZpXSPp3FUKPjL5Q
         OWChZ+etOyu33vavtQ/XXWp856rrwp0XUClHtnNcIkV0Yng0iQkxVE5gkgoUIHrrTB3g
         EK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YL983DZYCsDH2/bxBW55mkIkXEZ4iV1BlOwZ0Y9UQbo=;
        b=uaZOXVvecLwjWsUdDQUq9XamEEcW/8q1KI1rthJYAk2kVE4gLVgFkDgzmMM9Z0McFs
         7ESsrKPm0wTTmeb0zzESSP5kQRyyDDN4aXAhUarCnl5JjJoYfe1GlKeszsszBa8sP2yj
         FNuP2URaFYaqDCIdaOG/ex8hgep3ULTsSHzTI6XFHApGAoTW2EiXeAK125v2GtOUBhn3
         kk5C+cZhwQqxAAICceVfbiwNuHlg/H4cE7NTZk+JFCToyQYCo/Gtb6XUTQi0o/bPHaci
         6Ic0PyRMvhrNOqoX0S9tXctD8AWkbrB5x/N2zwvfGW3nclsaUn3jpS52AkumQKcptCE7
         TJ5g==
X-Gm-Message-State: APjAAAUNxpuaSE2qZgxN899P+otcgXVXBVJpa4LhNE/qjGxjv6ZviEAF
        2AL1MOOda2V3hkscnIdYk5lJaw8WQP1umLcHx0DJcQ==
X-Google-Smtp-Source: APXvYqy1rMt7IYQEnvUTMTdvNv/ls9xHIA2QghWA0Kj/etxe1pEs/b+3H3c4KKiJicMB2RXpHgtuYqO01k0YrblXJk+Naw==
X-Received: by 2002:a65:5382:: with SMTP id x2mr4566847pgq.422.1565222857072;
 Wed, 07 Aug 2019 17:07:37 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:57 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 05/29] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
---
 drivers/char/mem.c           | 7 +++++--
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..d0148aee1aab 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -29,8 +29,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/uio.h>
-
 #include <linux/uaccess.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -786,7 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
-	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	return security_locked_down(LOCKDOWN_DEV_MEM);
 }
 
 #define zero_lseek	null_lseek
diff --git a/include/linux/security.h b/include/linux/security.h
index 8e70063074a1..9458152601b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -104,6 +104,7 @@ enum lsm_event {
 enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
+	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2c53fd9f5c9b..d2ef29d9f0b2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

