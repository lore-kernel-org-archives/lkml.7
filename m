Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EF2CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BD62086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfJaKyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:54:24 -0400
Received: from foss.arm.com ([217.140.110.172]:47008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfJaKyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:54:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B7B11F1;
        Thu, 31 Oct 2019 03:54:24 -0700 (PDT)
Received: from [172.20.53.248] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7465B3F719;
        Thu, 31 Oct 2019 03:54:20 -0700 (PDT)
Subject: Re: NULL pointer dereference in pick_next_task_fair
From:   Valentin Schneider <valentin.schneider@arm.com>
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
 <75e99374-0bd6-a7d7-581e-9360a1f90103@arm.com>
Message-ID: <8d8fe4e9-1905-cde1-9ced-0a860e5a961b@arm.com>
Date:   Thu, 31 Oct 2019 11:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <75e99374-0bd6-a7d7-581e-9360a1f90103@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2019 02:33, Valentin Schneider wrote:
> For wakeups, select_task_rq_fair() can only ever pick prev_cpu or this_cpu
> since there are no sched domains. I don't see many candidates that could
> wakeup on a secondary (thus have non-zero this_cpu) this early there. Perhaps
> the smpboot threads, but from a quick look they are first created *after*
> sched_init_smp(), so they couldn't exist during (boot-time) secondary bringup.

Scratch that, I can't read. The registration is done in early initcalls (and
we have the unpark in the secondary bringup anyway), so when we spool up the
secondaries we'll get wakeups for the smpboot threads. AFAIR only softirqd
and cpuhp are CFS, but while this satisfied some of my curiosity this doesn't
seem super helpful on its own.

> Seems to be the same for IRQ threads (and they're setscheduler'd to FIFO
> anyway).
> 
> So now I'm even more curious as to what CFS task could be enqueued on a
> secondary CPU rq before sched_init_smp(). Have you been sending stuff to space
> without any shielding lately?
> 
