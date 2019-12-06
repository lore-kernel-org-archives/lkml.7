Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A60C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E836A24679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt41mzhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLFH5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:57:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40802 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:57:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id y5so4545134lfy.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEu6cAM9pmTpfttF8e2oMkl90xLdoRvHCVPFFTjvbNo=;
        b=kt41mzhhzZcrOKXdVDG0ccgMoWbimeOhH2wggSrbIcSDNKHbn4jYw83Gvalvmc5JKX
         wgY+GKv1z8Y3ibrydIiYHEt/YWwmo17l9aslJWB4BMso65+PQH1CPFHWbAlb65oCLwXF
         LrrAPAPLo34QAbwT7QFPQx0RRKRfjH87www/57ahU2E+M9uJ8xT6f3awrJwRXpRLx63R
         s6ryERgUUIKQWsJk0zm/E46Zf69vLJU8RbfdEz36mvBtM2Hwzd2HVPThl7z3EwYNYZHB
         8f8+1q1IGmuQZlwps6Z/TvjVKhcNQiDIlUHNVkLfu34mYgIuu/pmtFQnm7y1J+ELrL6L
         VyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEu6cAM9pmTpfttF8e2oMkl90xLdoRvHCVPFFTjvbNo=;
        b=Cy8Ox5uuLs6piDnw6UBuSD8pdkbH1YvT4e25Tvyq1YS6CqwdcAukt0pFuxTEvs2ruP
         pdueO8nVjjn3TpfIAwzPhBu0cnA86ezTRg/yOCBdSUYdVQhy77QOrZ4JCB3yleg4LL4w
         OLHy3ei7ccgVCM9a37DNlWUsRuZLZeTUM0UXxXmJh0H8/IcE7YEctRiw2fsb1YQSJEhv
         9hj5uHfkgUbZkNqzr9AN4xrGUxH0fYWx/UnzqYPDhGB84nsOGpZdmppeRq7BBQwCqfPJ
         In/akcyNGNmi8ERzGJfcf/F8ViPkZt1tqsQ1p4dSxwSjPnC+5MN3JLBGOd52SDtWjoOa
         /FPg==
X-Gm-Message-State: APjAAAWvplNBPSKUqWGX+286Zo9h0yrAcO07YYKJNGmwOjCZLA2M5ylH
        iR5nuSIfs4DhhPqn7X+xVwI4hOFiHwRdB9Rl5uLdWQ==
X-Google-Smtp-Source: APXvYqzgrpwRRY7jmgSpXqLkEQarYAJPki0cVzClvDnOhM80LLiZpSNMjfQ9GSfZvN00MLkn1aHXTncqJYe9U6WKyeQ=
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr6729587lfl.125.1575619043523;
 Thu, 05 Dec 2019 23:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20191204200623.198897-1-joshdon@google.com>
In-Reply-To: <20191204200623.198897-1-joshdon@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Dec 2019 08:57:11 +0100
Message-ID: <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Wed, 4 Dec 2019 at 21:06, Josh Don <joshdon@google.com> wrote:
>
> From: Venkatesh Pallipadi <venki@google.com>
>
> Setting skip buddy all the way up the hierarchy does not play well
> with intra-cgroup yield. One typical usecase of yield is when a
> thread in a cgroup wants to yield CPU to another thread within the
> same cgroup. For such a case, setting the skip buddy all the way up
> the hierarchy is counter-productive, as that results in CPU being
> yielded to a task in some other cgroup.
>
> So, limit the skip effect only to the task requesting it.
>
> Signed-off-by: Josh Don <joshdon@google.com>

There is a mismatch between the author Venkatesh Pallipadi and the
signoff Josh Don
If Venkatesh is the original author and you have then done some
modifications, your both signed-off should be there

Apart from that, the change makes sense to me

> ---
> v2: Only clear skip buddy on the current cfs_rq
>
>  kernel/sched/fair.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..0b7a1958ad52 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4051,13 +4051,10 @@ static void __clear_buddies_next(struct sched_entity *se)
>
>  static void __clear_buddies_skip(struct sched_entity *se)
>  {
> -       for_each_sched_entity(se) {
> -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -               if (cfs_rq->skip != se)
> -                       break;
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
> +       if (cfs_rq->skip == se)
>                 cfs_rq->skip = NULL;
> -       }
>  }
>
>  static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
> @@ -6552,8 +6549,15 @@ static void set_next_buddy(struct sched_entity *se)
>
>  static void set_skip_buddy(struct sched_entity *se)
>  {
> -       for_each_sched_entity(se)
> -               cfs_rq_of(se)->skip = se;
> +       /*
> +        * One typical usecase of yield is when a thread in a cgroup
> +        * wants to yield CPU to another thread within the same cgroup.
> +        * For such a case, setting the skip buddy all the way up the
> +        * hierarchy is counter-productive, as that results in CPU being
> +        * yielded to a task in some other cgroup. So, only set skip
> +        * for the task requesting it.
> +        */
> +       cfs_rq_of(se)->skip = se;
>  }
>
>  /*
> --
> 2.24.0.393.g34dc348eaf-goog
>
