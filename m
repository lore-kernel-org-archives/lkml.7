Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE042171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/lWy1OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfCLRYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:24:11 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54462 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfCLRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:56 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so5662751itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NlXEi3emhG/WYSsl8nOZrJjFK+P8wjzHIuDi4pDMGw=;
        b=S/lWy1OYNMcZAszvY/+S7u7iFYwB2tvImYNHp+h2BZ1K/Qpw9siYUo1kfqyOtBr11n
         7uI5B0cXPo9fJM7fc0psjlMxFUFi8RcfZ8Qug4Ztk0U72111mMpX7GGa3vAXDs50wj2F
         7ocGYkrxrH2/yvN9k0oRg8t4WNvS2cdseKRn6WjnEHA1FxvsxMfnqVBzopnTOJ5GjVkh
         +bk2LxlWFMW7/obEuady1Ys9ctDnwQ2tzfZhHl5n2ukImhNSycJ4NAFqpVeLxbTFq5bt
         bB3YmQqQx0lcG0pRG3V4LGfBPhyisqifZ7xft7jCv5i1kKLv9kwhnCa8h1enJfI3JYjG
         Vj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NlXEi3emhG/WYSsl8nOZrJjFK+P8wjzHIuDi4pDMGw=;
        b=sfBosrvQGdHXp9yFlV48gHuHBpKUWZp11sgOFxISe4+SGr0FcTOFN2z1MfyPDPuGEx
         0NPiQxxGTij24Jf05leERgvXEM+i/gsV+JRhLQGS3g84bFwBk6PiFXzRZYpFpbARZtgY
         Run3ewX7ohuqHb8HwTCYdHdKNey7/ZZdwbVZbde3RTkOXLGA3AipkE/Ylm3c/j1XUd+0
         tl/Cq7CN4mkogXFP003shZdZ5LYWfHIzQMpoi00Asz2/+OFzD7yuG6jeEjvYiqumbbyN
         Dx6yh/I4oRwkudrlKMdRj/fbUpfDoSFyoX7UvXzczajBuvGZSC2gwievfll6cmMvynL+
         qvIw==
X-Gm-Message-State: APjAAAWXc+QxS+1C0V3HX8fYYhjQre83pe8A5NKLo2N8x768DjXhp1wd
        1Cb+LiVXxbEolJG4NyDLtweprchisTJllu9TFosIag==
X-Google-Smtp-Source: APXvYqxOaQUOdbWABKdxQHmSBWB0t1gYlMOlKqK+MvAw6URM2JbAF8wERAX49ZZEu7Qx0kyT3DYE7kryqetUW6U5jxM=
X-Received: by 2002:a24:3a8b:: with SMTP id m133mr2651650itm.26.1552411074982;
 Tue, 12 Mar 2019 10:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain> <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz> <20190312163741.GA2762@sultan-box.localdomain>
In-Reply-To: <20190312163741.GA2762@sultan-box.localdomain>
From:   Tim Murray <timmurray@google.com>
Date:   Tue, 12 Mar 2019 10:17:43 -0700
Message-ID: <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 9:37 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>
> On Tue, Mar 12, 2019 at 09:05:32AM +0100, Michal Hocko wrote:
> > The only way to control the OOM behavior pro-actively is to throttle
> > allocation speed. We have memcg high limit for that purpose. Along with
> > PSI, I can imagine a reasonably working user space early oom
> > notifications and reasonable acting upon that.
>
> The issue with pro-active memory management that prompted me to create this was
> poor memory utilization. All of the alternative means of reclaiming pages in the
> page allocator's slow path turn out to be very useful for maximizing memory
> utilization, which is something that we would have to forgo by relying on a
> purely pro-active solution. I have not had a chance to look at PSI yet, but
> unless a PSI-enabled solution allows allocations to reach the same point as when
> the OOM killer is invoked (which is contradictory to what it sets out to do),
> then it cannot take advantage of all of the alternative memory-reclaim means
> employed in the slowpath, and will result in killing a process before it is
> _really_ necessary.

