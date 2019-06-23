Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4753DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3BE22CED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EmN3irit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFXBlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfFXBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNhbLv2856611
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:43:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNhbLv2856611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333419;
        bh=Zya2uyCCLGkqpLnHRxNkZNm9EbFu0GD0WvoO1K2KFO8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EmN3iritynRXUl33zPhXgJjAsERLAvF4CDkq3CvIlq4owKEZ3Kufvk4WZCXUlvGFH
         0qp9jXW2BWsQwXS3NUwiSUzTs9+VfSTuIuWPqYuKR9IJ0WOfrKfI8RKiG+RBXVL8Ac
         uZRQ+dIFd1kDAtuoUApsJ67kxU/J7teU1XmfA/GxxZbc6o5MPpaxknjToA/kbXt0iq
         mHjVR2p++ujh897PE46NR80nKBI6zYk7eiEdKPZmGaGw773+7dni1VxhJOxM5XJ5RJ
         MkTX6vcumI5hSEginD8MI7xelTXe27lC8cU16MNAQTN1DQ1TC6TlggfTIyxDH8Vx8j
         Q0V73DBQGbwnA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNhWC12856606;
        Sun, 23 Jun 2019 16:43:32 -0700
Date:   Sun, 23 Jun 2019 16:43:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-32e29396f00e7849ea0b1aeebae097fc1de6e979@git.kernel.org>
Cc:     salyzyn@android.com, ralf@linux-mips.org, 0x7f454c46@gmail.com,
        hpa@zytor.com, daniel.lezcano@linaro.org, linux@rasmusvillemoes.dk,
        sthotton@marvell.com, paul.burton@mips.com, huw@codeweavers.com,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, pcc@google.com,
        arnd@arndb.de, linux@armlinux.org.uk, andre.przywara@arm.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: huw@codeweavers.com, tglx@linutronix.de, hpa@zytor.com,
          0x7f454c46@gmail.com, salyzyn@android.com, ralf@linux-mips.org,
          sthotton@marvell.com, paul.burton@mips.com,
          linux@rasmusvillemoes.dk, daniel.lezcano@linaro.org,
          linux-kernel@vger.kernel.org, shuah@kernel.org,
          andre.przywara@arm.com, mingo@kernel.org, will.deacon@arm.com,
          catalin.marinas@arm.com, vincenzo.frascino@arm.com,
          linux@armlinux.org.uk, arnd@arndb.de, pcc@google.com
In-Reply-To: <20190621095252.32307-3-vincenzo.frascino@arm.com>
References: <20190621095252.32307-3-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] hrtimer: Split out hrtimer defines into separate
 header
Git-Commit-ID: 32e29396f00e7849ea0b1aeebae097fc1de6e979
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

Commit-ID:  32e29396f00e7849ea0b1aeebae097fc1de6e979
Gitweb:     https://git.kernel.org/tip/32e29396f00e7849ea0b1aeebae097fc1de6e979
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Sat, 22 Jun 2019 15:02:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:04 +0200

hrtimer: Split out hrtimer defines into separate header

To avoid include dependency hell split out the hrtimer defines which are
required in the upcoming VDSO library into a separate header file.

[ tglx: Split out from the VDSO library patch and included ktime.h as
        the new header depends on it. ]

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
Link: https://lkml.kernel.org/r/20190621095252.32307-3-vincenzo.frascino@arm.com
---
 include/linux/hrtimer.h      | 16 +---------------
 include/linux/hrtimer_defs.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957eac4d4..4971100a8cab 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -12,8 +12,8 @@
 #ifndef _LINUX_HRTIMER_H
 #define _LINUX_HRTIMER_H
 
+#include <linux/hrtimer_defs.h>
 #include <linux/rbtree.h>
-#include <linux/ktime.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/percpu.h>
@@ -298,26 +298,12 @@ struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
 
-/*
- * The resolution of the clocks. The resolution value is returned in
- * the clock_getres() system call to give application programmers an
- * idea of the (in)accuracy of timers. Timer values are rounded up to
- * this resolution values.
- */
-# define HIGH_RES_NSEC		1
-# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
-# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
-
 extern void clock_was_set_delayed(void);
 
 extern unsigned int hrtimer_resolution;
 
 #else
 
-# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
-
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
 static inline void clock_was_set_delayed(void) { }
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
new file mode 100644
index 000000000000..2d3e3c5fb946
--- /dev/null
+++ b/include/linux/hrtimer_defs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HRTIMER_DEFS_H
+#define _LINUX_HRTIMER_DEFS_H
+
+#include <linux/ktime.h>
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+# define HIGH_RES_NSEC		1
+# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
+# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
+
+#else
+
+# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
+
+#endif
+
+#endif
