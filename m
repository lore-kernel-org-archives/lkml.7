Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B26A218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLTIzaFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCPVKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:10:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46139 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:10:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id 33so13027283wrb.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ixFzQRlmJZhuKRpJEZjIs+FAc/Wa9mJ709KV36I6rxM=;
        b=lLTIzaFMxZLRyCX82mXJXu5j6PkM9n1rqtDxcKad488f+8//YIkGEdM+fJIbMq3RKw
         7O05uw2ZMN5Nf+eIkUymdl/VISlM1ycgb9r86kFBXKXgRJSaIuxsAq/HSsK80BEwbExn
         XLDVJf1bRxmkdYAaq8A6jiHnGQAr6HcDKvm0mVOT4LPLgwzy81NT+S6fhB7ZWUeGE+t5
         3InSpo3LN/AVY768hZkHOLoK90EgUQsPoaf20G/WnEeyG9zs5JO3rm8q5TyUZABydZPl
         QzLZvmc1PBRjn9ugwHdXMSOuhSDr7TpQCiJ1nwkNwgJ5d6l5ahpCi5uwhFMIcV8K2OeV
         tP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ixFzQRlmJZhuKRpJEZjIs+FAc/Wa9mJ709KV36I6rxM=;
        b=ickUjGPAg6ty1rYVBIDvbpni2hS94YUcS8T/62DmiCQwp6E8eNi7/Xymr8AiNvNxbj
         rq0TwohteitUr6lpxgz8f/5yn3BRJWdm5xfHCWD24coJlsajdCR+SIvNX1Wgd0wgyUff
         0PU8s3ELJjTFlS2P2FnL6MeIkjIgav99SoBqvalXi3qxe+cd8Nuq06sLJ0qo9qJLEibg
         ky0tPQK0R1vjjBGmrWfo5uwRAq0MrQGyogm2KRgSg4fJPFn2J+Xwz9N4sGPD/dNXYe6p
         XGqxzY5R4apk663CL5ewCw3c9FTCgAfGuqWsErhA0UH6Q9fb3f24/wrXkx2Tv6xI4cH5
         UNow==
X-Gm-Message-State: APjAAAX3ZApw337qCO3WiHC6gX62hTg8/V7SGTtqSHnLcW86IBTIVSO7
        HQiFGX4xKUyhvIywBmrKLQ==
X-Google-Smtp-Source: APXvYqw691qos2bJtdffJtGTHQGhUHizlGbXRnBlDtPGrnyxLj5OXBtGreOsN+qK4QWZ75b+Hg2w6w==
X-Received: by 2002:adf:dc07:: with SMTP id t7mr6598680wri.290.1552770603859;
        Sat, 16 Mar 2019 14:10:03 -0700 (PDT)
Received: from avx2 ([46.53.243.195])
        by smtp.gmail.com with ESMTPSA id r63sm11024792wmr.32.2019.03.16.14.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 14:10:03 -0700 (PDT)
Date:   Sun, 17 Mar 2019 00:10:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, glauber@scylladb.com
Subject: [PATCH 4/4] x86, putuser: switch 64-bit version to normal calling
 convention
Message-ID: <20190316211001.GD21830@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use usual RDI, RSI for put_user()'s arguments.
Do everything in 4 registers, clobber RDX being the next in sequence.

Do CLAC as soon as possible.
Indent more.
Delete unnecessary macros.

This essentially undoes what Glauber did 10 years ago,
but the "this is the i386 way" is not an argument today :^)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/uaccess.h |    9 ++-
 arch/x86/lib/putuser_64.S      |  106 ++++++++++++++++-------------------------
 2 files changed, 50 insertions(+), 65 deletions(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -175,12 +175,17 @@ __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 	__builtin_expect(__ret_gu, 0);					\
 })
 
+#ifdef CONFIG_X86_32
 #define __put_user_x(size, x, ptr, __ret_pu)			\
 	asm volatile("call __put_user_" #size			\
 		     : "=a" (__ret_pu), ASM_CALL_CONSTRAINT	\
 		     : "0" ((typeof(*(ptr)))(x)), "c" (ptr) : "ebx")
-
-
+#else
+#define __put_user_x(size, x, ptr, __ret_pu)	\
+	asm volatile("call __put_user_" #size			\
+		     : "=a" (__ret_pu), ASM_CALL_CONSTRAINT	\
+		     : "D" ((typeof(*(ptr)))(x)), "S" (ptr) : "rdx")
+#endif
 
 #ifdef CONFIG_X86_32
 #define __put_user_goto_u64(x, addr, label)			\
