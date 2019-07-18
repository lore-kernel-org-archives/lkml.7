Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A58C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C642084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGSBD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:03:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33738 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfGSBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:03:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so4433501pgj.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3qLasoIZQ902FSbTQ2C3sQZkgl+r6ccAyrvNllcaU4=;
        b=cp/HoljzcPhsMfBMnRW8Zvl8Eb64cbewAwMnposyug/67q9t5gAMDz4QZBaVElwbQ3
         sQH8NXE3lE7G9LCdK+JxeoNGjB4lZ8pfuQUFg+8TiU62xxXgyvolJHo7moWmjHyXsEE6
         /Sf0BQqQ8NgV5Y2ItQFU+vgQQFfaLK0Wm5ay5nGNMRpNCKbqIWwB+vTn9KJbYBHVK3nH
         x5nL+4HCKqkE0s+4aLdUtjRvCYvpzpEBWnN2KS0kTd5HxdhOXLtDHW/sMCsATF19Qxiy
         nnT4RKFfyysf3PAIANYXYDkfCucrD+nHBk7OGIiWn3AEdujcaZ/e38/kdkNotra+tCAK
         mYzQ==
X-Gm-Message-State: APjAAAXaK4k4JgTDKRHdS6Am9V46lWCyTKf9Yz+TuJtSPWcklvn02IjD
        VM/r8tuQGkeKpVSBscUBU571wqPdIiQ=
X-Google-Smtp-Source: APXvYqwiSnxeJhqq+nyQ/Nv9iA6hQuVL7LADgKr1key5/2cK2xq6SZui8B6yzCGfd8p/rPKtx7ZpNA==
X-Received: by 2002:a63:d34c:: with SMTP id u12mr35802019pgi.114.1563498232167;
        Thu, 18 Jul 2019 18:03:52 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q144sm28887612pfc.103.2019.07.18.18.03.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:03:51 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC 2/7] x86/percpu: Use compiler segment prefix qualifier
Date:   Thu, 18 Jul 2019 10:41:05 -0700
Message-Id: <20190718174110.4635-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a segment prefix qualifier is cleaner than using a segment prefix
in the inline assembly, and provides the compiler with more information,
telling it that __seg_gs:[addr] is different than [addr] when it
analyzes data dependencies. It also enables various optimizations that
will be implemented in the next patches.

Use segment prefix qualifiers when they are supported. Unfortunately,
gcc does not provide a way to remove segment qualifiers, which is needed
to use typeof() to create local instances of the per-cpu variable. For
this reason, do not use the segment qualifier for per-cpu variables, and
do casting using the segment qualifier instead.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/percpu.h | 153 ++++++++++++++++++++++------------
 1 file changed, 102 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2278797c769d..1fe348884477 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -45,8 +45,33 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 
+#if defined(COMPILER_HAS_X86_SEG_SUPPORT) && IS_ENABLED(CONFIG_SMP)
+#define USE_X86_SEG_SUPPORT	1
+#else
+#define USE_X86_SEG_SUPPORT	0
+#endif
+
 #ifdef CONFIG_SMP
+
+#if USE_X86_SEG_SUPPORT
+
+#ifdef CONFIG_X86_64
+#define __percpu_seg_override	__seg_gs
+#else
+#define __percpu_seg_override	__seg_fs
+#endif
+
+#define __percpu_prefix		""
+#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
+
+#else /* USE_X86_SEG_SUPPORT */
+
+#define __percpu_seg_override
 #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
+#define __force_percpu_prefix	__percpu_prefix
+
+#endif /* USE_X86_SEG_SUPPORT */
+
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
 /*
@@ -58,14 +83,21 @@
 	unsigned long tcp_ptr__;			\
 	asm volatile("add " __percpu_arg(1) ", %0"	\
 		     : "=r" (tcp_ptr__)			\
-		     : "m" (this_cpu_off), "0" (ptr));	\
+		     : "m" (__my_cpu_var(this_cpu_off)),\
+		       "0" (ptr));			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;	\
 })
-#else
+#else /* CONFIG_SMP */
+#define __percpu_seg_override
 #define __percpu_prefix		""
-#endif
+#define __force_percpu_prefix	""
+#endif /* CONFIG_SMP */
 
