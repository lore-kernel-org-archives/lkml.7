Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9BAC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD1520863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="wZXidubZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfCBXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:07:41 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:42846 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBXHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:07:39 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465:0:5054:ff:fe4f:85bd])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id CD0315C0086;
        Sun,  3 Mar 2019 00:07:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551568056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=DFt2kZHnj0NjV7f4nRSfqhXB8i9yVn0VsTHIdlAvBNw=;
        b=wZXidubZ0WNTMII8zWEizaC8kqKKWFG3Y3KvvQFRHhYEg+U2Ft0HY5Rb3XLW806S8mvVf/
        O+jsdV4AS2trY/K4mJ1VqGkD0wwXpmYBv+/Gry9D8jU33capxMntlvgGEEMUkNHycc7k7j
        WpIzwAPymhQKK14ifUr2EC/YQMm0elA=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] ARM: add TUSERCOND() macro for conditional postfix
Date:   Sun,  3 Mar 2019 00:08:18 +0100
Message-Id: <1ed0a317c3e9ae1cdd1b05fad5e1bd13a58a9036.1551567941.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified assembly syntax requires conditionals to be postfixes.
TUSER() currently only takes a single argument which then gets
appended t (with translation) on every instruction.

This fixes a build error when using LLVM's integrated assembler:
  In file included from kernel/futex.c:72:
  ./arch/arm/include/asm/futex.h:116:3: error: invalid instruction, did you mean: strt?
          "2:     " TUSER(streq) "        %3, [%4]\n"
           ^
  <inline asm>:5:4: note: instantiated into assembly here
  2:      streqt  r2, [r4]
          ^~~~~~

Additionally, for GCC ".syntax unified" for inline assembly.
When compiling non-Thumb2 GCC always emits a ".syntax divided"
at the beginning of the inline assembly which makes the
assembler fail. Since GCC 5 there is the -masm-syntax-unified
GCC option which make GCC assume unified syntax asm and hence
emits ".syntax unified" even in ARM mode. However, the option
is broken since GCC version 6 (see GCC PR88648 [1]). Work
around by adding ".syntax unified" as part of the inline
assembly.

[0] https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html#index-masm-syntax-unified
[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/include/asm/domain.h | 6 ++++--
 arch/arm/include/asm/futex.h  | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 99d9f630d6b6..1888c2d15da5 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -133,9 +133,11 @@ static inline void modify_domain(unsigned dom, unsigned type)	{ }
  * instructions (inline assembly)
  */
 #ifdef CONFIG_CPU_USE_DOMAINS
-#define TUSER(instr)	#instr "t"
+#define TUSER(instr)		TUSERCOND(instr, )
+#define TUSERCOND(instr, cond)	#instr "t" #cond
 #else
-#define TUSER(instr)	#instr
+#define TUSER(instr)		TUSERCOND(instr, )
+#define TUSERCOND(instr, cond)	#instr #cond
 #endif
 
 #else /* __ASSEMBLY__ */
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 0a46676b4245..83c391b597d4 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -110,10 +110,11 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	preempt_disable();
 	__ua_flags = uaccess_save_and_enable();
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
+	"	.syntax unified\n"
 	"1:	" TUSER(ldr) "	%1, [%4]\n"
 	"	teq	%1, %2\n"
 	"	it	eq	@ explicit IT needed for the 2b label\n"
-	"2:	" TUSER(streq) "	%3, [%4]\n"
+	"2:	" TUSERCOND(str, eq) "	%3, [%4]\n"
 	__futex_atomic_ex_table("%5")
 	: "+r" (ret), "=&r" (val)
 	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
-- 
2.20.1

