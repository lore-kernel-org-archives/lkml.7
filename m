Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A07E222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="L1aemyzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKSKya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:54:30 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37268 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfKSKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:54:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id u6so13890828vsp.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLtkUESkDarsYpGMcY5/LJpQLbfAZdXaCoyZyWBflKA=;
        b=L1aemyzM1aduLNZwAbSrTDiqpcLqDVmLQ7XFSgddc8EA+l5K2jXQ6ORT6r7115VWVX
         HiPcECQnLNwTf8AgAVbGAc/i6t1DRLeCHqDF8aUnnwq5YXgQSqijLylFm5O6Viqw7sGA
         umY24/2n7asnmh0cQllGJf4akM8O6Cm8mCQCgJtPO3zqYfyVx3zTpgeXD6ZmsprgQetG
         j0S0AU/puPjqxtBYPd7hjJBHzISRmVPBjfO9focyR4OZuN2flk4K+2oD/70HNi0NC/Jz
         ku7V+SEgTxHDPkTow8ajnSe1pler3XauB+52VpNsCMfF7m6q95iYXMvHvA7Bxzoh/fHW
         xdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLtkUESkDarsYpGMcY5/LJpQLbfAZdXaCoyZyWBflKA=;
        b=kcR8kNC1tZZrHC8soRNDeJhJF+wizq3SeCIgiIITcbeDReYGMfC1PU1zMBoamhrFU+
         GP5szBtSThiCNemUZDMQEs37p9bJko0jXvatg66y8vmIprm3gVO7FlXG5yn/+pWCaxrl
         KkYCbxHmpfBwQB+ez7hTd7v6PRnynRyYAxvQHAhkTUzQcnyUeAAW2WJ5dRtxybpruKff
         4d1W6qBGlFli85pvqUwfY07HoDNBrvBdBchKitKC94UmMPxyJf8G9ReMjyOBuzL8LCu9
         /n/YcIbAMKbvpNvEbj3iM15P/3yRT8+c0hNI9PRfhLSmyXIR3e7OsaqoUAoypWgRGtUH
         4V7g==
X-Gm-Message-State: APjAAAUmxrjc4E+QMB4DwVWYs1tMdiIuwsDhVRKMNaoWLiMpLYkjTFOT
        QHZESTrAfag5uL/SbsHuDvZsXjGqQ8HBhQ3jEmNidg==
X-Google-Smtp-Source: APXvYqw/jaAhqAUxnB8KffVvYBscfdFeLbX307kwZidhP2VTnhqF+a6zd3OJ6FkoYzjz+UIZHRushldSgGNRpOfmnLw=
X-Received: by 2002:a67:3217:: with SMTP id y23mr22858901vsy.182.1574160868651;
 Tue, 19 Nov 2019 02:54:28 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 19 Nov 2019 16:24:17 +0530
Message-ID: <CAHLCerNoPW4DSD5-j=CFQ7K9Pn_YzSAz1qKx7n6=_pvCXdzfFg@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Introduce Thermal Pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, qperret@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:20 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Thermal governors can respond to an overheat event of a cpu by
> capping the cpu's maximum possible frequency. This in turn
> means that the maximum available compute capacity of the
> cpu is restricted. But today in the kernel, task scheduler is
> not notified of capping of maximum frequency of a cpu.
> In other words, scheduler is unaware of maximum capacity
> restrictions placed on a cpu due to thermal activity.
> This patch series attempts to address this issue.
> The benefits identified are better task placement among available
> cpus in event of overheating which in turn leads to better
> performance numbers.
>
> The reduction in the maximum possible capacity of a cpu due to a
> thermal event can be considered as thermal pressure. Instantaneous
> thermal pressure is hard to record and can sometime be erroneous
> as there can be mismatch between the actual capping of capacity
> and scheduler recording it. Thus solution is to have a weighted
> average per cpu value for thermal pressure over time.
> The weight reflects the amount of time the cpu has spent at a
> capped maximum frequency. Since thermal pressure is recorded as
> an average, it must be decayed periodically. Exisiting algorithm
> in the kernel scheduler pelt framework is re-used to calculate
> the weighted average. This patch series also defines a sysctl
> inerface to allow for a configurable decay period.
>
> Regarding testing, basic build, boot and sanity testing have been
> performed on db845c platform with debian file system.
> Further, dhrystone and hackbench tests have been
> run with the thermal pressure algorithm. During testing, due to
> constraints of step wise governor in dealing with big little systems,

What contraints?

> trip point 0 temperature was made assymetric between cpus in little
> cluster and big cluster; the idea being that
> big core will heat up and cpu cooling device will throttle the
> frequency of the big cores faster, there by limiting the maximum available
> capacity and the scheduler will spread out tasks to little cores as well.

Can you share the hack to get this behaviour as well so I can try to
reproduce on 845c?

> Test Results
>
> Hackbench: 1 group , 30000 loops, 10 runs
>                                                Result         SD
>                                                (Secs)     (% of mean)
>  No Thermal Pressure                            14.03       2.69%
>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%
>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%
>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%
>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%
>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%
>
