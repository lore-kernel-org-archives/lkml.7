Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EBBC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41FB21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL/Me8kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEIVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:54:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42933 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:54:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id d4so2459286qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1Y5CP3udzISeDRQqWhtzmQN2i9kFihKEw0JXstWj9M=;
        b=pL/Me8krcAphJ67aosTGp+j/4PRI9lioxkeisVWldcV/Dvs3IsrnsVX0HvwN/dxIAF
         b8DftkernysTHwUvRYe4WvTmlqDQRYhnFMu6GyXGv4Y5PDt9Q56I/xZTnGu9pc2m46py
         JNOa4j8GWjmwqBNKk3cnh7QkBKjTGSGnGK1dNOq+4CC0QgZduczxm1VVNf17nidKPCZX
         mT/ZNXMbB7zLfeRXep+mupiqQauOgpEGVIZjc9lRhhKPfvX0Ug2Q9FlcRBGNRA3kuJRX
         9XsZJB5n1Bx5csGHKcj4BFefSBd8mLVVgRf5bLKhWK/TfPtaAt+ibXDoKsI4Nx/FBolt
         8CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1Y5CP3udzISeDRQqWhtzmQN2i9kFihKEw0JXstWj9M=;
        b=k07rqsFyIad1DgKFjCzMR96F+psErLv8M3UOLnlHrz69DwlV58Yp0dpgA+QKO10Wo7
         PjCP2gB6Jf6gvEKKXLBUN/50hOE1nEsihnvLfgSt/FX0D56d1n6hDvvS4qJTGBUoTQ9G
         R7NFcCnG9vfngBfGvX+giOrHKOtg4lt7F4WwX5MxwhlZhi1t9HdO65l6fVCOMvruZfuX
         /NEVRBkefPB1S1R0qLKVKpNScPbSe5KzVb3EK4gG1B4lVOsfBCQcJGydv91xrfJNd+rk
         w+QVGRBiTM1mbJCqG5rXSY0pCdJJZX1lZav4/Ezx51NyhavJy+/nHTz3RyFvEfEdbuIW
         QcTw==
X-Gm-Message-State: APjAAAVfW8CJPasI0pJH2IxO9u2gjLqD2JbXaK30eLHlfJdn2Kd22xOV
        diTEWunRrtw416cI8v291fb5g1+hSv15HOBT62c=
X-Google-Smtp-Source: APXvYqwVFODnoW/fE5CqlEUhYorMgYr5CnyIy5hZn5PfDJgmsGaRLbRbgwnXzqo93oMEAn8EvGHFJtcsmGyvgVswa90=
X-Received: by 2002:ae9:ea10:: with SMTP id f16mr5536712qkg.5.1557438886786;
 Thu, 09 May 2019 14:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556182964.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1556182964.git.viresh.kumar@linaro.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 9 May 2019 17:54:35 -0400
Message-ID: <CAPhsuW6QXn9HfGN31=1w037mLhc7eSZCOSK-Lor7OWRxg8Ct7A@mail.gmail.com>
Subject: Re: [RFC V2 0/2] sched/fair: Fallback to sched-idle CPU for better performance
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 5:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> Here is another attempt to get some benefit out of the sched-idle
> policy. The previous version [1] focused on getting better power numbers
> and this version tries to get better performance or lower response time
> for the tasks.
>
> The first patch is unchanged from v1 and accumulates
> information about sched-idle tasks per CPU.
>
> The second patch changes the way the target CPU is selected in the fast
> path. Currently, we target for an idle CPU in select_idle_sibling() to
> run the next task, but in case we don't find idle CPUs it is better to
> pick a CPU which will run the task the soonest, for performance reason.
> A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> should be a good target based on this criteria as any normal fair task
> will most likely preempt the currently running SCHED_IDLE task
> immediately. In fact, choosing a SCHED_IDLE CPU shall give better
> results as it should be able to run the task sooner than an idle CPU
> (which requires to be woken up from an idle state).
>
> Basic testing is done with the help of rt-app currently to make sure the
> task is getting placed correctly.

