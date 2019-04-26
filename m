Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABDFC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB84206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272310;
	bh=zu39KrqVScXSYJ2V8oF1ct0hrigrxYzWcE5ZsUBZE/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZEuPAYhpxsSRMj4K3pYr5m3GC8PbenR7USesyQe4SYVCcBmMPp1ZJL/gZ8q7agri4
	 1tSF1eHhNuZ1uxhK2RXzB/UCZNTpX1P+EZ950KcAtIbz7kgp/X0VKbCHy6nJPPY+v8
	 m5+AlgGpTWs7CiM4VdNKSmvrTCkrtYO83rFnXFcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfDZJvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:51:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40489 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:51:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so3454644wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NLJ08Ufr1QVxZuFD/lFtwOIQE4Cp4+A0n25EKyxM2OM=;
        b=TLkxn4TEKm9gZ4iYB8i8g3meZLx+59eMI6dN40tU1eLICJOguiL2gGj/4k4LSXDB5a
         lTVcRTQMNepYYkJenv4QVfmA372DXtY8FnDZCUFZ2t5esrQY4dcgl1PVLjCPBtFviWLj
         J754QVTTVS95etgt5Trbeneatwcw7FZdHFiI+Hy6gndC0ICr9boL8qe1q7Zd6LIZvabw
         jcbfpnuEUolGoyIhbJ2QIiHC7plrTtV7x6IFK0tsWvT4ZEe9mNmq+wgYp7RxfWvoSNrx
         TjUeTv4ZMMrbX8bQWDmI0slGGYa+8mojM6lxXlhqNwLu873IiXr12iXKviRtdVzCKA71
         FgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NLJ08Ufr1QVxZuFD/lFtwOIQE4Cp4+A0n25EKyxM2OM=;
        b=RZiV4yENOcQ2A7bn2NvN9pg7m6HogvDsU6O12egF8C7Un+KOZsNS2PtDDlO8VA7wnx
         2CCEkK0EO1W/0U4QFDcwo57SJcaMxQFTQ8g/ZMa/L3jw1mNxbDc9141/VpuKQLz0Qd+4
         By6rOxny65BS2hHiojgwsO8tiwlzz8RQFOT6OxqBaZp+xrnzJEKjK2U5XQtNNEhF6HFa
         k7M/y23eo+ZBi5Vuzc685BAe+y1HHNVycofRDR0LShQA3OwhZGMP1zSHMFgH5km0UwqJ
         p59MbY6aoX3E1GfBWH5EZIqAsiKSurvN506VlcLfhugkRs7Mr4qqFUvqnnyQa/5Jxilv
         HcrA==
X-Gm-Message-State: APjAAAW2ZgbZtwzpSemo7qYJV4830rLS+9GQdBgWafSPVGYvuVRZzooF
        1dcPQzEAqTBQiFAv+5j+WUuSOW3L
X-Google-Smtp-Source: APXvYqy1FChLnu7+RrMHZKVbssU5sKkHm32W0qKG9RZkacLC+ijZWLeslTL8NWtvEDoi56yv8JMCAA==
X-Received: by 2002:a1c:ef10:: with SMTP id n16mr7427255wmh.70.1556272306313;
        Fri, 26 Apr 2019 02:51:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z140sm49096201wmc.27.2019.04.26.02.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 02:51:45 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:51:43 +0200
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
Message-ID: <20190426095143.GF126896@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <CAERHkruMnwsD0iE1rQQGR3Zv1G+xbOBPODcgXz1fPn0kNRHsxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkruMnwsD0iE1rQQGR3Zv1G+xbOBPODcgXz1fPn0kNRHsxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.intel@gmail.com> wrote:

> On Thu, Apr 25, 2019 at 5:55 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Aubrey Li <aubrey.intel@gmail.com> wrote:
> >
> > > On Wed, Apr 24, 2019 at 10:00 PM Julien Desfossez
> > > <jdesfossez@digitalocean.com> wrote:
> > > >
> > > > On 24-Apr-2019 09:13:10 PM, Aubrey Li wrote:
> > > > > On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
> > > > > <vpillai@digitalocean.com> wrote:
> > > > > >
> > > > > > Second iteration of the core-scheduling feature.
> > > > > >
> > > > > > This version fixes apparent bugs and performance issues in v1. This
> > > > > > doesn't fully address the issue of core sharing between processes
> > > > > > with different tags. Core sharing still happens 1% to 5% of the time
> > > > > > based on the nature of workload and timing of the runnable processes.
> > > > > >
> > > > > > Changes in v2
> > > > > > -------------
> > > > > > - rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
> > > > >
> > > > > Thanks to post v2, based on this version, here is my benchmarks result.
> > > > >
> > > > > Environment setup
> > > > > --------------------------
> > > > > Skylake server, 2 numa nodes, 104 CPUs (HT on)
> > > > > cgroup1 workload, sysbench (CPU intensive non AVX workload)
> > > > > cgroup2 workload, gemmbench (AVX512 workload)
> > > > >
> > > > > Case 1: task number < CPU num
> > > > > --------------------------------------------
> > > > > 36 sysbench threads in cgroup1
> > > > > 36 gemmbench threads in cgroup2
> > > > >
> > > > > core sched off:
> > > > > - sysbench 95th percentile latency(ms): avg = 4.952, stddev = 0.55342
> > > > > core sched on:
> > > > > - sysbench 95th percentile latency(ms): avg = 3.549, stddev = 0.04449
> > > > >
> > > > > Due to core cookie matching, sysbench tasks won't be affect by AVX512
> > > > > tasks, latency has ~28% improvement!!!
> > > > >
> > > > > Case 2: task number > CPU number
> > > > > -------------------------------------------------
> > > > > 72 sysbench threads in cgroup1
> > > > > 72 gemmbench threads in cgroup2
> > > > >
> > > > > core sched off:
> > > > > - sysbench 95th percentile latency(ms): avg = 11.914, stddev = 3.259
> > > > > core sched on:
> > > > > - sysbench 95th percentile latency(ms): avg = 13.289, stddev = 4.863
> > > > >
> > > > > So not only power, now security and performance is a pair of contradictions.
> > > > > Due to core cookie not matching and forced idle introduced, latency has ~12%
> > > > > regression.
> > > > >
> > > > > Any comments?
> > > >
> > > > Would it be possible to post the results with HT off as well ?
> > >
> > > What's the point here to turn HT off? The latency is sensitive to the
> > > relationship
> > > between the task number and CPU number. Usually less CPU number, more run
> > > queue wait time, and worse result.
> >
> > HT-off numbers are mandatory: turning HT off is by far the simplest way
> > to solve the security bugs in these CPUs.
> >
> > Any core-scheduling solution *must* perform better than HT-off for all
> > relevant workloads, otherwise what's the point?
> >
> Got it, I'll measure HT-off cases soon.

Thanks!

	Ingo
