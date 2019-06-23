Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6847622DA7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x2RdswGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfFXBlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfFXBk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNrsq72859764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:53:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNrsq72859764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334036;
        bh=LUevjWnxulWmyQspA1Jq/kxZST/G4AGPNALMYRoAZXo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=x2RdswGXZX5lL4IIy8hAgUUZVwDgJHbXlsl1CfWHavmITTUnFuPs0RvDFLQtEPi3A
         HGz9vUFYMaouLloGcBY90WxAwsuHWodr6QGNNwzbIuqqiRYyEI/njk6yS/L8QdWIk+
         h9fHtXUrAz8JJ+IwRbB5buIs1N/vFRgmzXYxHu9x5GCNA6EfEbAd0xGSoMQNF6nDaM
         jbjDfGC7p0KrYbnDYGwVIfSzZY7qF+G3J+Om0rdc3zm5212Bwo1U7gX3ezJw4BspwM
         YzTG1OCMmN/UeplOsBs2Ihf3J8YuI3+dbe8RX8PGclm8+DZuZUaCpQoNcuG+xVvW3G
         P/Tnjpu3AF/HQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNrs1J2859761;
        Sun, 23 Jun 2019 16:53:54 -0700
Date:   Sun, 23 Jun 2019 16:53:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-f01703b3d2e6faf7233cedf78f1e2d31b39fa90f@git.kernel.org>
Cc:     sthotton@marvell.com, hpa@zytor.com, tglx@linutronix.de,
        andre.przywara@arm.com, 0x7f454c46@gmail.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, pcc@google.com, paul.burton@mips.com,
        mingo@kernel.org, shuah@kernel.org, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, salyzyn@android.com,
        huw@codeweavers.com, vincenzo.frascino@arm.com,
        ralf@linux-mips.org, linux@armlinux.org.uk
Reply-To: arnd@arndb.de, linux@rasmusvillemoes.dk,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          sthotton@marvell.com, hpa@zytor.com, 0x7f454c46@gmail.com,
          andre.przywara@arm.com, paul.burton@mips.com,
          will.deacon@arm.com, pcc@google.com, daniel.lezcano@linaro.org,
          salyzyn@android.com, mingo@kernel.org, shuah@kernel.org,
          catalin.marinas@arm.com, ralf@linux-mips.org,
          linux@armlinux.org.uk, vincenzo.frascino@arm.com,
          huw@codeweavers.com
In-Reply-To: <20190621095252.32307-15-vincenzo.frascino@arm.com>
References: <20190621095252.32307-15-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: Get sigreturn trampolines from
 vDSO
Git-Commit-ID: f01703b3d2e6faf7233cedf78f1e2d31b39fa90f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f01703b3d2e6faf7233cedf78f1e2d31b39fa90f
Gitweb:     https://git.kernel.org/tip/f01703b3d2e6faf7233cedf78f1e2d31b39fa90f
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:41 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:09 +0200

arm64: compat: Get sigreturn trampolines from vDSO

When the compat vDSO is enabled, the sigreturn trampolines are not
anymore available through [sigpage] but through [vdso].

Add the relevant code the enable the feature.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Link: https://lkml.kernel.org/r/20190621095252.32307-15-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/vdso.h |  3 +++
 arch/arm64/kernel/signal32.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 1f94ec19903c..9c15e0a06301 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -17,6 +17,9 @@
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_COMPAT_VDSO
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 8a9a5ceb63b7..12a585386c2f 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -18,6 +18,7 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -341,6 +342,30 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_COMPAT_VDSO
+		void *vdso_base = current->mm->context.vdso;
+		void *vdso_trampoline;
+
+		if (ka->sa.sa_flags & SA_SIGINFO) {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_arm);
+			}
+		} else {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_arm);
+			}
+		}
+
+		retcode = ptr_to_compat(vdso_trampoline) + thumb;
+#else
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
@@ -348,6 +373,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 		retcode = (unsigned long)current->mm->context.vdso +
 			  (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
