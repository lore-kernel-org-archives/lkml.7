Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F90B20656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liHxwsRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732989AbfKHMPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:15:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51681 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfKHMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:15:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so5974160wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GrUAfRhVm/tXtqAx74Z8unYM4+UiTro6HswF676OxZ4=;
        b=liHxwsRGIjQQ9UHQLNS0ZJK7brBDoritz75shYiZr21UY02qXUi+IpZk4nQKV7Zwpn
         CLpIYfjn8Ro41QrtRBeVNV+K5l+MRHQDIbwBGfsZLez8+GS6k/crcHCiltp+nRt2Osn8
         zXYQtty/UFksXmSJ7f8R4H+aIJMh18Nc45Ph1DVVHwNcc0nrCvXs1ZiABaH7cHo30T/w
         m9STCPp6qTCA5ZDk/7oFKs71cmQ3XsbuiLzvo1u1d5hzT1/NQr+2tSYAqfTDsketf1Oy
         JYlXvPLzLu1SJ931FNpnH87HepIpwn6GLcso7/dsmzbMuU9RpiFvf7LZjaVypjizAsQn
         n+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GrUAfRhVm/tXtqAx74Z8unYM4+UiTro6HswF676OxZ4=;
        b=QboGfs5out9k4ZJby5hzABwFsO7+H50gPD7KkIypPMDV/WC5zFbLIWyAVYx+GJuHFk
         sV8DHcbAlrRr4trNFUcgqTTyjBOgzoCDAlOTDDxUP2KpM4H1K/b3ExwX5M7auOzRGtL+
         Up1sXjW+1nFb5FhcjYt7UyLWj157HBQnQ0oz1BlUVfrFXXSpX7Z+42ZukJrZgF5eugjO
         Q9GtgO2dgiRGJ4tFOtotUH5AUOauG+HK+HmVFaDA7z/zTBehvbVzgxbrAueB0tJJQJ3D
         9fwl2QHWu4OxR6/pBMHqq70gxVNuWi9GBbQ2UUmpWf+ZRsV5WWTR5P7P/4epw1JIrVpq
         Cv9g==
X-Gm-Message-State: APjAAAWEhtfpELsYw5YlWzQHUvgBgk+21bbbxVsxGRIlic373UEGvoq9
        Zbf0fr7Fn2gD1sSyELoPVObz2hHrJZE=
X-Google-Smtp-Source: APXvYqwp8orRb9009iUMhxyq0zL5nN+tUv3HQmuiYD9WBzx9WzK5GeO4erE01SH/JyGgUhkUTxBe3A==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr8165330wmd.176.1573215330623;
        Fri, 08 Nov 2019 04:15:30 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id b17sm6302216wru.36.2019.11.08.04.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 04:15:29 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:15:26 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108121526.GB83597@google.com>
References: <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
 <20191108110212.GA204618@google.com>
 <20191108120034.GK4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108120034.GK4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Nov 2019 at 13:00:35 (+0100), Peter Zijlstra wrote:
> On Fri, Nov 08, 2019 at 11:02:12AM +0000, Quentin Perret wrote:
> > On Thursday 07 Nov 2019 at 20:29:07 (+0100), Peter Zijlstra wrote:
> > > I still havne't had food, but this here compiles...
> > 
> > And it seems to work, too :)
> 
> Excellent!
> 
> > > @@ -3929,13 +3929,17 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >  	}
> > > 
> > >  restart:
> > > -	/*
> > > -	 * Ensure that we put DL/RT tasks before the pick loop, such that they
> > > -	 * can PULL higher prio tasks when we lower the RQ 'priority'.
> > > -	 */
> > > -	prev->sched_class->put_prev_task(rq, prev, rf);
> > > -	if (!rq->nr_running)
> > > -		newidle_balance(rq, rf);
> > > +#ifdef CONFIG_SMP
> > > +	for (class = prev->sched_class;
> > > +	     class != &idle_sched_class;
> > > +	     class = class->next) {
> > > +
> > > +		if (class->balance(rq, prev, rf))
> > > +			break;
> > > +	}
> > > +#endif
> > > +
> > > +	put_prev_task(rq, prev);
> > 
> > Right, that looks much cleaner IMO. I'm thinking if we killed the
> > special case for CFS above we could do with a single loop to iterate the
> > classes, and you could fold ->balance() in ->pick_next_task() ...
> 
> No, you can't, because then you're back to having to restart the pick
> when something happens when we drop the rq halfway down the pick.  Which
> is something I really wanted to get rid of.

Right, with a single loop you'll have to re-iterate the classes from
the start in case of RETRY_TASK, but you're re-iterating all the classes
too with this patch. You're doing a little less work in the second loop
though, so maybe it's worth it. And I was the one worried about
refactoring the code too much close to the release, so maybe that's for
another time ;)

Thanks,
Quentin
