Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084FC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79213206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfD0PXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33598 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727501AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zA-6D; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004ZB-R2; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.900369982@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 134/202] tracehook_signal_handler: Remove sig, info,
 ka and regs
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

From: Richard Weinberger <richard@nod.at>

commit df5601f9c3d831b4c478b004a1ed90a18643adbe upstream.

These parameters are nowhere used, so we can remove them.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/tracehook.h | 8 +-------
 kernel/signal.c           | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -133,10 +133,6 @@ static inline void tracehook_report_sysc
 
 /**
  * tracehook_signal_handler - signal handler setup is complete
- * @sig:		number of signal being delivered
- * @info:		siginfo_t of signal being delivered
- * @ka:			sigaction setting that chose the handler
- * @regs:		user register state
  * @stepping:		nonzero if debugger single-step or block-step in use
  *
  * Called by the arch code after a signal handler has been set up.
@@ -146,9 +142,7 @@ static inline void tracehook_report_sysc
  * Called without locks, shortly before returning to user mode
  * (or handling more signals).
  */
-static inline void tracehook_signal_handler(int sig, siginfo_t *info,
-					    const struct k_sigaction *ka,
-					    struct pt_regs *regs, int stepping)
+static inline void tracehook_signal_handler(int stepping)
 {
 	if (stepping)
 		ptrace_notify(SIGTRAP);
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2387,7 +2387,7 @@ void signal_delivered(int sig, siginfo_t
 	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&blocked, sig);
 	set_current_blocked(&blocked);
-	tracehook_signal_handler(sig, info, ka, regs, stepping);
+	tracehook_signal_handler(stepping);
 }
 
 void signal_setup_done(int failed, struct ksignal *ksig, int stepping)

