Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C72C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F8F2586C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unjcBkAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfE3Lk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:40:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42602 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3Lkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:40:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so2444580plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=vt7q/LditmDyJBAB6cODqCjJUh7AilXzOQaTQy3jvoI=;
        b=unjcBkAgbw7XsoMLAZ3G8TtJb7hRvvDrGCUXt/xh35DPXr0Q6iK9Qwvs4QCBOzzEkB
         OuW1PbA+HZRHkHu/3wDGMqIFPhkGLzwMvFQVBEfYFmTcCvL+cXuiDCdv6WDFS1JPnVR4
         1U+pdfaC93/wlJtQq2rXR4vAjJNd41e5CS2gHfkVlVjXUdtxpVi1HvkqvQ2VeS8Di8HS
         Ht5j+8hRoUWFWtXR+yqcfvTOzqIukwdSnf6vCA7PyVjciPoDdvVXKVGW/izBfm+oNI2A
         kfm3ueYlKfUExbZzZxjJykMTKBOK9WeZnGmZlmVUUa9ZSv09ZjQufUGzRZ5eH2nNPWlA
         hxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=vt7q/LditmDyJBAB6cODqCjJUh7AilXzOQaTQy3jvoI=;
        b=NHISmy+/5fa3TXMnHia9/vWI8N2Gc16kfmVEivUPLPtUMNWSKq9qIsWtElVLG1A9YV
         1d7TZpfSYQ6C1lAh4vuoHKSjCj3Ev91UrkBqP6DVQlC64w2Ql264oQooznqaPrt8QV7x
         CYXIhJY0vVKer9jdqtMUxd4i3H6GKYneVxSXAK/czeCBcUo2pwIrZPtlxK3RqFH7W1Mo
         /Mqics0jhf8sIlJ4eAg2sPA61ouFbyUpECRPtlIlDh4NzOO+sydZtavtQlp+LhZwWVzl
         kzJ43IN6GXBsyIRkKoRe7FiHUUzG+i2nPtt4bGIaPtA1CJ3nihyaCJ6Etyh9mxJ3GmDT
         iqUg==
X-Gm-Message-State: APjAAAV8vo8AFj5mKOQUgMJL5y+caVaqVjiNrwRFp9YhTcxS57/DKnz9
        c9rPbWzHhJBth3ne7Z4NHzHSZZgL
X-Google-Smtp-Source: APXvYqwBA+Uj6mDofhNVWONUsMFMYOTtuvz9+6Wg0FgaiY7D1ADu2S+AI0dY67QYuwZWpa5x/4QTOA==
X-Received: by 2002:a17:902:8c82:: with SMTP id t2mr3344131plo.256.1559216455332;
        Thu, 30 May 2019 04:40:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x23sm3361352pfn.160.2019.05.30.04.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:40:54 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] samples: pidfd: Fix compile error seen if __NR_pidfd_send_signal is undefined
Date:   Thu, 30 May 2019 04:40:47 -0700
Message-Id: <1559216447-28355-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make pidfd-metadata compile on all arches, irrespective of whether
or not syscall numbers are assigned, define the syscall number to -1
if it isn't to cause the kernel to return -ENOSYS.

Fixes: 43c6afee48d4 ("samples: show race-free pidfd metadata access")
Cc: Christian Brauner <christian@brauner.io>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 samples/pidfd/pidfd-metadata.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
index 640f5f757c57..1e125ddde268 100644
--- a/samples/pidfd/pidfd-metadata.c
+++ b/samples/pidfd/pidfd-metadata.c
@@ -21,6 +21,10 @@
 #define CLONE_PIDFD 0x00001000
 #endif
 
+#ifndef __NR_pidfd_send_signal
+#define __NR_pidfd_send_signal	-1
+#endif
+
 static int do_child(void *args)
 {
 	printf("%d\n", getpid());
-- 
2.7.4

