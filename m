Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC67C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15171214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407124AbfHINdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:33:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436493AbfHINdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:33:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B61F8308FEC1;
        Fri,  9 Aug 2019 13:33:45 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E41A260BF3;
        Fri,  9 Aug 2019 13:33:44 +0000 (UTC)
Date:   Fri, 9 Aug 2019 09:33:43 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: use rq_lock/unlock in online_fair_sched_group
Message-ID: <20190809133342.GA18727@pauld.bos.csb>
References: <20190801133749.11033-1-pauld@redhat.com>
 <20190806130334.GO2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806130334.GO2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 09 Aug 2019 13:33:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:03:34PM +0200 Peter Zijlstra wrote:
> On Thu, Aug 01, 2019 at 09:37:49AM -0400, Phil Auld wrote:
> > Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
> 
> ISTR there were more issues; but it sure is good to start picking them
> off.
> 

Following up on this I hit another in rt.c which looks like:

[  156.348854] Call Trace:
[  156.351301]  <IRQ>
[  156.353322]  sched_rt_period_timer+0x124/0x350
[  156.357766]  ? sched_rt_rq_enqueue+0x90/0x90
[  156.362037]  __hrtimer_run_queues+0xfb/0x270
[  156.366303]  hrtimer_interrupt+0x122/0x270
[  156.370403]  smp_apic_timer_interrupt+0x6a/0x140
[  156.375022]  apic_timer_interrupt+0xf/0x20
[  156.379119]  </IRQ>

It looks like the same issue of not using the rq_lock* wrappers and
hence not using the pinning. From looking at the code there is at 
least one potential hit in deadline.c in the push_dl_task path with 
find_lock_later_rq but I have not hit that in practice.

This commit, which introduced the warning, seems to imply that the use
of the rq_lock* wrappers is required, at least for any sections that will
call update_rq_clock:

commit 26ae58d23b94a075ae724fd18783a3773131cfbc
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Oct 3 16:53:49 2016 +0200

    sched/core: Add WARNING for multiple update_rq_clock() calls
    
    Now that we have no missing calls, add a warning to find multiple
    calls.
    
    By having only a single update_rq_clock() call per rq-lock section,
    the section appears 'atomic' wrt time.


Is that the case? Otherwise we have these false positives.

I can spin up patches if so. 


Thanks,
Phil


-- 
