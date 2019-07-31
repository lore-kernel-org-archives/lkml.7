Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CCC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C4C206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QDMv6BCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGaR5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:57:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfGaR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:57:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VHuqv33777392
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 10:56:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VHuqv33777392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564595813;
        bh=qd/uZrI1scPtSVSL74aMjEYkwBO45H1Wk8cKH8KOun4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QDMv6BCTMyFUGtDUInsOKNcuq2fnynt+eDxqnMXus9c3GQg5jYwXJGk9ZIhDpvRib
         d7HRRVuVjeILBjK2xKW/KczVSJWiEPxpkaTc9OxA9tcU/royqHbICP0dv1yHFZclcf
         0/zKyICs7A15C13Wc+1/o2R+tMEIYtsROnLsBFvB+AtQJtuk9uFSfZoXRuFenVsNon
         MHkc7uzH9taDvcK2ni5ov/MKDol83UG2JvVy5DcHLxA7sxNcO7WkJJm2Y53KBtBvBT
         rjQE5ZQ+dw1idOae7/uRoaGXvN3RqFmReFzlfJutJz3aVivLvHECyBytO6rny1cSwP
         YB97yxQl7eGIQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VHup6N3777389;
        Wed, 31 Jul 2019 10:56:51 -0700
Date:   Wed, 31 Jul 2019 10:56:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-27972765bd0410fc2ef5e86a41de17c71440a2dd@git.kernel.org>
Cc:     mingo@kernel.org, pbonzini@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        mhiramat@kernel.org, rostedt@goodmis.org, paulmck@linux.ibm.com
Reply-To: rostedt@goodmis.org, paulmck@linux.ibm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, pbonzini@redhat.com,
          mingo@kernel.org, mhiramat@kernel.org, tglx@linutronix.de
In-Reply-To: <20190726212124.302995288@linutronix.de>
References: <20190726212124.302995288@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] locking/spinlocks: Use CONFIG_PREEMPTION
Git-Commit-ID: 27972765bd0410fc2ef5e86a41de17c71440a2dd
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

Commit-ID:  27972765bd0410fc2ef5e86a41de17c71440a2dd
Gitweb:     https://git.kernel.org/tip/27972765bd0410fc2ef5e86a41de17c71440a2dd
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:39 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:35 +0200

locking/spinlocks: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Adjust the comments in the locking code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.302995288@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/spinlock.h         | 2 +-
 include/linux/spinlock_api_smp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index ed7c4d6b8235..031ce8617df8 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -214,7 +214,7 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 
 /*
  * Define the various spin_lock methods.  Note we define these
- * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The
+ * regardless of whether CONFIG_SMP or CONFIG_PREEMPTION are set. The
  * various methods are defined as nops in the case they are not
  * required.
  */
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 42dfab89e740..b762eaba4cdf 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -96,7 +96,7 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
- * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
+ * even on CONFIG_PREEMPTION, because lockdep assumes that interrupts are
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
