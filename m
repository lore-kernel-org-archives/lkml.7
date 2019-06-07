Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D5D2080C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfFGKc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:32:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfFGKc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:32:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58FCC308219F;
        Fri,  7 Jun 2019 10:32:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6ACF57D512;
        Fri,  7 Jun 2019 10:32:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  7 Jun 2019 12:32:26 +0200 (CEST)
Date:   Fri, 7 Jun 2019 12:32:23 +0200
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
Subject: [PATCH 2/2] aio: fix the usage of restore_saved_sigmask_unless()
Message-ID: <20190607103223.GB22159@redhat.com>
References: <20190607103122.GA22167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607103122.GA22167@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 07 Jun 2019 10:32:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_io_getevents() is the only user of set/restore_user_sigmask which
can return success or error and deliver a signal which was temporary
unblocked by set_user_sigmask().

Change it to keep the modified sigmask (pass true to restore_unless)
only if the syscall returns ERESTARTNOHAND/EINTR. This matches all
other syscalls which modify current->blocked before wait-for-event.

Note that it doesn't even need the signal_pending() check, read_event()
wait_event_interruptible_hrtimeout() returns ERESTARTSYS if interrupted.
But it seems that read_events() needs some unrelated cleanups which
should be done first.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/aio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 944eef7..5bdbef0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2034,7 +2034,6 @@ static long do_io_getevents(aio_context_t ctx_id,
 {
 	ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
 	struct kioctx *ioctx = lookup_ioctx(ctx_id);
-	bool interrupted;
 	long ret = -EINVAL;
 
 	if (likely(ioctx)) {
@@ -2043,10 +2042,9 @@ static long do_io_getevents(aio_context_t ctx_id,
 		percpu_ref_put(&ioctx->users);
 	}
 
-	interrupted = signal_pending(current);
-	restore_saved_sigmask_unless(interrupted);
-	if (interrupted && !ret)
+	if (!ret && signal_pending(current))
 		ret = -ERESTARTNOHAND;
+	restore_saved_sigmask_unless(ret == -ERESTARTNOHAND);
 
 	return ret;
 }
-- 
2.5.0


