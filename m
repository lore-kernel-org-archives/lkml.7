Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E205BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB860213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDICFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:05:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:35825 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDICFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:05:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 19:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="221741953"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 19:05:14 -0700
Date:   Mon, 8 Apr 2019 19:04:05 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v2 03/14] x86/hpet: Calculate ticks-per-second in a
 separate function
Message-ID: <20190409020405.GA7070@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262201140.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262201140.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:03:02PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Ricardo Neri wrote:
> >  int hpet_alloc(struct hpet_data *hdp)
> >  {
> >  	u64 cap, mcfg;
> > @@ -845,7 +868,6 @@ int hpet_alloc(struct hpet_data *hdp)
> >  	size_t siz;
> >  	struct hpet __iomem *hpet;
> >  	static struct hpets *last;
> > -	unsigned long period;
> >  	unsigned long long temp;
> >  	u32 remainder;
> >  
> > @@ -881,6 +903,8 @@ int hpet_alloc(struct hpet_data *hdp)
> >  
> >  	cap = readq(&hpet->hpet_cap);
> >  
> > +	temp = hpet_get_ticks_per_sec(cap);
> 
> Just putting stuff to random places does not make the code any better.

This seems to not be needed. I'll remove it and directly save the result
in hpetp->hp_tick_freq;

> 
> >  	ntimer = ((cap & HPET_NUM_TIM_CAP_MASK) >> HPET_NUM_TIM_CAP_SHIFT) + 1;
> >  
> >  	if (hpetp->hp_ntimer != ntimer) {
> > @@ -897,11 +921,6 @@ int hpet_alloc(struct hpet_data *hdp)
> >  
> >  	last = hpetp;
> >  
> > -	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> > -		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> > -	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
> > -	temp += period >> 1; /* round */
> > -	do_div(temp, period);
> >  	hpetp->hp_tick_freq = temp; /* ticks per second */
> 
> What's wrong with the obvious:
> 
>        hpetp->hp_tick_freq = hpet_get_ticks_per_sec(cap);
> 
> Hmm?

Nothing wrong. I'll implement this change.

Thanks and BR,
Ricardo
