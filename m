Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A92C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C39521744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfIBKxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:53:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbfIBKxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:53:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46D2E28;
        Mon,  2 Sep 2019 03:53:51 -0700 (PDT)
Received: from [192.168.0.8] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDA4A3F246;
        Mon,  2 Sep 2019 03:53:49 -0700 (PDT)
Subject: Re: [PATCH RFC v4 0/15] sched,fair: flatten CPU controller runqueues
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
References: <20190822021740.15554-1-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <94ba95b9-9cfe-d715-dded-ff92700d47eb@arm.com>
Date:   Mon, 2 Sep 2019 12:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822021740.15554-1-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 04:17, Rik van Riel wrote:
> The current implementation of the CPU controller uses hierarchical
> runqueues, where on wakeup a task is enqueued on its group's runqueue,
> the group is enqueued on the runqueue of the group above it, etc.
> 
> This increases a fairly large amount of overhead for workloads that
> do a lot of wakeups a second, especially given that the default systemd
> hierarchy is 2 or 3 levels deep.
> 
> This patch series is an attempt at reducing that overhead, by placing
> all the tasks on the same runqueue, and scaling the task priority by
> the priority of the group, which is calculated periodically.
> 
> My main TODO items for the next period of time are likely going to
> be testing, testing, and testing. I hope to find and flush out any
> corner case I can find, and make sure performance does not regress
> with any workloads, and hopefully improves some.

I did some testing with a small & simple rt-app based test-case:

2 CPUs (rq->cpu_capacity_orig=1024), CPUfreq performance governor

2 taskgroups /tg0 and /tg1

6 CFS tasks (periodic, 8/16ms (runtime/period))

/tg0 (cpu.shares=1024) ran 4 tasks and /tg1 (cpu.shares=1024) ran 2 tasks

(arm64 defconfig with !CONFIG_NUMA_BALANCING, !CONFIG_SCHED_AUTOGROUP)

---

v5.2:

The 2 /tg1 tasks ran 8/16ms. The 4 /tg0 tasks ran 4/16ms in the
beginning and then 8/16ms after the 2 /tg1 tasks did finish.

---

v5.2 + v4:

There is no runtime/period pattern visible anymore. I see a lot of extra
wakeup latency for those tasks though.

v5.2 + (v4 without 07/15, 08/15, 15/15) didn't change much.

---

I could try to reduce the stack even further (e.g. without 13/15).

IMHO it's a good idea to have a set of these small & simple test-cases
handy to verify that the base-functionality is still in place. This
might be hard to achieve with benchmarks.
