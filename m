Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C19EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0490820693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HliUuNxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394469AbfIFOcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:32:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39616 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbfIFOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:32:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id j16so6218517ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOQeqxzL2VcRL6ZYImhbl/u4E/vqj+oJ+z2PtQzLoSA=;
        b=HliUuNxjiuAHyl/V5+MxFwm7cnCiZRak2XtOgE2mD3DhaMnq1HqG8GD5Ed23ZQDjxf
         VspcUw0/FR3t62kogFTm+aF/6uBLcc5+LAJ4WwsA0nuf5P5Ye7nF5QMOp3A4FBAzQujK
         miKVpktI+xmtcSJEiB7ye3pZg1QgUV4O6BNkinKWGMO3QSdV60FS4yCv+dfmD1Auzfyo
         dclEvqnYEn6wn66KlP+jdjf2WlLrtsxH6AOisYzEHjFnoMPMFhGn5EvPUgb8yS9pRGlk
         oPMhfrgGd9Sb7YjZwfTL8FtXa5oq2mDlc2O+R0Rri15eQGzn4pBzC8lnlP7XtlgNH+/u
         RnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOQeqxzL2VcRL6ZYImhbl/u4E/vqj+oJ+z2PtQzLoSA=;
        b=OZeYLuGYkeHLd799HqYoj3HY4YEnoR+bjxo3PbZcoROyrzRe4GgeJhuGV+p7t4l+BD
         XD2Hm/GcL9soVdOHh/yPW1u7YcJpJ4I6C77jVXwRc9I9QcEMv9B1rQ6gx60cX1c5zRRT
         m/du414L4JlezlKRsKXaN4qWp0RXiFIJdikkfvR5aKnPrbjkSftfhqkaoLmMjleQQm0n
         MdXUqEUm19zETTrUMETARbKNkShVl5V8Hil3CUqjSU/LiJBg+1pOq1kyTPKHjm5DJoSE
         VZIjQq0Cv0ulP4Tqv8rYketUmhL/opUThpvZVmlstVt8yetRo03AhPmIagjxmNQPJE72
         e+WQ==
X-Gm-Message-State: APjAAAW2QRh8g9Ng2yeXRi7A4Cr/MjS3fg7ut4LQzAJ5VASIcwL7Spi3
        2SIWyEtNMxJohooMwDZO2N6IQoRv1rz2lrgmyCOm2A==
X-Google-Smtp-Source: APXvYqxCDivhWQzJtRbcLc7oov2JgtxOpIlb53kzTA4r0PKB8nE3oDhDljA7Bc1d4YVB6hfvSYhGBshdv1PZTO7g7hY=
X-Received: by 2002:a2e:94cd:: with SMTP id r13mr5964644ljh.24.1567780361923;
 Fri, 06 Sep 2019 07:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com> <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com> <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <87imq72dpc.fsf@arm.com> <df69627e-8aa0-e2cb-044e-fb392f34efa5@arm.com>
 <87d0ge3n85.fsf@arm.com> <3bb17e15-5492-b78c-20a8-5989519f20e2@linux.ibm.com> <75e782c7-121d-a0ea-7fbf-efb0c83f50e6@arm.com>
In-Reply-To: <75e782c7-121d-a0ea-7fbf-efb0c83f50e6@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Sep 2019 16:32:30 +0200
Message-ID: <CAKfTPtCwHS8k-0g=j2On=5GyHmTd4bfYNY5vfZRA11iT5jPxQw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Parth Shah <parth@linux.ibm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        steven.sistare@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 at 16:13, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 06/09/2019 13:45, Parth Shah wrote:>
> > I guess there is some usecase in case of thermal throttling.
> > If a task is heating up the core then in ideal scenarios POWER systems throttle
> > down to rated frequency.
> > In such case, if the task is latency sensitive (min latency nice), we can move the
> > task around the chip to heat up the chip uniformly allowing me to gain more performance
> > with sustained higher frequency.
> > With this, we will require the help from active load balancer and latency-nice
> > classification on per task and/or group basis.
> >
> > Hopefully, this might be useful for other arch as well, right?
> >
>
> Most of the functionality is already there, we're only really missing thermal
> pressure awareness. There was [1] but it seems to have died.

Thara still works on it but she has been sidetracked on other
activities and  It takes more time than expected to run all tests with
different averaging window and process the results
>
>
> At least with CFS load balancing, if thermal throttling is correctly
> reflected as a CPU capacity reduction you will tend to move things away from
> that CPU, since load is balanced over capacities.
>
>
> For active balance, we actually already have a condition that moves a task
> to a less capacity-pressured CPU (although it is somewhat specific). So if
> thermal pressure follows that task (e.g. it's doing tons of vector/float),
> it will be rotated around.
>
> However there should be a point made on latency vs throughput. If you
> care about latency you probably do not want to active balance your task. If
> you care about throughput, it should be specified in some way (util-clamp
> says hello!).
>
> It sort of feels like you'd want an extension of misfit migration (salesman
> hat goes on from here) - misfit moves tasks that are CPU bound (IOW their
> util is >= 80% of the CPU capacity) to CPUs of higher capacity. It's only
> enabled for systems with asymmetric capacities, but could be enabled globally
> for "dynamically-created asymmetric capacities" (IOW RT/IRQ/thermal pressure
> on SMP systems).
>
> On top of that, if we make misfit consider e.g. uclamp.min (I don't think
> that's already the case), then you have your throughput knob to have *some*
> designated tasks move away from (thermal & else) pressure.
>
>
> [1]: https://lore.kernel.org/lkml/1555443521-579-1-git-send-email-thara.gopinath@linaro.org/
