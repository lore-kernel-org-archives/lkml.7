Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022D0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C997F21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfAjV9pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKLPkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:40:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45010 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:40:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so18286648ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zu0KReonp/Dvh814/aR49/dIUTQPkHFLFvLTh9BjBJU=;
        b=jfAjV9pe3qHgAPYXC5bDWCM6SehVsqSrXaCyvKhOT+teEhUMll9b1VNsEeMotXM2fI
         RX85n4pFKuzyrnSnd9lylg3PQuLfzIM1r6Juo28sJGwTM4u3hKhaWC6F3qDkZztXqfmq
         06fB86V3nYiLkZFWvIgH4qFOHKeFDtNQqgPSH8sOLUasj09jjdiwJZ7dsCOw8A9VStFD
         0ajLXfrCKcnhq4V3PNOCwbIa+4vWgABN4Abv0YIElqpFZB+XAHzA3my6B25btWKS140X
         eD2M+ibGqnB4XtWq7R0ZjyT6XB7ERFqjNkjtlE+VWCGWFMfx5BWHUNTwONHLaYgt0Sjd
         z76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zu0KReonp/Dvh814/aR49/dIUTQPkHFLFvLTh9BjBJU=;
        b=FDFytUtHOFSgBgSeuzMXEOxCXlx9YrEyBhoIo+2ZKNCucqPDcDSZwx/njib+kY1dxP
         N9ThcidWD4+hBd9iZZ0dNUW+ItWTV1HtJnUsKkh3bF5+n1LjEFi0ivzgj0pebi10U+92
         t/ugxu9yzJ3/yRizJ5XGe1GutTD8yotdytP0HZGLULLbIRlBZUxWCqSXWFjDrFCVrTzL
         I3L+STWCAisxls26laPNrLttuGJClIYDa/yl1Pcy6GoPad1KIIwzZcVYhsY6ySwcDedi
         1NSp2SnPU5+9k/JDYXHFrk4/IVChMR71l8XOREevgYOXvP4EBfmvZtR6kJ59O5+g2A4f
         zkDA==
X-Gm-Message-State: APjAAAVPQwTZN3uNZmIPA4ZpU3len0taplkFN52b+O6VSLFEOKlH7jYT
        Eds5M2RWZH5hCRBuivF3Gf7oi5IaYIJxQ8RHqVgQ4A==
X-Google-Smtp-Source: APXvYqwzurXFq2vYxkN+AxLmD0lXELsNpIBZBEVylzp+vmL5gLlTHMi3AZmeS0zcudig8jwrOU7gq49Oiu1uTq7CgpA=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr6762612ljl.193.1573573231629;
 Tue, 12 Nov 2019 07:40:31 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net> <CAKfTPtB_6kBq69E=-YFuon6fg21CxHneMpncpbLcPGk6uoVcMQ@mail.gmail.com>
 <20191031101544.GP3016@techsingularity.net> <CAKfTPtByO7oLQZxF_+-FxZ9u1JhO24-rujW3j-QDqr+PFDOQ=Q@mail.gmail.com>
 <20191031114020.GQ3016@techsingularity.net> <20191108163501.GA26528@linaro.org>
 <20191108183730.GU3016@techsingularity.net> <20191112105830.GA8765@linaro.org>
 <20191112150636.GX3016@techsingularity.net>
In-Reply-To: <20191112150636.GX3016@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Nov 2019 16:40:20 +0100
Message-ID: <CAKfTPtCVdG1zcd4kyU4d+K_+VdW7TZn+RSDKt4Hk28B366NPOQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 16:06, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Nov 12, 2019 at 11:58:30AM +0100, Vincent Guittot wrote:
> > > This roughly matches what I've seen. The interesting part to me for
> > > netperf is the next section of the report that reports the locality of
> > > numa hints. With netperf on a 2-socket machine, it's generally around
> > > 50% as the client/server are pulled apart. Because netperf is not
> > > heavily memory bound, it doesn't have much impact on the overall
> > > performance but it's good at catching the cross-node migrations.
> >
> > Ok. I didn't want to make my reply too long. I have put them below for
> > the netperf-tcp results:
> >                                         5.3-rc2        5.3-rc2
> >                                             tip      +rwk+fix
> > Ops NUMA alloc hit                  60077762.00    60387907.00
> > Ops NUMA alloc miss                        0.00           0.00
> > Ops NUMA interleave hit                    0.00           0.00
> > Ops NUMA alloc local                60077571.00    60387798.00
> > Ops NUMA base-page range updates        5948.00       17223.00
> > Ops NUMA PTE updates                    5948.00       17223.00
> > Ops NUMA PMD updates                       0.00           0.00
> > Ops NUMA hint faults                    4639.00       14050.00
> > Ops NUMA hint local faults %            2073.00        6515.00
> > Ops NUMA hint local percent               44.69          46.37
> > Ops NUMA pages migrated                 1528.00        4306.00
> > Ops AutoNUMA cost                         23.27          70.45
> >
>
> Thanks -- it was "NUMA hint local percent" I was interested in and the
> 46.37% local hinting faults is likely indicative of the client/server
> being load balanced across SD_NUMA domains without NUMA Balancing being
> aggressive enough to fix it. At least I know I am not just seriously
> unlucky or testing magical machines!

I agree that the collaboration between load balanced across SD_NUMA
level and NUMA balancing should be improved

It's also interesting to notice that the patchset doesn't seem to do
worse than the baseline: 46.37% vs 44.69%

Vincent

>
> --
> Mel Gorman
> SUSE Labs
