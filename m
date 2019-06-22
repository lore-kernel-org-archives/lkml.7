Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C30C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8A920656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLKG7NXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFVAEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:14 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39943 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfFVAEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:12 -0400
Received: by mail-pf1-f202.google.com with SMTP id z1so5318101pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xWwvqoly0PlbH3oeDVETCqcyxNm+Yts9aIPiMy6JED0=;
        b=vLKG7NXbdP5iB0pGbeaWEB/S5uQntOo7aDNOTRJE5FTCqU5mqc1FLcJV5X9DTKhRUF
         skhH25su+evM+aesFmCqTJGHSxr9PAuHNaWTxTdOZu1cs13K5HlxqZ/Vsx3o/2bXx/No
         0C5LtbZv0KOVW2DTNIKFUDaPPbPHV7ouuhcHm5Rb7VSKB58D+SncR0Xpw+xFUzQcV/+S
         DhX82dzykAkEOBveZ+dKP2HdwUYPf1a46nQNkwXxDMk2hns0a9BLiYEXeFOdphGJ+RWP
         iP95ZFn4U7U1cVFqsLm5QxNRF31uyeVhEntSAEbWBO/844S4nQR9bRUp4mGqvnPElkq1
         tnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xWwvqoly0PlbH3oeDVETCqcyxNm+Yts9aIPiMy6JED0=;
        b=T4fKP9ftGs/KH+hRJ8C+HN7oVhFK77q1wKSjcoKCwXHYXzGAYJMrp6YhdpT9iHgyXQ
         5PKPUb9kR2xJH3E7R3CF3dSaFqAXu+y/eDf5XNU4Pz27cPUeh0eRTvdIODFIaR/tW0BY
         x9NVxzWsfMnAA1Nt3y96kWNPVSRIX3Q2YjdGu+NfNdrGz41DnuUXGK3QMfns7up3GC4I
         POW9PErFTw67W54weoX9JmtoVOMKJXYIdS+472HR2E8AVdKvUMH/ErlyrLcppAaWtdFy
         JvYrmCr+Q+QPUAkgS5Tc1d8GX10zskjxVPrs2rnWV9RWE/mIXLaVEpVUe0c26UcFan8Y
         LvIw==
X-Gm-Message-State: APjAAAXUy6jCbe/ATYzzex34K+OoxxiJ1HvAdBkydrIhpxSDnsnCIivx
        RcVznRGbf8NkUZKmstYQXb/S7QKVoTIDqEm8R5Kbtw==
X-Google-Smtp-Source: APXvYqx0mEhlT0ooxRI6ZbcDWX5ttbbUK2UhpRjvoSoGikcOsjmlTxGeN/u7fJgSuhxSgvvZPRyqVv+YDyhrsCuMO0voxQ==
X-Received: by 2002:a63:3042:: with SMTP id w63mr13863609pgw.21.1561161851464;
 Fri, 21 Jun 2019 17:04:11 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:33 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 04/29] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jessica Yu <jeyu@kernel.org>
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
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/security.h     |  1 +
 kernel/module.c              | 38 +++++++++++++++++++++++++++++-------
 security/lockdown/lockdown.c |  1 +
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c808d344ec75..46d85cd63b06 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -82,6 +82,7 @@ enum lsm_event {
  */
 enum lockdown_reason {
 	LOCKDOWN_NONE,
+	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/module.c b/kernel/module.c
index 0b9aa8ab89f0..6aa681edd660 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2763,8 +2763,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int ret, err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2779,16 +2780,39 @@ static int module_sig_check(struct load_info *info, int flags)
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
+		ret = security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+		return ret;
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
index 8e39b36b8f33..25a3a5b0aa9c 100644
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
2.22.0.410.gd8fdbe21b5-goog

