Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73EFC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521521479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfEUCzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:55:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfEUCzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:55:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448EB341;
        Mon, 20 May 2019 19:55:46 -0700 (PDT)
Received: from [10.162.42.136] (p8cg001049571a15.blr.arm.com [10.162.42.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8091A3F718;
        Mon, 20 May 2019 19:55:42 -0700 (PDT)
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Tim Murray <timmurray@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
 <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
Date:   Tue, 21 May 2019 08:25:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/20/2019 10:29 PM, Tim Murray wrote:
> On Sun, May 19, 2019 at 11:37 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> Or Is the objective here is reduce the number of processes which get killed by
>> lmkd by triggering swapping for the unused memory (user hinted) sooner so that
>> they dont get picked by lmkd. Under utilization for zram hardware is a concern
>> here as well ?
> 
> The objective is to avoid some instances of memory pressure by
> proactively swapping pages that userspace knows to be cold before
> those pages reach the end of the LRUs, which in turn can prevent some
> apps from being killed by lmk/lmkd. As soon as Android userspace knows
> that an application is not being used and is only resident to improve
> performance if the user returns to that app, we can kick off
> process_madvise on that process's pages (or some portion of those
> pages) in a power-efficient way to reduce memory pressure long before
> the system hits the free page watermark. This allows the system more
> time to put pages into zram versus waiting for the watermark to
> trigger kswapd, which decreases the likelihood that later memory
> allocations will cause enough pressure to trigger a kill of one of
> these apps.

So this opens up bit of LRU management to user space hints. Also because the app
in itself wont know about the memory situation of the entire system, new system
call needs to be called from an external process.

> 
>> Swapping out memory into zram wont increase the latency for a hot start ? Or
>> is it because as it will prevent a fresh cold start which anyway will be slower
>> than a slow hot start. Just being curious.
> 
> First, not all swapped pages will be reloaded immediately once an app
> is resumed. We've found that an app's working set post-process_madvise
> is significantly smaller than what an app allocates when it first
> launches (see the delta between pswpin and pswpout in Minchan's
> results). Presumably because of this, faulting to fetch from zram does

pswpin      417613    1392647     975034     233.00
pswpout    1274224    2661731    1387507     108.00

IIUC the swap-in ratio is way higher in comparison to that of swap out. Is that
always the case ? Or it tend to swap out from an active area of the working set
which faulted back again.

> not seem to introduce a noticeable hot start penalty, not does it
> cause an increase in performance problems later in the app's
> lifecycle. I've measured with and without process_madvise, and the
> differences are within our noise bounds. Second, because we're not

That is assuming that post process_madvise() working set for the application is
always smaller. There is another challenge. The external process should ideally
have the knowledge of active areas of the working set for an application in
question for it to invoke process_madvise() correctly to prevent such scenarios.

> preemptively evicting file pages and only making them more likely to
> be evicted when there's already memory pressure, we avoid the case
> where we process_madvise an app then immediately return to the app and
> reload all file pages in the working set even though there was no
> intervening memory pressure. Our initial version of this work evicted

That would be the worst case scenario which should be avoided. Memory pressure
must be a parameter before actually doing the swap out. But pages if know to be
inactive/cold can be marked high priority to be swapped out.

> file pages preemptively and did cause a noticeable slowdown (~15%) for
> that case; this patch set avoids that slowdown. Finally, the benefit
> from avoiding cold starts is huge. The performance improvement from
> having a hot start instead of a cold start ranges from 3x for very
> small apps to 50x+ for larger apps like high-fidelity games.

Is there any other real world scenario apart from this app based ecosystem where
user hinted LRU management might be helpful ? Just being curious. Thanks for the
detailed explanation. I will continue looking into this series.
