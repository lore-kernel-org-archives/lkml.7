Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDF7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C06820896
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfCZUt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:49:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbfCZUt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:49:29 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8t0U-00061t-Ei; Tue, 26 Mar 2019 21:49:14 +0100
Date:   Tue, 26 Mar 2019 21:49:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
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
In-Reply-To: <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903262029310.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, Ricardo Neri wrote:
> +/**
> + * get_count() - Get the current count of the HPET timer
> + *
> + * Returns:
> + *
> + * Value of the main counter of the HPET timer

The extra newline is not required IIRC.

    Returns: Value ......

shoud be sufficient and spares a lot of lines all over the place.

> + */
> +static inline unsigned long get_count(void)
> +{
> +	return hpet_readq(HPET_COUNTER);
> +}
> +
> +/**
> + * set_comparator() - Update the comparator in an HPET timer instance
> + * @hdata:	A data structure with the timer instance to update
> + * @cmp:	The value to write in the in the comparator registere
> + *
> + * Returns:
> + *
> + * None

Returns: None is not required and provides no additional value.

I appreciate that you try to document your functions extensively, but please
apply common sense whether it really provides value. Documenting the
obvious is not necessarily an improvement.

> + */
> +static inline void set_comparator(struct hpet_hld_data *hdata,
> +				  unsigned long cmp)
> +{
> +	hpet_writeq(cmp, HPET_Tn_CMP(hdata->num));
> +}

Also do we really need wrappers plus N lines documentation for
hpet_readq/writeq()?

I fail to see the benefit. It's just increasing the line count for no
reason and requires the reader to lookup functions which are just cosmetic
wrappers.

> +/**
> + * hardlockup_detector_nmi_handler() - NMI Interrupt handler
> + * @val:	Attribute associated with the NMI. Not used.
> + * @regs:	Register values as seen when the NMI was asserted
> + *
> + * When in NMI context, check if it was caused by the expiration of the

When in NMI context? This function _IS_ called in NMI context, right?

> + * HPET timer. If yes, create a CPU mask to issue an IPI to the rest
> + * of monitored CPUs. Upon receiving their own NMI, the other CPUs will
> + * check such mask to determine if they need to also look for lockups.
> + *
> + * Returns:
> + *
> + * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
> + * otherwise.
> + */
> +static int hardlockup_detector_nmi_handler(unsigned int val,
> +					   struct pt_regs *regs)
> +{
> +	struct hpet_hld_data *hdata = hld_data;
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (is_hpet_wdt_interrupt(hdata)) {
> +		/* Get ready to check other CPUs for hardlockups. */
> +		cpumask_copy(&hdata->cpu_monitored_mask,
> +			     watchdog_get_allowed_cpumask());
> +		cpumask_clear_cpu(smp_processor_id(),
> +				  &hdata->cpu_monitored_mask);

Why are you copying the mask in NMI context and not updating it when the
watchdog enable/disable functions are called?

Also the mask can contain offline CPUs, which is bad because the send IPI
function expects offline CPUs to be cleared.

Clearing the CPU in the mask is not required because the function you
invoke:

> +		apic->send_IPI_mask_allbutself(&hdata->cpu_monitored_mask,
> +					       NMI_VECTOR);

has it's name for a reason.

> +
> +		kick_timer(hdata, !(hdata->flags & HPET_DEV_PERI_CAP));
> +
> +		inspect_for_hardlockups(regs);
> +
> +		return NMI_HANDLED;
> +	}
> +
> +	if (cpumask_test_and_clear_cpu(cpu, &hdata->cpu_monitored_mask)) {
> +		inspect_for_hardlockups(regs);
> +		return NMI_HANDLED;
> +	}

So if the function above returns false, then why would you try to check
that CPU mask and invoke the inspection? You already cleared that bit
above. This part is pointless and can be removed.

> +void hardlockup_detector_hpet_enable(void)
> +{
> +	struct cpumask *allowed = watchdog_get_allowed_cpumask();
> +	unsigned int cpu = smp_processor_id();

This is called from a function which has already a cpu argument. Why aren't
you handing that in?

> +
> +	if (!hld_data)
> +		return;

Why can hld_data be NULL here?

> +
> +	hld_data->handling_cpu = cpumask_first(allowed);
> +
> +	if (cpu == hld_data->handling_cpu) {
> +		update_handling_cpu(hld_data);
> +		/* Force timer kick when detector is just enabled */
> +		kick_timer(hld_data, true);
> +		enable_timer(hld_data);
> +	}

That logic is wrong. The per cpu enable function is called via:

  softlockup_start_all()
    for_each_cpu(cpu, &watchdog_allowed_mask)
       smp_call_on_cpu(cpu, softlockup_start_fn, NULL, false);

       ---> softlockup_start_fn()
               watchdog_enable()

OR

  lockup_detector_online_cpu()
    watchdog_enable()

The latter is a CPU hotplug operation. The former is invoked when the
watchdog is (re)configured in the core code. Both are mutually exclusive
and guarantee to never invoke the function concurrently on multiple CPUs.

So way you should handle this is:

	cpumask_set_cpu(cpu, hld_data->cpu_monitored_mask);

	if (!hld_data->enabled_cpus++) {
		hld_data->handling_cpu = cpu;
		kick_timer();
		enable_timer();
	}

The cpu mask starts off empty and each CPU sets itself when the function is
invoked on it.

data->enabled_cpus keeps track of the enabled cpus so you avoid
reconfiguration just because a different cpu comes online. And it's
required for disable as well.

> +void hardlockup_detector_hpet_disable(void)
> +{
> +	struct cpumask *allowed = watchdog_get_allowed_cpumask();
> +
> +	if (!hld_data)
> +		return;
> +
> +	/* Only disable the timer if there are no more CPUs to monitor. */
> +	if (!cpumask_weight(allowed))
> +		disable_timer(hld_data);

Again this should be:

	cpumask_clear_cpu(cpu, hld_data->cpu_monitored_mask);
	hld_data->enabled_cpus--;

	if (hld_data->handling_cpu != cpu)
		return;

	disable_timer();
	if (hld_data->enabled_cpus)
		return;

	hld_data->handling_cpu = cpumask_first(hld_data->cpu_monitored_mask);
	enable_timer();

> +}
> +
> +/**
> + * hardlockup_detector_hpet_stop() - Stop the NMI watchdog on all CPUs
> + *
> + * Returns:
> + *
> + * None
> + */
> +void hardlockup_detector_hpet_stop(void)
> +{
> +	disable_timer(hld_data);
> +}

This function is nowhere used.

> +int __init hardlockup_detector_hpet_init(void)
> +{
> +	int ret;
> +
> +	if (!is_hpet_enabled())
> +		return -ENODEV;
> +
> +	if (check_tsc_unstable())

What happens if the TSC becomes unstable _AFTER_ you initialized and
started the HPET watchdog?

Thanks,

	tglx
