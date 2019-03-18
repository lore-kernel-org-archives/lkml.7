Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA20C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C34F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Llll9qEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfCRPyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfCRPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t3kYxm8giI53DptNpjxSYhnDp41d76jBvEiQ982AEE0=; b=Llll9qExMiyNMo68bvH8eK53E9
        3SyJ4pszePeJBPOWX6DvgXNz+5gLddRCvZlZiOmm1qUZq4GMC5u+Okvs3cD4RntcqTnglE29Uds71
        9hg6Gc1dUjqQA9SOaIfNS3RMnEFIssQVsVYcZhuJjhLVHRwhYAuixiFUMLYupcQl/f6bK/Mv76VjV
        A4l59f68TP2r+tFMkYXqQj+CA8nbZzqrYBlB/sOMLaimrWse6KYtmVHwIKMec94BPBQVgZzTmoKa7
        Y6BVmsSBCuC0lQG5BoUJmInUjzsoPav3IUJ651p+uuV95Le0IXc+prfL1jSnPiGwBZ1oEik/Xf6dd
        nHTQEBIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ9-0006mj-5c; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC25925E45D76; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155141.005287695@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 12/25] x86/smap: Ditch __stringify()
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus noticed all users of __ASM_STAC/__ASM_CLAC are with
__stringify(). Just make them a string.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/smap.h |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -13,13 +13,12 @@
 #ifndef _ASM_X86_SMAP_H
 #define _ASM_X86_SMAP_H
 
-#include <linux/stringify.h>
 #include <asm/nops.h>
 #include <asm/cpufeatures.h>
 
 /* "Raw" instruction opcodes */
-#define __ASM_CLAC	.byte 0x0f,0x01,0xca
-#define __ASM_STAC	.byte 0x0f,0x01,0xcb
+#define __ASM_CLAC	".byte 0x0f,0x01,0xca"
+#define __ASM_STAC	".byte 0x0f,0x01,0xcb"
 
 #ifdef __ASSEMBLY__
 
@@ -28,10 +27,10 @@
 #ifdef CONFIG_X86_SMAP
 
 #define ASM_CLAC \
-	ALTERNATIVE "", __stringify(__ASM_CLAC), X86_FEATURE_SMAP
+	ALTERNATIVE "", __ASM_CLAC, X86_FEATURE_SMAP
 
 #define ASM_STAC \
-	ALTERNATIVE "", __stringify(__ASM_STAC), X86_FEATURE_SMAP
+	ALTERNATIVE "", __ASM_STAC, X86_FEATURE_SMAP
 
 #else /* CONFIG_X86_SMAP */
 
@@ -49,20 +48,20 @@
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative("", __stringify(__ASM_CLAC), X86_FEATURE_SMAP);
+	alternative("", __ASM_CLAC, X86_FEATURE_SMAP);
 }
 
 static __always_inline void stac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative("", __stringify(__ASM_STAC), X86_FEATURE_SMAP);
+	alternative("", __ASM_STAC, X86_FEATURE_SMAP);
 }
 
 static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
 
-	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __stringify(__ASM_CLAC),
+	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
 				  X86_FEATURE_SMAP)
 		      : "=rm" (flags) : : "memory", "cc");
 
@@ -77,9 +76,9 @@ static __always_inline void smap_restore
 
 /* These macros can be used in asm() statements */
 #define ASM_CLAC \
-	ALTERNATIVE("", __stringify(__ASM_CLAC), X86_FEATURE_SMAP)
+	ALTERNATIVE("", __ASM_CLAC, X86_FEATURE_SMAP)
 #define ASM_STAC \
-	ALTERNATIVE("", __stringify(__ASM_STAC), X86_FEATURE_SMAP)
+	ALTERNATIVE("", __ASM_STAC, X86_FEATURE_SMAP)
 
 #else /* CONFIG_X86_SMAP */
 


