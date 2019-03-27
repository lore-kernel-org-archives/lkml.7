Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226EAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AC920651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711246;
	bh=+ex38ORoadsGP+drc6n1OCcESgAGxnr9Dpl61s4jB44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PU13dQrVllAZCKDaWRhv4VSthHGfL00LGj2911HPIKnD+kd1NP5Q2GTrOYc5YGsJJ
	 uYSPRWLxkYX8GHPWnelnwUmf2Wuc6I6Rr/qzVlDabcOKVkZfVEIuAsw32ST0IcBU5Y
	 OBUo08Xmjqx7nv3YlyDhxNeI6UWmnaiI8Yh51Cbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfC0S0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388656AbfC0S0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1A620651;
        Wed, 27 Mar 2019 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711175;
        bh=+ex38ORoadsGP+drc6n1OCcESgAGxnr9Dpl61s4jB44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncdPbGZYPy1HakpFuO14M2UEdu9orydUCQvm75Cfxo3QpLinYYp1y8DAn2UZmIjmH
         xRf/L/3sq1LaAfk5mEn5BxwsWo5bJNsdnOUtsr+K5+hiyP292Y7x14t2gLXapwgGjF
         +Wk3VK0SsHtpeXQKpIgrHs07r7YuvDFSYCkQA1AM=
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
Subject: [PATCH AUTOSEL 3.18 30/41] locking/lockdep: Add debug_locks check in __lock_downgrade()
Date:   Wed, 27 Mar 2019 14:25:07 -0400
Message-Id: <20190327182518.19394-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
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
index fb90ca3a296e..27de98428367 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3312,6 +3312,9 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
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

