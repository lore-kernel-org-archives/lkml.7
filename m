Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA18CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047C92084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfJUQfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:35:24 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57656 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbfJUQfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:35:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D8B15A1;
        Mon, 21 Oct 2019 09:34:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FA363F71F;
        Mon, 21 Oct 2019 09:34:48 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mark.rutland@arm.com, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCH 5/8] arm64: insn: add encoder for MOV (register)
Date:   Mon, 21 Oct 2019 17:34:23 +0100
Message-Id: <20191021163426.9408-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021163426.9408-1-mark.rutland@arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For FTRACE_WITH_REGS, we're going to want to generate a MOV (register)
instruction as part of the callsite intialization. As MOV (register) is
an alias for ORR (shifted register), we can generate this with
aarch64_insn_gen_logical_shifted_reg(), but it's somewhat verbose and
difficult to read in-context.

Add a aarch64_insn_gen_move_reg() wrapper for this case so that we can
write callers in a more straightforward way.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/insn.h |  3 +++
 arch/arm64/kernel/insn.c      | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 39e7780bedd6..bb313dde58a4 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -440,6 +440,9 @@ u32 aarch64_insn_gen_logical_shifted_reg(enum aarch64_insn_register dst,
 					 int shift,
 					 enum aarch64_insn_variant variant,
 					 enum aarch64_insn_logic_type type);
+u32 aarch64_insn_gen_move_reg(enum aarch64_insn_register dst,
+			      enum aarch64_insn_register src,
+			      enum aarch64_insn_variant variant);
 u32 aarch64_insn_gen_logical_immediate(enum aarch64_insn_logic_type type,
 				       enum aarch64_insn_variant variant,
 				       enum aarch64_insn_register Rn,
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index d801a7094076..513b29c3e735 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -1268,6 +1268,19 @@ u32 aarch64_insn_gen_logical_shifted_reg(enum aarch64_insn_register dst,
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn, shift);
 }
 
+/*
+ * MOV (register) is architecturally an alias of ORR (shifted register) where
+ * MOV <*d>, <*m> is equivalent to ORR <*d>, <*ZR>, <*m>
+ */
+u32 aarch64_insn_gen_move_reg(enum aarch64_insn_register dst,
+			      enum aarch64_insn_register src,
+			      enum aarch64_insn_variant variant)
+{
+	return aarch64_insn_gen_logical_shifted_reg(dst, AARCH64_INSN_REG_ZR,
+						    src, 0, variant,
+						    AARCH64_INSN_LOGIC_ORR);
+}
+
 u32 aarch64_insn_gen_adr(unsigned long pc, unsigned long addr,
 			 enum aarch64_insn_register reg,
 			 enum aarch64_insn_adr_type type)
-- 
2.11.0

