Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD9C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E44208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dq01yU/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbfGRTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:45:04 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:38140 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403865AbfGRTpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:01 -0400
Received: by mail-vs1-f74.google.com with SMTP id k10so7294476vso.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8KDC4TFcTV1Qdw2x6JDnGyK/1HMGYSMk6A05DVDwER8=;
        b=dq01yU/V68RBr2Lu3Ccu8jV81vXcun9dJ22LdvOfwo75XHTlumm+2N75HW/98KlkvM
         roP9j5uWvt0qI0/ymgD4PJlLxcwHRn1BQmgzycgaUEy261hGKsR0sNCwLnmF3JU2Crt0
         mV9LOvlp5DTQnbf+eHXgmQcTf6vdcPYanOndpoSh0UC2Xa9TsLmYlLdHnwaULJeTFFi2
         YXrc1GqxAyzeVGlMFUru9/qj6xUccrDwzYoCxO9/bM5n6GGlEw4sYibtTMdnRRhRly3K
         7wUgeC16EnLGT0oQl4J1pPuuzR++NAjnCvd3j4ZtED8EVEt4cQqWDREp14+UTkJUly0l
         86Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8KDC4TFcTV1Qdw2x6JDnGyK/1HMGYSMk6A05DVDwER8=;
        b=IodHT5l8GkbYKl1zCZKUz+SFhx4XrPkMu7SgZAZ19g2MnoqK5cUiX4N8+9i66uT1PX
         xuTA4JjgSzRONGdGg26zRjoBIBAe0CJjPC0H+5VIkUzui8Dm1Ub+muSCPSX2eKHHPskU
         lWZPuDBOhcvauF0aY2VGFFuJi4EvCNXbGkZ2neb5zCJ21FAFdCehD8z/wsxccXS8hcv6
         TM8GDL87bPfg5IwGl8JkL4y9KcYMmTtbyyX0lqc0rZ2KSpcMLSuslKfckJl6MeoErPvQ
         DQkXPQyKd2GiosDr/jHXas0/xxxF+7vpA7W0ID6axBX8ncbZLo0odq9QWrdArYQI15nw
         qiBw==
X-Gm-Message-State: APjAAAUsReUupzeYUjm2slXd+YvxVAFWVfs4UK4MKjqXTF8iqiUR9Yjl
        w8/r22iKLAuOOgVg096cEYnf2WHuptVHyJnbWn8laQ==
X-Google-Smtp-Source: APXvYqwoBuMtJhdfuOUM+HOKTlVvU3+lHPezK3uGPo6GGnVqXOM7R5MHWqWIevMdGYtZWmhwaC7r2yO6XEFK/yaJRVrKLA==
X-Received: by 2002:a1f:5945:: with SMTP id n66mr19511174vkb.58.1563479100123;
 Thu, 18 Jul 2019 12:45:00 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:02 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 16/29] acpi: Disable ACPI table override if the kernel is
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
2.22.0.510.g264f2c817a-goog

