Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625B0C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BED20692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391773AbfIMNv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:51:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388813AbfIMNv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:51:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA90FAF77;
        Fri, 13 Sep 2019 13:51:23 +0000 (UTC)
Date:   Fri, 13 Sep 2019 15:51:22 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Jorg Vehlow <lkml@jv-coder.de>
Cc:     ltp@lists.linux.it, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [LTP] sched_football: Validity of testcase
Message-ID: <20190913135121.GB7939@rei>
References: <015a01d56486$6c905050$45b0f0f0$@jv-coder.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015a01d56486$6c905050$45b0f0f0$@jv-coder.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> I was looking thoroughly at the realtime testcase sched_football, 
> because it sometimes fails and like to know your opinion on the test case.
> 
> A short introduction to how the test works:
> It creates nThreads threads called offense and n threads called defense
> (all fifo scheduled). The offense threads run at a lower priority than
> the defense threads and the main thread has the highest priority. After 
> all threads are created (validated using an atomic counter). The test 
> verifies, that the offense threads are never executed by incrementing 
> a counter in the offense threads, that is zeroed in the main thread. 
> During the test the main threads sleeps to regularly. 
> 
> While the test is totally fine on a single core system, you can 
> immediately see, that it will fail on a system with nCores > nThreads, 
> because there will be a core were only an offense thread an no defense 
> thread is scheduled. In its default setup nThreads = nCores. This should 
> theoretically work, because there is a defense thread for every score with 
> a higher priority than the offense threads and they should be scheduled
> onto  every core. This is indeed what happens. The problem seems to be 
> the  initialization phase. When the threads are created, they are not 
> evenly scheduled. After pthread_create was called, the threads are scheduled
> 
> too cores where nothing is running. If there is no idle core anymore, they
> are
> scheduled to any core (the first?, the one with the shortest wait queue?).
> At
> some point after all threads are created, they are rescheduled to every
> core.
> It looks like the test fails, when there is initially a core with only an
> offense thread scheduled onto it. In perf sched traces I saw, that a defense
> thread was migrated to this core, but still the offense thread was executed
> for
> a short time, until the offense thread runs. From this point onwards only
> defense threads are running.
> 
> I tested adding a sleep to the main function, after all threads are created,
> to give the system some time for rescheduling. A sleep of around 50ms works
> quite well and supports my theory about the migration time being the
> problem.
> 
> Now I am not sure if the test case is even valid or if the scheduler is not
> working as it is supposed to. Looking at the commits of sched_football it 
> looks like it was running stable at least at some point, at least it es 
> reported to have run 15k iterations in e6432e45.
> What do you think about the test case? Is it even valid?

As far as I can tell the test is designed to check that the realtime
threads are distributed evenly on a system. I'm not scheduller expert
and as far as I know there are push and pull mechanims to distribute the
realtime tasks between per-cpu run-queues so that maximal amount of
realtime threads can run at a given time. I guess that there may be a
short window until one of the cores pulls the defensive thread to it's
run-queue which gives the offensive change to run for a while because
the main thread could have been running on that core previously, but I
guess that is something that should be answered by scheduller
developers, hence CCing them.

> Should the cpu affinity be set fixed?

Maybe we should pin and isolate the main thread that does the referee to
single core and let the test run on the rest of the cores, which would
rule out the possibility of the main thread interfering with the rest of
the threads.

> A note about my testing methodology:
> After I realized, that the execution often failed due to the offense thread
> running after referee set the_ball to 0, I replaced the loop with just
> usleep(10000), for faster iteration.
> I tested on ubuntu 19.04 with linux 5.0.0-27 running in vmware and 
> a custom yocto distribution running linux 4.19.59 (with and without rt
> patches)

-- 
Cyril Hrubis
chrubis@suse.cz
