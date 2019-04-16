Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B281C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069DC2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfDPMIT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:08:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfDPMIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:08:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hGMsl-0007jW-7J; Tue, 16 Apr 2019 14:08:11 +0200
Date:   Tue, 16 Apr 2019 14:08:11 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        john.ogness@linutronix.de, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Document that RT task priorities
 are 1...99
Message-ID: <20190416120811.mqhubgsz6btwrxtk@linutronix.de>
References: <20190403210821.10916-1-bigeasy@linutronix.de>
 <tip-37a8f8590f307db8f8cfa62dfd82b3fc0978607c@git.kernel.org>
 <20190416093634.GS11158@hirez.programming.kicks-ass.net>
 <20190416094727.xanzq5t2xjuflcbt@linutronix.de>
 <20190416112235.GU11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190416112235.GU11158@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-16 13:22:35 [+0200], Peter Zijlstra wrote:
> On Tue, Apr 16, 2019 at 11:47:27AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-04-16 11:36:34 [+0200], Peter Zijlstra wrote:
> > > On Tue, Apr 16, 2019 at 01:13:11AM -0700, tip-bot for Sebastian Andrzej Siewior wrote:
> > > > Commit-ID:  37a8f8590f307db8f8cfa62dfd82b3fc0978607c
> > > > Gitweb:     https://git.kernel.org/tip/37a8f8590f307db8f8cfa62dfd82b3fc0978607c
> > > > Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > AuthorDate: Wed, 3 Apr 2019 23:08:21 +0200
> > > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > > CommitDate: Tue, 16 Apr 2019 10:06:08 +0200
> > > > 
> > > > sched/core: Document that RT task priorities are 1...99
> > > > 
> > > > John identified three files which claim that RT task priorities start at
> > > > zero. As far as I understand, 0 is used for DL and has nothing to do
> > > > wihich RT priorities as identified by the RT policy.
> > > 
> > > DL is -1, 0 is still very much FIFO/FF
> > 
> > but it can't be set. The lowest we can set is 1. Is this a bug then?
> 
> What cannot be set?
|         {
|                 struct sched_param sp;
|                 int r;
| 
|                 sp.sched_priority = 0;
|                 r = sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
|                 pr_err("%s(%d): %d\n", __func__, __LINE__, r);
| 
|         }

-22 due to

4160 static int __sched_setscheduler(struct task_struct *p,
…
4191         /*
4192          * Valid priorities for SCHED_FIFO and SCHED_RR are
4193          * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
4194          * SCHED_BATCH and SCHED_IDLE is 0.
4195          */
4196         if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
4197             (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
4198                 return -EINVAL;
4199         if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
4200             (rt_policy(policy) != (attr->sched_priority != 0)))
4201                 return -EINVAL;
                               ↑

Sebastian
