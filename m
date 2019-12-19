Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E37FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAFC2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1SOj+6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLSAOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:14:21 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:35354 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:14:21 -0500
Received: by mail-pj1-f73.google.com with SMTP id l8so2174188pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dtYJGhXvidGK6sDcgxIhyPPLb4WJNKOiIKfjLPl0mNY=;
        b=u1SOj+6QXy3P3+I/a6pnKxQFl4cXlIVvppy9KcSbvMrci41+XkyOO9nhDVV3SfXH+2
         F82sj9a0EAqRVy/qvV/wLyH5CIu0INQyIx4q83KGmNAlwdzBIV4Z8X+NcSGsdIfHDg68
         WjGqWQz1Q+dF9AKR2seYRjCp1Rchj0kdKPTHJgYIGBrIaMWnUv9GIBG+eSn+CUEzxDkc
         aiSFz8me8cD0M1Ryh5bAt/H8TjWG4UP+MNXhPuM/dU4SUCO/f7fgnBTgA8rCGV1HKtP6
         XOOzJi6CIFzZYrZd45wAiSPQVOohNPBM8ejWrSuIafIgRilYXtQmF/Wiykx/2diSm+TH
         fZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dtYJGhXvidGK6sDcgxIhyPPLb4WJNKOiIKfjLPl0mNY=;
        b=ll7XpSx0R8zUKQtAtTMTHLkxjBxqAo2xhca1uriG67+AKYSVjoJ4ZiPD0Wt6am6+Em
         SYUc/osjTDs+N4fp2JgUKaE/vcL+/BoOSnv29um/oUperKP9TNrEdKOnYNjNciySvgOH
         mIbif9W9i195eievh3DgDNZhMizVJLg6zeH1hBRTq4fK+tkW/6cU0nRIvBiqWs1cR6Ly
         zAfpd4rzbSo7oV9tQ5G1PL+vezerHzj3KN24DKIUkHlknLhO9Fwtx9/49GQ5T15CtUAX
         A6eylWWJ0Q1pFnL1G7zj5jHNRZcGTPa6VNU/a6si05X7GqKJ0iTZ7dtkYa9x8eL33a+z
         aaPg==
X-Gm-Message-State: APjAAAWU5XoqrQCFwgFdsH3rQPXF8xJD155CPgLrn2yUotc6AQU1yqxh
        YnvJTm/wfqj8exH2SLLsHjooBFd57+aQ
X-Google-Smtp-Source: APXvYqx5rnZyJOtyJD2Pdt6oOskd+lhDAHxj0O1q5IhECLwAirOICGf3R3TR8LXjPPAHvpZ7QzGyZj4fGksr
X-Received: by 2002:a63:d848:: with SMTP id k8mr5011243pgj.114.1576714460207;
 Wed, 18 Dec 2019 16:14:20 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:14:18 -0800
In-Reply-To: <CABk29NvMS87uGnFRWoN3Ce0t+UQ--qnjRmQCPJCCEcSASs25uQ@mail.gmail.com>
Message-Id: <20191219001418.234372-1-joshdon@google.com>
Mime-Version: 1.0
References: <CABk29NvMS87uGnFRWoN3Ce0t+UQ--qnjRmQCPJCCEcSASs25uQ@mail.gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3] sched/fair: Do not set skip buddy up the sched hierarchy
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

Setting the skip buddy up the hierarchy effectively means that a thread
calling yield will also end up skipping the other tasks in its hierarchy
as well. However, a yielding thread shouldn't end up causing this
behavior on behalf of its entire hierarchy.

For typical uses of yield, setting the skip buddy up the hierarchy is
counter-productive, as that results in CPU being yielded to a task in
some other cgroup.

So, limit the skip effect only to the task requesting it.

Co-developed-by: Josh Don <joshdon@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
v2: Only clear skip buddy on the current cfs_rq

v3: Modify comment describing the justification for this change.

 kernel/sched/fair.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..0056b57d52cb 100644
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
@@ -6552,8 +6549,12 @@ static void set_next_buddy(struct sched_entity *se)
 
 static void set_skip_buddy(struct sched_entity *se)
 {
-	for_each_sched_entity(se)
-		cfs_rq_of(se)->skip = se;
+	/*
+	 * Only set the skip buddy for the task requesting it. Setting the skip
+	 * buddy up the hierarchy would result in skipping all other tasks in
+	 * the hierarchy as well.
+	 */
+	cfs_rq_of(se)->skip = se;
 }
 
 /*
-- 
2.24.1.735.g03f4e72817-goog

