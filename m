Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF0C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1B520848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfERA6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 20:58:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:33935 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfERA6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 20:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 17:58:37 -0700
X-ExtLoop1: 1
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2019 17:58:33 -0700
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Ingo Molnar <mingo@kernel.org>, Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
 <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com>
 <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
 <20190429061422.GA20939@gmail.com>
 <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
 <20190429160058.GA82935@gmail.com>
 <CAERHkrvhggb8nkGOx1GHUftGhh5b0qLvq4HvuHJreNrRC1RXow@mail.gmail.com>
 <20190430044250.GC73609@gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <9489d9e4-1dae-fc84-53eb-beb0c1418c0f@linux.intel.com>
Date:   Sat, 18 May 2019 08:58:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190430044250.GC73609@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/30 12:42, Ingo Molnar wrote:
> 
>>> What's interesting is how in the over-saturated case (the last three
>>> rows: 128, 256 and 512 total threads) coresched-SMT leaves 20-30% CPU
>>> performance on the floor according to the load figures.
>>

Sorry for a delay, I got a chance to obtain some profiling results. Here
is the story on my side. I still used the previous testing 128/128 case
(256 threads totally), and focus on CPU53(randomly pickup) only.

Firstly, mpstat reports cpu utilization,
- baseline is 100%,
- coresched-SMT is 87.51%

Then I traced sched_switch trace point, in 100s sampling period,
- baseline context switch 14083 times, next task idle 0 times
- coresched-SMT context switch 15101 times, next task idle 880 times

So I guess pick_next_task() is mostly the interesting place, then I
dig into the trace log on coresched-SMT case:
- CPU53 selected idle task 767 times (matched with the data of sched_switch)

There are 3 branches of CPU53 selecting idle task in pick_next_task():
- pick pre selected 765 times
- unconstrained pick 1 times
- picked: swapper/53/0 1 times

Where CPU53's "pick pre selected idle task" from? I guess its from its
brother CPU1, so I checked CPU1's trace log and found:
- CPU1 helped its sibling CPU53 select idle task 800 times

So for CPU53, the most interesting part occurs in pick_task(), that is:
-The sibling CPU1 helped to select idle task in pick_task()

Forgive me to paste this routine() here:
=====================================================
+// XXX fairness/fwd progress conditions
+static struct task_struct *
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+{
+	struct task_struct *class_pick, *cookie_pick;
+	unsigned long cookie = 0UL;
+
+	/*
+	 * We must not rely on rq->core->core_cookie here, because we fail to reset
+	 * rq->core->core_cookie on new picks, such that we can detect if we need
+	 * to do single vs multi rq task selection.
+	 */
+
+	if (max && max->core_cookie) {
+		WARN_ON_ONCE(rq->core->core_cookie != max->core_cookie);
+		cookie = max->core_cookie;
+	}
+
+	class_pick = class->pick_task(rq);
+	if (!cookie)
+		return class_pick;
+
+	cookie_pick = sched_core_find(rq, cookie);
+	if (!class_pick)
+		return cookie_pick;
+
+	/*
+	 * If class > max && class > cookie, it is the highest priority task on
+	 * the core (so far) and it must be selected, otherwise we must go with
+	 * the cookie pick in order to satisfy the constraint.
+	 */
+	if (cpu_prio_less(cookie_pick, class_pick) && core_prio_less(max, class_pick))
+		return class_pick;
+
+	return cookie_pick;
+}
=================================================================

And the most related log of the case:
=================================================================
<...>-21553 [001] dN.. 87341.514992: __schedule: cpu(1): selected: gemmbench/21294 ffff888823df8900
<...>-21553 [001] dN.. 87341.514992: __schedule: max: gemmbench/21294 ffff888823df8900
<...>-21553 [001] dN.. 87341.514995: __schedule: (swapper/53/0;140,0,0) ?< (sysbench/21503;140,457178607302,0)
<...>-21553 [001] dN.. 87341.514996: __schedule: (gemmbench/21294;119,219715519947,0) ?< (sysbench/21503;119,457178607302,0)
<...>-21553 [001] dN.. 87341.514996: __schedule: cpu(53): selected: swapper/53/0 0

It said,
- CPU1 selected gemmbench for itself
- and gemmbench was assigned to max of this core
- then CPU1 helped CPU53 to pick_task()
-- CPU1 used class->pick_task(), selected sysbench for CPU53
-- CPU1 used cookie_pick, selected swapper(idle task) for CPU53
-- the class_pick(sysbench) unfortunately didn't pass the priority check
- idle task picked up at the end(sadly).

So, I think if we want to improve CPU utilization under this scenario,
the straightforward tweak is picking up class_pick if cookie_pick is idle.
But I know, this is a violation of the design philosophy(avoid L1TF) of
this proposal.

Does it make sense to add a knob to switch security/performance?
Welcome any comments!

Thanks,
-Aubrey
