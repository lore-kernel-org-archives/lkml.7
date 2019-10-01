Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9140321855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbfJAOYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:24:20 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbfJAOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:24:20 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M7KKA-1iEEjW3xoi-007mdl; Tue, 01 Oct 2019 16:23:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86: math-emu: check __copy_from_user result
Date:   Tue,  1 Oct 2019 16:23:34 +0200
Message-Id: <20191001142344.1274185-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LSi0qIo+IKbHrXfP8Pkp9zAyLXlnrJvmni8tHxKb+O/Ub6ZCq0u
 8x/rt9ECezApygTNTCiR6o6x7YXpUjif6bYeQ5IqOudSHIC8oD97FqGA9IOYh71bbgxrEd+
 X2TMh0HRObpO0nE+bsl4/SPOamlDdr0G7OtTVCkeTmi3ulMA8eRvdk/c0qfUsy3bADf2rgP
 I5GTN7GjOBv+EHIMNEpZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tHN9agYJA24=:WAnScvCNVDqWi++T8PHk1X
 hycN+9acEwOfIchp/tpSCsUeAlUFAuEpARB7kluKG3X2cUuv53W0TQjMJO0Qw1k3xHFhDJx+x
 tCLsbCl43AHerQg8+0cAYTq7fATZEjg9sQyDVnwHoQWUzAWPXDFzTr/8Sxtb6hvEo+FCB2Cgc
 8p7sHI9M0klcI1N59W/F1tQRST535LRfAqbLoRLRhrxl2dSyMI18CMYpZzHEb2by7MwWauR70
 /kbw2aWxRItCoxD3OSY7BQK1WyT4xKrcfoyxbb9CHYISghtPvFh5eBGgGzZNSFQq3wVAClymt
 dOcrY5P0ADtA5+ItxZ0c/ZA5ONiHHz3h0HiubOp8ptdE9o7hZTN/tlkYD2kDpqBG0TBcr0j/a
 Yp7jqRGmFfbjc/J1CG2asts1ZkbKjD1Zclkn8UuIJF9B6N43uGm7sLHQRkfdU7RVI8qvvfZIX
 AZPZrTlhG0KM+Ft5uwOjSlMGmhDag39DHQLUxttfhy50EbnJsO3J+MQJ7kLJ5WeYV86iEUadc
 KM+wnO8iQ9FteSg82qVAjkm+fVLP7WsS4Okctn0EJDMj4+EJfvgQZ6dRe2TPE/zoc0nvmzqno
 +dDHgY7Fb/STdRxP6K6OzTgEdqbKosgFWCa04nGEnzKash6nyGbgTvymF07BnHCvxbuXwZ56m
 EJS2SNaPyIRb3O4IzgiooEC9O0STZ3oZ7VNw+bY7sGWsfdqYhzInJDdUx7jPf04pQMWxUb1HS
 APtxdQIt8ZC8kODKowHAAjkNKhrwmNfW0yjWusY4A7BqOPn6EvdgmCzNWX5FctLPC3yh1pBJd
 LGPV5PIwH7CN4/xCaaG92ls3JzU3Pxeaa+3AOXVrW0hzkRvfuKgSLtrQoW5Xegt5Hyi7obUKs
 kBAE+4u/AtS/8IuB/kSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new __must_check annotation on __copy_from_user successfully
identified some code that has lacked the check since at least
linux-2.1.73:

arch/x86/math-emu/reg_ld_str.c:88:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
        __copy_from_user(sti_ptr, s, 10);
        ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~
arch/x86/math-emu/reg_ld_str.c:1129:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
        __copy_from_user(register_base + offset, s, other);
        ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_ld_str.c:1131:3: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
                __copy_from_user(register_base, s + other, offset);
                ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In addition, the get_user/put_user helpers do not enforce a return value
check, but actually still require one. These have been missing
for even longer.

Change the internal wrappers around get_user/put_user to force
a signal and add a corresponding wrapper around __copy_from_user
to check all such cases.

Fixes: 257e458057e5 ("Import 2.1.73")
Fixes: 9dd819a15162 ("uaccess: add missing __must_check attributes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/math-emu/fpu_system.h | 6 ++++--
 arch/x86/math-emu/reg_ld_str.c | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
index f98a0c956764..9b41391867dc 100644
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
index f3779743d15e..fe6246ff9887 100644
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
-- 
2.20.0

