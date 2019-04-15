Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FDFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C992087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfDOOHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:07:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbfDOOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:07:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FDxAb2130347
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:07:35 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvth136we-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:07:34 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 15:07:33 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 15:07:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FE7SIE26935352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 14:07:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13694B2067;
        Mon, 15 Apr 2019 14:07:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7C49B2064;
        Mon, 15 Apr 2019 14:07:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 14:07:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8DD0716C30F6; Mon, 15 Apr 2019 07:07:31 -0700 (PDT)
Date:   Mon, 15 Apr 2019 07:07:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Reply-To: paulmck@linux.ibm.com
References: <20181113135453.GW9144@intel.com>
 <20181113151037.GG4170@linux.ibm.com>
 <20181114202013.GA27603@linux.ibm.com>
 <20181126220122.GA6345@linux.ibm.com>
 <20190415133524.GS3888@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415133524.GS3888@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041514-0040-0000-0000-000004E11CC9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010932; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189454; UDB=6.00623214; IPR=6.00970240;
 MB=3.00026451; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 14:07:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041514-0041-0000-0000-000008EC2685
Message-Id: <20190415140731.GX14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:35:24PM +0300, Ville Syrjälä wrote:
> On Mon, Nov 26, 2018 at 02:01:22PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 14, 2018 at 12:20:13PM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 13, 2018 at 07:10:37AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Nov 13, 2018 at 03:54:53PM +0200, Ville Syrjälä wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > After 4.20-rc1 some of my 32bit UP machines no longer reboot/shutdown.
> > > > > I bisected this down to commit 45975c7d21a1 ("rcu: Define RCU-sched
> > > > > API in terms of RCU for Tree RCU PREEMPT builds").
> > > > > 
> > > > > I traced the hang into
> > > > > -> cpufreq_suspend()
> > > > >  -> cpufreq_stop_governor()
> > > > >   -> cpufreq_dbs_governor_stop()
> > > > >    -> gov_clear_update_util()
> > > > >     -> synchronize_sched()
> > > > >      -> synchronize_rcu()
> > > > > 
> > > > > Only PREEMPT=y is affected for obvious reasons, but that couldn't
> > > > > explain why the same UP kernel booted on an SMP machine worked fine.
> > > > > Eventually I realized that the difference between working and
> > > > > non-working machine was IOAPIC vs. PIC. With initcall_debug I saw
> > > > > that we mask everything in the PIC before cpufreq is shut down,
> > > > > and came up with the following fix:
> > > > > 
> > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > index 7aa3dcad2175..f88bf3c77fc0 100644
> > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > @@ -2605,4 +2605,4 @@ static int __init cpufreq_core_init(void)
> > > > >         return 0;
> > > > >  }
> > > > >  module_param(off, int, 0444);
> > > > > -core_initcall(cpufreq_core_init);
> > > > > +late_initcall(cpufreq_core_init);
> > > > 
> > > > Thank you for testing this and tracking it down!
> > > > 
> > > > I am glad that you have a fix, but I hope that we can arrive at a less
> > > > constraining one.
> > > > 
> > > > > Here's the resulting change in inutcall_debug:
> > > > >   pci 0000:00:00.1: shutdown
> > > > >   hub 4-0:1.0: hub_ext_port_status failed (err = -110)
> > > > >   agpgart-intel 0000:00:00.0: shutdown
> > > > > + PM: Calling cpufreq_suspend+0x0/0x100
> > > > >   PM: Calling mce_syscore_shutdown+0x0/0x10
> > > > >   PM: Calling i8259A_shutdown+0x0/0x10
> > > > > - PM: Calling cpufreq_suspend+0x0/0x100
> > > > > + reboot: Restarting system
> > > > > + reboot: machine restart
> > > > > 
> > > > > I didn't really look into what other ramifications the cpufreq
> > > > > initcall change might have. cpufreq_global_kobject worries
> > > > > me a bit. Maybe that one has to remain in core_initcall() and
> > > > > we could just move the suspend to late_initcall()? Anyways,
> > > > > I figured I'd leave this for someone more familiar with the
> > > > > code to figure out ;) 
> > > > 
> > > > Let me guess...
> > > > 
> > > > When the system suspends or shuts down, there comes a point after which
> > > > there is only a single CPU that is running with preemption and interrupts
> > > > are disabled.  At this point, RCU must change the way that it works, and
> > > > the commit you bisected to would make the change more necessary.  But if
> > > > I am guessing correctly, we have just been getting lucky in the past.
> > > > 
> > > > It looks like RCU needs to create a struct syscore_ops with a shutdown
> > > > function and pass this to register_syscore_ops().  Maybe a suspend
> > > > function as well.  And RCU needs to invoke register_syscore_ops() at
> > > > a time that causes RCU's shutdown function to be invoked in the right
> > > > order with respect to the other work in flight.  The hope would be that
> > > > RCU's suspend function gets called just as the system transitions into
> > > > a mode where the scheduler is no longer active, give or take.
> > > > 
> > > > Does this make sense, or am I confused?
> > > 
> > > Well, it certainly does not make sense in that blocking is still legal
> > > at .shutdown() invocation time, which means that RCU cannot revert to
> > > its boot-time approach at that point.  Looks like I need hooks in a
> > > bunch of arch-dependent functions.  Which is certainly doable, but will
> > > take a bit more digging.
> > 
> > A bit more detail, after some additional discussion at Linux Plumbers
> > conference...
> > 
> > The preferred approach is to hook into syscore_suspend(),
> > syscore_resume(), and syscore_shutdown().  This can be done easily by
> > creating an appropriately initialized struct syscore_ops and passing a
> > pointer to it to register_syscore_ops() during boot.  Taking these three
> > functions in turn:
> > 
> > syscore_suspend():
> > 
> > o	arch/x86/kernel/apm_32.c suspend(), standby()
> > 
> > 	These calls to syscore_suspend() has interrupts disabled, which
> > 	is very good, but they are immediately re-enabled, and only then
> > 	is the call to set_system_power_state().  Unless both interrupts
> > 	and preemption are prevented somehow, it is not safe for
> > 	CONFIG_PREEMPT=y RCU implementations to revert back to boot-time
> > 	behavior at this point.
> > 
> > o	drivers/xen/manage.c xen_suspend()
> > 
> > 	This looks to have interrupts disabled throughout.  It is also
> > 	invoked within stop_machine(), which means that the other CPUs,
> > 	though online, are quiescent.  This allows RCU to safely switch
> > 	back to early boot operating mode.  That is, this is safe only
> > 	if there is no interaction with RCU-preempt read-side critical
> > 	sections that might well be underway in the other CPUs.  This
> > 	assumption is likely violated in CONFIG_PREEMPT=y kernels.  One
> > 	alternative that would work with RCU in CONFIG_PREEMPT=y kernels
> > 	is CPU-hotplug removing all but one CPU, but that might have
> > 	some other disadvantages.
> > 
> > o	kernel/kexec_core.c kernel_kexec()
> > 
> > 	Before we get here, disable_nonboot_cpus() has been invoked, which
> > 	in turn invokes freeze_secondary_cpus(), which offlines all but
> > 	the boot CPU.  Prior to that, all user-space tasks are frozen.
> > 	So in this case, it would be safe for RCU to revert back to its
> > 	boot-time behavior.  Aside from the possibility of unfreezable
> > 	kthreads being preempted within RCU-preempt read-side critical
> > 	sections, anyway...  :-/
> > 
> > 	However, one can argue that as long as the kthreads preempted
> > 	within an RCU-preempt read-side critical section are guaranteed
> > 	to never ever run again, we might be OK.  And this guarantee
> > 	seems consistent with the kernel_kexec() operation.  At least
> > 	when there are no errors that cause the kernel_kexec() to return
> > 	control to the initial kernel image...
> > 
> > 	Of course, this line of reasoning does not apply when the
> > 	kernel is to resume on the same hardware, as in some of the
> > 	cases above.
> > 
> > o	kernel/power/hibernate.c create_image()
> > 
> > 	Same as for kernel_kexec(), except that freeze_kernel_threads()
> > 	is invoked, which hopefully gets all tasks out of RCU read-side
> > 	critical sections.  So this one might actually permit RCU to
> > 	revert back to boot-time behavior.  Except for the possibility of
> > 	an error condition forcing an abort back into the original kernel
> > 	image, which again could have trouble with kthreads that were
> > 	preempted within an RCU read-side critical section throughout.
> > 
> > o	kernel/power/hibernate.c resume_target_kernel()
> > 	kernel/power/hibernate.c hibernation_platform_enter()
> > 	kernel/power/suspend.c suspend_enter()
> > 
> > 	Same as for kernel_kexec(), but no obvious pretense of freezing
> > 	any tasks.
> > 
> > 
> > syscore_resume():
> > 
> > o	arch/x86/kernel/apm_32.c suspend(), standby()
> > 
> > 	Resume-time counterparts to the calls to syscore_suspend() called
> > 	out above, with the same interrupt-enabling problem, as well as
> > 	issues with tasks being preempted throughout within RCU-preempt
> > 	read-side critical sections.
> > 
> > o	drivers/xen/manage.c xen_suspend()
> > 
> > 	Resume-time counterpart to the calls to xen_suspend() called out
> > 	above, with the same issues with tasks being preempted throughout
> > 	within RCU-preempt read-side critical sections.
> > 
> > o	kernel/kexec_core.c kernel_kexec()
> > 
> > 	Resume-time counterpart to the calls to kernel_kexec() called out
> > 	above.  This is the error case that causes trouble due to the
> > 	possibility of preempted RCU read-side critical sections.
> > 
> > o	kernel/power/hibernate.c create_image()
> > 	kernel/power/hibernate.c resume_target_kernel()
> > 	kernel/power/hibernate.c hibernation_platform_enter()
> > 	kernel/power/hibernate.c suspend_enter()
> > 
> > 	Resume-time counterparts to calls within kernel/power/hibernate.c
> > 	and kernel/power/suspend.c called out above.  This is the error
> > 	case that causes trouble due to the possibility of preempted
> > 	RCU read-side critical sections.
> > 
> > 
> > syscore_shutdown():
> > 
> > o	kernel/reboot.c kernel_restart()
> > 	kernel/reboot.c kernel_halt()
> > 	kernel/reboot.c kernel_power_off()
> > 
> > 	These appears to leave all CPUs online, which prevents RCU from
> > 	safely reverting back to boot-time mode.
> > 
> > 
> > So what is to be done?
> > 
> > Here are the options I can see:
> > 
> > 1.	Status quo, which means that synchronize_rcu() and friends
> > 	cannot be used in syscore_suspend(), syscore_resume(), and
> > 	syscore_shutdown() callbacks.  At the moment, this appears to
> > 	be the only workable approach, though ideas and suggestions are
> > 	quite welcome.
> > 
> > 2.	Make each code path to syscore_suspend(), syscore_resume(), and
> > 	syscore_shutdown() offline all but the boot CPU, ensure that
> > 	all tasks exit any RCU read-side critical sections that they
> > 	might be in, then run the remainder of the code path on the
> > 	boot CPU with interrupts disabled.
> > 
> > 	Making all tasks exit any RCU read-side critical sections is
> > 	easy when CONFIG_PREEMPT=n via things like stop-machine, but
> > 	it is difficult and potentially time-consuming for
> > 	CONFIG_PREEMPT=y kernels.
> > 
> > 3.	Do error checking so that there cannot possibly be failures
> > 	beyond the time that syscore_suspend(), syscore_resume(),
> > 	and syscore_shutdown() are invoked.  This is fine for
> > 	syscore_shutdown() and syscore_resume(), but syscore_suspend()'s
> > 	callbacks are permitted to return errors that force suspend
> > 	failures.
> > 
> > 	And there are syscore_suspend() callbacks that actually do
> > 	return errors, for example, fsl_lbc_syscore_suspend()
> > 	in arch/powerpc/sysdev/fsl_lbc.c can return -ENOMEM.
> > 	As can save_ioapic_entries() in arch/x86/kernel/apic/io_apic.c
> > 	and arch/x86/include/asm/io_apic.h.  And mvebu_mbus_suspend()
> > 	in drivers/bus/mvebu-mbus.c.  And iommu_suspend() in
> > 	drivers/iommu/intel-iommu.c.
> > 
> > 	And its_save_disable() in drivers/irqchip/irq-gic-v3-its.c
> > 	can return -EBUSY.
> > 
> > 	Perhaps these can be remedied somehow, but unless that can
> > 	be done, this approach cannot work.
> > 
> > 4.	Your idea here!!!
> 
> Paul, are we any closer to fixing this regression? It's been around
> for far too long, and I'd like to stop carrying my original hack
> around.

Actually, no.  If I got any response before now, I fat-fingered it.
Seeing no responses, I assumed that nobody cared, and that option #1
(status quo) was preferred.

Any feedback from anyone on the various options?  Or, better yet, some
better options?

							Thanx, Paul

