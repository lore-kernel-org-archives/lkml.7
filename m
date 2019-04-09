Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE00DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EBB213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDICDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:03:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:35742 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDICDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:03:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 19:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149195224"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 19:03:28 -0700
Date:   Mon, 8 Apr 2019 19:02:19 -0700
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20190409020219.GA6974@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262029310.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262029310.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:49:13PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Ricardo Neri wrote:
> > +/**
> > + * get_count() - Get the current count of the HPET timer
> > + *
> > + * Returns:
> > + *
> > + * Value of the main counter of the HPET timer
> 
> The extra newline is not required IIRC.
> 
>     Returns: Value ......
> 
> shoud be sufficient and spares a lot of lines all over the place.
> 

Many thanks for your review!

I checked the documentation again and the extra line is not needed. I'll
remove it.

> > + */
> > +static inline unsigned long get_count(void)
> > +{
> > +	return hpet_readq(HPET_COUNTER);
> > +}
> > +
> > +/**
> > + * set_comparator() - Update the comparator in an HPET timer instance
> > + * @hdata:	A data structure with the timer instance to update
> > + * @cmp:	The value to write in the in the comparator registere
> > + *
> > + * Returns:
> > + *
> > + * None
> 
> Returns: None is not required and provides no additional value.
> 
> I appreciate that you try to document your functions extensively, but please
> apply common sense whether it really provides value. Documenting the
> obvious is not necessarily an improvement.

Sure, I'll limit function documentation to places where it makes sense.

> 
> > + */
> > +static inline void set_comparator(struct hpet_hld_data *hdata,
> > +				  unsigned long cmp)
> > +{
> > +	hpet_writeq(cmp, HPET_Tn_CMP(hdata->num));
> > +}
> 
> Also do we really need wrappers plus N lines documentation for
> hpet_readq/writeq()?
> 
> I fail to see the benefit. It's just increasing the line count for no
> reason and requires the reader to lookup functions which are just cosmetic
> wrappers.

I'll remove the wrapper for set_comparator() and get_count() as well as
their documentation. These are the simplest wrappers. Is this
acceptable?

