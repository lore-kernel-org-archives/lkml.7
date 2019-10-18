Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07AECA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791A021852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gvQqT9Yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407261AbfJRAtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:49:50 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46715 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJRAtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:49 -0400
Received: by mail-il1-f196.google.com with SMTP id c4so3905011ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gALXE7phMSnF5XNrDSEyjkXd1DZJtTY9PSTVrsQZe00=;
        b=gvQqT9Yodma6TKFJX8psyNTmo8wcv+MIYwgBZSs5+OnIb53melvh14TUW8Krr6e/pw
         b6Ruf9EUI3WPSSX1ll6odbzEAr8QBztNIPKo1dkw8sS8CjOqCmsvFqh8w9HRTDfVL10u
         dfVhQB9K9qqxNQtwpR3pvEcBSS4/n5xuiikXqL2eEVkfg/01+BpwoDOBI4prTXD6oW3e
         lrjiGH5iOhv5B8FXh6YoMwYcIjogRCbX+Mgy5eD07LOR37kbJRm41HyV6Ts/nIartkj2
         XFOfE4nXsSWa8hclFAY99o218sf8Q1RtxuVD/azxc03ekDAP9KSGLh3v8KbC6gylyYA8
         lTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gALXE7phMSnF5XNrDSEyjkXd1DZJtTY9PSTVrsQZe00=;
        b=D24Aea1jm+6AADD6yzSM09zpd/CetWaswxtHGI6553TvYOWnF2Z+PewgNbg7tOMAw3
         3ied6QRtTBqHoeYPVUrN0zKbNdgbabLImL3l0diLmau/6tXUsejw6+8ZnCPZUb7Tke3+
         yYH3/6yxj7w9hz7QpmPGZMGtwnSadRJ59M80KCci2nfUWiPcyWzGgYMAzIv+8wcY0g4A
         eIOiiELDMwIXSHbS/pHrTxGv/S7hvpZNq+STDLXNvdVIhuhO3ZeC2FcKsOeZHNMkQ/2M
         T7X10o499HI+a1Tjs4vJNNwK2p5axFAEyiOg+duEGjA0CkuLsoOzTXbIBRNV4i4oNmeE
         TwQA==
X-Gm-Message-State: APjAAAVSU6TCi/c6QKZpG4dWBbi7PYW9MniZ/NVTdAM2en5yRmyBZ7oY
        eJFtENB39PE4tLzJAjUaNA58JrPpREY=
X-Google-Smtp-Source: APXvYqxPLKQvtgbLgFlVRB2Ikn/U3owBmflwcq8p9d/U6XcwlVA5Drwp1LB7Ar0kv3oX22JbaPb7Lw==
X-Received: by 2002:a92:4144:: with SMTP id o65mr7004075ila.172.1571359788541;
        Thu, 17 Oct 2019 17:49:48 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:48 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] riscv: add prototypes for assembly language functions from entry.S
Date:   Thu, 17 Oct 2019 17:49:22 -0700
Message-Id: <20191018004929.3445-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
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

