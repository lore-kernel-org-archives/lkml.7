Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE09C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338A220989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSZLPVSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfEMJOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfEMJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:14:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so6850601pfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xh8l5qK2+HT2kZksTDEFuM3KwaiTI6btFTlvN3yvxMo=;
        b=SSZLPVSxJ03Kyh+cx73mnr/lHCZC0rCHxdIS3ObRw3N4MbPALDGQc9uBTMWdK5Pdzu
         MbE3LfRmQ1DZbWy2fZjfpe+1XinmosjLCre01FVxB1IB3DWkRjK/Rqu7FcWYFYdtsV64
         8kW+IErgIZURlG37KpG2+CrjXo7kmv5KKdGA1Lf+gq+WJakcbGAn1gC4bmBz8bDGlj4+
         CaKKlhsyjAi84z3t1Kn2OitjQh3p0pkdBCxFgcfhcGZLLXbQbPxy1GVu1XY4BSdEkwTy
         13XHV4SiqSCyMsZoF85qk3OiO1OzKNS7e930mdCpUmPAvTpADC4EU5nelqWnkmZguaQ9
         keLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xh8l5qK2+HT2kZksTDEFuM3KwaiTI6btFTlvN3yvxMo=;
        b=ZML461MOiEoFM1+Vi+ggVVdlRDTfpt4ICzhKEaN+/3bgkG4pVIrzdJkqjmLhspr/JM
         WAvYdsRFzX4wUCB/lI2VoL3rPeuVGTIj8TYsp4Jf30m4Jpe4vVcxquzpxsX3vQXD1fn0
         EgGGvyCMwZZBywLFLu36AB4F2tXOZhQngi8UyvjbgPBkVfDBmvJbm5nKZ3qlVqilGIrb
         INNVuhzFQ4kE4o0bENb2xUkI/1hHRFR4sNCfNaVKSpxt6JfWfoRqx1hGp/SIp28tCyta
         Qmd6Z1oyGae9AXJXCjG7DBA0BqkoDwQ9LgG3jn+F+ADxKbqliMbW3SGbXl5RscLm5BDT
         XnVQ==
X-Gm-Message-State: APjAAAU+xITceGkWZXTYxlLVp7cCoZC6yLgy2jG2KVc/4vJpomwJv4IH
        lPa6aY0ABUUfuu8wIUE1OEY=
X-Google-Smtp-Source: APXvYqx6lZwHjJdIKe5eb2VqfrArWYuRcUpyRSs8IFrmzJjmEPtZ42PGbUBz30JZWQPoG3tDxzWZ0A==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr29571038pge.318.1557738843927;
        Mon, 13 May 2019 02:14:03 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:14:03 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 14/17] locking/lockdep: Support recursive read locks
Date:   Mon, 13 May 2019 17:12:00 +0800
Message-Id: <20190513091203.7299-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we are good to finally support recursive read locks.

This is done simply by adding the dependency that has recursive locks to the
graph, which previously is skipped.

The reason is plainly simple:

  (a). Recursive read lock differs from read lock only inside a task.
  (b). check_deadlock_current() already handles recursive-read lock pretty
       well.

Now that the bulk of the implementation of the read-write lock deadlock
detection algorithm is done, the lockdep internal performance statistics can
be collected (the workload used as usual is: make clean; reboot; make vmlinux -j8):

Before
------
 direct dependencies:                  8980 [max: 32768]
 indirect dependencies:               41065
 all direct dependencies:            211016
 dependency chains:                   11592 [max: 65536]
 dependency chain hlocks:             42869 [max: 327680]
 in-hardirq chains:                      85
 in-softirq chains:                     385
 in-process chains:                   10250
 stack-trace entries:                123121 [max: 524288]
 combined max dependencies:       340292196
 max bfs queue depth:                   244
 chain lookup misses:                 12703
 chain lookup hits:               666620822
 cyclic checks:                       11392
 redundant checks:                        0

