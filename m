Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2318C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A705E2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ffU+/r87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfEOVgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:36:22 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40088 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfEOVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:36:20 -0400
Received: by mail-it1-f196.google.com with SMTP id g71so2624338ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=VaWf0DxIsOtL+gqSFvbvPp/cnPVSa14UAEkBKFBaqXI=;
        b=ffU+/r87dbpaPRq5YHsmfE0ImMbB8D9LGnIe6cpu1TnWNk65Ih3zk5sYT4o8CLP5/v
         fr1oCo4e+oIZxxN0aRLtLlFRshWWwJ/pUMkXhB11RRR81c+ZIYdxxAB4ddpHq1PG9sok
         92icO5vFUhwzULQCNteZkYVYYbhNdoa83KqBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=VaWf0DxIsOtL+gqSFvbvPp/cnPVSa14UAEkBKFBaqXI=;
        b=oN3TJHckop099gsEGDFyd6WkO7LuXoVKj6gxpRT5V0IpoqkikNrA/9VQdJsuDGzu74
         IAWpqnXuaHksAVHzEp8PYPpYS/FZ+tM+hYl7dRqYXdKVRBidVfttuRk0SNu8+IkuNlGc
         /+bw+JkoPmaOYwMvAnetMQN9pggbZiS0SwxqgzMdawcUUIzAopZcdwYAfzcJVYTOwVO8
         nsaFlYBwz0AQqkYHUDbl20ajrBHDqxRZ52ippays6q3TfHBsgJdFgh0gy7hHEY369OxX
         7cKyeR81J9kyGe0JMlAOm7bHDIM2nLa1NQ0LgDLXqSEHHDnDzQt6N9JNGDNPOFSSNASr
         bLMA==
X-Gm-Message-State: APjAAAWn8DVtt0E48TFLp8QCI3jyH8XsTIZcpkYM1DMV02lSeroLpFur
        t5Q6nax4WzO5KCOZm12roud9vA==
X-Google-Smtp-Source: APXvYqxcrFyqqmWKVg6mPQh7bu/HAuvPzdx9L91ncJ2iUbuIHuigKAavrdufUH4pLl9ag+Ft3idRqg==
X-Received: by 2002:a24:fd41:: with SMTP id m62mr9673327ith.67.1557956178553;
        Wed, 15 May 2019 14:36:18 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id i195sm713647ite.41.2019.05.15.14.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 14:36:18 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Date:   Wed, 15 May 2019 21:36:15 +0000
Message-Id: <20190515213615.3387-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509021144.GA24577@aaronlu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's clear now, thanks.
> I don't immediately see how my isolation fix would make your fix stop
> working, will need to check. But I'm busy with other stuffs so it will
> take a while.
>
We have identified the issue and have a fix for this. The issue is
same as before, forced idle sibling has a runnable process which
is starved due to an unconstrained pick bug.

One sample scenario is like this:
cpu0 and cpu1 are siblings. cpu0 selects an untagged process 'a'
which forces idle on cpu1 even though it had a runnable tagged
process 'b' which is determined by the code to be of lesser priority.
cpu1 can go to deep idle.

During the next schedule in cpu0, the following could happen:
 - cpu0 selects swapper as there is nothing to run and hence
   prev_cookie is 0, it does an unconstrained pick of swapper.
   So both cpu0 and 1 are idling and cpu1 might be deep idle.
 - cpu0 again goes to schedule and selects 'a' which is runnable
   now. since prev_cookie is 0, 'a' is an unconstrained pick and
   'b' on cpu1 is forgotten again.

This continues with swapper and process 'a' taking turns without
considering sibling until a tagged process becomes runnable in cpu0
and then we don't get into unconstrained pick.

The above is one of the couple of scenarios we have seen and each
have a slightly different path, which ultimately leads to an
unconstrianed pick, starving the sibling's runnable thread.

The fix is to mark if a core has gone forced idle when there was a
runnable process and then do not do uncontrained pick if a forced
idle happened in the last pick.

I am attaching here wth, the patch that fixes the above issue. Patch
is on top of Peter's fix and your correctness fix that we modified for
v2. We have a public reposiory with all the changes including this
fix as well:
https://github.com/digitalocean/linux-coresched/tree/coresched

We are working on a v3 where the last 3 commits will be squashed to
their related patches in v2. We hope to come up with a v3 next week
with all the suggestions and fixes posted in v2.

Thanks,
Vineeth

---
 kernel/sched/core.c  | 26 ++++++++++++++++++++++----
 kernel/sched/sched.h |  1 +
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 413d46bde17d..3aba0f8fe384 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3653,8 +3653,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
-	unsigned long prev_cookie;
 	int i, j, cpu, occ = 0;
+	bool need_sync = false;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
@@ -3702,7 +3702,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * 'Fix' this by also increasing @task_seq for every pick.
 	 */
 	rq->core->core_task_seq++;
-	prev_cookie = rq->core->core_cookie;
+	need_sync = !!rq->core->core_cookie;
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
@@ -3711,6 +3711,11 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		rq_i->core_pick = NULL;
 
+		if (rq_i->core_forceidle) {
+			need_sync = true;
+			rq_i->core_forceidle = false;
+		}
+
 		if (i != cpu)
 			update_rq_clock(rq_i);
 	}
@@ -3743,7 +3748,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				 * If there weren't no cookies; we don't need
 				 * to bother with the other siblings.
 				 */
-				if (i == cpu && !prev_cookie)
+				if (i == cpu && !need_sync)
 					goto next_class;
 
 				continue;
@@ -3753,7 +3758,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 * Optimize the 'normal' case where there aren't any
 			 * cookies and we don't need to sync up.
 			 */
-			if (i == cpu && !prev_cookie && !p->core_cookie) {
+			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
 				rq->core_pick = NULL;
 				rq->core->core_cookie = 0UL;
@@ -3816,7 +3821,16 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					}
 					occ = 1;
 					goto again;
+				} else {
+					/*
+					 * Once we select a task for a cpu, we
+					 * should not be doing an unconstrained
+					 * pick because it might starve a task
+					 * on a forced idle cpu.
+					 */
+					need_sync = true;
 				}
+
 			}
 		}
 next_class:;
@@ -3843,6 +3857,9 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
+		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
+			rq->core_forceidle = true;
+
 		rq_i->core_pick->core_occupation = occ;
 
 		if (i == cpu)
@@ -6746,6 +6763,7 @@ void __init sched_init(void)
 		rq->core_pick = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
+		rq->core_forceidle = false;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f38d4149443b..74c29afa0f32 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -964,6 +964,7 @@ struct rq {
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
+	bool			core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
-- 
2.17.1
