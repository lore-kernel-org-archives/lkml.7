Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAA8204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nnj6zwNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfK0TTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:19:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44165 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0TTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:19:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so10213379plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oBrPJ9sYwDSW4uj7Uc4h3NOiqrxzVdYSDRLTKeRx8Eg=;
        b=Nnj6zwNiP1jBcxqwMJNmRsPBkVa7voDaE/gzEtXMxDXNX2dbQd2U4+VRuT4aeLAPn/
         lz29M7KcV2j2wutA8IbIa94L2myqXeIsTfYgOyT55FzSf/IR+QJVw2Oip8M/b9hkhjJJ
         zkp8xRrPJ+bQhYflquHOjRJsWZMiF/nKorceQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oBrPJ9sYwDSW4uj7Uc4h3NOiqrxzVdYSDRLTKeRx8Eg=;
        b=D7Uo6j3yT8YentsfXL+s/zfCUfTSAc+YfOVg+0BzRmyLmitEQnaJo1mlXrDV2mwa6/
         NwQmiQO5phB7e9N4+Q0Ldf1E2F8Go+HSVZejwuJL1b3Gw2SRX4+9IBh0HRNO+3j65Wjv
         bvCUywNXxn5aD0Vm6AvldsY2R1pwN6mQ3mjwlHX4tPjpW/t32s/P2DJDB0szZGPVFggF
         xCboVez+KdRYvMHdl6kVLSan0UllZvblL48kyuhjbMHqVtfaGMmLrrSZmFg2Glr+XESy
         KG96rnnLpoi7q3j9OEvCcU/PJOHolOGROmOyjH/iR5cr3gzx2bCFE/C86akPa0iOHiUP
         KE2g==
X-Gm-Message-State: APjAAAWFTDWJl7q18n+KMVsWuwlSHU9psaHw6IAJq9KgjwjxwkvfVgpt
        7FEK/FNEHMYeJhEGIDGGSyh6uZDE/54=
X-Google-Smtp-Source: APXvYqwItIpvymu0/9xYl4B3yrMFiB2Z89KzRlsNhr+wCp19VWp41y6UEcZo1jxqWtESf/D+duG3Ow==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr8092360pjb.19.1574882362151;
        Wed, 27 Nov 2019 11:19:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w5sm17977385pfd.31.2019.11.27.11.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:19:21 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:19:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm/bugs: Avoid ifdefs for DOUBLE_FAULT
Message-ID: <201911271118.FCC2D04F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKDTM test visibility shouldn't change, so remove the ifdefs on
DOUBLE_FAULT and make sure test failure doesn't crash the system.

Link: https://lore.kernel.org/lkml/20191127184837.GA35982@gmail.com
Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
applies on top of tip/x86/urgent
---
 drivers/misc/lkdtm/bugs.c  | 8 +++++---
 drivers/misc/lkdtm/core.c  | 4 +---
 drivers/misc/lkdtm/lkdtm.h | 2 --
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index a4fdad04809a..22f5293414cc 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -342,9 +342,9 @@ void lkdtm_UNSET_SMEP(void)
 #endif
 }
 
-#ifdef CONFIG_X86_32
 void lkdtm_DOUBLE_FAULT(void)
 {
+#ifdef CONFIG_X86_32
 	/*
 	 * Trigger #DF by setting the stack limit to zero.  This clobbers
 	 * a GDT TLS slot, which is okay because the current task will die
@@ -373,6 +373,8 @@ void lkdtm_DOUBLE_FAULT(void)
 	asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
 		      "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
 
-	panic("tried to double fault but didn't die\n");
-}
+	pr_err("FAIL: tried to double fault but didn't die!\n");
+#else
+	pr_err("FAIL: this test is only available on 32-bit x86.\n");
 #endif
+}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index ee0d6e721441..7082ef8a2b99 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -116,6 +116,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
 	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
 	CRASHTYPE(UNSET_SMEP),
+	CRASHTYPE(DOUBLE_FAULT),
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
 	CRASHTYPE(OVERWRITE_ALLOCATION),
 	CRASHTYPE(WRITE_AFTER_FREE),
@@ -171,9 +172,6 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_KERNEL_DS),
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
-#ifdef CONFIG_X86_32
-	CRASHTYPE(DOUBLE_FAULT),
-#endif
 };
 
 
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c56d23e37643..f4952efd6785 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -28,9 +28,7 @@ void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
-#ifdef CONFIG_X86_32
 void lkdtm_DOUBLE_FAULT(void);
-#endif
 
 /* lkdtm_heap.c */
 void __init lkdtm_heap_init(void);
-- 
2.17.1


-- 
Kees Cook
