Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97173C46477
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B242183F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfFRWsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:48:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:51598 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfFRWsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:48:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 15:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="scan'208";a="160196241"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2019 15:48:22 -0700
Date:   Tue, 18 Jun 2019 15:48:00 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v4 03/21] x86/hpet: Calculate ticks-per-second in a
 separate function
Message-ID: <20190618224800.GD30488@ranerica-svr.sc.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1558660583-28561-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1906141749330.1722@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906141749330.1722@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 05:54:05PM +0200, Thomas Gleixner wrote:
> On Thu, 23 May 2019, Ricardo Neri wrote:
> >  
> > +u64 hpet_get_ticks_per_sec(u64 hpet_caps)
> > +{
> > +	u64 ticks_per_sec, period;
> > +
> > +	period = (hpet_caps & HPET_COUNTER_CLK_PERIOD_MASK) >>
> > +		 HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> > +
> > +	/*
> > +	 * The frequency is the reciprocal of the period. The period is given
> > +	 * in femtoseconds per second. Thus, prepare a dividend to obtain the
> > +	 * frequency in ticks per second.
> > +	 */
> > +
> > +	/* 10^15 femtoseconds per second */
> > +	ticks_per_sec = 1000000000000000ULL;
> > +	ticks_per_sec += period >> 1; /* round */
> > +
> > +	/* The quotient is put in the dividend. We drop the remainder. */
> > +	do_div(ticks_per_sec, period);
> > +
> > +	return ticks_per_sec;
> > +}
> > +
> >  int hpet_alloc(struct hpet_data *hdp)
> >  {
> >  	u64 cap, mcfg;
> > @@ -844,7 +867,6 @@ int hpet_alloc(struct hpet_data *hdp)
> >  	struct hpets *hpetp;
> >  	struct hpet __iomem *hpet;
> >  	static struct hpets *last;
> > -	unsigned long period;
> >  	unsigned long long temp;
> >  	u32 remainder;
> >  
> > @@ -894,12 +916,7 @@ int hpet_alloc(struct hpet_data *hdp)
> >  
> >  	last = hpetp;
> >  
> > -	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> > -		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> > -	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
> > -	temp += period >> 1; /* round */
> > -	do_div(temp, period);
> > -	hpetp->hp_tick_freq = temp; /* ticks per second */
> > +	hpetp->hp_tick_freq = hpet_get_ticks_per_sec(cap);
> 
> Why are we actually computing this over and over?
> 
> In hpet_enable() which is the first function invoked we have:
> 
>         /*
>          * The period is a femto seconds value. Convert it to a
>          * frequency.
>          */
>         freq = FSEC_PER_SEC;
>         do_div(freq, hpet_period);
>         hpet_freq = freq;
> 
> So we already have ticks per second, aka frequency, right? So why do we
> need yet another function instead of using the value which is computed
> once? The frequency of the HPET channels has to be identical no matter
> what. If it's not HPET is broken beyond repair.

I don't think it needs to be recomputed again. I missed the fact that
the frequency was already computed here.

Also, the hpet char driver has its own frequency computation. Perhaps it
could also obtain it from here, right?

Thanks and BR,
Ricardo
> 
> Thanks,
> 
> 	tglx
> 
> 
