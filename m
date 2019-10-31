Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FD2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E0620856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfJaBd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:33:27 -0400
Received: from foss.arm.com ([217.140.110.172]:43604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfJaBd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:33:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75AE61FB;
        Wed, 30 Oct 2019 18:33:26 -0700 (PDT)
Received: from [10.188.222.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE2E3F719;
        Wed, 30 Oct 2019 18:33:23 -0700 (PDT)
Subject: Re: NULL pointer dereference in pick_next_task_fair
To:     Ram Muthiah <rammuthiah@google.com>,
        Quentin Perret <qperret@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        mingo@kernel.org, pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
References: <20191028174603.GA246917@google.com>
 <20191029113411.GP4643@worktop.programming.kicks-ass.net>
 <20191029115000.GA11194@google.com>
 <CA+CXyWsoW8ann52pcR66ejRmjJ=4QmoaHTRVhb3=ohe0ZDnm-A@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <75e99374-0bd6-a7d7-581e-9360a1f90103@arm.com>
Date:   Thu, 31 Oct 2019 02:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+CXyWsoW8ann52pcR66ejRmjJ=4QmoaHTRVhb3=ohe0ZDnm-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 23:50, Ram Muthiah wrote:
> 
> Quentin and I were able to create a setup which reproduces the issue.
> 
> Given this, I tried Peter's proposed fix and was still able to reproduce the
> issue unfortunately. Current patch is located here -
> https://android-review.googlesource.com/c/kernel/common/+/1153487
> 
> Our mitigation for this issue on the android-mainline branch has been to
> revert 67692435c411 ("sched: Rework pick_next_task() slow-path").
> https://android-review.googlesource.com/c/kernel/common/+/1152564
> 
> I'll spend some time detailing repro steps next. I should be able to
> provide an update on those details early next week.
> 
> We appreciate the help so far.
> Thanks,
> Ram
> 

The splat Quentin posted happens at secondary startup, is that always
the case? I'm trying to think of what could make rq.cfs_rq.nr_running
non-zero at secondary bringup time. It might not explain the NULL pointer, but
I'm still curious as to how we can get something there this early, as it could
point towards something. Be warned, I might bring up stuff I know nothing
about, but this looks "fun" so I can't help myself :)


sched domains are only setup after smp_init() in sched_init_smp(), thus after
we've booted all secondaries. This should take load balance out of the
picture.

For wakeups, select_task_rq_fair() can only ever pick prev_cpu or this_cpu
since there are no sched domains. I don't see many candidates that could
wakeup on a secondary (thus have non-zero this_cpu) this early there. Perhaps
the smpboot threads, but from a quick look they are first created *after*
sched_init_smp(), so they couldn't exist during (boot-time) secondary bringup.
Seems to be the same for IRQ threads (and they're setscheduler'd to FIFO
anyway).

So now I'm even more curious as to what CFS task could be enqueued on a
secondary CPU rq before sched_init_smp(). Have you been sending stuff to space
without any shielding lately?

