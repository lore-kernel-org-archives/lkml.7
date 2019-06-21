Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545852085A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICMNVRkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfFUBVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:21:11 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39034 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfFUBVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:21:04 -0400
Received: by mail-yw1-f74.google.com with SMTP id w127so4883146ywe.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=knoEDxerDamiS2udwBAyDKB2ttd1lX+80CF4AC/SyM0=;
        b=ICMNVRkNz9HnJz3EvoIc4iF32ARr2jxl8GgTxe7lk2BN+XJU+KaLeMD/xZw/RUgzBj
         2IL4z04wtDp23HqSdMnyrxoaA16Rk6s7u8X92iR3qnSMgGiAALWsSPXk8Rbm5iZf1HFJ
         AKcA2cV/jHmxmTRZu1LPNcYoeYkmR1BjKdhDUXgEAN2OyQgMW1krbjk+tbEoV/1+MYP5
         /Uq42xpHhwGYRr2fefqC2TK7cE5w8u6XMt4GStffGhwP6FZ2bof1USBItw3kW7Kd7giP
         GHViyL8q45sG3E0i5Do1T6WQHdYVQaRRGdkUud8BrJPUj45c8qJIwU9nXrpeons+BrZ/
         k/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=knoEDxerDamiS2udwBAyDKB2ttd1lX+80CF4AC/SyM0=;
        b=g2O7RgEOhd49d/FPTH61wKIanZYGc0k7imZePrvkHnZJ9V6BztxkHmYhxQG74tiBOq
         0CkW4Kx3Yf/eYEpIYRTL/0cB2PqhsFeCMb+0krm43g5EnVAYrClBOjUS8eEGhy+fFs98
         I4juGXwqZEE81Ptbyw/RMgDZ0QBmzuvS82zGiLGYoN/+6Vbh5scnHthDAh9wyjzwr2Ot
         PhZFu328Pvf20r4Za9lDvoFTejX+5m7Pml5GUDzS4jWTnUlnKj8JR6b+6791O8Vt4dCJ
         awexLhHGuTJImrQ5damaYgpRokVnEUeHAD+5D6vsC18zh3HIVuHQoRbh0Gb21PApv1Hr
         hfSg==
X-Gm-Message-State: APjAAAWnsq2d0p4/EWoCEINOSLW60UVo8eSf4vuE8XyxV7xd48zEYyKd
        uNrSdQYtYEWB8DPkgkHUhbIuQuWeEn1RC8sMG6A/Fw==
X-Google-Smtp-Source: APXvYqzXtKc4q/eOrcelOahjOBOrBEBeNLXGOpYukdIfoX1WsAoG+47EYNVhHraiGgoP/Z3FQm4pLmztSWSJawWS+XNZAw==
X-Received: by 2002:a81:590a:: with SMTP id n10mr7812986ywb.187.1561080063114;
 Thu, 20 Jun 2019 18:21:03 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:41 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-31-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 30/30] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..a9ea649e0512 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -242,6 +243,9 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	if (security_is_locked_down(LOCKDOWN_ACPI_TABLES))
+		return -EPERM;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.22.0.410.gd8fdbe21b5-goog

