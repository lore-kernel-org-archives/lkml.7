Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80430C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612E12084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfGSBEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:04:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33027 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGSBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:03:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so13400742pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3DerTdpMCvOAmilKWu1WZjnbwiZiuPLab19ZVw3bxBA=;
        b=CcjIovhZedFsDdezc7AQitBZADDpwxrpZuoHqoLBsPIhq3ETzLfSXl5FRR6+g825Vi
         NQ0I9It1E1J4o/5fbkjF2OxtlN2iwuclO8cVTscbJyPBi6km6qMmxFJxxkMzFIE4bGTu
         rzjNrLYnlcBD9SO1IwKCAftWASxed/bC43uQ/wqzv0yb1ye8ptSZ3u/Xg8H6OBRMwpUd
         OTLKRKIA9gaC57vo4o19GJsJGRGwObYHEArlmsjkVv6zOXCrvLEK2zVKa78QbGLBnnc4
         3G3KoCFj7FOzMNs/8paTdMhLgqH8GDGR5U4ZYFibe2NCgJr2oRh2iuR9zxwmFBn/d5uV
         xBag==
X-Gm-Message-State: APjAAAUXSbEhqkrIabv94hfhj7o71LE6Ewi8t7A/x3RR/g4ix+EVpmuz
        qz/qamyk+ELCQBaaYIpdmw0=
X-Google-Smtp-Source: APXvYqzPAcu6qLOmEhMfz7VydByOJF8x4MlGexyAApZEKkNR5dc+pDZCOb3kIxs/VQggIwPkwgP3nw==
X-Received: by 2002:a17:90b:8cd:: with SMTP id ds13mr51585957pjb.141.1563498237573;
        Thu, 18 Jul 2019 18:03:57 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q144sm28887612pfc.103.2019.07.18.18.03.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:03:56 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC 6/7] x86/percpu: Optimized arch_raw_cpu_ptr()
Date:   Thu, 18 Jul 2019 10:41:09 -0700
Message-Id: <20190718174110.4635-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
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
index 13987f9bc82f..8bac7db397cc 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -73,20 +73,41 @@
 #endif /* USE_X86_SEG_SUPPORT */
 
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
+#define __raw_my_cpu_offset	__this_cpu_read(this_cpu_off)
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
 
+#if USE_X86_SEG_SUPPORT && (!defined(BUILD_VDSO32) || defined(CONFIG_X86_64))
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
+#else /* USE_X86_SEG_SUPPORT && (!defined(BUILD_VDSO32) || defined(CONFIG_X86_64)) */
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
+#endif /* USE_X86_SEG_SUPPORT && (!defined(BUILD_VDSO32) || defined(CONFIG_X86_64)) */
+
+#define arch_raw_cpu_ptr(ptr)				__arch_raw_cpu_ptr_qual(volatile, ptr)
+#define arch_raw_cpu_ptr_preemption_disabled(ptr)	__arch_raw_cpu_ptr_qual( , ptr)
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
-- 
2.17.1

