Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C064FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9267825162
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nZKgY2O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFCNSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:18:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:18:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DI4c3606461
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:18:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DI4c3606461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567885;
        bh=qQju9tIEAxgAVY0b0Mb/QeR42zB5EUie62cCkeZ7QEU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nZKgY2O3MfvdGUSTbqkyzSQdVlp5k2Ar+P3IIMElY7H82hdpHER/BQe/XA/fUyh4H
         F+VC3Pkb4pupqplNvHzpbTPbGLKhEZC6ZrVJYzE69ZpFYSRekLc+lK+hkNtGvDEKyS
         oCz2b+aKN4ASp299tkl8i4N/nqTIth5sugPr7NPOcF/kuJRA3gBYJvTiDNziLWyjKN
         3xCX8j+NHAeoJOqdaGRNr9AtcrI6qJBa3az0LwKSgYaPU+cxkbl9/GfMqMWspfL1XK
         bydlbHaM603DDRD0+ciF0sJrRhQUFF9Dth6ljnygD3Ywm6BB9JsTBK11W9j1dYQjH+
         rdm1hNBHhiu/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DI43r606458;
        Mon, 3 Jun 2019 06:18:04 -0700
Date:   Mon, 3 Jun 2019 06:18:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-4609c4f963f353613812f999bb027aac795bcde8@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, duyuyang@gmail.com,
        hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org, hpa@zytor.com, duyuyang@gmail.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190506081939.74287-18-duyuyang@gmail.com>
References: <20190506081939.74287-18-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove redundant argument in
 check_deadlock
Git-Commit-ID: 4609c4f963f353613812f999bb027aac795bcde8
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

Commit-ID:  4609c4f963f353613812f999bb027aac795bcde8
Gitweb:     https://git.kernel.org/tip/4609c4f963f353613812f999bb027aac795bcde8
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:33 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:49 +0200

locking/lockdep: Remove redundant argument in check_deadlock

In check_deadlock(), the third argument read comes from the second
argument hlock so that it can be removed. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-18-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b2ca20aa69aa..be4c1348ddcd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2246,7 +2246,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2265,7 +2265,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
 		 * Allow read-after-read recursion of the same
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
-		if ((read == 2) && prev->read)
+		if ((next->read == 2) && prev->read)
 			return 2;
 
 		/*
@@ -2839,7 +2839,7 @@ static int validate_chain(struct task_struct *curr,
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock(curr, hlock, hlock->read);
+		int ret = check_deadlock(curr, hlock);
 
 		if (!ret)
 			return 0;
