Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2575BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51E522CE2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfHSPpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:45:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47557 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfHSPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:38 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqh-0006t8-Lq; Mon, 19 Aug 2019 17:45:35 +0200
Message-Id: <20190819143141.221906747@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 00/44] posix-cpu-timers: Cleanup and consolidation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

While working on splitting the posix CPU timer expiry out into task
context, I took a deeper look at that code.

It contains quite some duplicated code and the abuse of struct task_cputime
along with the defines to rename the struct members just made my eyes bleed.

The following series cleans that up and consolidates and simplifies the
implementation. The resulting .text is about 15% smaller than the orignal
one.

It's split into small patches to make the review easier as this code is a
true can of worms and the larger patches I had initially were just an
invitation to overlook subtle issues.

The series applies on top of:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

and is available from git as well:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers/core

Thanks,

	tglx

8<--------------
 include/linux/alarmtimer.h     |    3 
 include/linux/init_task.h      |   11 
 include/linux/posix-timers.h   |  112 +++-
 include/linux/sched.h          |   26 -
 include/linux/sched/cputime.h  |   12 
 include/linux/sched/signal.h   |   13 
 include/linux/sched/types.h    |   21 
 include/linux/timerqueue.h     |   10 
 init/init_task.c               |    2 
 kernel/fork.c                  |   34 -
 kernel/sched/rt.c              |    6 
 kernel/time/alarmtimer.c       |   14 
 kernel/time/itimer.c           |   11 
 kernel/time/posix-cpu-timers.c | 1033 ++++++++++++++++++-----------------------
 kernel/time/posix-timers.c     |   32 -
 kernel/time/posix-timers.h     |    1 
 kernel/time/timer.c            |    2 
 17 files changed, 659 insertions(+), 684 deletions(-)


