Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D7EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D1D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhaBOeUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfGaWSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:18:51 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50558 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731352AbfGaWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:20 -0400
Received: by mail-qk1-f201.google.com with SMTP id e18so59266839qkl.17
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FIo2fvd2ZRzAOCkOenwujWvUsEXtgcv+etTkEkyg1xI=;
        b=ZhaBOeUn+nS6E4T1+sBKPnygtWezzpdPerEqfA5uqkD0XE7ajx1N3BtNS+gYIFvTMv
         m5/OTl8rt5TML9cNVvxzr00+WM4rpnQh6KtnkCsy852F9N/KziU4WPdi4AoTxbrZOIGD
         ZOFwSYsTuejxhPisUAE8hIyWXaA2sjlt5OXBzdmnDWJ5pncwcDuVfcYf0NntTSKlpQjp
         rKKZtgFGHKjLXws/EcubYglXFByM0y93MDCDhUiun16sMe93nN1WtD4on0KReHoc1RCd
         b6udBfRpp4S+HJiB9HNdkFhA4hO9S++7vB0TtCj9NlX8THX3Qm4rDqKyBqdn1siC5g4u
         RUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FIo2fvd2ZRzAOCkOenwujWvUsEXtgcv+etTkEkyg1xI=;
        b=iZkLM1o7x4yjFZuvwmRvmCh2R6RmRPz0nIv7dGBdRkZnw1vu/BR1pTcunvntuUAJTy
         QurXsZnQz+UJWdx72ufwhks5FbJGMheSB0nEwJY86AXkBcEEEiPUhfkhs2mzjFqFRFNx
         tdT2ES2Y77xqqOxwLqRDq7o9ky/9pxOpCNILnMuipRmdnt3Wm2U4b/2gnpf5mzomriOe
         zD1kNcE1E4WLlF1FNis+/NY0HTJswWVk1ejEn/nn1C48Sd59QQUMm0DqyYBXp4nhuhMO
         qP41ABDWDFfJ3WeHBkMZs7jlC+sPMEuF5AUtoGoquSNvpxRrTZWv9BFkbJYXC3TJHdFR
         6hHw==
X-Gm-Message-State: APjAAAX4n9mhr1TF9EBC6VNibfS73RSfq9sB/25arkzXK5zHYuElDT04
        sTC15J2HTM3a5gSLyK66FvrmDKgsTvsZcuWTlCZzbw==
X-Google-Smtp-Source: APXvYqxuoZZS41br52XXtB1It9wntwqv+gu5vKv5JgSETNL3oo/Kz9hO3JnuMiwnS1ORMBDzqM9a9+iQGWlIZZ9K5OtTDA==
X-Received: by 2002:a0c:8690:: with SMTP id 16mr91555482qvf.228.1564611439834;
 Wed, 31 Jul 2019 15:17:19 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:09 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 21/29] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/kcore.c              | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index f5834488b67d..ee2c576cc94e 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/memory.h>
 #include <linux/sched/task.h>
+#include <linux/security.h>
 #include <asm/sections.h>
 #include "internal.h"
 
@@ -545,6 +546,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	int ret = security_locked_down(LOCKDOWN_KCORE);
+
+	if (ret)
+		return ret;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 3f7b6a4cd65a..f0cffd0977d3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 37b7d7e50474..c050b82c7f9f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -31,6 +31,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.770.g0f2c4a37fd-goog

