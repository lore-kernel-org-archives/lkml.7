Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5FC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA28F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p2FloagV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfG3WUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:20:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfG3WUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:20:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMKdPE3399978
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:20:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMKdPE3399978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564525240;
        bh=0AWJICeI4PbNjv8pSuF32JmgoQZJ5aMSzFDsHN1eeGU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p2FloagVuYifRP0sZ6P7UbFPAJIL6wQVocw3Hp88jpTwvLIihfHkS1RHAkyf/kogQ
         jIyhJA8V1UrVFi4LQvYjYfAMJqqcdbF8ce6LMvH/mGXeJMskCFXQiNZOb2HjNQdAMI
         eC+9Kbj3cO3m12c8DIAwaJbg+SajSvu2WK+MSov3eSYvE3YYztXn41Vf/tl6KNJVGU
         FPi+FOH+sGkPjjadTGYs3jiXLQDYkXA2J0ce4+994KMkmh1kXSvSWxNOj3sn9S9i3+
         dw+9Rp05OrnikkCltcgIUKwxdecOAo3UyAmjv7jEEa9sP+VibfvBjZliExUYmctV32
         zSghY7nb/5Nuw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMKcZd3399974;
        Tue, 30 Jul 2019 15:20:38 -0700
Date:   Tue, 30 Jul 2019 15:20:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c60a32ea4f459f99b98d383cad3b1ac7cfb3f4be@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, sean.j.christopherson@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] lib/vdso/32: Provide legacy syscall fallbacks
Git-Commit-ID: c60a32ea4f459f99b98d383cad3b1ac7cfb3f4be
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

Commit-ID:  c60a32ea4f459f99b98d383cad3b1ac7cfb3f4be
Gitweb:     https://git.kernel.org/tip/c60a32ea4f459f99b98d383cad3b1ac7cfb3f4be
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 30 Jul 2019 11:38:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 31 Jul 2019 00:09:09 +0200

lib/vdso/32: Provide legacy syscall fallbacks

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
Tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de

---
 lib/vdso/gettimeofday.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a9e7fd029593..e630e7ff57f1 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -125,14 +125,18 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 
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
 
@@ -232,8 +236,14 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
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
