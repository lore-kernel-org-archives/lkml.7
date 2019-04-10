Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C37C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDA02133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDJBVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:21:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:24835 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfDJBVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:21:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 18:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="141419860"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 09 Apr 2019 18:21:06 -0700
Date:   Tue, 9 Apr 2019 18:19:57 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 12/14] x86/watchdog/hardlockup/hpet: Determine if
 HPET timer caused NMI
Message-ID: <20190410011957.GC10062@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20190409112817.GT4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409112817.GT4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 01:28:17PM +0200, Peter Zijlstra wrote:
> On Wed, Feb 27, 2019 at 08:05:16AM -0800, Ricardo Neri wrote:
> > @@ -62,7 +67,18 @@ static inline void set_comparator(struct hpet_hld_data *hdata,
> >  static void kick_timer(struct hpet_hld_data *hdata, bool force)
> >  {
> >  	bool kick_needed = force || !(hdata->flags & HPET_DEV_PERI_CAP);
> > -	unsigned long new_compare, count;
> > +	unsigned long tsc_curr, tsc_delta, new_compare, count;
> > +
> > +	/* Start obtaining the current TSC and HPET counts. */
> > +	tsc_curr = rdtsc();
> > +
> > +	if (kick_needed)
> > +		count = get_count();
> > +
> > +	tsc_delta = (unsigned long)watchdog_thresh * (unsigned long)tsc_khz
> > +		    * 1000L;
> > +	hdata->tsc_next = tsc_curr + tsc_delta;
> > +	hdata->tsc_next_error = tsc_delta >> 6;
> 
> What do we need a per hld_data tsc_next_error for? It is basically a
> global 'constant'.
> 

This is true. I thought I'd keep all the needed variables in a single
struct to make the code more readable. I guess, I did not achieve that
goal. I'll put it as a static global variable.

> >  	/*
> >  	 * Update the comparator in increments of watch_thresh seconds relative
> > @@ -74,8 +90,6 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
> >  	 */
> >  
> >  	if (kick_needed) {
> > -		count = get_count();
> > -
> >  		new_compare = count + watchdog_thresh * hdata->ticks_per_second;
> >  
> >  		set_comparator(hdata, new_compare);
> > @@ -147,6 +161,14 @@ static void set_periodic(struct hpet_hld_data *hdata)
> >   */
> >  static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
> >  {
> > +	if (smp_processor_id() == hdata->handling_cpu) {
> > +		unsigned long tsc_curr;
> 
> TSC is u64

In x86_64, isn't u64 an unsigned long? Do you mean to consider the
32-bit case?

> 
> > +
> > +		tsc_curr = rdtsc();
> > +		if (abs(tsc_curr - hdata->tsc_next) < hdata->tsc_next_error)
> > +			return true;
> 
> You can write that as:
> 
> 		(tsc_curr - hdata->tsc_next) + tsc_error < 2*tsc_error
> 
> which doesn't contain any branches what so ever.
> 

Sure, I'll add this change.

Thanks and BR,
Ricardo
