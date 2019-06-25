Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D174C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C1620644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LTfG5Okr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfFYK6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:58:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42292 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfFYK6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:58:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Y36R26s9z9v17h;
        Tue, 25 Jun 2019 12:58:07 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LTfG5Okr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xshcch4t6e7f; Tue, 25 Jun 2019 12:58:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Y36R0wYTz9v17d;
        Tue, 25 Jun 2019 12:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561460287; bh=WmP4bKhnfBYlSSGQ//frf/dAVmCAzNuL14conWVzh18=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LTfG5OkrMJ3Ye1E4i+wFzYQEkzfCXKs9+oybS+JkhU4GxOF08mmXtYJAmkGO9WETA
         kv/IihAEV37RMJGIqNQqmjkYr3sDAf/Yx489fdm5y7fM65wD8XdIRdFbniAOLMNVxJ
         SXXUyiet9dr5wPjo9+nfC+V5i1oDUwYPjZyuOFFQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 500658B879;
        Tue, 25 Jun 2019 12:58:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RJECN6eakLR5; Tue, 25 Jun 2019 12:58:08 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F38F98B874;
        Tue, 25 Jun 2019 12:58:06 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C114068E1B; Tue, 25 Jun 2019 10:58:06 +0000 (UTC)
Message-Id: <b8a767a9e1ffc055768b7e0bba0f18b6229dfc94.1561459983.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561459983.git.christophe.leroy@c-s.fr>
References: <cover.1561459983.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 01/13] powerpc: move ptrace into a subdirectory.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Jun 2019 10:58:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow splitting of ptrace depending on the
different CONFIG_ options, create a subdirectory dedicated to
ptrace and move ptrace.c and ptrace32.c into it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/Makefile                | 7 +++----
 arch/powerpc/kernel/ptrace/Makefile         | 9 +++++++++
 arch/powerpc/kernel/{ => ptrace}/ptrace.c   | 0
 arch/powerpc/kernel/{ => ptrace}/ptrace32.c | 0
 4 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/kernel/ptrace/Makefile
 rename arch/powerpc/kernel/{ => ptrace}/ptrace.c (100%)
 rename arch/powerpc/kernel/{ => ptrace}/ptrace32.c (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0ea6c4aa3a20..c522464fa56a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the linux kernel.
 #
 
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
-
 # Disable clang warning for using setjmp without setjmp.h header
 CFLAGS_crash.o		+= $(call cc-disable-warning, builtin-requires-header)
 
@@ -43,15 +41,16 @@ CFLAGS_prom_init.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y				:= cputable.o ptrace.o syscalls.o \
+obj-y				:= cputable.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o
+obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
-				   signal_64.o ptrace32.o \
+				   signal_64.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
diff --git a/arch/powerpc/kernel/ptrace/Makefile b/arch/powerpc/kernel/ptrace/Makefile
new file mode 100644
index 000000000000..02fb28eb3b55
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux kernel.
+#
+
+CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
+
+obj-y				+= ptrace.o
+obj-$(CONFIG_PPC64)		+= ptrace32.o
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
similarity index 100%
rename from arch/powerpc/kernel/ptrace.c
rename to arch/powerpc/kernel/ptrace/ptrace.c
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace/ptrace32.c
similarity index 100%
rename from arch/powerpc/kernel/ptrace32.c
rename to arch/powerpc/kernel/ptrace/ptrace32.c
-- 
2.13.3

