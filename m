Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFF7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5387F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcOpK9az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCFX7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:44 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42575 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfCFX7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:42 -0500
Received: by mail-pf1-f202.google.com with SMTP id p9so15433384pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J9HskZ77OUFICI41Y6vWx6qjidmwsaOE6tSBtlsEq6A=;
        b=PcOpK9azISxtDIMoSR8lrqsGa2jzKe5DpkkVwC2lvPLouHJ+vxS0aioyTJZIJTIalp
         l2w1dyY3icZy5F2BbXRiOSOF6JKLNx6ZDSl4jPxhtjlbkeUmAGR5NLhNY/jl0Yj/UyKx
         Ky/L1DecjxO0eL/TXC88bCzSUQPTJnVc0yxiluRZyQ6euvebM9bQTAM+Pi2ngMPQSNvu
         /qWm8mUzjhDcr5Dbeapg9eZmk+eoR06cg69/g4BBxK6tvxx1NASQpRZHlPkLQxPniMJm
         RMDQslYkVwE9UPxpgtmv+vZEoFMyZdYlMcn1sN68WeheHf4ybL5NvgLvkJlAvtuNrobN
         Oo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J9HskZ77OUFICI41Y6vWx6qjidmwsaOE6tSBtlsEq6A=;
        b=Qyan3bCSaQLrxpLug8ybjXRcd14sXBqjX8fb18wbxfoBfnuuGMphsJMPnFFiFWmZaX
         EAVxZoLE+7MMu+qPZovpyZ82+XkHw4q0tmfON/vFHGhpgzv9Jqj8mc8trouZVlkNq6w0
         O7nrKMrcJbX0Di4rD99BX2dFKrJqpgTBUBhaDPElZuXJlZKHnHKxhxRqgX3avIFP9IQd
         rQyK8ZffgU+x9r2xDggZtDSjfDrqIQsoHA2xphy3wU7vYwK7H5F/K63Bnpf4cYTQMSxd
         vc/5z3tPsnVxneiPL8mzMCHJHK/xwvUr0/HC7gQy4iL+Fk4ReZoOGll0Zhggwj9iBiUB
         GfCQ==
X-Gm-Message-State: APjAAAVa1NpISwed0PwkgkQHkYBhAtNVb70vywSxl6bWCAeOFie/7YcN
        uA783vXJYDOfB5YdhdQqjIlmdnCljLCLQVphD/0g0w==
X-Google-Smtp-Source: APXvYqxJI9YBy3Tx4TeP2k8b5JTYfjwF/BZZOjH1sXAgR2zDWSwPhEvf3n0YHoxi6RUqjKeGDYELgoSp30Xy4R9fLnYRpQ==
X-Received: by 2002:a62:b401:: with SMTP id h1mr3868938pfn.61.1551916781465;
 Wed, 06 Mar 2019 15:59:41 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:52 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
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
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
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
2.21.0.352.gf09ad66450-goog

