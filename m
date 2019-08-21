Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC022064A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfHUTan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:30:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57129 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHUTan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:43 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJc-00048z-R6; Wed, 21 Aug 2019 21:30:40 +0200
Message-Id: <20190821190847.665673890@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:08:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 00/38] posix-cpu-timers: Cleanup and consolidation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

This is the second version of that set. First one can be found here:

  https://lkml.kernel.org/r/20190819143141.221906747@linutronix.de

The following changes vs. V1:

  - Folded the synchronization callback patch into the original one and
    replaced the original one in tip timers/core as requested by Christoph

  - Merged the first couple of trivial patches into tip timers/core with
    Frederics reviewed-by picked up.

  - Dropped the sighand locking change as pointed out by Frederic

  - Dropped the last patch which switches to direct expiry mode as it got
    too ugly as the sighand locking change needed to be dropped. This will
    come with the next set on top of this which moves the expiry into task
    work context which was the initial reason for staring at this code.

  - Reworked the storage array after the patch which removes the temporary
    union and the abused struct task_cputime as requested by Ingo.

  - Fixed up a comment and the ugly hack in do_rlimit() which was needed to
    convert 0 expiry time to 1 which was required due to the 0 based checks
    which are now gone. (New)

  - Fixed typos in comments and changelogs (Ingo)

The series applies on top of:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

and is available from git as well:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers/core

Thanks,

	tglx

8<--------------
 include/linux/init_task.h      |   11 
 include/linux/posix-timers.h   |  121 ++++-
 include/linux/sched.h          |   29 -
 include/linux/sched/cputime.h  |   12 
 include/linux/sched/signal.h   |   14 
 include/linux/sched/types.h    |   23 
 include/linux/timerqueue.h     |   10 
 init/init_task.c               |    2 
 kernel/fork.c                  |   34 -
 kernel/sched/rt.c              |    6 
 kernel/sys.c                   |   16 
 kernel/time/itimer.c           |   11 
 kernel/time/posix-cpu-timers.c |  952 +++++++++++++++++++----------------------
 13 files changed, 616 insertions(+), 625 deletions(-)



