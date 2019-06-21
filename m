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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D63C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1DE2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dq5dOVkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFUBUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:20:10 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:32791 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfFUBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:05 -0400
Received: by mail-pl1-f202.google.com with SMTP id f2so2686814plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YHpf3S+LawhmDVzX+FQxCcCkHwySWAOsiAjcN5bQy70=;
        b=dq5dOVkTOdSfd0FozM7Ov5Two6lGpbsR9AIOljld75nkqE2lD/l+iezTZzt+6Y1dad
         ajewcxBR5TXOQ2MN7iZdTNQcKQW9uSzqEeRy2TCvlLe9cj2jtJKL0nXIRKVLMPXn2emB
         GtlmnJlfE10Ez4ixgSaP1hoFApm53GG9eyXdFrREvn58r656tGslWsX0Hzvrop1nrH2b
         3a1jUtUphr7GGQa/goikEO0OK1cRwDXw0GkKAckn+gZ+UCDSsYc+yUAE7L08JYQOux9R
         0ilcy8SDSxFLe0XGp982UV2SduOe5LFmh5WpOqpQsk9rt6Rcsh+IrCa9OezND7wkz/E9
         3oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YHpf3S+LawhmDVzX+FQxCcCkHwySWAOsiAjcN5bQy70=;
        b=AtdY9CdERhHsEzjz2qq8OAS1+g/oAqKgb8a+dhVMAPnTNjrRC67AvBw0vs36T14Uiu
         H1ZnM95OVc1tYITboWndfyKzaG4gWtUq/I8CFxoYfX1zexWQnlRultqIOhwnrZ2SpFWb
         Cz9pRbGfLHSCrb9A9efHQbpyLzflyNPqgp1+OMDdTJFWvFDHoWWvMVszLRNh3WAAxXSF
         2haB9zhLs68zUP5SB2RAHOyTsGO3G3eMA2+sIdnLrDFL9vk7Dt+/JjNSlfji8k4tJC2X
         yF21Wp5X6nfDn0ySk6lcM+WR0p3GS8jiaH57pDkXn9W5CUoboM1/WgcxBWn40tv88RBY
         I0dw==
X-Gm-Message-State: APjAAAXQtJomr8kz154IVGZWPXol1gGqPBSikLvBQRMD2QHtIeBCnNhz
        UNmn2Q2DEeHC3NbK1zeQ6zHv5JHrcrhxrK0CYoX6kw==
X-Google-Smtp-Source: APXvYqz/OQUUp0959AnAoGMtRG/cQFqGYBYMlIWvKDLKvTKI+fS5zJyEZlJutm42bS3uVQCm+ZHnp+17hJOPftREHMlZYA==
X-Received: by 2002:a63:757:: with SMTP id 84mr4150003pgh.288.1561080004266;
 Thu, 20 Jun 2019 18:20:04 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:18 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 07/30] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
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
cc: kexec@lists.infradead.org
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 22f60dd26460..4243359ac509 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -182,6 +182,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.22.0.410.gd8fdbe21b5-goog

