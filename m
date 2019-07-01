Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AB3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663BD20673
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCfqCyIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfGAIDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:03:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39812 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGAIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:03:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so6926404pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NtIJgEqr5a+tboLGQAt9BeVBtMYgtyvUXMLqycWKEgY=;
        b=NCfqCyIQ8QsnZhro5Uoc0ZBABugb4pmjelltEYnmarUlx6ffHKm8BRcFjveWujNev+
         /K1ohG+I+Wt89Dozg9zWPftFA5fkZsKLkAOvSsU6wWIZLdMwiezUbMvX4RxbSNE4+6Mm
         bEy3+QEutTS23FxIoGR8Hsk6yL5oAaj4f9hZ/WODkeOg74aTQbZRX28sUd+Vif9gqcPs
         PwCk3IksHr4N6ewFI2MjjgEa9YRxbVhIaff56fwZG6bSb2co8w76x9vn/cIaCmoJTGZy
         YqmGKrJuZ7Xkx3mM+/jnQi07ZakK8MH5sxmGFWAGlZ8z4GzWm75gLU3k/d6ZuYxCBGzI
         /3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NtIJgEqr5a+tboLGQAt9BeVBtMYgtyvUXMLqycWKEgY=;
        b=EFrO0WwBK9f34I/8Dd3LLNxj3i8fjN5RetPPnyfPQ6/x1umK9TN0u4qZqeQ66YIvok
         bR9zRWVvikAbfMM77olG25Nx6bl+83zmcoXZ6L6Asqq4d8rmfeer3hIcD5sbe81Nfzfe
         wt6dSmX5CXb82EAG0oNell9dCVyZCIp6HBtNYO5Evi609vTfK00z4JRGr+aClHswXnzv
         gINZN0fecikYX0OhoV1IOFZquWAU3TULK6YnjrW3JQVInYH7NCJe9Z1rDJLushuLed+R
         vIVVYqFHDW23P4iRdo4pgSWJaLMsJk8l5jOb2NYw5qBcWmPgaJglL5bQlKujcyd6fwK4
         CjjA==
X-Gm-Message-State: APjAAAX2E57Az3GPHeWbaTOSrGzJkD2yewqeCyb9HKUQCit226MyHbts
        fiAt6Y+cqCoub0odeEche2A/Ag==
X-Google-Smtp-Source: APXvYqyLxDcnOgx6KVsnqeZCyxjiu15BrHNTGUpp0Uz7PM/xrAbLyckMFxsnYdZRkuh0t/M/iBipQw==
X-Received: by 2002:a17:902:b487:: with SMTP id y7mr27010317plr.219.1561968231789;
        Mon, 01 Jul 2019 01:03:51 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id 85sm12931447pfv.130.2019.07.01.01.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 01:03:50 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:33:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, songliubraving@fb.com
Subject: Re: [PATCH V3 2/2] sched/fair: Fallback to sched-idle CPU if idle
 CPU isn't found
Message-ID: <20190701080349.homlsgia4fuaitek@vireshk-i7>
References: <cover.1561523542.git.viresh.kumar@linaro.org>
 <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
 <32bd769c-b692-8896-5cc9-d19ab0a23abb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32bd769c-b692-8896-5cc9-d19ab0a23abb@oracle.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-19, 18:16, Subhra Mazumdar wrote:
> 
> On 6/25/19 10:06 PM, Viresh Kumar wrote:
> > We try to find an idle CPU to run the next task, but in case we don't
> > find an idle CPU it is better to pick a CPU which will run the task the
> > soonest, for performance reason.
> > 
> > A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> > should be a good target based on this criteria as any normal fair task
> > will most likely preempt the currently running SCHED_IDLE task
> > immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
> > shall give better results as it should be able to run the task sooner
> > than an idle CPU (which requires to be woken up from an idle state).
> > 
> > This patch updates both fast and slow paths with this optimization.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++----------
> >   1 file changed, 33 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1277adc3e7ed..2e0527fd468c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5376,6 +5376,15 @@ static struct {
> >   #endif /* CONFIG_NO_HZ_COMMON */
> > +/* CPU only has SCHED_IDLE tasks enqueued */
> > +static int sched_idle_cpu(int cpu)
> > +{
> > +	struct rq *rq = cpu_rq(cpu);
> > +
> > +	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
> > +			rq->nr_running);
> > +}
> > +
> Shouldn't this check if rq->curr is also sched idle?

Why wouldn't the current set of checks be enough to guarantee that ?

> And why not drop the rq->nr_running non zero check?

Because CPU isn't sched-idle if nr_running and idle_h_nr_running are both 0,
i.e. it is an IDLE cpu in that case. And so I thought it is important to have
this check as well.

-- 
viresh
