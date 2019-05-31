Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442DC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8457326278
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEaDB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:01:56 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:26279 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfEaDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:01:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TT2tMci_1559271712;
Received: from 30.17.232.221(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TT2tMci_1559271712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 May 2019 11:01:52 +0800
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
Message-ID: <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
Date:   Fri, 31 May 2019 11:01:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/30 22:04, Aubrey Li wrote:
> On Thu, May 30, 2019 at 4:36 AM Vineeth Remanan Pillai
> <vpillai@digitalocean.com> wrote:
>>
>> Third iteration of the Core-Scheduling feature.
>>
>> This version fixes mostly correctness related issues in v2 and
>> addresses performance issues. Also, addressed some crashes related
>> to cgroups and cpu hotplugging.
>>
>> We have tested and verified that incompatible processes are not
>> selected during schedule. In terms of performance, the impact
>> depends on the workload:
>> - on CPU intensive applications that use all the logical CPUs with
>>   SMT enabled, enabling core scheduling performs better than nosmt.
>> - on mixed workloads with considerable io compared to cpu usage,
>>   nosmt seems to perform better than core scheduling.
> 
> My testing scripts can not be completed on this version. I figured out the
> number of cpu utilization report entry didn't reach my minimal requirement.
> Then I wrote a simple script to verify.
> ====================
> $ cat test.sh
> #!/bin/sh
> 
> for i in `seq 1 10`
> do
>     echo `date`, $i
>     sleep 1
> done
> ====================

Is the shell put to some cgroup and assigned some tag or simply untagged?

> 
> Normally it works as below:
> 
> Thu May 30 14:13:40 CST 2019, 1
> Thu May 30 14:13:41 CST 2019, 2
> Thu May 30 14:13:42 CST 2019, 3
> Thu May 30 14:13:43 CST 2019, 4
> Thu May 30 14:13:44 CST 2019, 5
> Thu May 30 14:13:45 CST 2019, 6
> Thu May 30 14:13:46 CST 2019, 7
> Thu May 30 14:13:47 CST 2019, 8
> Thu May 30 14:13:48 CST 2019, 9
> Thu May 30 14:13:49 CST 2019, 10
> 
> When the system was running 32 sysbench threads and
> 32 gemmbench threads, it worked as below(the system
> has ~38% idle time)

Are the two workloads assigned different tags?
And how many cores/threads do you have?

> Thu May 30 14:14:20 CST 2019, 1
> Thu May 30 14:14:21 CST 2019, 2
> Thu May 30 14:14:22 CST 2019, 3
> Thu May 30 14:14:24 CST 2019, 4 <=======x=
> Thu May 30 14:14:25 CST 2019, 5
> Thu May 30 14:14:26 CST 2019, 6
> Thu May 30 14:14:28 CST 2019, 7 <=======x=
> Thu May 30 14:14:29 CST 2019, 8
> Thu May 30 14:14:31 CST 2019, 9 <=======x=
> Thu May 30 14:14:34 CST 2019, 10 <=======x=

This feels like "date" failed to schedule on some CPU
on time.

> And it got worse when the system was running 64/64 case,
> the system still had ~3% idle time
> Thu May 30 14:26:40 CST 2019, 1
> Thu May 30 14:26:46 CST 2019, 2
> Thu May 30 14:26:53 CST 2019, 3
> Thu May 30 14:27:01 CST 2019, 4
> Thu May 30 14:27:03 CST 2019, 5
> Thu May 30 14:27:11 CST 2019, 6
> Thu May 30 14:27:31 CST 2019, 7
> Thu May 30 14:27:32 CST 2019, 8
> Thu May 30 14:27:41 CST 2019, 9
> Thu May 30 14:27:56 CST 2019, 10
> 
> Any thoughts?

My first reaction is: when shell wakes up from sleep, it will
fork date. If the script is untagged and those workloads are
tagged and all available cores are already running workload
threads, the forked date can lose to the running workload
threads due to __prio_less() can't properly do vruntime comparison
for tasks on different CPUs. So those idle siblings can't run
date and are idled instead. See my previous post on this:

https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
(Now that I re-read my post, I see that I didn't make it clear
that se_bash and se_hog are assigned different tags(e.g. hog is
tagged and bash is untagged).

Siblings being forced idle is expected due to the nature of core
scheduling, but when two tasks belonging to two siblings are
fighting for schedule, we should let the higher priority one win.

It used to work on v2 is probably due to we mistakenly
allow different tagged tasks to schedule on the same core at
the same time, but that is fixed in v3.
