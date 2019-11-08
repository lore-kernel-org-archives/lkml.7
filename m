Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0CEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA6B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csWWcJPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfKHLcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:32:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32808 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfKHLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:32:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so4415307pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oal3Za7MPstt95oA4rhjWG6PFWcqU7c3Oih+QOo6zXY=;
        b=csWWcJPqkRPKsUxLkfJgP5nZSZhfy0sziNyDXVw+On45DUDlYU0KdBlEjp2T6m3dGa
         eQTnMEyglxaBPByc3YPNmukxRTNFPl4hdTd6iLpaxdf5M3UpfLithxvJr+sBhneAv+tv
         iJ7YARTqsEmmFpTxa8WWOcurPCy8vVDiJeVgT4cK4k1ybUi8b1W8el3O0iJBFTYZ5DK4
         JFKzeX7qqLmITdBSl/pFYy4wz+fP9EcG4BTvdb9ZlW8xg7lfAXMz0eN5hLR6ApAe/ENM
         fdwkWyOLR+fuIIQB7l+n0deSRnrC6pnu3oUwB2PtMxSIggrtn+99423Hr7B0nnhNvR/2
         9coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oal3Za7MPstt95oA4rhjWG6PFWcqU7c3Oih+QOo6zXY=;
        b=gxingsPUt6Yn16cCppp45W2LDWBRnuFz45jEM3BDKNAs5rGx0bxEnJLoYJogrJkF46
         tJzH0ggYvf8dsW6dbI6CNmE1XlerFRk5gGJP32DDwePyKb9ZSJwKlfo5ID0G3pU88WWe
         vsy1VGZIkdgjyB2zfYZuptJvVIGS7xBJClGaRw7ZMd5CEoHk2Ig89YmpVKGpEJ42wHeg
         WlsjD2Zjm39+Mi7RVI1eRKzIGChf2PqyWiqfZhIh1cw0rG1ITT7MJFsuVQem7XApMXTq
         TCQhQPHks2jZquTGjCzZQWSGwFFe16bWz/wIuWb/rsBI6QThI/dODz2iKTP9ZEIEWbI5
         vvoA==
X-Gm-Message-State: APjAAAVmgiYj6PXBBVgpUVDmGB7F4oS8RZcrR6E6HFq0PTDK/YhUkIr1
        hJ5xq5WVRGuJ5Zwd1wHezO8kYw==
X-Google-Smtp-Source: APXvYqyn8WFEaGPxpRyBOzIFmCGXRVJypaRcKDU0Rx9SiGDtWW6wXU8GzqQkB89kUyNufE4Udp1EmA==
X-Received: by 2002:a62:6404:: with SMTP id y4mr10918020pfb.170.1573212724010;
        Fri, 08 Nov 2019 03:32:04 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id i123sm10211330pfe.145.2019.11.08.03.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 03:32:02 -0800 (PST)
Date:   Fri, 8 Nov 2019 17:01:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent
 throughout
Message-ID: <20191108113156.y555y4se2mshv7in@vireshk-i7>
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
 <20191030164714.GH28938@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030164714.GH28938@suse.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-19, 16:47, Mel Gorman wrote:
> On Thu, Oct 24, 2019 at 12:15:27PM +0530, Viresh Kumar wrote:
> > There are instances where we keep searching for an idle CPU despite
> > having a sched-idle cpu already (in find_idlest_group_cpu(),
> > select_idle_smt() and select_idle_cpu() and then there are places where
> > we don't necessarily do that and return a sched-idle cpu as soon as we
> > find one (in select_idle_sibling()). This looks a bit inconsistent and
> > it may be worth having the same policy everywhere.
> > 
> 
> This needs supporting data.

I did some more interesting tests with rt-app. It was getting
difficult to generate the correct numbers with normal use cases as
most of the time prev/target/etc CPUs were found to be completely idle
and the task was getting placed there in all the cases and so no diff
with sched-idle changes.

To prove the point I was making (that we can reduce task latency with
SCHED_IDLE), I created 3 different tests on my hikey board (octa-core,
2 clusters, 0-3 and 4-7). The cpufreq governor was set to performance
to avoid any side affects from CPU frequency.

Test 1: 1-cfs-task:

A single SCHED_NORMAL task is pinned to CPU5 which runs for 2333 us
out of 7777 us (so gives time for the cluster to go in deep idle
state).

Test 2: 1-cfs-1-idle-task:

A single SCHED_NORMAL task is pinned on CPU5 and single SCHED_IDLE
task is pinned on CPU6 (to make sure cluster 1 doesn't go in deep idle
state).

Test 3: 1-cfs-8-idle-task:

A single SCHED_NORMAL task is pinned on CPU5 and eight SCHED_IDLE
tasks are created which run forever (not pinned anywhere, so they run
on all CPUs). Checked with kernelshark that as soon as NORMAL task
sleeps, the SCHED_IDLE task starts running on CPU5.

And here are the results on mean latency (in us), using the "st" tool.

$ st 1-cfs-task/rt-app-cfs_thread-0.log 
N	min	max	sum	mean	stddev
642	90	592	197180	307.134	109.906

$ st 1-cfs-1-idle-task/rt-app-cfs_thread-0.log 
N	min	max	sum	mean	stddev
642	67	311	113850	177.336	41.4251

$ st 1-cfs-8-idle-task/rt-app-cfs_thread-0.log 
N	min	max	sum	mean	stddev
643	29	173	41364	64.3297	13.2344


The mean latency when:
- we need to wakeup from deep idle state is 307 us
- we need to wakeup from shallow idle state is 177 us
- we need to preempt a SCHED_IDLE task is 64 us

So the theory looks correct, we should probably prefer SCHED_IDLE CPUs
both for power and performance :)

> find_idlest_group_cpu is generally from
> a fork() context where it's not particularly performance critical.
> select_idle_sibling and the helpers it uses is wakeup context where is
> is often much more critical to wake quickly than find the best CPU.

I agree. We must find the best CPU here. But won't a SCHED_IDLE cpu be
the best ? After all that is the one in shallowest idle state and so
better for power :)

-- 
viresh
