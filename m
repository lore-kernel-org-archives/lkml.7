Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E72C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B503A218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nb/f8Yv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfHHAHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:55 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56127 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbfHHAHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:51 -0400
Received: by mail-qt1-f202.google.com with SMTP id z93so1973281qtc.22
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=Nb/f8Yv6FUVnI6AIYErVf4XUZ415HdkvpRagDvig0laxwN4e5b6qWT1BqjPfyTY3gh
         /H3whwCBPF7qu+ONJFFcvISfyrKbJANEayQYzgY9gHmZ8YKQ+kEmvPYPYXODnWGXvi5d
         F8znJJWnR7znYQH4GDVeoGbQexpU7EVwK6PZksEIOj0WfKvyQIByPBZuAZ9IteArwCXj
         WCIVC/+E1p3z4aH2TMUjSVRwVSsuCq7uBHKlr80Wfaai9/4Xn1k7/15AnRb9A4Ctyc3R
         GgvmLYIcY0b7C23Fi2Fqh6yf9PKj8RyyTjrNT2czlJijhFqHjk2/PrJ/3idRZYhmTtMI
         D/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=fIExXZxkDx/uTYd8WNvRmPUVL+htAXmvCjNwhOCr3shCrUsyINtBLWllJI6M0HHQkG
         RvNfkRVVRiQev2yo2CVPRZUozojb990OgYakWZWVc2fstktUAlX4ZN+8e1dfGvtSz62H
         cjLzYKZlk6c3ByXdqAq/tzHlplCHE+i+TPIZD8X+3utDf7dROH/Isuysdb/mtO5s7Vne
         I8+Jp7fWpq1QZNOZwUlAfGIGmSx/jJiG4KjpLj9szAN0RY5wytHi1P9RGFlq+AiGvQJG
         qubSVdZfkSekWxgj82ltLhI1QN9Drs6fRxiPnOc9VSdCeqTglDwB13h6iBv7tiP2UVVQ
         oJ6A==
X-Gm-Message-State: APjAAAVvEmmmsapbuAYq8F4YTVWuMrqNDFdX3ht7aw8FS7a6vrfOOoP6
        WsZa7cGAUAZKgOGK4o/CM6D04hYIVJAvSVdgzo06qA==
X-Google-Smtp-Source: APXvYqzDD3e/DDDmmiFWtFLYPkI8+F4oMu/Vs4BKQACi8mWeuLre1RbWU/82SKWjQJaIbIWLzYoh5zi/iHEUBl2vePR/rA==
X-Received: by 2002:ae9:c303:: with SMTP id n3mr10359268qkg.372.1565222870081;
 Wed, 07 Aug 2019 17:07:50 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:02 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 10/29] hibernate: Disable when the kernel is locked down
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
2.22.0.770.g0f2c4a37fd-goog

