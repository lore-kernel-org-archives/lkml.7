Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3328BC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0378920989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyiIgpCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfEMJeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:34:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34342 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:34:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so6207189plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8qILBOpMiRedYdROo4F7lbb8sYs87f3CbxwazOWGN18=;
        b=cyiIgpCIXRQoY9yWYhfPDw0v7Zb7a3qRNiQfDjDK3tju5VjWfLC3UJyG8KnwAtn8bf
         LhjJsYPPrCg35OdLYV7VCwGDBU2z683NvNIB/BAYJPLNm1B0Eyf2BgxMKJjcKfqPVKWL
         q+3zeP+darH8GDL1p1M35LCw1lfZE90aMPKd8AoA6tgRZjC2pc9xBoMOPA4zKX43vzcC
         X0ASLmh8cTNHulkgdM1Ux7EnS6j/u8zACE57dAYWneuu/0zuq1L6A6+Qrv5g7HUnbJ6z
         JJXgwD3o0qnMty7B1JWlWLtn8JKAJe4UW54nbNmH72na21YbO+8Tucd5nRowzMC9KaJs
         uFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qILBOpMiRedYdROo4F7lbb8sYs87f3CbxwazOWGN18=;
        b=Yf09k1vaxcQGpfzp3sm1sx4QSHrOncIpYdhUTpC3OkLnOTr6BxqxeP/CtziLpd/b6R
         HUF845blYXbPSBIRAol3r3/6/VSrKSS0UQBnB1klQfuD46iAw10n6a+KsZGzWGTmns/9
         xtU5h6YV1SKd5eTRWY2BYsETtR5tMcsVdwIz4LCkoFQnYI2HFVsVrDHFJs/NyUjpgrvX
         BNuFl7qjfwOsf9CZtmpfXfLA+JF0KACnb7i1XiXNwCttofDDHVlqaYGQdcyoho2YtTkA
         n8jh4eet4lO6Ye+/TLdGNXUl5ilR0gPHjPo0BCuxKXVzRnzBVY5mIgj2IWWq1/DSpRo/
         4wqw==
X-Gm-Message-State: APjAAAXHWJMWcGiJYqvFDqe8r0F3fFIKjgCOl90fItisnZcNrZ+L0Y6y
        38uWneia2XLydiElDqY5hXSObg==
X-Google-Smtp-Source: APXvYqzspeETLDTAQy7Ayu5YY1TRqeSZxIl8sANuKb2cUy+CIK2+NKacfzWbFifERBIQY+lKCKpSCg==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr29276221plz.91.1557740061380;
        Mon, 13 May 2019 02:34:21 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id 85sm3511294pgb.52.2019.05.13.02.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:34:20 -0700 (PDT)
Date:   Mon, 13 May 2019 15:04:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>, songliubraving@fb.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com
Subject: Re: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
Message-ID: <20190513093418.altqhlhu4zsu75t4@vireshk-i7>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
 <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
 <20190510072125.GG2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510072125.GG2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-19, 09:21, Peter Zijlstra wrote:
> On Thu, Apr 25, 2019 at 03:07:40PM +0530, Viresh Kumar wrote:
> > We target for an idle CPU in select_idle_sibling() to run the next task,
> > but in case we don't find idle CPUs it is better to pick a CPU which
> > will run the task the soonest, for performance reason. A CPU which isn't
> > idle but has only SCHED_IDLE activity queued on it should be a good
> > target based on this criteria as any normal fair task will most likely
> > preempt the currently running SCHED_IDLE task immediately. In fact,
> > choosing a SCHED_IDLE CPU shall give better results as it should be able
> > to run the task sooner than an idle CPU (which requires to be woken up
> > from an idle state).
> > 
> > This patch updates the fast path to fallback to a sched-idle CPU if the
> > idle CPU isn't found, the slow path can be updated separately later.
> > 
> > Following is the order in which select_idle_sibling() picks up next CPU
> > to run the task now:
> > 
> > 1. idle_cpu(target) OR sched_idle_cpu(target)
> > 2. idle_cpu(prev) OR sched_idle_cpu(prev)
> > 3. idle_cpu(recent_used_cpu) OR sched_idle_cpu(recent_used_cpu)
> > 4. idle core(sd)
> > 5. idle_cpu(sd)
> > 6. sched_idle_cpu(sd)
> > 7. idle_cpu(p) - smt
> > 8. sched_idle_cpu(p)- smt
> > 
> > Though the policy can be tweaked a bit if we want to have different
> > priorities.
> 
> I don't hate his per se; but the whole select_idle_sibling() thing is
> something that needs looking at.
> 
> There was the task stealing thing from Steve that looked interesting and
> that would render your apporach unfeasible.

I am surely missing something as I don't see how that patchset will
make this patchset perform badly, than what it already does.

The idea of this patchset is to find a CPU which can run the task the
soonest if no other CPU is idle. If a CPU is idle we still want to run
the task on that one to finish work asap. This patchset only updates
the fast path right now and doesn't touch slow-path and periodic/idle
load-balance path. That would be the next step for sure though.

Steve's patchset (IIUC) adds a new fast way of doing idle-load-balance
at the LLC level, that is no different than normal idle-load-balancing
for this patchset. In fact, I will say that Steve's patchset makes our
work easier to extend going forward as we can capitalize on the new
*fast* infrastructure to pull tasks even when a CPU isn't fully idle
but only has sched-idle stuff on it.

Does this makes sense ?

@Song: Thanks for giving this a try and I am really happy to see your
results. I do see that we still don't get the performance we wanted,
perhaps because we only touch the fast path. Maybe load-balance screws
it up for us at a later point of time and CPUs are left with only
sched-idle tasks. Not sure though.

-- 
viresh
