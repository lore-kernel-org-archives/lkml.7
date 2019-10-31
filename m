Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF8CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647712086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUSQhNBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfJaSpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:45:40 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33142 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbfJaSpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:45:40 -0400
Received: by mail-qt1-f201.google.com with SMTP id k53so7290408qtk.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8ALf84QyJ21Yy83EcsBZYx0R5ySmANW7J5oD5E9Gtsc=;
        b=WUSQhNBAOxFkVi7Km6IbhgY+FLELPn8N20pipsZpHhKH3RIy/SdgG+EC4r8hz6fznI
         ONaTeM7G+L6JDvf1deTj/CWq/4QnIhe06e4mRHS0LJBKW6lnhRj1U5zKz3skyHMfQAL4
         uCiHZQNIq31Oqil/PmGKreOtZD8dJ3Kl+FTCWChnThvafmwBdxQft7VGFUXTzNsc1YUm
         yCtbC9D652rQpFqNbUUvXQRM3WVxgYNtD/cMH9VxH+oahlNo4QM4tlFDkrBt+kBZ6aJG
         0Wg9w6eYhkaryFrrwuwP3QezYuQXYrcGh/RqeBKBQoznD8OvZz5ByenyMAYvDajZ1yW2
         8eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8ALf84QyJ21Yy83EcsBZYx0R5ySmANW7J5oD5E9Gtsc=;
        b=t06D7L3knSkPohtir/XgChK+rbnB0YbtgnHAs5CIr7IGNU5hzyiQcqZ/ytbRfQ+rOm
         eAripJ48aR7OTKBPTZG+S9IP1t2B+fB9GLrN9Fctotuz+bMtzUdtmj+TqZBJc0dqWZEv
         uDhhVyR/X1/PM826ry2EDe8hsUZt4/4vSkdmxz9tyb23u4LDsNLST8bRS6NGU95ycbHE
         tRWC5qTf41HzoJ/E/9ZDGUO19gfDYbIned1yBf07EAQ9D8Wv6yQyaEQxOycecUWvpNwX
         M83PbQ9IuWIjLMiL/zlqdPvg3TRZvSPrP1+Hf9fAwvIXBuGGKhX4fsFhYEeM2uNYDlyn
         YSaw==
X-Gm-Message-State: APjAAAUP4vmD9TuxwoCBuTg2prjpM7YsNPf2+HoUtZnEiHJmQ/lo6qaL
        7lbeb3Rh5BvUv5DN1PYyV8ceVJVEXZ14
X-Google-Smtp-Source: APXvYqxC7GbWTz0du6BFDrnwZDCsKhQAuGQ3BE9WEG+eJ2qywFvKJtEnZhEVSc14ueeltWSYJl5Lcq1pI75/
X-Received: by 2002:ad4:5345:: with SMTP id v5mr6154067qvs.217.1572547538807;
 Thu, 31 Oct 2019 11:45:38 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:45:33 -0700
Message-Id: <20191031184533.67118-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] sched/fair: Do not set skip buddy up the sched hierarchy
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Paul Turner <pjt@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Venkatesh Pallipadi <venki@google.com>,
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
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754ea3e1..52ab06585d7f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6647,8 +6647,15 @@ static void set_next_buddy(struct sched_entity *se)
 
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
2.23.0.700.g56cf767bdb-goog

