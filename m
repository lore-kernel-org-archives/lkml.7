Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7261EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CE722CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXk7YvHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfHTASy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:54 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44182 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfHTASw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:52 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so2936202plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r2xGnC0FtOlmxcR7U4lP7p0O5/wEeWW3Rzosx6HPL/8=;
        b=JXk7YvHu8uy9Vx2jXXzyKER+S/SWTrnD/83LRDR4ElsTuqbjh18fiB1AgcrqZ1ZtIF
         dMLq3zzoXUE6dXGuKvPut+6ATWyGRbKYpJQIWJjwFu6Tktlm4+khhBMdXLh/0OqWlkJD
         h3VT2eyE0HfHclqvuDTTYe++NSkz3ZXZS/oEfZAVPh9H+VGFEqFJWQTLj/AGb6qRW153
         dVTBXGCk+4jZcyzl7B6lYmE2JFLT24V4zbxfcymtMySEfGel9M+ifHbgb0XkoBrbcMve
         Smv1XxFiTFUE/g7rS3PzrYA0UBMXXLGMKnG7YB3ziODgQiU6yzj6lIxTEPV4wJpLoQRH
         +Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r2xGnC0FtOlmxcR7U4lP7p0O5/wEeWW3Rzosx6HPL/8=;
        b=Pr8r2Vi9L5nBTj8oQreyCJIbCFKlJUqzUtv1OIg7x8HBHp0G7hy9i53LgZJ3ObKdn+
         fBJVqVZT0uksWqzyHY9zOrV3zIY/n0QM7ALhwtFOEMLeDa4Ouh3SrDeOqBVWV7dqW4+y
         V+0GfnGvIaODcu8OwY2/MfnmtslghE/DORVqYcTFkaPbawOO+dKe0ojEwd/+fuSDvQFh
         KEbi+vMI8+SH1gboJSiFvmrnwORCJp+mQlL0IyYW562RLGOHNLoaQVh759xebGNEcK+T
         mxtpmGlg2i3MQcyhRyPJFPX588L7Wam/nEWv/fON7YfIDIoRqGNJy2Q3EMwmkpNVUJQK
         ptEQ==
X-Gm-Message-State: APjAAAXmm+uX8PJaVwXPbNEdw6CYF89LiE/ZwmZJWe/nZGmxqHJYjvpl
        h+H8bEMUOkAa6XJxPw5BwhC/DCUZd+aWso1hrimRZg==
X-Google-Smtp-Source: APXvYqxrGakYRkc/UBdl5S+Lz4mZIkCuit30tjXFo94slFXGF6j556kZ0jwzI6cM9tqT+OLJIW/WjG8X9KIlf81TlA81yg==
X-Received: by 2002:a65:56c1:: with SMTP id w1mr21932176pgs.395.1566260331657;
 Mon, 19 Aug 2019 17:18:51 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:52 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 16/29] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <lcrosetto@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linn Crosetto <lcrosetto@gmail.com>

>From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <lcrosetto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index de974322a197..b7c29a11c0c1 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -20,6 +20,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -577,6 +578,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (security_locked_down(LOCKDOWN_ACPI_TABLES)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.23.0.rc1.153.gdeed80330f-goog

