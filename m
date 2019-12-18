Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29490C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061F324672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLRLgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:36:55 -0500
Received: from foss.arm.com ([217.140.110.172]:43050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfLRLgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:36:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F33A030E;
        Wed, 18 Dec 2019 03:36:53 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0E43F6CF;
        Wed, 18 Dec 2019 03:36:51 -0800 (PST)
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched
 hierarchy
To:     Josh Don <joshdon@google.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
References: <20191204200623.198897-1-joshdon@google.com>
 <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
 <edc9f4aa-a6ab-3bab-0a9e-73a155b8a48a@arm.com>
 <CABk29Ns3v3KqAo89oEOqQjRQxWN4Wgc+YtweWbS13MtmsUJeyw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <55c162e4-2f3a-5628-cbe3-31bce6cb8480@arm.com>
Date:   Wed, 18 Dec 2019 12:36:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABk29Ns3v3KqAo89oEOqQjRQxWN4Wgc+YtweWbS13MtmsUJeyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 23:19, Josh Don wrote:
> On Mon, Dec 9, 2019 at 1:19 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 06.12.19 23:13, Josh Don wrote:
>>
>> [...]
>>
>>> On Thu, Dec 5, 2019 at 11:57 PM Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>>
>>>> Hi Josh,
>>>>
>>>> On Wed, 4 Dec 2019 at 21:06, Josh Don <joshdon@google.com> wrote:
>>>>>
>>>>> From: Venkatesh Pallipadi <venki@google.com>
>>>>>
>>>>> Setting skip buddy all the way up the hierarchy does not play well
>>>>> with intra-cgroup yield. One typical usecase of yield is when a
>>>>> thread in a cgroup wants to yield CPU to another thread within the
>>>>> same cgroup. For such a case, setting the skip buddy all the way up
>>
>> But with yield_task{_fair}() you have no way to control which other task
>> gets accelerated. The other task in the taskgroup (cgroup) could be even
>> on another CPU.
>>
>> It's not like yield_to_task_fair() which uses next buddy to accelerate
>> another task p.
>>
>> What's this typical usecase?
> 
> The semantics for yield_task under CFS are not well-defined.  With our
> CFS hierarchy, we cannot easily just push a yielded task to the end of
> a runqueue.  And, we don't want to play games with artificially
> increasing vruntime, as this results in potentially high latency for a
> yielded task to get back on CPU.
> 
> I'd interpret a task that calls yield as saying "I can run, but try to
> run something else."  I'd agree that this patch is imperfect in
> achieving this, but I think it is better than the current
> implementation (or at least, less broken).  Currently, a side-effect
> of calling yield is that all other tasks in the same hierarchy get
> skipped as well.  This is almost certainly not what the user
> expects/wants.  It is true that if a yielded task has no other tasks
> in its cgroup on the same CPU, we will potentially end up just picking
> the yielded task again.  But this should be OK; a yielded task should
> be able to continue making forward progress.  Any yielded task that
> calls yield again is likely implementing a busy loop, which is an
> improper use of yield anyway.

I see the issue you want to address.

But isn't then the comment in the patch "... a thread in a cgroup wants
to yield CPU to another thread within the same cgroup ..." misleading?

IMHO, a task can't yield to another task. It can only relinquish the CPU.

Someone could argue that in the current implementation, the task which
calls yield acts on behalf of all the tasks in its taskgroup hierarchy.
But this can have issues as you pointed out.

[...]
