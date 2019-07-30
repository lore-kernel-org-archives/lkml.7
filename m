Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08624C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D839E20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfG3Ji5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:38:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56227 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfG3Ji4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:38:56 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsOap-0003lj-AF; Tue, 30 Jul 2019 11:38:51 +0200
Date:   Tue, 30 Jul 2019 11:38:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: [patch V2 3/5] lib/vdso/32: Provide legacy syscall fallbacks
In-Reply-To: <20190729144831.GA21120@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
References: <20190728131251.622415456@linutronix.de> <20190728131648.786513965@linutronix.de> <20190729144831.GA21120@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address the regression which causes seccomp to deny applications the
access to clock_gettime64() and clock_getres64() syscalls because they
are not enabled in the existing filters.

That trips over the fact that 32bit VDSOs use the new clock_gettime64() and
clock_getres64() syscalls in the fallback path.

Add a conditional to invoke the 32bit legacy fallback syscalls instead of
the new 64bit variants. The conditional can go away once all architectures
are converted.

Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Move the #ifdef into the fallback function
---
 lib/vdso/gettimeofday.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -125,14 +125,18 @@ static __maybe_unused int
 
 	ret = __cvdso_clock_gettime_common(clock, &ts);
 
+#ifdef VDSO_HAS_32BIT_FALLBACK
+	if (unlikely(ret))
+		return clock_gettime32_fallback(clock, res);
+#else
 	if (unlikely(ret))
 		ret = clock_gettime_fallback(clock, &ts);
+#endif
 
 	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
-
 	return ret;
 }
 
@@ -232,8 +236,14 @@ static __maybe_unused int
 	int ret;
 
 	ret = __cvdso_clock_getres_common(clock, &ts);
+
+#ifdef VDSO_HAS_32BIT_FALLBACK
+	if (unlikely(ret))
+		return clock_getres32_fallback(clock, res);
+#else
 	if (unlikely(ret))
 		ret = clock_getres_fallback(clock, &ts);
+#endif
 
 	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
