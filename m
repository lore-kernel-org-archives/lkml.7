Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD87C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6732072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLIJTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:19:08 -0500
Received: from foss.arm.com ([217.140.110.172]:52738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLIJTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:19:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DAB3328;
        Mon,  9 Dec 2019 01:19:07 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1766F3F6CF;
        Mon,  9 Dec 2019 01:19:04 -0800 (PST)
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched
 hierarchy
To:     Josh Don <joshdon@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
References: <20191204200623.198897-1-joshdon@google.com>
 <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <edc9f4aa-a6ab-3bab-0a9e-73a155b8a48a@arm.com>
Date:   Mon, 9 Dec 2019 10:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.19 23:13, Josh Don wrote:

[...]

> On Thu, Dec 5, 2019 at 11:57 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> Hi Josh,
>>
>> On Wed, 4 Dec 2019 at 21:06, Josh Don <joshdon@google.com> wrote:
>>>
>>> From: Venkatesh Pallipadi <venki@google.com>
>>>
>>> Setting skip buddy all the way up the hierarchy does not play well
>>> with intra-cgroup yield. One typical usecase of yield is when a
>>> thread in a cgroup wants to yield CPU to another thread within the
>>> same cgroup. For such a case, setting the skip buddy all the way up

But with yield_task{_fair}() you have no way to control which other task
gets accelerated. The other task in the taskgroup (cgroup) could be even
on another CPU.

It's not like yield_to_task_fair() which uses next buddy to accelerate
another task p.

What's this typical usecase?

>>> the hierarchy is counter-productive, as that results in CPU being
>>> yielded to a task in some other cgroup.
>>>
>>> So, limit the skip effect only to the task requesting it.

[...]
