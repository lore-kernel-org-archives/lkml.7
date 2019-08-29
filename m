Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B882073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/G1nb0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfH2IdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33039 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfH2Ic4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so1251508plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zlq2IBLuceVbdXIR+sbqYK0JGHzJ0OSTvlG77al8JWo=;
        b=X/G1nb0CpuyCr2vmt/DOG4mIhMEOEUjXfMvBys+/IGiUF0k6kUnuGuGLHnh3X4pnVT
         NRujSQX1YQFG5dGedXWlF/01SrXfRBUrB7BVEUOLALNY4YQB7co6JbhIons6rdpHuC4M
         4Z7mNXM3vCQCj3GWmRz7/mrjscfOw683/VyIFlRDr5oG33fmTJZrownWVwKMwmNQHU87
         mpkz3zs1jpgoQi2KUfoyGAwnnAsOLYTylN8H7MV15NBn0j0Q1drjROO2+sro6zxuDyYy
         buyWSZYDsxQ0X61IjGrW9eRdsDjetddKwFEU0nsF49GUX3HovMB0XYMF53KQTRHoItsP
         c/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlq2IBLuceVbdXIR+sbqYK0JGHzJ0OSTvlG77al8JWo=;
        b=tDVFGHuNNo2M/SuDCZFf9TQHKDVaP5wGfgJpQGPvj4gOepHunsPANvc0WrYAtsmfgN
         wRbNdHjN54Lb1Vo42DN935ub/2E5Y3e+jrNvGMdglfs+K7PRySA01SJVdD48Hduys+WA
         8ZS243E/HSNiGryk9GqQrkwGTngczjZROH46tIKyMN9JOofmx2YE2CF/INOYpHOE9R22
         ISkW5y6BwcU5oQ52qyqULf/b3UGQ9V+/OE1jw4FWA8q9bk/wzxEWfmJe2PcGgAH6mQIf
         raT8rKPK63YaCjyFWNn66+uKDE14vjRpqpkLUNvkWPN/sYUEuUJgr6qfuAn9CR1qbZ1V
         l7iw==
X-Gm-Message-State: APjAAAXF0dlVAPh7sT1MqNYS5erc2PaKZVrmz6h+mi19LHBGwy7t3XJH
        1s+EmPGLZWy/MR+utRvkOO8=
X-Google-Smtp-Source: APXvYqxqMAfbGmC0nk2I8KBtEU+uUwaElXic1ahMn3oG5486dMGvUStQIFNfXYRscPZ5vym3lFUrVQ==
X-Received: by 2002:a17:902:8a87:: with SMTP id p7mr8633372plo.240.1567067575250;
        Thu, 29 Aug 2019 01:32:55 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:54 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 18/30] ocking/lockdep: Add read-write type for a lock dependency
Date:   Thu, 29 Aug 2019 16:31:20 +0800
Message-Id: <20190829083132.22394-19-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct dependencies need to keep track of their read-write lock types.
Two bit fields, which share the distance field, are added to lock_list
struct to store the types.

With a dependecy lock1 -> lock2, lock_type1 has the type for lock1 and
lock_type2 has the type for lock2, where the values are one of the
lock_type enums.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  | 15 ++++++++++++++-
 kernel/locking/lockdep.c | 25 +++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 2335447..eab8a90 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -182,6 +182,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 		to->class_cache[i] = NULL;
 }
 
+#define LOCK_TYPE_BITS	2
+
 /*
  * Every lock has a list of other locks that were taken after or before
  * it as lock dependencies. These dependencies constitute a graph, which
@@ -204,7 +206,17 @@ struct lock_list {
 	struct list_head		chains;
 	struct lock_class		*class[2];
 	const struct lock_trace		*trace;
-	int				distance;
+
+	/*
+	 * The lock_type fields keep track of the lock type of this
+	 * dependency.
+	 *
+	 * With L1 -> L2, lock_type1 stores the lock type of L1, and
+	 * lock_type2 stores that of L2.
+	 */
+	unsigned int			lock_type1 : LOCK_TYPE_BITS,
+					lock_type2 : LOCK_TYPE_BITS,
+					distance   : 32 - 2*LOCK_TYPE_BITS;
 
 	/*
 	 * The parent field is used to implement breadth-first search.
@@ -359,6 +371,7 @@ enum lock_type {
 	LOCK_TYPE_WRITE		= 0,
 	LOCK_TYPE_READ,
 	LOCK_TYPE_RECURSIVE,
+	NR_LOCK_TYPE,
 };
 
 /*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bdc7e94..18303ff 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1379,9 +1379,17 @@ static int add_lock_to_list(struct lock_class *lock1,
 			    struct lock_class *lock2,
 			    unsigned long ip, int distance,
 			    const struct lock_trace *trace,
-			    struct lock_chain *chain)
+			    struct lock_chain *chain,
+			    int lock_type1, int lock_type2)
 {
 	struct lock_list *entry;
+
+	/*
+	 * The distance bit field in struct lock_list must be large
+	 * enough to hold the maximum lock depth.
+	 */
+	BUILD_BUG_ON((1 << (32 - 2*LOCK_TYPE_BITS)) < MAX_LOCK_DEPTH);
+
 	/*
 	 * Lock not present yet - get a new dependency struct and
 	 * add it to the list:
@@ -1394,6 +1402,8 @@ static int add_lock_to_list(struct lock_class *lock1,
 	entry->class[1] = lock2;
 	entry->distance = distance;
 	entry->trace = trace;
+	entry->lock_type1 = lock_type1;
+	entry->lock_type2 = lock_type2;
 
 	/*
 	 * Both allocation and removal are done under the graph lock; but
@@ -1537,6 +1547,16 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int forward
 	return &class->dep_list[forward];
 }
 
+static inline int get_lock_type1(struct lock_list *lock)
+{
+	return lock->lock_type1;
+}
+
+static inline int get_lock_type2(struct lock_list *lock)
+{
+	return lock->lock_type2;
+}
+
 /*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
@@ -2580,7 +2600,8 @@ static inline void inc_chains(void)
 	 * dependency list of the previous lock <prev>:
 	 */
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       next->acquire_ip, distance, *trace, chain);
+			       next->acquire_ip, distance, *trace, chain,
+			       prev->read, next->read);
 	if (!ret)
 		return 0;
 
-- 
1.8.3.1

