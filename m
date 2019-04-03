Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB73C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C948E21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfDCIiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:38:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDCIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:38:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x338bxOo1774717
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 01:38:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x338bwUs1774714;
        Wed, 3 Apr 2019 01:37:58 -0700
Date:   Wed, 3 Apr 2019 01:37:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mel Gorman <tipbot@zytor.com>
Message-ID: <tip-0e9f02450da07fc7b1346c8c32c771555173e397@git.kernel.org>
Cc:     hpa@zytor.com, mgorman@techsingularity.net,
        valentin.schneider@arm.com, efault@gmx.de, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          stable@vger.kernel.org, linux-kernel@vger.kernel.org,
          efault@gmx.de, mingo@kernel.org, peterz@infradead.org,
          valentin.schneider@arm.com, mgorman@techsingularity.net,
          hpa@zytor.com
In-Reply-To: <20190319123610.nsivgf3mjbjjesxb@techsingularity.net>
References: <20190319123610.nsivgf3mjbjjesxb@techsingularity.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Do not re-read ->h_load_next during
 hierarchical load calculation
Git-Commit-ID: 0e9f02450da07fc7b1346c8c32c771555173e397
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0e9f02450da07fc7b1346c8c32c771555173e397
Gitweb:     https://git.kernel.org/tip/0e9f02450da07fc7b1346c8c32c771555173e397
Author:     Mel Gorman <mgorman@techsingularity.net>
AuthorDate: Tue, 19 Mar 2019 12:36:10 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 09:50:22 +0200

sched/fair: Do not re-read ->h_load_next during hierarchical load calculation

A NULL pointer dereference bug was reported on a distribution kernel but
the same issue should be present on mainline kernel. It occured on s390
but should not be arch-specific.  A partial oops looks like:

  Unable to handle kernel pointer dereference in virtual kernel address space
  ...
  Call Trace:
    ...
    try_to_wake_up+0xfc/0x450
    vhost_poll_wakeup+0x3a/0x50 [vhost]
    __wake_up_common+0xbc/0x178
    __wake_up_common_lock+0x9e/0x160
    __wake_up_sync_key+0x4e/0x60
    sock_def_readable+0x5e/0x98

The bug hits any time between 1 hour to 3 days. The dereference occurs
in update_cfs_rq_h_load when accumulating h_load. The problem is that
cfq_rq->h_load_next is not protected by any locking and can be updated
by parallel calls to task_h_load. Depending on the compiler, code may be
generated that re-reads cfq_rq->h_load_next after the check for NULL and
then oops when reading se->avg.load_avg. The dissassembly showed that it
was possible to reread h_load_next after the check for NULL.

While this does not appear to be an issue for later compilers, it's still
an accident if the correct code is generated. Full locking in this path
would have high overhead so this patch uses READ_ONCE to read h_load_next
only once and check for NULL before dereferencing. It was confirmed that
there were no further oops after 10 days of testing.

As Peter pointed out, it is also necessary to use WRITE_ONCE() to avoid any
potential problems with store tearing.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
Link: https://lkml.kernel.org/r/20190319123610.nsivgf3mjbjjesxb@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb6f351..40bd1e27b1b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7784,10 +7784,10 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	if (cfs_rq->last_h_load_update == now)
 		return;
 
-	cfs_rq->h_load_next = NULL;
+	WRITE_ONCE(cfs_rq->h_load_next, NULL);
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_load_next = se;
+		WRITE_ONCE(cfs_rq->h_load_next, se);
 		if (cfs_rq->last_h_load_update == now)
 			break;
 	}
@@ -7797,7 +7797,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 		cfs_rq->last_h_load_update = now;
 	}
 
-	while ((se = cfs_rq->h_load_next) != NULL) {
+	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
 			cfs_rq_load_avg(cfs_rq) + 1);
