Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4742075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712508;
	bh=7fh/+gxi/1QLeRZifdvKYCVbSmA2/G/763cMFxU0aZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDEYW5FiU79PGUOnExPBTOHkPeBYiJIQG8zx2P98qNdmEAehjFFCil0JxqpIv3IJ2
	 Y5hCr1UzsoXjpRIsV573P4g1XyPVrXC6HRZ+UpGAWYRAUurSwgSD5ESLp8c+JU10Dp
	 VHs7uwZeWcabEEt9Q+yv+BruL1KGLgtKr7x6MZ3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbfC0STL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390656AbfC0STH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4914920449;
        Wed, 27 Mar 2019 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710746;
        bh=7fh/+gxi/1QLeRZifdvKYCVbSmA2/G/763cMFxU0aZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPP9aBO6Pxp6RudlZ1mhhAneZ1/GVR1bh00CmTT3AmGWtpMveshAW4KGMgqVADFUW
         BTBpZpWX6l8MOlymaQfUtFm4javCfMVRWCPjM0J9goBGOUAEmXn+/edkeAx72Ldfq2
         JA0l05Fa7djGmDXWHNasLKluC4M/eadVTOEzXtZs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 086/123] locking/lockdep: Add debug_locks check in __lock_downgrade()
Date:   Wed, 27 Mar 2019 14:15:50 -0400
Message-Id: <20190327181628.15899-86-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

[ Upstream commit 71492580571467fb7177aade19c18ce7486267f5 ]

Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
warning right after a previous lockdep warning. It is likely that the
previous warning turned off lock debugging causing the lockdep to have
inconsistency states leading to the lock downgrade warning.

Fix that by add a check for debug_locks at the beginning of
__lock_downgrade().

Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/1547093005-26085-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf694c709b96..e57be7031cb3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3650,6 +3650,9 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 	unsigned int depth;
 	int i;
 
+	if (unlikely(!debug_locks))
+		return 0;
+
 	depth = curr->lockdep_depth;
 	/*
 	 * This function is about (re)setting the class of a held lock,
-- 
2.19.1

