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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C192C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F4821874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoR40voX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfHHAHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:38 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37991 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfHHAHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:35 -0400
Received: by mail-pg1-f201.google.com with SMTP id w5so56580044pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u2905WeoBzsTcUqrWVSX7p6zMJ6qFdPBK2S0ptkFjO4=;
        b=VoR40voXGZ4r3EI7oQ5TJp8v2YX39brgb6d/zSs8ft4hklym8/Gt2a9+o//N9qLOFE
         lL6d+hjXYM0ZfhO+JnOxPtMKcWI9ufmjAi1pqwnizkXVz3zYxdkgQjIR1X0RkHyrspZ7
         n+ULWEiaxWUUmkq6xJrie3FKlqw8wqf8m17SkFtTyX+bobwjSvbQl+w/6TWNvSUHZKqJ
         GAnEr/kt4WthH2MCiRcvNlAHaYXhmg0G4eRma/ptAee5bJusZYJnxdpEUf6wSgY/KjwJ
         AkJWag1ewJUIEDQXVqTbfGIG6/Y0zDemscTSwNyJCkT6GUOWGkukpVtf/FxaDBHt7M1e
         NSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u2905WeoBzsTcUqrWVSX7p6zMJ6qFdPBK2S0ptkFjO4=;
        b=N8sPOyhLI4jPaOhNLHox3fqwmlqmHrFgYvp36sGZrbIkeNlDHC6PiUqIFcCiaC+dv9
         139cvps0hH20AQQG4bNjFM6RNgqo4IlC1jWOG8jCtwteFJzjD0GEZs3/w7pFJVYA+oNn
         5mxVOmtYJeHxxShBhPRHBs4rNFsJP7RzvOFv5Sn/PUcj+202N0h1Ozj1eOJw4239E9F6
         2PpDMMqF8hlb8KkBX2la7R14FI2xuDsfcChHKxkNjynHOPFdGILYVBdkOiGaHUwBUmDr
         2OSYRDd7Mga2EaRqv57dvxGO7B+C+zvQNqVKsAyEhYtbkcCKmmV57SrcUSvoTKcLr3Rp
         MJwA==
X-Gm-Message-State: APjAAAVelqTuU4qn5hJg6UAu/VxKxizUlJYPINu9jGP+dHDm5ZY5Zu3p
        Z6kAK/aks/cgLsmeuG/YbqZ61qEdjbYEEaYTeyGqQw==
X-Google-Smtp-Source: APXvYqyR4AfaEXJW2ENR7zwCKUIvKwO1QMtq0y+rmGIcu67Yrsi7oIJ0VRtdvsK+tFTLWpJIe/+Jj+iYyJyKasMUao2L5A==
X-Received: by 2002:a63:9249:: with SMTP id s9mr9774501pgn.356.1565222854591;
 Wed, 07 Aug 2019 17:07:34 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:56 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 04/29] Enforce module signatures if the kernel is locked down
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
 kernel/module.c              | 37 +++++++++++++++++++++++++++++-------
 security/lockdown/lockdown.c |  1 +
 3 files changed, 32 insertions(+), 7 deletions(-)

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
2.22.0.770.g0f2c4a37fd-goog

