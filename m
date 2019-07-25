Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B03B2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wjpDV4k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbfGYQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:05:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbfGYQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:05:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG4sZ51073001
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:04:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG4sZ51073001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070695;
        bh=CGp/2X3rAFbOFE9U5JoPmTJTK/AY1kMMD/x9u0l9pJ0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wjpDV4k8/ZKPIRCnanlBydkUIzeCw/43wQJrQXOIf/bkMRM00vQ2p5dkhtB8yTeRG
         LBxNuj2vxQteupuLQK5TQcFx7gg4KenLV+FpTy8lKKxa8ixEMjlVKkG7YcMviV+Whn
         wFRuvAnINC2FOwGhvLWvvVaAHVdSaG5rqFwldHXY/6aHSCMwWJmQa7JLKUPxx9e5da
         B5IPFt8xs/rtTVVr7iDxiBeV5taCCg/VXJdauS2SY9T5gNJp8TAwXagt27CgEq/Rvh
         kEND8BxWllCqMNKidpSv4LajdEP+NE0085NnhV9YhJPwbkhXhMeUVQUtr/5xMoGkeW
         N70XAwVQ9eM/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG4smO1072998;
        Thu, 25 Jul 2019 09:04:54 -0700
Date:   Thu, 25 Jul 2019 09:04:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-6c11c6e3d5e9e5caf8686cd6a5e4552cfc3ea326@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, will@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, will@kernel.org,
          bigeasy@linutronix.de
In-Reply-To: <20190703092125.lsdf4gpsh2plhavb@linutronix.de>
References: <20190703092125.lsdf4gpsh2plhavb@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/mutex: Test for initialized mutex
Git-Commit-ID: 6c11c6e3d5e9e5caf8686cd6a5e4552cfc3ea326
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

Commit-ID:  6c11c6e3d5e9e5caf8686cd6a5e4552cfc3ea326
Gitweb:     https://git.kernel.org/tip/6c11c6e3d5e9e5caf8686cd6a5e4552cfc3ea326
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Jul 2019 11:21:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:39:27 +0200

locking/mutex: Test for initialized mutex

An uninitialized/ zeroed mutex will go unnoticed because there is no
check for it. There is a magic check in the unlock's slowpath path which
might go unnoticed if the unlock happens in the fastpath.

Add a ->magic check early in the mutex_lock() and mutex_trylock() path.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190703092125.lsdf4gpsh2plhavb@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/mutex.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index edd1c082dbf5..5e069734363c 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -908,6 +908,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 	might_sleep();
 
+#ifdef CONFIG_DEBUG_MUTEXES
+	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+#endif
+
 	ww = container_of(lock, struct ww_mutex, base);
 	if (use_ww_ctx && ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
@@ -1379,8 +1383,13 @@ __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
  */
 int __sched mutex_trylock(struct mutex *lock)
 {
-	bool locked = __mutex_trylock(lock);
+	bool locked;
+
+#ifdef CONFIG_DEBUG_MUTEXES
+	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+#endif
 
+	locked = __mutex_trylock(lock);
 	if (locked)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
