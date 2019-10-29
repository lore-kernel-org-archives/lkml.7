Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC20CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A2D21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pE6dlCmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbfJ2LuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:50:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55382 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfJ2LuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:50:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so2219684wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kd8KdBaTWWYCGSiSX2Hi1YoJKfTLqZTdgxbJDT6peN8=;
        b=pE6dlCmkPr6YeNj8F0dlfkhzBt/HHIIhk3RN50cwbOPLGkWPqHt/1iODkRlGyHLyFq
         dK9Q6Ar+3plcJj7JvIq7dvsb3DSLrw5T2HkFAHQhsmFUPm5o57kp69d4EyMGyH2Le2Xw
         Jdx/CK56+iBVpo0aCK38aMZXSv2kgZHjfqw7eHcroAqkJ9G8mkC6fDHNFlRSEsgEELzZ
         Bez8pVOdYrspy/rtQ+OtUP2wXowd5LMZluXxH6OcHVE4Wa4NqM7Px4E1GZvfuRZ256bu
         sdVTZ1C+hweBiMR/1t5X9TgWfC4UoiM6sf/5L8krxnzl6VsosKkGLXZ2rZn+Mvn5HNAb
         aCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kd8KdBaTWWYCGSiSX2Hi1YoJKfTLqZTdgxbJDT6peN8=;
        b=lTDqeyRwJ6Y2MHBGPXbtkxLVWTUtqaszTklKwEyh3bYM9DlzE4RnPRo10q0wdNxqZv
         Wn+Ajjsyo1MWPS2r9Yj+o/2RhS4MQA3GS/C+bSbl6X4D4WVShYB6nfZ+XfkwojhBYfr1
         SsSKkRpnEdsoZv+4u8dyKxnrVRPQEU0LsdX9ZP1GoZg+hsomNosTCzocAokol1/0C+zh
         P9EQYCqk96m9sIYlg3uru8/0vwkd29yJup8PqKT3Scq829Bxkt7RxO4ij1DrwJLyTcZi
         soK4HGML2YX+X/Sw6DLyBmXa/dyVtEoF3qCr/71Yj96RdCsau+AuHfqZji5cIvg6IKI9
         tUVQ==
X-Gm-Message-State: APjAAAX8IWuGkFNFDPxjYzZDjZFPG4CRTtWr1MRPuqsVUISDIsTupcTJ
        pvesncUrgjMK3N32hqJMnjywdQ==
X-Google-Smtp-Source: APXvYqwIteS+juQJ8rYOHhGQ1aepL/UWGhYPMUVt3OSt1PPedjqfm4WJtCsinIek6PWiKVm5qXubVQ==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr3818938wml.60.1572349805183;
        Tue, 29 Oct 2019 04:50:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id d16sm3260781wmb.27.2019.10.29.04.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:50:04 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:50:00 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191029115000.GA11194@google.com>
References: <20191028174603.GA246917@google.com>
 <20191029113411.GP4643@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029113411.GP4643@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 Oct 2019 at 12:34:11 (+0100), Peter Zijlstra wrote:
> On Mon, Oct 28, 2019 at 05:46:03PM +0000, Quentin Perret wrote:
> > The issue is very transient and relatively hard to reproduce.
> > 
> > After digging a bit, the offending commit seems to be:
> > 
> >     67692435c411 ("sched: Rework pick_next_task() slow-path")
> > 
> > By 'offending' I mean that reverting it makes the issue go away. The
> > issue comes from the fact that pick_next_entity() returns a NULL se in
> > the 'simple' path of pick_next_task_fair(), which causes obvious
> > problems in the subsequent call to set_next_entity().
> > 
> > I'll dig more, but if anybody understands the issue in the meatime feel
> > free to send me a patch to try out :)
> 
> Can you please see if this makes any difference?
> 
> ---
>  kernel/sched/core.c | 6 ++++--
>  kernel/sched/fair.c | 2 +-
>  kernel/sched/idle.c | 3 +--
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f64d0e..abd2d4f80381 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3922,8 +3922,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  			goto restart;
> 
>  		/* Assumes fair_sched_class->next == idle_sched_class */
> -		if (unlikely(!p))
> -			p = idle_sched_class.pick_next_task(rq, prev, rf);
> +		if (unlikely(!p)) {
> +			prev->sched_class->put_prev_task(rq, prev, rf);
> +			p = idle_sched_class.pick_next_task(rq, NULL, NULL);
> +		}
> 
>  		return p;
>  	}
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 83ab35e2374f..2aad94bb7165 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6820,7 +6820,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  simple:
>  #endif
>  	if (prev)
> -		put_prev_task(rq, prev);
> +		prev->sched_class->put_prev_task(rq, prev, rf);
> 
>  	do {
>  		se = pick_next_entity(cfs_rq, NULL);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8dad5aa600ea..e8dfc84f375a 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -390,8 +390,7 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  {
>  	struct task_struct *next = rq->idle;
> 
> -	if (prev)
> -		put_prev_task(rq, prev);
> +	WARN_ON_ONCE(prev || rf);
> 
>  	set_next_task_idle(rq, next);
> 
> 

Unfortunately the issue went into hiding this morning and I struggle to
reproduce it (this is turning bordeline nightmare now TBH).

I'll try the patch once my reproducer is fixed :/

Thank you very much for the help,
Quentin
