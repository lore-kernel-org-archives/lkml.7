Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B4CC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24B21881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfIQOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:22:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfIQOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:22:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8884B6D9;
        Tue, 17 Sep 2019 14:22:23 +0000 (UTC)
Message-ID: <1568730466.3329.4.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Quentin Perret <qperret@qperret.net>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, matt@codeblueprint.co.uk,
        viresh.kumar@linaro.org, juri.lelli@redhat.com, pjt@google.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Date:   Tue, 17 Sep 2019 16:27:46 +0200
In-Reply-To: <20190914105708.GA12877@qperret.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
         <20190909024216.5942-2-ggherdovich@suse.cz>
         <20190914105708.GA12877@qperret.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Quentin,

On Sat, 2019-09-14 at 12:57 +0200, Quentin Perret wrote:
> Hi Giovanni
> 
> On Monday 09 Sep 2019 at 04:42:15 (+0200), Giovanni Gherdovich wrote:
> > +static inline long arch_scale_freq_capacity(int cpu)
> > +{
> > +	if (static_cpu_has(X86_FEATURE_APERFMPERF))
> > +		return per_cpu(arch_cpu_freq, cpu);
> 
> So, if this is conditional, perhaps you could also add this check in an
> x86-specific implementation of arch_scale_freq_invariant() ? That would
> guide sugov in the right path (see get_next_freq()) if APERF/MPERF are
> unavailable.
> 
> > +	return 1024 /* SCHED_CAPACITY_SCALE */;
> > +}
>

Good remark. If the cpu doesn't have APERF/MPERF, the choice here is that
freq_curr is constantly equal to freq_max, and the scaling factor is 1 all the
time.

But I'm checking this static_cpu_has() every time I do a frequency update;
arguably schedutil should be smarter and settle such a case once and for all
at boot time.

I'll check what's the cost of static_cpu_has() and if it's non-negligible I'll
do what you suggest (x86-specific version of arch_scale_freq_invariant().


Giovanni
