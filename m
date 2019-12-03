Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF20C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28962054F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCKap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:30:45 -0500
Received: from foss.arm.com ([217.140.110.172]:40176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfLCKap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:30:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE3C930E;
        Tue,  3 Dec 2019 02:30:44 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31B9F3F68E;
        Tue,  3 Dec 2019 02:30:44 -0800 (PST)
Subject: Re: Crash in fair scheduler
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1575364273836.74450@mentor.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <564e45cb-8230-9c3d-24a8-b58e6e88349f@arm.com>
Date:   Tue, 3 Dec 2019 10:30:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1575364273836.74450@mentor.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 09:11, Schmid, Carsten wrote:
[...]

> set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
> {
> 	/* 'current' is not kept within the tree. */
> 	if (se->on_rq) { <<<<<<< crash here
> 
> set_next_entity is called from within pick_next_task_fair, from the following piece of code:
> static struct task_struct *
> pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> {
> 	struct cfs_rq *cfs_rq = &rq->cfs;
> 	struct sched_entity *se;
> 	struct task_struct *p;
> 	int new_tasks;
> 
> again:
> 	if (!cfs_rq->nr_running) // this is 1, so we are not going to idle
> 		goto idle;
> 
> #ifdef CONFIG_FAIR_GROUP_SCHED
> 	if (prev->sched_class != &fair_sched_class) <<<<< this is true:
> 							crash> p &fair_sched_class
> 							$1 = (const struct sched_class *) 0xffffffffaaa10cc0 <<<<
> 							crash> $prev=ffff99a97895a580
> 							crash> gdb set $prev=(struct task_struct *)0xffff99a97895a580
> 							crash> p $prev->sched_class
> 							$2 = (const struct sched_class *) 0xffffffffaaa10b40 <<<<
> 		goto simple; <<<< so we go to simple
> ....
> (Line 6360, Kernel 4.14.86; Line 6820 Kernel v5.4-rc2)
> simple:
> #endif
> 
> 	put_prev_task(rq, prev);
> 
> 	do {
> 		se = pick_next_entity(cfs_rq, NULL); <<<< this returns se=NULL
> 		set_next_entity(cfs_rq, se); <<<<<<<< here we crash
> 		cfs_rq = group_cfs_rq(se);
> 	} while (cfs_rq);
> 
> So why is se = NULL returned?


That looks a lot like a recent issue we've had, see

  https://lore.kernel.org/lkml/20191108131909.428842459@infradead.org/

The issue is caused by
  
  67692435c411 ("sched: Rework pick_next_task() slow-path")

which 5.4-rc2 has (without the fix which landed in -rc7) but 4.14 really
shouldn't, unless the kernel you're using has had core scheduling somehow
backported to it?

I've only scraped the surface but I'd like to first ask: can you reproduce
the issue on v5.4 final ?

> Best regards
> Carsten
> 