I run some test with this set on our (Facebook's) web service (main job)
and ffmpeg (side job). The result looks promising.

For all the tests below, I run the web service with same load level; and
the side job with SCHED_IDLE. I presented schedule latency distribution
of the main job. The latency distribution is measured with the runqlat tool:
     https://github.com/iovisor/bpftrace/blob/master/tools/runqlat.bt

I modified the tool to only track wake up latency of the main job.

4 cases are compared here:

1. w/o this set, w/o side job;
2. w/ this set, w/o side job;
3. w/o this set, w/ side job;
4. w/ this set, w/ side job;


Case #1. w/o this set, w/o side job
@usecs:
[1]                 1705 |                                                    |
[2, 4)           1102086 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4, 8)            329160 |@@@@@@@@@@@@@@@                                     |
[8, 16)            34135 |@                                                   |
[16, 32)           37466 |@                                                   |
[32, 64)           15700 |                                                    |
[64, 128)           8759 |                                                    |
[128, 256)          5714 |                                                    |
[256, 512)          3718 |                                                    |
[512, 1K)           2152 |                                                    |
[1K, 2K)             882 |                                                    |
[2K, 4K)             256 |                                                    |
[4K, 8K)              48 |                                                    |
[8K, 16K)              2 |                                                    |

Case #2. w/ this set, w/o side job;
@usecs:
[1]                 2121 |                                                    |
[2, 4)           1251877 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4, 8)            401517 |@@@@@@@@@@@@@@@@                                    |
[8, 16)            64325 |@@                                                  |
[16, 32)           74352 |@@@                                                 |
[32, 64)           40583 |@                                                   |
[64, 128)          26129 |@                                                   |
[128, 256)         18612 |                                                    |
[256, 512)         12863 |                                                    |
[512, 1K)           8304 |                                                    |
[1K, 2K)            4072 |                                                    |
[2K, 4K)            1569 |                                                    |
[4K, 8K)             411 |                                                    |
[8K, 16K)             70 |                                                    |
[16K, 32K)             1 |                                                    |

From #1 and #2, we see this set probably adds a little overhead to
scheduling when there is no side job. But the overhead is clearly very
small.


Case #3. w/o this set, w/ side job;
@usecs:
[1]                 1282 |                                                    |
[2, 4)            260977 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                      |
[4, 8)            446120 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8, 16)           136927 |@@@@@@@@@@@@@@@                                     |
[16, 32)          148758 |@@@@@@@@@@@@@@@@@                                   |
[32, 64)          160291 |@@@@@@@@@@@@@@@@@@                                  |
[64, 128)         177292 |@@@@@@@@@@@@@@@@@@@@                                |
[128, 256)        184573 |@@@@@@@@@@@@@@@@@@@@@                               |
[256, 512)        173405 |@@@@@@@@@@@@@@@@@@@@                                |
[512, 1K)         149662 |@@@@@@@@@@@@@@@@@                                   |
[1K, 2K)          120217 |@@@@@@@@@@@@@@                                      |
[2K, 4K)           80275 |@@@@@@@@@                                           |
[4K, 8K)           36108 |@@@@                                                |
[8K, 16K)          11121 |@                                                   |
[16K, 32K)           736 |                                                    |
[32K, 64K)            19 |                                                    |

Case #4. w/ this set, w/ side job;
@usecs:
[1]                  407 |                                                    |
[2, 4)            535378 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
[4, 8)            795526 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8, 16)            93032 |@@@@@@                                              |
[16, 32)           89890 |@@@@@                                               |
[32, 64)           82775 |@@@@@                                               |
[64, 128)          84413 |@@@@@                                               |
[128, 256)         84413 |@@@@@                                               |
[256, 512)         77202 |@@@@@                                               |
[512, 1K)          66043 |@@@@                                                |
[1K, 2K)           49276 |@@@                                                 |
[2K, 4K)           30114 |@                                                   |
[4K, 8K)           11145 |                                                    |
[8K, 16K)           2328 |                                                    |
[16K, 32K)            88 |                                                    |

#3 and #4 clearly showed the benefit of this set. With this set, we see
significantly fewer latency values in the 8usecs+ ranges.

Thanks,
Song

>
> --
> viresh
>
> Viresh Kumar (2):
>   sched: Start tracking SCHED_IDLE tasks count in cfs_rq
>   sched/fair: Fallback to sched-idle CPU if idle CPU isn't found
>
>  kernel/sched/fair.c  | 42 +++++++++++++++++++++++++++++++++---------
>  kernel/sched/sched.h |  2 ++
>  2 files changed, 35 insertions(+), 9 deletions(-)
>
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
> [1] https://lore.kernel.org/lkml/cover.1543229820.git.viresh.kumar@linaro.org/
