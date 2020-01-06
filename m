Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E450C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D1020731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXX9odmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAFNem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:34:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44450 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgAFNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:34:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so36339799lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLggzgyJvV8TKTUDxbBA+R5G99qoCIFvbA/nYC43k14=;
        b=kXX9odmXZ7Bfd26kMx1l7PNs1AjQYHabeFTwq1RoncVrG102dEWFBvgYKjkv/LjTBw
         XBxpYysBUWn5Q/oCxrskYzJ/k32D9Q6CBRgAjWeogx57z6oRpLxygOoHuFutfAsUZ+lz
         dXQUKPgwFvuegsPuZhcaFvYSHP81qmHMpNXv0a+1CcHPeeuSUimWPFpuixcKlxptk3Fz
         TzoA063cWRAnhzAgm32IiB9UGZ0J/ZN15Kq3CXC+/8asLo+ncbp2p7C7AkL94LlNi0b6
         H2hrML0F+d2tZEH6vsCIPydkFQjM7TQj2WxrPn92Oaih4WIAMLoAtGH/sMidHncFeZzJ
         OA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLggzgyJvV8TKTUDxbBA+R5G99qoCIFvbA/nYC43k14=;
        b=Nuak11MPxxNYHpLonzj6ye3f9U6Xj1iY0RQYPpAoPNBCou7zgGrve0ViLvMBvYUn29
         GS50uRdSVBtssPme+BZyR789EBLTjA/JjzrkKyJtfSxmcM4NHw8EpefwDG846k3Vop88
         lzIBkU4GSxuDhleucaMxbE4O9uB5UepMcHfTG3ww/GUdGxZ1le0i3+ozHiMLEGODVEnR
         Q3HInEUBKfkvqbd0alhs7uONgLD19o+3qus4d5EZvl5nTP06lcUHk7+FXA6kCMEGAtPM
         cEbnC6TDF8sgtYlpTrF9OVoKPbooJi4wIrcpePTTq6HBYdqg0xv4SYMyQFhXhfxnTeRc
         IDxQ==
X-Gm-Message-State: APjAAAW8ip56rF+QSAJgWobpK/RMXIE37ofpsEp2nlg+ezVbsaJe4iTg
        WgnHGg2Ch3l1pM6zvdWcGVmCWrO5DWaqMaTYrr83iA==
X-Google-Smtp-Source: APXvYqym5w1SmcY6fKQB+woCSYKZPTS3viF83AOLj8xIdVMv+bOvXsHltXCsqw/PCe/2z8+s10n0EBPv+F8uQPT6DNw=
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr55096916lfa.151.1578317679486;
 Mon, 06 Jan 2020 05:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20200103114400.17668-1-rocking@linux.alibaba.com>
In-Reply-To: <20200103114400.17668-1-rocking@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Jan 2020 14:34:28 +0100
Message-ID: <CAKfTPtAYHqbbVkQdT3A6qgbehZr8Yxa-bFjOXG7oG7eaN=uckA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: calculate delta runnable load only when it's needed
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

On Fri, 3 Jan 2020 at 12:45, Peng Wang <rocking@linux.alibaba.com> wrote:
>
> Move the code of calculation for delta_sum/delta_avg to where

Maybe precise that you move delta_sum/delta_avg for runnable_load_sum/avg

> it is really needed to be done.
>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>

make sense to me

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ba749f579714..6b7e6b528e9b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3366,16 +3366,17 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
>
>         runnable_load_sum = (s64)se_runnable(se) * runnable_sum;
>         runnable_load_avg = div_s64(runnable_load_sum, LOAD_AVG_MAX);
> -       delta_sum = runnable_load_sum - se_weight(se) * se->avg.runnable_load_sum;
> -       delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
> -
> -       se->avg.runnable_load_sum = runnable_sum;
> -       se->avg.runnable_load_avg = runnable_load_avg;
>
>         if (se->on_rq) {
> +               delta_sum = runnable_load_sum -
> +                               se_weight(se) * se->avg.runnable_load_sum;
> +               delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
>                 add_positive(&cfs_rq->avg.runnable_load_avg, delta_avg);
>                 add_positive(&cfs_rq->avg.runnable_load_sum, delta_sum);
>         }
> +
> +       se->avg.runnable_load_sum = runnable_sum;
> +       se->avg.runnable_load_avg = runnable_load_avg;
>  }
>
>  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
> --
> 2.24.0
>
