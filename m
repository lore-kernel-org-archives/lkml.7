Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D89AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220E920830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GtoxyAql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfEFTjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:39:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37152 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEFTjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:39:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id c1so1707846qkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UGEz3fWycUgCm3CTVXnJ8VB+4V/aEaS9OHGlagcNT3w=;
        b=GtoxyAqlX8ao4lfdNBXQNbghqeB5mdYdSHE6+oOvTAADrPn7MD/4h1DwMjf7d8anHk
         gAE+WPLMRo3xq6a2IppPzGODTA+YtB4QXzJRAZtalaUQdtAqQQhj4UdB52ONS09XkUZ7
         HjoTOoNrlhOv6md9DdSq577a4K4Il+7OsXaFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UGEz3fWycUgCm3CTVXnJ8VB+4V/aEaS9OHGlagcNT3w=;
        b=BWlWcHTg7CBqnfGjTMvJx7Cfy9ir+/fyM25vHiV3jZYrNp8yJUFB1Gi2prD2QQiygl
         zsAguYI3koKlpzKGB3xjOWpjFeYPMRLhF7/gmYgOwfS1Aic7NesFeaXtHtKA3/dgaMAp
         oDCNdKGDMJY0cZ2ivYPDdy6N4KXn2MTtVZfQuhRmx2DkeUoLjS1yhiS2+EtkASRvsf7J
         gbj8jd6JVEMjZbrgrsGQqV1lzbZ6jPOY7y9kpc9ZuuAqj8/zcLRXR70NuHh9fGM2VkM6
         ZmPbn3KBQqSDBHpu8p/tN8jVkohNRA2z7xeaI2bF2z5u9c02xqaAJNzobOEVP+bIk8Fd
         L0EA==
X-Gm-Message-State: APjAAAWK2uf8wCADDS08AVTOGaJXMHBv++M+jAVnUNtOcwhISihf03xG
        Ge1/DTfpvRlWm7Jic8ay9egxyFyHxVbAbA==
X-Google-Smtp-Source: APXvYqwyq8jFML8zMYUxtDujoxQfKMx8tPU5Rj5CX+BHLXzqcqn9EcmHjkx5PkQdJrtlTVgY1RvOSw==
X-Received: by 2002:a37:a005:: with SMTP id j5mr11051937qke.331.1557171587271;
        Mon, 06 May 2019 12:39:47 -0700 (PDT)
Received: from sinkpad (modemcable077.38-81-70.mc.videotron.ca. [70.81.38.77])
        by smtp.gmail.com with ESMTPSA id f1sm4770399qta.10.2019.05.06.12.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 12:39:46 -0700 (PDT)
Date:   Mon, 6 May 2019 15:39:37 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190506193937.GA10264@sinkpad>
References: <20190423180238.GG22260@pauld.bos.csb>
 <20190423184527.6230-1-vpillai@digitalocean.com>
 <20190429035320.GB128241@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190429035320.GB128241@aaronlu>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Apr-2019 11:53:21 AM, Aaron Lu wrote:
> On Tue, Apr 23, 2019 at 06:45:27PM +0000, Vineeth Remanan Pillai wrote:
> > >> - Processes with different tags can still share the core
> > 
> > > I may have missed something... Could you explain this statement?
> > 
> > > This, to me, is the whole point of the patch series. If it's not
> > > doing this then ... what?
> > 
> > What I meant was, the patch needs some more work to be accurate.
> > There are some race conditions where the core violation can still
> > happen. In our testing, we saw around 1 to 5% of the time being
> > shared with incompatible processes. One example of this happening
> > is as follows(let cpu 0 and 1 be siblings):
> > - cpu 0 selects a process with a cookie
> > - cpu 1 selects a higher priority process without cookie
> > - Selection process restarts for cpu 0 and it might select a
> >   process with cookie but with lesser priority.
> > - Since it is lesser priority, the logic in pick_next_task
> >   doesn't compare again for the cookie(trusts pick_task) and
> >   proceeds.
> > 
> > This is one of the scenarios that we saw from traces, but there
> > might be other race conditions as well. Fix seems a little
> > involved and We are working on that.
> 
> This is what I have used to make sure no two unmatched tasks being
> scheduled on the same core: (on top of v1, I thinks it's easier to just
> show the diff instead of commenting on various places of the patches :-)

