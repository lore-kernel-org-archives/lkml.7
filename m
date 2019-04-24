Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFF8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAC720652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129010;
	bh=9pLZJHEjM+78ujBOCOAukMA4hlbpOI9vGGeo3zyAOjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bRiOZnost2rba/LfhqDPBfcCK90OUs9ExTkSVUI37sCGLzdzWZVUipNpcSnZgYo9N
	 oAwgG+tsVo0DLBx/KVBdL0qP6xLJMD7t/WWwM/FHN3sU0H8XsNaGELWu6jB9QEVwd8
	 YwIsiTbxTrg8512GZ/0epo6McP1ZUXH37YmkxmpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbfDXRUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388488AbfDXRUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:16 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A044E21934;
        Wed, 24 Apr 2019 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126415;
        bh=9pLZJHEjM+78ujBOCOAukMA4hlbpOI9vGGeo3zyAOjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gI7dOjFHIgTT2Z68cUMOsIF8sLh7WENm6B+a7tvIWFaUeGidH9w8eUyjaWZm507we
         3S3e3DWr+SAVq9q8YJ+ziD4Yd/i219f0bOdJaH2Rck6UTtbHoTrlI4QE2Zt9Valob1
         aZZ1CEIraqKCk38lkcl+76JK1s9YtgiQ7DOr0qpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 095/168] sched/fair: Do not re-read ->h_load_next during hierarchical load calculation
Date:   Wed, 24 Apr 2019 19:08:59 +0200
Message-Id: <20190424170929.324352320@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

commit 0e9f02450da07fc7b1346c8c32c771555173e397 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/fair.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6022,10 +6022,10 @@ static void update_cfs_rq_h_load(struct
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
@@ -6035,7 +6035,7 @@ static void update_cfs_rq_h_load(struct
 		cfs_rq->last_h_load_update = now;
 	}
 
-	while ((se = cfs_rq->h_load_next) != NULL) {
+	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
 			cfs_rq_load_avg(cfs_rq) + 1);


