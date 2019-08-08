Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBDC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BC82189F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQ32ZYFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbfHHAHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:47 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39641 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389404AbfHHAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:43 -0400
Received: by mail-qk1-f201.google.com with SMTP id x1so80728083qkn.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=AQ32ZYFy04wA4mb2XkzJMu41uBwdTPJVCQkZLoSqoG5BPESh7PtahcJElB42fN7yCa
         RgpAdVhcQ5fuL4/xbllTjDfI2lyqus7qV8tRpcqdDJ/VX1SpE4XMZ3HvF0pfgCWIcmbA
         Zz9a2qpUoHBQ5fw1br+vqmDeXDCgSck943n71lbq0K8fl99KDPL9Cr+apC6baNZBDpqB
         yetG9rfVr7XgiWV+oEMuvXWmxki7WHMWAVAgsDWQ3kUNYceMtvrIEGX+u90sxOg52+xU
         WwDTm3LZ/jev4cFV6SJG2fghnPLj1QbrnL9bCZ9OKuqjQneM4UxIH4SbmaYnC+fTKyUe
         xoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=ZQKsljA2DJFdVeJmw6sJ0t3P2e97noIGvEcuWBk6bff2vnshipDmHOuw3Zt0AfSfgJ
         cPoN4aP3in/ZybhAhc/ALw0YLcnZ6BdBufSHlg99JpzlgcnOkhH86KPrbfQL1leVoh0i
         Uvy2WH6h16o18UO3XVDrY4hT7nwwnRFAt4HE6UVndBSW4wDnNlHlX1NskCa+OjQIKhgO
         73GPm2OfNtO9V0GXIEdA17s10iYF0c1CwGAjddIUzuiWXwjTVxvYEODqYrmWkw+BJRCA
         C5lNxL+i2ZEyhrluE9MqcRVK5KmBMwFv3paPb5FT3/YfEfIrsWgHIw4Kot3zrajI3A2F
         blfQ==
X-Gm-Message-State: APjAAAU6uQZPQooSvGLn/+Ti75nIgDsxsxiMCa160WKRGW/YwoPpyc1g
        KZqdEmWJsBRKiSv7WoK5/XYt4dYtPA4F6lQE8s7iOA==
X-Google-Smtp-Source: APXvYqwbxMXMHnAWnMCnOqh54UKVOkglSwlrJqk2yQseIK/mHSAACIPxF2yMxL4MhNvEpmU0x5PUPo+FVwhaY2V8uK4ABw==
X-Received: by 2002:a0c:eec2:: with SMTP id h2mr10594442qvs.189.1565222862448;
 Wed, 07 Aug 2019 17:07:42 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:59 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 07/29] Copy secure_boot flag in boot params across kexec reboot
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
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 5ebcd02cbca7..d2f4e706a428 100644
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
2.22.0.770.g0f2c4a37fd-goog

