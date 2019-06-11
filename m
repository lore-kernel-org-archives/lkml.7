Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303120673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbfFKNO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:14:59 -0400
Received: from foss.arm.com ([217.140.110.172]:32966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388792AbfFKNO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:14:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C901B344;
        Tue, 11 Jun 2019 06:14:57 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CB4F3F557;
        Tue, 11 Jun 2019 06:14:56 -0700 (PDT)
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
To:     paulmck@linux.ibm.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, mojha@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <20190602011253.GA6167@linux.ibm.com>
 <20190603083848.GB3436@hirez.programming.kicks-ass.net>
 <20190603114455.GA16119@lakrids.cambridge.arm.com>
 <ea4887fb-cc77-59d4-3ba7-a59f5237ca40@arm.com>
 <20190604074549.GP28207@linux.ibm.com>
 <6eb5d59f-37d0-0aab-1fc0-fcf48cc4164f@arm.com>
 <20190608164158.GK28207@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <16a424d1-0ab7-7e81-5c4f-93da23519b1d@arm.com>
Date:   Tue, 11 Jun 2019 15:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608164158.GK28207@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/19 6:41 PM, Paul E. McKenney wrote:
> On Tue, Jun 04, 2019 at 03:29:32PM +0200, Dietmar Eggemann wrote:
>> On 6/4/19 9:45 AM, Paul E. McKenney wrote:
>>> On Mon, Jun 03, 2019 at 03:39:18PM +0200, Dietmar Eggemann wrote:
>>>> On 6/3/19 1:44 PM, Mark Rutland wrote:
>>>>> On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
>>>>>> On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
>>>>>>> Scheduling-clock interrupts can arrive late in the CPU-offline process,

[...]

>>> And it looks like the reason I dropped it was that I didn't get any
>>> response from the maintainer.  I sent a message to this effect to
>>> linux-arm-kernel@lists.infradead.org and linux@arm.linux.org.uk on May
>>> 21, 2015.
>>>
>>> So here it is again.  ;-)
>>>
>>> I have queued this locally.  Left to myself, I add the two of you on its
>>> Cc: list and run it through my normal process.  But given the history,
>>> I would still want either an ack from the maintainer or, better, for
>>> the maintainer to take the patch.
>>>
>>> Or is there a better way for us to proceed on this?
>>
>> You could send this patch also to
>> linux-arm-kernel@lists.infradead.org and cc rmk to get his opinion
>> on the patch.
> 
> OK, please let me know how the testing goes.  My thought is to send the
> patch as you suggest with your Tested-by.

Tested your patch on top of v5.2-rc4* on Arm TC2 (32bit) and CPU hotplug 
stress test. W/o your patch, the test fails within seconds since CPUs 
are not coming up again. W/ your patch, the test runs for hours just fine.

You can add my:

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

* just for the record: one additional unrelated patch (to disable the 
NOR flash) is necessary on Arm TC2: 
https://patchwork.kernel.org/patch/10968391 .
