Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33969C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02AB2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAXy/i1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfDBNVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:21:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40921 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfDBNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:21:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so11948136otp.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pT1tSOA1Izh0qdqOIeOKkczIFYFbYblirMLL0FSKvVE=;
        b=QAXy/i1YEtShdsaCx7vsv8jDJPeucGa2kYjy4TxmC1XzmHwn2VFyZZokEMcPZJKFsA
         oOY56MtJQ7KHnJ7Q4u4t58KA7U3Xlb93L9TTOBIeHsp0u7MlBSIgrvaojkPJaQ3mn+hm
         3Om9mb7OJj8R+Y2cpPjHQyL8IYhO6/8uCZoD3N9SPTs14+sWwzesQRINdhDg4ezvQd+R
         GNeX59DqVBOX3yL9ZmHpLM75BjNZNT5CrFQdsUopJapLT5Q5oy2+rNeHr+2gHvuxpEOK
         hB+yu6GguNQWSDGICbLcEQ+QryAdgQzx1QxNsL9h2BRV12B+h3Rm0eqTAgav5D5oKoFb
         V3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pT1tSOA1Izh0qdqOIeOKkczIFYFbYblirMLL0FSKvVE=;
        b=JyWs/Udh3WN60NWmyP49piiWvM42iRII/iVQbo25aPQxs7+fdxyplQa0QnvmXJJiMQ
         wsWOMb/Zjxvu3cNsIyfMk1R2kVSaMUltXB3A6xJh1hpKfEl5yqBqF/phIMRU6VfL8p2m
         kEfY5yuufh1aKJ5I/Nsw+vrNWLZVfSfMw5WYFjW4igYc//SJQLlD0PYbIyOJoR/+CCRZ
         SB3skWahvrHP/ZM2mSjT1g70Uv5X+5a3qlkN9uSmvbv/YjTZaq6wG8zVC7s1PnUadMc9
         pvyHuc7j7y6BOsHVhAXQ4u0+gsjYZxHqLF6HgqduNHdjp9kKrO+vEDwUYMI2Je/mznT7
         PW4A==
X-Gm-Message-State: APjAAAU96xglCDwEyJ38qSc5zcrerfm6LznCNPB0pKCvdcFmQaqlrQDA
        6YVi+QkpJonl7nb3mD0YZPM=
X-Google-Smtp-Source: APXvYqxNRhiottBcA458rSTczxL1HvQ/AELHcqbTHYEKjkNySffNoBVVOnvjItEb+9ZKCij4hhj68w==
X-Received: by 2002:a9d:5a11:: with SMTP id v17mr31945482oth.150.1554211266274;
        Tue, 02 Apr 2019 06:21:06 -0700 (PDT)
Received: from PF15AMXS.hz.ali.com ([205.204.117.33])
        by smtp.gmail.com with ESMTPSA id g17sm5524865otq.45.2019.04.02.06.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 06:21:05 -0700 (PDT)
Date:   Tue, 2 Apr 2019 21:20:55 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        subhra.mazumdar@oracle.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190402132038.GA1198@PF15AMXS.hz.ali.com>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:28:12AM +0200, Peter Zijlstra wrote:
> Another approach would be something like the below:
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -87,7 +87,7 @@ static inline int __task_prio(struct tas
>   */
>  
>  /* real prio, less is less */
> -static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool runtime)
> +static inline bool __prio_less(struct task_struct *a, struct task_struct *b, u64 vruntime)
>  {
>  	int pa = __task_prio(a), pb = __task_prio(b);
>  
> @@ -104,21 +104,25 @@ static inline bool __prio_less(struct ta
>  	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
>  		return !dl_time_before(a->dl.deadline, b->dl.deadline);
>  
> -	if (pa == MAX_RT_PRIO + MAX_NICE && runtime) /* fair */
> -		return !((s64)(a->se.vruntime - b->se.vruntime) < 0);
> +	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
> +		return !((s64)(a->se.vruntime - vruntime) < 0);
>  
>  	return false;
>  }
>  
>  static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
>  {
> -	return __prio_less(a, b, true);
> +	return __prio_less(a, b, b->se.vruntime);
>  }
>  
>  static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
>  {
> -	/* cannot compare vruntime across CPUs */
> -	return __prio_less(a, b, false);
> +	u64 vruntime = b->se.vruntime;
> +
> +	vruntime -= task_rq(b)->cfs.min_vruntime;
> +	vruntime += task_rq(a)->cfs.min_vruntime
> +
> +	return __prio_less(a, b, vruntime);
>  }
>  
>  static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)

Brilliant, I like this approach, it makes core_prio_less() work across
CPUs. So I tested this, together with changing
cpu_prio_less(max, class_pick) to core_prio_less(max, class_pick) in
pick_task(), this problem is gone :-)

I verified with below debug code:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb24a0141e57..50658e79363f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3832,6 +3832,14 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
+		if (rq->core->core_cookie && rq_i->core_pick->core_cookie &&
+			rq->core->core_cookie != rq_i->core_pick->core_cookie) {
+			trace_printk("expect 0x%lx, cpu%d got 0x%lx\n",
+					rq->core->core_cookie, i,
+					rq_i->core_pick->core_cookie);
+			WARN_ON_ONCE(1);
+		}
+
 		rq_i->core_pick->core_occupation = occ;
 
 		if (i == cpu)
-- 
2.19.1.3.ge56e4f7

