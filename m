Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BB0C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839D12080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575406151;
	bh=NqWUim3P4zCL/7IUtpQCZO9Xb5uEkYeYZizK/BXYMsI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bAbpUy588IQDn8ScxWasE1E4/rRLVFQT7VYG4Cl46pDIqhO8WKoA6p9EeB2uYZzaD
	 yuNi2XWBXsuhXyodEFJJSBFWYpMIwPZONXjMp/01VBGuhb11E+6aYnZ+u9KdWn2TwH
	 fFbIlLRB+HCbWBgFSbI+ahJeGzRsLxsTYhYp21cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLCUtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:49:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40551 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfLCUtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:49:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so2161217plp.7;
        Tue, 03 Dec 2019 12:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1G+L1iXyg9WsvAhiBU0plOD98ZEEqTeAJKnio8PQGVI=;
        b=VAn4c43hRYNSW9YkW6dId/qpM9dnxo4p4wAtBaWee3y7TG49LiyZXvkwVZBFFV2ZG+
         9wYbscEz9tKyiJ+3Ir1QqSAjKkXYERWTucu8usmLXmFvdcJ9PuWFZQhz6IYhXOBqvwsq
         cfe4qD0Mw5F6jDWComWSKa3tXnCmDlpbBH5wPQ9ne3S4C7/owKORmvfCiOtGxlrguBtM
         Mn4wyEDpUpOVlijoeQYv+YiMlMTj3oRUD1fmxLXZ5cYekS9bpulDPnjn1nkD1+h1fbJB
         g3FY8seMYL4r30oxZoeb3GIWqVgBrwf8tCnyQWIBIfwvtZ0yFsIbn5DcVygIYF6F/s/k
         FTQQ==
X-Gm-Message-State: APjAAAXHAklSrQyMYm10YoX+omDdL9558g2cHPHwicaCZh0mw/gB2Rzz
        q2llT/doQK+I9unIMGxBMeCCEedwnqg=
X-Google-Smtp-Source: APXvYqx4TZrkwIhqDQl9aBJXa/SKofSy+menGC9K2DEaF74w1ikQ3eXm3kKGaRz2rKzU4/MOI4G61A==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr7129455plk.10.1575406149016;
        Tue, 03 Dec 2019 12:49:09 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id fz12sm3711580pjb.15.2019.12.03.12.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:49:08 -0800 (PST)
From:   Paul Burton <paulburton@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paul Burton <paulburton@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH] MIPS: Use __copy_{to,from}_user() for emulated FP loads/stores
Date:   Tue,  3 Dec 2019 12:49:33 -0800
Message-Id: <20191203204933.1642259-1-paulburton@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our FPU emulator currently uses __get_user() & __put_user() to perform
emulated loads & stores. This is problematic because __get_user() &
__put_user() are only suitable for naturally aligned memory accesses,
and the address we're accessing is entirely under the control of
userland.

This allows userland to cause a kernel panic by simply performing an
unaligned floating point load or store - the kernel will handle the
address error exception by attempting to emulate the instruction, and in
the process it may generate another address error exception itself.
This time the exception is taken with EPC pointing at the kernels FPU
emulation code, and we hit a die_if_kernel() in
emulate_load_store_insn().

Fix this up by using __copy_from_user() instead of __get_user() and
__copy_to_user() instead of __put_user(). These replacements will handle
arbitrary alignment without problems.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org> # v2.6.12+
---
 arch/mips/math-emu/cp1emu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 710e1f804a54..d2009b4b5209 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1056,7 +1056,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			*fault_addr = dva;
 			return SIGBUS;
 		}
-		if (__get_user(dval, dva)) {
+		if (__copy_from_user(&dval, dva, sizeof(u64))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
 			*fault_addr = dva;
 			return SIGSEGV;
@@ -1074,7 +1074,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			*fault_addr = dva;
 			return SIGBUS;
 		}
-		if (__put_user(dval, dva)) {
+		if (__copy_to_user(dva, &dval, sizeof(u64))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
 			*fault_addr = dva;
 			return SIGSEGV;
@@ -1090,7 +1090,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			*fault_addr = wva;
 			return SIGBUS;
 		}
-		if (__get_user(wval, wva)) {
+		if (__copy_from_user(&wval, wva, sizeof(u32))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
 			*fault_addr = wva;
 			return SIGSEGV;
@@ -1108,7 +1108,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			*fault_addr = wva;
 			return SIGBUS;
 		}
-		if (__put_user(wval, wva)) {
+		if (__copy_to_user(wva, &wval, sizeof(u32))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
 			*fault_addr = wva;
 			return SIGSEGV;
@@ -1486,7 +1486,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				*fault_addr = va;
 				return SIGBUS;
 			}
-			if (__get_user(val, va)) {
+			if (__copy_from_user(&val, va, sizeof(u32))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
 				*fault_addr = va;
 				return SIGSEGV;
@@ -1506,7 +1506,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				*fault_addr = va;
 				return SIGBUS;
 			}
-			if (put_user(val, va)) {
+			if (__copy_to_user(va, &val, sizeof(u32))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
 				*fault_addr = va;
 				return SIGSEGV;
@@ -1583,7 +1583,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				*fault_addr = va;
 				return SIGBUS;
 			}
-			if (__get_user(val, va)) {
+			if (__copy_from_user(&val, va, sizeof(u64))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
 				*fault_addr = va;
 				return SIGSEGV;
@@ -1602,7 +1602,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				*fault_addr = va;
 				return SIGBUS;
 			}
-			if (__put_user(val, va)) {
+			if (__copy_to_user(va, &val, sizeof(u64))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
 				*fault_addr = va;
 				return SIGSEGV;
-- 
2.24.0

