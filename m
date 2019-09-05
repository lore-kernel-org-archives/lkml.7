Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC6DC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5905020825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbfIEKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:31:20 -0400
Received: from foss.arm.com ([217.140.110.172]:41376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbfIEKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:31:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930881576;
        Thu,  5 Sep 2019 03:31:19 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF32D3F718;
        Thu,  5 Sep 2019 03:31:17 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net,
        parth@linux.ibm.com
Subject: Re: [RFC PATCH 0/9] Task latency-nice
In-reply-to: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
Date:   Thu, 05 Sep 2019 11:31:15 +0100
Message-ID: <87k1an2fws.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Aug 30, 2019 at 18:49:35 +0100, subhra mazumdar wrote...

> Introduce new per task property latency-nice for controlling scalability
> in scheduler idle CPU search path.

As per my comments in other message, we should try to better split the
"latency nice" concept introduction (API and mechanisms) from its usage
in different scheduler code paths.

This distinction should be evident from the cover letter too. What you
use "latency nice" for is just one possible use-case, thus it's
important to make sure it's generic enough to fit other usages too.

> Valid latency-nice values are from 1 to
> 100 indicating 1% to 100% search of the LLC domain in select_idle_cpu. New
> CPU cgroup file cpu.latency-nice is added as an interface to set and get.
> All tasks in the same cgroup share the same latency-nice value. Using a
> lower latency-nice value can help latency intolerant tasks e.g very short
> running OLTP threads where full LLC search cost can be significant compared
> to run time of the threads. The default latency-nice value is 5.
>
> In addition to latency-nice, it also adds a new sched feature SIS_CORE to
> be able to disable idle core search altogether which is costly and hurts
> more than it helps in short running workloads.

I don't see why you latency-nice cannot be used to implement what you
get with NO_SIS_CORE.

IMHO, "latency nice" should be exposed as a pretty generic concept which
progressively enables different "levels of biasing" both at wake-up time
and load-balance time.

Why it's not possible to have SIS_CORE/NO_SIS_CORE switch implemented
just as different threshold values for the latency-nice value of a task?

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
