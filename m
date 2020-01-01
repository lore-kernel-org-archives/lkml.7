Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF9C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA992072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGeQ0wxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgAAONg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 09:13:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41350 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 09:13:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id bd4so16812541plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+l61iY8UCZT+9rPDa5ppeVv5ndFumdyzfuuo1mO7NGk=;
        b=CGeQ0wxVpVKIxvUdWEssAOWfmv3iCRloGmETOtyCH2HfP8LW9PzeGEE7Evg9hWEGYP
         5Qv8nlmjJOvvCexrWKuRyGJ1jEWKumPvNVLmu1/z+cS7UzokWuvboH2K13Qpt7UBD5tL
         zlM5uRoNrgGB4zRh7TsxnJZSz/akJfS71BoqCg+Mcje6+IMavlFnwLSURHreOyojRrDW
         sON5UBiySZgx48JaLGvfgfS/G2EQZu+sBIL0lreYTm5v7maN1YOM39JvKTGR6hKuaIJ3
         SQVKUCEHt4FX6BaSrqUWFLIOMJ/GFdqnEWlpv3asY14WB7VoB55tJwmSy3YAGQzsHf74
         Vjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+l61iY8UCZT+9rPDa5ppeVv5ndFumdyzfuuo1mO7NGk=;
        b=CpcYn60jgwHobA1cF1ep5rIIa99W9bN1zHieh7VmRXM68M0Ygeko8KKosR+MRcG3c1
         OuFDaxfJnCf1077ZowBUN0N4taofNRYck5NYFvGSwz7cLObiyMuEuR5/oOT1pnuesdlo
         A9DdIk844nlMYgmcERseoVIMTip+CW8aH7JhSDKfFV3MvNDra8MBbfjzjjqFaxn0hqe7
         3H8VGYyHHjkjFog39Xi0d1Or6BWfkOL1SgYRTXb6A2s0ovY+8wCSFqQOwE/e5LpXEyN5
         TZCKVte4lnbmw2vdquLS4BKID7FTDfE3jvjRwveGb6OSalnRXfQL7CRvmONt8yor/lba
         AWKQ==
X-Gm-Message-State: APjAAAUNfpAU0IYy8TpO39Ll8Zr6PWAJ5xs7DiEtfdZE8488OLiXHnSS
        3DZixRO4um7CCvM0acbRKkA=
X-Google-Smtp-Source: APXvYqy0QEIQIXne0u4xagyO7B91Jtl+x/+gkgoX6DJp/ql6VWmMPFIyhtKfcw+wvYLnoydT0zc0Wg==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr12981854pld.58.1577888014522;
        Wed, 01 Jan 2020 06:13:34 -0800 (PST)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id u23sm59905114pfm.29.2020.01.01.06.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 06:13:33 -0800 (PST)
Date:   Wed, 1 Jan 2020 22:13:29 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20200101141329.GA12809@iZj6chx1xj0e0buvshuecpZ>
References: <20191231035122.GA10020@iZj6chx1xj0e0buvshuecpZ>
 <ec390ddb-c015-a467-2f88-47c00f23e27b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec390ddb-c015-a467-2f88-47c00f23e27b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 05:56:49AM +0000, Valentin Schneider wrote:
> Hi Peng,
> 
> On 31/12/2019 03:51, Peng Liu wrote:
> > commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
> > sched_group_capacity") introduced per-cpu min_capacity.
> > 
> > commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
> > introduced per-cpu max_capacity.
> > 
> > sgc->capacity is the *SUM* of all CPU's capacity in the group.
> > sgc->{min,max}_capacity are the sg per-cpu variables. Compare with
> > sgc->capacity to get sgc->{min,max}_capacity makes no sense. Instead,
> > we should compare one by one in each iteration to get
> > sgc->{min,max}_capacity of the group.
> > 
> 
> Worth noting this only affects the SD_OVERLAP case, the other case is fine
> (I checked again just to be sure).
> 
> Now, on the bright side of things I don't think this currently causes any
> harm. The {min,max}_capacity values are used in bits of code that only
> gets run on topologies with asymmetric CPU µarchs (SD_ASYM_CPUCAPACITY), and
> I know of no such system that is also NUMA, i.e. end up with SD_OVERLAP
> (here's hoping nobody gets any funny idea).
> 
> Still, nice find!

Valentin, thanks for your time!

> 
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> > ---
> >  kernel/sched/fair.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2d170b5da0e3..97b164fcda93 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7795,6 +7795,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
> >  		for_each_cpu(cpu, sched_group_span(sdg)) {
> >  			struct sched_group_capacity *sgc;
> >  			struct rq *rq = cpu_rq(cpu);
> > +			unsigned long cap;
> >  
> >  			/*
> >  			 * build_sched_domains() -> init_sched_groups_capacity()
> > @@ -7808,14 +7809,16 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
> >  			 * causing divide-by-zero issues on boot.
> >  			 */
> >  			if (unlikely(!rq->sd)) {
> > -				capacity += capacity_of(cpu);
> > +				cap = capacity_of(cpu);
> > +				capacity += cap;
> > +				min_capacity = min(cap, min_capacity);
> > +				max_capacity = max(cap, max_capacity);
> >  			} else {
> >  				sgc = rq->sd->groups->sgc;
> >  				capacity += sgc->capacity;
> > +				min_capacity = min(sgc->min_capacity, min_capacity);
> > +				max_capacity = max(sgc->max_capacity, max_capacity);
> >  			}
> > -
> > -			min_capacity = min(capacity, min_capacity);
> > -			max_capacity = max(capacity, max_capacity);
> >  		}
> >  	} else  {
> >  		/*
> > 
> 
> All that could be shortened like the below, no? 
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..9f6c015639ef 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7773,8 +7773,8 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>  		 */
>  
>  		for_each_cpu(cpu, sched_group_span(sdg)) {
> -			struct sched_group_capacity *sgc;
>  			struct rq *rq = cpu_rq(cpu);
> +			unsigned long cpu_cap;
>  
>  			/*
>  			 * build_sched_domains() -> init_sched_groups_capacity()
> @@ -7787,15 +7787,15 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>  			 * This avoids capacity from being 0 and
>  			 * causing divide-by-zero issues on boot.
>  			 */
> -			if (unlikely(!rq->sd)) {
> -				capacity += capacity_of(cpu);
> -			} else {
> -				sgc = rq->sd->groups->sgc;
> -				capacity += sgc->capacity;
> -			}
> +			if (unlikely(!rq->sd))
> +				cpu_cap = capacity_of(cpu);

--------------------------------------------------------------
> +			else
> +				cpu_cap = rq->sd->groups->sgc->capacity;

sgc->capacity is the *sum* of all CPU's capacity in that group, right?
{min,max}_capacity are per CPU variables(*part* of a group). So we can't
compare *part* to *sum*. Am I overlooking something? Thanks.

> +
> +			min_capacity = min(cpu_cap, min_capacity);
> +			max_capacity = max(cpu_cap, max_capacity);
>  
> -			min_capacity = min(capacity, min_capacity);
> -			max_capacity = max(capacity, max_capacity);
> +			capacity += cpu_cap;
>  		}
>  	} else  {
>  		/*
