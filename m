Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AE421874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5mZUpGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH3GrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:47:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45747 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfH3GrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:47:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so3590087lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1cxyeKWPxeVuoZEhXkXAHwppIIEHjcbmTaw0G875BA=;
        b=m5mZUpGIp+4ikDLzQkDvQHmDuazBbQ6cN/gpsldLAkw+RLmFVK7hgOBFwN1AToXBed
         kxZubeesJS9x3Q6kU1eTkKHIhwvlQa21rbFB6Hfqo7YHufr6SpLIdCTSzCBnlF5lu77S
         tokFOFrWGX59FgUC2/Td099Z7xJS2Vk+aQBaARDAVE0lL2Ec20V7v0vjd1/rMaEjfj/d
         sp75pEzlL9W/FxX5XS7P+wH7w0Y783U7FV4N0C3wFtC689dnEym7PFgDP6UgC/O9BujP
         zfU1D4zPq3inhaeiGKC5Tif++VKTnVj/DFZwfGtDH5RMqgVQT+jdl34tGuVfDPLG5PWW
         SJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1cxyeKWPxeVuoZEhXkXAHwppIIEHjcbmTaw0G875BA=;
        b=IeoRMJvKwNB3OL85njnHe8Ocqp2owXus4r4fVgRBud5id7jO/tp+LwObpeuwmffE2Z
         ZatRRM5ym2Wc45fxus+Yofm0SCld14BmQCdtNvZi5xxV2LRpUZXp4TlW1yTyQgjAi0x+
         NaDLGHqwnbZj/PYb18c8JrtbrZ7+SDbpaVFpGF1gYY7QREnOnazqnTGKnWLn34UIoRlo
         v2WmJZKLS3XV8FGdPak62CegwndO6rciMK/rd3f2cbnIiVjrETJtbLMXqPjZlPy4A/r0
         KCqHFRxulE5XJM8rltC3frNoOIj5GiRdi9sDbzTExfrxuuSABkAEk7ljBGRlRlQsWMTf
         fCaQ==
X-Gm-Message-State: APjAAAWTwToFqXYEsfesI+dx5PqbXzp8qfYZd6rKcGWx0zpyRkrqg1qf
        u2EKZ5R57U5YXQPIT02tMJM0AuCgKXW9IH7OXuWwoQ==
X-Google-Smtp-Source: APXvYqyJjMjan47wtuWWUDQRt88yWdtn/iDbyQgoBW7pyJ7k3/aYOVYQRhfySb4q60pTsM2P40fZV2mD86rUXNxGEGo=
X-Received: by 2002:a19:f806:: with SMTP id a6mr8396742lff.151.1567147624612;
 Thu, 29 Aug 2019 23:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org> <20190829192305.GD20736@pauld.bos.csb>
In-Reply-To: <20190829192305.GD20736@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Aug 2019 08:46:53 +0200
Message-ID: <CAKfTPtBV-KU9zJXwZ7B3ojriTcbyJLek=oUrsJxA8ppbma90nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] sched/fair: rework the CFS load balance
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Thu, 29 Aug 2019 at 21:23, Phil Auld <pauld@redhat.com> wrote:
>
> On Thu, Aug 01, 2019 at 04:40:16PM +0200 Vincent Guittot wrote:
> > Several wrong task placement have been raised with the current load

> >
> > --
> > 2.7.4
> >
>
> I keep expecting a v3 so I have not dug into all the patches in detail. However, I've

v3 is under preparation

> been working with them from Vincent's tree while they were under development so I thought
> I'd add some results.

Yes. thanks for your help.

