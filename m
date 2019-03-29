Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F56C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E83A218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8Ossw+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfC2VrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:47:11 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:36023 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbfC2VrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:47:10 -0400
Received: by mail-it1-f202.google.com with SMTP id l202so3500025ita.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BIUYSdViMIn+To2mUC3qZ7zEN+7GQ3ySY+V/Ekd7gP4=;
        b=Q8Ossw+hkgnOCqCCmDlkaB7INGKnnX/7XqFXcKnoxXj/6IR9rdXMn1eAfOnQAfHSCT
         m5BeHO8EWmf2c6BIYwp6PdlKGhI6ShBMM6cXt+rBdSAhe7/Rh5YiIksh4CtpRzijg1qo
         tV6ArUbKs3AB7BWgOtRAbgWGvaXaX5mGVVyuzxwTdGBQk3qeITV8HlpazvQFhV/dln2P
         8quJN+t0pFFsPlRVZOX4CJZAdOa/PHbJ0oYA9cjDcH9U/HmXwz1MkjOANht8NAs/pPHK
         2+8wong01mhW4uGhFW4XZqOzDm+FQoAcnSnPsiB1MG7atw/npWT0MAUqWkqkZR7Dxieb
         MZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BIUYSdViMIn+To2mUC3qZ7zEN+7GQ3ySY+V/Ekd7gP4=;
        b=MrT3Z+xUo8gZASK++FN3Di03DurgJ1lkQfYU+rQyyslt1sR6FkUozuMTeITmiDcego
         ED3+twVkToJgzd1xeAZ+C9yRBPXEEyU40709RxPvgtSPrbjW4CRbqvnWdPFzmOqK1ILj
         fKfvhXL7yYu7cpkYZ7YpSWkmWeitGGDzukfvKG9Y5dsnafjn0RWxkRgQ4OgEY1cm+Ln3
         4GA/K15FZsErKKS4kcwzLvYeh+ggfq09hdxLzLQfmIftYeapFNSbFQZP6p1Fgthy5kgD
         uUtgLcsO/bOVs+Bg2yMe5CNQN//qvKHDxXvuoBg7sUxJnX1+8K3FOEAZ0zZx3BVuLwCc
         YkFA==
X-Gm-Message-State: APjAAAWywy294R5F2GAn1ztx7lYfX0WZEnnezDrLrctdNYKDEPVvOoqB
        88gWde94c4HmHjtbPHZIWq19Jelvtw==
X-Google-Smtp-Source: APXvYqwowR9WlAl7Fp/7MzuCpLf7ifuupDP7KotIgItUt3ZXdaHLyxYhEOMqnBWfypAOnOrYsYJleUSfsA==
X-Received: by 2002:a24:9fc4:: with SMTP id c187mr2332485ite.23.1553896029431;
 Fri, 29 Mar 2019 14:47:09 -0700 (PDT)
Date:   Fri, 29 Mar 2019 22:46:50 +0100
In-Reply-To: <20190329214652.258477-1-jannh@google.com>
Message-Id: <20190329214652.258477-2-jannh@google.com>
Mime-Version: 1.0
References: <20190329214652.258477-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 2/4] x86/microcode: Fix __user annotations around generic_load_microcode()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_load_microcode() deals with a pointer that can be either a kernel
pointer or a user pointer. Pass it around as a __user pointer so that it
can't be dereferenced accidentally while its address space is unknown.
Use explicit casts to convert between __user and __kernel to inform the
checker that these address space conversions are intentional.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..e8ef65c275c7 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -861,11 +861,13 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
-				int (*get_ucode_data)(void *, const void *, size_t))
+static enum ucode_state generic_load_microcode(int cpu,
+		const void __user *data, size_t size,
+		int (*get_ucode_data)(void *, const void __user *, size_t))
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	u8 *ucode_ptr = data, *new_mc = NULL, *mc = NULL;
+	const u8 __user *ucode_ptr = data;
+	u8 *new_mc = NULL, *mc = NULL;
 	int new_rev = uci->cpu_sig.rev;
 	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
@@ -945,9 +947,10 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	return ret;
 }
 
-static int get_ucode_fw(void *to, const void *from, size_t n)
+static int get_ucode_fw(void *to, const void __user *from, size_t n)
 {
-	memcpy(to, from, n);
+	/* cast paired with request_microcode_fw() */
+	memcpy(to, (const void __force *)from, n);
 	return 0;
 }
 
@@ -993,7 +996,8 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 		return UCODE_NFOUND;
 	}
 
-	ret = generic_load_microcode(cpu, (void *)firmware->data,
+	/* cast paired with get_ucode_fw() */
+	ret = generic_load_microcode(cpu, (void __force __user *)firmware->data,
 				     firmware->size, &get_ucode_fw);
 
 	release_firmware(firmware);
@@ -1001,7 +1005,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	return ret;
 }
 
-static int get_ucode_user(void *to, const void *from, size_t n)
+static int get_ucode_user(void *to, const void __user *from, size_t n)
 {
 	return copy_from_user(to, from, n);
 }
@@ -1012,7 +1016,7 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
 	if (is_blacklisted(cpu))
 		return UCODE_NFOUND;
 
-	return generic_load_microcode(cpu, (void *)buf, size, &get_ucode_user);
+	return generic_load_microcode(cpu, buf, size, &get_ucode_user);
 }
 
 static struct microcode_ops microcode_intel_ops = {
-- 
2.21.0.392.gf8f6787159e-goog

