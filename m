Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EFBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7878E21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfJCJeD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:34:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfJCJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:34:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFxUa-0003BR-Oa; Thu, 03 Oct 2019 11:33:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6AAF01C0740;
        Thu,  3 Oct 2019 11:33:48 +0200 (CEST)
Date:   Thu, 03 Oct 2019 09:33:48 -0000
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/math-emu: Check __copy_from_user() result
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191001142344.1274185-1-arnd@arndb.de>
References: <20191001142344.1274185-1-arnd@arndb.de>
MIME-Version: 1.0
Message-ID: <157009522838.9978.6698411788206711401.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e6b44ce1925a8329a937c57f0d60ba0d9bb5d226
Gitweb:        https://git.kernel.org/tip/e6b44ce1925a8329a937c57f0d60ba0d9bb5d226
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 01 Oct 2019 16:23:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Oct 2019 10:51:08 +02:00

x86/math-emu: Check __copy_from_user() result

The new __must_check annotation on __copy_from_user() successfully
identified some code that has lacked the check since at least
linux-2.1.73:

  arch/x86/math-emu/reg_ld_str.c:88:2: error: ignoring return value of \
  function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
          __copy_from_user(sti_ptr, s, 10);
          ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~
  arch/x86/math-emu/reg_ld_str.c:1129:2: error: ignoring return value of \
  function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
          __copy_from_user(register_base + offset, s, other);
          ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/x86/math-emu/reg_ld_str.c:1131:3: error: ignoring return value of \
  function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
                  __copy_from_user(register_base, s + other, offset);
                ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In addition, the get_user()/put_user() helpers do not enforce a return
value check, but actually still require one. These have been missing for
even longer.

Change the internal wrappers around get_user()/put_user() to force
a signal and add a corresponding wrapper around __copy_from_user()
to check all such cases.

 [ bp: Break long lines. ]

Fixes: 257e458057e5 ("Import 2.1.73")
Fixes: 9dd819a15162 ("uaccess: add missing __must_check attributes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bill Metzenthen <billm@melbpc.org.au>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191001142344.1274185-1-arnd@arndb.de
---
 arch/x86/math-emu/fpu_system.h | 6 ++++--
 arch/x86/math-emu/reg_ld_str.c | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
index f98a0c9..9b41391 100644
--- a/arch/x86/math-emu/fpu_system.h
+++ b/arch/x86/math-emu/fpu_system.h
@@ -107,6 +107,8 @@ static inline bool seg_writable(struct desc_struct *d)
 #define FPU_access_ok(y,z)	if ( !access_ok(y,z) ) \
 				math_abort(FPU_info,SIGSEGV)
 #define FPU_abort		math_abort(FPU_info, SIGSEGV)
+#define FPU_copy_from_user(to, from, n)	\
+		do { if (copy_from_user(to, from, n)) FPU_abort; } while (0)
 
 #undef FPU_IGNORE_CODE_SEGV
 #ifdef FPU_IGNORE_CODE_SEGV
@@ -122,7 +124,7 @@ static inline bool seg_writable(struct desc_struct *d)
 #define	FPU_code_access_ok(z) FPU_access_ok((void __user *)FPU_EIP,z)
 #endif
 
-#define FPU_get_user(x,y)       get_user((x),(y))
-#define FPU_put_user(x,y)       put_user((x),(y))
+#define FPU_get_user(x,y) do { if (get_user((x),(y))) FPU_abort; } while (0)
+#define FPU_put_user(x,y) do { if (put_user((x),(y))) FPU_abort; } while (0)
 
 #endif
diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
index f377974..fe6246f 100644
--- a/arch/x86/math-emu/reg_ld_str.c
+++ b/arch/x86/math-emu/reg_ld_str.c
@@ -85,7 +85,7 @@ int FPU_load_extended(long double __user *s, int stnr)
 
 	RE_ENTRANT_CHECK_OFF;
 	FPU_access_ok(s, 10);
-	__copy_from_user(sti_ptr, s, 10);
+	FPU_copy_from_user(sti_ptr, s, 10);
 	RE_ENTRANT_CHECK_ON;
 
 	return FPU_tagof(sti_ptr);
@@ -1126,9 +1126,9 @@ void frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
 	/* Copy all registers in stack order. */
 	RE_ENTRANT_CHECK_OFF;
 	FPU_access_ok(s, 80);
-	__copy_from_user(register_base + offset, s, other);
+	FPU_copy_from_user(register_base + offset, s, other);
 	if (offset)
-		__copy_from_user(register_base, s + other, offset);
+		FPU_copy_from_user(register_base, s + other, offset);
 	RE_ENTRANT_CHECK_ON;
 
 	for (i = 0; i < 8; i++) {
