Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96611C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F84208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556186115;
	bh=0n4/b804LrRgV0IkstfXDxmzKKNR4zvoBIoq6K5si1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X5IsTIalUY7AYLhEf01YJQtlibcPJf746QpdXT66OLC2XO9pZ+HUiSii+H+nbQxAY
	 Yb4PzVAV4n1SDxnq4nCbNWeXuQ/vuHQneclY7Vm5ZJktMYPe/KeSwwpu3wftxmlAIp
	 1+/p03QE/jNuyirsduXoezdS5zhlAC6rtKGFIQjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfDYJzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:55:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40522 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfDYJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:55:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so29404395wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ouVX7DLtQR+TSPnOB9BUOPib5uiKvZBg++0sPW/v4gE=;
        b=Xyvp+dfhww1WMbugWM08fm5oyJfQ+wIKPoCdMy5/ONKkXkHlNV+XZLOEPkycNdN2do
         wyRtmYS6t3ALW+vGuhfpcfhylKnMcYe6E0xduwzdwMPka8vN5YpT8tbdDeMIz2FKamuC
         FHet4fcB3VWAX2UW6ElDdXhh8Wh86rjliHR7rxe3T8nmBI5/kUYAKokSiAwVSC2VV68S
         xCbdKUjHUs7yNGSmyo1MRwmduYGsY9YMwiS5t7gpziXlFBhWE37EdGi4oqoN11Ha/cyK
         0zEQYoe3GEq/pBSf3mv/N8Mwpk4lsZttHC6QA4OVzxdaGAtoCRL4vE7/Px07Bo8BEilM
         2RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ouVX7DLtQR+TSPnOB9BUOPib5uiKvZBg++0sPW/v4gE=;
        b=ldJl+QP/Vza+FEwDQ1uqp33GZSmpe/5hLsZ0+LcgNpBc6K6RlyTvZjGR+/LVTKZLxp
         BN85goprZVzzS6ULu8MozjcrKiu9k95wqPK+LlvoM4I8btH5MYl8CJvz5B6xr4GBexrS
         R0lKFWHypmcfXpzdt+rrXxnLug7ZjYhqoPDgiLKT0w5l85GVbvC8LolZcpSOZYh2j5sW
         SOFj8PMmxHRsaRnax9b6IBLEtmK7jCPPag+WaJwwq+5jzJuOCgznHo+jKhwRGS2c5VTX
         E7rumJeLwNOZOQbbTzdnPZV/cZgH8VuO9wgLGUlERHqHQrmj7X0rvaAZB9o4vM7VPrzo
         coww==
X-Gm-Message-State: APjAAAXDCxIFBndh7vU5FrfD2DdJZJC/wG3uCN/AXoWTk6xCF3oVmsd1
        qHh4kSz4XfhGA/8aiQuhve0=
X-Google-Smtp-Source: APXvYqyp1suasz+reeDqu2oVDxNMpbouFweRJdk2YT+qAB2J5V6DmzM+Dd9vTRpCuBTv6lky9b0Kgg==
X-Received: by 2002:adf:80ec:: with SMTP id 99mr16716387wrl.55.1556186111655;
        Thu, 25 Apr 2019 02:55:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y125sm31917125wmc.39.2019.04.25.02.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:55:10 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:55:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190425095508.GA8387@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.intel@gmail.com> wrote:

> On Wed, Apr 24, 2019 at 10:00 PM Julien Desfossez
> <jdesfossez@digitalocean.com> wrote:
> >
> > On 24-Apr-2019 09:13:10 PM, Aubrey Li wrote:
> > > On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
> > > <vpillai@digitalocean.com> wrote:
> > > >
> > > > Second iteration of the core-scheduling feature.
> > > >
> > > > This version fixes apparent bugs and performance issues in v1. This
> > > > doesn't fully address the issue of core sharing between processes
> > > > with different tags. Core sharing still happens 1% to 5% of the time
> > > > based on the nature of workload and timing of the runnable processes.
> > > >
> > > > Changes in v2
> > > > -------------
> > > > - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
> > >
> > > Thanks to post v2, based on this version, here is my benchmarks result.
> > >
> > > Environment setup
> > > --------------------------
> > > Skylake server, 2 numa nodes, 104 CPUs (HT on)
> > > cgroup1 workload, sysbench (CPU intensive non AVX workload)
> > > cgroup2 workload, gemmbench (AVX512 workload)
> > >
> > > Case 1: task number < CPU num
> > > --------------------------------------------
> > > 36 sysbench threads in cgroup1
> > > 36 gemmbench threads in cgroup2
> > >
> > > core sched off:
> > > - sysbench 95th percentile latency(ms): avg = 4.952, stddev = 0.55342
> > > core sched on:
> > > - sysbench 95th percentile latency(ms): avg = 3.549, stddev = 0.04449
> > >
> > > Due to core cookie matching, sysbench tasks won't be affect by AVX512
> > > tasks, latency has ~28% improvement!!!
> > >
> > > Case 2: task number > CPU number
> > > -------------------------------------------------
> > > 72 sysbench threads in cgroup1
> > > 72 gemmbench threads in cgroup2
> > >
> > > core sched off:
> > > - sysbench 95th percentile latency(ms): avg = 11.914, stddev = 3.259
> > > core sched on:
> > > - sysbench 95th percentile latency(ms): avg = 13.289, stddev = 4.863
> > >
> > > So not only power, now security and performance is a pair of contradictions.
> > > Due to core cookie not matching and forced idle introduced, latency has ~12%
> > > regression.
> > >
> > > Any comments?
> >
> > Would it be possible to post the results with HT off as well ?
> 
> What's the point here to turn HT off? The latency is sensitive to the
> relationship
> between the task number and CPU number. Usually less CPU number, more run
> queue wait time, and worse result.

HT-off numbers are mandatory: turning HT off is by far the simplest way 
to solve the security bugs in these CPUs.

Any core-scheduling solution *must* perform better than HT-off for all 
relevant workloads, otherwise what's the point?

Thanks,

	Ingo
