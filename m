Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535BB206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNtYwwW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfGaWTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:19:10 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:39858 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbfGaWRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:08 -0400
Received: by mail-vk1-f202.google.com with SMTP id d14so29968230vka.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=KNtYwwW10pBzgMhIxkJCS/uENsLSdnfeR4Sv0jIZjE/kqgEDSSHm7qFmZbYcYGhoW6
         ah/D6endKWnFZUJYaYj7c4Z+Ww90IGwhNDxIsN8ddpHHjZu1K7WMe4g+HC9ErAOL+Oan
         P+BwGpuxFHwb5gLspVTRu+6V+KSMYrvGqWk/8uA5Bh2vAksZ/MPON9EHcNcYaMbAc+XA
         C8a2S8I67YkszaV+R1icsFv0U0LpSf3kIpJXXD+cQD5wRZp78DzPMYAZY0V+NEYlQnJJ
         vgeuo4JK2gW0U5FN7kBmSeEw1cE/vN5M3uTg1hBFh/FZ4R94jpLxHeYydBoPJgYD3CRN
         TwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=QGajRbMZkHP3TrqDr/ssbXxMF1BRQ5BrZiETBn8ocuwr+vpr8MwHzypYbSuR0/HI95
         mdZzFTc8B+dxz3FvRKaEKACP/7k3/+7NcB9mS9OgRdsAchTc961KfEuGdoHuOWtfLqWR
         +ub5QHVNSywZaZnTpuacSh/xHIFH/oDPKtS0aA1ciwlwtw8Lb5HkRVPNg29voLbUF5UT
         gAB8Di1I2pOIWvxC3wIaP5MmrtNiUczN5+I+5fc07iKASTojnVG5IcEGwtr5+eZwwHaS
         4Leki/LFR7Zv7HPjtve8JvwdL5wrCkM16/1tQlJpdYG/QVd2Y+wfvG1RnA+1KMeoiKS+
         ER5A==
X-Gm-Message-State: APjAAAVfhifx1XRWFeeuNy1MDYgy824wBGdUX9t0CdMNrdbHgR0Owh3e
        vgWTHmEDcIebnpiuJ6FrrzXis1j2mQhGALM2qRb1rA==
X-Google-Smtp-Source: APXvYqyn7wWBd2XqZE1SpADBue93B65mbiHUDF9eDEu3R6HN098MIwjsGaS2ZfwdCHJzwoGqIuAtZDoBJTZs2wCzIwTnOA==
X-Received: by 2002:ab0:4307:: with SMTP id k7mr12696958uak.45.1564611426939;
 Wed, 31 Jul 2019 15:17:06 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:04 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 16/29] acpi: Disable ACPI table override if the kernel is
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

