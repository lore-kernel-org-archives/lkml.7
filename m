Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35ED20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tC6reX0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGNti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:49:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52018 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OWo6zcuM4QbSJs8addp2GaUi84GhdXtb7fYYcdx0j/Y=; b=tC6reX0R0sKhewK0cnJ9q2TdH
        ZL7tr4WT5MZGOL6qDFRe5ZNFhIPd0+WajCbDJK4v9PEeLTm0sVho41NAu6rBS67yLyp1P6lYfeaML
        VcVygajox1AT/Fd0NMr4LX6CUs4BCSR4umd6iKbMbkiN3Ua9frMKE/ODXMH8fpJNZr05/P0OVH4AF
        /hq4QXhBfwxsECu2Emg+IZ6+rCMHJ/Pk3VDMsZ9IQAWIkMzZC55Yw/Rb9hFVTXXDBqe2LkBZoRVw0
        WXwdiAcV0YA7v9dfS3tEbVwfyr1iFY9U8X5poyJrHC4pek8EFkQl02IV0H5++IvP/ejRy5ODKj00n
        pEgo4iyGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1tOn-00062J-U3; Thu, 07 Mar 2019 13:49:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56164202A2A1F; Thu,  7 Mar 2019 14:49:24 +0100 (CET)
Date:   Thu, 7 Mar 2019 14:49:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190307134924.GF32477@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
 <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <20190306171451.GZ32534@hirez.programming.kicks-ass.net>
 <20190306173715.GA32534@hirez.programming.kicks-ass.net>
 <CAHk-=wiDfi_=hny1hDCrxaEUUcgvykaWXt4f1qn+pt1RD1OFLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDfi_=hny1hDCrxaEUUcgvykaWXt4f1qn+pt1RD1OFLQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:59:11AM -0800, Linus Torvalds wrote:
> Maybe we could just get rid of that oddity, and just make __ASM_CLAC
> be a string to begin with.

Seems to work.. I'll add it to the pile.

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
 
