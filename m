Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E323F2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcZabgis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFUBVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:21:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36183 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFUBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:31 -0400
Received: by mail-pg1-f202.google.com with SMTP id s4so2992656pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MFrhOOVeW4IxvuHo8Dzy6dq7eeQGF3tpEcYBlR0WBso=;
        b=TcZabgisBkyxXJLrHlJokm7pF3TBlp704rcyxWqQr7UBjl5F7Ssjc96k7OlHa57HX4
         3xR1+ubHcpOaZiH1aTCE78J/YCxbY6z4BwqD44zr9aEv32L/y7usgub1W7sKV2xDI3ui
         tF6cAzVnYWH7eBYL/UDuUTdSJHS9OCxCP6uQ+DH/jPiEGGXMqGomAGLzMHwBmJGKO/Xi
         AZybp8B/Ge2tdSkOVjvjBa4Zoteog0hysbk6bv3DsMj+DyQe2nRuLsoe34IQ3l3jBxvY
         vTJuWKTdI92NMOeDD33HDAxRxSAyxBwigO9hlP8a6pjmvcu3N8UTxybhZunMy4TXM8Pb
         mrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MFrhOOVeW4IxvuHo8Dzy6dq7eeQGF3tpEcYBlR0WBso=;
        b=CVlya+0jFpRPWBewUObciisEB1ModJeQxu5MtVycESgKcSj0hFZxLcEyo8Cvfq6G+w
         wDTIQ9D+6rDImDJ4CFOaI8JREyZoPmrg9CM3kzQA8INVi359gYJ27BdGlckqrPK4r7vS
         22D7eqYU2yVfbS1qjU2tqHwGvLiShBNMIQt55zX/uAo2HRtIuuXRDETRhG0tmjOZ7Bqm
         PYnOL4DgX5vMH6HP791HdL7hz85TTENfruIVdx2h9G/O9cj7uEjEvFoMVOTW5zcDrX37
         N+3Q3DvvCN37AVLyLR9pOQEJwEvi8y9ulWxyFFkWDpwmP0b5V6YQgBhg26M5SVtfLjXw
         N9qg==
X-Gm-Message-State: APjAAAWjkdHbYllTKsnKbXye3ugoUxu22+/8eNjeF/xj7kcuqJke3YVt
        NuD6JIT4p3wCF/XBbQ/JP4oZ4D6Veu7256ZLZykILQ==
X-Google-Smtp-Source: APXvYqxHE/gBOkhAiSbfrmS0K/Wbmqx3GctJ6ZvOlTkR58pahzRkAQYiz5QtoA6YyUzTLy4ssZQCfYbpp0KUfKwAi76AKQ==
X-Received: by 2002:a65:448b:: with SMTP id l11mr15174758pgq.74.1561080030187;
 Thu, 20 Jun 2019 18:20:30 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:28 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 17/30] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Linn Crosetto <linn@hpe.com>,
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
index 8fccbe49612a..f8e7d70f07ee 100644
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
 
+	if (security_is_locked_down(LOCKDOWN_ACPI_TABLES)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.22.0.410.gd8fdbe21b5-goog

