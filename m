Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44353C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23799206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfFGKb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfFGKb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:31:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B295C01F28C;
        Fri,  7 Jun 2019 10:31:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C22510A4B4D;
        Fri,  7 Jun 2019 10:31:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  7 Jun 2019 12:31:56 +0200 (CEST)
Date:   Fri, 7 Jun 2019 12:31:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Wong <e@80x24.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] aio: simplify the usage of restore_saved_sigmask_unless()
Message-ID: <20190607103154.GA22159@redhat.com>
References: <20190607103122.GA22167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607103122.GA22167@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 07 Jun 2019 10:31:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the signal_pending() check and restore_saved_sigmask_unless()
into do_io_getevents() and simplify the callers.

The only complication is that non-restartable io_getevents() and
io_getevents_time32() have to translate ERESTARTNOHAND into EINTR.
They do not need restore_saved_sigmask_unless(), but it is harmless
and WARN_ON(!TIF_SIGPENDING) will be usefule after the next patch.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/aio.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 8200f97..944eef7 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2034,6 +2034,7 @@ static long do_io_getevents(aio_context_t ctx_id,
 {
 	ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
 	struct kioctx *ioctx = lookup_ioctx(ctx_id);
+	bool interrupted;
 	long ret = -EINVAL;
 
 	if (likely(ioctx)) {
@@ -2042,6 +2043,11 @@ static long do_io_getevents(aio_context_t ctx_id,
 		percpu_ref_put(&ioctx->users);
 	}
 
+	interrupted = signal_pending(current);
+	restore_saved_sigmask_unless(interrupted);
+	if (interrupted && !ret)
+		ret = -ERESTARTNOHAND;
+
 	return ret;
 }
 
@@ -2072,7 +2078,7 @@ SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 		return -EFAULT;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-	if (!ret && signal_pending(current))
+	if (ret == -ERESTARTNOHAND)
 		ret = -EINTR;
 	return ret;
 }
@@ -2094,7 +2100,6 @@ SYSCALL_DEFINE6(io_pgetevents,
 {
 	struct __aio_sigset	ksig = { NULL, };
 	struct timespec64	ts;
-	bool interrupted;
 	int ret;
 
 	if (timeout && unlikely(get_timespec64(&ts, timeout)))
@@ -2109,11 +2114,6 @@ SYSCALL_DEFINE6(io_pgetevents,
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
 
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
 	return ret;
 }
 
@@ -2129,7 +2129,6 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
 {
 	struct __aio_sigset	ksig = { NULL, };
 	struct timespec64	ts;
-	bool interrupted;
 	int ret;
 
 	if (timeout && unlikely(get_old_timespec32(&ts, timeout)))
@@ -2145,11 +2144,6 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
 
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
 	return ret;
 }
 
@@ -2170,7 +2164,7 @@ SYSCALL_DEFINE5(io_getevents_time32, __u32, ctx_id,
 		return -EFAULT;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-	if (!ret && signal_pending(current))
+	if (ret == -ERESTARTNOHAND)
 		ret = -EINTR;
 	return ret;
 }
@@ -2196,7 +2190,6 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 {
 	struct __compat_aio_sigset ksig = { NULL, };
 	struct timespec64 t;
-	bool interrupted;
 	int ret;
 
 	if (timeout && get_old_timespec32(&t, timeout))
@@ -2211,11 +2204,6 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
 
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
 	return ret;
 }
 
@@ -2231,7 +2219,6 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 {
 	struct __compat_aio_sigset ksig = { NULL, };
 	struct timespec64 t;
-	bool interrupted;
 	int ret;
 
 	if (timeout && get_timespec64(&t, timeout))
@@ -2246,11 +2233,6 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
 
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
-		ret = -ERESTARTNOHAND;
-
 	return ret;
 }
 #endif
-- 
2.5.0


