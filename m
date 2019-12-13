Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B3C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0164F214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF2Cvyk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMJWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:22:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37071 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:22:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so1427809lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwmaUZJnMZMjAykwzuMYq1+U7baQKDrVjVyjfWLNTpw=;
        b=KF2Cvyk+um/v+kxXqA2S5wHAkj8D6+AhKHlmdTVTCbha2Go4osgSNgw4BUNQFXQoDg
         P0GyScEVl0N4NFlb/b9/x4kz+6JbSUIwpvjNerr8IDahYkRxoRa25OtqjbzKGupwkVny
         qOgGjvMy41bDFgRQVetDMtkYOeO5K+6++Tc6LXxiSsP7b1kJmVqR8kBl3yukcYQYeQBR
         6iFMa7q3heLX6iJilsN8ZEsbqwhPGMxX/c8RAvEXJaVHTa2kMU46it/oaCEOVOwimAuI
         gjrOODSkF3rNwVwsDQ9RlHNbiirhCbTk+iMCBO9gCdFVtSE8OLYkPAMIeFSqmcmk+CE5
         au+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwmaUZJnMZMjAykwzuMYq1+U7baQKDrVjVyjfWLNTpw=;
        b=M58q77m+3y9dg04sAsnjqPqJ0sZHJPOKx91k7MqT2HEMQ7aRo+hnD/HTOZD4RURAgD
         MOfE/qLw4lwVH9glIWKK4B0L2SGrBSRNdZ3nvrr0byoLJuLhcRvaQomXJujbzLIROnnK
         TB/AwsKRdnGq5Ce4e4jtiAKxq8wNVzPPfO1Q7CkX3H+mxvR+qtlyxX7+QpedLhhT17uL
         wozzj7N73GVeZUIm5UCIYGjHYMzNnCCOZE3v7uXM7S4nsjJMlM8tYgWbGlp1MoAcvb8M
         1VACHCQu990X4oY4buiEs/kDGILh2pOO9/FdVVO9pkv/Nm7BYR616yAA98N/bvL3prU7
         06lQ==
X-Gm-Message-State: APjAAAXNCTpJWwnIU43w7g6cnn5Gd0bo4DRfFmRY2vut96TQm2ZQp98h
        /wyjFIWb64Nt9wkg43YKpb4X5eOk0cklCq+iF2oGbFM9
X-Google-Smtp-Source: APXvYqwnTZgiMyv3JP0dy+CwLfGllw+etRelCx/iggNKJJ3sbGD+uMKyUHfVkxjMVSuOOgwd4aJFMbhKQCc+kRtsVkg=
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr8059708lfa.151.1576228925551;
 Fri, 13 Dec 2019 01:22:05 -0800 (PST)
MIME-Version: 1.0
References: <1575648862-12095-1-git-send-email-rocking@linux.alibaba.com> <1576208740-35609-1-git-send-email-rocking@linux.alibaba.com>
In-Reply-To: <1576208740-35609-1-git-send-email-rocking@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Dec 2019 10:21:54 +0100
Message-ID: <CAKfTPtC-iAewnR3QV1BJNWq-hJQphjs_eUwy=PxBrw-NuU3g_w@mail.gmail.com>
Subject: Re: [PATCH v2] schied/fair: Skip calculating @contrib without load
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

minor typo on the subject s/schied/sched/

On Fri, 13 Dec 2019 at 04:46, Peng Wang <rocking@linux.alibaba.com> wrote:
>
> Because of the:
>
>         if (!load)
>                 runnable = running = 0;
>
> clause in ___update_load_sum(), all the actual users of @contrib in
> accumulate_sum():
>
>         if (load)
>                 sa->load_sum += load * contrib;
>         if (runnable)
>                 sa->runnable_load_sum += runnable * contrib;
>         if (running)
>                 sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
>
> don't happen, and therefore we don't care what @contrib actually is and
> calculating it is pointless.
>
> If we count the times when @load equals zero and not as below:
>
>         if (load) {
>                 load_is_not_zero_count++;
>                 contrib = __accumulate_pelt_segments(periods,
>                                 1024 - sa->period_contrib,delta);
>         } else
>                 load_is_zero_count++;
>
> As we can see, load_is_zero_count is much bigger than
> load_is_zero_count, and the gap is gradually widening:
>
>         load_is_zero_count:            6016044 times
>         load_is_not_zero_count:         244316 times
>         19:50:43 up 1 min,  1 user,  load average: 0.09, 0.06, 0.02
>
>         load_is_zero_count:            7956168 times
>         load_is_not_zero_count:         261472 times
>         19:51:42 up 2 min,  1 user,  load average: 0.03, 0.05, 0.01
>
>         load_is_zero_count:           10199896 times
>         load_is_not_zero_count:         278364 times
>         19:52:51 up 3 min,  1 user,  load average: 0.06, 0.05, 0.01
>
>         load_is_zero_count:           14333700 times
>         load_is_not_zero_count:         318424 times
>         19:54:53 up 5 min,  1 user,  load average: 0.01, 0.03, 0.00

your system looks pretty idle so i'm not sure to see a benefit of your
patch in such situation

>
> Perhaps we can gain some performance advantage by saving these
> unnecessary calculation.

load == 0 when
- system is idle and we updates blocked load but we don't really care
about performance in this case and we will stop the trigger the update
once the load_avg reach null value
- a rt/dl/cfs rq or a sched_entity wakes up. In this case, skipping
the calculation of the contribution should fasten the wake up path
although i'm not sure about the amount

Nevertheless, this change makes sense

Reviewed-by: Vincent Guittot < vincent.guittot@linaro.org>

>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> ---
>  kernel/sched/pelt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..4392953 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -129,8 +129,9 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
>                  * Step 2
>                  */
>                 delta %= 1024;
> -               contrib = __accumulate_pelt_segments(periods,
> -                               1024 - sa->period_contrib, delta);
> +               if (load)
> +                       contrib = __accumulate_pelt_segments(periods,
> +                                       1024 - sa->period_contrib, delta);
>         }
>         sa->period_contrib = delta;
>
> --
> 1.8.3.1
>
