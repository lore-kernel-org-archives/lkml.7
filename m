Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96AC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B48421851
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUfpKO3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404256AbfGRTq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:46:28 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36013 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391630AbfGRTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:45 -0400
Received: by mail-qk1-f202.google.com with SMTP id t124so24236321qkh.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=GUfpKO3Ga00Csg4gANFyqY7Cii9zK5UJiC7y7T53XWMHXolPbGtqL3/Y47/RTYgeVm
         Mi6RCLXrn+mFXqpu5OsWOJKds5n11Pm7/VfKFqyJyZc9yr639fO4YGJKtjbx4J4dg9DS
         PJwJtApulzrCc0Bgg28sX6Ujl31wRI6PaW5rfHbkzmCSi0hS7nYUQu7E9PQiI4ht1XC+
         dnV7J2tcrTwkrO7Sg9e3n9F/+LqTDuw1UdpjFK6nE1GXMcyw2GcsKji4TXEFCm2+pont
         rqA8db+Ui8EDLoOR90H03Sx1uL/TpWN4SwHCRaaCI4xM2JGV2I8do4YqpvWrigRG+SNK
         TUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=NqUsitqaaWGP7EAA41q20NFjKqcrpUC9mGZq+IPPANGxsTYSUNxeFVn9aLQvOGld37
         HLYig0wLCwDIV0kXn7P035SGdzKG5MZ6swUkXnVoRxLT2SjRPcmX1v5u++OWrwsGJeIt
         LX6WfcW6+g2K6ylC6/0t5npTO7DkaDZ/0fTnnDAtFjrG9rn1i2D7bMG89wI2eVN+e/ps
         v+kQEOYv2ckI/iTM4DAS5ycy9KLmpZPWV/k79qeCVIWTc2CcMWsXBuZ5wu4cXsoqcs1V
         rhI+zbkqOCpIYVS9r0LhFbwWem1CPENiwoq4Pw+LsXz4o6XiKyFjt3acXaZlCHv0E1tN
         WCQA==
X-Gm-Message-State: APjAAAVB9RGu0t1gAJQhdjMJ3fazJt+hhGuP0mCeoWXnoaaTk0jQJQWl
        yc24bap6YwqIf666mXdp+MdB9l5zOeM5xeKS8DJDig==
X-Google-Smtp-Source: APXvYqy741iSM2u6/mj5HF9mJLUvf4WTxBzk/3jchTmVB1EWeHxmWZcFTfDOtltj6LRSG0GCOtQ7D+jq/zKj0P7CgkdOdQ==
X-Received: by 2002:a0c:acab:: with SMTP id m40mr35031284qvc.52.1563479084552;
 Thu, 18 Jul 2019 12:44:44 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:56 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 69c5de539e9a..304a155a5628 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cd7434e6000d..3c0a5a8170b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -68,7 +69,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 6f302c156bc8..a0996f75629f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

