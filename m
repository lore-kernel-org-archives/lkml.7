Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D669AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A814D21873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kf/lJKUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfHHAIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:08:11 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43261 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfHHAIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:08:06 -0400
Received: by mail-pf1-f201.google.com with SMTP id 6so57824680pfz.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=Kf/lJKUGyFrHWv7boTRudlru1eDOO0jCqNVRU6s/zrZ4UBZ45Bbg1hHE2vw7Kquw/O
         BtmrDHrQUguITMHZO1XRWt3qpTLuWh6bxlUqECbMiGx7OZtBnvpDBakjN0ycek+Ym0oT
         VEE/nfvsA+clVcjyvYnP3yVfxBQ9QpNrgqiSN9iXWbQBKtZODoUBJE3gL1xgQP4vtAXo
         kMtaA+zKROv6wnq4ugj/1KFMS84SGY1llsNh7tQgLT1xUYuAM/6MYMXMd0eGnvzRvPLX
         JyMQ8QDVGqY9caZ+fSX9gEVqLuWWBd36lDPkXMHTMMeiOjGTb3iNw5XbNw5OK6wScvda
         CO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=mn82DFQO+3XnJb48g2m19dSzVwdmiX4ZisGDqTkODSDs6RYKHH9Dh/GUWsxsp4og8q
         ZadymlMHc/91bB56FyG95pmkIiW/6AT5tT6lJRpJf+V+POqRsaK/SBWntFbO+m9pNZ/0
         MzcNCkXkB6JLOGQtZadeyPFzjK1rchg13RMFyFqRn5j5TW2XctbRHURZLQ7lCJYRAdQF
         TbgMdz8mmTnw/AioMi/aUfFIG2YrEKhnG1SakmrZi2Ndwf5ONizeOUdc66K8QnDFzoCL
         lddAGfp5jNQknVJVBmZrI6XnLIAcX09PNRGn2Z4J3puK0TvE23ICHgQme5iF9kAOE2b7
         sBRw==
X-Gm-Message-State: APjAAAVmopYQfYL3CYwC7M5k3XqCzh2TvA5VSJrAk6FAmT1h0QfC6Jjx
        wk7uG729X74BGdD3sAomftTxLxSYXR3qGfbF/S8y0Q==
X-Google-Smtp-Source: APXvYqwwJbX16Z8GxujpyEl8EKb14qjxjwwHWOxL57n+QSxdmTSznG4fkHV2cE5AB2mqJ3GSZPqFVdUoApC44ww6iiEddg==
X-Received: by 2002:a65:6859:: with SMTP id q25mr9838575pgt.181.1565222885343;
 Wed, 07 Aug 2019 17:08:05 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:08 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 16/29] acpi: Disable ACPI table override if the kernel is
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

From the kernel documentation (initrd_table_override.txt):

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
---
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b32327759380..180ac4329763 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -20,6 +20,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -578,6 +579,11 @@ void __init acpi_table_upgrade(void)
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
2.22.0.770.g0f2c4a37fd-goog

