Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF509C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6092089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QhJs4+Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbfEVTw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:52:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44452 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfEVTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:52:54 -0400
Received: by mail-io1-f65.google.com with SMTP id f22so2870863iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=T9AT3ewsIMuqVzvKAv4Pbte5aWAILvVS0O3ClTcUnH0=;
        b=QhJs4+DiM9KiqkRX/zaC3TYGhWSNTKY6D8A6eQJnRYVZBskt7HF9pvrb0ko9oz4mR1
         0D4a4fKhJXc3w1PCZX7Or99GkQ4tuEVTCuqs837ZdTeqFoEG0q8B2l/GB41fyF8uRXX7
         AXkxRtRmEji+5FDtoRlGhEAykeGAJT6uM5TDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=T9AT3ewsIMuqVzvKAv4Pbte5aWAILvVS0O3ClTcUnH0=;
        b=V1Dq70+xIfcpsOTmo/0ud7PeSOb4TfPxz0EjmFaOtGGlKGdpJnE4+bK0HKQ/uvLknK
         sSWSt5WqqnYFfE2FVqMQNrCGgGkPuTb3oVNXhjjr7QOYUraTvT3O58rGFM+c1wha9jJz
         asmbcnauP5ysNzqZDhO2A5hyARq9pTf1m6AyfKOeeeKOkjXWlw8ZRQc3vLDVmF8FKLTN
         NxlSxbCNVfpv9pq4brNwk07aziV0BpMd3JwWRpvowPGTujm0TNZ0m+igu8Gwxvqn9z6G
         0Igz1SWyvhxf/M8PMzZSuoAEnBlhRESchIwDew9gmulP10G2e0Vrv4NcvZyQcKGpdMl3
         yIiQ==
X-Gm-Message-State: APjAAAUBkt0b/MbcPMaT5scnpFFiz7/F6SI1WxyuHSZtBLXkhW1Pat0h
        ApzOi4aRUfs2JVHpeTQvw15SJA==
X-Google-Smtp-Source: APXvYqyNfY0C3T3eM9AVsvjdozGUOjXJ0nDVN8kr9dE5BzkPRDtuFtHJxj5FrZb1vCnazD0rv+vYUQ==
X-Received: by 2002:a05:6602:218d:: with SMTP id b13mr34776530iob.96.1558554773662;
        Wed, 22 May 2019 12:52:53 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id 69sm2973679itl.7.2019.05.22.12.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 12:52:52 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.intel@gmail.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Date:   Wed, 22 May 2019 19:52:49 +0000
Message-Id: <20190522195249.21168-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425143506.GB979@pauld.bos.csb>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I do not have a strong opinion on both. Probably a better approach
> > would be to replace both cpu_prio_less/core_prio_less with prio_less
> > which takes the third arguement 'bool on_same_rq'?
> >
>
> Fwiw, I find the two names easier to read than a boolean flag. Could still
> be wrapped to a single implementation I suppose.
>
> An enum to control cpu or core would be more readable, but probably overkill...
>
I think we can infact remove the boolean altogether and still have a single
function to compare the priority. If tasks are on the same cpu, use the task's
vruntime, else do the normalization.

Thanks,
Vineeth

---
-static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool core_cmp)
+static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 {
-	u64 vruntime;
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
@@ -119,25 +105,21 @@ static inline bool __prio_less(struct task_struct *a, struct task_struct *b, boo
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	vruntime = b->se.vruntime;
-	if (core_cmp) {
-		vruntime -= task_cfs_rq(b)->min_vruntime;
-		vruntime += task_cfs_rq(a)->min_vruntime;
-	}
-	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
+	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
+		u64 vruntime = b->se.vruntime;
 
-	return false;
-}
+		/*
+		 * Normalize the vruntime if tasks are in different cpus.
+		 */
+		if (task_cpu(a) != task_cpu(b)) {
+			vruntime -= task_cfs_rq(b)->min_vruntime;
+			vruntime += task_cfs_rq(a)->min_vruntime;
+		}
 
-static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
-{
-	return __prio_less(a, b, false);
-}
+		return !((s64)(a->se.vruntime - vruntime) <= 0);
+	}
 
-static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
-{
-	return __prio_less(a, b, true);
+	return false;
 }
 
 static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
@@ -149,7 +131,7 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 		return false;
 
 	/* flip prio, so high prio is leftmost */
-	if (cpu_prio_less(b, a))
+	if (prio_less(b, a))
 		return true;
 
 	return false;
@@ -3621,7 +3603,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 		 * higher priority than max.
 		 */
 		if (max && class_pick->core_cookie &&
-		    core_prio_less(class_pick, max))
+		    prio_less(class_pick, max))
 			return idle_sched_class.pick_task(rq);
 
 		return class_pick;
@@ -3640,8 +3622,8 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	 * the core (so far) and it must be selected, otherwise we must go with
 	 * the cookie pick in order to satisfy the constraint.
 	 */
-	if (cpu_prio_less(cookie_pick, class_pick) &&
-	    (!max || core_prio_less(max, class_pick)))
+	if (prio_less(cookie_pick, class_pick) &&
+	    (!max || prio_less(max, class_pick)))
 		return class_pick;
 
 	return cookie_pick;

