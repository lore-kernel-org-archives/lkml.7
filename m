Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F14124679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLSVqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfLSVqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:46:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8182C2467B;
        Thu, 19 Dec 2019 21:45:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1ii3cM-000Uks-FM; Thu, 19 Dec 2019 16:45:58 -0500
Message-Id: <20191219214451.340746474@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Dec 2019 16:44:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC][PATCH 0/4] sched: Optimizations to sched_class processing
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As Kirill made a micro-optimization to the processing of pick_next_task()
that required the address locations of the sched_class descriptors to
be that of their priority to one another. This required a linker
script modification to guarantee that order.

After adding the forced order in the linker script, I realized that
we no longer needed the 'next' field in the sched_class descriptor.
Thus, I changed it to use the order of the linker script.

Then decided that the sched_class_highest define could be moved
to the linker script as well to keep the defines of the order to
be in one location, and it be obvious what the highest sched_class is
when SMP is not configured. (BTW, I have not tested this with
!CONFIG_SMP yet, but who does ;-). As the removal of next was a bit
more invasive than the highest sched class change, I moved that to
be the second patch.

Finally I added Kirill's patch at the end, (Which may not have made it
to LKML due to trying to not get it mangled by Exchange).

Kirill Tkhai (1):
      sched: Micro optimization in pick_next_task() and in check_preempt_curr()

Steven Rostedt (VMware) (3):
      sched: Force the address order of each sched class descriptor
      sched: Have sched_class_highest define by vmlinux.lds.h
      sched: Remove struct sched_class next field

----
 include/asm-generic/vmlinux.lds.h | 29 +++++++++++++++++++++++++++++
 kernel/sched/core.c               | 24 +++++++++---------------
 kernel/sched/deadline.c           |  4 ++--
 kernel/sched/fair.c               |  4 ++--
 kernel/sched/idle.c               |  4 ++--
 kernel/sched/rt.c                 |  4 ++--
 kernel/sched/sched.h              | 13 +++++--------
 kernel/sched/stop_task.c          |  4 ++--
 8 files changed, 53 insertions(+), 33 deletions(-)
