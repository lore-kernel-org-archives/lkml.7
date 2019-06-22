Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6541DC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374B1208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnFBb4AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfFVAEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:23 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40747 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfFVAEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:20 -0400
Received: by mail-yb1-f201.google.com with SMTP id w194so3738587ybe.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YHpf3S+LawhmDVzX+FQxCcCkHwySWAOsiAjcN5bQy70=;
        b=nnFBb4AQ6PQC9WUZohXByCAVtnekWaVTdN6oouGZ//0ePIiRvSgodwVR27Dg3omm9o
         xkCtoeLK5m3KZWd7e/iGYtOVqbzDYsB4aZ2F5NPcB//sziR1TMMvpIkfSitcqbtkVVi5
         Nb0tvyoriuxSQMP59mzZTCUPGTMdwDQ3qAROu33b0VcrMw8db4r0brWAD662pfhdcBNz
         Uvcvkp6tM9NNnx559yhcxg577vi7s0VaGv0sSTuClodF7BRnOy4WFaaXk5L/Ok90YO6m
         TZHmORNhD0xEtJ9lXBO1YCLkH/3JYy2WUnNXtmOEQqwEGvOU46Ny5FQOUZI9Fel2PK0u
         d/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YHpf3S+LawhmDVzX+FQxCcCkHwySWAOsiAjcN5bQy70=;
        b=UYeqm1sd4bKCpf0y39UjULZ7/rU1biNV4PGmvd3Z4LwCiPUEPCxULHXEtq/6t3JzYm
         CR42JPueqEp/R6ItpIpFvggNZQQBCIaEyJaLTsvnEF5ArwgNjyPmrVMa8OeqFkgtLhNu
         3CpF3Tvw3Q4DuwvWAYamSYBVJiq/CJp0w+HCVr+5XEn5MmAkWa7S6XmEq35pz3PdCkyl
         eVdcREOfn8tzjJaGz9JBVgzEDbFacERVanwe/tzjT9oYmH0kRVgS09KNg5518Im9q8OF
         lzRCXD4kw9dgjBc1J62nJkAdilX/4UAgjkyPKujVu/9fNI67X98EC7xZromLeFn5vYYZ
         H3vQ==
X-Gm-Message-State: APjAAAUuteVRXk1NNrIduXJb1Mn2cljbqpYa6Vc35Yh878tJVjk4WcD3
        JgUZcQordNWYLOaPjrEIbbWkH88w0GcmQ3w1wQ9Rcw==
X-Google-Smtp-Source: APXvYqxaKWP4U28G/EHKOmeo7lhj8YJBHAsd4q2DuqNeOquLbCGwAG5TsajEMGXTGM1UKUyTHnefjMXpm/aaKL1c+HSqXQ==
X-Received: by 2002:a81:31c5:: with SMTP id x188mr62293902ywx.429.1561161859657;
 Fri, 21 Jun 2019 17:04:19 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:36 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 07/29] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
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

