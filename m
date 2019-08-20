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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905D122CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNREMDP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfHTASd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:33 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:52203 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbfHTAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:29 -0400
Received: by mail-pl1-f202.google.com with SMTP id p9so2933044pls.18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2LlLKA7xilo57KgJ9aBUFbPNJv3YWGuiG9UEU7t1Rzg=;
        b=dNREMDP+TG2C/LXVb2y5pqTvco3iRS0dhBeVXMI8yStBmDaDACn0KU8WoFg0ZtiOXp
         +1T4zFY7wH7Hw2KCv+l3gjoQjRE/73lZVZEUW/AxAXh5v8A/u/MA69OZI3mABCI5gjeV
         HrllyORU7+ymSitKrwkt1XKnOTXejRQnccT/TflwDunzx9Gwi8xnTdCF/J87R4Dcn7wJ
         zhSsHEU1M6/OXOYC0CsCHnWyZYtewSK+4HWUGPTxGmxYYU+8IZ8m4D7NiVEtuaekKsia
         XKn86Aw95n02in30KWH/5BMISqdYFuHokAcKWfBMQBNqA6fB+Me65VVB9TyV7Q/5MjKD
         Zmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2LlLKA7xilo57KgJ9aBUFbPNJv3YWGuiG9UEU7t1Rzg=;
        b=M+k9HlT9IRrPWMertr6xkHvGquS9xQRuyx3DUQxTwZldVJCyDZrcvlxaB48dcX6BEj
         hk7+gTkdiax24zYtV9VTfR3ULXXl5HyXBToOjk1AGE64tDzmmBwhFS0GfOxylwDNmfqV
         j1H2rDwTe97s1hwX054DTUAeK3Xpn1af/zSh4whBl7awCWmefc7lJ61QJnkIljLNdd0J
         XvrzQIi7nFf060PU9xoV0nObG5+F4H6y2ESwFIwU8x3abg4qI1FaswxiSKFOjqRuYYm8
         vj/pSosv1Y65DFza/9FfqWJDb8bK0W6357QAN6sOTzfm6qEtoh558v0FrcGEgRgH/3J9
         vPkQ==
X-Gm-Message-State: APjAAAWZeSEtbebq6AdIPSuosfGou1X92z00EebkAwzzMPY1duU92ecP
        bN+keUa6Zf2Cb1PvjRC6awBLuEjHB5zT7LLvyK1itw==
X-Google-Smtp-Source: APXvYqys7jvt/D4+3SJ797I1FFI7U+j4sGn8mLnpJ7BQ8OG5PHg/+H0I5jr+bCp39lsh1kkHfvuUfXaGpWqewAvzA3nz+w==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr22232462pgm.21.1566260308483;
 Mon, 19 Aug 2019 17:18:28 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:43 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 07/29] lockdown: Copy secure_boot flag in boot params
 across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

Kexec reboot in case secure boot being enabled does not keep the secure
boot mode in new kernel, so later one can load unsigned kernel via legacy
kexec_load.  In this state, the system is missing the protections provided
by secure boot.

Adding a patch to fix this by retain the secure_boot flag in original
kernel.

secure_boot flag in boot_params is set in EFI stub, but kexec bypasses the
stub.  Fixing this issue by copying secure_boot flag across kexec reboot.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index f03237e3f192..5d64a22f99ce 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -180,6 +180,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.23.0.rc1.153.gdeed80330f-goog

