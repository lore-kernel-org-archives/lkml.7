Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5F6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E121022CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfH1KRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46483 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfH1KQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0K-0000La-SF; Wed, 28 Aug 2019 12:16:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1719A1C0DE5;
        Wed, 28 Aug 2019 12:16:33 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:32 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rlimit: Rewrite non-sensical RLIMIT_CPU comment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.185511287@linutronix.de>
References: <20190821192922.185511287@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739298.5780.9875919416300087726.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     24db4dd90dd53ad6e3331b6f01cb985e466cface
Gitweb:        https://git.kernel.org/tip/24db4dd90dd53ad6e3331b6f01cb985e466cface
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:40 +02:00

rlimit: Rewrite non-sensical RLIMIT_CPU comment

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192922.185511287@linutronix.de

---
 kernel/sys.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304..c578b75 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1576,10 +1576,9 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
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
