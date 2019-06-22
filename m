Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA743C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF2920656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRjJLKdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfFVAEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:44 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44867 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfFVAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:41 -0400
Received: by mail-qk1-f201.google.com with SMTP id c207so9370537qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kMkOq/TdZP2DxC+0jYMlNvaXt/K0jRyWoQ2RXLMuYi0=;
        b=QRjJLKdNtZo8CP4nTH7hluG2qV1AXyHaeNhLgJ9dx1fDUKb4PKvKgsxZC9qD/JpyOc
         nDlpqLlNjPK2Fr6/XPB9DFGktNMicEjN1U3rsUDXfXc0qt6uDJ4LiVqBRuB0IEYVTdqC
         g9pw8gFOb/hrRGu3KsVlrmVHnvI6Fg2+fFpvLxGvsYk9kHFo5degfWEqDha7Y8eH/AMU
         owop8HB8frx+BdG4M4kFYi15V93p/L6y8OBHHLti5WrGcp5xyaJuzKxcJQQIy7uVl5RI
         bM63+qZ8cl4gZwKMeJroO8r+Eqm/Y9IaQqorCVln/XP6Sft3X+wUDeJFpOaUTuF1wRyz
         uPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kMkOq/TdZP2DxC+0jYMlNvaXt/K0jRyWoQ2RXLMuYi0=;
        b=CLyoXZ06iYOcUE6aOH+1LsKB/zSVE8c+R7ylRt2fPjIv3SdrtiprLOm6ZudTq/VXrJ
         Pjke9dbP9TMMtaOAxPh+i+NKYaUFAh4ouUOttgWMB14+P/QZCerLlfIuiR2+rs4wTiyl
         4GlEyc3IjZZ9G2nC7CgHpOjEmtX8SBmTQXH26aojxKe05DBw3Z6QbhUFtsb60F1SWyCW
         h5R4/6vXHVcMNw6HC6n2WQFl1aQC7WTzUPmJTIxfY4FaaFjO0epxPWUMmjGN1VwzLybN
         oa4V6p5a3ryPgUU0LRBmrrQAHX92+38Pr/md+zllpqZ+7+1IcCn2w3asWwhV1hhJMlhu
         phSg==
X-Gm-Message-State: APjAAAWRW/tkQbSIwGuhoILKAzSog9rbkcpghiKwA0jBwfWuREza5BrJ
        AmagMVZlreGVo6pWMUYxPIePwaUgzhxIzxecVbZYHQ==
X-Google-Smtp-Source: APXvYqyfTelCSA7v0vPY8aBBSkh56jUJFjBxZnlm2jUkbBn4LGuF/pZ/ysDWTqqbVvj8Ybj3gU9B9i2a5Gg4/j2L/hPeGw==
X-Received: by 2002:a37:a9c9:: with SMTP id s192mr111878928qke.335.1561161880192;
 Fri, 21 Jun 2019 17:04:40 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:44 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 15/29] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..60cda8a0f36b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/security.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -194,7 +195,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !security_locked_down(LOCKDOWN_ACPI_TABLES))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.22.0.410.gd8fdbe21b5-goog

