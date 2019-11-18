Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6D1206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574082956;
	bh=Sfp8fsPf4vYB7BCtekhlrC3EKA0S41yUMjRaxhXV9FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sgy1cNG9OJI75ozmMl7vUqIOGgNNpGxpuYQVdz2hKuEFxR5KY1NHdTiEKvWwG28e+
	 WQW0wo7adY88Zt5i1BZnUEXvF/Oia1uqYtv9E3OeibvGTJ3fUX6FoB+YpU7V54+Fsq
	 Rzpi+vPlsc1rN6TKkNcBqxgf9X0SAXQz+wVZ6ydI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKRNPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:15:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50298 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfKRNPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:15:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so17318175wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwrm/EdqJrqRNp6lDCphJomGvC6C6nLJYt/tPtXNRTo=;
        b=CPZtH2ZLTLwEH9TSUaYNabXvirAMqgCMYHDboEXSQKVRdXf4TcrIhYxU1tH4cNuw80
         6SeO0ffIfO5RXwB+bfnNhLxJh0Txr04s0PXOC6Ppm/DlpSwl/VM/VaL80EU0vySF0F4n
         qSIt5gWm9kpFeB6tu8nXpv/oNYgMI76GRWoPJ6oKyB/J2yB01hghFRorZCU2EREQATga
         qUZOKFKOf2pBdR9uE+7Mame6+arLJhVuXGos4zGiQQt5bKvrZ8sfLwC8TIt4gAlJI3SX
         li1ZmkMwKP2POdy6u+uOH2ReStPY4TqUehbrqYrfDyAAbEgF+8N4fAQpVud4VqNhbQay
         hcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwrm/EdqJrqRNp6lDCphJomGvC6C6nLJYt/tPtXNRTo=;
        b=ZPzpgwfwpZ+3l/zd9SE6snO69GxPV7U0sDyYLFEs+oQF8ekTL15L4zhQ+R+p0gVzZe
         gcvb7fI/e7wFWZ+lpN+EefsKkfK6qSaRUroBxH16nEoHKzLcwzEJ62skeVvZIP9Td5y9
         SFmyvsGlEmJcs+Zhy2r1FoTy9wp9aE2uE4bLRDfELVKMPS2cDn6/JejdNbcFvdIJnOL3
         WkLLvVG5t0Ax1KYl1pTDofEiNC45BZUtPB3fpX0HKGGAnCpHsf5rt0pVKA8UBc6Ad4Gr
         N5ym3JlYtHTLLS3wZFi7zkcIP1nfQrIcep67WP5EfqfYLCD1L0ByjVcFTE53ZB5CS5Wx
         XEWA==
X-Gm-Message-State: APjAAAXd5v6z5lWrZjWdVPUXpwx5jFeVXVUIO/9P6R+S8HUPEnn177Nx
        P1Yc7eD6+Nw4/o0sdc7xmrk=
X-Google-Smtp-Source: APXvYqyp+hz39/b0fxklCkUM8qTiQIMxAffYDa6DSEvI6YrVB8J9AgtZEmmPObwfkTrDBOeLgda6wA==
X-Received: by 2002:a1c:de88:: with SMTP id v130mr30852765wmg.89.1574082949828;
        Mon, 18 Nov 2019 05:15:49 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 19sm26137589wrc.47.2019.11.18.05.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 05:15:48 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:15:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191118131546.GA66833@gmail.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com>
 <20191030162440.GO3016@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030162440.GO3016@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> On Mon, Oct 21, 2019 at 09:50:38AM +0200, Ingo Molnar wrote:
> > > <SNIP>
> > 
> > Thanks, that's an excellent series!
> > 
> 
> Agreed despite the level of whining and complaining I made during the
> review.

I saw no whining and complaining whatsoever, and thanks for the feedback!
:-)

> 
> > I've queued it up in sched/core with a handful of readability edits to 
> > comments and changelogs.
> > 
> > There are some upstreaming caveats though, I expect this series to be a 
> > performance regression magnet:
> > 
> >  - load_balance() and wake-up changes invariably are such: some workloads 
> >    only work/scale well by accident, and if we touch the logic it might 
> >    flip over into a less advantageous scheduling pattern.
> > 
> >  - In particular the changes from balancing and waking on runnable load 
> >    to full load that includes blocking *will* shift IO-intensive 
> >    workloads that you tests don't fully capture I believe. You also made 
> >    idle balancing more aggressive in essence - which might reduce cache 
> >    locality for some workloads.
> > 
> > A full run on Mel Gorman's magic scalability test-suite would be super 
> > useful ...
> > 
> 
> I queued this back on the 21st and it took this long for me to get back
> to it.
> 
> What I tested did not include the fix for the last patch so I cannot say
> the data is that useful. I also failed to include something that exercised
> the IO paths in a way that idles rapidly as that can catch interesting
> details (usually cpufreq related but sometimes load-balancing related).
> There was no real thinking behind this decision, I just used an old
> collection of tests to get a general feel for the series.

I have just applied Vincent's fix to find_idlest_group(), so that will 
probably modify some of the results. (Hopefully for the better.)

Will push it out later today-ish.

> Most of the results were performance-neutral and some notable gains 
> (kernel compiles were 1-6% faster depending on the -j count). Hackbench 
> saw a disproportionate gain in terms of performance but I tend to be 
> wary of hackbench as improving it is rarely a universal win. There 
> tends to be some jitter around the point where a NUMA nodes worth of 
> CPUs gets overloaded. tbench (mmtests configuation network-tbench) on a 
> NUMA machine showed gains for low thread counts and high thread counts 
> but a loss near the boundary where a single node would get overloaded.
> 
> Some NAS-related workloads saw a drop in performance on NUMA machines 
> but the size class might be too small to be certain, I'd have to rerun 
> with the D class to be sure.  The biggest strange drop in performance 
> was the elapsed time to run the git test suite (mmtests configuration 
> workload-shellscripts modified to use a fresh XFS partition) took 
> 17.61% longer to execute on a UMA Skylake machine. This *might* be due 
> to the missing fix because it is mostly a single-task workload.

Thanks a lot for your testing!

> I'm not going to go through the results in detail because I think 
> another full round of testing would be required to take the fix into 
> account. I'd also prefer to wait to see if the review results in any 
> material change to the series.

I'll try to make sure it all gets addressed.

Thanks,

	Ingo
