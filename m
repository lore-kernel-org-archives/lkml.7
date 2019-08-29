Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C42C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDED2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YEkpOy3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfH2IeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:34:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43750 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfH2Ic4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id q27so1807511lfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6P0N9+OtzBQ/+pWxgapquiOAPv3FZmW3I9CzZ8KtwA0=;
        b=YEkpOy3y52sYFpekXF5SsnslyuHmOvVTH8W30KxlWAeLUPrCxTbcMPCtmShJaWANVF
         UXHh8crLiDMyDxwPz00RvTLUQN3xxGftGCvtBOQ8uc6+y7Ak4vTynsLyUtaK0djb0e2M
         KRJ8469XXV8VOgk/5naodAqkWR2fZuxzY28yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6P0N9+OtzBQ/+pWxgapquiOAPv3FZmW3I9CzZ8KtwA0=;
        b=MVLAnrHj3W7iwgJFe5okR49Ftox9g9pJErJr5LBCDKrTUYyWKAwRAm6fdJIIMA1bKd
         MO2SkL2FdHgttx1CTDfUpLBafRokvVHDK37gWXCfRDWLlWtxlyqMlLKUjS+DLNMaMPn1
         GXeg1D8a2AnGh09ftpCfzn9mVHhWbjdJ93Cm4cXyh5xenACAcQx3Fu6Uvg2PvezauYcj
         0/peC5dNYaz5kmoLd/3ubSmUpzyjhlDYJEGJYql4INLY7ByA3lC1On6FpC0Xb4txPva/
         KgRey5t6W0pNBnLU4lOkujUEIu6ZDcD3nyhLsis43Rj0seGoitZrwxBgbJWG+BMXPrZH
         SK2g==
X-Gm-Message-State: APjAAAXwMx8+5LuJtEwMCb5VqKBPsSVyrnLnWt7m+a7etwK7gEKT8Xye
        EEvzREqo4PvZ5zlhjlZOV1AgRg==
X-Google-Smtp-Source: APXvYqyf1Lzadr9tMyJSzoWA+LFKwx5oiJj5n4TOy6bd0AYG5wf7UjgXqtCn9rgmhc/yaRiu8MruZw==
X-Received: by 2002:a19:6a12:: with SMTP id u18mr5260201lfu.133.1567067573970;
        Thu, 29 Aug 2019 01:32:53 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o20sm248087ljg.31.2019.08.29.01.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 01:32:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 4/5] x86: alternative.h: use asm_inline for all alternative variants
Date:   Thu, 29 Aug 2019 10:32:32 +0200
Message-Id: <20190829083233.24162-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
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

