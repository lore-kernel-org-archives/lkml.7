Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6733BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A202175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkyqddEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfDXKVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfDXKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so9094260pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzCv3BclGHFhGWHFmfTH+y9n6ekknPKGz39OZ/d34o4=;
        b=VkyqddEyCQBjPglOQqE5KKS84RJ4SWOhZykvUQwrBi6D91pq4UAooMo8PUovLoSWAy
         o//NHP1er9wWbGlMf7wLsfTDcq5DRP372A2fGnxr8MvYn6ptM/iZWc+vfAszFsMFsma/
         4UrKuyYOz7qSD4szQA6F7rz5qJ5Sh1njobEshsZLmX0cCMIdD5aoozwDUXxkoIXtRf7b
         m4gy7xL5DxJUxWDdkmG1UPHmFFe0Xxxcums124tbHHqY0+giUTxQEqck9wkVDtDCarMh
         yCXgxR1vdj3QD9pvjFVyUkqmMfmJ1YRqZI6fcqn9DUbjmrKbA5dJ1jxsWEnrzudvz/5u
         EDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzCv3BclGHFhGWHFmfTH+y9n6ekknPKGz39OZ/d34o4=;
        b=W0ZDgMH/wHGUhaNdnIF44xrwGWPFF0intYse86/sq1T+3yGQSVka+5AIKXdRQOYbW7
         2WdJoiInDPEeD+AwUqQT0Zk1b4+7A+Cb6va+mJEuaMhGGg3iz4vWBF7xSJ5Y0HxcNK9A
         QXO/LaZYC5uwYBCR10sGIBXAGJTLJQpypxQQ9GwQxpAy/Ft4m2rvO+tKFDkhrGI4KYNA
         NnEXRxFWUCqxVcLUsEMyfP3/jgkvh1zirLoUVsVwyPzPsdqr2m470uugW3lhk8KQX8Yt
         C0VBlwEojdWDJSnn8/M073IksOJFgOA3UNABIR6tvYooRhqB4gzKd6rYPLm1gbLq33F8
         bDWw==
X-Gm-Message-State: APjAAAW3wGVaXxFdMxHfRQoP4zUFSs6hfysrnVdm3xw3E4s7hrfY+Ezn
        RGElCMwBH5/k483NE28O/ko=
X-Google-Smtp-Source: APXvYqxmn/a1rTMdHbxnyLyRb+ssFG0mrvAeykZFi1Qdc4CEQV1U44yz3XnrY7g2icUjHM0exyd9Vw==
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr29938428pga.154.1556101286259;
        Wed, 24 Apr 2019 03:21:26 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:25 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 19/28] locking/lockdep: Optimize irq usage check when marking lock usage bit
Date:   Wed, 24 Apr 2019 18:19:25 +0800
Message-Id: <20190424101934.51535-20-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic rule concerning IRQ usage related deadlock is to find whether
there is a direct or indirect dependency from an IRQ safe lock to an IRQ
unsafe lock, where an IRQ safe lock means the lock is ever used in IRQ
context (i.e., LOCK_USED_IN_*) while an IRQ unsafe lock means the lock
is ever acquired with IRQ enabled (i.e., LOCK_ENABLED_IN_*).

This rule is checked to find violation at two points:

 - When marking a new IRQ usage bit
 - When adding a new dependency

At each point, a check may take two searches through the dependency
graph:

 - Forward search: walk forwards the dependency graph, try to find an unsafe lock.
 - Backward search: walk backwards the dependency graph, try to find a safe lock.

If graph search/searches are successful, then there is a rule violation.
The current checks are effective albeit they can be significantly
optimized.

----------
Lock usage
----------

Any lock class can be marked as in three exclusive usage states:

 - IRQ safe or IRQ unsafe
 - Lock used (with the LOCK_USED bit marked only), which is neither safe
   nor unsafe, but can transition to either one above state

A lock can not be in both IRQ safe and unsafe states, if so it is a
simple violation of the rule by the node itself, which can be easily
found when marking IRQ usage. Therefore, this violation quest is left
out in the following.

Note that with read-write locks considered, the exclusiveness is a bit
more complex, which will be discussed in later patches.

----------------
Dependency graph
----------------

When checking the rule, the current dependency graph is composed of
nodes of the three exclusive types, and of directed edges as follows,
presumably it has no violation:

 - Edges from safe node to safe node
 - Edges from unsafe node to safe node
 - Edges from unsafe node to unsafe node

 - Edges from used node to safe node
 - Edges from used node to unsafe node
 - Edges from used node to used node
 - Edges from safe node to used node
 - Edges from unsafe node to used node

The first three types are fixed; edges will not change the type over
time. If the graph has only fixed-type edges, checking the rule would be
so easy: just check the direct dependencies involved at the two checking
points, there is even no need to search the entire graph, because a
violation could only be a direct dependency from a safe lock to an
unsafe lock.

The other five types are uncertain. If a used node transitions to other
states, the involved edge types will be altered.

