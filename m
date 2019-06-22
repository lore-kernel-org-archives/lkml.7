Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E51C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA9720881
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWSAua9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfFVAGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:06:25 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:48995 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfFVAEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:43 -0400
Received: by mail-vk1-f202.google.com with SMTP id f184so3036477vkd.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n33H2caFWJMziV8Vl9fEyuQPirYfKy2HcqzebAjjbEk=;
        b=QWSAua9g9RwKP0uU2R678HQj1nTTQlk+ccuY/QK3BB9zuEyoAp2MVYhulrYkxknxtp
         8CcguRHGvVDf5J0QYKG9GN2mG6EWCobGgzOL2HDjpsFhBVlDO71Hs+o0pLtXh/p3Ed4V
         N5nM6O7m5g2LG2oUQZP1CsRN/M4x/GGJNW1x6vRcXwslO1ZZEosxSyRhL7850ntFt/Qr
         0nB8h31WahXFNIUcWpZ86cgp6VcJyrAzNoEdvFqSnlqNyhwwQTw4mGjPAMnnSJ4bBY5N
         uVnBjMN4HatYvmQyuAT2EkWPBDPyZag+Wolf4TT6MIZc1eWQtxhPUA57hp8Msm/MWMnW
         KRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n33H2caFWJMziV8Vl9fEyuQPirYfKy2HcqzebAjjbEk=;
        b=tUz7sbUAksJ/GCC2UU9R7qtWjPZdufLO+QFRKB40NUy64oURrYOtQndbi1LSJ2RNzl
         SFpoD0v13OCwxaFYRZzXPC/sGAvX0rpLQHWuLxz7aPAn7GloRWYfVo4llsZxGrPEd30G
         1beBDxGPve/1xxVvre9rQcPP6+yWhJWxCvELKEPJp5+l583PlFKTE+sCqulzALUBtA2q
         QeO4N9iQY0dwJOsTtZYl9qVnbpY8uPLzCvhbvPr26wu1npQlN3+Is9XDqL+W0RQjq5xM
         RrlOrht9f8+nMQwML2UewhEYF6akjTZsINAKbjx99mVGCz3+wAOnZTWlibZE7jVwpKIw
         4AnQ==
X-Gm-Message-State: APjAAAWM03NBQkHiiO7z2fsNM+6tUQoIQp+ezjTBIQtF+U+bAZ0DXJBV
        o12Qq/GlJ4URulm6q8eKUuyi9igP3oXJHFgxkpmXZQ==
X-Google-Smtp-Source: APXvYqz+aR99joPErIIEbc2OhbHDT9lUw4o9PwDXDXdQ9wGtV1PBN1Bun/Dpx72Xl1cgY14BcfWe++NbFFwjQPw4r6febw==
X-Received: by 2002:a67:7fd8:: with SMTP id a207mr52544296vsd.85.1561161882682;
 Fri, 21 Jun 2019 17:04:42 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:45 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 16/29] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <linn@hpe.com>,
        David Howells <dhowells@redhat.com>,
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
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 8fccbe49612a..41d9ccd0e075 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -34,6 +34,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -539,6 +540,11 @@ void __init acpi_table_upgrade(void)
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
2.22.0.410.gd8fdbe21b5-goog

