Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51944C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D11214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6liV1la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGIPqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:46:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43174 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGIPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:46:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so20010587ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATI/TZzm+B0VbUvyUPBuGeEy3pilz7Di8ahTsMVIDKw=;
        b=S6liV1laeivRRmIWP2pjOtY6fB34kHttLPnB41MOCk/pthvJddX8AmDyFD/RusmiWl
         f5Io9P75NDej9SSck0BTHc9uIbPuXWT3at3VegPJHTdp3YAWgUfZCUegyGhpF/I1Cp8I
         9i++m5GQDFpf1elWGda63cRO+So9Z6WLzZb3gFR4fjx2SRKIvYgkMPRVP1Q3jIbOanvl
         p4D/qkUceAk85LKany0Cvu9ShK1rYB21xqoeTwWxvf9OnHkAMTlogNqC8igPyDlFoHLS
         UC49NeXJXrHv42kEX4ZQB4Yqod/0k1bbfZzIW1n/uzXef4fbYUtTHOatz2fGh71B4dhM
         iyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATI/TZzm+B0VbUvyUPBuGeEy3pilz7Di8ahTsMVIDKw=;
        b=Cd4C+3v8O1+/t6TqVvJLWoRVIUaL0pigz2y+dlq4HP+I89nXWDqnDFkyXZd+oyK446
         WgqDCfI6wJtMHLP+y4OxsFURnV0ewa9tbh2jiujJLokWEWnEloaowIIwT08/WMcxZRxL
         6qNIp7g2UMEVzHWSY8xLnKhxPTUcYXnVqIgl02z9NLqkEnjnDQ8uyL7CTCucDV0UqL5c
         hDYY5fv+NunYxZ3IRAQ4Ufw0O8YxTpz6dvTgNqfH2lAtyEVAooFMalm+M4fzM6r5x/Mh
         CSIh2naGq8Qpr+eA4fh8rS3GFJF7TG+N6I+x+UZJLn5uxnjsAWZmerTci8zxUyQJVSJ2
         UzGw==
X-Gm-Message-State: APjAAAV6wlSd/3fXL95pQnSFZo9J8CanaXXcTa6qdIZ65fSl1Hv7XGFI
        gsThV3iXWPzj/0sUf6+ajccrZd90wAzgXAmqhtqXKQ==
X-Google-Smtp-Source: APXvYqwhnYsBtjymv+e7iT4LtPb38VAweME90FfJ/SAgwtKmIM/VuIfOcRll09QCJIvl+NaemEWfJVSkUfbBVT3bzKk=
X-Received: by 2002:a2e:995a:: with SMTP id r26mr14072623ljj.107.1562687189661;
 Tue, 09 Jul 2019 08:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190709115759.10451-1-chris.redpath@arm.com> <20190709135054.GF3402@hirez.programming.kicks-ass.net>
 <b0d82dbf-f23b-f858-4c60-b5a413c0e618@arm.com> <CAKfTPtCxw8Xqz3rJPKeeDVfvWTcsByAb64_JtB-w2Bp83BGBgw@mail.gmail.com>
 <1128a866-6817-3703-8962-8c3670dd10c1@foss.arm.com>
In-Reply-To: <1128a866-6817-3703-8962-8c3670dd10c1@foss.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Jul 2019 17:46:18 +0200
Message-ID: <CAKfTPtD3j6M5q1feDMQ3S7=YVwL7BJ2ShHcki777Xx2sHbD+_w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Update rq_clock, cfs_rq before migrating for
 asym cpu capacity
To:     Chris Redpath <chris.redpath@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 at 17:42, Chris Redpath <chris.redpath@foss.arm.com> wrote:
>
> On 09/07/2019 16:36, Vincent Guittot wrote:
> > Hi Chris,
> >
> >>
> >> We enter this code quite often in our testing, most individual runs of a
> >> test which has small tasks involved have at least one hit where we make
> >> a change to the clock with this patch in.
> >
> > Do you have a rt-app file that you can share ?
> >
>
> The ThreeSmallTasks test which is the worst hit produces this:
>
> {
>      "tasks": {
>          "small_0": {
>              "policy": "SCHED_OTHER",
>              "delay": 0,
>              "loop": 1,
>              "phases": {
>                  "p000001": {
>                      "loop": 62,
>                      "run": 2880,
>                      "timer": {
>                          "ref": "small_0",
>                          "period": 16000
>                      }
>                  }
>              }
>          },
>          "small_1": {
>              "policy": "SCHED_OTHER",
>              "delay": 0,
>              "loop": 1,
>              "phases": {
>                  "p000001": {
>                      "loop": 62,
>                      "run": 2880,
>                      "timer": {
>                          "ref": "small_1",
>                          "period": 16000
>                      }
>                  }
>              }
>          },
>          "small_2": {
>              "policy": "SCHED_OTHER",
>              "delay": 0,
>              "loop": 1,
>              "phases": {
>                  "p000001": {
>                      "loop": 62,
>                      "run": 2880,
>                      "timer": {
>                          "ref": "small_2",
>                          "period": 16000
>                      }
>                  }
>              }
>          }
>      },
>      "global": {
>          "default_policy": "SCHED_OTHER",
>          "duration": -1,
>          "calibration": 264,
>          "logdir": "/root/devlib-target"
>      }
> }
>
> when I run it

Thanks I will make it a try on my b.L platform

>
> >>
> >> That said - despite the relatively high number of hits only about 5% of
> >> runs see enough additional energy consumed to trigger a test failure. We
> >> do try to keep a quiet system as much as possible and only run for a few
> >> seconds so the impact we see in testing is also probably higher than in
> >> the real world.
> >
> > Yeah, I'm curious to see the impact on a real system which have a
> > 60fps screen update like an android phone
> >
>
> I wouldn't expect much change there but I would on the idle-ish
> homescreen/day-of-use type benchmarks.
>
> If I had a platform with any kind of representative energy use, I'd test
> it :)
