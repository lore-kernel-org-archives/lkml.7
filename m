Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26371218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzfnYNTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbfB1XMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:15 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51304 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387478AbfB1XMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:13 -0500
Received: by mail-pf1-f201.google.com with SMTP id x134so17266815pfd.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QtKsyYHiwCWU5yiWJciggoAD1nlqNR9ctuqeDCsYWKI=;
        b=rzfnYNTLJA1ZeFACBysiRXmHvQrizAgydUJTNEp1PKJ8dFuZNs5aYF6JbQjMRRcRYN
         oHDRL39qxkz+uZfepJbEY4U9l0frA6ZXMkZa0M0Xe4EQ0oYnw9XB6AmoBQTqqc4ZTwaJ
         veSnNaJ4T17FTfFup/RE83ghYUXl6JZvfzdRz8hWeMfN8swjSixWObHc8Dc64zFCo8b9
         8uMbyjrYaKXIvsfxU5pr6KjJKfIj7pjXybNjMlogwX/2HfuslhAuluVTjvOXUmTJBfMe
         fcbiINkIL2McwoDvK4XpTKTShrAb9mASZmYeH7C3XrRC9coYp5oJ2WbZLv3IOEcuys0z
         DPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QtKsyYHiwCWU5yiWJciggoAD1nlqNR9ctuqeDCsYWKI=;
        b=j32nfD1FgxV4WmhRsX7dWFeVE53mLpmjkqplzjoDbFlaWPLI+ktHMu7mR6PsFKemEi
         E8Avr7VQBHO9EH9/90m013nPOHeRMlSbMK4knsCa9lqtImJXvtXmTO7ij+czNdgy0ybU
         G782No/uk+2ZvKRkKpmS97ZtSv/+HWOQWDRt9h+Fkeft6sE/Ujp4bcA8zJ4QM7B/46Z7
         ssL55F5NOzDBk9yI2Qy43yIh8LaVPpkQRAWi4PkFeIIYtOKsvFm0pJos9Ui47DMgYg1M
         KrK0N949B+gcyHRMTZe7AFUaG/E7103RPbRIkNOajlogtjt/NTeWxttlDB75SWva6eS4
         1Q1Q==
X-Gm-Message-State: AHQUAuZkflkcN8s3cAylj6pUmo3YwT9jX5cHrVjNOx86H8jREcTbWBPQ
        GF7jzWu70iR/ltf9futZG9VHMVXpd7mWNPdWKSSpjQ==
X-Google-Smtp-Source: APXvYqxTdLxxvHRUxrP6dBjOqmshkQpbu3yKcYUfKStvLjNRtJ1u9wNINweXDLZgeOP8DXPUtfKeahlCufSsmmEwMAmy6A==
X-Received: by 2002:a62:ac0f:: with SMTP id v15mr973328pfe.148.1551395531818;
 Thu, 28 Feb 2019 15:12:11 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:39 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 03/27] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

If the kernel is locked down, require that all modules have valid
signatures that we can verify or that IMA can validate the file.

I have adjusted the errors generated:

 (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
     ENOKEY), then:

     (a) If signatures are enforced then EKEYREJECTED is returned.

     (b) If IMA will have validated the image, return 0 (okay).

     (c) If there's no signature or we can't check it, but the kernel is
	 locked down then EPERM is returned (this is then consistent with
	 other lockdown cases).

 (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
     return the error we got.

Note that the X.509 code doesn't check for key expiry as the RTC might not
be valid or might not have been transferred to the kernel's clock yet.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: "Lee, Chun-Yi" <jlee@suse.com>
cc: James Morris <james.l.morris@oracle.com>
---
 kernel/module.c | 56 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..afa5489be39f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,6 +64,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/ima.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -2765,10 +2766,12 @@ static inline void kmemleak_load_module(const struct module *mod,
 #endif
 
 #ifdef CONFIG_MODULE_SIG
-static int module_sig_check(struct load_info *info, int flags)
+static int module_sig_check(struct load_info *info, int flags,
+			    bool can_do_ima_check)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2783,19 +2786,46 @@ static int module_sig_check(struct load_info *info, int flags)
 		err = mod_verify_sig(mod, info);
 	}
 
-	if (!err) {
+	switch (err) {
+	case 0:
 		info->sig_ok = true;
 		return 0;
-	}
 
-	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !is_module_sig_enforced())
-		err = 0;
+		/* We don't permit modules to be loaded into trusted kernels
+		 * without a valid signature on them, but if we're not
+		 * enforcing, certain errors are non-fatal.
+		 */
+	case -ENODATA:
+		reason = "Loading of unsigned module";
+		goto decide;
+	case -ENOPKG:
+		reason = "Loading of module with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "Loading of module with unavailable key";
+	decide:
+		if (is_module_sig_enforced()) {
+			pr_notice("%s is rejected\n", reason);
+			return -EKEYREJECTED;
+		}
 
-	return err;
+		if (can_do_ima_check && is_ima_appraise_enabled())
+			return 0;
+		if (kernel_is_locked_down(reason))
+			return -EPERM;
+		return 0;
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		return err;
+	}
 }
 #else /* !CONFIG_MODULE_SIG */
-static int module_sig_check(struct load_info *info, int flags)
+static int module_sig_check(struct load_info *info, int flags,
+			    bool can_do_ima_check)
 {
 	return 0;
 }
@@ -3658,7 +3688,7 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static int load_module(struct load_info *info, const char __user *uargs,
-		       int flags)
+		       int flags, bool can_do_ima_check)
 {
 	struct module *mod;
 	long err = 0;
@@ -3677,7 +3707,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_copy;
 	}
 
-	err = module_sig_check(info, flags);
+	err = module_sig_check(info, flags, can_do_ima_check);
 	if (err)
 		goto free_copy;
 
@@ -3872,7 +3902,7 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	if (err)
 		return err;
 
-	return load_module(&info, uargs, 0);
+	return load_module(&info, uargs, 0, false);
 }
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
@@ -3899,7 +3929,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	info.hdr = hdr;
 	info.len = size;
 
-	return load_module(&info, uargs, flags);
+	return load_module(&info, uargs, flags, true);
 }
 
 static inline int within(unsigned long addr, void *start, unsigned long size)
-- 
2.21.0.352.gf09ad66450-goog

