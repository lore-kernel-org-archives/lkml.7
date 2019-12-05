Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CEAC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE032464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/EVziDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfLEAK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35376 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfLEAKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so678092pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yE3ZHkR69UGcsqSedpJxhASD5SeB0FinXe1byG56UQ=;
        b=f/EVziDY7KK0UVtP07zeQE8P/OZC24lNIxT+R0yrkPhKCRQlrqlzCOrH5fi8fvczJ5
         bhXqfRmivbfuDr2Tu6VTuKi28nf92jc1ge/UxVZlXwVOvxwsjHB0e4vv9oMBJYuLmvcB
         d+qDYPPdtKxm9l1gNlaJYeQGZJZ06L4X45ZUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yE3ZHkR69UGcsqSedpJxhASD5SeB0FinXe1byG56UQ=;
        b=DUVU5NyYgHhDB49h166m3yXKqn1iXvOlPXn+Ik6o0h3dQnPX1xNpFCmX7+Kmb4vJ4E
         5M5iodUFVRf+dRKmyg0eWOh9kuN27RDeBCkkFuPOu6jBldfP3a+g7c5Z0tm+JyM5SfRs
         uUjHRN9a+/oq7G7ih/bPRD9B1SqDm4mBh7R50yTIG4CKZRrXUmjUJTGt5DILBxyZGhBU
         d4lKEkRvyGh9KGgOAGX+DdxbiAtkXNmWs7acrblJL579d4OaSPBt8uMtTqMjIuJKEAQ5
         lWSGtm3JNDPscmodxTp98vtRXOQzOH8BmUwKltVFHVQ3x5NQB4/X5Qw8FDve59NTzGwJ
         ANeA==
X-Gm-Message-State: APjAAAV9RsZx92p5xG2mVcnkUFOO1Ih/EBHSvYRI3f/2OQ2wXFjpgcZa
        jbY8TO16To5RseOjxZIHt/WSbA==
X-Google-Smtp-Source: APXvYqwCkYksA3H9gQM8Dd/UpM0c4sw+LmMk/E0hmNMYq/n4Q5BnskCCI0QZYAt9KoQF8+EThAaDog==
X-Received: by 2002:a63:3f4f:: with SMTP id m76mr6186602pga.353.1575504619867;
        Wed, 04 Dec 2019 16:10:19 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:19 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v10 06/11] x86/CPU: Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:43 -0800
Message-Id: <20191205000957.112719-7-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
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
index 0340aad3f2fc..77fa291a60bb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -742,11 +742,13 @@ static inline void sync_core(void)
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
2.24.0.393.g34dc348eaf-goog

