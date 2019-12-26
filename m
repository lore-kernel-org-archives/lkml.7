Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EBC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D8A206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsXFwUWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfLZPGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 10:06:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46510 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfLZPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 10:05:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so18665116lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 07:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lXldyy2rUjU3vsUoz2r9OdaSkB56U7u5IkcDGjgTII=;
        b=dsXFwUWj2zd+802wi1aSzCpV+f0+CNWG3n8KF710hGCXgXnuQzdIRllOjjfrq98ydU
         FIuEWvx0UCvqdPTywBHykRigcGPKwTdwx08JAELHGHF+62eVe/vrJzDt8B3NoI/9sa9K
         EszCslrtgVARJAconxW6W9+h3ucRfpwbgLb9sq4Uy4Nu+mpOVHbIcdEoaOzOgmYVeAeJ
         FKvN/aWdJkNN/orXe4rDae/OGLtgGYdpUNB79y+Rip2wmSguSUonHUb8nHvDd0DjOIrr
         Ujfu4NOHQaZmBTGNB+m88ZTxgk4fE6MKHsCGNYCgNWFgNl8uRX4Q+JWzdVp1CQ8bvHVi
         xXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lXldyy2rUjU3vsUoz2r9OdaSkB56U7u5IkcDGjgTII=;
        b=IPyIyKmrZDFtn2ra93zteEOz0lil4xE4R1GVFrDQ1HzBkaYdreHg5mT9kM/C4k1N+e
         Ghii3zHwEBQ8Qu0kRkLnPWHW54buzIXAWR9VPphbty/w2GxzepLO2+h8PkbrtM/NgkKV
         K3NojczyAZivSjSiIePVqHaoyvyoinFkYi1LFpatDnxnG8VNBp6HDrCOVoLJiNjDrJQp
         GQP3olXV8+khqxPJhgZIvWmKE5g0ANvTN1XbWEKpksHgOhoXOuJ4iQcWoBhmfK5jrBvZ
         SHNuKm/hNnF6PXRmlJZqQzxgWCPB6Sv4MN5Oykpe+Q6zBbeqltv9gZ7s7FtXhB6Q7Mw2
         SyUA==
X-Gm-Message-State: APjAAAWWDBj8ucmg8g64KMS1VPglI5E/mxDL01b6shHib7KVRd9fbt3L
        xc3lOZiKrB0qQeRszB0xvWzKoIZ1K8sFiPSv/saHUzXv
X-Google-Smtp-Source: APXvYqxm/Lf/CBnbewwlll8lbRh6lPvHRg0d58EDcboqZqDNm7GwrDDKvCK8Y0O20b0ldUpMZiaO50vWbTjTDFiA4F8=
X-Received: by 2002:ac2:44d9:: with SMTP id d25mr27409552lfm.15.1577372757749;
 Thu, 26 Dec 2019 07:05:57 -0800 (PST)
MIME-Version: 1.0
References: <CABk29NvMS87uGnFRWoN3Ce0t+UQ--qnjRmQCPJCCEcSASs25uQ@mail.gmail.com>
 <20191219001418.234372-1-joshdon@google.com>
In-Reply-To: <20191219001418.234372-1-joshdon@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Dec 2019 16:05:46 +0100
Message-ID: <CAKfTPtDBuzVUZmqZo2MZNDrrnX=iMEN=pq6pid0NJ7PRzGjKjw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: Do not set skip buddy up the sched hierarchy
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

On Thu, 19 Dec 2019 at 01:14, Josh Don <joshdon@google.com> wrote:
>
> From: Venkatesh Pallipadi <venki@google.com>
>
> Setting the skip buddy up the hierarchy effectively means that a thread
> calling yield will also end up skipping the other tasks in its hierarchy
> as well. However, a yielding thread shouldn't end up causing this
> behavior on behalf of its entire hierarchy.
>
> For typical uses of yield, setting the skip buddy up the hierarchy is
> counter-productive, as that results in CPU being yielded to a task in
> some other cgroup.
>
> So, limit the skip effect only to the task requesting it.
>
> Co-developed-by: Josh Don <joshdon@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v2: Only clear skip buddy on the current cfs_rq
>
> v3: Modify comment describing the justification for this change.
>
>  kernel/sched/fair.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..0056b57d52cb 100644
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
> @@ -6552,8 +6549,12 @@ static void set_next_buddy(struct sched_entity *se)
>
>  static void set_skip_buddy(struct sched_entity *se)
>  {
> -       for_each_sched_entity(se)
> -               cfs_rq_of(se)->skip = se;
> +       /*
> +        * Only set the skip buddy for the task requesting it. Setting the skip
> +        * buddy up the hierarchy would result in skipping all other tasks in
> +        * the hierarchy as well.
> +        */
> +       cfs_rq_of(se)->skip = se;
>  }
>
>  /*
> --
> 2.24.1.735.g03f4e72817-goog
>
