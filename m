Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424CEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EA2214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfJJOxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:53:25 -0400
Received: from foss.arm.com ([217.140.110.172]:32836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfJJOxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:53:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD3971000;
        Thu, 10 Oct 2019 07:53:23 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B74B23F6C4;
        Thu, 10 Oct 2019 07:53:21 -0700 (PDT)
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Parth Shah <parth@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <qperret@qperret.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20191007083051.4820-1-parth@linux.ibm.com>
 <20191007083051.4820-5-parth@linux.ibm.com>
 <CAKfTPtCgoTJXxbYyza1W55ayw9QeM7fue2e91Xpt804sL9GQWA@mail.gmail.com>
 <80bb34ec-6358-f4dc-d20d-cde6c9d7e197@linux.ibm.com>
 <d55c593d-af8e-c8ba-cc0e-c9917df5d593@arm.com>
 <86dc25e4-9f19-627f-9581-d74608b7f20c@linux.ibm.com>
 <eef32b9e-1f24-e8a9-cd91-dcc6546a636f@arm.com>
 <0ee8052e-e7fb-83cb-bf70-3c4855ccca8e@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6a620fc4-daf9-dd02-7a81-3d9364bfe162@arm.com>
Date:   Thu, 10 Oct 2019 16:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ee8052e-e7fb-83cb-bf70-3c4855ccca8e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 19:02, Parth Shah wrote:
> 
> 
> On 10/9/19 7:56 PM, Dietmar Eggemann wrote:
>> On 09/10/2019 10:57, Parth Shah wrote:
>>
>> [...]
>>
>>>> On 07/10/2019 18:53, Parth Shah wrote:
>>>>>
>>>>>
>>>>> On 10/7/19 5:49 PM, Vincent Guittot wrote:
>>>>>> On Mon, 7 Oct 2019 at 10:31, Parth Shah <parth@linux.ibm.com> wrote:

[...]

> ok. so does that mean TurboSched can still do some good in such systems as
> well ?
> I mean save energy even when rd->overutilized==1 by not waking user
> classified bg tasks on idle core.

I wouldn't say it is impossible but how likely would it be?

The Android runtime already classifies its tasks into groups such as
background, foreground, top-app, etc. It uses existing infrastructure
like cpusets, taskgroups, util_clamp (or its out-of-tree predecessor
schedtune) as well as EAS/Energy Model on asymmetric CPU capacity
systems to map them (differently) onto the CPU topology to achieve the
best possible performance/energy consumption trade-off.

Moreover, Google and Arm are keen getting the concept of 'latency nice'
upstream so we can map Android Common Kernel's 'prefer idle' feature
into the mainline energy-aware wu path.

So I'm afraid the question whether TurboSched could make sense on an
Android system can only be answered by people responsible for future
Android runtime architecture.
