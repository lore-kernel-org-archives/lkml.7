Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC0C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2DE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="hvJvDTNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfLTQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:23:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:22:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so5197703pgf.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tY0QhQpTu5RdMosMDUzceZjQ4A6aaBIeBthRCHd6OHY=;
        b=hvJvDTNdDWYzQQWdTSntmuzwDsONUPm7ylhImEriMaJv8R1GV/b41mGZgSZ8lzFBmg
         PfOssyzsNfkcdom/B+8QIQniHzaf6Vtdh5kpqY9XXD/go0CR9BEIAoDx2UhiQ1Q+wV4A
         O6k7klwHtMgOQxymKL2dvHertw3yyPq4rbSGiBKx+DwUJv/GjUp/3NFpLvapiRccyNeO
         ORw67G4l9Sns/K6jGN4FKJBL1rk5bNkFkruv9wwlCfL2MsS7EqshQrvwUapo51uWBNHu
         aXjrqtFknVJ48SysYK+bPz37ilR0I0HoGvCXqul+xur7r8wgO0SeqMUHKWk6IxOEBYRb
         iZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tY0QhQpTu5RdMosMDUzceZjQ4A6aaBIeBthRCHd6OHY=;
        b=H4I4ayvSYEvuqaFsFbNUYMAM26DQb8oJ6/52Whw62i/grsKgEpkDWQ3l0/aXy0aNeg
         3SobMMblUZ6E8vKB82mCpBfy0HKLWUKkxp4ZOUo0bZxNlYLVzif9facJgySOG6pSB2wg
         4vgMKEHauDwCXxKzOlN6Iibo7+g+4divOtOXvw0iikdjErEC7YYrw2WQPIiEaBUlxtvJ
         uN0UOyWFM9esXIfSY0RyGoyK1rDB70kUWjiMtwbrKPnsY6huXPaK77NQYP5BTPUFWBOH
         hXuoneCYUvh5K4L7V/WSBrh2yRVKDd2EgUBmof6iS3TBD6w7fhHVAW5SHvUZYKekjF/q
         FiZw==
X-Gm-Message-State: APjAAAUkUKcqFoVZ4c3m8BVHQehkWSp70MbzS+TxPEsT0VpJWTylzP95
        69dK0me20M/u6LdiguWe9Pql9w==
X-Google-Smtp-Source: APXvYqwi0gJzgr9IZYhGnpJx160O4tumQ+WpLvtj1sj5ow/kwsS3ZeT6MS3MoeAVUtOe8fDGR0zO9w==
X-Received: by 2002:a63:cb06:: with SMTP id p6mr15747378pgg.236.1576858978595;
        Fri, 20 Dec 2019 08:22:58 -0800 (PST)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id g7sm14036842pfq.33.2019.12.20.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 08:22:58 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86: define arch_crash_save_vmcoreinfo() if CONFIG_CRASH_CORE=y
Date:   Fri, 20 Dec 2019 08:22:49 -0800
Message-Id: <0589961254102cca23e3618b96541b89f2b249e2.1576858905.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

On x86 kernels configured with CONFIG_PROC_KCORE=y and
CONFIG_KEXEC_CORE=n, the vmcoreinfo note in /proc/kcore is incomplete.
Specifically, it is missing arch-specific information like the KASLR
offset and whether 5-level page tables are enabled. This breaks
applications like drgn [1] and crash [2], which need this information
for live debugging via /proc/kcore.

This happens because:

1. CONFIG_PROC_KCORE selects CONFIG_CRASH_CORE.
2. kernel/crash_core.c (compiled if CONFIG_CRASH_CORE=y) calls
   arch_crash_save_vmcoreinfo() to get the arch-specific parts of
   vmcoreinfo. If it is not defined, then it uses a no-op fallback.
3. x86 defines arch_crash_save_vmcoreinfo() in
   arch/x86/kernel/machine_kexec_*.c, which is only compiled if
   CONFIG_KEXEC_CORE=y.

Therefore, an x86 kernel with CONFIG_CRASH_CORE=y and
CONFIG_KEXEC_CORE=n uses the no-op fallback and gets incomplete
vmcoreinfo data. This isn't relevant to kdump, which requires
CONFIG_KEXEC_CORE. It only affects applications which read vmcoreinfo at
runtime, like the ones mentioned above.

Fix it by moving arch_crash_save_vmcoreinfo() into two new
arch/x86/kernel/crash_core_*.c files, which are gated behind
CONFIG_CRASH_CORE.

1: https://github.com/osandov/drgn/blob/73dd7def1217e24cc83d8ca95c995decbd9ba24c/libdrgn/program.c#L385
2: https://github.com/crash-utility/crash/commit/60a42d709280cdf38ab06327a5b4fa9d9208ef86

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Based on Linus' tree.

Changes from v1 -> v2:

- Elaborate on use case in commit message.

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
2.24.1

