Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBEDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD8B26431
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEaGJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:09:30 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33825 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbfEaGJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:09:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TT3KRH6_1559282949;
Received: from 30.17.232.221(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TT3KRH6_1559282949)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 May 2019 14:09:23 +0800
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <CAERHkruVthrTgGqiH=yhCspZWpMDAu0G4rNcrDTKQzgPq9eqQQ@mail.gmail.com>
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
Message-ID: <21fda627-1d3c-12cc-6389-8c226218e2ce@linux.alibaba.com>
Date:   Fri, 31 May 2019 14:09:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAERHkruVthrTgGqiH=yhCspZWpMDAu0G4rNcrDTKQzgPq9eqQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/31 13:12, Aubrey Li wrote:
> On Fri, May 31, 2019 at 11:01 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>>
>> This feels like "date" failed to schedule on some CPU
>> on time.
>>
>> My first reaction is: when shell wakes up from sleep, it will
>> fork date. If the script is untagged and those workloads are
>> tagged and all available cores are already running workload
>> threads, the forked date can lose to the running workload
>> threads due to __prio_less() can't properly do vruntime comparison
>> for tasks on different CPUs. So those idle siblings can't run
>> date and are idled instead. See my previous post on this:
>> https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
>> (Now that I re-read my post, I see that I didn't make it clear
>> that se_bash and se_hog are assigned different tags(e.g. hog is
>> tagged and bash is untagged).
> 
> Yes, script is untagged. This looks like exactly the problem in you
> previous post. I didn't follow that, does that discussion lead to a solution?

No immediate solution yet.

>>
>> Siblings being forced idle is expected due to the nature of core
>> scheduling, but when two tasks belonging to two siblings are
>> fighting for schedule, we should let the higher priority one win.
>>
>> It used to work on v2 is probably due to we mistakenly
>> allow different tagged tasks to schedule on the same core at
>> the same time, but that is fixed in v3.
> 
> I have 64 threads running on a 104-CPU server, that is, when the

104-CPU means 52 cores I guess.
64 threads may(should?) spread on all the 52 cores and that is enough
to make 'date' suffer.

> system has ~40% idle time, and "date" is still failed to be picked
> up onto CPU on time. This may be the nature of core scheduling,
> but it seems to be far from fairness.

Exactly.

> Shouldn't we share the core between (sysbench+gemmbench)
> and (date)? I mean core level sharing instead of  "date" starvation?

We need to make core scheduling fair, but due to no
immediate solution to vruntime comparison cross CPUs, it's not
done yet.
