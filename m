Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D025C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7B42133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ruw+AyiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbfB1XOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:14:36 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41153 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387554AbfB1XMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:20 -0500
Received: by mail-qk1-f202.google.com with SMTP id f70so17167261qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uJSG4DfOm5wajFhd/fVp5JjZRZbJ1ZIYh8VYeWgqjpg=;
        b=Ruw+AyiSDZ47njZAbBZaRrEZ+ClOByQdbrxyjiK4O6ppfEXb7Rv+WzMs/RrJ5O4jP1
         Dxm84G0NNsq1mR4oERWpXqSQIwujmDFAg4+h1xhzJIbfgxaH+XF1dRNP1najZMpc9C8A
         oBR1ZpNcbBgKGNf28Y2pyslDbDtAOg22nwGrQL1DIK/pgPL3UQPCZXBANWv9RpkTdcPF
         MQzsINxIhVkOmpux2VNHTvttTgDm5gtPSXr/aKGHeAt39PqSSTpfm3X3Q/Ws2gjhGAJR
         ztwjrhFoQiueFYKCmLth5vaunhFITzN6MdkANN3RuG8EZVqWK0Q1+k/3Yq6bOo5ojyZC
         VLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uJSG4DfOm5wajFhd/fVp5JjZRZbJ1ZIYh8VYeWgqjpg=;
        b=Sa0UI4MsvtD3v0nAcoIZzic+3RVSMMh+BVAccR/mdgNlfWCjt3UT8bEqGSdwrU2Z3x
         tddNugWuX0g0exMn5Tzp5DuHHEe6deuHZ6U/5kBg4RAXt0BQaq+bG4J9d/X2ciwiHZU2
         giBvE4dT9e1g2pKhT5r+3uVEZt7YkkwhdgwTxjREIkZsK2zi7HhPuyRzqyK7DksN0rN4
         TeSM0fxoVKzajoXk8UqUolmSq6GLrV9BtqHIGtO2zq0KK7YrXiGlurIUtrhvDrKPulof
         8+iBFtk0CmtoerFs2RFXwfsYsNtcHyuH9swKuNJqn1J4Mit9C7mlhmDUcLRTTzc5tRlx
         MNdg==
X-Gm-Message-State: APjAAAX68hkNrBhx1DbyhZfx6jBkfoJWejQZEJWWN2t4TRhTIb79mfZb
        fiPdthpNZ/Ly8cdvHlFW63fuj3Fg241sbdx+Cpg4ng==
X-Google-Smtp-Source: APXvYqzfQKeEcAbnraohBadiJQXH1phr5qwXa6NhpSZOwRC0UMZMDCIv1gIs7WF6+nytf5B7sWkQz5s81QdNS935XYJSOA==
X-Received: by 2002:a0c:b8a3:: with SMTP id y35mr1037792qvf.25.1551395539553;
 Thu, 28 Feb 2019 15:12:19 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:42 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 06/27] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: kexec@lists.infradead.org
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 53917a3ebf94..58301a11f6da 100644
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
2.21.0.352.gf09ad66450-goog

