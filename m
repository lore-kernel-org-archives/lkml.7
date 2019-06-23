Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18471C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE87A22CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SF5sLTvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFXBk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:40:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfFXBkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNmrjI2859061
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:48:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNmrjI2859061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333734;
        bh=5GSLaD9aeP1ooF7juF1Pn35jjes+DommM5+L6z+s0sw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SF5sLTvXXNtz8tJOn4XIZEhygkD78GjY78NAxmT7X20BvxsJAbnQKLAqLqNkfLM36
         wxbOWDagjb0Mx4RrBpxxfLajuwRpULOs3IfAUpR6CUXwNd2D+uYiPTv7/xZkeJuCd0
         rryshm1WNExbFHFomPSfT+xv7lNb1a7hhDZD+49pMQbdfE8KeCyIk+640yvnfhoN9V
         2TPCpch3GCovUZlZdxxZWWKhBOf4jlJpkrX5kMuOdLIBp9qraPvTrBE/yLIA9wNP6n
         /G5+yXc+ey2MgEw0WlEGaUm4Z/39GqrFIzZ4ApvYH3k0Gukaa9DGtEXjfMf1UlG6BU
         q4XMJjzi2Fqfw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNmrhk2859058;
        Sun, 23 Jun 2019 16:48:53 -0700
Date:   Sun, 23 Jun 2019 16:48:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-53c489e1dfeb6092b9fb14eb73c2cbcb07224798@git.kernel.org>
Cc:     huw@codeweavers.com, salyzyn@android.com, pcc@google.com,
        paul.burton@mips.com, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, tglx@linutronix.de, linux@rasmusvillemoes.dk,
        mingo@kernel.org, hpa@zytor.com, sthotton@marvell.com,
        vincenzo.frascino@arm.com, arnd@arndb.de, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, linux@armlinux.org.uk,
        ralf@linux-mips.org, will.deacon@arm.com, shuah@kernel.org,
        andre.przywara@arm.com
Reply-To: huw@codeweavers.com, salyzyn@android.com, pcc@google.com,
          paul.burton@mips.com, linux-kernel@vger.kernel.org,
          0x7f454c46@gmail.com, tglx@linutronix.de,
          linux@rasmusvillemoes.dk, mingo@kernel.org, sthotton@marvell.com,
          hpa@zytor.com, vincenzo.frascino@arm.com, arnd@arndb.de,
          catalin.marinas@arm.com, daniel.lezcano@linaro.org,
          ralf@linux-mips.org, linux@armlinux.org.uk, will.deacon@arm.com,
          shuah@kernel.org, andre.przywara@arm.com
In-Reply-To: <20190621095252.32307-7-vincenzo.frascino@arm.com>
References: <20190621095252.32307-7-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: Add missing syscall numbers
Git-Commit-ID: 53c489e1dfeb6092b9fb14eb73c2cbcb07224798
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

Commit-ID:  53c489e1dfeb6092b9fb14eb73c2cbcb07224798
Gitweb:     https://git.kernel.org/tip/53c489e1dfeb6092b9fb14eb73c2cbcb07224798
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:33 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:07 +0200

arm64: compat: Add missing syscall numbers

vDSO requires gettimeofday() and clock_gettime() syscalls to implement the
fallback mechanism.

Add the missing syscall numbers to unistd.h for arm64.

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
Link: https://lkml.kernel.org/r/20190621095252.32307-7-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/unistd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index c9f8dd421c5f..2a23614198f1 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -22,8 +22,13 @@
 #define __NR_compat_exit		1
 #define __NR_compat_read		3
 #define __NR_compat_write		4
+#define __NR_compat_gettimeofday	78
 #define __NR_compat_sigreturn		119
 #define __NR_compat_rt_sigreturn	173
+#define __NR_compat_clock_getres	247
+#define __NR_compat_clock_gettime	263
+#define __NR_compat_clock_gettime64	403
+#define __NR_compat_clock_getres_time64	406
 
 /*
  * The following SVCs are ARM private.