--- a/arch/x86/lib/putuser_64.S
+++ b/arch/x86/lib/putuser_64.S
@@ -5,11 +5,8 @@
  * (C) Copyright 2005 Linus Torvalds
  * (C) Copyright 2005 Andi Kleen
  * (C) Copyright 2008 Glauber Costa
+ * (C) Copyright 2019 Alexey Dobriyan
  *
- * These functions have a non-standard call interface
- * to make them more efficient, especially as they
- * return an error value in addition to the "real"
- * return value.
  */
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
@@ -18,86 +15,69 @@
 #include <asm/smap.h>
 #include <asm/export.h>
 
-
-/*
- * __put_user_X
- *
- * Inputs:	%eax[:%edx] contains the data
- *		%ecx contains the address
- *
- * Outputs:	%eax is error code (0 or -EFAULT)
- *
- * These functions should not modify any other registers,
- * as they get called from within inline assembly.
- */
-
-#define ENTER	mov PER_CPU_VAR(current_task), %_ASM_BX
-#define EXIT	ASM_CLAC ;	\
-		ret
-
 .text
+
 ENTRY(__put_user_1)
-	ENTER
-	cmp TASK_addr_limit(%_ASM_BX),%_ASM_CX
-	jae bad_put_user
+	mov	PER_CPU_VAR(current_task), %rdx
+	cmp	TASK_addr_limit(%rdx), %rsi
+	jae	bad_put_user
 	ASM_STAC
-1:	movb %al,(%_ASM_CX)
-	xor %eax,%eax
-	EXIT
+1:	mov	%dil, (%rsi)
+	ASM_CLAC
+	xor	%eax, %eax
+	ret
 ENDPROC(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
 ENTRY(__put_user_2)
-	ENTER
-	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
-	sub $1,%_ASM_BX
-	cmp %_ASM_BX,%_ASM_CX
-	jae bad_put_user
+	mov	PER_CPU_VAR(current_task), %rdx
+	mov	TASK_addr_limit(%rdx), %rdx
+	sub	$1, %rdx
+	cmp	%rdx, %rsi
+	jae	bad_put_user
 	ASM_STAC
-2:	movw %ax,(%_ASM_CX)
-	xor %eax,%eax
-	EXIT
+2:	mov	%di, (%rsi)
+	ASM_CLAC
+	xor	%eax, %eax
+	ret
 ENDPROC(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
 ENTRY(__put_user_4)
-	ENTER
-	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
-	sub $3,%_ASM_BX
-	cmp %_ASM_BX,%_ASM_CX
-	jae bad_put_user
+	mov	PER_CPU_VAR(current_task), %rdx
+	mov	TASK_addr_limit(%rdx), %rdx
+	sub	$3, %rdx
+	cmp	%rdx, %rsi
+	jae	bad_put_user
 	ASM_STAC
-3:	movl %eax,(%_ASM_CX)
-	xor %eax,%eax
-	EXIT
+4:	mov	%edi, (%rsi)
+	ASM_CLAC
+	xor	%eax, %eax
+	ret
 ENDPROC(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
 ENTRY(__put_user_8)
-	ENTER
-	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
-	sub $7,%_ASM_BX
-	cmp %_ASM_BX,%_ASM_CX
-	jae bad_put_user
+	mov	PER_CPU_VAR(current_task), %rdx
+	mov	TASK_addr_limit(%rdx), %rdx
+	sub	$7, %rdx
+	cmp	%rdx, %rsi
+	jae	bad_put_user
 	ASM_STAC
-4:	mov %_ASM_AX,(%_ASM_CX)
-#ifdef CONFIG_X86_32
-5:	movl %edx,4(%_ASM_CX)
-#endif
-	xor %eax,%eax
-	EXIT
+8:	mov	%rdi, (%rsi)
+	ASM_CLAC
+	xor	%eax, %eax
+	ret
 ENDPROC(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 bad_put_user:
-	movl $-EFAULT,%eax
-	EXIT
+	ASM_CLAC
+	mov	$-EFAULT, %eax
+	ret
 END(bad_put_user)
 
-	_ASM_EXTABLE_UA(1b, bad_put_user)
-	_ASM_EXTABLE_UA(2b, bad_put_user)
-	_ASM_EXTABLE_UA(3b, bad_put_user)
-	_ASM_EXTABLE_UA(4b, bad_put_user)
-#ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(5b, bad_put_user)
-#endif
+_ASM_EXTABLE_UA(1b, bad_put_user)
+_ASM_EXTABLE_UA(2b, bad_put_user)
+_ASM_EXTABLE_UA(4b, bad_put_user)
+_ASM_EXTABLE_UA(8b, bad_put_user)