>
> The workload is a test our perf team came up with to illustrate the issues we were seeing
> with imbalance in the presence of group scheduling.
>
> On a 4-numa X 20 cpu system (smt on) we run a 76 thread lu.C benchmark from the NAS Parallel
> suite. And at the same time run 2 stress cpu burn processes.  The GROUP test puts the
> benchmark and the stress processes each in its own cgroup.  The NORMAL case puts them all
> in the first cgroup.  The results show first the average number of threads of each type
> running on each of the numa nodes based on sampling taken during the run.  This is followed
> by the lu.C benchmark results. There are 3 runs of GROUP and 2 runs of NORMAL shown.
>
> Before (linux-5.3-rc1+  @  a1dc0446d649)
>
> lu.C.x_76_GROUP_1.stress.ps.numa.hist   Average    0.00  1.00  1.00
> lu.C.x_76_GROUP_2.stress.ps.numa.hist   Average    0.00  1.00  1.00
> lu.C.x_76_GROUP_3.stress.ps.numa.hist   Average    0.00  1.00  1.00
> lu.C.x_76_NORMAL_1.stress.ps.numa.hist  Average    1.15  0.23  0.00  0.62
> lu.C.x_76_NORMAL_2.stress.ps.numa.hist  Average    1.67  0.00  0.00  0.33
>
> lu.C.x_76_GROUP_1.ps.numa.hist   Average    30.45  6.95  4.52  34.08
> lu.C.x_76_GROUP_2.ps.numa.hist   Average    32.33  8.94  9.21  25.52
> lu.C.x_76_GROUP_3.ps.numa.hist   Average    30.45  8.91  12.09  24.55
> lu.C.x_76_NORMAL_1.ps.numa.hist  Average    18.54  19.23  19.69  18.54
> lu.C.x_76_NORMAL_2.ps.numa.hist  Average    17.25  19.83  20.00  18.92
>
> ============76_GROUP========Mop/s===================================
> min     q1      median  q3      max
> 2119.92 2418.1  2716.28 3147.82 3579.36
> ============76_GROUP========time====================================
> min     q1      median  q3      max
> 569.65  660.155 750.66  856.245 961.83
> ============76_NORMAL========Mop/s===================================
> min     q1      median  q3      max
> 30424.5 31486.4 31486.4 31486.4 32548.4
> ============76_NORMAL========time====================================
> min     q1      median  q3      max
> 62.65   64.835  64.835  64.835  67.02
>
>
> After (linux-5.3-rc1+  @  a1dc0446d649 + this v2 series pulled from
> Vincent's git on ~8/15)
>
> lu.C.x_76_GROUP_1.stress.ps.numa.hist   Average    0.36  1.00  0.64
> lu.C.x_76_GROUP_2.stress.ps.numa.hist   Average    1.00  1.00
> lu.C.x_76_GROUP_3.stress.ps.numa.hist   Average    1.00  1.00
> lu.C.x_76_NORMAL_1.stress.ps.numa.hist  Average    0.23  0.15  0.31  1.31
> lu.C.x_76_NORMAL_2.stress.ps.numa.hist  Average    1.00  0.00  0.00  1.00
>
> lu.C.x_76_GROUP_1.ps.numa.hist   Average    18.91  18.36  18.91  19.82
> lu.C.x_76_GROUP_2.ps.numa.hist   Average    18.36  18.00  19.91  19.73
> lu.C.x_76_GROUP_3.ps.numa.hist   Average    18.17  18.42  19.25  20.17
> lu.C.x_76_NORMAL_1.ps.numa.hist  Average    19.08  20.00  18.62  18.31
> lu.C.x_76_NORMAL_2.ps.numa.hist  Average    18.09  19.91  19.18  18.82
>
> ============76_GROUP========Mop/s===================================
> min     q1      median  q3      max
> 32304.1 33176   34047.9 34166.8 34285.7
> ============76_GROUP========time====================================
> min     q1      median  q3      max
> 59.47   59.68   59.89   61.505  63.12
> ============76_NORMAL========Mop/s===================================
> min     q1      median  q3      max
> 29825.5 32454   32454   32454   35082.5
> ============76_NORMAL========time====================================
> min     q1      median  q3      max
> 58.12   63.24   63.24   63.24   68.36
>
>
> I had initially tracked this down to two issues. The first was picking the wrong
> group in find_busiest_group due to using the average load. The second was in
> fix_small_imbalance(). The "load" of the lu.C tasks was so low it often failed
> to move anything even when it did find a group that was overloaded (nr_running
> > width). I have two small patches which fix this but since Vincent was embarking
> on a re-work which also addressed this I dropped them.
>
> We've also run a series of performance tests we use to check for regressions and
> did not find any bad results on our workloads and systems.
>
> So...
>
> Tested-by: Phil Auld <pauld@redhat.com>

Thanks for testing

Vincent

>
>
> Cheers,
> Phil
> --
