Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7003BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EBB25F6D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YqTwea3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfFCNWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:22:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfFCNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:22:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DMOgF607192
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:22:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DMOgF607192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568145;
        bh=kRbNr96VS09F+taGClxc324ZFJY2xCgOU3S9yZzfQ5Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YqTwea3Ag2jAOIEsyHt4SB7VmCTggJALo9PBuoc2Dw57KHRSu7rCyBrqL23lwfG5N
         4ZRsUfQXSJQgXoIxbLi3UR65JGLaVNsBMAR2uDYJxIdY2sQ+Z+Ec/J9cR3Cv0s9UVq
         15GcnEZnFJPrgglKA8vtZWZ3eFJ0ER4gtMfOQUG2b2DoLyLZC5ypYbwaKg1RRhth6O
         xNfjBOCP/I5LnTXYfLDdFc4Cpp3L4tuAym6U505L5HZrKQ29eMAHGKsiJ2ZPx3+NQx
         nxCerfP+fA0atuaZRvd/A/6Ih3yBt3rgojNKQ7gAjpMx7532/dyO7hGGulkYA/MxQ3
         I2lyX3d2JWnBg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DMOQI607189;
        Mon, 3 Jun 2019 06:22:24 -0700
Date:   Mon, 3 Jun 2019 06:22:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-bf998b98f5bce4ebc97b3980016f54fabb7a4958@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        duyuyang@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com, duyuyang@gmail.com,
          torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20190506081939.74287-24-duyuyang@gmail.com>
References: <20190506081939.74287-24-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove !dir in lock irq usage
 check
Git-Commit-ID: bf998b98f5bce4ebc97b3980016f54fabb7a4958
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

Commit-ID:  bf998b98f5bce4ebc97b3980016f54fabb7a4958
Gitweb:     https://git.kernel.org/tip/bf998b98f5bce4ebc97b3980016f54fabb7a4958
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:39 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:53 +0200

locking/lockdep: Remove !dir in lock irq usage check

In mark_lock_irq(), the following checks are performed:

   ----------------------------------
  |   ->      | unsafe | read unsafe |
  |----------------------------------|
  | safe      |  F  B  |    F* B*    |
  |----------------------------------|
  | read safe |  F? B* |      -      |
   ----------------------------------

Where:
F: check_usage_forwards
B: check_usage_backwards
*: check enabled by STRICT_READ_CHECKS
?: check enabled by the !dir condition

From checking point of view, the special F? case does not make sense,
whereas it perhaps is made for peroformance concern. As later patch will
address this issue, remove this exception, which makes the checks
consistent later.

With STRICT_READ_CHECKS = 1 which is default, there is no functional
change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-24-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9c4e2a7547d3..2168e94715b9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3235,7 +3235,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || !dir || STRICT_READ_CHECKS) &&
+	if ((!read || STRICT_READ_CHECKS) &&
 			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
