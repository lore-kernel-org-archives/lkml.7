Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63786C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239FF2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8PPQms6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfLDUG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:06:27 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52582 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:06:26 -0500
Received: by mail-pl1-f201.google.com with SMTP id 62so226234ple.19
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QzM8spuJP55zBSfgdmyKlFzKEKfzJw6hEQjs+FiEARs=;
        b=f8PPQms6ztUtNN8+vwDa0hg9YM/544F+rXr57NSMtsxTkTRYGzbdtW0nZLJLQRiidW
         9CLw40Ioej6sM03bvaPfw9bJmS1ZiEUiE+vwW4/26BVx0tFPJknaJYZ9mgRjxdSqmOPh
         /LE7Wjwv4SBw+Wcw4y8IJZfKgVw5dh3xV5f9xLHRbFrl6mB2KNovOxr/WPVyltK2pzBb
         jdNT6Ed/RZv7oTl5eToxzwRQsG8p4rlHJUyXGcilQQgfKseDrrqosw50fav1RTQzImFG
         jRb9QoqvvmFhwp45D4k1nG/+siywYMY9qxqQxy3kJdGZXtI0kx7XDPsgOND434e/UB7f
         HiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QzM8spuJP55zBSfgdmyKlFzKEKfzJw6hEQjs+FiEARs=;
        b=brearM+eFCWY2DMoRRmu1DxOnvACH46Fnb+/zY0/gvGirGhTJby7p2WCMyPne2N1S6
         J5mEEYNMmxbgeD1LtP5Z2NLUAGNCxMofFQT1a8XA5yEsYynG0vVeHmoBCr5/40vGt4xy
         P/C6innVwDueCjWe1eeGiU6T0umNbCIaWOav3c8/9f05bNF0Rg09mtE6ZRtUqAmLcFsa
         XKewXVTMHmTE+N3b+AbFIyn0802XDOTObs0eZUcENJ96ygJLYl2tco4/PHD6f9hfHYZ5
         jo4naa3svHaE0XWQ3j1kNjSdfKIiF6+g1xhhjBz2OKgSy4doBy0vYpPFfB1LIagjON8O
         2SzA==
X-Gm-Message-State: APjAAAXLpVwrQ7wLjfn6nxaZeETyFoU3g5dkblajWBbjKKKJ17cPyDcT
        uz8BL1OJPiWxk/Mfvj2O6zI+OF8f/XoS
X-Google-Smtp-Source: APXvYqze6uXo1kRw4SCiKfjrAOv0bidqPuCT9DzmzG8lX1K+ftb8ZF2EOHMCFdRXp594HBhPV4gN/0Bq7JPM
X-Received: by 2002:a65:6095:: with SMTP id t21mr5151518pgu.97.1575489985794;
 Wed, 04 Dec 2019 12:06:25 -0800 (PST)
Date:   Wed,  4 Dec 2019 12:06:23 -0800
Message-Id: <20191204200623.198897-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] sched/fair: Do not set skip buddy up the sched hierarchy
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkatesh Pallipadi <venki@google.com>

Setting skip buddy all the way up the hierarchy does not play well
with intra-cgroup yield. One typical usecase of yield is when a
thread in a cgroup wants to yield CPU to another thread within the
same cgroup. For such a case, setting the skip buddy all the way up
the hierarchy is counter-productive, as that results in CPU being
yielded to a task in some other cgroup.

So, limit the skip effect only to the task requesting it.

Signed-off-by: Josh Don <joshdon@google.com>
---
v2: Only clear skip buddy on the current cfs_rq

 kernel/sched/fair.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..0b7a1958ad52 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4051,13 +4051,10 @@ static void __clear_buddies_next(struct sched_entity *se)
 
 static void __clear_buddies_skip(struct sched_entity *se)
 {
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		if (cfs_rq->skip != se)
-			break;
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+	if (cfs_rq->skip == se)
 		cfs_rq->skip = NULL;
-	}
 }
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -6552,8 +6549,15 @@ static void set_next_buddy(struct sched_entity *se)
 
 static void set_skip_buddy(struct sched_entity *se)
 {
-	for_each_sched_entity(se)
-		cfs_rq_of(se)->skip = se;
+	/*
+	 * One typical usecase of yield is when a thread in a cgroup
+	 * wants to yield CPU to another thread within the same cgroup.
+	 * For such a case, setting the skip buddy all the way up the
+	 * hierarchy is counter-productive, as that results in CPU being
+	 * yielded to a task in some other cgroup. So, only set skip
+	 * for the task requesting it.
+	 */
+	cfs_rq_of(se)->skip = se;
 }
 
 /*
-- 
2.24.0.393.g34dc348eaf-goog

