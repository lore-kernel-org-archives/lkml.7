Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF50C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E162184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvCEMMQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391546AbfGRToe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:44:34 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50338 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391523AbfGRToc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:32 -0400
Received: by mail-pg1-f201.google.com with SMTP id q9so17206479pgv.17
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oRvWsZp4PPUfRyX2ON14DSSZgIGsbQD9v/C1S79uaF4=;
        b=GvCEMMQFq8YVuuH/+JijpqMd2l2xH6x1LMaUu/SVjMGJOGBby5tLLNPrZj6pXsPLEd
         ZFSxIg5suyCmyTsSQVYRKUaR8xC1f+4xFHsqFVxXoTpsAXKbowhu4vjYgddRbVmUa8Fl
         EZumOubz5h8kwiV9SmskAV3kv23BydkTpRqFDT7+m0Jan8LgXyeIt/aD+OoaQFM7iQsz
         cL9+qzHdKAITKq0WPFZbrXvRFsWQN5pwTr3sjOcaotgjM2trQ6fZaMf71DjWW/VGs3KQ
         YKJqe8gmiPzo6DojHAdNNYOGay8QxOvfeaIXCY+038zQeV+by699BL8r8awvLWH12EpO
         45Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oRvWsZp4PPUfRyX2ON14DSSZgIGsbQD9v/C1S79uaF4=;
        b=VwIldE4vDxpUhlJt/+zFovDQFZQBMUld9olSvbjB/yp5ZsQ65tbvTF+7nXkBa1Jc/I
         uB9083/p3J+m8twCZv+5rBEmB5x78igSrKm4TpRlMaMVV+07nT9hevj8IPkEqIMwKS6U
         Fsp1VitXqU81IFxAWXKaSkysG3RGKpQeEef3m/WE+Mz4XI0/LU2j7FniFZBSRbFM//Wh
         OZexXKv8yXAqphFrwNz6oF5AWI+oZud3hmRkTh+6hK1gD4VxX1rnRIZ7eLz+dLHVN/8W
         U9nqBg3L/UZDfxPTWh1GFZb0Gr1fNu2G6KYiLa1GjTRoTOcaDorFb8gn2zmJ+l+DiViQ
         CyTQ==
X-Gm-Message-State: APjAAAXTlmybF3I7CB6+J4/tkY5qN6on4jt5Zlg6bURwFewYXIj1sJA4
        xn51aSaufDZqkvh14Zo74DWDEY9JLDlt4JZ9/4zCRA==
X-Google-Smtp-Source: APXvYqwtMjJhE9QZ+9DHXbweIeAox0CuZXW9cE82ADx+CCjrC+PGj+9gFGrydyeYFQYQ27UGyztfwVA2E/6h4peFZC3szg==
X-Received: by 2002:a63:ce45:: with SMTP id r5mr24775979pgi.435.1563479071446;
 Thu, 18 Jul 2019 12:44:31 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:51 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 05/29] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
---
 drivers/char/mem.c           | 7 +++++--
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..d0148aee1aab 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -29,8 +29,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/uio.h>
-
 #include <linux/uaccess.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -786,7 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
-	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	return security_locked_down(LOCKDOWN_DEV_MEM);
 }
 
 #define zero_lseek	null_lseek
diff --git a/include/linux/security.h b/include/linux/security.h
index 8e70063074a1..9458152601b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -104,6 +104,7 @@ enum lsm_event {
 enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
+	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2c53fd9f5c9b..d2ef29d9f0b2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