We imported this fix in v2 and made some small changes and optimizations
(with and without Peter’s fix from https://lkml.org/lkml/2019/4/26/658)
and in both cases, the performance problem where the core can end up
idle with tasks in its runqueues came back.

This is pretty easy to reproduce with a multi-file disk write benchmark.

Here is the patch based on your changes applied on v2 (on top of Peter’s
fix):

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 07f3f0c..e09fa25 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3653,6 +3653,13 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 }
 
 // XXX fairness/fwd progress conditions
+/*
+ * Returns
+ * - NULL if there is no runnable task for this class.
+ * - the highest priority task for this runqueue if it matches
+ *   rq->core->core_cookie or its priority is greater than max.
+ * - Else returns idle_task.
+ */
 static struct task_struct *
 pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
 {
@@ -3660,19 +3667,36 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	unsigned long cookie = rq->core->core_cookie;
 
 	class_pick = class->pick_task(rq);
-	if (!cookie)
+	if (!class_pick)
+		return NULL;
+
+	if (!cookie) {
+		/*
+		 * If class_pick is tagged, return it only if it has
+		 * higher priority than max.
+		 */
+		if (max && class_pick->core_cookie &&
+		    core_prio_less(class_pick, max))
+			return idle_sched_class.pick_task(rq);
+
+		return class_pick;
+	}
+
+	/*
+	 * If there is a cooke match here, return early.
+	 */
+	if (class_pick->core_cookie == cookie)
 		return class_pick;
 
 	cookie_pick = sched_core_find(rq, cookie);
-	if (!class_pick)
-		return cookie_pick;
 
 	/*
 	 * If class > max && class > cookie, it is the highest priority task on
 	 * the core (so far) and it must be selected, otherwise we must go with
 	 * the cookie pick in order to satisfy the constraint.
 	 */
-	if (cpu_prio_less(cookie_pick, class_pick) && core_prio_less(max, class_pick))
+	if (cpu_prio_less(cookie_pick, class_pick) &&
+	    (!max || core_prio_less(max, class_pick)))
 		return class_pick;
 
 	return cookie_pick;
@@ -3742,8 +3766,16 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		rq_i->core_pick = NULL;
 
-		if (i != cpu)
+		if (i != cpu) {
 			update_rq_clock(rq_i);
+
+			/*
+			 * If a sibling is idle, we can initiate an
+			 * unconstrained pick.
+			 */
+			if (is_idle_task(rq_i->curr) && prev_cookie)
+				prev_cookie = 0UL;
+		}
 	}
 
 	/*
@@ -3820,12 +3852,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
-			 * the slate and start over.
+			 * the slate and start over. pick_task makes sure that
+			 * p's priority is more than max if it doesn't match
+			 * max's cookie.
 			 *
 			 * NOTE: this is a linear max-filter and is thus bounded
 			 * in execution time.
 			 */
-			if (!max || core_prio_less(max, p)) {
+			if (!max || !cookie_match(max, p)) {
 				struct task_struct *old_max = max;
 
 				rq->core->core_cookie = p->core_cookie;
@@ -3833,7 +3867,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
 
-				if (old_max && !cookie_match(old_max, p)) {
+				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
@@ -3879,6 +3913,23 @@ next_class:;
 
 	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
+	/* make sure we didn't break L1TF */
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+		if (i == cpu)
+			continue;
+
+		if (likely(cookie_match(next, rq_i->core_pick)))
+			continue;
+
+		trace_printk("[%d]: cookie mismatch. %s/%d/0x%lx/0x%lx\n",
+			     rq_i->cpu, rq_i->core_pick->comm,
+			     rq_i->core_pick->pid,
+			     rq_i->core_pick->core_cookie,
+			     rq_i->core->core_cookie);
+		WARN_ON_ONCE(1);
+	}
+
 done:
 	set_next_task(rq, next);
 	return next;

