Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfDONf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:35:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:14990 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfDONf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:35:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 06:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="143099088"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 15 Apr 2019 06:35:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 15 Apr 2019 16:35:24 +0300
Date:   Mon, 15 Apr 2019 16:35:24 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Message-ID: <20190415133524.GS3888@intel.com>
References: <20181113135453.GW9144@intel.com>
 <20181113151037.GG4170@linux.ibm.com>
 <20181114202013.GA27603@linux.ibm.com>
 <20181126220122.GA6345@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181126220122.GA6345@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:01:22PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 14, 2018 at 12:20:13PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 13, 2018 at 07:10:37AM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 13, 2018 at 03:54:53PM +0200, Ville Syrjälä wrote:
> > > > Hi Paul,
> > > > 
> > > > After 4.20-rc1 some of my 32bit UP machines no longer reboot/shutdown.
> > > > I bisected this down to commit 45975c7d21a1 ("rcu: Define RCU-sched
> > > > API in terms of RCU for Tree RCU PREEMPT builds").
> > > > 
> > > > I traced the hang into
> > > > -> cpufreq_suspend()
> > > >  -> cpufreq_stop_governor()
> > > >   -> cpufreq_dbs_governor_stop()
> > > >    -> gov_clear_update_util()
> > > >     -> synchronize_sched()
> > > >      -> synchronize_rcu()
> > > > 
> > > > Only PREEMPT=y is affected for obvious reasons, but that couldn't
> > > > explain why the same UP kernel booted on an SMP machine worked fine.
> > > > Eventually I realized that the difference between working and
> > > > non-working machine was IOAPIC vs. PIC. With initcall_debug I saw
> > > > that we mask everything in the PIC before cpufreq is shut down,
> > > > and came up with the following fix:
> > > > 
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 7aa3dcad2175..f88bf3c77fc0 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -2605,4 +2605,4 @@ static int __init cpufreq_core_init(void)
> > > >         return 0;
> > > >  }
> > > >  module_param(off, int, 0444);
> > > > -core_initcall(cpufreq_core_init);
> > > > +late_initcall(cpufreq_core_init);
> > > 
> > > Thank you for testing this and tracking it down!
> > > 
> > > I am glad that you have a fix, but I hope that we can arrive at a less
> > > constraining one.
> > > 
> > > > Here's the resulting change in inutcall_debug:
> > > >   pci 0000:00:00.1: shutdown
> > > >   hub 4-0:1.0: hub_ext_port_status failed (err = -110)
> > > >   agpgart-intel 0000:00:00.0: shutdown
> > > > + PM: Calling cpufreq_suspend+0x0/0x100
> > > >   PM: Calling mce_syscore_shutdown+0x0/0x10
> > > >   PM: Calling i8259A_shutdown+0x0/0x10
> > > > - PM: Calling cpufreq_suspend+0x0/0x100
> > > > + reboot: Restarting system
> > > > + reboot: machine restart
> > > > 
> > > > I didn't really look into what other ramifications the cpufreq
> > > > initcall change might have. cpufreq_global_kobject worries
> > > > me a bit. Maybe that one has to remain in core_initcall() and
> > > > we could just move the suspend to late_initcall()? Anyways,
> > > > I figured I'd leave this for someone more familiar with the
> > > > code to figure out ;) 
> > > 
> > > Let me guess...
> > > 
> > > When the system suspends or shuts down, there comes a point after which
> > > there is only a single CPU that is running with preemption and interrupts
> > > are disabled.  At this point, RCU must change the way that it works, and
> > > the commit you bisected to would make the change more necessary.  But if
> > > I am guessing correctly, we have just been getting lucky in the past.
> > > 
> > > It looks like RCU needs to create a struct syscore_ops with a shutdown
> > > function and pass this to register_syscore_ops().  Maybe a suspend
> > > function as well.  And RCU needs to invoke register_syscore_ops() at
> > > a time that causes RCU's shutdown function to be invoked in the right
> > > order with respect to the other work in flight.  The hope would be that
> > > RCU's suspend function gets called just as the system transitions into
> > > a mode where the scheduler is no longer active, give or take.
> > > 
> > > Does this make sense, or am I confused?
> > 
> > Well, it certainly does not make sense in that blocking is still legal
> > at .shutdown() invocation time, which means that RCU cannot revert to
> > its boot-time approach at that point.  Looks like I need hooks in a
> > bunch of arch-dependent functions.  Which is certainly doable, but will
> > take a bit more digging.
> 
> A bit more detail, after some additional discussion at Linux Plumbers
> conference...
> 
> The preferred approach is to hook into syscore_suspend(),
> syscore_resume(), and syscore_shutdown().  This can be done easily by
> creating an appropriately initialized struct syscore_ops and passing a
> pointer to it to register_syscore_ops() during boot.  Taking these three
> functions in turn:
> 
> syscore_suspend():
> 
> o	arch/x86/kernel/apm_32.c suspend(), standby()
> 
> 	These calls to syscore_suspend() has interrupts disabled, which
> 	is very good, but they are immediately re-enabled, and only then
> 	is the call to set_system_power_state().  Unless both interrupts
> 	and preemption are prevented somehow, it is not safe for
> 	CONFIG_PREEMPT=y RCU implementations to revert back to boot-time
> 	behavior at this point.
> 
> o	drivers/xen/manage.c xen_suspend()
> 
> 	This looks to have interrupts disabled throughout.  It is also
> 	invoked within stop_machine(), which means that the other CPUs,
> 	though online, are quiescent.  This allows RCU to safely switch
> 	back to early boot operating mode.  That is, this is safe only
> 	if there is no interaction with RCU-preempt read-side critical
> 	sections that might well be underway in the other CPUs.  This
> 	assumption is likely violated in CONFIG_PREEMPT=y kernels.  One
> 	alternative that would work with RCU in CONFIG_PREEMPT=y kernels
> 	is CPU-hotplug removing all but one CPU, but that might have
> 	some other disadvantages.
> 
> o	kernel/kexec_core.c kernel_kexec()
> 
> 	Before we get here, disable_nonboot_cpus() has been invoked, which
> 	in turn invokes freeze_secondary_cpus(), which offlines all but
> 	the boot CPU.  Prior to that, all user-space tasks are frozen.
> 	So in this case, it would be safe for RCU to revert back to its
> 	boot-time behavior.  Aside from the possibility of unfreezable
> 	kthreads being preempted within RCU-preempt read-side critical
> 	sections, anyway...  :-/
> 
> 	However, one can argue that as long as the kthreads preempted
> 	within an RCU-preempt read-side critical section are guaranteed
> 	to never ever run again, we might be OK.  And this guarantee
> 	seems consistent with the kernel_kexec() operation.  At least
> 	when there are no errors that cause the kernel_kexec() to return
> 	control to the initial kernel image...
> 
> 	Of course, this line of reasoning does not apply when the
> 	kernel is to resume on the same hardware, as in some of the
> 	cases above.
> 
> o	kernel/power/hibernate.c create_image()
> 
> 	Same as for kernel_kexec(), except that freeze_kernel_threads()
> 	is invoked, which hopefully gets all tasks out of RCU read-side
> 	critical sections.  So this one might actually permit RCU to
> 	revert back to boot-time behavior.  Except for the possibility of
> 	an error condition forcing an abort back into the original kernel
> 	image, which again could have trouble with kthreads that were
> 	preempted within an RCU read-side critical section throughout.
> 
> o	kernel/power/hibernate.c resume_target_kernel()
> 	kernel/power/hibernate.c hibernation_platform_enter()
> 	kernel/power/suspend.c suspend_enter()
> 
> 	Same as for kernel_kexec(), but no obvious pretense of freezing
> 	any tasks.
> 
> 
> syscore_resume():
> 
> o	arch/x86/kernel/apm_32.c suspend(), standby()
> 
> 	Resume-time counterparts to the calls to syscore_suspend() called
> 	out above, with the same interrupt-enabling problem, as well as
> 	issues with tasks being preempted throughout within RCU-preempt
> 	read-side critical sections.
> 
> o	drivers/xen/manage.c xen_suspend()
> 
> 	Resume-time counterpart to the calls to xen_suspend() called out
> 	above, with the same issues with tasks being preempted throughout
> 	within RCU-preempt read-side critical sections.
> 
> o	kernel/kexec_core.c kernel_kexec()
> 
> 	Resume-time counterpart to the calls to kernel_kexec() called out
> 	above.  This is the error case that causes trouble due to the
> 	possibility of preempted RCU read-side critical sections.
> 
> o	kernel/power/hibernate.c create_image()
> 	kernel/power/hibernate.c resume_target_kernel()
> 	kernel/power/hibernate.c hibernation_platform_enter()
> 	kernel/power/hibernate.c suspend_enter()
> 
> 	Resume-time counterparts to calls within kernel/power/hibernate.c
> 	and kernel/power/suspend.c called out above.  This is the error
> 	case that causes trouble due to the possibility of preempted
> 	RCU read-side critical sections.
> 
> 
> syscore_shutdown():
> 
> o	kernel/reboot.c kernel_restart()
> 	kernel/reboot.c kernel_halt()
> 	kernel/reboot.c kernel_power_off()
> 
> 	These appears to leave all CPUs online, which prevents RCU from
> 	safely reverting back to boot-time mode.
> 
> 
> So what is to be done?
> 
> Here are the options I can see:
> 
> 1.	Status quo, which means that synchronize_rcu() and friends
> 	cannot be used in syscore_suspend(), syscore_resume(), and
> 	syscore_shutdown() callbacks.  At the moment, this appears to
> 	be the only workable approach, though ideas and suggestions are
> 	quite welcome.
> 
> 2.	Make each code path to syscore_suspend(), syscore_resume(), and
> 	syscore_shutdown() offline all but the boot CPU, ensure that
> 	all tasks exit any RCU read-side critical sections that they
> 	might be in, then run the remainder of the code path on the
> 	boot CPU with interrupts disabled.
> 
> 	Making all tasks exit any RCU read-side critical sections is
> 	easy when CONFIG_PREEMPT=n via things like stop-machine, but
> 	it is difficult and potentially time-consuming for
> 	CONFIG_PREEMPT=y kernels.
> 
> 3.	Do error checking so that there cannot possibly be failures
> 	beyond the time that syscore_suspend(), syscore_resume(),
> 	and syscore_shutdown() are invoked.  This is fine for
> 	syscore_shutdown() and syscore_resume(), but syscore_suspend()'s
> 	callbacks are permitted to return errors that force suspend
> 	failures.
> 
> 	And there are syscore_suspend() callbacks that actually do
> 	return errors, for example, fsl_lbc_syscore_suspend()
> 	in arch/powerpc/sysdev/fsl_lbc.c can return -ENOMEM.
> 	As can save_ioapic_entries() in arch/x86/kernel/apic/io_apic.c
> 	and arch/x86/include/asm/io_apic.h.  And mvebu_mbus_suspend()
> 	in drivers/bus/mvebu-mbus.c.  And iommu_suspend() in
> 	drivers/iommu/intel-iommu.c.
> 
> 	And its_save_disable() in drivers/irqchip/irq-gic-v3-its.c
> 	can return -EBUSY.
> 
> 	Perhaps these can be remedied somehow, but unless that can
> 	be done, this approach cannot work.
> 
> 4.	Your idea here!!!

Paul, are we any closer to fixing this regression? It's been around
for far too long, and I'd like to stop carrying my original hack
around.

-- 
Ville Syrjälä
Intel