There are two essential parts of a lowmemorykiller implementation:
when to kill and how to kill.

There are a million possible approaches to decide when to kill an
unimportant process. They usually trade off between the same two
failure modes depending on the workload.

If you kill too aggressively, a transient spike that could be
imperceptibly absorbed by evicting some file pages or moving some
pages to ZRAM will result in killing processes, which then get started
up later and have a performance/battery cost.

If you don't kill aggressively enough, you will encounter a workload
that thrashes the page cache, constantly evicting and reloading file
pages and moving things in and out of ZRAM, which makes the system
unusable when a process should have been killed instead.

As far as I've seen, any methodology that uses single points in time
to decide when to kill without completely biasing toward one or the
other is susceptible to both. The minfree approach used by
lowmemorykiller/lmkd certainly is; it is both too aggressive for some
workloads and not aggressive enough for other workloads. My guess is
that simple LMK won't kill on transient spikes but will be extremely
susceptible to page cache thrashing. This is not an improvement; page
cache thrashing manifests as the entire system running very slowly.

What you actually want from lowmemorykiller/lmkd on Android is to only
kill once it becomes clear that the system will continue to try to
reclaim memory to the extent that it could impact what the user
actually cares about. That means tracking how much time is spent in
reclaim/paging operations and the like, and that's exactly what PSI
does. lmkd has had support for using PSI as a replacement for
vmpressure for use as a wakeup trigger (to check current memory levels
against the minfree thresholds) since early February. It works fine;
unsurprisingly it's better than vmpressure at avoiding false wakeups.

Longer term, there's a lot of work to be done in lmkd to turn PSI into
a kill trigger and remove minfree entirely. It's tricky (mainly
because of the "when to kill another process" problem discussed
later), but I believe it's feasible.

How to kill is similarly messy. The latency of reclaiming memory post
SIGKILL can be severe (usually tens of milliseconds, occasionally
>100ms). The latency we see on Android usually isn't because those
threads are blocked in uninterruptible sleep, it's because times of
memory pressure are also usually times of significant CPU contention
and these are overwhelmingly CFS threads, some of which may be
assigned a very low priority. lmkd now sets priorities and resets
cpusets upon killing a process, and we have seen improved reclaim
latency because of this. oom reaper might be a good approach to avoid
this latency (I think some in-kernel lowmemorykiller implementations
rely on it), but we can't use it from userspace. Something for future
consideration.

A non-obvious consequence of both of these concerns is that when to
kill a second process is a distinct and more difficult problem than
when to kill the first. A second process should be killed if reclaim
from the first process has finished and there has been insufficient
memory reclaimed to avoid perceptible impact. Identifying whether
memory pressure continues at the same level can probably be handled
through multiple PSI monitors with different thresholds and window
lengths, but this is an area of future work.

Knowing whether a SIGKILL'd process has finished reclaiming is as far
as I know not possible without something like procfds. That's where
the 100ms timeout in lmkd comes in. lowmemorykiller and lmkd both
attempt to wait up to 100ms for reclaim to finish by checking for the
continued existence of the thread that received the SIGKILL, but this
really means that they wait up to 100ms for the _thread_ to finish,
which doesn't tell you anything about the memory used by that process.
If those threads terminate early and lowmemorykiller/lmkd get a signal
to kill again, then there may be two processes competing for CPU time
to reclaim memory. That doesn't reclaim any faster and may be an
unnecessary kill.

So, in summary, the impactful LMK improvements seem like

- get lmkd and PSI to the point that lmkd can use PSI signals as a
kill trigger and remove all static memory thresholds from lmkd
completely. I think this is mostly on the lmkd side, but there may be
some PSI or PSI monitor changes that would help
- give userspace some path to start reclaiming memory without waiting
for every thread in a process to be scheduled--could be oom reaper,
could be something else
- offer a way to wait for process termination so lmkd can tell when
reclaim has finished and know when killing another process is
appropriate
