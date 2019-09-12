Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F9FC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE562084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Kc2wbMDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfILWUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:20:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46310 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfILWTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id i8so25280099edn.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwxfKZDbkwsssc8hJEZ7254If0oTH7t3AgJp5tFLhpQ=;
        b=Kc2wbMDaSPuvNCOUWiPawZ2XjD9wncgKxq8m3BULeF3PmtrOCOiHmeZRTNRG+J3FXt
         IGupAYENCPO4vXO4s3p8GRMT8UgfR/8Rsj3nEuE+xZnYfBURC7SjMTbPUu7/WS9+IuP9
         Sljo8fS94RMRPfk0oeY+cpPKyoUFgcnq1B+3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwxfKZDbkwsssc8hJEZ7254If0oTH7t3AgJp5tFLhpQ=;
        b=VIde+IVNV2dxhEWKts114LePJRBR8M0Ar7ec5MIgVHXHH5oJjLAxpgmHnZsNTgoYP/
         Y14+vW7VREzmAvbMuMSteOiXd5PKUyHQfIxTsVwO1++HL2fTDHDTFwOQk+NgQmRbklKG
         +SZrDCXhNTkEVKFkcGmPyAavqNtCQSHUmpAbXogBWYixd11doohz4mdInEvlCzuZzpp7
         aL9Y6J3d8O/sWKsdhFdgW9h894CSR5Quags7bMJ7TI6L9RyM6lIPS0N+0y528+zG0n8Z
         DKWE3c6LtmBua1koTKIDuf8/BQYPzTM6iCfPW9MrtLdMIGZey0A0T6YlWYl7kr4+vooe
         S15A==
X-Gm-Message-State: APjAAAUvpcpME916HZ+6rFS/TEAdtYtKXYfz51dVuJY8f91iH+9iMB7j
        YAHuwIOGs41URqqRRa4wuMgB4V172B0gU24N
X-Google-Smtp-Source: APXvYqzd56ZujyFylBsQlE/MU6x/6GnG2yrLrsDqQpumPyFHEgAhKQjfl6DYMAdNq4Qv2Ra1WvSG1Q==
X-Received: by 2002:a50:9eee:: with SMTP id a101mr22124717edf.128.1568326788028;
        Thu, 12 Sep 2019 15:19:48 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id 36sm4305228edz.92.2019.09.12.15.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:47 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 5/6] x86: alternative.h: use asm_inline for all alternative variants
Date:   Fri, 13 Sep 2019 00:19:26 +0200
Message-Id: <20190912221927.18641-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912221927.18641-1-linux@rasmusvillemoes.dk>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
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

New enough versions of gcc allow one to overrule the estimated size by
using "asm inline" instead of just "asm". So replace asm by the helper
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

