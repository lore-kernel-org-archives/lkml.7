Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C81CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJaLzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55449 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfJaLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92t-000355-GZ; Thu, 31 Oct 2019 12:55:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1E9A81C06B2;
        Thu, 31 Oct 2019 12:55:07 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:06 -0000
From:   "tip-bot2 for Alan Stern" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model: Fix data race detection for
 unordered store and load
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290681.29376.3038680166687118243.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     daebf24a8e8c6064cba3a330db9fe9376a137d2c
Gitweb:        https://git.kernel.org/tip/daebf24a8e8c6064cba3a330db9fe9376a137d2c
Author:        Alan Stern <stern@rowland.harvard.edu>
AuthorDate:    Fri, 06 Sep 2019 16:57:22 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:58:14 -07:00

tools/memory-model: Fix data race detection for unordered store and load

Currently the Linux Kernel Memory Model gives an incorrect response
for the following litmus test:

C plain-WWC

{}

P0(int *x)
{
	WRITE_ONCE(*x, 2);
}

P1(int *x, int *y)
{
	int r1;
	int r2;
	int r3;

	r1 = READ_ONCE(*x);
	if (r1 == 2) {
		smp_rmb();
		r2 = *x;
	}
	smp_rmb();
	r3 = READ_ONCE(*x);
	WRITE_ONCE(*y, r3 - 1);
}

P2(int *x, int *y)
{
	int r4;

	r4 = READ_ONCE(*y);
	if (r4 > 0)
		WRITE_ONCE(*x, 1);
}

exists (x=2 /\ 1:r2=2 /\ 2:r4=1)

The memory model says that the plain read of *x in P1 races with the
WRITE_ONCE(*x) in P2.

The problem is that we have a write W and a read R related by neither
fre or rfe, but rather W ->coe W' ->rfe R, where W' is an intermediate
write (the WRITE_ONCE() in P0).  In this situation there is no
particular ordering between W and R, so either a wr-vis link from W to
R or an rw-xbstar link from R to W would prove that the accesses
aren't concurrent.

But the LKMM only looks for a wr-vis link, which is equivalent to
assuming that W must execute before R.  This is not necessarily true
on non-multicopy-atomic systems, as the WWC pattern demonstrates.

This patch changes the LKMM to accept either a wr-vis or a reverse
rw-xbstar link as a proof of non-concurrency.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/linux-kernel.cat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index ea2ff4b..2a9b4fe 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -197,7 +197,7 @@ empty (wr-incoh | rw-incoh | ww-incoh) as plain-coherence
 (* Actual races *)
 let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
 let ww-race = (pre-race & co) \ ww-nonrace
-let wr-race = (pre-race & (co? ; rf)) \ wr-vis
+let wr-race = (pre-race & (co? ; rf)) \ wr-vis \ rw-xbstar^-1
 let rw-race = (pre-race & fr) \ rw-xbstar
 
 flag ~empty (ww-race | wr-race | rw-race) as data-race
