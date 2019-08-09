Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDCC32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FA42086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7WQoCZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfHIU77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:59:59 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34018 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfHIU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:59:58 -0400
Received: by mail-qk1-f201.google.com with SMTP id s23so2874825qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1dUG1NMCpkV2WkKZesUQVb6Dz7CzfhUj65K8G9Towq4=;
        b=T7WQoCZKX7Wq+UOhImXZEoVPZhkCpjMeQFTB9tRdBWSAF3obYVvznl50aJhWDlSS44
         fi4dAIYKDDRWAWH0KxgLzbfaz3zBBcXkS6yVHh6srQvVY6UN2y63DBDlrPClVdmBea5K
         l/gs5qun2op7KvgFX4k1vbaSqzykPTVmmT6UCfQQu2LGBaez8GMBdlj+YBdkPkknYrj6
         VmjoxwHa9gg+PsuAxhr/cBCAKr17GtEXMDK3MtU1JGhpAAdEpPJLlRuTG/91cPgpgvq0
         iFgQ+7V6CCXu11U2SU6cUad0AWrsNXflNu7d1I95XoHK4GyIi5hxLA67j0bzpxuvNSkb
         7I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1dUG1NMCpkV2WkKZesUQVb6Dz7CzfhUj65K8G9Towq4=;
        b=GBjj5Z2PJlRSiuOxoGsnpssx9MJ2m8hwaA8c8XRN+qHqWmRH51tUssHLN9vCZkHVXp
         qNQW/HPywFzcIgDZVqjw0uc+8vyLq5Spjw9XQEwV+Pgq42y4GP/5wC90HJpEVhJsNFiG
         NuucR6grDfRYtgyTbzD0YV1sS19s2Fws5VmVVoyZVTh1hK7IZ7U1qz9bma5s62bah3l7
         Eu2wUMUh+2+qIC/Ut2UVUJVHCqn9LflZidjMh2DRHYkH2HMPoqeyhi5fkk1GypokO+TW
         FrzQctSKBm/Xz1/wyB09oFjCuwnd8cEN64NwRZE0uSkKzSeyXomFO0OB4fm/wkXUxdLS
         pPAw==
X-Gm-Message-State: APjAAAWj1RazOS81phpFe5JgvlBlEc2UgBG2aE3miUTuMHocjb1+BEQf
        IUUonNbHWGaa+dkmVoLXfaKe6T6y2WnOrCo6hrMzAg==
X-Google-Smtp-Source: APXvYqwLZr72bOnQwCmWG8+ZdkXoVNNSRD6ih433tgwJCH1YjGw4l2t+D/BDOflZ1Ia2cUyhpkOtAwiJPQ8IrHpqkGCbUw==
X-Received: by 2002:a37:9fc1:: with SMTP id i184mr7769621qke.289.1565384396579;
 Fri, 09 Aug 2019 13:59:56 -0700 (PDT)
Date:   Fri,  9 Aug 2019 13:59:49 -0700
In-Reply-To: <20190808100059.GA30260@linux-8ccs>
Message-Id: <20190809205949.111398-1-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808100059.GA30260@linux-8ccs>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V39] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

If the kernel is locked down, require that all modules have valid
signatures that we can verify.

I have adjusted the errors generated:

 (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
     ENOKEY), then:

     (a) If signatures are enforced then EKEYREJECTED is returned.

     (b) If there's no signature or we can't check it, but the kernel is
	 locked down then EPERM is returned (this is then consistent with
	 other lockdown cases).

 (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
     return the error we got.

Note that the X.509 code doesn't check for key expiry as the RTC might not
be valid or might not have been transferred to the kernel's clock yet.

 [Modified by Matthew Garrett to remove the IMA integration. This will
  be replaced with integration with the IMA architecture policy
  patchset.]

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/security.h     |  1 +
 init/Kconfig                 |  5 +++++
 kernel/module.c              | 37 +++++++++++++++++++++++++++++-------
 security/lockdown/Kconfig    |  1 +
 security/lockdown/lockdown.c |  1 +
 5 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 54a0532ec12f..8e70063074a1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -103,6 +103,7 @@ enum lsm_event {
  */
 enum lockdown_reason {
 	LOCKDOWN_NONE,
+	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..1f0f53774c3e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2017,6 +2017,11 @@ config MODULE_SIG
 	  kernel build dependency so that the signing tool can use its crypto
 	  library.
 
+	  You should enable this option if you wish to use either
+	  CONFIG_SECURITY_LOCKDOWN_LSM or lockdown functionality imposed via
+	  another LSM - otherwise unsigned modules will be loadable regardless
+	  of the lockdown policy.
+
 	  !!!WARNING!!!  If you enable this option, you MUST make sure that the
 	  module DOES NOT get stripped after being signed.  This includes the
 	  debuginfo strip done by some packagers (such as rpmbuild) and
diff --git a/kernel/module.c b/kernel/module.c
index cd8df516666d..318209889e26 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2771,8 +2771,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2787,16 +2788,38 @@ static int module_sig_check(struct load_info *info, int flags)
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
+		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
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
 static int module_sig_check(struct load_info *info, int flags)
diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index 7374ba76d8eb..f9dd683261e9 100644
--- a/security/lockdown/Kconfig
+++ b/security/lockdown/Kconfig
@@ -1,6 +1,7 @@
 config SECURITY_LOCKDOWN_LSM
 	bool "Basic module for enforcing kernel lockdown"
 	depends on SECURITY
+	select MODULE_SIG if MODULES
 	help
 	  Build support for an LSM that enforces a coarse kernel lockdown
 	  behaviour.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d30c4d254b5f..2c53fd9f5c9b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -18,6 +18,7 @@ static enum lockdown_reason kernel_locked_down;
 
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
+	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

