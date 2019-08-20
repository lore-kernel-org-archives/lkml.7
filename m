Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC04C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBCD2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1htn3p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfHTAT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:27 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:54644 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfHTATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:23 -0400
Received: by mail-qk1-f202.google.com with SMTP id x28so5215329qki.21
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+olFNxFYhjL9QRL4ImBQxYfzLxvoDTRC2EU1toIBTB8=;
        b=g1htn3p5MZXFXzHIA+Jjt6jTrPQQXmo5akMJNxXZhfwpce3QyP067kNbJy/zfSbTxP
         cqz6lYhGVH0Y58/jTvOZi73Je+dj6hcnU1VPmFh5JWW26socuEY2ootWG3DEUR1iI5Nj
         FkuD5Sr2MnqIJJ0/mQ2m1R+Gatojxz/0YnCKFlSUhlohVO86a0EARley9S0ZUdIQjx2/
         PHareqg3wUQzuEQVwba2lcWN6esQv5jG3FrggakTQ/4Pq46kBazhFsDcmiyM2nxDFwVX
         7HJPcEoP4vJw5ivPgLu++46qCQuAEe782JNqba2Z2LlbukNPdEi26D4bMgjB2C4twbvo
         XJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+olFNxFYhjL9QRL4ImBQxYfzLxvoDTRC2EU1toIBTB8=;
        b=eZlYsNddS1tuIZYI2CBjej9ntMf4DwGlnSBTVqKdZU7HXIuMzi2L0D87LgVP8Vqof0
         2LEznJmGFzM4w/m6zmXiQe8+DXVQH71O6WiB9wy5TFShQ8dd91RNyChrqWZaipQdZ4Hn
         OLBtxRCEx634n98DeTgJgDLC781DNIHQA8biKPEZV7hLSKkg87ZneicFqPnodW8Wt6kl
         OMEiwYYpRo9UHFNu8igR7ha3WzMd00mi3hOWmedQIkK8b7Kzv6O6T+5ZXiqRxJ4aD0qM
         ZsTl2XWoJgCkhT3fITyZ/jnpcVsGH8+8LAxUkwCjZECtwFJUc8SPeBHr+8ceMhO6/WMc
         beDA==
X-Gm-Message-State: APjAAAVpzl3f20lMDoghqL2CWMkhXwC7YmPpXGbFaWIlfKcT+0EJ5ShT
        wOsmDcKVTLjCjDb8qYGbwHHvXEpVvAOTVqfGwcbK1A==
X-Google-Smtp-Source: APXvYqyKVq6bwM7kYeFQvbD+BxIpXVpiuWJNkgMoBfKq9+4QIWBY0VIK8EebTXkq1faB4DrgMP8UwAK2DmoUx9lvKKRkxw==
X-Received: by 2002:a05:620a:4c8:: with SMTP id 8mr21987278qks.366.1566260362547;
 Mon, 19 Aug 2019 17:19:22 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:18:04 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4b7cf7bc0ded..5f98374f77f4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -241,6 +242,11 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.23.0.rc1.153.gdeed80330f-goog