> 
> > +/**
> > + * hardlockup_detector_nmi_handler() - NMI Interrupt handler
> > + * @val:	Attribute associated with the NMI. Not used.
> > + * @regs:	Register values as seen when the NMI was asserted
> > + *
> > + * When in NMI context, check if it was caused by the expiration of the
> 
> When in NMI context? This function _IS_ called in NMI context, right?
> 

Yes, this wording is incorrect. I'll remove the "When in NMI context"
part.

> > + * HPET timer. If yes, create a CPU mask to issue an IPI to the rest
> > + * of monitored CPUs. Upon receiving their own NMI, the other CPUs will
> > + * check such mask to determine if they need to also look for lockups.
> > + *
> > + * Returns:
> > + *
> > + * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
> > + * otherwise.
> > + */
> > +static int hardlockup_detector_nmi_handler(unsigned int val,
> > +					   struct pt_regs *regs)
> > +{
> > +	struct hpet_hld_data *hdata = hld_data;
> > +	unsigned int cpu = smp_processor_id();
> > +
> > +	if (is_hpet_wdt_interrupt(hdata)) {
> > +		/* Get ready to check other CPUs for hardlockups. */
> > +		cpumask_copy(&hdata->cpu_monitored_mask,
> > +			     watchdog_get_allowed_cpumask());
> > +		cpumask_clear_cpu(smp_processor_id(),
> > +				  &hdata->cpu_monitored_mask);
> 
> Why are you copying the mask in NMI context and not updating it when the
> watchdog enable/disable functions are called?

I think I need two CPU masks for this implementation. A mask is used to
track what CPUs need to be monitored at any given time; I use
watchdog_allowed_mask from kernel/watchdog.c for that.

Separately, I need to prepare a CPU mask to determine which CPUs should be
targeted in the IPI; I use hdata->cpu_monitored_mask for this. This mask will
remain clear most of the time. As soon as CPUs receive their own IPI,
they must clear themselves from this mask. This to prevent them from
incorrectly handling unrelated NMIs; as would be the case if it relied on
watchdog_allowed_mask.

> 
> Also the mask can contain offline CPUs, which is bad because the send IPI
> function expects offline CPUs to be cleared.
> 
> Clearing the CPU in the mask is not required because the function you
> invoke:
> 
> > +		apic->send_IPI_mask_allbutself(&hdata->cpu_monitored_mask,
> > +					       NMI_VECTOR);
> 
> has it's name for a reason.
> 

I think it still needs to be cleared. While it may not receive an IPI
from this call, an unrelated NMI may happen and it will incorrectly invoke
inspection as it found its bit in the CPU mask set.

> > +
> > +		kick_timer(hdata, !(hdata->flags & HPET_DEV_PERI_CAP));
> > +
> > +		inspect_for_hardlockups(regs);
> > +
> > +		return NMI_HANDLED;
> > +	}
> > +
> > +	if (cpumask_test_and_clear_cpu(cpu, &hdata->cpu_monitored_mask)) {
> > +		inspect_for_hardlockups(regs);
> > +		return NMI_HANDLED;
> > +	}
> 
> So if the function above returns false, then why would you try to check
> that CPU mask and invoke the inspection? You already cleared that bit
> above. This part is pointless and can be removed.
> 

Do you mean is_hpet_wdt_interrupt()? Such function only returns true if it
determines that the HPET caused an NMI in the handling_cpu. The goal is that
the first block only handles an NMI caused by the HPET and the second block only
handles the NMI IPI issued by send_IPI_mask_allbutself() in the first
block.

Also, using IPIs may not be the best approach if we have to send them across
packages as they can be rather costly. Instead, I plan to go back to my initial
proposal of targeting each online CPU separately in a round robin fashion
instead of having a single CPU handling the HPET interrupt and issuing
IPIs.

> > +void hardlockup_detector_hpet_enable(void)
> > +{
> > +	struct cpumask *allowed = watchdog_get_allowed_cpumask();
> > +	unsigned int cpu = smp_processor_id();
> 
> This is called from a function which has already a cpu argument. Why aren't
> you handing that in?
> 

But it could also be called from watchdog_nmi_stop(), which does not
take a cpu as argument. Perhaps watchdog_nmi_stop() does not need to be
implemented as in addition to it watchdog_nmi_disable() is called on all
CPUs when stopping or reconfiguring the watchdog.

> > +
> > +	if (!hld_data)
> > +		return;
> 
> Why can hld_data be NULL here?

It cannot. It could only be null if, for instance HPET was disabled or
not available. These cases cause hardlockup_detector_hpet_init() to
fail and the NMI watchdog falls back to the perf implementation.

I'll remove this check.

> 
> > +
> > +	hld_data->handling_cpu = cpumask_first(allowed);
> > +
> > +	if (cpu == hld_data->handling_cpu) {
> > +		update_handling_cpu(hld_data);
> > +		/* Force timer kick when detector is just enabled */
> > +		kick_timer(hld_data, true);
> > +		enable_timer(hld_data);
> > +	}
> 
> That logic is wrong. The per cpu enable function is called via:
> 
>   softlockup_start_all()
>     for_each_cpu(cpu, &watchdog_allowed_mask)
>        smp_call_on_cpu(cpu, softlockup_start_fn, NULL, false);
> 
>        ---> softlockup_start_fn()
>                watchdog_enable()
> 
> OR
> 
>   lockup_detector_online_cpu()
>     watchdog_enable()
> 
> The latter is a CPU hotplug operation. The former is invoked when the
> watchdog is (re)configured in the core code. Both are mutually exclusive
> and guarantee to never invoke the function concurrently on multiple CPUs.
> 
> So way you should handle this is:
> 
> 	cpumask_set_cpu(cpu, hld_data->cpu_monitored_mask);
> 
> 	if (!hld_data->enabled_cpus++) {
> 		hld_data->handling_cpu = cpu;
> 		kick_timer();
> 		enable_timer();
> 	}
> 
> The cpu mask starts off empty and each CPU sets itself when the function is
> invoked on it.
> 
> data->enabled_cpus keeps track of the enabled cpus so you avoid
> reconfiguration just because a different cpu comes online. And it's
> required for disable as well.
> 
> > +void hardlockup_detector_hpet_disable(void)
> > +{
> > +	struct cpumask *allowed = watchdog_get_allowed_cpumask();
> > +
> > +	if (!hld_data)
> > +		return;
> > +
> > +	/* Only disable the timer if there are no more CPUs to monitor. */
> > +	if (!cpumask_weight(allowed))
> > +		disable_timer(hld_data);
> 
> Again this should be:
> 
> 	cpumask_clear_cpu(cpu, hld_data->cpu_monitored_mask);
> 	hld_data->enabled_cpus--;
> 
> 	if (hld_data->handling_cpu != cpu)
> 		return;
> 
> 	disable_timer();
> 	if (hld_data->enabled_cpus)
> 		return;
> 
> 	hld_data->handling_cpu = cpumask_first(hld_data->cpu_monitored_mask);
> 	enable_timer();
>

Sure. I will update the impelementation with this suggestion in both
hardlockup_detector_hpet_disable() and
hardlockup_detector_hpet_enable().

> > +}
> > +
> > +/**
> > + * hardlockup_detector_hpet_stop() - Stop the NMI watchdog on all CPUs
> > + *
> > + * Returns:
> > + *
> > + * None
> > + */
> > +void hardlockup_detector_hpet_stop(void)
> > +{
> > +	disable_timer(hld_data);
> > +}
> 
> This function is nowhere used.
> 

Actually, thanks to this comment I found a bug in my patches. This
function should be called from watchdog_nmi_stop().

> > +int __init hardlockup_detector_hpet_init(void)
> > +{
> > +	int ret;
> > +
> > +	if (!is_hpet_enabled())
> > +		return -ENODEV;
> > +
> > +	if (check_tsc_unstable())
> 
> What happens if the TSC becomes unstable _AFTER_ you initialized and
> started the HPET watchdog?

I had not considered such case. Probably it will need to be disabled and
switch to the perf implementation?

Thanks and BR,
Ricardo
