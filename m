Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA395C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B450A206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfD0Pak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:30:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60952 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727165AbfD0PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-000144-Kx; Sat, 27 Apr 2019 16:15:12 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004ZV-2R; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry Vyukov" <dvyukov@google.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.989279490@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 138/202] signal: Better detection of synchronous signals
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 7146db3317c67b517258cb5e1b08af387da0618b upstream.

Recently syzkaller was able to create unkillablle processes by
creating a timer that is delivered as a thread local signal on SIGHUP,
and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop failing
to deliver SIGHUP but always trying.

When the stack overflows delivery of SIGHUP fails and force_sigsegv is
called.  Unfortunately because SIGSEGV is numerically higher than
SIGHUP next_signal tries again to deliver a SIGHUP.

=46roma quality of implementation standpoint attempting to deliver the
timer SIGHUP signal is wrong.  We should attempt to deliver the
synchronous SIGSEGV signal we just forced.

We can make that happening in a fairly straight forward manner by
instead of just looking at the signal number we also look at the
si_code.  In particular for exceptions (aka synchronous signals) the
si_code is always greater than 0.

That still has the potential to pick up a number of asynchronous
signals as in a few cases the same si_codes that are used
for synchronous signals are also used for asynchronous signals,
and SI_KERNEL is also included in the list of possible si_codes.

Still the heuristic is much better and timer signals are definitely
excluded.  Which is enough to prevent all known ways for someone
sending a process signals fast enough to cause unexpected and
arguably incorrect behavior.

Fixes: a27341cd5fcb ("Prioritize synchronous signals over 'normal' signals")
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[bwh: Backported to 3.16: s/kernel_siginfo_t/siginfo_t/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/signal.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -684,6 +684,48 @@ int dequeue_signal(struct task_struct *t
 	return signr;
 }
 
+static int dequeue_synchronous_signal(siginfo_t *info)
+{
+	struct task_struct *tsk = current;
+	struct sigpending *pending = &tsk->pending;
+	struct sigqueue *q, *sync = NULL;
+
+	/*
+	 * Might a synchronous signal be in the queue?
+	 */
+	if (!((pending->signal.sig[0] & ~tsk->blocked.sig[0]) & SYNCHRONOUS_MASK))
+		return 0;
+
+	/*
+	 * Return the first synchronous signal in the queue.
+	 */
+	list_for_each_entry(q, &pending->list, list) {
+		/* Synchronous signals have a postive si_code */
+		if ((q->info.si_code > SI_USER) &&
+		    (sigmask(q->info.si_signo) & SYNCHRONOUS_MASK)) {
+			sync = q;
+			goto next;
+		}
+	}
+	return 0;
+next:
+	/*
+	 * Check if there is another siginfo for the same signal.
+	 */
+	list_for_each_entry_continue(q, &pending->list, list) {
+		if (q->info.si_signo == sync->info.si_signo)
+			goto still_pending;
+	}
+
+	sigdelset(&pending->signal, sync->info.si_signo);
+	recalc_sigpending();
+still_pending:
+	list_del_init(&sync->list);
+	copy_siginfo(info, &sync->info);
+	__sigqueue_free(sync);
+	return info->si_signo;
+}
+
 /*
  * Tell a process that it has a new active signal..
  *
@@ -2249,7 +2291,15 @@ relock:
 			goto relock;
 		}
 
-		signr = dequeue_signal(current, &current->blocked, &ksig->info);
+		/*
+		 * Signals generated by the execution of an instruction
+		 * need to be delivered before any other pending signals
+		 * so that the instruction pointer in the signal stack
+		 * frame points to the faulting instruction.
+		 */
+		signr = dequeue_synchronous_signal(&ksig->info);
+		if (!signr)
+			signr = dequeue_signal(current, &current->blocked, &ksig->info);
 
 		if (!signr)
 			break; /* will return 0 */

