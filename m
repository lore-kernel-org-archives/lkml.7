Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FCBC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93272084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfGSBEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:04:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfGSBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:03:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so7439792pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=234sLOzVHB5hCj+BQKTblG2UsxBEUB0HpiZuWiY8m1k=;
        b=fIn/C+oxIkXyH3rgsASOjz9QnUUYWGfYapVj08rHpJUVzsLcJ0/RXEhrvjzoNv+LJC
         tf638XI6ng1o7PbvomKPkCwgNP2auqSxI6Im+cpd79YpTaFpsLKNpZla/NiEeAlrn/KQ
         hr6rkw+VKP7wv81GhwekEquH459W2H0iLYTNzbyDj/oJSV8+IWoWrSUit53GDdgIkR18
         ih6iincWXDm9Sy6Q/MnWbIatD5w7VMViOebN/Oaja6tD+VbghK7TtEApuMbr6OYwNzQE
         TEY7Bg5xrboMwdMFsh9JX+4FYV6EdfYkPSqT+IoNgBf8kIUXjlLBkvlT8t+nKX7BJF0r
         iT/w==
X-Gm-Message-State: APjAAAVBXYlLFuTTkBK2QQaYeX0YekZAzI4C1cYNXXxTcFI9poPjgUJI
        7chdPBzjhaqu6PI/kiOqsJ0=
X-Google-Smtp-Source: APXvYqxVw4bYMMHJy9xZz2XbQ8FkLcAt/G11LsNEEH3AYxw1NB7JbL6nJQIqi9P5oSIllZx+WVr1og==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr53921159pjg.90.1563498236261;
        Thu, 18 Jul 2019 18:03:56 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q144sm28887612pfc.103.2019.07.18.18.03.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:03:55 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC 5/7] percpu: Assume preemption is disabled on per_cpu_ptr()
Date:   Thu, 18 Jul 2019 10:41:08 -0700
Message-Id: <20190718174110.4635-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When per_cpu_ptr() is used, the caller should have preemption disabled,
as otherwise the pointer is meaningless. If the user wants an "unstable"
pointer he should call raw_cpu_ptr().

Add an assertion to check that indeed preemption is disabled, and
distinguish between the two cases to allow further, per-arch
optimizations.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/asm-generic/percpu.h | 12 ++++++++++++
 include/linux/percpu-defs.h  | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c2de013b2cf4..7853605f4210 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -36,6 +36,14 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
 #define my_cpu_offset __my_cpu_offset
 #endif
 
+/*
+ * Determine the offset of the current active processor when preemption is
+ * disabled. Can be overriden by arch code.
+ */
+#ifndef __raw_my_cpu_offset
+#define __raw_my_cpu_offset __my_cpu_offset
+#endif
+
 /*
  * Arch may define arch_raw_cpu_ptr() to provide more efficient address
  * translations for raw_cpu_ptr().
@@ -44,6 +52,10 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
 #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
 #endif
 
+#ifndef arch_raw_cpu_ptr_preemptable
+#define arch_raw_cpu_ptr_preemptable(ptr) SHIFT_PERCPU_PTR(ptr, __raw_my_cpu_offset)
+#endif
+
 #ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
 extern void setup_per_cpu_areas(void);
 #endif
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index a6fabd865211..13afca8a37e7 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -237,20 +237,51 @@ do {									\
 	SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));			\
 })
 
+#ifndef arch_raw_cpu_ptr_preemption_disabled
+#define arch_raw_cpu_ptr_preemption_disabled(ptr)			\
+	arch_raw_cpu_ptr(ptr)
+#endif
+
+#define raw_cpu_ptr_preemption_disabled(ptr)				\
+({									\
+	__verify_pcpu_ptr(ptr);						\
+	arch_raw_cpu_ptr_preemption_disabled(ptr);			\
+})
+
+/*
+ * If preemption is enabled, we need to read the pointer atomically on
+ * raw_cpu_ptr(). However if it is disabled, we can use the
+ * raw_cpu_ptr_nopreempt(), which is potentially more efficient. Similarly, we
+ * can use the preemption-disabled version if the kernel is non-preemptable or
+ * if voluntary preemption is used.
+ */
+#ifdef CONFIG_PREEMPT
+
 #define raw_cpu_ptr(ptr)						\
 ({									\
 	__verify_pcpu_ptr(ptr);						\
 	arch_raw_cpu_ptr(ptr);						\
 })
 
+#else
+
+#define raw_cpu_ptr(ptr)	raw_cpu_ptr_preemption_disabled(ptr)
+
+#endif
+
 #ifdef CONFIG_DEBUG_PREEMPT
+/*
+ * Unlike other this_cpu_* operations, this_cpu_ptr() requires that preemption
+ * will be disabled. In contrast, raw_cpu_ptr() does not require that.
+ */
 #define this_cpu_ptr(ptr)						\
 ({									\
+	__this_cpu_preempt_check("ptr");				\
 	__verify_pcpu_ptr(ptr);						\
 	SHIFT_PERCPU_PTR(ptr, my_cpu_offset);				\
 })
 #else
-#define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
+#define this_cpu_ptr(ptr) raw_cpu_ptr_preemption_disabled(ptr)
 #endif
 
 #else	/* CONFIG_SMP */
-- 
2.17.1

