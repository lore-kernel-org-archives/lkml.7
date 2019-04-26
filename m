Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0F5206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272008;
	bh=w7QOTyi6ZFjiRjLlZwXAwT10rAZ2o0LAJoxCqoB66Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sq9POJ5IqSChjvlnATTIUuFIdlJvPm8PGEMPikniDt6MAZzmJ1NJ+PAKjqEVNmFdA
	 /HAmHXx8Q50hMHtu9oF+6M2iWWhCUUE3FK8Z+1lq6W65eUYnIqbecZQg9cxQq7v3MX
	 RhSrTIToiSfGKrhXfv27oqXHStERSHz8llH7L4F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDZJqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:46:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46366 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDZJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:45:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so3482083wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eaJiPLeHd+s83MgD/3Fmktbq/gtm4kNAtMchl1QcyoI=;
        b=V/vHwgvCj9WPXHqOzniwQl6WhblT0Dq8n9BUmzk278lU6HWIJ5LD0vVfMkyL82Mf66
         QnTaKArUoDizhJ47lvB2arjpDM97JzI2NMly9zHuE4JYx2az5PS2ej445V4fgmicEMxd
         MgTL3EDhJZT66+ennlgBUBHhgod4u+Vpoue0VmsaygC6vskrP1ei31Sg/tBMpvaWKPrR
         hfvuCSyvuLuiUg9ArLM5aYuFyFMt9B/lXkK0r7n/3CY3Gkag6XbYHAF7QwhocC8lay7S
         n7FKrokga7/EQSKHqq5ZLxz6AkeyZa5a0qHVhjRSWvltFkTvLygQAAG875BgN9cEVLvx
         oSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eaJiPLeHd+s83MgD/3Fmktbq/gtm4kNAtMchl1QcyoI=;
        b=IlmYtl5fhipxiPKReVVJXiGqgK7Af5fg7S/NfrIvW2TAm51bPSpHRmE4zJi8/8EN0N
         kHbAe9ggwWpgLk5jO/n+OJU9lAER4L9XOCWI+ahE7sYWWc/V/hUNOmuKSBAsXqNfjCw/
         9ZCccvHDIiYx0HIVqM3Iz2ZnbKBX4Y4nMSm6VI9ogwJCaBozA+IH8PTFtnnG3E0iHr6Z
         pif64UB9NyF8c8zduRTs1JaRDEFm9XuDyycAlNum2bdG4oxn8EFlFV4J2rsEVg6hkz1r
         juRIuR8EaeLDiUdHQvPmBUnJOZa36zyrsIdSNHESTMHBseNEtRlmz5xhhaPI3H5fZy3m
         kx4g==
X-Gm-Message-State: APjAAAXGfKLbX3rAXj7+Uu29lOFYMTA0ns+XC/8L+amFg3XrM9h4+Up4
        Eev2pEW48vgu6NI3EvIuRZk=
X-Google-Smtp-Source: APXvYqyoJTBqQfQc9AeSIpsbHkeSJM/4esLqud/HAdW6Vq3PLGw4Jas0+w5lkV+FO5EUWm3H7H0Xlw==
X-Received: by 2002:adf:f709:: with SMTP id r9mr624986wrp.89.1556271949129;
        Fri, 26 Apr 2019 02:45:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 204sm30841621wmc.1.2019.04.26.02.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 02:45:48 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:45:45 +0200
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
Message-ID: <20190426094545.GD126896@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <20190425213145.GY18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425213145.GY18914@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> > > I can show a comparison with equal levels of parallelisation but with 
> > > HT off, it is a completely broken configuration and I do not think a 
> > > comparison like that makes any sense.
> > 
> > I would still be interested in that comparison, because I'd like
> > to learn whether there's any true *inherent* performance advantage to 
> > HyperThreading for that particular workload, for exactly tuned 
> > parallelism.
> > 
> 
> It really isn't a fair comparison. MPI seems to behave very differently
> when a machine is saturated. It's documented as changing its behaviour
> as it tries to avoid the worst consequences of saturation.
> 
> Curiously, the results on the 2-socket machine were not as bad as I
> feared when the HT configuration is running with twice the number of
> threads as there are CPUs
> 
> Amean     bt      771.15 (   0.00%)     1086.74 * -40.93%*
> Amean     cg      445.92 (   0.00%)      543.41 * -21.86%*
> Amean     ep       70.01 (   0.00%)       96.29 * -37.53%*
> Amean     is       16.75 (   0.00%)       21.19 * -26.51%*
> Amean     lu      882.84 (   0.00%)      595.14 *  32.59%*
> Amean     mg       84.10 (   0.00%)       80.02 *   4.84%*
> Amean     sp     1353.88 (   0.00%)     1384.10 *  -2.23%*

Yeah, so what I wanted to suggest is a parallel numeric throughput test 
with few inter-process data dependencies, and see whether HT actually 
improves total throughput versus the no-HT case.

No over-saturation - but exactly as many threads as logical CPUs.

I.e. with 20 physical cores and 40 logical CPUs the numbers to compare 
would be a 'nosmt' benchmark running 20 threads, versus a SMT test 
running 40 threads.

I.e. how much does SMT improve total throughput when the workload's 
parallelism is tuned to utilize 100% of the available CPUs?

Does this make sense?

Thanks,

	Ingo
