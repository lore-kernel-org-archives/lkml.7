Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F6624655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfLQMkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfLQMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8p-0001qb-16; Tue, 17 Dec 2019 13:39:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D5ED51C2A3B;
        Tue, 17 Dec 2019 13:39:52 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:52 -0000
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/wait: fix ___wait_var_event(exclusive)
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191210191902.GB14449@redhat.com>
References: <20191210191902.GB14449@redhat.com>
MIME-Version: 1.0
Message-ID: <157658639276.30329.909563738680417721.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cde65194502778665c1b52afc5722cf7dbfaa399
Gitweb:        https://git.kernel.org/tip/cde65194502778665c1b52afc5722cf7dbfaa399
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Tue, 10 Dec 2019 20:19:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:50 +01:00

sched/wait: fix ___wait_var_event(exclusive)

init_wait_var_entry() forgets to initialize wq_entry->flags.

Currently not a problem, we don't have wait_var_event_exclusive().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20191210191902.GB14449@redhat.com
---
 kernel/sched/wait_bit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 45eba18..02ce292 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -179,6 +179,7 @@ void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int 
 			.bit_nr = -1,
 		},
 		.wq_entry = {
+			.flags	 = flags,
 			.private = current,
 			.func	 = var_wake_function,
 			.entry	 = LIST_HEAD_INIT(wbq_entry->wq_entry.entry),
