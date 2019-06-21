Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA9DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B223F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/tZc+vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfFUBWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:22:19 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40485 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfFUBT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:19:57 -0400
Received: by mail-pf1-f202.google.com with SMTP id z1so3256606pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oTJZhc67YgKisP9p9JrVMJPjUu1Ev+S7xJTrYSbTZx4=;
        b=B/tZc+vn3WaktKNK9T4k1XUjU+a/eU0uQ08kmrDc1+bigYos9FB2WWsluAGeB/G36t
         YfAi0QjD4sjtPxtMnKY6HzjB3jTO7vK2JNYab6BtyV5526LbxUvgwZPU16Y9DmMfjK4z
         PQ9+5uZQxgsE+fsDixETFuS8E05F8v1i/abMsI5HQdBgKOMJtdKMQgAx5Pe5e2c/C8ml
         gdAMxEOcKnAU+r0v6LKNDPeTkZYEtmhHO99KvvbB57QlAyqICjo623Oiw4CezwS5sEuD
         cjmdF2SlV+e5wr/yTJ4vkNPAiCUGAy0Vu6pDAhDhbwTMEFwf3GRrdiUDbbutIw6NbH2o
         d0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oTJZhc67YgKisP9p9JrVMJPjUu1Ev+S7xJTrYSbTZx4=;
        b=N/8mBYTyBF885AZFer3ZskTcuHx3RfZCeYvOGFOLSERDrAkJ+Vb0dEsU3iTRD1/3wP
         /cpbB0x7ORKPd1jMkpjHQFBo9r4wlwNXgIL6FGAVYYlrfe7nVlMLvUjssPNYspe7aOs5
         3+5JxJvgL9IRdGRV9FUBnOubp/An7flEwczHh/Od+cjLbG5eioX/CmUjceEaSVzBXe76
         yoyNePQMG558sAEL1PuBy0HJrzm9uDebnJ5YVoRS5RlgfrNrMkRlhakQoC7f104UecMh
         uIoAMRmnCmm/rVNGJC1KwMJ6QTFrPOkqt/obbuXjq1SFb9eLmf3ehWvRfw9s+zQAACxd
         cVBA==
X-Gm-Message-State: APjAAAUv+bsrWA+lVISAbmZ7u/ttJDXgm9/+D1OvNvEMLU43GG4y38IG
        f0G/SP5uCZYkiNWTWpZcXX+obAQh5zwZ2ZCkwlgMSw==
X-Google-Smtp-Source: APXvYqwexMzej4VdUeudQPwQh1qQKM6SYeoBeLdyWoQWkXhoBCQ4iKlvwP3IZKrK3rle+thzWDsw0C7WLpDrWAB4n88CsA==
X-Received: by 2002:a63:490a:: with SMTP id w10mr15275691pga.6.1561079996688;
 Thu, 20 Jun 2019 18:19:56 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:15 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 04/30] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
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
 kernel/module.c              | 39 +++++++++++++++++++++++++++++-------
 security/lockdown/lockdown.c |  1 +
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index a86a7739ca24..a7612b03b42a 100644
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
index 0b9aa8ab89f0..780e9605ff88 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2763,8 +2763,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2779,16 +2780,40 @@ static int module_sig_check(struct load_info *info, int flags)
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
+		if (security_is_locked_down(LOCKDOWN_MODULE_SIGNATURE))
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
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 1ecb2eecb245..08abd7e6609b 100644
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

