Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DBBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069E120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDICPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:15:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:2595 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDICPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:15:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 19:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="221743957"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 19:15:48 -0700
Date:   Mon, 8 Apr 2019 19:14:39 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Nayna Jain <nayna@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
Subject: Re: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20190409021439.GA7291@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <b6d0dd2d-4b56-0055-a7e0-51af5c45f959@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d0dd2d-4b56-0055-a7e0-51af5c45f959@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:12:56PM +0000, Suthikulpanit, Suravee wrote:
> Hi Neri,

Hi Suravee,

Many thanks for testing the patches!
> 
> While trying out this patch series, I found that it does not work when the HPET timer
> is in periodic mode.

I should have tested this better. I'll double check my setup.
> 
> On 2/27/19 11:05 PM, Ricardo Neri wrote:
> > ......
> > diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
> > new file mode 100644
> > index 000000000000..cfa284da4bf6
> > --- /dev/null
> > +++ b/arch/x86/kernel/watchdog_hld_hpet.c
> > @@ -0,0 +1,405 @@
> > .....
> > +
> > +/**
> > + * set_comparator() - Update the comparator in an HPET timer instance
> > + * @hdata:	A data structure with the timer instance to update
> > + * @cmp:	The value to write in the in the comparator registere
> > + *
> > + * Returns:
> > + *
> > + * None
> > + */
> > +static inline void set_comparator(struct hpet_hld_data *hdata,
> > +				  unsigned long cmp)
> > +{
> > +	hpet_writeq(cmp, HPET_Tn_CMP(hdata->num));
> > +}
> > +
> > +/**
> > + * kick_timer() - Reprogram timer to expire in the future
> > + * @hdata:	A data structure with the timer instance to update
> > + * @force:	Force reprogram. Useful enabling or re-enabling detector.
> > + *
> > + * Reprogram the timer to expire within watchdog_thresh seconds in the future.
> > + *
> > + * Returns:
> > + *
> > + * None
> > + */
> > +static void kick_timer(struct hpet_hld_data *hdata, bool force)
> > +{
> > +	bool kick_needed = force || !(hdata->flags & HPET_DEV_PERI_CAP);
> > +	unsigned long new_compare, count;
> > +
> > +	/*
> > +	 * Update the comparator in increments of watch_thresh seconds relative
> > +	 * to the current count. Since watch_thresh is given in seconds, we
> > +	 * are able to update the comparator before the counter reaches such new
> > +	 * value.
> > +	 *
> > +	 * Let it wrap around if needed.
> > +	 */
> > +
> > +	if (kick_needed) {
> > +		count = get_count();
> > +
> > +		new_compare = count + watchdog_thresh * hdata->ticks_per_second;
> > +
> > +		set_comparator(hdata, new_compare);
> > +	}
> > +}
> 
> It turns out that the set_comparator() does not seem to support periodic mode,
> in which it should have been setting the accumulator/period via the comparator register.
> 
> Instead, what if we re-factor the code in the arch/x86/kernel/hpet.c:hpet_set_periodic()
> to hpet_set_comparator(). Then we can also reuse it in the arch/x86/kernel/watchdog_hld_pet.c:
> kick_timer() as shown below.
> 
> With these changes, I can test the series on AMD systems, and see all cores
> in /proc/interrupts are receiving NMI interrupts.

These changes look OK to me. Thanks! I'll incorporate them in my next version.

