Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E609C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCDF2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLYKjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40587 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfLYKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik445-00085z-V3; Wed, 25 Dec 2019 11:38:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6765A1C2B24;
        Wed, 25 Dec 2019 11:38:53 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:38:53 -0000
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] rseq: Reject unknown flags on rseq unregister
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191211161713.4490-2-mathieu.desnoyers@efficios.com>
References: <20191211161713.4490-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <157727033331.30329.17206832903007175600.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     66528a4575eee9f5a5270219894ab6178f146e84
Gitweb:        https://git.kernel.org/tip/66528a4575eee9f5a5270219894ab6178f146e84
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 11 Dec 2019 11:17:11 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:41:20 +01:00

rseq: Reject unknown flags on rseq unregister

It is preferrable to reject unknown flags within rseq unregistration
rather than to ignore them. It is an oversight caused by the fact that
the check for unknown flags is after the rseq unregister flag check.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191211161713.4490-2-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/rseq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 27c48eb..a4f86a9 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -310,6 +310,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	int ret;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
+		if (flags & ~RSEQ_FLAG_UNREGISTER)
+			return -EINVAL;
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
