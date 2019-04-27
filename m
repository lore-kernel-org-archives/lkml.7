Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A44C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD7D208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueyfzFys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfD0DwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:52:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44775 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfD0DwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:52:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id h18so3771411lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpWcnfmzZ7ec68S493ukJ+jRPCgyuACvRPzYEL86aaY=;
        b=ueyfzFyslo3t+L3eQMpZu2N2uFAzraig8duw9+5UxnzyZNyIO/AyahDEDQDvd52aNX
         lzgjKo/waxWh8gFYye8IBkYJs2SRUj9ZVnWtKQS6FSAzan25ShghUxfQi3WKbdBIbMm7
         L3wI2ofq67Dnvq40h30m3XK/d2EWN403I1Cnu0FoGo++ErnVpHCDzwFYnmtokTCii7cR
         NVBBHi0kdLmXe3uDrsB8PUPuJ1UqAKJQYWLPuwO2AOqMoJRgl4457PSWNRF6ze31s+nt
         1o3xz2XSn4HiIsxS185NK6Q9jtOdCKTi+ah3ngWdEXCadf6d7lAay3HabGBat72iJ5fB
         rI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpWcnfmzZ7ec68S493ukJ+jRPCgyuACvRPzYEL86aaY=;
        b=o2EqThkgUoUd+++UNp9QY0HCPufrL+EDq5LAgMxkiEeOYQlN5/zyiXkbFEn9SKvhPT
         YdjvXBoeQCVd0TQW3oz2G3BfPX6jrN9LFZ6J6SDGnUcVbxjnDvStLv4QVnP23ffKpmrX
         Ai/1TO39nAX3S1sfsJ2f/aso1Fw2FnroTpJs3G3ITvEiIuhsy4YCLynL6cwoU6dvv1/W
         aE69BeLxSqPv5yrHpEKycXD2fzQkGr4+hgKXDhkha5855CqvWPhIawY7DmvEY72cDvNv
         kyQLX8LYqX2Pe2D0MGmdY1r9GvnnsIAU8IbnmN/0+WhjgZQqVLoHX0HvtOZ2qRDAYXO6
         qPMg==
X-Gm-Message-State: APjAAAUKWoqYc1nNbgoM+9lh8GwcHg3h4vk8v/EV9hW5FUsfWsVIJqWt
        TckB0la1ewX713Q7nrHNfxxehHEs297nybPZPow=
X-Google-Smtp-Source: APXvYqxmS3ewRnlVr0SyDbVPns05TFBIWB2SDfpwkT40IQrVxshcd+uJPxz9xK892fP2eO502FyRmQ4/03Vz8TQKe7E=
X-Received: by 2002:a19:6a06:: with SMTP id u6mr27506594lfu.26.1556337117313;
 Fri, 26 Apr 2019 20:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad> <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
In-Reply-To: <20190425095508.GA8387@gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 27 Apr 2019 11:51:46 +0800
Message-ID: <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 5:55 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Aubrey Li <aubrey.intel@gmail.com> wrote:
> > On Wed, Apr 24, 2019 at 10:00 PM Julien Desfossez
> > <jdesfossez@digitalocean.com> wrote:
> > >
> > > On 24-Apr-2019 09:13:10 PM, Aubrey Li wrote:
> > > > On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
> > > > <vpillai@digitalocean.com> wrote:
> > > > >
> > > > > Second iteration of the core-scheduling feature.
> > > > >
> > > > > This version fixes apparent bugs and performance issues in v1. This
> > > > > doesn't fully address the issue of core sharing between processes
> > > > > with different tags. Core sharing still happens 1% to 5% of the time
> > > > > based on the nature of workload and timing of the runnable processes.
> > > > >
> > > > > Changes in v2
> > > > > -------------
> > > > > - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
> > > >
> > > > Thanks to post v2, based on this version, here is my benchmarks result.
> > > >
> > > > Environment setup
> > > > --------------------------
> > > > Skylake server, 2 numa nodes, 104 CPUs (HT on)
> > > > cgroup1 workload, sysbench (CPU intensive non AVX workload)
> > > > cgroup2 workload, gemmbench (AVX512 workload)
> > > >
> > > > Case 1: task number < CPU num
> > > > --------------------------------------------
> > > > 36 sysbench threads in cgroup1
> > > > 36 gemmbench threads in cgroup2
> > > >
> > > > core sched off:
> > > > - sysbench 95th percentile latency(ms): avg = 4.952, stddev = 0.55342
> > > > core sched on:
> > > > - sysbench 95th percentile latency(ms): avg = 3.549, stddev = 0.04449
> > > >
> > > > Due to core cookie matching, sysbench tasks won't be affect by AVX512
> > > > tasks, latency has ~28% improvement!!!
> > > >
> > > > Case 2: task number > CPU number
> > > > -------------------------------------------------
> > > > 72 sysbench threads in cgroup1
> > > > 72 gemmbench threads in cgroup2
> > > >
> > > > core sched off:
> > > > - sysbench 95th percentile latency(ms): avg = 11.914, stddev = 3.259
> > > > core sched on:
> > > > - sysbench 95th percentile latency(ms): avg = 13.289, stddev = 4.863
> > > >
> > > > So not only power, now security and performance is a pair of contradictions.
> > > > Due to core cookie not matching and forced idle introduced, latency has ~12%
> > > > regression.
> > > >
> > > > Any comments?
> > >
> > > Would it be possible to post the results with HT off as well ?
> >
> > What's the point here to turn HT off? The latency is sensitive to the
> > relationship
> > between the task number and CPU number. Usually less CPU number, more run
> > queue wait time, and worse result.
>
> HT-off numbers are mandatory: turning HT off is by far the simplest way
> to solve the security bugs in these CPUs.
>
> Any core-scheduling solution *must* perform better than HT-off for all
> relevant workloads, otherwise what's the point?
>
I have the same environment setup above, for nosmt cases, I used
/sys interface Thomas mentioned, below is the result:

NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
1/1      1.987( 1.97%)   2.043( 1.76%) -2.84% 1.985( 1.70%)  0.12%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
2/2      2.074( 1.16%)   2.057( 2.09%)  0.81% 2.072( 0.77%)  0.10%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
4/4      2.140( 0.00%)   2.138( 0.49%)  0.09% 2.137( 0.89%)  0.12%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
8/8      2.140( 0.00%)   2.144( 0.53%) -0.17% 2.140( 0.00%)  0.00%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
16/16    2.361( 2.99%)   2.369( 2.65%) -0.30% 2.406( 2.53%) -1.87%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
32/32    5.032( 8.68%)   3.485( 0.49%) 30.76% 6.002(27.21%) -19.27%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
64/64    7.577(34.35%)   3.972(23.18%) 47.57% 18.235(14.14%) -140.68%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
128/128 24.639(14.28%)  27.440( 8.24%) -11.37% 34.746( 6.92%) -41.02%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
256/256 38.797( 8.59%)  44.067(16.20%) -13.58% 42.536( 7.57%) -9.64%

Thanks,
-Aubrey
