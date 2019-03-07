Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD31C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C720835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsNP+QJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCGLyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:54:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCGLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lZT7U8jOS2QYfV7CTlzn5rebslOn0+IVfvsGTTosaSs=; b=XsNP+QJ4EAwTkxsjpeWcBDoCuh
        /9XNhc8XMkI3QTrsLpxmeLB5b6Y65FsZMHHkJiBU2TWjbR+gMtxKOCDsAN/P0Kg8O/NJZfO9ahjzY
        Z65Xc0LN3ist0IbiYSKZNqZNaA2OpsrKxGr1DN5wymVJL29jpWvGzG4eP2TCUZyUep/NLUEkeJehk
        ypoMumAq8yDU9mTcXzwRytS+6S7NavfRreDiwXCZqibH28aVaCOw/QTopqYuAfAjc50pc4k4ju9Wx
        NBHl8iTLk4vsJub+kXeUibhHpLt526acHxb2XoUnSM7sN2BKO7zQ4W6+FpFzMnIT7I4xttM2ILyqp
        RNxyQULQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZm-0005PS-LL; Thu, 07 Mar 2019 11:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A7A6220297BD4; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.797068197@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 08/20] x86/uaccess: Introduce user_access_{save,restore}()
References: <20190307114511.870090179@infradead.org>
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


