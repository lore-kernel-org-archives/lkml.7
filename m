Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18715C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CA7217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m0iQTXUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfG3TNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34585 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbfG3TNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so24330517pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qa0vdqU/e4QPHFVnoNOrEozPMumAGtkoZQ9IP0jYnkg=;
        b=m0iQTXUNy9Ivxk8S8rx6UuqUrCNk/lmb9ABT6tX720KuMWsD28POJqIHBW6/ecVDNQ
         1wbWq2OFtsCV/gCMaCWhi/N9ivwFCLXmf8NoCB80kLVtvh5oGNjC8TdkekyoWfngXYpv
         g4yOAr38UwABJuJh4u7l9MRi4cavnGZbRi9Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qa0vdqU/e4QPHFVnoNOrEozPMumAGtkoZQ9IP0jYnkg=;
        b=AODDATy8YZtpA1twKk7mjCsZ8N01GF3Jwct1ihRKgkBZBjIYRJHaaE/G30Uv1GmzlV
         3pzHe6qYiC+fjV0vRoLcXgaZdWtUKz2jbDfrnywrbYzmJUnqkSE/xbdz7EQ8a3tXHqYP
         hnJ2lmK2j+klXG6kFxFaPz1M3Al9wYOsl5obGoydhIO4a8qiWdgJzSjTXCEicUJbr+89
         Y8SLrzHcU36ogepllx8YS5q7ZSgNJacZSLIinG4N0ZXXTz8Z7NUgEQhqA/J5PHXvm/fU
         QuNf3hbEqkN5L40Rz69Kdid8QdL39PUOLJ00cgpKd0yKqdq9O/AFPkIbXGYT210G1as6
         Ldvg==
X-Gm-Message-State: APjAAAWEGAaiBVNDRmVnwELgpjCaEk+nXYZ48/VKS6PjmqH8iUmKLKXD
        XB7GuykKgOX4CF8i9Wlwm1Vb1Q==
X-Google-Smtp-Source: APXvYqw4FhQAyLlzTXXeXnWi4AdlBXSr5qODFDIUZbZ8fdBVPq/Zyh+2sg3WQmjXFcNGWYaH8U26QA==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr56057575pjq.64.1564513999646;
        Tue, 30 Jul 2019 12:13:19 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:19 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 06/11] x86/CPU: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:50 -0700
Message-Id: <20190730191303.206365-7-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6e0a3b43d027..bf333d62889e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -713,11 +713,13 @@ static inline void sync_core(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"leaq 1f(%%rip), %q0\n\t"
+		"pushq %q0\n\t"
 		"iretq\n\t"
 		UNWIND_HINT_RESTORE
 		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT
+		: : "cc", "memory");
 #endif
 }
 
-- 
2.22.0.770.g0f2c4a37fd-goog

