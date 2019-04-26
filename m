Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF38C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4F4208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYvgo9ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfD0GoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:44:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44687 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfD0Gnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id y12so2555220plk.11;
        Fri, 26 Apr 2019 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RIE66crRSFais2XMEreovT7cuc4aWzwk2c6XjFrsy1k=;
        b=pYvgo9ZCfUCHvRHlTxheTL9ZRQVp4fim5mJ1MwWcKR1lA8y1aUP/jaFmmW0gvaWJ7S
         zVzA0PQ2EURS5SWk/peFTu1A3/0LRw7DZYQoG4uzOziiwhPRGPxHOWrU2FLz8xJKPBlh
         /zuS4kFNlrBUqnzlR10WasNuwWxPh6kwUkYfWX2HNs3YXw+waJ/qMVcWCQyEr/PXxH6M
         ipIVs/0XiprUGYbGWdjj/stD10SwODP6rYxbEpQWhHBNTSo8/W1+lQ5k//iDxItfsPxn
         hO3NCZNloR7//+m6Eozd9KTmliFtML7SM01N4FLmt+HleGXZ2gYxUmzOYvSuD2G1W0Lp
         NyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RIE66crRSFais2XMEreovT7cuc4aWzwk2c6XjFrsy1k=;
        b=UIX7WqICoRsO+LiT42b/95RjkddWdaUlctGjIILVrGcJOBzh6zlezMYaHTPvAvaxtp
         D2Nh0ndy0YdnE8wYg0rinRpotEsbPiFBZkuFvmc9RbipOjXf+GgFnLI0Vl4PK71P5QOv
         VIiO7psV3Ol99yY3+TTQ2ldiTDY+BE36QG0Iu7uMM5YIn1Y/5cYuVFMnJRMeJcohK9zG
         +90ok/RTOtIFUf84w6TUjzTKwWyQmOoui7jzxWVZ/4HPtG7IVficrXUycniNrs2nm9uv
         HiI5NRtSx2C7ipQOsceKMXm7NKY4Fio/8dlG5doDG6mAu1RxQ4Dh0fv9Ivbb6c7Bohb4
         5qtQ==
X-Gm-Message-State: APjAAAWvzSJGD44R1VS3wEBPhi8AF8fjA1pob4rea55usRhvbclpe7qO
        m/bYzjXuuusI2l2yqHaRu50=
X-Google-Smtp-Source: APXvYqwLfbRywYDBLBkn2s5QjOy7Ake8UGyhjw6r9cFTnOHwE2KsORvL/Fy4JLKSQeWsUj9Okam5Jg==
X-Received: by 2002:a17:902:b68e:: with SMTP id c14mr52282678pls.49.1556347412993;
        Fri, 26 Apr 2019 23:43:32 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:32 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v6 20/24] x86/ftrace: Use vmalloc special flag
Date:   Fri, 26 Apr 2019 16:22:59 -0700
Message-Id: <20190426232303.28381-21-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
permissioned memory in vmalloc and remove places where memory was set NX
and RW before freeing which is no longer needed.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/ftrace.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 53ba1aa3a01f..0caf8122d680 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -678,12 +678,8 @@ static inline void *alloc_tramp(unsigned long size)
 {
 	return module_alloc(size);
 }
-static inline void tramp_free(void *tramp, int size)
+static inline void tramp_free(void *tramp)
 {
-	int npages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	set_memory_nx((unsigned long)tramp, npages);
-	set_memory_rw((unsigned long)tramp, npages);
 	module_memfree(tramp);
 }
 #else
@@ -692,7 +688,7 @@ static inline void *alloc_tramp(unsigned long size)
 {
 	return NULL;
 }
-static inline void tramp_free(void *tramp, int size) { }
+static inline void tramp_free(void *tramp) { }
 #endif
 
 /* Defined as markers to the end of the ftrace default trampolines */
@@ -808,6 +804,8 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
+	set_vm_flush_reset_perms(trampoline);
+
 	/*
 	 * Module allocation needs to be completed by making the page
 	 * executable. The page is still writable, which is a security hazard,
@@ -816,7 +814,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
-	tramp_free(trampoline, *tramp_size);
+	tramp_free(trampoline);
 	return 0;
 }
 
@@ -947,7 +945,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 		return;
 
-	tramp_free((void *)ops->trampoline, ops->trampoline_size);
+	tramp_free((void *)ops->trampoline);
 	ops->trampoline = 0;
 }
 
-- 
2.17.1

