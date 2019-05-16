Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A87C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63C220881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0XtiUFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEPIAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37045 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id p15so1223497pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIveG1D7r7idiQG14j1Qu/8FicgeCmdaO791tOVIC/o=;
        b=r0XtiUFap0XXt2eMGFhzNjgzKrjxz+MK4MKYgXMK1xW1CkNzzVXBHXlQf4NZP3j3sg
         0aRa7msT0O27es+4KSZBiglhDAdId2//zLJPUS5IZl8ElatDgo1ttfTNXYFbNry2Pjy9
         EA0dfTzdG8CjN6HhHOpyYU1sDHe5cyGsVQS1V6mtgrTaE1GpGVi0LY0HcATcG8zRPKDt
         Zg6QgB/AnEaTFToCJiDyYS/DjuBYlo3iUyfL0Ua1ZeguvLLn0+uWveE5AL+y49CN9HlG
         yXV2rIS/MnBXKnZZ/OCgQpXyv7T+lvU+UXQl1Vt7G9TIMjzn33L6kjnBMJNpAzCpgBm1
         0DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIveG1D7r7idiQG14j1Qu/8FicgeCmdaO791tOVIC/o=;
        b=AI45owlw8NIbPUo/9s54tBbVTkNi/9KDW+yOzJKMcPZplidZCSkTtxWPybW+3hiiV/
         0cJrhoCW4YYorGR3opCLJ7i/vgFnxoKb9iBlFsOk9/iMNmhT/vlYuXEWxSS3P50vZ0U7
         KZMwIZ/xcn2WcRbJHUkNTmG5W8NKJsZCGWiKFWP89EYPVJmCRtt4enNTbav9tqU2nwIj
         u/eEw1gTCEes3O2yEMVLLldXlyYqu3Aq+6Sdwf8N+9TiwGvCByi53XcCPmEdzYO9t1KG
         TD0dh++8p5Qcxsn8gdY0ODygML2NahO/ZnIzDlJCVgcajA1GmnSMeSsso/Auj5olPr/6
         3z7A==
X-Gm-Message-State: APjAAAVsDLMpkeTqjQXCKa2PHos+6FK7KUSLMiD5P5yLVuDYNdWRIQDv
        KJN5vC2h5Lj/JxpYkSHRBhs=
X-Google-Smtp-Source: APXvYqyfkuSWaKjiQletyzlB80FHEwLiftkuKnjfHle75K2K+PNcOFEOfT9Ovl7O8UwSvYhzJSgagg==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr26110168pls.146.1557993630692;
        Thu, 16 May 2019 01:00:30 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:30 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 02/17] locking/lockdep: Add read-write type for dependency
Date:   Thu, 16 May 2019 16:00:00 +0800
Message-Id: <20190516080015.16033-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct dependency needs to keep track of its locks' read-write types. A
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
endianness, so use helper functions to operate on these types.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h            | 12 ++++++++++++
 kernel/locking/lockdep.c           | 34 +++++++++++++++++++++++++++++++---
 kernel/locking/lockdep_internals.h |  3 +++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1009c47..bc09c85 100644
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
index fb6be63..e7eedbf 100644
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

