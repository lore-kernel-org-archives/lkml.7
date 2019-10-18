Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D877CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F6921D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VdiO5twV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504976AbfJRIIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:08:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37048 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfJRIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:08:52 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so6403879iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gALXE7phMSnF5XNrDSEyjkXd1DZJtTY9PSTVrsQZe00=;
        b=VdiO5twVtCF9UsEJN/g/Ibi63daAcXzXNmZwrtCD1RybuXu7p4ff+DqxMMhOvSexJ9
         O+h+RCzoMAYVvqRmSYWRgQ0cKZ4kGPOd2mYMuTQE8CbqgQ4NrCDOD1MNtlJsLs/QBVck
         yDEzptuIrt49pyuPEslqXvV0+EtOBXjCLscuS8Zztqra4SVC/n4wl43V2OBapnsBnS7l
         ScmBx8PLNNCUyWrl5FE0itd8L+nCgKDR9xwi/In98CmvYPv4qoYlpdl2id6DvE5MWOC3
         m16329oHHSaXla9lmZ93+A/+QggzKyLBRL24MePHKpxlby7tgnemMvIAYIDjBc5HF3Bu
         4fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gALXE7phMSnF5XNrDSEyjkXd1DZJtTY9PSTVrsQZe00=;
        b=uQJuSMOjoLtd0r7iF7j9sWe9+r+Q2zszzzIi/d0k9XyMoiaCGBDqKn/l5nvawtM18r
         h1dxgbgPrjUJnHuL13/88Pq7PjZdNMYsdzobxQtTUFJYcYHh/MOfqXeP3wOBlAZkk88E
         gSLhyETSMi36vitT0DebWzO4JRGlwgsuaRpv8i/G2f+4NonG9AcaVq8/jRTNYus0Yx5b
         aw5mCquETbSthaHC7GjbcxB6B0GvbmsQLhdhX+AcYAp9xGg/yQBL7Ii3s1dqrSoCRE4M
         k4hCVrufyKtTRCxOxKKypKMAeOFX4/AFhFcak161gSI3SUmcoPdPODbVkoMGLcCEfLOE
         4ZDw==
X-Gm-Message-State: APjAAAWpoPvfkeUNOgq4UsVnfPdR9RwrP/kANvzyGgPv5+ASHQPU2662
        vP/az32qN+Q8wfIJMt8CmKNa/g==
X-Google-Smtp-Source: APXvYqzfJ8zKMPYKiC0SIxFmIQKB8w+RgetlcbhzplyFFJO/YWgSaIBZm0V0UHqa+RzxKZ3ivY9Rew==
X-Received: by 2002:a02:1d44:: with SMTP id 65mr7665917jaj.129.1571386131665;
        Fri, 18 Oct 2019 01:08:51 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:08:51 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] riscv: add prototypes for assembly language functions from entry.S
Date:   Fri, 18 Oct 2019 01:08:34 -0700
Message-Id: <20191018080841.26712-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018080841.26712-1-paul.walmsley@sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prototypes for assembly language functions defined in entry.S,
and include these prototypes into C source files that call those
functions.

This patch resolves the following warnings from sparse:

arch/riscv/kernel/signal.c:32:53: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/signal.c:45:23: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/signal.c:59:53: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/signal.c:69:23: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/signal.c:89:48: warning: incorrect type in argument 2 (different address spaces)
arch/riscv/kernel/signal.c:142:45: warning: incorrect type in argument 2 (different address spaces)
arch/riscv/kernel/signal.c:295:17: warning: symbol 'do_notify_resume' was not declared. Should it be static?
arch/riscv/kernel/traps.c:91:1: warning: symbol 'do_trap_unknown' was not declared. Should it be static?
arch/riscv/kernel/traps.c:93:1: warning: symbol 'do_trap_insn_misaligned' was not declared. Should it be static?
arch/riscv/kernel/traps.c:95:1: warning: symbol 'do_trap_insn_fault' was not declared. Should it be static?
arch/riscv/kernel/traps.c:97:1: warning: symbol 'do_trap_insn_illegal' was not declared. Should it be static?
arch/riscv/kernel/traps.c:99:1: warning: symbol 'do_trap_load_misaligned' was not declared. Should it be static?
arch/riscv/kernel/traps.c:101:1: warning: symbol 'do_trap_load_fault' was not declared. Should it be static?
arch/riscv/kernel/traps.c:103:1: warning: symbol 'do_trap_store_misaligned' was not declared. Should it be static?
arch/riscv/kernel/traps.c:105:1: warning: symbol 'do_trap_store_fault' was not declared. Should it be static?
arch/riscv/kernel/traps.c:107:1: warning: symbol 'do_trap_ecall_u' was not declared. Should it be static?
arch/riscv/kernel/traps.c:109:1: warning: symbol 'do_trap_ecall_s' was not declared. Should it be static?
arch/riscv/kernel/traps.c:111:1: warning: symbol 'do_trap_ecall_m' was not declared. Should it be static?
arch/riscv/kernel/traps.c:125:17: warning: symbol 'do_trap_break' was not declared. Should it be static?
arch/riscv/kernel/traps.c:163:13: warning: symbol 'trap_init' was not declared. Should it be static?

This change should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/entry.h  | 29 +++++++++++++++++++++++++++++
 arch/riscv/kernel/signal.c |  2 ++
 arch/riscv/kernel/traps.c  |  2 ++
 3 files changed, 33 insertions(+)
 create mode 100644 arch/riscv/kernel/entry.h

diff --git a/arch/riscv/kernel/entry.h b/arch/riscv/kernel/entry.h
new file mode 100644
index 000000000000..73bfcda993d0
--- /dev/null
+++ b/arch/riscv/kernel/entry.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 SiFive, Inc.
+ */
+#ifndef __ASM_ENTRY_H
+#define __ASM_ENTRY_H
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+asmlinkage void do_trap_unknown(struct pt_regs *regs);
+asmlinkage void do_trap_insn_misaligned(struct pt_regs *regs);
+asmlinkage void do_trap_insn_fault(struct pt_regs *regs);
+asmlinkage void do_trap_insn_illegal(struct pt_regs *regs);
+asmlinkage void do_trap_load_misaligned(struct pt_regs *regs);
+asmlinkage void do_trap_load_fault(struct pt_regs *regs);
+asmlinkage void do_trap_store_misaligned(struct pt_regs *regs);
+asmlinkage void do_trap_store_fault(struct pt_regs *regs);
+asmlinkage void do_trap_ecall_u(struct pt_regs *regs);
+asmlinkage void do_trap_ecall_s(struct pt_regs *regs);
+asmlinkage void do_trap_ecall_m(struct pt_regs *regs);
+asmlinkage void do_trap_break(struct pt_regs *regs);
+
+asmlinkage void do_notify_resume(struct pt_regs *regs,
+				 unsigned long thread_info_flags);
+
+void __init trap_init(void);
+
+#endif /* __ASM__H */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index b14d7647d800..85c700ad47e9 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -17,6 +17,8 @@
 #include <asm/switch_to.h>
 #include <asm/csr.h>
 
+#include "entry.h"
+
 #define DEBUG_SIG 0
 
 struct rt_sigframe {
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 1ac75f7d0bff..eff679c3b618 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -19,6 +19,8 @@
 #include <asm/ptrace.h>
 #include <asm/csr.h>
 
+#include "entry.h"
+
 int show_unhandled_signals = 1;
 
 extern asmlinkage void handle_exception(void);
-- 
2.23.0

