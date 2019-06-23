Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC319C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B509822CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="urFKSKjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFXBmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:42:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfFXBk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNoMfH2859239
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:50:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNoMfH2859239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333823;
        bh=UwzS8YFFJZyt/k85LgC78YnO8D2+HRtyxQ0RIzbovew=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=urFKSKjIh0B8p4dYffIhFtLANKq1GHVQBLs54SpRQMgB6MIOmDiW7VDPTzbHTwYD9
         dM5pfx9zG+dRZJW0ZN59tQiQq+3WxOYyOdxisWBoONvMNXHBZkiuY8fEes0X3EyJ9d
         8+jNnT74tUyhxAfpoceM6SVDXojf2dUt4+BMUIK0zSh3yQMFCkSQxK6/Xvt85jqQ7t
         PkQvMqtgoqeWSq0LLy9pSrD86tCpWRdsu3mfGD6BAq8lX07LYjQP0EEDTEIUPuah8m
         GvREYHHaMd893sGIVN9JQsnDNCpH6f1q3+nnNdKFswwy6wobEYJYN/06KaBenR+3nd
         ewzGCevpi6TCw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNoL7h2859236;
        Sun, 23 Jun 2019 16:50:21 -0700
Date:   Sun, 23 Jun 2019 16:50:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-f14d8025d263f3c8236775df724a7c1f14e0dc94@git.kernel.org>
Cc:     mingo@kernel.org, arnd@arndb.de, salyzyn@android.com,
        vincenzo.frascino@arm.com, paul.burton@mips.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, pcc@google.com,
        huw@codeweavers.com, ralf@linux-mips.org, andre.przywara@arm.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        sthotton@marvell.com, 0x7f454c46@gmail.com, will.deacon@arm.com,
        hpa@zytor.com, daniel.lezcano@linaro.org, linux@rasmusvillemoes.dk,
        shuah@kernel.org
Reply-To: arnd@arndb.de, salyzyn@android.com, mingo@kernel.org,
          paul.burton@mips.com, vincenzo.frascino@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, pcc@google.com,
          huw@codeweavers.com, linux@armlinux.org.uk,
          andre.przywara@arm.com, ralf@linux-mips.org,
          0x7f454c46@gmail.com, sthotton@marvell.com,
          catalin.marinas@arm.com, daniel.lezcano@linaro.org,
          will.deacon@arm.com, hpa@zytor.com, shuah@kernel.org,
          linux@rasmusvillemoes.dk
In-Reply-To: <20190621095252.32307-9-vincenzo.frascino@arm.com>
References: <20190621095252.32307-9-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: Generate asm offsets for signals
Git-Commit-ID: f14d8025d263f3c8236775df724a7c1f14e0dc94
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

Commit-ID:  f14d8025d263f3c8236775df724a7c1f14e0dc94
Gitweb:     https://git.kernel.org/tip/f14d8025d263f3c8236775df724a7c1f14e0dc94
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:35 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:07 +0200

arm64: compat: Generate asm offsets for signals

Update asm-offsets for arm64 to generate the correct offsets for
compat signals.

They will be useful for the implementation of the compat sigreturn
trampolines in vDSO context.

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
Link: https://lkml.kernel.org/r/20190621095252.32307-9-vincenzo.frascino@arm.com

---
 arch/arm64/kernel/asm-offsets.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 14c99b7a0c0e..e6f7409a78a4 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -19,6 +19,7 @@
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
+#include <asm/signal32.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <linux/kbuild.h>
@@ -66,6 +67,11 @@ int main(void)
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_COMPAT
+  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		offsetof(struct compat_sigframe, uc.uc_mcontext.arm_r0));
+  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_rt_sigframe, sig.uc.uc_mcontext.arm_r0));
+  BLANK();
+#endif
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