After
-----

 direct dependencies:                  9624 [max: 32768]
 indirect dependencies:               43759
 all direct dependencies:            216024
 dependency chains:                   12119 [max: 65536]
 dependency chain hlocks:             44654 [max: 327680]
 in-hardirq chains:                      88
 in-softirq chains:                     383
 in-process chains:                   10544
 stack-trace entries:                132362 [max: 524288]
 combined max dependencies:       360385920
 max bfs queue depth:                   250
 chain lookup misses:                 13528
 chain lookup hits:               664721852
 cyclic checks:                       12053
 redundant checks:                        0

Most noticeably, we have slightly more dependencies, chains, and chain
lookup misses, but none of them raises concerns.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 417b23d..69d6bd6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1805,6 +1805,9 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 		.parent = NULL,
 	};
 
+	if (DEBUG_LOCKS_WARN_ON(hlock_class(src) == hlock_class(target)))
+		return 0;
+
 	debug_atomic_inc(nr_cyclic_checks);
 
 	while (true) {
@@ -1861,9 +1864,17 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 					break;
 
 				/*
+				 * This previous lock has the same class as
+				 * the src (the next lock to acquire); this
+				 * must be a recursive read case. Skip.
+				 */
+				if (hlock_class(prev) == hlock_class(src))
+					continue;
+
+				/*
 				 * Since the src lock (the next lock to
-				 * acquire) is neither recursive nor nested
-				 * lock, so this prev class cannot be src
+				 * acquire) is not nested lock, so up to
+				 * now this prev class cannot be the src
 				 * class, then does the path have this
 				 * previous lock?
 				 *
@@ -2609,6 +2620,17 @@ static inline void inc_chains(void)
 	}
 
 	/*
+	 * Filter out the direct dependency with the same lock class, which
+	 * is legitimate only if both the locks have the recursive read
+	 * type, otherwise we should not have been here in the first place.
+	 */
+	if (hlock_class(prev) == hlock_class(next)) {
+		WARN_ON_ONCE(next->read != LOCK_TYPE_RECURSIVE);
+		WARN_ON_ONCE(prev->read != LOCK_TYPE_RECURSIVE);
+		return 2;
+	}
+
+	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
@@ -2626,16 +2648,6 @@ static inline void inc_chains(void)
 		return 0;
 
 	/*
-	 * For recursive read-locks we do all the dependency checks,
-	 * but we dont store read-triggered dependencies (only
-	 * write-triggered dependencies). This ensures that only the
-	 * write-side dependencies matter, and that if for example a
-	 * write-lock never takes any other locks, then the reads are
-	 * equivalent to a NOP.
-	 */
-	if (next->read == LOCK_TYPE_RECURSIVE || prev->read == LOCK_TYPE_RECURSIVE)
-		return 1;
-	/*
 	 * Is the <prev> -> <next> dependency already present?
 	 *
 	 * (this may occur even though this is a new chain: consider
@@ -2734,11 +2746,7 @@ static inline void inc_chains(void)
 		int distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
-		/*
-		 * Only non-recursive-read entries get new dependencies
-		 * added:
-		 */
-		if (hlock->read != LOCK_TYPE_RECURSIVE && hlock->check) {
+		if (hlock->check) {
 			int ret = check_prev_add(curr, hlock, next, distance,
 						 &trace);
 			if (!ret)
@@ -3131,10 +3139,9 @@ static int validate_chain(struct task_struct *curr,
 
 		/*
 		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
+		 * of the chain, and if it's not a nest lock:
 		 */
-		if (!chain_head && ret != LOCK_TYPE_RECURSIVE &&
-		    ret != LOCK_TYPE_NEST) {
+		if (!chain_head && ret != LOCK_TYPE_NEST) {
 			if (!check_prevs_add(curr, hlock))
 				return 0;
 		}
-- 
1.8.3.1

