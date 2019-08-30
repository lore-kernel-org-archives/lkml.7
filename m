Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF472343D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="boJouUw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfH3XPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:15:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44846 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfH3XPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:15:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id a21so9695880edt.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6P0N9+OtzBQ/+pWxgapquiOAPv3FZmW3I9CzZ8KtwA0=;
        b=boJouUw78n75bFxQRuRR8zbkuteRj6NjF5ukCY3vk1vAP3W5UUvRAzwPJ7M4qRF0b1
         VhaNF6RFkQm01KXbbHye45S5UxAtRndhVKlvQI6um+I2GuQ4yAYDuGEytSKxDbBA9bPf
         r8Ack5+2qynx6L1DM68lp3PCdFRZ7Nv04qnQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6P0N9+OtzBQ/+pWxgapquiOAPv3FZmW3I9CzZ8KtwA0=;
        b=c+Yr4lXks06oRozEv89kMql98kL3Jonj5M6xssaOsNlYOiaSq13CP/xXZr8sEaT9h5
         Q7G4mVyL7ovhPRxKqo2lmrhD54xbnAgb8tZK4c//OZ+TmevPA/hXFLPpNZdZTnxIF+5w
         A2Hf6YOI6lmdcTQ2PcbMhZcgLVSWrpxFDbRPY3S7IVI1K3hBtsWz+ta4VczDc7HcB3RU
         DJ2z9q+7e7YCyOClOPcta80bhj/L6DwIAFpudaniF9U3hZTdFtU+AOh7YhnkNOcnprK7
         qZCQg8UT2oDJlEhRfHhCB3hVUdfYAHlBFtbc1KULDWfqwpph3VVoixOII2eF7ZWii7Au
         ht3Q==
X-Gm-Message-State: APjAAAX6WGM+L9DVtLAyuPUGs5hWOXoevFbNd6EdpQwAtlPofQqU5Slu
        0k/5CMJHWmwUZMsfML+dP5bPbg==
X-Google-Smtp-Source: APXvYqxDn9oW7XVGPRMon5L9MXdlUpj2LtGtNsSOwcfNtJ1/yjaDHjJNDf6/aG6ezAwBa1tFvn/hlg==
X-Received: by 2002:a50:ba81:: with SMTP id x1mr17958640ede.257.1567206938426;
        Fri, 30 Aug 2019 16:15:38 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id s4sm875457ejx.33.2019.08.30.16.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:15:37 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 5/6] x86: alternative.h: use asm_inline for all alternative variants
Date:   Sat, 31 Aug 2019 01:15:26 +0200
Message-Id: <20190830231527.22304-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most, if not all, uses of the alternative* family just provide one or
two instructions in .text, but the string literal can be quite large,
causing gcc to overestimate the size of the generated code. That in
turn affects its decisions about inlining of the function containing
the alternative() asm statement.

gcc >= 9.1 allows one to overrule the estimated size by using "asm
inline" instead of just "asm". So replace asm by the helper
asm_inline, which for older gccs just expands to asm.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/alternative.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 094fbc9c0b1c..13adca37c99a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -201,10 +201,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, feature)			\
-	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
-	asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
 
 /*
  * Alternative inline assembly with input.
@@ -218,7 +218,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, feature, input...)	\
-	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature)	\
 		: : "i" (0), ## input)
 
 /*
@@ -231,18 +231,18 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_input_2(oldinstr, newinstr1, feature1, newinstr2,	     \
 			   feature2, input...)				     \
-	asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,	     \
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,     \
 		newinstr2, feature2)					     \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, feature, output, input...)	\
-	asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
+	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, feature)	\
 		: output : "i" (0), ## input)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
-	asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
+	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -253,7 +253,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feature2,   \
 			   output, input...)				      \
-	asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
+	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-- 
2.20.1

