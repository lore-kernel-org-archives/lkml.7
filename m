Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB320C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC5920866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKxuTIw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfCZS2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:11 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:41719 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732610AbfCZS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:09 -0400
Received: by mail-vk1-f202.google.com with SMTP id g9so5836366vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZxYq8cG2sFhGgbw0k3aUDfwIzpbQidarvZYq7w9bkW0=;
        b=XKxuTIw96/3+PO2e8Ya9M0C6H/BRKjbA7yCgb6ScDY71OKQu5O1qKynqYWdRZD1PkT
         6X/9B1zYux3mu1aFjig8XS7q3DMLwHqMmXUvoGtAgZTiVqAXOPlB39jvB0b2LcsukNoL
         pPWqayoIdW9Nge+E83siRCq3NRELl3ui1CHNEgvGTxCphitA1+OlZJQrBFj2IxpBsuI7
         OqL6q+lDn6kFhRlnMVUGjoMx6N8teAVHCUvVXD+VM8jpkzW3SOP0RUjD2LSxBoRDE4M5
         OP99Uwtyx2pNjnZ+DqkkO4GZpT9A9MLxfN2L8AWVWnyv+Fsq/32fW8wpw4Kzu4Khwxel
         8K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZxYq8cG2sFhGgbw0k3aUDfwIzpbQidarvZYq7w9bkW0=;
        b=QB3FE3Q1NkmRyNl8I01q4Ka3T1dAGgoad8JMFjR64hf3b2bObonLKMb/Mdu8Q9E7R+
         OfJ0chCfJZetHuX7YD5BS0yw2Kk/V3hwXQeWanikOX2oHTZmZzk93Z5Iiz/gJ+FS+Q76
         +VIy58kM77g1LIUKEj6sC1Jpvkq0gXxFLLGJmtnU/TYzoeNVfo4JKJa6n0scqJw2AfNL
         uKTSo9pNZg23Xqn8npHBd0VdRaUEnQ7+U/un7tZiJzJqDBrMRH6BEbRuCPxgIHAJE/CX
         ox6viZ7bg4Nw7JHfdGvBxwsV286EVYkH8pjqRM7WkIxSoauk4D6vELw/u2kk2ymF7Poz
         LzWA==
X-Gm-Message-State: APjAAAVepL+DkG7NoJK/S+Lh+l5bdaigOepEvI3DrprXtJyxFM3sH9nX
        VDl5C4Zy5at8Kx7ayoVPbvhFQ+pgEkx6aEpLdiEffA==
X-Google-Smtp-Source: APXvYqxlissl0NjOJ+77xdIz+6/F0YGZJeXa8wrNGBsNkoGBnW975xjqFKfU2vra4AZjmcWWJ9+pVUMa08cHnkbiVaF4kQ==
X-Received: by 2002:a67:f3c3:: with SMTP id j3mr10831580vsn.206.1553624888095;
 Tue, 26 Mar 2019 11:28:08 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:21 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 05/25] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Dave Young <dyoung@redhat.com>,
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
index 278cd07228dd..d49554b948fd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -179,6 +179,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.21.0.392.gf8f6787159e-goog