+#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
+#define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
+#define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
 /*
  * Initialized pointers to per-cpu variables needed for the boot
@@ -98,22 +130,22 @@ do {							\
 	switch (sizeof(var)) {				\
 	case 1:						\
 		asm qual (op "b %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
+		    : "+m" (__my_cpu_var(var))		\
 		    : "qi" ((pto_T__)(val)));		\
 		break;					\
 	case 2:						\
 		asm qual (op "w %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
+		    : "+m" (__my_cpu_var(var))		\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 4:						\
 		asm qual (op "l %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
+		    : "+m" (__my_cpu_var(var))		\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 8:						\
 		asm qual (op "q %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
+		    : "+m" (__my_cpu_var(var))		\
 		    : "re" ((pto_T__)(val)));		\
 		break;					\
 	default: __bad_percpu_size();			\
@@ -138,71 +170,79 @@ do {									\
 	switch (sizeof(var)) {						\
 	case 1:								\
 		if (pao_ID__ == 1)					\
-			asm qual ("incb "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incb "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else if (pao_ID__ == -1)				\
-			asm qual ("decb "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decb "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else							\
 			asm qual ("addb %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
+			    : "+m" (__my_cpu_var(var))			\
 			    : "qi" ((pao_T__)(val)));			\
 		break;							\
 	case 2:								\
 		if (pao_ID__ == 1)					\
-			asm qual ("incw "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incw "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else if (pao_ID__ == -1)				\
-			asm qual ("decw "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decw "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else							\
 			asm qual ("addw %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
+			    : "+m" (__my_cpu_var(var))			\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 4:								\
 		if (pao_ID__ == 1)					\
-			asm qual ("incl "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incl "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else if (pao_ID__ == -1)				\
-			asm qual ("decl "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decl "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else							\
 			asm qual ("addl %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
+			    : "+m" (__my_cpu_var(var))			\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 8:								\
 		if (pao_ID__ == 1)					\
-			asm qual ("incq "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incq "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else if (pao_ID__ == -1)				\
-			asm qual ("decq "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decq "__percpu_arg(0) :		\
+				  "+m" (__my_cpu_var(var)));		\
 		else							\
 			asm qual ("addq %1, "__percpu_arg(0)		\
-			    : "+m" (var)				\
+			    : "+m" (__my_cpu_var(var))			\
 			    : "re" ((pao_T__)(val)));			\
 		break;							\
 	default: __bad_percpu_size();					\
 	}								\
 } while (0)
 
-#define percpu_from_op(qual, op, var)			\
-({							\
+#define percpu_from_op(qual, op, var)					\
+({									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
 		asm qual (op "b "__percpu_arg(1)",%0"	\
 		    : "=q" (pfo_ret__)			\
-		    : "m" (var));			\
+		    : "m" (__my_cpu_var(var)));		\
 		break;					\
 	case 2:						\
 		asm qual (op "w "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
+		    : "m" (__my_cpu_var(var)));		\
 		break;					\
 	case 4:						\
 		asm qual (op "l "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
+		    : "m" (__my_cpu_var(var)));		\
 		break;					\
 	case 8:						\
 		asm qual (op "q "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
+		    : "m" (__my_cpu_var(var)));		\
 		break;					\
 	default: __bad_percpu_size();			\
 	}						\
@@ -214,22 +254,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(P1)",%0"	\
+		asm(op "b "__force_percpu_arg(P1)",%0"	\
 		    : "=q" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(P1)",%0"	\
+		asm(op "w "__force_percpu_arg(P1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(P1)",%0"	\
+		asm(op "l "__force_percpu_arg(P1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(P1)",%0"	\
+		asm(op "q "__force_percpu_arg(P1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
@@ -243,19 +283,19 @@ do {									\
 	switch (sizeof(var)) {				\
 	case 1:						\
 		asm qual (op "b "__percpu_arg(0)	\
-		    : "+m" (var));			\
+		    : "+m" (__my_cpu_var(var)));	\
 		break;					\
 	case 2:						\
 		asm qual (op "w "__percpu_arg(0)	\
-		    : "+m" (var));			\
+		    : "+m" (__my_cpu_var(var)));	\
 		break;					\
 	case 4:						\
 		asm qual (op "l "__percpu_arg(0)	\
-		    : "+m" (var));			\
+		    : "+m" (__my_cpu_var(var)));	\
 		break;					\
 	case 8:						\
 		asm qual (op "q "__percpu_arg(0)	\
-		    : "+m" (var));			\
+		    : "+m" (__my_cpu_var(var)));	\
 		break;					\
 	default: __bad_percpu_size();			\
 	}						\
@@ -270,22 +310,26 @@ do {									\
 	switch (sizeof(var)) {						\
 	case 1:								\
 		asm qual ("xaddb %0, "__percpu_arg(1)			\
-			    : "+q" (paro_ret__), "+m" (var)		\
+			    : "+q" (paro_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : : "memory");				\
 		break;							\
 	case 2:								\
 		asm qual ("xaddw %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
+			    : "+r" (paro_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : : "memory");				\
 		break;							\
 	case 4:								\
 		asm qual ("xaddl %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
+			    : "+r" (paro_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : : "memory");				\
 		break;							\
 	case 8:								\
 		asm qual ("xaddq %0, "__percpu_arg(1)			\
-			    : "+re" (paro_ret__), "+m" (var)		\
+			    : "+re" (paro_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : : "memory");				\
 		break;							\
 	default: __bad_percpu_size();					\
@@ -308,7 +352,8 @@ do {									\
 		asm qual ("\n\tmov "__percpu_arg(1)",%%al"		\
 		    "\n1:\tcmpxchgb %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
+			    : "=&a" (pxo_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : "q" (pxo_new__)				\
 			    : "memory");				\
 		break;							\
@@ -316,7 +361,8 @@ do {									\
 		asm qual ("\n\tmov "__percpu_arg(1)",%%ax"		\
 		    "\n1:\tcmpxchgw %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
+			    : "=&a" (pxo_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : "r" (pxo_new__)				\
 			    : "memory");				\
 		break;							\
@@ -324,7 +370,8 @@ do {									\
 		asm qual ("\n\tmov "__percpu_arg(1)",%%eax"		\
 		    "\n1:\tcmpxchgl %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
+			    : "=&a" (pxo_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : "r" (pxo_new__)				\
 			    : "memory");				\
 		break;							\
@@ -332,7 +379,8 @@ do {									\
 		asm qual ("\n\tmov "__percpu_arg(1)",%%rax"		\
 		    "\n1:\tcmpxchgq %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
-			    : "=&a" (pxo_ret__), "+m" (var)		\
+			    : "=&a" (pxo_ret__),			\
+			      "+m" (__my_cpu_var(var))			\
 			    : "r" (pxo_new__)				\
 			    : "memory");				\
 		break;							\
@@ -353,25 +401,25 @@ do {									\
 	switch (sizeof(var)) {						\
 	case 1:								\
 		asm qual ("cmpxchgb %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
+			    : "=a" (pco_ret__), "+m" (__my_cpu_var(var))\
 			    : "q" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 2:								\
 		asm qual ("cmpxchgw %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
+			    : "=a" (pco_ret__), "+m" (__my_cpu_var(var))\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 4:								\
 		asm qual ("cmpxchgl %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
+			    : "=a" (pco_ret__), "+m" (__my_cpu_var(var))\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 8:								\
 		asm qual ("cmpxchgq %2, "__percpu_arg(1)		\
-			    : "=a" (pco_ret__), "+m" (var)		\
+			    : "=a" (pco_ret__), "+m" (__my_cpu_var(var))\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
@@ -464,7 +512,8 @@ do {									\
 	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
 	asm volatile("cmpxchg8b "__percpu_arg(1)			\
 		     CC_SET(z)						\
-		     : CC_OUT(z) (__ret), "+m" (pcp1), "+m" (pcp2), "+a" (__o1), "+d" (__o2) \
+		     : CC_OUT(z) (__ret), "+m" (__my_cpu_var(pcp1)),	\
+		    "+m" (__my_cpu_var(pcp2)), "+a" (__o1), "+d" (__o2) \
 		     : "b" (__n1), "c" (__n2));				\
 	__ret;								\
 })
@@ -507,11 +556,13 @@ do {									\
 	bool __ret;							\
 	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
 	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	alternative_io("leaq %P1,%%rsi\n\tcall this_cpu_cmpxchg16b_emu\n\t", \
-		       "cmpxchg16b " __percpu_arg(1) "\n\tsetz %0\n\t",	\
+	alternative_io("leaq %P[ptr],%%rsi\n\tcall this_cpu_cmpxchg16b_emu\n\t", \
+		       "cmpxchg16b " __force_percpu_arg([ptr]) "\n\tsetz %0\n\t",\
 		       X86_FEATURE_CX16,				\
-		       ASM_OUTPUT2("=a" (__ret), "+m" (pcp1),		\
-				   "+m" (pcp2), "+d" (__o2)),		\
+		       ASM_OUTPUT2("=a" (__ret),			\
+				   "+m" (__my_cpu_var(pcp1)),		\
+				   "+m" (__my_cpu_var(pcp2)),		\
+				   "+d" (__o2)), [ptr]"m" (pcp1),	\
 		       "b" (__n1), "c" (__n2), "a" (__o1) : "rsi");	\
 	__ret;								\
 })
@@ -542,7 +593,7 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 	asm volatile("btl "__percpu_arg(2)",%1"
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
-			: "m" (*(unsigned long __percpu *)addr), "Ir" (nr));
+			: "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))), "Ir" (nr));
 
 	return oldbit;
 }
-- 
2.17.1

