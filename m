Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF19BC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFB221849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sr+U+0BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbfGRTo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:44:57 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49366 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403805AbfGRToz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:55 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so17207560pfw.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RmH/lQXgmHpT1wDdkDviRnHZue3oZYbqIfCTXvy7fCM=;
        b=sr+U+0BUhfEnXadfS3Td1uoyOy7MyzT1cfjoaE68UBw1WhRqNJMBFgpLkQFYR8CYek
         KMLLN+smdCN2smIEcLzxglZftb5hu87OZDSnHoh58j9iUJ9WtMY8gtatqIWRzLoReE4k
         rOXwOJJUY3pNC9LTVR+45zWViuky5wZ5OsqQmEH21XbkAZ2iczTBIY0BDe0O6ftn+0Nd
         N8VHxUEL9vzNp13MjZ/HenFMfJvjHjVq4+s9MH40Hv98la5iFc/+chgCT/UbR25vQQo8
         f1K5mSd6Q5IDsOeHHgZ8Jj3sZRtyFkxD9BOWOQoOTJwCQ5ZkVLIwSvMUjWHIe2vcYKG3
         IrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RmH/lQXgmHpT1wDdkDviRnHZue3oZYbqIfCTXvy7fCM=;
        b=WoTeMSz/OvaEVljnca3Jw/tsq0+AlzFd4zJ9TARlub6WZCtwOyWdIZgFzhzYSn1Bso
         yPvt3apFigxP/PSUZ7ZuxN6+7EpsmkiW5BqlcRBOOwXNeOEBbCHYQOBffsDflZ+iBsFa
         pSulD2N2bJZmPGD8SOHysBPuF6s8fNSM+NnZ0JaAiE3vmIE8DYgpHZMM5nnnqbTHfnQE
         32DqwATbZFkSl+a7u7Bs8pByHlXg8NjUXwCqW7IQPcobAR0QZaSZqNgCgQFWYRgURTvi
         0e0FbVuFbetrHcj8UMADymzyVncZx8lYrYkNpxSbJmVD6gVf6H4RKpwmhcpJHDUDRS/I
         HS4w==
X-Gm-Message-State: APjAAAXmSQ72w8fJLuZ0Z/hTakNEeeIWeriaNHt2sloOprTq6DJOSxfj
        Leg7j0o64d54AWzp6etqD2FikPzRlB0oj39wAciArQ==
X-Google-Smtp-Source: APXvYqyeJB/q+rqGISfS2YyA1gmULiVA9NiMn8MYvGu0Kh+AP7Ivcdvfi4JVaIEOuKfNlKBPpuhBRNRFf/1QBiVgkwqkhQ==
X-Received: by 2002:a63:460c:: with SMTP id t12mr49204271pga.69.1563479094865;
 Thu, 18 Jul 2019 12:44:54 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:00 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 14/29] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 6 ++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index b2ef4c2ec955..7031307becd7 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,6 +30,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 
 	struct acpi_table_header table;
 	acpi_status status;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+	if (ret)
+		return ret;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
diff --git a/include/linux/security.h b/include/linux/security.h
index 155ff026eca4..1c32522b3c5a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -110,6 +110,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d99c0bee739d..ecb51b1a5c03 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

