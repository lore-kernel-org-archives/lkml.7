Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE68C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D3520700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxYQmILS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfCZS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:41 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54871 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732762AbfCZS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:33 -0400
Received: by mail-pf1-f202.google.com with SMTP id h69so12440126pfd.21
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3FVj0Vux23rW7dwNJJDnKT59ZHynyqjKA3q4fn8QSso=;
        b=AxYQmILSdFg0+F/o39f/WfXSvOMkaN5wYJO4P7AP0HLuNoMiYIIvFwFvfk0hUBiR13
         4UAMjUq31t9bSPe0MnXikCSkC2eyMupf0ei8U0Ch/JsGWJCIxjQKrkYNixwHJNhsKf+8
         ewiscQ7iVR6PbhjFJ6irRmuxUVbZLX5V1eFKDgOc+diXskj2lcYCgwC0GRCcxdXfP6YA
         uW7rY+3bIfIzXqyMc9UiOcDQaANdLrPOlfGEVIiD5evpn8H4GKKNhOV6Dgx16grRJ0Oi
         rDHP+gZaykXlVyw38TJLvk19ALMIfOGPG8dCFPBpoaR2er4L7WOE5TXOO0+zJmre7Hh8
         8mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3FVj0Vux23rW7dwNJJDnKT59ZHynyqjKA3q4fn8QSso=;
        b=agUe5s3AKdizV0ALkeq41X8u0EyYBdxm9D9biQdwVJj1q6CGewhJ/feoJV7yc5uz2w
         HOqGW3N0tgy34BIAZxX8JpO26Gu9R1W1/p+nj10AMbKIXOp0zpWVDn0OqIUHiJY5zVnZ
         sTh9bATV4CG/V3tjl06k+HxVFeBCjmYi3kD61kNgBe/X2cbtLbVQh4rx67PnLYPDRX4Q
         F+9erTO6JVbGlL4PczHqeuOgGtYASotNJt7wcLPIos4DufggIaFFQJDVixRN7hRS+6O+
         OOFKIlu9I2+nGbDQLWfUIbbQkb0RH2zy8K/gskhhANyqH4bTkgT+OkCADjtPhSXmm0f7
         3oKA==
X-Gm-Message-State: APjAAAV2weh4/5H8Mrj+veR7ousA37mJRkrzzyV87BiB+x8Y7Nq8vXxq
        qjFCOpGXJF9Gbox47j1VbkT7xXuGuRHDWByfBAhPSg==
X-Google-Smtp-Source: APXvYqzlbcsO0MLfv7TbuLhLJ50spDBJ4EO9m5/RfC1cSvWt7EDQbTTXzw3lPerDfy2lNc3+4Q1va2ANipQsr3I+ft+bOg==
X-Received: by 2002:a65:5343:: with SMTP id w3mr13108859pgr.232.1553624912801;
 Tue, 26 Mar 2019 11:28:32 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:31 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 15/25] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Linn Crosetto <linn@hpe.com>,
        Matthew Garrett <mjg59@google.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 48eabb6c2d4f..0dc561210c86 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -531,6 +531,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (kernel_is_locked_down("ACPI table override", LOCKDOWN_INTEGRITY)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.21.0.392.gf8f6787159e-goog

