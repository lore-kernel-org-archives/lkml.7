Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82558C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F56820820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTbmRxtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDDAfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:35:25 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:40927 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDDAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:07 -0400
Received: by mail-oi1-f202.google.com with SMTP id q82so345867oif.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZxYq8cG2sFhGgbw0k3aUDfwIzpbQidarvZYq7w9bkW0=;
        b=cTbmRxtu2jUwcJETn1cw2HiL44MplIt+di+W0OqpKWmtj0D+RjaWKI6JUmwDvqOjgc
         Rl96fi5FPAJb06vs3tp+PtGIXumG8NcOOZdl96kpieo3+S/JUj6mocPiKjl0ZUYS40Gy
         9Bi3BAPvZVKk8p6ORLM1tRfxHvU55s9pgGNijeTtpD4/UCgvsJ5LLMGhqk0gLL6/3nSO
         eZvDEvkUN/JIr/KgnIbcdcF5qWY+SiuWdu8O/9z1tVt2QFjSefCCnpamKII+wI6rIG8c
         oEPm3tbJ2jTPZch5fe5hzqK76tr/s3RmZkXLbhe92GGHVvJyD0BNCPAMfcmoyIZLa2W5
         w+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZxYq8cG2sFhGgbw0k3aUDfwIzpbQidarvZYq7w9bkW0=;
        b=GPa/WreSAXslP6f4qq8Xotl2usFdAN5lYxDP39lDG7wSviJEPH7uLqwKZKlT7dc+cs
         gG8ILpWXDGzOlhhBD8p6ejHHCgjCejxbPRKYSGWoVf4zWszrTdG9aLLkQK8xPnepPC0D
         IOPkDOoTMRElr+9716vkXhvm0c0kkJsH533eRJPyGLdQDbtgp3xCTz9OfX0uzk+fZmuI
         1couK7C+TJCkIQLBiaegZPJpEHxw8W3K0Dy8UGJNipBTbtFbdyft6xt+R2PS4CAGxVmw
         Dh16ZWyNk6btAwVtqV+4CXbFhisn8SO2kY/rL7xS8qc9eMPgDvsoTNaAYnUitywnWoI3
         cfkw==
X-Gm-Message-State: APjAAAVziRh9x5ukKlX2nVzfhAaaz19Q5jWJ+I3w5mAJAKrsSBXd04c2
        fgUk/J6QcSOgeS7XBOFqbxhynzWwe8Gd0W6kjhSTMQ==
X-Google-Smtp-Source: APXvYqzeF/5ARGboj1rgaNG0wh8/NpDdVQj41bbjjfIzlbjV3l72O+FbucqOLXfi3OQDi/HWRtdsLh1FkxcoQ+FI+UeeQA==
X-Received: by 2002:a9d:6208:: with SMTP id g8mr289988otj.15.1554337987036;
 Wed, 03 Apr 2019 17:33:07 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:27 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 05/27] Copy secure_boot flag in boot params across kexec reboot
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

