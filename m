Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C30C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935182067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbfISOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:43:05 -0400
Received: from foss.arm.com ([217.140.110.172]:59958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732606AbfISOnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4F3C337;
        Thu, 19 Sep 2019 07:43:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967393F575;
        Thu, 19 Sep 2019 07:43:02 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:43:00 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        tim.c.chen@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        mingo@redhat.com, morten.rasmussen@arm.com,
        dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com
Subject: Re: Usecases for the per-task latency-nice attribute
Message-ID: <20190919144259.vpuv7hvtqon4qgrv@e107158-lin.cambridge.arm.com>
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/19 18:11, Parth Shah wrote:
> Hello everyone,
> 
> As per the discussion in LPC2019, new per-task property like latency-nice
> can be useful in certain scenarios. The scheduler can take proper decision
> by knowing latency requirement of a task from the end-user itself.
> 
> There has already been an effort from Subhra for introducing Task
> latency-nice [1] values and have seen several possibilities where this type of
> interface can be used.
> 
> From the best of my understanding of the discussion on the mail thread and
> in the LPC2019, it seems that there are two dilemmas;
> 
> 1. Name: What should be the name for such attr for all the possible usecases?
> =============
> Latency nice is the proposed name as of now where the lower value indicates
> that the task doesn't care much for the latency and we can spend some more
> time in the kernel to decide a better placement of a task (to save time,
> energy, etc.)
> But there seems to be a bit of confusion on whether we want biasing as well
> (latency-biased) or something similar, in which case "latency-nice" may
> confuse the end-user.
> 
> 2. Value: What should be the range of possible values supported by this new
> attr?
> ==============
> The possible values of such task attribute still need community attention.
> Do we need a range of values or just binary/ternary values are sufficient?
> Also signed or unsigned and so the length of the variable (u64, s32, etc)?

IMO the main question is who is the intended user of this new knob/API?

If it's intended for system admins to optimize certain workloads on a system
then I like the latency-nice range.

If we want to support application writers to define the latency requirements of
their tasks then I think latency-nice would be very confusing to use.
Especially when one has to consider they lack a pre-knowledge about the system
they will run on; and what else they are sharing the resources with.

> 
> 
> 
> This mail is to initiate the discussion regarding the possible usecases of
> such per task attribute and to come up with a specific name and value for
> the same.
> 
> Hopefully, interested one should plot out their usecase for which this new
> attr can potentially help in solving or optimizing it.
> 
> 
> Well, to start with, here is my usecase.
> 
> -------------------
> **Usecases**
> -------------------
> 
> $> TurboSched
> ====================
> TurboSched [2] tries to minimize the number of active cores in a socket by
> packing an un-important and low-utilization (named jitter) task on an
> already active core and thus refrains from waking up of a new core if
> possible. This requires tagging of tasks from the userspace hinting which
> tasks are un-important and thus waking-up a new core to minimize the
> latency is un-necessary for such tasks.
> As per the discussion on the posted RFC, it will be appropriate to use the
> task latency property where a task with the highest latency-nice value can
> be packed.
> But for this specific use-cases, having just a binary value to know which
> task is latency-sensitive and which not is sufficient enough, but having a
> range is also a good way to go where above some threshold the task can be
> packed.


$> EAS
====================
The new knob can help EAS path to switch to spreading behavior when
latency-nice is set instead of packing tasks on the most energy efficient CPU.
ie: pick the most energy efficient idle CPU.

--
Qais Yousef
