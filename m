Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2ACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1402206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bA3dmIiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfCZS2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:05 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:36074 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732566AbfCZS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:01 -0400
Received: by mail-oi1-f202.google.com with SMTP id t66so5741538oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fNnpo8lLzymZARu5UXrve26AL2A88YZO9HZRbBxOnPc=;
        b=bA3dmIiFcHRvOdKWWJyyAWFxpd0/eSw3KHIROhS1I9yokwsCzfmKaqf2p2y68VqWW/
         vlpoVkko2s4T0hcqSYMOU+Pcj9KiiFB8r4MVvv23Z4PL1HYmVD0aMOI1DyIsqALq8Pb+
         xMGOgj4XAA7JK6szCyO/HvwnUME6L00WvEEIuexfwS454lE90GHCMLcOXzmPyOuuGij5
         Ecg3v1tSGWh7r3dyYdfuMXae9MtbkUTDYLO4ipHww1JcpLUO7xwp8vIc9kcixNO56mIh
         IoUbHw0PRwuDn3ud9o3XyiRofhdf9MR73HyKVnqYfuvGbIALzJx0UJ57RtLp+OwxaJrp
         RduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fNnpo8lLzymZARu5UXrve26AL2A88YZO9HZRbBxOnPc=;
        b=N2PH4j0qbUIX6cjHGl75ONhEs82VUjL0ZE2ioQZCpwYDvLygy4NP/InSRxhsX+RqdM
         NZfXGbYYHmG61E6YMN/mRlx5qw8eLcn67DOwuCYLaARAxJwrs9ooyOZ6jXwbbvOqT4Lo
         2oxE8WPK08rBFzD6WyRqTNH6AiemDyYljx5Fc2W/iMXYJgoGjxgmiU4uFQDG1tp9k9nQ
         qtBzcP/sp29lPNbBr0jvFe/4KSgDtgV70tipCALKv6m0pSDgyPuOg99HT3/XC53+/DAz
         i2o3rCVHEj7GG5yGEeuxZcoBMlIykTo3G+rDn1DEOLd49TDVfU9NzoPzEvJTwfjpZZ7a
         msWg==
X-Gm-Message-State: APjAAAXRJlm9ANciXanuFmH+lDo/AS6fz+EfQkt1zBI3xwC7kVQGSar8
        bJC9PR1D1TxbbumYsDiedxKjxe6beSs6Sa7VkZCEdA==
X-Google-Smtp-Source: APXvYqxK5etbNZOafsOtIe3ObV0QXWQIHk+fUQNdgAx8FlSaBS+KmOAPLWPk31D+F29XECjttdxMIxlQUKAsFpz/tE3e+g==
X-Received: by 2002:aca:dd0b:: with SMTP id u11mr16650482oig.24.1553624880468;
 Tue, 26 Mar 2019 11:28:00 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:18 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 02/25] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
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
 kernel/module.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..deea9d2763f8 100644
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
+		if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY))
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

