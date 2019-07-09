Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502CBC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C486214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGIPmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:42:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGIPmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:42:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C7E2B;
        Tue,  9 Jul 2019 08:42:09 -0700 (PDT)
Received: from [10.1.194.67] (e108031-lin.cambridge.arm.com [10.1.194.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4D1C3F246;
        Tue,  9 Jul 2019 08:42:08 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Update rq_clock, cfs_rq before migrating for
 asym cpu capacity
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
References: <20190709115759.10451-1-chris.redpath@arm.com>
 <20190709135054.GF3402@hirez.programming.kicks-ass.net>
 <b0d82dbf-f23b-f858-4c60-b5a413c0e618@arm.com>
 <CAKfTPtCxw8Xqz3rJPKeeDVfvWTcsByAb64_JtB-w2Bp83BGBgw@mail.gmail.com>
Reply-To: chris.redpath@arm.com
From:   Chris Redpath <chris.redpath@foss.arm.com>
Message-ID: <1128a866-6817-3703-8962-8c3670dd10c1@foss.arm.com>
Date:   Tue, 9 Jul 2019 16:42:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCxw8Xqz3rJPKeeDVfvWTcsByAb64_JtB-w2Bp83BGBgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2019 16:36, Vincent Guittot wrote:
> Hi Chris,
> 
>>
>> We enter this code quite often in our testing, most individual runs of a
>> test which has small tasks involved have at least one hit where we make
>> a change to the clock with this patch in.
> 
> Do you have a rt-app file that you can share ?
> 

The ThreeSmallTasks test which is the worst hit produces this:

{
     "tasks": {
         "small_0": {
             "policy": "SCHED_OTHER",
             "delay": 0,
             "loop": 1,
             "phases": {
                 "p000001": {
                     "loop": 62,
                     "run": 2880,
                     "timer": {
                         "ref": "small_0",
                         "period": 16000
                     }
                 }
             }
         },
         "small_1": {
             "policy": "SCHED_OTHER",
             "delay": 0,
             "loop": 1,
             "phases": {
                 "p000001": {
                     "loop": 62,
                     "run": 2880,
                     "timer": {
                         "ref": "small_1",
                         "period": 16000
                     }
                 }
             }
         },
         "small_2": {
             "policy": "SCHED_OTHER",
             "delay": 0,
             "loop": 1,
             "phases": {
                 "p000001": {
                     "loop": 62,
                     "run": 2880,
                     "timer": {
                         "ref": "small_2",
                         "period": 16000
                     }
                 }
             }
         }
     },
     "global": {
         "default_policy": "SCHED_OTHER",
         "duration": -1,
         "calibration": 264,
         "logdir": "/root/devlib-target"
     }
}

when I run it

>>
>> That said - despite the relatively high number of hits only about 5% of
>> runs see enough additional energy consumed to trigger a test failure. We
>> do try to keep a quiet system as much as possible and only run for a few
>> seconds so the impact we see in testing is also probably higher than in
>> the real world.
> 
> Yeah, I'm curious to see the impact on a real system which have a
> 60fps screen update like an android phone
> 

I wouldn't expect much change there but I would on the idle-ish 
homescreen/day-of-use type benchmarks.

If I had a platform with any kind of representative energy use, I'd test 
it :)
