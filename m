Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE49C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D05F233A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfHXGFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:05:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44406 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfHXGFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:05:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so8022964pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYZ+gDH3g6WdufNLGNflxTKOst30C6CpIv++xEXo6RI=;
        b=tVroRz8cYXIgxoDdWDi2BZ/H2qQx5NaovtV1Nen6VXdhv9ZBQ2Mir4GkVV2ZAch5ZA
         +JQ1oYg2v81xmZDDcXYn4rhgfoOAF7PWIiAgmkQF40bodtK5p2rgCTZ7hEL4jhm6E0GF
         FnAPAtmab4gj74RJ39jksg4J3ybaW36nswiSqrr2QjBQL89ekEA5VihmxAn1GnSpwOYI
         qFGCR+61EWDtW1w65UIyM6ayJS1CJa6Pq3v249V3DEoJi7ttQ7ndzp2dCYYVZVkF/gzp
         /LCx+sP6O7PhhVBDCdkbzCOsLQyx9jF34dBCLOlfo6Vuz9zK5QPvjV1FT5WRqq5Ts7Jc
         FWyw==
X-Gm-Message-State: APjAAAVwy9K/biSbz39jNPi7qLTIFHjxmlxitocuJbMHNK3+D5MP6NMk
        gG78QtCp3EwQO9L4o9ltSds=
X-Google-Smtp-Source: APXvYqxnW3TA13OgXQn3orFwBDb73TJgDZy8fkF8p6X9MdoW5r4nFVOcrZ28tTmQsqznNy4T7V5vFA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr7262057pgr.52.1566626715340;
        Fri, 23 Aug 2019 23:05:15 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w2sm4300882pjr.27.2019.08.23.23.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:05:14 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 2/7] x86/percpu: Use compiler segment prefix qualifier
Date:   Fri, 23 Aug 2019 15:44:19 -0700
Message-Id: <20190823224424.15296-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224424.15296-1-namit@vmware.com>
References: <20190823224424.15296-1-namit@vmware.com>
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
 arch/x86/include/asm/percpu.h  | 153 ++++++++++++++++++++++-----------
 arch/x86/include/asm/preempt.h |   3 +-
 2 files changed, 104 insertions(+), 52 deletions(-)

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
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 3d4cb83a8828..8d46efbc675a 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -91,7 +91,8 @@ static __always_inline void __preempt_count_sub(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", __preempt_count, e, __percpu_arg([var]));
+	return GEN_UNARY_RMWcc("decl", __my_cpu_var(__preempt_count), e,
+			       __percpu_arg([var]));
 }
 
 /*
-- 
2.17.1