> 
> Regards,
> Suravee
> 
> 
> diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> index 0976334..f30957f 100644
> --- a/arch/x86/include/asm/hpet.h
> +++ b/arch/x86/include/asm/hpet.h
> @@ -115,6 +115,7 @@ extern int hpet_rtc_timer_init(void);
>   extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
>   extern int hpet_register_irq_handler(rtc_irq_handler handler);
>   extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
> +extern void hpet_set_comparator(int num, unsigned int cmp, unsigned int period);
> 
>   #endif /* CONFIG_HPET_EMULATE_RTC */
> 
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 03b05dae..f3b2351 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -328,6 +328,41 @@ static void hpet_legacy_clockevent_register(void)
>   	printk(KERN_DEBUG "hpet clockevent registered\n");
>   }
> 
> +/*
> + * hpet_set_comparator() - Helper function for setting comparator register
> + * @num:	The timer ID
> + * @cmp:	The value to be written to the comparator/accumulator
> + * @period:	The value to be written to the period (0 = oneshot mode)
> + *
> + * Helper function for updating comparator, accumulator and period values.
> + *
> + * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
> + * to the Tn_CMP to update the accumulator. Then, HPET needs a second
> + * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
> + * The HPET_TN_SETVAL bit is automatically cleared after the first write.
> + *
> + * For one-shot mode, HPET_TN_SETVAL does not need to be set.
> + *
> + * See the following documents:
> + *   - Intel IA-PC HPET (High Precision Event Timers) Specification
> + *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
> + */
> +void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
> +{
> +	if (period) {
> +		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
> +		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
> +	}
> +
> +	hpet_writel(cmp, HPET_Tn_CMP(num));
> +	if (!period)
> +		return;
> +
> +	udelay(1);
> +	hpet_writel(period, HPET_Tn_CMP(num));
> +}
> +EXPORT_SYMBOL_GPL(hpet_set_comparator);
> +
>   static int hpet_set_periodic(struct clock_event_device *evt, int timer)
>   {
>   	unsigned int cfg, cmp, now;
> @@ -339,19 +374,11 @@ static int hpet_set_periodic(struct clock_event_device *evt, int timer)
>   	now = hpet_readl(HPET_COUNTER);
>   	cmp = now + (unsigned int)delta;
>   	cfg = hpet_readl(HPET_Tn_CFG(timer));
> -	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
> -	       HPET_TN_32BIT;
> +	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_32BIT;
>   	hpet_writel(cfg, HPET_Tn_CFG(timer));
> -	hpet_writel(cmp, HPET_Tn_CMP(timer));
> -	udelay(1);
> -	/*
> -	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
> -	 * cleared) to T0_CMP to set the period. The HPET_TN_SETVAL
> -	 * bit is automatically cleared after the first write.
> -	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
> -	 * Publication # 24674)
> -	 */
> -	hpet_writel((unsigned int)delta, HPET_Tn_CMP(timer));
> +
> +	hpet_set_comparator(timer, cmp, (unsigned int)delta);
> +
>   	hpet_start_counter();
>   	hpet_print_config();
> 
> diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
> index 4402def..de33c50 100644
> --- a/arch/x86/kernel/watchdog_hld_hpet.c
> +++ b/arch/x86/kernel/watchdog_hld_hpet.c
> @@ -35,21 +35,6 @@ static inline unsigned long get_count(void)
>   }
> 
>   /**
> - * set_comparator() - Update the comparator in an HPET timer instance
> - * @hdata:	A data structure with the timer instance to update
> - * @cmp:	The value to write in the in the comparator registere
> - *
> - * Returns:
> - *
> - * None
> - */
> -static inline void set_comparator(struct hpet_hld_data *hdata,
> -				  unsigned long cmp)
> -{
> -	hpet_writeq(cmp, HPET_Tn_CMP(hdata->num));
> -}
> -
> -/**
>    * kick_timer() - Reprogram timer to expire in the future
>    * @hdata:	A data structure with the timer instance to update
>    * @force:	Force reprogram. Useful enabling or re-enabling detector.
> @@ -68,7 +53,7 @@ static inline void set_comparator(struct hpet_hld_data *hdata,
>   static void kick_timer(struct hpet_hld_data *hdata, bool force)
>   {
>   	bool kick_needed = force || !(hdata->flags & HPET_DEV_PERI_CAP);
> -	unsigned long tsc_curr, tsc_delta, new_compare, count;
> +	unsigned long tsc_curr, tsc_delta, new_compare, count, period = 0;
> 
>   	/* Start obtaining the current TSC and HPET counts. */
>   	tsc_curr = rdtsc();
> @@ -81,6 +66,9 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
>   	hdata->tsc_next = tsc_curr + tsc_delta;
>   	hdata->tsc_next_error = tsc_delta >> 6;
> 
> +	if (!kick_needed)
> +		return;
> +
>   	/*
>   	 * Update the comparator in increments of watch_thresh seconds relative
>   	 * to the current count. Since watch_thresh is given in seconds, we
> @@ -89,12 +77,11 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
>   	 *
>   	 * Let it wrap around if needed.
>   	 */
> +	if (hdata->flags & HPET_DEV_PERI_CAP)
> +		period = watchdog_thresh * hdata->ticks_per_second;
> 
> -	if (kick_needed) {
> -		new_compare = count + watchdog_thresh * hdata->ticks_per_second;
> -
> -		set_comparator(hdata, new_compare);
> -	}
> +	new_compare = count + period;
> +	hpet_set_comparator(hdata->num, new_compare, period);
>   }
> 
>   /**
> -- 
> 2.7.4
