Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F37C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292D3218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTTdgQH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLRXML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:12:11 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:35150 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLRXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:12:10 -0500
Received: by mail-wr1-f74.google.com with SMTP id f15so1525828wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XROsw98/jioxNmwaFa5qgGIGTXokTI7dQ4xiPx1pCR8=;
        b=cTTdgQH0MvqJtv3XgkF7BwJ0fhE1oQf8dNov06qeFTb90oP+3wyb92mfnHER/86ku4
         au5i8n2NYtj/JgXC5iRJLoE36b3cqdGhdGlvXnn7j6JsWwM9ref6fkAET06M3ItdqnM2
         QYZ7AE6tVQ31gYQcpTDhRCDD4mYpGhfqElSC1DxchrgjN+iPu6xsJXOvhqnlwoIh8ZWx
         fV4Yk0Y+E+T9hRWuUa4i9m4DF3s83Giyr4O6hMIzoEwOp7mlYCYBcjvlE447HQcAO7zB
         GPyORKpggMHDSSgH5SWYKiBxrVM52lKmUqegO+xJa6GWBqSKteZD38PjPGvaR/QDwu+G
         ViMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XROsw98/jioxNmwaFa5qgGIGTXokTI7dQ4xiPx1pCR8=;
        b=nWudpooBsKX9HrNExHgKaCBzXeuM1JfYNHArt2Z4HzfX01bdr0YEJJu3P8JW9cx8ig
         DxhDu+9KpH1NEtUFC5ZUCuBtLbbTJ7/C1juqr5LIXSBjbKp1itV3zrEyEMmXkFpCVT6T
         +7e8Po7CGaN5GGbHaabBX2gGjAxwcl6s9+hm1O0Pkg+ghKr4cdTJxL4yMyrH98K5pNAj
         kIwrf4zEJm7c3LeEtEkyMRkPxhio6e6f2lARg7S4Vw10q6M05XEfuzOBKhyiJk2qQ2uM
         zIX3ghhTHoYJ2XFg4J6gmn+7wnaX6Bh9a5wCJgUdhGhkgyKb0pxXyFGrSocaghdApt4W
         h3yQ==
X-Gm-Message-State: APjAAAVRTF6bzExsnzIB/f+tk9DFuqaijLEJIdr/9AnFyWPDC4lfhAV9
        1oKgKihdh6HGBBnEYQr60KBioS8Fwg==
X-Google-Smtp-Source: APXvYqxoPij0nnAS8v6D2DsSQ+4qDQ1m6ZB8u3SVZ565Xa2k6xMp3WfPH21sRHSEo0wj+iuxoSRvNvy7OQ==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr5452607wrv.197.1576710725585;
 Wed, 18 Dec 2019 15:12:05 -0800 (PST)
Date:   Thu, 19 Dec 2019 00:11:47 +0100
Message-Id: <20191218231150.12139-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v7 1/4] x86/insn-eval: Add support for 64-bit kernel mode
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support evaluating 64-bit kernel mode instructions:

Replace existing checks for user_64bit_mode() with a new helper that
checks whether code is being executed in either 64-bit kernel mode or
64-bit user mode.

Select the GS base depending on whether the instruction is being
evaluated in kernel mode.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v2-v7:
      no changes

 arch/x86/include/asm/ptrace.h | 13 +++++++++++++
 arch/x86/lib/insn-eval.c      | 26 +++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5057a8ed100b..ac45b06941a5 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -159,6 +159,19 @@ static inline bool user_64bit_mode(struct pt_regs *regs)
 #endif
 }
 
+/*
+ * Determine whether the register set came from any context that is running in
+ * 64-bit mode.
+ */
+static inline bool any_64bit_mode(struct pt_regs *regs)
+{
+#ifdef CONFIG_X86_64
+	return !user_mode(regs) || user_64bit_mode(regs);
+#else
+	return false;
+#endif
+}
+
 #ifdef CONFIG_X86_64
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 306c3a0902ba..31600d851fd8 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -155,7 +155,7 @@ static bool check_seg_overrides(struct insn *insn, int regoff)
  */
 static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 {
-	if (user_64bit_mode(regs))
+	if (any_64bit_mode(regs))
 		return INAT_SEG_REG_IGNORE;
 	/*
 	 * Resolve the default segment register as described in Section 3.7.4
@@ -266,7 +266,7 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
 	 * which may be invalid at this point.
 	 */
 	if (regoff == offsetof(struct pt_regs, ip)) {
-		if (user_64bit_mode(regs))
+		if (any_64bit_mode(regs))
 			return INAT_SEG_REG_IGNORE;
 		else
 			return INAT_SEG_REG_CS;
@@ -289,7 +289,7 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
 	 * In long mode, segment override prefixes are ignored, except for
 	 * overrides for FS and GS.
 	 */
-	if (user_64bit_mode(regs)) {
+	if (any_64bit_mode(regs)) {
 		if (idx != INAT_SEG_REG_FS &&
 		    idx != INAT_SEG_REG_GS)
 			idx = INAT_SEG_REG_IGNORE;
@@ -646,23 +646,27 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 		 */
 		return (unsigned long)(sel << 4);
 
-	if (user_64bit_mode(regs)) {
+	if (any_64bit_mode(regs)) {
 		/*
 		 * Only FS or GS will have a base address, the rest of
 		 * the segments' bases are forced to 0.
 		 */
 		unsigned long base;
 
-		if (seg_reg_idx == INAT_SEG_REG_FS)
+		if (seg_reg_idx == INAT_SEG_REG_FS) {
 			rdmsrl(MSR_FS_BASE, base);
-		else if (seg_reg_idx == INAT_SEG_REG_GS)
+		} else if (seg_reg_idx == INAT_SEG_REG_GS) {
 			/*
 			 * swapgs was called at the kernel entry point. Thus,
 			 * MSR_KERNEL_GS_BASE will have the user-space GS base.
 			 */
-			rdmsrl(MSR_KERNEL_GS_BASE, base);
-		else
+			if (user_mode(regs))
+				rdmsrl(MSR_KERNEL_GS_BASE, base);
+			else
+				rdmsrl(MSR_GS_BASE, base);
+		} else {
 			base = 0;
+		}
 		return base;
 	}
 
@@ -703,7 +707,7 @@ static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
 	if (sel < 0)
 		return 0;
 
-	if (user_64bit_mode(regs) || v8086_mode(regs))
+	if (any_64bit_mode(regs) || v8086_mode(regs))
 		return -1L;
 
 	if (!sel)
@@ -948,7 +952,7 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 	 * following instruction.
 	 */
 	if (*regoff == -EDOM) {
-		if (user_64bit_mode(regs))
+		if (any_64bit_mode(regs))
 			tmp = regs->ip + insn->length;
 		else
 			tmp = 0;
@@ -1250,7 +1254,7 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
 	 * After computed, the effective address is treated as an unsigned
 	 * quantity.
 	 */
-	if (!user_64bit_mode(regs) && ((unsigned int)eff_addr > seg_limit))
+	if (!any_64bit_mode(regs) && ((unsigned int)eff_addr > seg_limit))
 		goto out;
 
 	/*
-- 
2.24.1.735.g03f4e72817-goog

