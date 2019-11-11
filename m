Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F08C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F5021783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eYei6hSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKKVvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:51:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35440 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:51:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id d13so11658798pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ECx6JJXMqwV7KvtEiTX6TzUulxx4XUMPqXnurGMc2Uo=;
        b=eYei6hSfPQgfbmHeboNCtBfjP97+85fbdUNJXf/44FSu4gPmAYcOBOO/sz4J84On/E
         J1+rW4ZapAF6YmXkYSYHwZ0V5VtDQYN5/fNEE+4KjvOZbo3zhEBtnOwGXgvuCdoOe+6b
         w8b93XU9uaMxYUSry6u9XNk2hUIX8KKaiAGIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ECx6JJXMqwV7KvtEiTX6TzUulxx4XUMPqXnurGMc2Uo=;
        b=IY1zCPQV+1oFJ6cCxgQBZ8LNoLFYU49Nkv/i2bsov917+nUtHSRvEwA0pFsHA1IswS
         ciOvt0Ejr0Gxd5rQBnbuoxNleiGPbAF3+7eCSaMgVb1/5f3gVdGdpEqQxqRw7reG5Psq
         N9KFfMIjskWPphzSEYUBa4nBKFnm+mqWNkafyfqSb8A1FS/jSXYgYyU0Kw9Mc1DIg24v
         srJjefXHORNBRHy13htObTLTLX0NU/EIF6CtrTKFRXA6yqqjhmA1T+INGN/hLRRnoIPu
         +OKRspkkmJtCiCNYlu6EfHaug1XV6g3RtVOrch82e2uMUJ3ouL2YPy/IvqJxxgy/oH5+
         evZg==
X-Gm-Message-State: APjAAAUqC6DQ1jbdblHddUMpbTecknwa0u+mFdeHxMZNCAiL0sddtQwN
        HkrwAg84WESD33fK8QNqwkGm6A==
X-Google-Smtp-Source: APXvYqy/PNK2WSCaJZEy3orTnroww4btgtO2Tjwp8D4SyDixktNvzz7IxXFB/wVGAO3Co9kjmer1Pw==
X-Received: by 2002:a17:90a:9286:: with SMTP id n6mr1617135pjo.84.1573509078108;
        Mon, 11 Nov 2019 13:51:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12sm4586034pgl.23.2019.11.11.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:51:17 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:51:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/alternatives: Use C int3 selftest but disable KASAN
Message-ID: <201911111348.7A0A6C3AFD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using inline asm for the int3 selftest (which confuses the
Clang's ThinLTO pass), this restores the C function but disables KASAN
(and tracing for good measure) to keep the things simple and avoid
unexpected side-effects. This attempts to keep the fix from commit
ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
corruption") without using inline asm.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/alternative.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9d3a971ea364..efb5ef8a7885 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -625,23 +625,10 @@ extern struct paravirt_patch_site __start_parainstructions[],
  *
  * See entry_{32,64}.S for more details.
  */
-
-/*
- * We define the int3_magic() function in assembly to control the calling
- * convention such that we can 'call' it from assembly.
- */
-
-extern void int3_magic(unsigned int *ptr); /* defined in asm */
-
-asm (
-"	.pushsection	.init.text, \"ax\", @progbits\n"
-"	.type		int3_magic, @function\n"
-"int3_magic:\n"
-"	movl	$1, (%" _ASM_ARG1 ")\n"
-"	ret\n"
-"	.size		int3_magic, .-int3_magic\n"
-"	.popsection\n"
-);
+static void __init __no_sanitize_address notrace int3_magic(unsigned int *ptr)
+{
+	*ptr = 1;
+}
 
 extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
 
-- 
2.17.1


-- 
Kees Cook
