Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B76C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88821206DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoOf8IY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgACOV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 09:21:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33474 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgACOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:21:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so19125346pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 06:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=83VimcFINonpltcm7FrV9vKE3xBADj5tPikwygFhOYs=;
        b=qoOf8IY9Iz4jDQ5nfk6vwHShRr8e7/f4DyPkBWMKOlwaAWj1ImlGohIEc86J2UzJ3s
         4Il70upFjU4cESuMyi97T2v/1j2flTI5HFh5YC6gNGVIcintlTZzRZw6wshugQli7aQf
         j1rru5eRDXu8FOHwDRpgdobVH3MbkVmC8JTMNZQLZK1rPET24UY7+rzdYZtXRKSJbisK
         qXa+F/V/X6MpOWkDOaWXtoKucxSwGuhmqdOt7g0O0oR5URsDKzslNy8lwb2eeJiedow1
         lzNuVBOdXphU41op0t8KOGfIziSZeFR645CzZ9daPSPOW5pqGjCkHOjvHUiAGxWwV0Ku
         aEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=83VimcFINonpltcm7FrV9vKE3xBADj5tPikwygFhOYs=;
        b=U0QXpKUwR5r4AWPuB3c50y9B+rdmqWNSx9NpEDiwb5mcw8vbAsESMXlWxEu4RacdAl
         gNFyC67wrIWyhb8x3RgEtLOMAVoeSe1kTdZxEVCk+p6yzDo+Srb39RSPQMnEb4JVXv09
         4d2Q1Z4pQO2T/e1f6cF+jUOdasaERsh/jakulZBDsaz3ThRqbV123cnbtnygh24XPLXR
         pLJQo0dd6+lxuq4BcC81ls9PjRGo/wsJpmRaDAONfOwgJNeQazXidW32t1i9m/acrfKj
         WcvYNJxYtEfForJlUxZ24ujPvFE0QKgYbSOG2v540wg3Nbt0/z3meGyUZYdSbuCRma+2
         +rtQ==
X-Gm-Message-State: APjAAAVQ/qWguJyXIDPkayKTObfEIi+3CDBU0nbxGMBninF8683Qo1og
        OxwB63W+Ix+S9VlVEZ9FS5o=
X-Google-Smtp-Source: APXvYqxUmpvctwsATNE2QczhxSqjJhljmsEuYLrUd+Cs9JoMxgpsX3IMwYwhs1u8TBXZCkhwKL5TiQ==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr68212774ply.125.1578061317162;
        Fri, 03 Jan 2020 06:21:57 -0800 (PST)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id q9sm64871263pgc.5.2020.01.03.06.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 06:21:56 -0800 (PST)
Date:   Fri, 3 Jan 2020 22:21:52 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20200103142152.GA4551@iZj6chx1xj0e0buvshuecpZ>
References: <20191231035122.GA10020@iZj6chx1xj0e0buvshuecpZ>
 <ec390ddb-c015-a467-2f88-47c00f23e27b@arm.com>
 <20200101141329.GA12809@iZj6chx1xj0e0buvshuecpZ>
 <e41793bc-daaf-b224-1f3d-a3e468072592@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41793bc-daaf-b224-1f3d-a3e468072592@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 06:55:48PM +0000, Valentin Schneider wrote:
> On 01/01/2020 14:13, Peng Liu wrote:
> >> ---
> > --------------------------------------------------------------
> >> +			else
> >> +				cpu_cap = rq->sd->groups->sgc->capacity;
> > 
> > sgc->capacity is the *sum* of all CPU's capacity in that group, right?
> 
> Right
> 
> > {min,max}_capacity are per CPU variables(*part* of a group). So we can't
> > compare *part* to *sum*. Am I overlooking something? Thanks.
> > 
> 
> AIUI rq->sd->groups->sgc->capacity should be the capacity of the rq's CPU
> (IOW the groups here should be made of single CPUs).
> 
> This should be true regardless of overlapping domains, since they sit on top
> of the regular domains. Let me paint an example with a simple 2-core SMT2
> system:
> 
>   MC  [          ]
>   SMT [    ][    ]
>        0  1  2  3
> 
> cpu_rq(0)->sd will point to the sched_domain of CPU0 at SMT level (it is the
> "base domain", IOW the lowest domain in the topology hierarchy). Its groups
> will be:
> 
>   {0} ----> {1}
>     ^       /
>      `-----'
> 
> and sd->groups will point at the group spanning the "local" CPU, in our case
> CPU0, and thus here will be a group containing only CPU0.
> 
> 
> I do not know why sched_group_capacity is used here however. As I understand
> things, we could use cpu_capacity() unconditionally.

Valentin, sorry for my tardy reply, but there are always so many things
to do.

Thanks for your patient explanation, and the picture is intuitive
and clear. Indeed, the group in lowest domain only contains one CPU, and
the only CPU in the first group should be the rq's CPU. So, I wonder if
we can do like this?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d170b5da0e3..c9d7613c74d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7793,9 +7793,6 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
                 */

                for_each_cpu(cpu, sched_group_span(sdg)) {
-                       struct sched_group_capacity *sgc;
-                       struct rq *rq = cpu_rq(cpu);
-
                        /*
                         * build_sched_domains() -> init_sched_groups_capacity()
                         * gets here before we've attached the domains to the
@@ -7807,15 +7804,11 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
                         * This avoids capacity from being 0 and
                         * causing divide-by-zero issues on boot.
                         */
-                       if (unlikely(!rq->sd)) {
-                               capacity += capacity_of(cpu);
-                       } else {
-                               sgc = rq->sd->groups->sgc;
-                               capacity += sgc->capacity;
-                       }
+                       unsigned long cpu_cap = capacity_of(cpu);

-                       min_capacity = min(capacity, min_capacity);
-                       max_capacity = max(capacity, max_capacity);
+                       min_capacity = min(cpu_cap, min_capacity);
+                       max_capacity = max(cpu_cap, max_capacity);
+                       capacity += cpu_cap;
                }
        } else  {
                /*
