Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE810C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03F220854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aBH+kMil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCRPwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:52:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfCRPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lZT7U8jOS2QYfV7CTlzn5rebslOn0+IVfvsGTTosaSs=; b=aBH+kMil9l9u1OWEkXE6R+F3qq
        KrTRcIScyx1YzH12eaQk6IjYfNA6x6xT7GlIPt+eYaElbrWtOSmxSlD5HUxqfKw3cRINDGG5vO616
        uUKIdogzHm4brE7cZQFn0TYnsKLkUDIG0bFCY5UNftbkwmIaMWeonohMeuw+acFR7TLqGd+OvzOpN
        0K98iusjGhHS1k9pA7h78itX0VJH6ISM4z3la0bm6QOrbvzGne/WnYnppWQMstPJRKvKuI4hcOKKv
        O2zn2OfJLqZM0NzRq8fiog2yVBtneE9S1cbrSRV33KM4Bn2Z4CujQhKASnH+ls1/1czvGe5gTEQpR
        7wgpbgwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ9-0006mi-5k; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B6BF125E45D75; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155140.910372928@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 11/25] x86/uaccess: Introduce user_access_{save,restore}()
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce common helpers for when we need to safely suspend a
uaccess section; for instance to generate a {KA,UB}SAN report.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/smap.h    |   20 ++++++++++++++++++++
 arch/x86/include/asm/uaccess.h |    3 +++
 include/linux/uaccess.h        |    2 ++
 3 files changed, 25 insertions(+)

--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -58,6 +58,23 @@ static __always_inline void stac(void)
 	alternative("", __stringify(__ASM_STAC), X86_FEATURE_SMAP);
 }
 
+static __always_inline unsigned long smap_save(void)
+{
+	unsigned long flags;
+
+	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __stringify(__ASM_CLAC),
+				  X86_FEATURE_SMAP)
+		      : "=rm" (flags) : : "memory", "cc");
+
+	return flags;
+}
+
+static __always_inline void smap_restore(unsigned long flags)
+{
+	asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
+		      : : "g" (flags) : "memory", "cc");
+}
+
 /* These macros can be used in asm() statements */
 #define ASM_CLAC \
 	ALTERNATIVE("", __stringify(__ASM_CLAC), X86_FEATURE_SMAP)
@@ -69,6 +86,9 @@ static __always_inline void stac(void)
 static inline void clac(void) { }
 static inline void stac(void) { }
 
+static inline unsigned long smap_save(void) { return 0; }
+static inline void smap_restore(unsigned long flags) { }
+
 #define ASM_CLAC
 #define ASM_STAC
 
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -716,6 +716,9 @@ static __must_check __always_inline bool
 #define user_access_begin(a,b)	user_access_begin(a,b)
 #define user_access_end()	__uaccess_end()
 
+#define user_access_save()	smap_save()
+#define user_access_restore(x)	smap_restore(x)
+
 #define unsafe_put_user(x, ptr, label)	\
 	__put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
 
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -268,6 +268,8 @@ extern long strncpy_from_unsafe(char *ds
 #define user_access_end() do { } while (0)
 #define unsafe_get_user(x, ptr, err) do { if (unlikely(__get_user(x, ptr))) goto err; } while (0)
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
+static inline unsigned long user_access_save(void) { return 0UL; }
+static void user_access_restore(unsigned long flags) { }
 #endif
 
 #ifdef CONFIG_HARDENED_USERCOPY


