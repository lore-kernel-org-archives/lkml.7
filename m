Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123E1206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fH0qiocH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfCYWKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:05 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45818 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbfCYWKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:04 -0400
Received: by mail-pf1-f201.google.com with SMTP id u78so10583051pfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7kY2QswyjJGeL+pn4tYPdCA7RsaJvP9HYM3SbJBAroA=;
        b=fH0qiocHX6D+ppy2Eb2sLQX8da74DNy4n+Yf3JdgbVVnZVss6gDkp1UF1+MGC2phbK
         2NBWddi7f2z/Wu3m54i5eKH/R4ZFC0dfsbWbsi7wjjvdiXztgfcwoANfoRbKTWGV11Ox
         O7ujjDZ+mouLArSBowSQ4PA+vt20BnzkqiisjM/P8QlkDazsrGEnu22inRsXUFU58SKo
         npGx7kKT6YGhJ5/PFGUpQNyqmLnNdDrYsK6YhukC5jDlhucYthSguWENoUMr1AxXeOQL
         7F5RzqoGTTPj6r5z8tby7xgqZCjecOc7zlaPi/sKuGLihdVXmTOAnj3cDW/s0XM89yz/
         XjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7kY2QswyjJGeL+pn4tYPdCA7RsaJvP9HYM3SbJBAroA=;
        b=VdEoy5F3mN4VTwoGMuIqEHC+0JivtrGjpSzLLy3ER2E853BoljCEhEs94WyKSgHMZa
         IzgmtwE2UpV7TNmUzO0fCCkl7SBtOQ+aABT7o198wiQhY4M3BLguyJnbRlsIVgXmlzyU
         0MtRHOxrMfnSKjZ1LjUcXFEOBQMF8ToaBj5YRybvTgqRi+QT+Zj3QevHdoQz5C1y0See
         s6sRMfWWxfthC+1sDQnA9Eal77tIP8JIMR4H5i4g4uQ0gWDt3JXdCxhFyMzfPWWmTmf2
         PrSq1P++sRW/vCx9Sw+0AIBStqv9YRl/j3YzNWNdGzfJeKitVxfiX+8Yk8RCvJ02Q+TG
         xjag==
X-Gm-Message-State: APjAAAX9XxlwFzu/be63x1vXA7eQPmOepkWI8tgmi/Qn4THbmjx9yq9i
        A6nMXUfqA8KLfLj5QSyhRBNTl1pcMpmHGftOfEkNyQ==
X-Google-Smtp-Source: APXvYqwAjwGZ2XuHEZMf2N4nC+utrAZ0fFynLHMvG+jRgiNluH5cNZofkgpugK8PHpKGPY6luT5eHt7GND8ndB/OLW+FpQ==
X-Received: by 2002:a65:4547:: with SMTP id x7mr24808022pgr.350.1553551803393;
 Mon, 25 Mar 2019 15:10:03 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:29 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 02/27] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Jiri Bohac <jbohac@suse.cz>,
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

This does not yet integrate with setups that pin module loading to
dm-verity backed filesystems. If lockdown is enabled, loading unsigned
modules from an integrity-assured filesystem will fail.

 [Modified by Matthew Garrett to remove the IMA integration. This will
  be replaced with integration with the IMA architecture policy
  patchset.]

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..9a377c6ea200 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2767,8 +2767,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2783,16 +2784,40 @@ static int module_sig_check(struct load_info *info, int flags)
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
 static int module_sig_check(struct load_info *info, int flags)
-- 
2.21.0.392.gf8f6787159e-goog

