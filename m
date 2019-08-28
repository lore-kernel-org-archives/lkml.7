Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E277CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06F422CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlHTlc2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfH1Q7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:59:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45579 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfH1Q7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:59:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id o11so115785lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ilh4otdfy0oqlyhJP4W72lKqPtDWr39PVGL0vMR6T6E=;
        b=WlHTlc2/pNS0JfBxa1yWKIRYaEGjqD4Nx3FVK+IezaFH1/2gzI2/WAqYzpyXTi+zW8
         87UIvi8EX6Dkj0eFnvviKXjjBWlqogk94Mjgz8k/Cx1SD20741uFP2LB/cS40k6OySes
         Iuf0Rj09JI6indjsjdtTAB9vOc/OL3nYS2GriY4fqp8k6BRCic3ygbhh6+aU0CnZLJ3c
         JSXEFPhMwGDyvA4VP2QFxaqTsiX0cfHRrLxGwyQNom1QNUk3MXT5P1vRD2BYpUsLgTbq
         NE+wQJ0M4nChdGYFtuihGTwm753vdYZmiTDzin56jeiD/mLKJVuItwAB9kXj5PnqJBfs
         Mo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ilh4otdfy0oqlyhJP4W72lKqPtDWr39PVGL0vMR6T6E=;
        b=hrEdLrocDkzDPkB6R5fhoBkXyZuPFu4R549PenB4vTm4+JVi36An/dJXpIValXOR+u
         QJRl/2LLwjUih1P4dV0FsK4HvJqW8SNjrYQ2CVMtVWZy5ZwwnPLA3OHkQfJ9X5NR2E5c
         LHV2O5XKVWlpuf2bvg3C7AouS15vICsLb0x/gLheFlkokToj1gZRtaqHhf/W8VUquao0
         IswAfYQQD9dPkO0+CfKxVGkF6JkDhUle1P4NE6ewj7p5RnR39jBjt51B0KlSX9kkf0ki
         Bk6m/0PU0TIO6Fo+/vP0BBlPEhSqapmN0qvFTTaeRTSfigpUKQaBlZpW9bWe7af66afq
         w21w==
X-Gm-Message-State: APjAAAUvosj+zDnxXUadjyd9OEAJI+hunI5B8xA60GDUtUOeKPr0W0aD
        0hkGN2SkuCkVbMuUJgBAxO1waFwD44m7NbsAyAq+Hg==
X-Google-Smtp-Source: APXvYqyzn8Ff8xi3BT0qHgaaBaerDiIq6p+mjLHCF2Ye55ZZmWBov2We06/i8jxpKKjlac8v69mq7ZxnEvDIvqYagU4=
X-Received: by 2002:a19:6a12:: with SMTP id u18mr3149337lfu.133.1567011571064;
 Wed, 28 Aug 2019 09:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-8-riel@surriel.com>
In-Reply-To: <20190822021740.15554-8-riel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Aug 2019 18:59:20 +0200
Message-ID: <CAKfTPtDCa8KsZW1cf+xYVkx-ty2vJ2SdAOKqgh+YJBbq8sJeXA@mail.gmail.com>
Subject: Re: [PATCH 07/15] sched,cfs: fix zero length timeslice calculation
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
>
> The way the time slice length is currently calculated, not only do high
> priority tasks get longer time slices than low priority tasks, but due
> to fixed point math, low priority tasks could end up with a zero length
> time slice. This can lead to cache thrashing and other inefficiencies.

Have you got more details of those UCs ?

>
> Cap the minimum time slice length to sysctl_sched_min_granularity.
>
> Tasks that end up getting a time slice length too long for their relative
> priority will simply end up having their vruntime advanced much faster than
> other tasks, resulting in them receiving time slices less frequently.

In fact that already happen as we wait for the tick to preempt a task
(unless you enable sched_feat(HRTICK))
so it sounds reasonable

>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 31a26737a873..8f8c85c6da9b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -732,6 +732,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 }
>                 slice = __calc_delta(slice, se->load.weight, load);
>         }
> +
> +       /*
> +        * To avoid cache thrashing, run at least sysctl_sched_min_granularity.
> +        * The vruntime of a low priority task advances faster; those tasks
> +        * will simply get time slices less frequently.
> +        */
> +       slice = max_t(u64, slice, sysctl_sched_min_granularity);
>         return slice;
>  }
>
> --
> 2.20.1
>
