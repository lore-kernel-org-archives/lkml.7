Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6DC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147E4206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXsxtFi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfGaWQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:16:55 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56779 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbfGaWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so44196676pfa.23
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=IXsxtFi3dTqKB+o/Wp7s083XS7SjUbQMcCgIsd0WIzzMtZmNaSQKck9SZk8/LV/tKW
         iauqc9Sh1AIluynW7+PR4PhpczN6yRdIv953ynjwuwFWHa/UVnQ72sULwrXjNjS6e/rU
         9B58SiL1PCO7x+gwtiCfLRDcFLfHYqJckXhIxs7f7BmC/OAWPsSihkTtRDo4hMCslWC4
         DcbbsuYXQYGwOfMS+1sE0Xp813o+0VO5tuwgaPAWsIiBTlDFJ2yTuhzH/viPVcMxtFXv
         PCDiNz31TQAFo2c/g5gz4FxUjGG5qNoYLTvZVJc1/xMrVhVCF6vii+6Ml1XW+QkFPzAs
         w83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mRx6DvobeAgz9fXiYoI+VAmx830kBHXoGc7G6A5EVd0=;
        b=T0jurBEPOS2ykV577ndCBslOOiOxeqpMQGjfWUFM1cj57jJ9QAhm7/2Md3erLOcamB
         LVJptlfxG4mKS41TiRqNtviRHq1bbfUkryJrz1VumDS5JPVPk0Rl/8PzMEEWpmlUmy2Z
         XIX8LWAsk7w+xOarO5tXGlZujGI773YzE4PLA6C4PplcwL9r8+9ISn5oPy0z/FXpC9eS
         GtFEC05EQOedA4VsP7lW+Y7+VbaZCr25m2WktLHpCzEMFlxK4dq+6Fokc//VLeDb9SBg
         NliU4rk4mRxb1Of3XPMTP0XI/7JM3SPl7DhiwzSLVxHt9iN8o5jiqwj832ArOhB0xPJB
         RfAw==
X-Gm-Message-State: APjAAAU4Jzqsm9RtqQWvB5qby1r2WKDjk3xUGIDP648FWhsHBCHZ5oik
        Rgh1gyZLXQXNLvo/Ma6UmlWDbmxpYQlsOcxC01dYrA==
X-Google-Smtp-Source: APXvYqwPUST8bcWEuK6wPg2C/0aVphd5/eFEPuRhKx/A1xJZobcujQxWD9xlWlFEjxq639LtyRci3WWJHAF+9qOzVRDrpA==
X-Received: by 2002:a65:44cc:: with SMTP id g12mr37784362pgs.409.1564611411719;
 Wed, 31 Jul 2019 15:16:51 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:58 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 10/29] hibernate: Disable when the kernel is locked down
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

