Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79CAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BF8208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfFXDBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:01:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfFXDBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:01:45 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfB9Y-0007Pi-Vw; Mon, 24 Jun 2019 00:40:05 +0200
Date:   Mon, 24 Jun 2019 00:40:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
In-Reply-To: <1560994438-235698-4-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1906232216140.32342@nanos.tec.linutronix.de>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com> <1560994438-235698-4-git-send-email-fenghua.yu@intel.com>
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

On Wed, 19 Jun 2019, Fenghua Yu wrote:
> C0.2 state in umwait and tpause instructions can be enabled or disabled
> on a processor through IA32_UMWAIT_CONTROL MSR register.

  through the IA32....CONTROL MSR.

MSR register, IOW: Machine Specific Register register.

> 
> Andy Lutomirski suggests to turn off local irqs before writing
> MSR_TEST_CTL to ensure msr_test_ctl_cached is not changed by sysfs write

What has MSR_TEST_CTL to do with this?

> +/*
> + * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR
> + * in writing sysfs to ensure all CPUs have the same MSR value.
> + */
> +static DEFINE_MUTEX(umwait_lock);
> +
> +static void update_this_cpu_umwait_control_msr(void)

Why is this not following the umwait_ namespace as everything else?

> +{
> +	unsigned long flags;
> +
> +	/*
> +	 * We need to prevent umwait_control_cached from being changed *and*
> +	 * completing its WRMSR between our read and our WRMSR. By turning

Huch? How does umwait_control_cached complete its WRMSR?

> +	 * IRQs off here, ensure that no sysfs write happens on this CPU

How would that happen? If this is called from a hotplugged CPU then that
CPU cannot handle sysfs writes even if the hotplug thread on which this
runs is preempted. The CPU is not marked active yet and cannot schedule
user space tasks. Doing the wrmsr(MSR, READ()) preemptible would just make
the race window larger.

> +	 * and we also make sure that any concurrent sysfs write from a
> +	 * different CPU will not finish updating us via IPI until we're done.

  will not finish updating us?

> +	local_irq_save(flags);

That local_irq_save() belongs into the cpu hotplug callback and there it
wants to be a local_irq_disable(). The IPI runs already with interrupts
disabled. And that comment wants to be in the hotplug function as well.

With that you can also spare the indirection via that extra IPI function
below and just add the void *unused argument to this and invoke it from the
hotplug callback with NULL.

> +
> +	wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
> +
> +	local_irq_restore(flags);
> +}

> +static u32 get_umwait_ctrl_c02(void)
> +{
> +	return READ_ONCE(umwait_control_cached) & MSR_IA32_UMWAIT_CONTROL_C02_DISABLED;
> +}
> +
> +static u32 get_umwait_ctrl_max_time(void)
> +{
> +	return READ_ONCE(umwait_control_cached) & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> +}
> +
> +static ssize_t
> +enable_c02_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	 /*
> +	  * When bit 0 in IA32_UMWAIT_CONTROL MSR is 1, C0.2 is disabled.
> +	  * Otherwise, C0.2 is enabled. Show the opposite of bit 0.
> +	  */
> +	return sprintf(buf, "%d\n", !(bool)get_umwait_ctrl_c02());

Eeew. !(bool)....

> +}
> +
> +static ssize_t enable_c02_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	u32 umwait_c02;
> +	bool c02_enabled;

Your naming conventions are inconsistent. The file is named 'enable', which
is fine, but here you read the written value into a variable named 'enabled'

> +	int ret;
> +
> +	ret = kstrtobool(buf, &c02_enabled);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&umwait_lock);
> +
> +	/*
> +	 * The value of bit 0 in IA32_UMWAIT_CONTROL MSR is opposite of
> +	 * c02_enabled.

How many of those comments do we need?

> +	 */
> +	umwait_c02 = (u32)!c02_enabled;

Umpf.

> +	if (umwait_c02 == get_umwait_ctrl_c02())
> +		goto out_unlock;
> +
> +	WRITE_ONCE(umwait_control_cached,
> +		   UMWAIT_CTRL_VAL(get_umwait_ctrl_max_time(), umwait_c02));

And how often do we need to read that cached value? Why not doing the
obvious, read the ctrl value once and then work from there.

    	ctrl = READ_ONCE(umwait_control_cached);

        if (c02_enable == umwait_c02_enabled(ctrl))
                goto out_unlock;

        ctrl = umwait_max_time(ctrl);
        if (!c02_enable)
                ctrl |= MSR_IA32_UMWAIT_CONTROL_C02_DISABLE;

        WRITE_ONCE(umwait_control_cached, ctrl);

That does not need any comment about the inverted bit and whatever. It's
just clear what it does. The only place where this comment is required is
in umwait_c02_enabled() which returns the enabled state from the control
value argument as boolean. That makes also the weird type casts go away.

>  static int __init umwait_init(void)
>  {
> +	struct device *dev;
>  	int ret;
>  
>  	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
>  		return -ENODEV;
>  
> +	/* Add umwait control interface. */
> +	dev = cpu_subsys.dev_root;
> +	ret = sysfs_create_group(&dev->kobj, &umwait_attr_group);
> +	if (ret)
> +		return ret;

When that fails then all CPUs have some random possibly nonsensical value
in the control MSR, whatever the firmware or reset default set it to.

Not that it matters much, because boot will probably not work at all, but
you can spare the removal below, when you move that sysfs thing to the very
end. And it makes more sense that way.

Thanks,

	tglx
