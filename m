Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE649C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F01B20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYmVkKuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFFCwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:52:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41490 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFFCwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:52:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so530388pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MuJrLKq3f8R6SA2gbKnAdIV2BIlVwoZY7490xsEPP08=;
        b=uYmVkKuhwcbANYnBr6B2uIgMzAVRUGKggE3YuQOteX9cRZ3/MYu2dsdKF3jnwQDUYm
         D+ukL0++ZQEVfZy4gM0IjEYrZrifZmJvcNMbU3tK3dEvzSXxMNpBtyZlO4nEAWkG5nuD
         qoK0F8AdpfAgM+wjubvszGA6KPry2IJ8qZ7+Nv9l96u4aaL9OLcRffpgFdtVxXp4GfFD
         5zuSDNCrtcbsPIYnnfH1gFc5YfoPcxm67FU1rSWJJXJyEhcmiU54BIS8geWtNPC2keZH
         SeDFTERBIkaUif4psQfyAKfKrF+YhA8N8UK/lVc05iCGCpUkUVQ62nSLM3Qrdn9U/8Ig
         6g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MuJrLKq3f8R6SA2gbKnAdIV2BIlVwoZY7490xsEPP08=;
        b=Dk3ReKSdVamOORHq3LSDwXFgTZmk7nRpfCQmJ4MIvK6UZj9HurZGpRnvihZyzOOCJz
         ZwtN5pZcAC0gav1+/yblWFqWXckNWQ/62ys/LmDxqU19IALNQflYiYAsf+ogQ3P83bTo
         3R1JvSF3ZbiKfPrjeJblQOlSjygx6H6Ye7AqzI2ZvMSETOpM0fkjphkNjk+iexOfCkmJ
         P31aT2YPZDua7RTNJU+QqIrt3csXJVXfBh4l96ylKqd+Ci0xjd30ozUq+7ySBr05wbWn
         GrGUT7oHDlAj5i9kIdJXSzoo3mRZQsObcwUEOapGS3f7qFRaOrBh6hsgx8YakPcryxmM
         So1A==
X-Gm-Message-State: APjAAAUy0oraCX2VZX9Cs70AlYm+z26zPiMmQDsMMMPu9J+59IOAzZGQ
        Hz/A1Ov9lWjVjf0lp8pTiDcL/Cf+ElM=
X-Google-Smtp-Source: APXvYqxma+G6RG+3HIzgQjjFHpzIJCpFBl5+/wmtP6ArQg9sdUJ1dTJk5T80TXEuQCCd+DYc8J3DYA==
X-Received: by 2002:a17:90a:ba81:: with SMTP id t1mr42998175pjr.139.1559789528005;
        Wed, 05 Jun 2019 19:52:08 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id j37sm245914pgj.58.2019.06.05.19.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:52:07 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:22:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605091644.w3g7hc7r3eiscz4f@queper01-lin>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-19, 10:16, Quentin Perret wrote:
> Hi Viresh,
> 
> On Tuesday 04 Jun 2019 at 12:31:52 (+0530), Viresh Kumar wrote:
> > The same formula to check utilization against capacity (after
> > considering capacity_margin) is already used at 5 different locations.
> > 
> > This patch creates a new macro, fits_capacity(), which can be used from
> > all these locations without exposing the details of it and hence
> > simplify code.
> > 
> > All the 5 code locations are updated as well to use it..
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  kernel/sched/fair.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7f8d477f90fe..db3a218b7928 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -102,6 +102,8 @@ int __weak arch_asym_cpu_priority(int cpu)
> >   * (default: ~20%)
> >   */
> >  static unsigned int capacity_margin			= 1280;
> > +
> > +#define fits_capacity(cap, max)	((cap) * capacity_margin < (max) * 1024)
> >  #endif
> >  
> >  #ifdef CONFIG_CFS_BANDWIDTH
> > @@ -3727,7 +3729,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> >  
> >  static inline int task_fits_capacity(struct task_struct *p, long capacity)
> >  {
> > -	return capacity * 1024 > task_util_est(p) * capacity_margin;
> > +	return fits_capacity(task_util_est(p), capacity);
> >  }
> >  
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > @@ -5143,7 +5145,7 @@ static inline unsigned long cpu_util(int cpu);
> >  
> >  static inline bool cpu_overutilized(int cpu)
> >  {
> > -	return (capacity_of(cpu) * 1024) < (cpu_util(cpu) * capacity_margin);
> > +	return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
> 
> This ...
> 
> >  }
> >  
> >  static inline void update_overutilized_status(struct rq *rq)
> > @@ -6304,7 +6306,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  			/* Skip CPUs that will be overutilized. */
> >  			util = cpu_util_next(cpu, p, cpu);
> >  			cpu_cap = capacity_of(cpu);
> > -			if (cpu_cap * 1024 < util * capacity_margin)
> > +			if (!fits_capacity(util, cpu_cap))
> 
> ... and this isn't _strictly_ equivalent to the existing code but I
> guess we can live with the difference :-)

Yes, I missed the == part it seems. Good catch. Though as you said,
maybe we don't need to take that into account and can live with the
new macro :)

> 
> >  				continue;
> >  
> >  			/* Always use prev_cpu as a candidate. */
> > @@ -7853,8 +7855,7 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
> >  static inline bool
> >  group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> >  {
> > -	return sg->sgc->min_capacity * capacity_margin <
> > -						ref->sgc->min_capacity * 1024;
> > +	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
> >  }
> >  
> >  /*
> > @@ -7864,8 +7865,7 @@ group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> >  static inline bool
> >  group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> >  {
> > -	return sg->sgc->max_capacity * capacity_margin <
> > -						ref->sgc->max_capacity * 1024;
> > +	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
> >  }
> >  
> >  static inline enum
> > -- 
> > 2.21.0.rc0.269.g1a574e7a288b
> > 
> 
> Also, since we're talking about making the capacity_margin code more
> consistent, one small thing I had in mind: we have a capacity margin
> in sugov too, which happens to be 1.25 has well (see map_util_freq()).
> Conceptually, capacity_margin in fair.c and the sugov margin are both
> about answering: "do I have enough CPU capacity to serve X of util, or
> do I need more ?"
> 
> So perhaps we should factorize the capacity_margin code some more to use
> it in both places in a consistent way ? This could be done in a separate
> patch, though.

Hmm, even if the values are same currently I am not sure if we want
the same for ever. I will write a patch for it though, if Peter/Rafael
feel the same as you.

Thanks Quentin.

-- 
viresh
