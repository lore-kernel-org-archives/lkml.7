Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1350AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5824ABA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfFDN3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:29:38 -0400
Received: from foss.arm.com ([217.140.101.70]:43834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfFDN3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:29:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D8BDA78;
        Tue,  4 Jun 2019 06:29:36 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CF393F690;
        Tue,  4 Jun 2019 06:29:34 -0700 (PDT)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6eb5d59f-37d0-0aab-1fc0-fcf48cc4164f@arm.com>
Date:   Tue, 4 Jun 2019 15:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604074549.GP28207@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 9:45 AM, Paul E. McKenney wrote:
> On Mon, Jun 03, 2019 at 03:39:18PM +0200, Dietmar Eggemann wrote:
>> On 6/3/19 1:44 PM, Mark Rutland wrote:
>>> On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
>>>> On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
>>>>> Scheduling-clock interrupts can arrive late in the CPU-offline process,

[...]

>>>    05981277a4de1ad6 ("arm64: Use common outgoing-CPU-notification code")
>>>
>>> ... but it looks like Paul's patch to do so [1] fell through the cracks;
>>> I'm not aware of any reason that shouldn't have been taken.
>>> [1] https://lore.kernel.org/lkml/1431467407-1223-8-git-send-email-paulmck@linux.vnet.ibm.com/
>>>
>>> Paul, do you want to resend that?
>>
>> Please do. We're carrying this patch out-of-tree for while now in
>> our EAS integration to get cpu hotplug tests passing on TC2 (arm).
> 
> Huh.  It still applies.  But I have no means of testing it.

We can do the testing part on our TC2 platform, i.e. we're testing it 
with each of our EAS mainline integration right now.

https://developer.arm.com/tools-and-software/open-source-software/linux-kernel/energy-aware-scheduling/eas-mainline-development

http://linux-arm.org/git?p=linux-power.git;a=commit;h=8cd16f1dc2cd896a0b1e2010b4992b33fdc11fe0

> And it looks like the reason I dropped it was that I didn't get any
> response from the maintainer.  I sent a message to this effect to
> linux-arm-kernel@lists.infradead.org and linux@arm.linux.org.uk on May
> 21, 2015.
> 
> So here it is again.  ;-)
> 
> I have queued this locally.  Left to myself, I add the two of you on its
> Cc: list and run it through my normal process.  But given the history,
> I would still want either an ack from the maintainer or, better, for
> the maintainer to take the patch.
> 
> Or is there a better way for us to proceed on this?

You could send this patch also to linux-arm-kernel@lists.infradead.org 
and cc rmk to get his opinion on the patch.

[...]
