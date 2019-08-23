Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2880EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D972133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfHXGFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:05:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41752 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfHXGFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:05:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so7056343pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0HkBOqN0uylntPEgaS0w5fFqAg/V/5vucjq9zDrym4=;
        b=snxF3JsuC9Y7gNcVB0od4XmiPo2nkAysHZ6JhhN3fEUJwTRJc8SagE0MDwHowYQXrX
         HkuqArFEZnQwD5K8TF4/v8yl9AEiGMA/6MNAJOBz8r9xAbGCAqWemwSOjE4DD6Ju/SI4
         O368ezZl8SLn2CuCx8vV/umBHKhzAckmTYnjL3oLAt7SPIPqlqyJbGFbK+R0HHuRMiKR
         rVJBlv/Flg82fxkha5sHZw+qC4vyOUi2a5X0pboAX0xTI0LPNkut4hzq+LLL2NmHAfra
         29Adof19cYq/FjFZkk/b7kpR905rPXFyF2Wh08Yj3eR+FsD7wqZ8/YIEmnfCN+lwETVH
         CXnw==
X-Gm-Message-State: APjAAAX2rzuP/04Sr0FT7YZCxeO4VxzbTRcZORe7xJoMIJ0iRCMAIDR8
        VjN7OUEVkOKyEnFfB1xpx2Y=
X-Google-Smtp-Source: APXvYqx9gXJzI9J8fiAP62+h4JpKDgeEO0hkmJGEPYIRc227/M4bn+76DWdLzq9rZZVUz2tyt4qmjQ==
X-Received: by 2002:a63:f048:: with SMTP id s8mr6940406pgj.26.1566626720775;
        Fri, 23 Aug 2019 23:05:20 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w2sm4300882pjr.27.2019.08.23.23.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:05:19 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 6/7] x86/percpu: Optimized arch_raw_cpu_ptr()
Date:   Fri, 23 Aug 2019 15:44:23 -0700
Message-Id: <20190823224424.15296-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224424.15296-1-namit@vmware.com>
References: <20190823224424.15296-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementing arch_raw_cpu_ptr() in C, allows the compiler to perform
better optimizations, such as setting an appropriate base to compute
the address instead of an add instruction.

The benefit of this computation is relevant only when using compiler
segment qualifiers. It is inapplicable to use this method when the
address size is greater than the maximum operand size, as it is when
building vdso32.

Distinguish between the two cases in which preemption is disabled (as
happens when this_cpu_ptr() is used) and enabled (when raw_cpu_ptr() is
used).

This allows optimizations, for instance in rcu_dynticks_eqs_exit(),
the following code:

  mov    $0x2bbc0,%rax
  add    %gs:0x7ef07570(%rip),%rax	# 0x10358 <this_cpu_off>
  lock xadd %edx,0xd8(%rax)

Turns with this patch into:

  mov    %gs:0x7ef08aa5(%rip),%rax	# 0x10358 <this_cpu_off>
  lock xadd %edx,0x2bc58(%rax)

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/percpu.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 13987f9bc82f..3d82df27d45c 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -73,20 +73,41 @@
 #endif /* USE_X86_SEG_SUPPORT */
 
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
+#define __raw_my_cpu_offset	__this_cpu_read(this_cpu_off)
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
 
+#if USE_X86_SEG_SUPPORT && !defined(BUILD_VDSO32) && defined(CONFIG_X86_64)
+/*
+ * Efficient implementation for cases in which the compiler supports C segments.
+ * Allows the compiler to perform additional optimizations that can save more
+ * instructions.
+ *
+ * This optimized version can only be used if the pointer size equals to native
+ * operand size, which does not happen when vdso32 is used.
+ */
+#define __arch_raw_cpu_ptr_qual(qual, ptr)				\
+({									\
+	(qual typeof(*(ptr)) __kernel __force *)((uintptr_t)(ptr) +	\
+						__my_cpu_offset);	\
+})
+#else /* USE_X86_SEG_SUPPORT && !defined(BUILD_VDSO32) && defined(CONFIG_X86_64) */
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
  */
-#define arch_raw_cpu_ptr(ptr)				\
+#define __arch_raw_cpu_ptr_qual(qual, ptr)		\
 ({							\
 	unsigned long tcp_ptr__;			\
-	asm volatile("add " __percpu_arg(1) ", %0"	\
+	asm qual ("add " __percpu_arg(1) ", %0"		\
 		     : "=r" (tcp_ptr__)			\
 		     : "m" (__my_cpu_var(this_cpu_off)),\
 		       "0" (ptr));			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;	\
 })
+#endif /* USE_X86_SEG_SUPPORT && !defined(BUILD_VDSO32) && defined(CONFIG_X86_64) */
+
+#define arch_raw_cpu_ptr(ptr)				__arch_raw_cpu_ptr_qual(volatile, ptr)
+#define arch_raw_cpu_ptr_preemption_disabled(ptr)	__arch_raw_cpu_ptr_qual( , ptr)
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
-- 
2.17.1

