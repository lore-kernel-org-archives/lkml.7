Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D5CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6339521530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfEHIOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:14:24 -0400
Received: from mail.sssup.it ([193.205.80.98]:59616 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfEHIOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:14:23 -0400
Received: from [83.43.182.198] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138918671; Wed, 08 May 2019 10:14:21 +0200
Date:   Wed, 8 May 2019 10:14:14 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for
 deadline tasks that do not block
Message-ID: <20190508101414.1c968810@nowhere>
In-Reply-To: <20190508080116.GE6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-4-luca.abeni@santannapisa.it>
        <20190508080116.GE6551@localhost.localdomain>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Wed, 8 May 2019 10:01:16 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Hi Luca,
> 
> On 06/05/19 06:48, Luca Abeni wrote:
> > From: luca abeni <luca.abeni@santannapisa.it>
> > 
> > Currently, the scheduler tries to find a proper placement for
> > SCHED_DEADLINE tasks when they are pushed out of a core or when
> > they wake up. Hence, if there is a single SCHED_DEADLINE task
> > that never blocks and wakes up, such a task is never migrated to
> > an appropriate CPU core, but continues to execute on its original
> > core.
> > 
> > This commit addresses the issue by trying to migrate a
> > SCHED_DEADLINE task (searching for an appropriate CPU core) the
> > first time it is throttled.  
> 
> Why we failed to put the task on a CPU with enough (max) capacity
> right after it passed admission control? The very first time the task
> was scheduled I mean.

I think the currently executing task cannot be pushed out of a
CPU/core, right?

So, if a task switches from SCHED_OTHER to SCHED_DEADLINE while it is
executing on a fast core, the only way to migrate it would be to
preempt it (by using the stop_sched_class, I think), no?
(the typical situation here is a "cpu hog" task that switches from
SCHED_OTHER to SCHED_DEADLINE, and it is the only SCHED_DEADLINE
task... The task never blocks, so push/pull functions are never invoked)

Or am I missing something?



			Thanks,
				Luca
