Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120E5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC26E2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfHUTbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:31:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbfHUTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:10 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WK3-0004GE-2J; Wed, 21 Aug 2019 21:31:07 +0200
Message-Id: <20190821192922.185511287@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [patch V2 31/38] rlimit: Rewrite non-sensical RLIMIT_CPU comment
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above the function which arms RLIMIT_CPU in the posix CPU timer
code makes no sense at all. It claims that the kernel does not return an
error code when it rejected the attempt to set RLIMIT_CPU. That's clearly
bogus as the code does an error check and the rlimit is only set and
activated when the permission checks are ok. In case of a rejection an
appropriate error code is returned.

This is a historical and outdated comment which got dragged along even when
the rlimit handling code was rewritten.

Replace it with an explanation why the setup function is not called when
the rlimit value is RLIM_INFINITY and how the 'disarming' is handled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
---
 kernel/sys.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1576,10 +1576,9 @@ int do_prlimit(struct task_struct *tsk,
 	task_unlock(tsk->group_leader);
 
 	/*
-	 * RLIMIT_CPU handling.   Note that the kernel fails to return an error
-	 * code if it rejected the user's attempt to set RLIMIT_CPU.  This is a
-	 * very long-standing error, and fixing it now risks breakage of
-	 * applications, so we live with it
+	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not
+	 * infite. In case of RLIM_INFINITY the posix CPU timer code
+	 * ignores the rlimit.
 	 */
 	 if (!retval && new_rlim && resource == RLIMIT_CPU &&
 	     new_rlim->rlim_cur != RLIM_INFINITY &&


