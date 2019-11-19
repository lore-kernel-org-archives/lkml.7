Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F0BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05E0222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKSXTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:19:17 -0500
Received: from foss.arm.com ([217.140.110.172]:59492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbfKSXTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:19:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66F811FB;
        Tue, 19 Nov 2019 15:19:16 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 827973F52E;
        Tue, 19 Nov 2019 15:19:15 -0800 (PST)
Date:   Tue, 19 Nov 2019 23:19:13 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ia64: Replace cpu_down with freeze_secondary_cpus
Message-ID: <20191119231912.viwqgcyzttoo5eou@e107158-lin.cambridge.arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-5-qais.yousef@arm.com>
 <alpine.DEB.2.21.1911192318400.6731@nanos.tec.linutronix.de>
 <20191119223234.ov323rcln4slj7br@e107158-lin.cambridge.arm.com>
 <alpine.DEB.2.21.1911192344110.6731@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911192344110.6731@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 23:59, Thomas Gleixner wrote:
> On Tue, 19 Nov 2019, Qais Yousef wrote:
> > On 11/19/19 23:21, Thomas Gleixner wrote:
> > > On Wed, 30 Oct 2019, Qais Yousef wrote:
> > > >  void machine_shutdown(void)
> > > >  {
> > > >  #ifdef CONFIG_HOTPLUG_CPU
> > > > -	int cpu;
> > > > -
> > > > -	for_each_online_cpu(cpu) {
> > > > -		if (cpu != smp_processor_id())
> > > > -			cpu_down(cpu);
> > > > -	}
> > > > +	/* TODO: Can we use disable_nonboot_cpus()? */
> > > > +	freeze_secondary_cpus(smp_processor_id());
> > > 
> > > freeze_secondary_cpus() is only available for CONFIG_PM_SLEEP_SMP=y and
> > > disable_nonboot_cpus() is a NOOP for CONFIG_PM_SLEEP_SMP=n :)
> > 
> > I thought I replied to this :-(
> > 
> > My plan was to simply make freeze_secondary_cpus() available and protected by
> > CONFIG_SMP only instead.
> > 
> > Good plan?
> 
> No. freeze_secondary_cpus() is really for hibernation. Look at the exit
> conditions there.

Hmm do you mean the pm_wakeup_pending() abort?

In arm64 we machine_shutdown() calls disable_nonboot_cpus(), which in turn
a wrapper around freeze_secondary_cpus() with 0 passed as an argument.

IIUC this means arm64 could fail to offline all CPUs on machine_shutdown(),
correct?

> 
> So you really want a seperate function which depends on CONFIG_HOTPLUG_CPU
> and provides an inline stub for the CONFIG_HOTPLUG_CPU=n case.
> 
> But I have a hard time to see how that stuff works at all on
> ia64:
> 
>   cpu_down() might sleep, i.e. it must be called from preemptible
>   context. smp_processor_id() is invalid from preemtible context.
> 
> As this is obviously broken and ia64 is in keep compile mode only, it
> should just go away.

If arm64 is doing the wrong thing, then we need a new function anyway.

Thanks

--
Qais Yousef
