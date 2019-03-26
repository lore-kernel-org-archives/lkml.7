Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B4420866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4V4spb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbfCZS2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:35 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:55892 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbfCZS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:30 -0400
Received: by mail-ot1-f73.google.com with SMTP id d38so8835316otb.22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B6VKNJoBZyOp9UQCoOkYqDvTMA68uU6nV4VivW8ayKY=;
        b=h4V4spb546fgqSWgS1MCnVIdB5xf8zwauormzGFZ9wdZZR11ercKvrV9vGQBG2eaHy
         U5yAE9dWDJ8cLyFUTI6F6itG/zRVsHLE7RipWoTzwm3Euye6oips8veg3p0JE412stCi
         NA7uUXxXILc7TDlsvqcna7OqX/NcA45fCDGPS/y4ARKGku0QdHk5dnOgh3o+dQEsVIa4
         70hb3FA8v3id5jV97bWtqjs/I7rVHqEdOkqe/GO66TDQ+GugNPfTcMdJKuvBVptU8XAN
         pXCcH/lTNqrDznbqQwAn+vWVf2zZb+yYoZ6C8xcYDV/S4TC8M3X2z2kIVCyt6ShkjatS
         1KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B6VKNJoBZyOp9UQCoOkYqDvTMA68uU6nV4VivW8ayKY=;
        b=dvTCFmi41Vs2Ksfq0BZf1KWeJsZ30EKL+SwRuWIXtStSlZq+RkMqfjXixnVc/ORE1W
         oEHF+Vgjj9Slnht5K+DuFem1Gsy2uVIbydh7dAB9F0JBEmUAFdhaqNy9jGfBOdFvcmJA
         Fdt3EzPl+mX1X9z0JyfQT3ONa5I4k9uNpBu0d+szW05XcqY+10hNGN2HYSkcP8XQfxbF
         sDjl359IlA9EcLBmrEPdlDvLSuwVbtqFVriYgoVP/aPFFRPmBYmNpqG+Tt+NvXUwzUSD
         33vMlFgr1XU/mlNHlgRxeAxrH0WLUcQVe/TFN64RoeO/CMsknS3p1Dn33tuk2qKEW/mA
         5LvA==
X-Gm-Message-State: APjAAAX8AqHp4yMX5PfiSz8wYmsGFm9zC/0CfSXUU7WlBSagc3OV8Wgh
        WLQyxk0edG/dyDstz1SGFTQaDwM8In2sIsC/drhmSw==
X-Google-Smtp-Source: APXvYqyQy3Ly/I0+luq4SXBdXDDkmt0+oEhQUaMxXkgB8GNCQOuYQkqhB2oSrkQXziMzg96uVFB1sRh7FJkFmnGB+uM52Q==
X-Received: by 2002:aca:54d2:: with SMTP id i201mr8572038oib.29.1553624910134;
 Tue, 26 Mar 2019 11:28:30 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:30 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 14/25] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
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
index f29e427d0d1d..cd5bba7b8eb3 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -194,7 +194,8 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down("ACPI RSDP specification",
+						LOCKDOWN_INTEGRITY))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.21.0.392.gf8f6787159e-goog

