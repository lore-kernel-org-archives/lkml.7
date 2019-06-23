Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53522CED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nTnouY0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFXBlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFXBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNjw2h2858617
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:45:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNjw2h2858617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333559;
        bh=r4W4TohRNurjR5gRYN5XPGJVpT4vP8bgvA34JPDprNw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nTnouY0iJNHSarTZG19K2A9JyBZopbIQ4NnOu+yTmMhK6Nut5tNTpiU7f+tka73h8
         6H9yq5zyNwNoqkDVNsDNDQIk0qov2P6ohhCdDGRq/rERO/CqaFrE6Zt622Bwrko9T1
         rrcFuYq4wfnr7Helfat1v3eeiMHTRzgkpcStIe72+tZ3ccOu19LTZxfNtZQDjwnKCZ
         6tfRzws+z7PTeTKAIr2zt4ZCgUPq7XRqha+43EZsxmtqacEbDGJorundUF4it84IUj
         qNIEf/Sw8HY21UrLBZbsU58MqMPpEBA4/i9fFPEkW3ac4LOqlx87f9d4TMWdUiDGip
         wzZJ1bCQMNTHA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNjvvR2858614;
        Sun, 23 Jun 2019 16:45:57 -0700
Date:   Sun, 23 Jun 2019 16:45:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-629fdf77ac4584b73bf3a7a07f5fc5ab0d27afdc@git.kernel.org>
Cc:     linux@rasmusvillemoes.dk, 0x7f454c46@gmail.com,
        paul.burton@mips.com, vincenzo.frascino@arm.com,
        tglx@linutronix.de, huw@codeweavers.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, arnd@arndb.de, shuah@kernel.org,
        salyzyn@android.com, linux@armlinux.org.uk, sthotton@marvell.com,
        hpa@zytor.com, andre.przywara@arm.com, catalin.marinas@arm.com,
        pcc@google.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Reply-To: tglx@linutronix.de, vincenzo.frascino@arm.com,
          paul.burton@mips.com, 0x7f454c46@gmail.com,
          linux@rasmusvillemoes.dk, arnd@arndb.de, shuah@kernel.org,
          will.deacon@arm.com, daniel.lezcano@linaro.org,
          huw@codeweavers.com, hpa@zytor.com, sthotton@marvell.com,
          linux@armlinux.org.uk, salyzyn@android.com, ralf@linux-mips.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          catalin.marinas@arm.com, pcc@google.com, andre.przywara@arm.com
In-Reply-To: <20190621095252.32307-10-vincenzo.frascino@arm.com>
References: <20190621095252.32307-10-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] lib/vdso: Add compat support
Git-Commit-ID: 629fdf77ac4584b73bf3a7a07f5fc5ab0d27afdc
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

Commit-ID:  629fdf77ac4584b73bf3a7a07f5fc5ab0d27afdc
Gitweb:     https://git.kernel.org/tip/629fdf77ac4584b73bf3a7a07f5fc5ab0d27afdc
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:36 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:05 +0200

lib/vdso: Add compat support

Some 64 bit architectures have support for 32 bit applications that
require a separate version of the vDSOs.

Add support to the generic code for compat fallback functions.

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
Link: https://lkml.kernel.org/r/20190621095252.32307-10-vincenzo.frascino@arm.com

---
 lib/vdso/gettimeofday.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 767d3a0bcb06..ef28cc5d7bff 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -20,7 +20,11 @@
  * - clock_gettime_fallback(): fallback for clock_gettime.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
 #include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
 
 static int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
