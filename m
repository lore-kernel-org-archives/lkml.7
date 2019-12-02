Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF24BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A274720715
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="wbLoAhpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLBSCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:02:41 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38064 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfLBSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:02:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id l4so54159pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ax7AJFFSOuj9/KpKJurbPo//Js3m9VypMUOlCMjR8xE=;
        b=wbLoAhpI3zpBjumoLAzDXqBKlWvYOrMKC+8KTct/2ORkshG4rYi/a7x0z9skQ+UF+i
         pFG4vX6HeqoW5shQ3FiUohzpdRU54TytrpO3JqKdf2AzV4CO2ZKFhOXi4N0pdPDzVa3b
         EK7+VjR8fII3C+LF2LTpyUG7oBhNIoyUqYMjlsYyBIBmsTEjISbd55+eN+XOv3LPbdgb
         ZdHldWIhYaOGA27oa3KJENfT300RwkByoHZvHrrq4zlMhaC6lHKHUb/w6rscWDMkJRjl
         MhB/LESi9BWJS3kp/qKn4Sa57vOP49mRCFKpCSkvEzJsaydTg30Gl2vIDLvQ5e8zlQ3Z
         hLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ax7AJFFSOuj9/KpKJurbPo//Js3m9VypMUOlCMjR8xE=;
        b=ElnbKVBKrz9zPbgv66tb8cinhacRmtmyWvUa7hOtlHFOKDOzgfl0U6EjVegDciFe10
         ZCrKquGDiUf0pWup2klma9HNtiAXFRYpKrZvPjnMXabq/uy35nVVQH3sO/aY+8Yxl8DS
         oXGrvfRPNkAg5UMHmnoJqPJhEgugMTgUnKsHZBbcyGf+wy1Xdmb2dEeeaMTp81juquC6
         YBkoY6rye1sS5a9m84/sbIFS5NxhW7juj9WV0KowzhBstoaPQ+ql7FnXAOHNZCC15xLS
         BFcEtc05RCB/yvgZ81FieYtmqh0tsvnFVfUgycFT7zzl3Ow1y/jnI1NjbyGPcc9jjamd
         tRlg==
X-Gm-Message-State: APjAAAX/f7Rxxi5a2mjjqWESzvmf7KyIVhtyjd6hlDJUIEliw7gereB+
        iLK3v6Wq0ZXx6cFR4KuuGxjJHA==
X-Google-Smtp-Source: APXvYqxzUG4s6dG8gjJ4GL72W2YEuag/dwxvNlJ9amBgYfwIEuVydQEN4ez+apZH69m6dQEaX5APNg==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr341827pjq.112.1575309760080;
        Mon, 02 Dec 2019 10:02:40 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:4fcf])
        by smtp.gmail.com with ESMTPSA id x2sm238373pgc.67.2019.12.02.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:02:39 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86: define arch_crash_save_vmcoreinfo() if CONFIG_CRASH_CORE=y
Date:   Mon,  2 Dec 2019 10:02:29 -0800
Message-Id: <9e9eb78c157d26d80f8781f8ce0e088fd12120b4.1575309711.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

kernel/crash_core.c calls arch_crash_save_vmcoreinfo() to get
arch-specific bits for vmcoreinfo. If it is not defined, then it has a
no-op fallback. kernel/crash_core.c is gated behind CONFIG_CRASH_CORE.
However, x86 defines arch_crash_save_vmcoreinfo() in
arch/x86/kernel/machine_kexec_*.c, which is gated behind
CONFIG_KEXEC_CORE. So, a kernel with CONFIG_CRASH_CORE=y and
CONFIG_KEXEC_CORE=n uses the fallback and gets incomplete vmcoreinfo
data, which can confuse applications reading vmcoreinfo from
/proc/kcore.

Fix it by moving arch_crash_save_vmcoreinfo() into two new
arch/x86/kernel/crash_core_*.c files, which are gated behind
CONFIG_CRASH_CORE.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Based on Linus's tree.

 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/crash_core_32.c    | 17 +++++++++++++++++
 arch/x86/kernel/crash_core_64.c    | 24 ++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_32.c | 12 ------------
 arch/x86/kernel/machine_kexec_64.c | 19 -------------------
 5 files changed, 42 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/kernel/crash_core_32.c
 create mode 100644 arch/x86/kernel/crash_core_64.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6175e370ee4a..9b294c13809a 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace_$(BITS).o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_X86_TSC)		+= trace_clock.o
+obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
diff --git a/arch/x86/kernel/crash_core_32.c b/arch/x86/kernel/crash_core_32.c
new file mode 100644
index 000000000000..c0159a7bca6d
--- /dev/null
+++ b/arch/x86/kernel/crash_core_32.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crash_core.h>
+
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
+#ifdef CONFIG_X86_PAE
+	VMCOREINFO_CONFIG(X86_PAE);
+#endif
+}
diff --git a/arch/x86/kernel/crash_core_64.c b/arch/x86/kernel/crash_core_64.c
new file mode 100644
index 000000000000..845a57eb4eb7
--- /dev/null
+++ b/arch/x86/kernel/crash_core_64.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crash_core.h>
+
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	u64 sme_mask = sme_me_mask;
+
+	VMCOREINFO_NUMBER(phys_base);
+	VMCOREINFO_SYMBOL(init_top_pgt);
+	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
+			      pgtable_l5_enabled());
+
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
+	VMCOREINFO_NUMBER(sme_mask);
+}
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 7b45e8daad22..02bddfc122a4 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -250,15 +250,3 @@ void machine_kexec(struct kimage *image)
 
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
-
-void arch_crash_save_vmcoreinfo(void)
-{
-#ifdef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(node_data);
-	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
-#ifdef CONFIG_X86_PAE
-	VMCOREINFO_CONFIG(X86_PAE);
-#endif
-}
-
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 16e125a50b33..ad5cdd6a5f23 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -398,25 +398,6 @@ void machine_kexec(struct kimage *image)
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
 
-void arch_crash_save_vmcoreinfo(void)
-{
-	u64 sme_mask = sme_me_mask;
-
-	VMCOREINFO_NUMBER(phys_base);
-	VMCOREINFO_SYMBOL(init_top_pgt);
-	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
-			pgtable_l5_enabled());
-
-#ifdef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(node_data);
-	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
-	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
-			      kaslr_offset());
-	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
-	VMCOREINFO_NUMBER(sme_mask);
-}
-
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.24.0

