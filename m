Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38240C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F91208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfD0PYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33512 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbfD0PP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:27 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2y-0000zM-Py; Sat, 27 Apr 2019 16:15:24 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004ZQ-0e; Sat, 27 Apr 2019 16:15:12 +0100
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
Message-ID: <lsq.1556377989.76700853@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 137/202] signal: Always notice exiting tasks
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

commit 35634ffa1751b6efd8cf75010b509dcb0263e29b upstream.

Recently syzkaller was able to create unkillablle processes by
creating a timer that is delivered as a thread local signal on SIGHUP,
and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop
failing to deliver SIGHUP but always trying.

Upon examination it turns out part of the problem is actually most of
the solution.  Since 2.5 signal delivery has found all fatal signals,
marked the signal group for death, and queued SIGKILL in every threads
thread queue relying on signal->group_exit_code to preserve the
information of which was the actual fatal signal.

The conversion of all fatal signals to SIGKILL results in the
synchronous signal heuristic in next_signal kicking in and preferring
SIGHUP to SIGKILL.  Which is especially problematic as all
fatal signals have already been transformed into SIGKILL.

Instead of dequeueing signals and depending upon SIGKILL to
be the first signal dequeued, first test if the signal group
has already been marked for death.  This guarantees that
nothing in the signal queue can prevent a process that needs
to exit from exiting.

Tested-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Ref: ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/signal.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2231,6 +2231,11 @@ relock:
 		goto relock;
 	}
 
+	/* Has this task already been marked for death? */
+	ksig->info.si_signo = signr = SIGKILL;
+	if (signal_group_exit(signal))
+		goto fatal;
+
 	for (;;) {
 		struct k_sigaction *ka;
 
@@ -2326,6 +2331,7 @@ relock:
 			continue;
 		}
 
+	fatal:
 		spin_unlock_irq(&sighand->siglock);
 
 		/*