----------------------
New checking algorithm
----------------------

First, two exclusive substates are added to the used state (they will be
discussed later):

 - Reachable from IRQ safe nodes
 - Unreachable from IRQ safe nodes

The new checking algorithm at the two checking points as follows:

1. When adding a new dependency from prev lock to next lock:

 - If prev is in unsafe then done. There is no worry to have any
   new violation from prev forwards so a forward search is not needed. A
   backward search for safe node is not needed either because prev is like
   a shield for next since there has been no safe node to prev.

 - If the prev is in safe state:
   * If next is safe, do a forward search for unsafe node from next
   * If next is unsafe, one violation is found
   * If next is used, do a forward search for unsafe node from next

 - If prev is in used state:
   * If prev is reachable from safe state, do a forward search for
     unsafe states from next
   * If prev is unreachable from safe state, done

A forward search for unsafe node traverses the graph as the current
forward search does. In addition, after a safe-state node or denpendency
is newly added to the graph, if a used node is encountered not marked as
reachable from safe state, then mark it reachable.

2. When marking a new usage bit for a lock

 - Used: this happens only when initializing the lock's usage bit. At
   this time, this node should have no any dependency so nothing needs
   to be done

 - Safe from used:
   * if the node is reachable from safe node, done
   * if the node is unreachable from safe node, do a forward search for unsafe node

 - Unsafe from used:
   * If the node is reachable from safe node, then a violation is found
   * If the node is unreachable from safe node, done

With this new algorithm, the checking efficiency can be improved
significantly. Backward searches are avoided; some forward search cases
are saved as well. As a result, backward dependencies are not needed any
more.

The following patches implement this new IRQ usage checking algorithm.

This starter patch defines and initializes irqsafe_lock and
irqsafe_distance fields in lock_class, which keep track of the irqsafe
locks that reach this lock class. In addition, four bitmaps are declared
to keep track of the irqsafe locks.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  | 14 ++++++++++++++
 kernel/locking/lockdep.c | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7c2fefa..0e209b8 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -72,6 +72,11 @@ struct lock_trace {
 };
 
 #define LOCKSTAT_POINTS		4
+/*
+ * For hardirq and softirq, each has one for irqsafe lock that reaches
+ * this lock and one for irqsafe-read lock that reaches this lock.
+ */
+#define LOCK_IRQ_SAFE_LOCKS	4
 
 /*
  * The lock-class itself. The order of the structure members matters.
@@ -114,6 +119,15 @@ struct lock_class {
 	int				name_version;
 	const char			*name;
 
+	/*
+	 * irqsafe_lock indicates whether there is an IRQ safe lock
+	 * reaches this lock_class in the dependency graph, and if so
+	 * points to it; irqsafe_distance measures the distance from the
+	 * IRQ safe locks, used for keeping the shortest.
+	 */
+	struct lock_class		*irqsafe_lock[LOCK_IRQ_SAFE_LOCKS];
+	int				irqsafe_distance[LOCK_IRQ_SAFE_LOCKS];
+
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
 	unsigned long			contending_point[LOCKSTAT_POINTS];
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6e79bd6..a3138c9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1101,6 +1101,7 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 	struct lockdep_subclass_key *key;
 	struct hlist_head *hash_head;
 	struct lock_class *class;
+	int i;
 
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1153,6 +1154,9 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 	WARN_ON_ONCE(!list_empty(&class->locks_before));
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	class->name_version = count_matching_names(class);
+	for (i = 0; i < ARRAY_SIZE(class->irqsafe_distance); i++)
+		class->irqsafe_distance[i] = INT_MAX;
+
 	/*
 	 * We use RCU's safe list-add method to make
 	 * parallel walking of the hash-list safe:
@@ -2896,6 +2900,10 @@ static void print_usage_bug_scenario(struct held_lock *lock)
 	return 1;
 }
 
+static DECLARE_BITMAP(lock_classes_hardirq_safe, MAX_LOCKDEP_KEYS);
+static DECLARE_BITMAP(lock_classes_hardirq_safe_read, MAX_LOCKDEP_KEYS);
+static DECLARE_BITMAP(lock_classes_softirq_safe, MAX_LOCKDEP_KEYS);
+static DECLARE_BITMAP(lock_classes_softirq_safe_read, MAX_LOCKDEP_KEYS);
 
 /*
  * print irq inversion bug:
@@ -5001,6 +5009,12 @@ void __init lockdep_init(void)
 		+ sizeof(lock_chains)
 		+ sizeof(lock_chains_in_use)
 		+ sizeof(chain_hlocks)
+#ifdef CONFIG_TRACE_IRQFLAGS
+		+ sizeof(lock_classes_hardirq_safe)
+		+ sizeof(lock_classes_hardirq_safe_read)
+		+ sizeof(lock_classes_softirq_safe)
+		+ sizeof(lock_classes_softirq_safe_read)
+#endif
 #endif
 		) / 1024
 		);
-- 
1.8.3.1

