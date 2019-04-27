Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A101C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209222077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556356025;
	bh=mwhMiJ3MQ2Nei3wxS8nEK2Qcw/8sWJvdNzTKZ8HUw0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2BqpTrkvL/SSdqK7AS4fQDAp4b08/LVP6KZum/VTyRzjSE3whDHm6zhiHetqclE0e
	 Wqh+HAZlCClZGnqnL85+R0vvd/ZkRL0VQsx6gCsvVOt3+h/je7AWma4auh/yOKOC15
	 Wmcg0QoiQzp4LaD+3Iwxo82QjMF3VSJFR8tcPEA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfD0JHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:07:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39796 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0JHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:07:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so7764120wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvO5tx75mBcwL4BBc74Z0twD+gtLAHXQirkVGs5qmHU=;
        b=TawwbpFDHBdf7qHKQwanK01akp5UHmfFwWygBiZHzZsXduGGd3h07WJn6bfdBoHST6
         JtGNK5krSkpbpET+dMkO3T6ollDhJX9z4V5hyNIIZkgPTc5fJMOE/tZvSgZjBviwawQO
         IXNRYNCTueNd/00Ke+TG5wktiR8TnRi6XbywMUcixLCzLVy2gOJEdFnfvfTXHM0dVs5a
         aiiBYXlyvfmo4aTpZjztKHcp9TJHkNjJwG249jMwi1c09ZK8xjMOXM+RXWO3EM9II2Mr
         YXtcIyVscoQEGU4stS7kKKZ5zexyiUAG1pu8rmJLzxGaA3nUn4tB8ER8PEx7RM9mTQW9
         mvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvO5tx75mBcwL4BBc74Z0twD+gtLAHXQirkVGs5qmHU=;
        b=pFnD9gBAzUR14gigEz9+55rS1f8vo83mhGXSuNWBPSEozUfMKSN10it1CvdcncnorM
         9aYI0PQ4X5sfvIUOjPfYY/hZkdENi6bdgkpMMZYxYY1lkJgRxvRxHZIagMYfdE9+hJ+s
         cTfElH7qtTO3nei3VjxpZ2cA19TItb6qcCqy2SMNq5X3PFm7JuGsOG8K3Hi7+A+a28dz
         PahHQQKXSFLx1ogXqqT41z2dS/GL495hZZ+5hCGQ96jGftGeysBBqWhcrUaT2Q/1zxlT
         uA/xtYvcrsXtJgqd4zWZZTFlwKzuhE8AfxwQe4PPP68H10IvCMsO+zQQgdu/1QUuqr9p
         TCog==
X-Gm-Message-State: APjAAAVvX14AnPQN1I6iPldsFjw5UU7VqNO4/jt6mlKFaiZi7W+/tutk
        cQiSk/VNTb6LbBaDdFQ7jzE=
X-Google-Smtp-Source: APXvYqx6xdnAH4icHxfhQib5/HAGWBEBBQVrS1RphPXUwl40e4PVJyJU12mkFpKMFL8N/6qkpM3rGw==
X-Received: by 2002:a1c:ca07:: with SMTP id a7mr11423307wmg.104.1556356021027;
        Sat, 27 Apr 2019 02:07:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 204sm34633192wmc.1.2019.04.27.02.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 02:06:59 -0700 (PDT)
Date:   Sat, 27 Apr 2019 11:06:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190427090657.GB99668@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <20190425213145.GY18914@techsingularity.net>
 <20190426094545.GD126896@gmail.com>
 <20190426101947.GZ18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426101947.GZ18914@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> On Fri, Apr 26, 2019 at 11:45:45AM +0200, Ingo Molnar wrote:
> > 
> > * Mel Gorman <mgorman@techsingularity.net> wrote:
> > 
> > > > > I can show a comparison with equal levels of parallelisation but with 
> > > > > HT off, it is a completely broken configuration and I do not think a 
> > > > > comparison like that makes any sense.
> > > > 
> > > > I would still be interested in that comparison, because I'd like
> > > > to learn whether there's any true *inherent* performance advantage to 
> > > > HyperThreading for that particular workload, for exactly tuned 
> > > > parallelism.
> > > > 
> > > 
> > > It really isn't a fair comparison. MPI seems to behave very differently
> > > when a machine is saturated. It's documented as changing its behaviour
> > > as it tries to avoid the worst consequences of saturation.
> > > 
> > > Curiously, the results on the 2-socket machine were not as bad as I
> > > feared when the HT configuration is running with twice the number of
> > > threads as there are CPUs
> > > 
> > > Amean     bt      771.15 (   0.00%)     1086.74 * -40.93%*
> > > Amean     cg      445.92 (   0.00%)      543.41 * -21.86%*
> > > Amean     ep       70.01 (   0.00%)       96.29 * -37.53%*
> > > Amean     is       16.75 (   0.00%)       21.19 * -26.51%*
> > > Amean     lu      882.84 (   0.00%)      595.14 *  32.59%*
> > > Amean     mg       84.10 (   0.00%)       80.02 *   4.84%*
> > > Amean     sp     1353.88 (   0.00%)     1384.10 *  -2.23%*
> > 
> > Yeah, so what I wanted to suggest is a parallel numeric throughput test 
> > with few inter-process data dependencies, and see whether HT actually 
> > improves total throughput versus the no-HT case.
> > 
> > No over-saturation - but exactly as many threads as logical CPUs.
> > 
> > I.e. with 20 physical cores and 40 logical CPUs the numbers to compare 
> > would be a 'nosmt' benchmark running 20 threads, versus a SMT test 
> > running 40 threads.
> > 
> > I.e. how much does SMT improve total throughput when the workload's 
> > parallelism is tuned to utilize 100% of the available CPUs?
> > 
> > Does this make sense?
> > 
> 
> Yes. Here is the comparison.
> 
> Amean     bt      678.75 (   0.00%)      789.13 * -16.26%*
> Amean     cg      261.22 (   0.00%)      428.82 * -64.16%*
> Amean     ep       55.36 (   0.00%)       84.41 * -52.48%*
> Amean     is       13.25 (   0.00%)       17.82 * -34.47%*
> Amean     lu     1065.08 (   0.00%)     1090.44 (  -2.38%)
> Amean     mg       89.96 (   0.00%)       84.28 *   6.31%*
> Amean     sp     1579.52 (   0.00%)     1506.16 *   4.64%*
> Amean     ua      611.87 (   0.00%)      663.26 *  -8.40%*
> 
> This is the socket machine and with HT On, there are 80 logical CPUs
> versus HT Off with 40 logical CPUs.

That's very interesting - so for most workloads HyperThreading is a 
massive loss, and for 'mg' and 'sp' it's a 5-6% win?

I'm wondering how much of say the 'cg' workload's -64% loss could be task 
placement inefficiency - or are these all probable effects of 80 threads 
trying to use too many cache and memory resources and thus utilizing it 
all way too inefficiently?

Are these relatively simple numeric workloads, with not much scheduling 
and good overall pinning of tasks, or is it more complex than that?

Also, the takeaway appears to be: by using HT there's a potential 
advantage of +6% on the benefit side, but a potential -50%+ performance 
hit on the risk side?

I believe these results also *strongly* support a much stricter task 
placement policy in up to 50% saturation of SMT systems - it's almost 
always going to be a win for workloads that are actually trying to fill 
in some useful role.

Thanks,

	Ingo
