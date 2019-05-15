Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C532CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B93A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfEOP5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:57:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:24524 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOP5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:57:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 08:57:44 -0700
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2019 08:57:43 -0700
Date:   Wed, 15 May 2019 08:56:04 -0700
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
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFC PATCH v3 04/21] x86/hpet: Add hpet_set_comparator() for
 periodic and one-shot modes
Message-ID: <20190515155604.GB10526@ranerica-svr.sc.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1557842534-4266-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <3c82f3e0-999c-b389-aa9b-f06919800bb4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c82f3e0-999c-b389-aa9b-f06919800bb4@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 07:24:38AM -0700, Randy Dunlap wrote:
> On 5/14/19 7:01 AM, Ricardo Neri wrote:
> > Instead of setting the timer period directly in hpet_set_periodic(), add a
> > new helper function hpet_set_comparator() that only sets the accumulator
> > and comparator. hpet_set_periodic() will only prepare the timer for
> > periodic mode and leave the expiration programming to
> > hpet_set_comparator().
> > 
> > This new function can also be used by other components (e.g., the HPET-
> > based hardlockup detector) which also need to configure HPET timers. Thus,
> > add its declaration into the hpet header file.
> > 
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Andi Kleen <andi.kleen@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: x86@kernel.org
> > Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  arch/x86/include/asm/hpet.h |  1 +
> >  arch/x86/kernel/hpet.c      | 57 ++++++++++++++++++++++++++++---------
> >  2 files changed, 45 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> > index f132fbf984d4..e7098740f5ee 100644
> > --- a/arch/x86/include/asm/hpet.h
> > +++ b/arch/x86/include/asm/hpet.h
> > @@ -102,6 +102,7 @@ extern int hpet_rtc_timer_init(void);
> >  extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
> >  extern int hpet_register_irq_handler(rtc_irq_handler handler);
> >  extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
> > +extern void hpet_set_comparator(int num, unsigned int cmp, unsigned int period);
> >  
> >  #endif /* CONFIG_HPET_EMULATE_RTC */
> >  
> > diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> > index 560fc28e1d13..c5c5fc150193 100644
> > --- a/arch/x86/kernel/hpet.c
> > +++ b/arch/x86/kernel/hpet.c
> > @@ -289,6 +289,46 @@ static void hpet_legacy_clockevent_register(void)
> >  	printk(KERN_DEBUG "hpet clockevent registered\n");
> >  }
> >  
> > +/**
> > + * hpet_set_comparator() - Helper function for setting comparator register
> > + * @num:	The timer ID
> > + * @cmp:	The value to be written to the comparator/accumulator
> > + * @period:	The value to be written to the period (0 = oneshot mode)
> > + *
> > + * Helper function for updating comparator, accumulator and period values.
> > + *
> > + * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
> > + * to the Tn_CMP to update the accumulator. Then, HPET needs a second
> > + * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
> > + * The HPET_TN_SETVAL bit is automatically cleared after the first write.
> > + *
> > + * For one-shot mode, HPET_TN_SETVAL does not need to be set.
> > + *
> > + * See the following documents:
> > + *   - Intel IA-PC HPET (High Precision Event Timers) Specification
> > + *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
> > + */
> > +void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
> > +{
> > +	if (period) {
> > +		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
> > +
> > +		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
> > +	}
> > +
> > +	hpet_writel(cmp, HPET_Tn_CMP(num));
> > +
> > +	if (!period)
> > +		return;
> > +
> > +	/* This delay is seldom used: never in one-shot mode and in periodic
> > +	 * only when reprogramming the timer.
> > +	 */
> 
> comment style warning ;)
>

Uh! I'll correct this. Strangely, I reran checkpatch and it didn't catch
it.

Thanks and BR,
Ricardo
