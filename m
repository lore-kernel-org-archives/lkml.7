Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC41CC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B732C2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6Kn+zOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfKFWOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:14:53 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53166 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfKFWOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:14:53 -0500
Received: by mail-pf1-f202.google.com with SMTP id 20so20124443pfp.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IPMIOrfkbztQvBBjOpcxydJjIPwlGr0+tNILSWIQfrc=;
        b=T6Kn+zOqyFKAHoVesTBAS24L/v9IdGIWkQVkED4AYTkcFW3RmKiYxAwmciiMVx+5AB
         jOQm+7/9naeXuNQRjJhU4bYF1BZMBeeXq8oNIoTm1L8+07qbZLd9ToitDDhUpOIetBV+
         S99DKw9fOinea2fHm0oZrULs2LerEsQ7/BZvnFLm4QQDAkjVdW63+xdr+sZMVrQRnVfc
         tpYGFcQlI49SyeXTcAfXKhLKOQsQCs+bmK1imNsTkZjEY8UwctNU+NFs+XqCKCpng+SB
         LuPXfuEjAZ4W9cc8E+u+4GwhQQRFTc/Yk8wFbNql6LUw7G2nw/wwI0OAGNBSQLMpsnU+
         5PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IPMIOrfkbztQvBBjOpcxydJjIPwlGr0+tNILSWIQfrc=;
        b=QXbU2ZSPhLfmZsO5Sx63s9ieCLiqjm8ywtkmqu8lz8N4kTCAo+9ZP0odGn6s8/js5H
         1y7hfaZSkM3+t8T/ghOwQIt/4lP/LFI2XBRcxln46n9vUf5g11+A/yiAV/hHITHk1Ahg
         WBjNnD3FFg24HKJOc/nyxm4aMt5Rt40nMogMrPIeos3XJayoWkBmCFCnA5N3XBREey/F
         mElk/EzLGpotR4TzoOjyLq76DGI+n0hXWDiEbqLLcPNfTBkN2R/qTRKoVGGUGRtR9s6N
         2afZPJL+9YIaXNcP/SV35vnc/Gi8AToWkVTb/UjB+TX6nX9AJ0XgghVGW0pgp7HVm2Be
         bCXQ==
X-Gm-Message-State: APjAAAURFpy1fKrhGsgHSl9mGpTGxnE1bniOfnW9DdjmHwLvllgjhbbd
        tjgri3aEcU/blOUqE6sbujHikdLkR0i9
X-Google-Smtp-Source: APXvYqyC+RKfGLp/NjiRd2RNyjgQg8cvc0NPNPvCfeDrzzAYk+blCPqqRuY7gazJNip0HImkjA9M+VWQi4qe
X-Received: by 2002:a63:d0d:: with SMTP id c13mr217521pgl.138.1573078490828;
 Wed, 06 Nov 2019 14:14:50 -0800 (PST)
Date:   Wed,  6 Nov 2019 14:14:48 -0800
In-Reply-To: <CAKfTPtDeMevgn0JFxjzUWhp4dS10T2MQSA9P82nOGX73xUjXoA@mail.gmail.com>
Message-Id: <20191106221448.225183-1-joshdon@google.com>
Mime-Version: 1.0
References: <CAKfTPtDeMevgn0JFxjzUWhp4dS10T2MQSA9P82nOGX73xUjXoA@mail.gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
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
Changelog since v1:
- As an optimization, skip clearing the skip buddy up the hierarchy
- Due to the above, it makes sense to inline __clear_buddies_skip; while
  we're at it, inline the other __clear_buddies* functions as well.

 kernel/sched/fair.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754ea3e1..dbac30e3cc08 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4010,7 +4010,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	}
 }
 
-static void __clear_buddies_last(struct sched_entity *se)
+static inline void __clear_buddies_last(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -4021,7 +4021,7 @@ static void __clear_buddies_last(struct sched_entity *se)
 	}
 }
 
-static void __clear_buddies_next(struct sched_entity *se)
+static inline void __clear_buddies_next(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -4032,15 +4032,12 @@ static void __clear_buddies_next(struct sched_entity *se)
 	}
 }
 
-static void __clear_buddies_skip(struct sched_entity *se)
+static inline void __clear_buddies_skip(struct sched_entity *se)
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
@@ -4051,8 +4048,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (cfs_rq->next == se)
 		__clear_buddies_next(se);
 
-	if (cfs_rq->skip == se)
-		__clear_buddies_skip(se);
+	__clear_buddies_skip(se);
 }
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -6647,8 +6643,15 @@ static void set_next_buddy(struct sched_entity *se)
 
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
2.24.0.rc1.363.gb1bccd3e3d-goog

