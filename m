Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2EC2068D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOqsXLW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUNau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:30:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51829 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUNau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:30:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so3457956wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jo+ES8Xc5JRhOigJYOHMRS0C9xfeoUlcZgoW8bE/klw=;
        b=WOqsXLW22kr4axDfqEH5dPhsTbkK5xKkbZfYrn+lbxNAo3grp4lJI62h4bBNN6zfqN
         h0Ezl+mfeIlN4g/wUslgGqCDuY4OzJsQk4qA41onqSgrwJv1c15So7vTaANZiV7xTFel
         UkFldHazH0+pYJwf9XZpxPpBvII5ZuZUGU08ovJIOY5spfr0DlUwgXDx1buJbVU+D8XZ
         nAgL359OjUCojdYI+zxZZEUy3ponYMJZxpDPBvppuVzB4aLgpG6voOHT1+z813EeQdES
         G4QPrletLL3WzD/ncqxZrlNM69ATLY/tEacFoJIIBxuMon8uJRU3U6rz+ftoioaDOCVg
         wHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jo+ES8Xc5JRhOigJYOHMRS0C9xfeoUlcZgoW8bE/klw=;
        b=SN0CP/y6IXHnEz964gMLc81X+ps+FP+xmnQitXAZbxRX8ubdDb4tyeTl6m8Y+RN3CG
         eyYyyQUEXt+vQXCzyYZCx7KFvIankEmCkBH4iUaNTxcCAk0H2zhpV3UaxPfsNHKnhufN
         CtgI0DJDKk8jH/kE8pIPUsaCBIr/KoEQY5NQKqSESwF4GO0hPrfmm7E6myf/zztPRVxV
         hmmLgNHkoqgCjfZEg7Inb3pRNq4gOrLpba4me/yqsU7zo4Myj1WZdk6HrWcP/2gUzoCw
         PVMCZM0kM3i8WKreM5DxOH/hJVatLFOA1k7nBVjeR8fiQrnWgte4Kbq7YtUo1I6be591
         /hyw==
X-Gm-Message-State: APjAAAW9le/G7iZ0+aVGUI/C13zSyQc3DUiIuAE3wa82LjOhuatCrff6
        /usqhRzK6Uqenc47b65kCJNWDw==
X-Google-Smtp-Source: APXvYqwfKqvBfhToGbmgTDkb4afoB9HGvbkBU0UqNXIj/iBpVqvczE4D3AVjR+XgW01I+HY3OmXE9Q==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr10380769wmk.62.1574343047861;
        Thu, 21 Nov 2019 05:30:47 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id f67sm2994421wme.16.2019.11.21.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 05:30:47 -0800 (PST)
Date:   Thu, 21 Nov 2019 13:30:43 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
Message-ID: <20191121133043.GA46904@google.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
 <20191121115602.GA213296@google.com>
 <f7e5dabb-a7e6-d110-abca-de7d4533bcc5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e5dabb-a7e6-d110-abca-de7d4533bcc5@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 Nov 2019 at 12:56:39 (+0000), Valentin Schneider wrote:
> > @@ -6274,6 +6274,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  			if (!fits_capacity(util, cpu_cap))
> >  				continue;
> >  
> > +			/*
> > +			 * Skip CPUs that don't satisfy uclamp requests. Note
> > +			 * that the above already ensures the CPU has enough
> > +			 * spare capacity for the task; this is only really for
> > +			 * uclamp restrictions.
> > +			 */
> > +			if (!task_fits_capacity(p, capacity_orig_of(cpu)))
> > +				continue;
> 
> This is partly redundant with the above, I think. What we really want here
> is just
> 
> fits_capacity(uclamp_eff_value(p, UCLAMP_MIN), capacity_orig_of(cpu))
> 
> but this would require some inline #ifdeffery.

This suggested change lacks the UCLAMP_MAX part, which is a shame
because this is precisely in the EAS path that we should try and
down-migrate tasks if they have an appropriate max_clamp. So, your first
proposal made sense, IMO.

Another option to avoid the redundancy would be to do something along
the lines of the totally untested diff below.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5709ff..38cb5fe7ba65 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6372,9 +6372,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
                        if (!cpumask_test_cpu(cpu, p->cpus_ptr))
                                continue;
 
-                       /* Skip CPUs that will be overutilized. */
                        util = cpu_util_next(cpu, p, cpu);
                        cpu_cap = capacity_of(cpu);
+                       spare_cap = cpu_cap - util;
+                       util = uclamp_util_with(cpu_rq(cpu), util, p);
+
+                       /* Skip CPUs that will be overutilized. */
                        if (!fits_capacity(util, cpu_cap))
                                continue;
 
@@ -6389,7 +6392,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
                         * Find the CPU with the maximum spare capacity in
                         * the performance domain
                         */
-                       spare_cap = cpu_cap - util;
                        if (spare_cap > max_spare_cap) {
                                max_spare_cap = spare_cap;
                                max_spare_cap_cpu = cpu;

Thoughts ?

Thanks,
Quentin
