Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA209C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98575205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mVuF5qbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfG3WTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:19:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfG3WTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:19:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMJ9xv3399847
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:19:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMJ9xv3399847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564525150;
        bh=eL+e5SoaMdtM0OEPI9mHFiwK0PstnWou0bKlFZPZJXg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mVuF5qbEf86ibP66yYF7lR3dUTyziuQeoAvEfDP8VampyjxKH0Bhpq/MIzWjs3+TO
         a4qhWDA0hBedfQ7YWTR2Sb/5qdSVnBPF7QgSbGN2/ntX1CJVABwNKiksig7jwWomZl
         bKbbqK466XB2/a5PYsLcjuABgE+ZlkkkwfUJt5qvvCIXvZDo8opnVtEKLIjvBJ/vtW
         RdmlFk0qFpbvs0gTcnRAe9eGlxdKbdq3CQUHVRTNfVWbcSkkQPfpuat8Oqf4TEC3/A
         sLZB6sevidKtngDSz6nRxSUWzJN24Uu59niUi3N0z5cx1MmchFWaEG7QbUIqqjvso8
         ucMmSM7g4G7Mw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMJ9ud3399844;
        Tue, 30 Jul 2019 15:19:09 -0700
Date:   Tue, 30 Jul 2019 15:19:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a9446a906f52292c52ecbd5be78eaa4d8395756c@git.kernel.org>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com
Reply-To: hpa@zytor.com, luto@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, vincenzo.frascino@arm.com, mingo@kernel.org
In-Reply-To: <20190728131648.587523358@linutronix.de>
References: <20190728131648.587523358@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] lib/vdso/32: Remove inconsistent NULL pointer
 checks
Git-Commit-ID: a9446a906f52292c52ecbd5be78eaa4d8395756c
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

Commit-ID:  a9446a906f52292c52ecbd5be78eaa4d8395756c
Gitweb:     https://git.kernel.org/tip/a9446a906f52292c52ecbd5be78eaa4d8395756c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 28 Jul 2019 15:12:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 31 Jul 2019 00:09:09 +0200

lib/vdso/32: Remove inconsistent NULL pointer checks

The 32bit variants of vdso_clock_gettime()/getres() have a NULL pointer
check for the timespec pointer. That's inconsistent vs. 64bit.

But the vdso implementation will never be consistent versus the syscall
because the only case which it can handle is NULL. Any other invalid
pointer will cause a segfault. So special casing NULL is not really useful.

Remove it along with the superflouos syscall fallback invocation as that
will return -EFAULT anyway. That also gets rid of the dubious typecast
which only works because the pointer is NULL.

Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20190728131648.587523358@linutronix.de

---
 lib/vdso/gettimeofday.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 2d1c1f241fd9..e28f5a607a5f 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -115,9 +115,6 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	struct __kernel_timespec ts;
 	int ret;
 
-	if (res == NULL)
-		goto fallback;
-
 	ret = __cvdso_clock_gettime(clock, &ts);
 
 	if (ret == 0) {
@@ -126,9 +123,6 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	}
 
 	return ret;
-
-fallback:
-	return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
 }
 
 static __maybe_unused int
@@ -204,10 +198,8 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 		goto fallback;
 	}
 
-	if (res) {
-		res->tv_sec = 0;
-		res->tv_nsec = ns;
-	}
+	res->tv_sec = 0;
+	res->tv_nsec = ns;
 
 	return 0;
 
@@ -221,9 +213,6 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	struct __kernel_timespec ts;
 	int ret;
 
-	if (res == NULL)
-		goto fallback;
-
 	ret = __cvdso_clock_getres(clock, &ts);
 
 	if (ret == 0) {
@@ -232,8 +221,5 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	}
 
 	return ret;
-
-fallback:
-	return clock_getres_fallback(clock, (struct __kernel_timespec *)res);
 }
 #endif /* VDSO_HAS_CLOCK_GETRES */
