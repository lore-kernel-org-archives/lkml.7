Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB5CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F42206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuLdIKvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKMRul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:50:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53215 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfKMRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:50:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so2955144wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XtZ5+hurRglr2Zec63tSlfjqtuoBsXpGgI+k5kdQDcU=;
        b=QuLdIKvOrPdm9jUB2Y3bTEmV76qPaTwnuZ2n/kzC+Pw6MXe1N4HV1EZNRLJghkAhXU
         goHShHGpbQkNngKCZylqHOEnNL0SvIgSfF/5LqoCIPr4zbdY3yCLA0rcGWjdqtOXHiQ9
         ebCfGFWOzHaqD8WI0UnFdMzT8grOKeXdEfWX9kPLFW/+Ud/2ouVzUhlQc7SVPKiUAA3C
         v1kHT8uYWHsAmRDQGJqfKvF/tU/ht6qPaQPgWeFfEEySzgO345SedMr5p25ncrZLeHQm
         BPi3QMvjcCj1OKZwBiWckNcKSbUm41swEvu4hiJxee55vL/yhuiXGTocJ1bVZGp5ac4a
         8GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XtZ5+hurRglr2Zec63tSlfjqtuoBsXpGgI+k5kdQDcU=;
        b=YzKwCzJKWnJ4xurFJCNRZjmPXQfUSGztxQApf0lCgcw+Iqks52F+xswgaFeFdIXHlS
         DxgCyTU7rs21ngE74JshYX6cdgqjhSKLUGHMCSEeix8TqceBg8R4MkvptXdXGXfzvgpg
         RekUHWALPZMRrG2nZYDU1MnhLcNCH/RYEY+AZa3igBnJKJs20MctcbGK2ZTPHpWYDQ4L
         vbT1QVu9aQSdxsfvYAdA/tqCS767FZnSgNm0f5xYkRN+Ffk8M42pX18mF5Nn3tgWjcgf
         at0TVV+4Os543vhe5e1PQnJog3jOQK2zSXMD37I58QYps0lzCHKMJvPYHfIjSSmlXjl2
         VioQ==
X-Gm-Message-State: APjAAAWA5dk7r4NlhmMedKXV+VAmOKXRvaWQ/J6GNmzTaRXps4pdddtF
        CtJOYqzQKPsQNqSSN5AIY1JxeQ==
X-Google-Smtp-Source: APXvYqwOVazO2F4zD8CghNWIMLBqPeDM2BvHp40pB/noJ1PV95xa2h4VO4iA6aANqurH7qMZLVQGng==
X-Received: by 2002:a7b:c347:: with SMTP id l7mr4047027wmj.48.1573667439032;
        Wed, 13 Nov 2019 09:50:39 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:bdd0:28e6:f0d9:a18c])
        by smtp.gmail.com with ESMTPSA id u1sm2854689wmc.3.2019.11.13.09.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:50:37 -0800 (PST)
Date:   Wed, 13 Nov 2019 18:50:35 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
Message-ID: <20191113175035.GA8553@linaro.org>
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
 <20191112150544.GA3664@linaro.org>
 <3b8cafb7-894d-c302-e6c6-b5844b1298b5@arm.com>
 <CAKfTPtBMNnM2tTfb72VtufDpwBvqu6Ttj3dnLgoNOZ--Q6qo+Q@mail.gmail.com>
 <bcba52bc-6780-1efc-6ef4-1a75f1cef33d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcba52bc-6780-1efc-6ef4-1a75f1cef33d@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wednesday 13 Nov 2019 à 15:09:47 (+0100), Dietmar Eggemann a écrit :
> On 13.11.19 14:30, Vincent Guittot wrote:
> > On Wed, 13 Nov 2019 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 12.11.19 16:05, Vincent Guittot wrote:
> >>> Le Tuesday 12 Nov 2019 à 15:48:13 (+0100), Vincent Guittot a écrit :
> 
> [...]
> 
> >>>> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
> >>>>       * that RT, DL and IRQ signals have been updated before updating CFS.
> >>>>       */
> >>>>      curr_class = rq->curr->sched_class;
> >>>> -    update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> >>>> -    update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> >>>> -    update_irq_load_avg(rq, 0);
> >>>> +    decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> >>>> +    decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> >>>> +    decayed |= update_irq_load_avg(rq, 0);
> >>
> >> Why not 'decayed  = update_cfs_rq_load_avg()' like in the
> >> !CONFIG_FAIR_GROUP_SCHED case?
> > 
> > Because it is handled by the update_load_avg() in
> > for_each_leaf_cfs_rq_safe() loop
> > 
> > This means that we can have 2 calls to cpufreq_update_util in
> > update_blocked_average() but at least the values will be up to date in
> > both calls unlike previously.
> > 
> > I'm going to prepare an additional patch to remove this useless call.
> > I have also seen some possible further optimization that i need to
> > study a bit more before preparing a patch
> 
> I see. The update_load_avg() call for the taskgroup skeleton se
> (cfs_rq->tg->se[cpu]). But what happens to the cpu which only has the
> root cfs_rq i the list? It doesn't have a skeleton se.

you're right. I have to add the following to make sure it will be called

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2eb1aa8..9fc077c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7604,9 +7604,13 @@ static void update_blocked_averages(int cpu)
                        cpu,
                        cfs_rq == &rq->cfs ? 0 : (long)cfs_rq->tg );
 
-               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
+               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
                        update_tg_load_avg(cfs_rq, 0);
 
+                       if (cfs_rq == &rq->cfs)
+                               decayed = 1;
+               }
+
                trace_sched_load_contrib_blocked(cpu,
                        &cfs_rq->avg,
                        cfs_rq == &rq->cfs ? 0 : (long)cfs_rq->tg );


