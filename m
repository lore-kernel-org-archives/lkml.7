Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AECC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313BC265BF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuf3Zngw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEaI0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:26:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43234 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfEaI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:26:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7so63988lfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfC0vBfj3dl+S4JICqcjDoSBUZJGnS+ckX0H0B+UWP8=;
        b=uuf3ZngwL3h2t7t4f1mqw1SA7AcmRSii9KiV/Qip2UqqQwkIcD+M5Ncpooxlpjetn+
         EVwVYGzH/O3ILxbusPiGYoniriBwnLhhb9LcJn2zu+IwE0ZHWaQWjUbup4SXE3tY5shP
         xuTqV3C0Zoq549IsRmGbXJObFgBs0iytW1nh1YMl6A6rtjQPau14oxFWF4rgbO8NbWSY
         1yaAOQn9MbjCB0D927ZUIW8CEG4A+c+ephFuvW9vkTkn5TFYfEoCooAx86i8z8PVrjqt
         djIcCisQKhSypwUNeJd5TzQY131nMP+BgI2vdnOcbQNJbUFWBzECg3+/mriPZrMcUQbK
         rGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfC0vBfj3dl+S4JICqcjDoSBUZJGnS+ckX0H0B+UWP8=;
        b=LMCZenm0k1UDAWP6LcdmKuxkVYVuggl580G9Jpp/WkAhdpefNjkep5lUG1nOMsrL9y
         q5TJ4PdDUhtOJ59amJYn2WmbIS2/rAexh6yY4pZvOYOYX/kPJKU2RbEx2CawKMecQD1t
         ncOLSX8i7/0M1Oi1X1HAN1OGRvs8vXkWO2N8BZXVpxkVXXkkuVBQOHxC5RfbeKlhs1Bs
         69rGdDWzTME2b6YbdxEH9hD3NrwjinOceNs2sEEZWQ0oo8mofoLhYUiR6X4RxTaBMF9y
         QFddxn6oXJUTeRzPafPSIwX80oLv8BTd0Lp5L/ME5kMGuRNpGURS1ZIv5osd0fG4Zs9S
         1aHA==
X-Gm-Message-State: APjAAAUAWHus+ICkovItbbPfP4ASvlRQtxAZPZ3UDk+E1LIz3tw1WkrU
        WJj5q9HCaH7Mipc/b9RU5JC+AZILvpLFRcZC1z0=
X-Google-Smtp-Source: APXvYqyVGfgWVvPGwpdGW2Ln9ZHaOlnCtQ2X4hkv3pLRyIZp7jHZPehfHqxUm45SXgm2E9GU6chipkFtt/uXwtMnQOU=
X-Received: by 2002:a19:a5ca:: with SMTP id o193mr4826260lfe.89.1559291198938;
 Fri, 31 May 2019 01:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com> <CAERHkruVthrTgGqiH=yhCspZWpMDAu0G4rNcrDTKQzgPq9eqQQ@mail.gmail.com>
 <21fda627-1d3c-12cc-6389-8c226218e2ce@linux.alibaba.com> <CAERHkrsjTNUssmECksdJnLdDjVJ_9UpvYiHyBDJ3S1toURCbrw@mail.gmail.com>
 <20190531074456.GA314@aaronlu>
In-Reply-To: <20190531074456.GA314@aaronlu>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 31 May 2019 16:26:26 +0800
Message-ID: <CAERHkru+tx+b_FMoyZYD+F7cWaFZRA7+6UeJEG_aoFJN+DEKkA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 3:45 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On Fri, May 31, 2019 at 02:53:21PM +0800, Aubrey Li wrote:
> > On Fri, May 31, 2019 at 2:09 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> > >
> > > On 2019/5/31 13:12, Aubrey Li wrote:
> > > > On Fri, May 31, 2019 at 11:01 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> > > >>
> > > >> This feels like "date" failed to schedule on some CPU
> > > >> on time.
> > > >>
> > > >> My first reaction is: when shell wakes up from sleep, it will
> > > >> fork date. If the script is untagged and those workloads are
> > > >> tagged and all available cores are already running workload
> > > >> threads, the forked date can lose to the running workload
> > > >> threads due to __prio_less() can't properly do vruntime comparison
> > > >> for tasks on different CPUs. So those idle siblings can't run
> > > >> date and are idled instead. See my previous post on this:
> > > >> https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
> > > >> (Now that I re-read my post, I see that I didn't make it clear
> > > >> that se_bash and se_hog are assigned different tags(e.g. hog is
> > > >> tagged and bash is untagged).
> > > >
> > > > Yes, script is untagged. This looks like exactly the problem in you
> > > > previous post. I didn't follow that, does that discussion lead to a solution?
> > >
> > > No immediate solution yet.
> > >
> > > >>
> > > >> Siblings being forced idle is expected due to the nature of core
> > > >> scheduling, but when two tasks belonging to two siblings are
> > > >> fighting for schedule, we should let the higher priority one win.
> > > >>
> > > >> It used to work on v2 is probably due to we mistakenly
> > > >> allow different tagged tasks to schedule on the same core at
> > > >> the same time, but that is fixed in v3.
> > > >
> > > > I have 64 threads running on a 104-CPU server, that is, when the
> > >
> > > 104-CPU means 52 cores I guess.
> > > 64 threads may(should?) spread on all the 52 cores and that is enough
> > > to make 'date' suffer.
> >
> > 64 threads should spread onto all the 52 cores, but why they can get
> > scheduled while untagged "date" can not? Is it because in the current
>
> If 'date' didn't get scheduled, there will be no output at all unless
> all those workload threads finished :-)

Certainly I meant untagged "date" can not be scheduled on time, :)

>
> I guess the workload you used is not entirely CPU intensive, or 'date'
> can be totally blocked due to START_DEBIT. But note that START_DEBIT
> isn't the problem here, cross CPU vruntime comparison is.
>
> > implementation the task with cookie always has higher priority than the
> > task without a cookie?
>
> No.

I checked the benchmark log manually, it looks like the data of two benchmarks
with cookies are acceptable, but ones without cookies are really bad.
