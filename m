Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C1FC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0A820989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhwRlW68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfEMJN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39314 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfEMJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id w22so6450939pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxtXj8UtQSYghHEfN3xnKKzkOFQGRnYE90nTsl6Ujjg=;
        b=jhwRlW68xzcAAcGuoqMH5yNgAbFIu6vd+KomvwtilVIysTWq2oVqDTQApiqUDxI9pC
         VtOzK33YPNcHJVvNppomR9Brki+JSDqX7qzUuE8FYDsj+RKA33Qj+gdN/ZE8v/PHNkkG
         p5DJDYW+0iy1cQAqY/y/V8RoJCeSUbSWqnVD7od2Lj36cub8AXJYyzHcbMJctfltle8G
         UhKDwnYHCVk/fUvDC5SfIV/c+1+KHGjXeveGzjmZze+qYkpCx/4zVFiH0iwsMcpX+iwK
         2m9ehhovfHDmmbvPEhHKAk7WBS/daG1Ffg3OXPnGfgkan0sub5qQy3N2BZ/iIKBL0kMb
         Ng+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxtXj8UtQSYghHEfN3xnKKzkOFQGRnYE90nTsl6Ujjg=;
        b=KuMhI+rHmFGXdp0S/rx4BQBHlAuXy5dpjc6u7Z/+9IHJUNJ1mM5mvvThG46afubB21
         6mNZa9uwtOP1v8Ar+KHT9Xn+sUgY9FpDnY43Q9XSll4/lAP7bKIh8RIwk/MDLLsB3AnE
         HFpTwwDLf7qMOMKKut7qLpryoF7OB+Al2H081ycf1obyaZKpfkHhtg6PuUXYfd3ouK58
         sj9tMxXVSUTT/p920RBjEPFUwOqA7RQgln9EtZOuA8CWQ6d9K9KyLIXshqoFeW4+hilD
         IMMMpJKkqV0uApgjy2WSwGrYxwk3EjslbiXU8RYjiUuXW8A6QlOFRkodD0UItXwqyk/8
         gh2w==
X-Gm-Message-State: APjAAAUdOP2ZhDso3Ixy2ExQvjSvpcCGA5kW4HWUy8ZuNYG/+nf/7hfO
        5o+YNKOfIf/TkSoIo/n9BJA=
X-Google-Smtp-Source: APXvYqzS6CutaQhgmW9u/OlX3akEfqIezW5lXM2ozxu6RsxsH/sBA8HGWMo6pKQouLVAJXn99Z6Kmg==
X-Received: by 2002:a65:63d5:: with SMTP id n21mr29675339pgv.330.1557738803899;
        Mon, 13 May 2019 02:13:23 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:23 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 02/17] locking/lockdep: Add read-write type for dependency
Date:   Mon, 13 May 2019 17:11:48 +0800
Message-Id: <20190513091203.7299-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct dependency needs to keep track of its locks' read-write types.  A
union field is added to lock_list struct so the type is stored there as
this:

	lock_type[1] (u16), lock_type[0] (u16)

			or:

	dep_type (int)

where value:

 0: exclusive / write
 1: read
 2: recursive read

Note that (int) dep_type value may vary with different architectural
endianness, so use helpers to operate on these types.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h            | 12 ++++++++++++
 kernel/locking/lockdep.c           | 34 +++++++++++++++++++++++++++++++---
 kernel/locking/lockdep_internals.h |  3 +++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 441288c..6aa9af2 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -195,6 +195,18 @@ struct lock_list {
 	struct lock_class		*links_to;
 	struct lock_trace		trace;
 	int				distance;
+	/*
+	 * This field keeps track of the read-write type of this dependency.
+	 *
+	 * With L1 -> L2:
+	 *
+	 * lock_type[0] stores the type of L1, while lock_type[1] stores the
+	 * type of L2.
+	 */
+	union {
+		int	dep_type;
+		u16	lock_type[2];
+	};
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e9eafcf..4091002 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1225,7 +1225,7 @@ static struct lock_list *alloc_list_entry(void)
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
-			    struct lock_trace *trace)
+			    struct lock_trace *trace, int dep_type)
 {
 	struct lock_list *entry;
 	/*
@@ -1240,6 +1240,8 @@ static int add_lock_to_list(struct lock_class *this,
 	entry->links_to = links_to;
 	entry->distance = distance;
 	entry->trace = *trace;
+	entry->dep_type = dep_type;
+
 	/*
 	 * Both allocation and removal are done under the graph lock; but
 	 * iteration is under RCU-sched; see look_up_lock_class() and
@@ -1677,6 +1679,30 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return ret;
 }
 
+static inline int get_dep_type(struct held_lock *lock1, struct held_lock *lock2)
+{
+	/*
+	 * With dependency lock1 -> lock2:
+	 *
+	 * lock_type[0] is lock1, while lock_type[1] is lock2.
+	 *
+	 * Avoid architectural endianness difference composing dep_type.
+	 */
+	u16 type[2] = { lock1->read, lock2->read };
+
+	return *(int *)type;
+}
+
+static inline int get_lock_type1(struct lock_list *lock)
+{
+	return lock->lock_type[0];
+}
+
+static inline int get_lock_type2(struct lock_list *lock)
+{
+	return lock->lock_type[1];
+}
+
 /*
  * Check that the dependency graph starting at <src> can lead to
  * <target> or not. Print an error and return 0 if it does.
@@ -2446,14 +2472,16 @@ static inline void inc_chains(void)
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance, trace,
+			       get_dep_type(prev, next));
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance, trace,
+			       get_dep_type(next, prev));
 	if (!ret)
 		return 0;
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 150ec3f..c287bcb 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -26,6 +26,9 @@ enum lock_usage_bit {
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
 
+#define LOCK_TYPE_BITS	16
+#define LOCK_TYPE_MASK	0xFFFF
+
 /*
  * Usage-state bitmasks:
  */
-- 
1.8.3.1

