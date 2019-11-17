Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9ADC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026CD206D6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfKQKUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 05:20:02 -0500
Received: from foss.arm.com ([217.140.110.172]:50278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfKQKUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 05:20:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E465328;
        Sun, 17 Nov 2019 02:20:01 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3100E3F6C4;
        Sun, 17 Nov 2019 02:20:00 -0800 (PST)
Subject: Re: [GIT PULL] scheduler fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <20191117094549.GB126325@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4e4b0828-abba-e27d-53f6-135df06eba1a@arm.com>
Date:   Sun, 17 Nov 2019 10:19:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191117094549.GB126325@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2019 09:45, Ingo Molnar wrote:
> I've picked v2 up instead. I suspect it's not really consequential as 
> enums don't really get truncated by compilers, right? Is there any other 
> negative runtime side effect possible from the imprecise enum/uint 
> typing?
> 

AFAIUI the requirement for the enum type is that it has to be an int type that
covers all its values, so I could see some funky optimization (e.g. check the
returned value is < 512 but it's assumed the type for the enum is 8 bits so
this becomes always true). Then again we don't have any explicit check on
those returned values, plus they fit in 11 bits, so as you say it's
mostly likely inconsequential (and I didn't see any compile diff).

My "worry" wasn't really about this patch, it was more about the following
one - it didn't like the idea of merging an unneeded patch (with a Fixes:
tag on top of it).

>>>       sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks
>>
>> And this one is no longer needed, as Michal & I understood (IOW the fix in
>> rc6 is sufficient), see:
>>
>>   c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com
> 
> Ok.
> 
> I'm inclined to just reduce sched/urgent back to these three fixes:
> 
>   6e1ff0773f49: sched/uclamp: Fix incorrect condition
>   b90f7c9d2198: sched/pelt: Fix update of blocked PELT ordering
>   ff51ff84d82a: sched/core: Avoid spurious lock dependencies
> 
> and apply v2 of the uclamp_id type fix to sched/core. This would reduce 
> the risks of a Sunday pull request ...
> 

This sounds good to me. Sorry for the hassle.

> Thanks,
> 
> 	Ingo
> 
