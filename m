Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9544DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E4E206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfG2Q7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:59:11 -0400
Received: from foss.arm.com ([217.140.110.172]:47964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfG2Q7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:59:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3F3337;
        Mon, 29 Jul 2019 09:59:08 -0700 (PDT)
Received: from [10.1.32.39] (unknown [10.1.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFBDD3F694;
        Mon, 29 Jul 2019 09:59:06 -0700 (PDT)
Subject: Re: [PATCH 5/5] sched/deadline: Use return value of SCHED_WARN_ON()
 in bw accounting
To:     Peter Zijlstra <peterz@infradead.org>,
        luca abeni <luca.abeni@santannapisa.it>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-6-dietmar.eggemann@arm.com>
 <20190726121819.32be6fb1@sweethome>
 <20190729165434.GO31398@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a12e2330-50d4-b31f-14b5-5b386252d418@arm.com>
Date:   Mon, 29 Jul 2019 17:59:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729165434.GO31398@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 5:54 PM, Peter Zijlstra wrote:
> On Fri, Jul 26, 2019 at 12:18:19PM +0200, luca abeni wrote:
>> Hi Dietmar,
>>
>> On Fri, 26 Jul 2019 09:27:56 +0100
>> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>>> To make the decision whether to set rq or running bw to 0 in underflow
>>> case use the return value of SCHED_WARN_ON() rather than an extra if
>>> condition.
>>
>> I think I tried this at some point, but if I remember well this
>> solution does not work correctly when SCHED_DEBUG is not enabled.
> 
> Well, it 'works' in so far that it compiles. But it might not be what
> one expects. That is, for !SCHED_DEBUG the return value is an
> unconditional false.
> 
> In this case I think that's fine, the WARN _should_ not be happending.

But there is commit 6d3aed3d ("sched/debug: Fix SCHED_WARN_ON() to
return a value on !CONFIG_SCHED_DEBUG as well")?

But it doesn't work with !CONFIG_SCHED_DEBUG

What compiles and work is (at least on Arm64).

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4012f98b9d26..494a767a4091 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -78,7 +78,7 @@
 #ifdef CONFIG_SCHED_DEBUG
 # define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
 #else
-# define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
+# define SCHED_WARN_ON(x)      ({ (void)(x), x; })


