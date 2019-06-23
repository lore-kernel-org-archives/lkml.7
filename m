Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D33CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6612722CED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wpa6IVGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFXBlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfFXBk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNiXUx2858277
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:44:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNiXUx2858277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333474;
        bh=+Pnp97QirDw23SXvjDjC+j20gnJWLcG2oWbLeC/mHhQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Wpa6IVGrSfOIwfOzANMbaE1ZzND3X6VdpkVhUfbCgoMpbjQcmFOwIgP6fDNKD8d/7
         jIrVOIT8PEn1tIvZgHVy/I3QgvWSrVhS/oaAGEmY6/D4AaheXnIEIxoO9SAblguKNY
         3ieJaKDkYTS3TMZAwVzAUx/smPQGvh4iOKFwLlti3c6tiq4iD1oqYZA/rj6NxoHo7G
         yHPCYNi+j+Onr8H7/kfDB/b43HpGorCXq+QN06xVxGfbW4uAGBFHn+gzPjpkQ1zcvd
         CyB+JiZaBZ2CedhEMdqHLgKPbw+JnT4dVYgcgNoKe3ti/cMSuRPH35k94ZY6StWap3
         cu0B+2vkqSPig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNiWpp2858274;
        Sun, 23 Jun 2019 16:44:32 -0700
Date:   Sun, 23 Jun 2019 16:44:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-361f8aee9b093526297d567a9dc2f6cbf746e5f9@git.kernel.org>
Cc:     linux@rasmusvillemoes.dk, daniel.lezcano@linaro.org, arnd@arndb.de,
        mingo@kernel.org, tglx@linutronix.de, sthotton@marvell.com,
        andre.przywara@arm.com, ralf@linux-mips.org, will.deacon@arm.com,
        shuah@kernel.org, linux@armlinux.org.uk, vincenzo.frascino@arm.com,
        huw@codeweavers.com, salyzyn@android.com, hpa@zytor.com,
        paul.burton@mips.com, pcc@google.com, 0x7f454c46@gmail.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Reply-To: will.deacon@arm.com, ralf@linux-mips.org, andre.przywara@arm.com,
          sthotton@marvell.com, tglx@linutronix.de, mingo@kernel.org,
          arnd@arndb.de, daniel.lezcano@linaro.org,
          linux@rasmusvillemoes.dk, catalin.marinas@arm.com,
          linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
          pcc@google.com, paul.burton@mips.com, vincenzo.frascino@arm.com,
          hpa@zytor.com, salyzyn@android.com, huw@codeweavers.com,
          shuah@kernel.org, linux@armlinux.org.uk
In-Reply-To: <20190621095252.32307-2-vincenzo.frascino@arm.com>
References: <20190621095252.32307-2-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] vdso: Define standardized vdso_datapage
Git-Commit-ID: 361f8aee9b093526297d567a9dc2f6cbf746e5f9
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

Commit-ID:  361f8aee9b093526297d567a9dc2f6cbf746e5f9
Gitweb:     https://git.kernel.org/tip/361f8aee9b093526297d567a9dc2f6cbf746e5f9
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:28 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:05 +0200

vdso: Define standardized vdso_datapage

Define a common formet for the vdso datapage as a preparation for sharing
the VDSO implementation as a generic library.

The datastructures are based on the current x86 layout.

[ tglx: Massaged changelog ]

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
Link: https://lkml.kernel.org/r/20190621095252.32307-2-vincenzo.frascino@arm.com

---
 include/vdso/datapage.h | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
new file mode 100644
index 000000000000..e6eb36c3d54f
--- /dev/null
+++ b/include/vdso/datapage.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bits.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define VDSO_BASES	(CLOCK_TAI + 1)
+#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
+			 BIT(CLOCK_MONOTONIC)		| \
+			 BIT(CLOCK_BOOTTIME)		| \
+			 BIT(CLOCK_TAI))
+#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
+			 BIT(CLOCK_MONOTONIC_COARSE))
+#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
+
+#define CS_HRES_COARSE	0
+#define CS_RAW		1
+#define CS_BASES	(CS_RAW + 1)
+
+/**
+ * struct vdso_timestamp - basetime per clock_id
+ * @sec:	seconds
+ * @nsec:	nanoseconds
+ *
+ * There is one vdso_timestamp object in vvar for each vDSO-accelerated
+ * clock_id. For high-resolution clocks, this encodes the time
+ * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * the actual time.
+ *
+ * To be noticed that for highres clocks nsec is left-shifted by
+ * vdso_data.cs[x].shift.
+ */
+struct vdso_timestamp {
+	u64	sec;
+	u64	nsec;
+};
+
+/**
+ * struct vdso_data - vdso datapage representation
+ * @seq:		timebase sequence counter
+ * @clock_mode:		clock mode
+ * @cycle_last:		timebase at clocksource init
+ * @mask:		clocksource mask
+ * @mult:		clocksource multiplier
+ * @shift:		clocksource shift
+ * @basetime[clock_id]:	basetime per clock_id
+ * @tz_minuteswest:	minutes west of Greenwich
+ * @tz_dsttime:		type of DST correction
+ * @hrtimer_res:	hrtimer resolution
+ * @__unused:		unused
+ *
+ * vdso_data will be accessed by 64 bit and compat code at the same time
+ * so we should be careful before modifying this structure.
+ */
+struct vdso_data {
+	u32			seq;
+
+	s32			clock_mode;
+	u64			cycle_last;
+	u64			mask;
+	u32			mult;
+	u32			shift;
+
+	struct vdso_timestamp	basetime[VDSO_BASES];
+
+	s32			tz_minuteswest;
+	s32			tz_dsttime;
+	u32			hrtimer_res;
+	u32			__unused;
+};
+
+/*
+ * We use the hidden visibility to prevent the compiler from generating a GOT
+ * relocation. Not only is going through a GOT useless (the entry couldn't and
+ * must not be overridden by another library), it does not even work: the linker
+ * cannot generate an absolute address to the data page.
+ *
+ * With the hidden visibility, the compiler simply generates a PC-relative
+ * relocation, and this is what we need.
+ */
+extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_DATAPAGE_H */
