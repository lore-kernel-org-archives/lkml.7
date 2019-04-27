Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE52C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEED206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfD0PZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:25:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33348 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbfD0PPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:25 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-0000zA-Ta; Sat, 27 Apr 2019 16:15:22 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004bB-Ln; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Ivan Delalande" <colona@arista.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.384011412@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 155/202] signal: Restore the stop PTRACE_EVENT_EXIT
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

commit cf43a757fd49442bc38f76088b70c2299eed2c2f upstream.

In the middle of do_exit() there is there is a call
"ptrace_event(PTRACE_EVENT_EXIT, code);" That call places the process
in TACKED_TRACED aka "(TASK_WAKEKILL | __TASK_TRACED)" and waits for
for the debugger to release the task or SIGKILL to be delivered.

Skipping past dequeue_signal when we know a fatal signal has already
been delivered resulted in SIGKILL remaining pending and
TIF_SIGPENDING remaining set.  This in turn caused the
scheduler to not sleep in PTACE_EVENT_EXIT as it figured
a fatal signal was pending.  This also caused ptrace_freeze_traced
in ptrace_check_attach to fail because it left a per thread
SIGKILL pending which is what fatal_signal_pending tests for.

This difference in signal state caused strace to report
strace: Exit of unknown pid NNNNN ignored

Therefore update the signal handling state like dequeue_signal
would when removing a per thread SIGKILL, by removing SIGKILL
from the per thread signal mask and clearing TIF_SIGPENDING.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Ivan Delalande <colona@arista.com>
Fixes: 35634ffa1751 ("signal: Always notice exiting tasks")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/signal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2274,9 +2274,12 @@ relock:
 	}
 
 	/* Has this task already been marked for death? */
-	ksig->info.si_signo = signr = SIGKILL;
-	if (signal_group_exit(signal))
+	if (signal_group_exit(signal)) {
+		ksig->info.si_signo = signr = SIGKILL;
+		sigdelset(&current->pending.signal, SIGKILL);
+		recalc_sigpending();
 		goto fatal;
+	}
 
 	for (;;) {
 		struct k_sigaction *ka;

