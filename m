Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D8C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA322084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfEOP4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:56:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:23199 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOP4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:56:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 08:56:06 -0700
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2019 08:56:04 -0700
Date:   Wed, 15 May 2019 08:54:26 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFC PATCH v3 03/21] x86/hpet: Calculate ticks-per-second in a
 separate function
Message-ID: <20190515155426.GA10526@ranerica-svr.sc.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1557842534-4266-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <25922025-d551-0865-b364-b53ef34e6b6a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25922025-d551-0865-b364-b53ef34e6b6a@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 07:23:47AM -0700, Randy Dunlap wrote:
> On 5/14/19 7:01 AM, Ricardo Neri wrote:
> > It is easier to compute the expiration times of an HPET timer by using
> > its frequency (i.e., the number of times it ticks in a second) than its
> > period, as given in the capabilities register.
> > 
> > In addition to the HPET char driver, the HPET-based hardlockup detector
> > will also need to know the timer's frequency. Thus, create a common
> > function that both can use.
> > 
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Andi Kleen <andi.kleen@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Clemens Ladisch <clemens@ladisch.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: x86@kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  drivers/char/hpet.c  | 31 ++++++++++++++++++++++++-------
> >  include/linux/hpet.h |  1 +
> >  2 files changed, 25 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> > index d0ad85900b79..bdcbecfdb858 100644
> > --- a/drivers/char/hpet.c
> > +++ b/drivers/char/hpet.c
> > @@ -836,6 +836,29 @@ static unsigned long hpet_calibrate(struct hpets *hpetp)
> >  	return ret;
> >  }
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
> > +	 * femtoseconds per second. Thus, prepare a dividend to obtain the
> 
> 	 * in femtoseconds per second.
> 

Thanks for your review Randy! I'll fix this grammar issue.
> > +	 * frequency in ticks per second.
> > +	 */
> > +
> > +	/* 10^15 femtoseconds per second */
> > +	ticks_per_sec = 1000000000000000uLL;
> 
> 	ULL is overwhelmingly used in the kernel.
> 

Sure, I'll update it.

BR,
Ricardo
