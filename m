Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B02245B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKSW7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:59:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54867 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfKSW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:59:17 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXCSl-0005Tb-IR; Tue, 19 Nov 2019 23:59:11 +0100
Date:   Tue, 19 Nov 2019 23:59:10 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ia64: Replace cpu_down with
 freeze_secondary_cpus
In-Reply-To: <20191119223234.ov323rcln4slj7br@e107158-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1911192344110.6731@nanos.tec.linutronix.de>
References: <20191030153837.18107-1-qais.yousef@arm.com> <20191030153837.18107-5-qais.yousef@arm.com> <alpine.DEB.2.21.1911192318400.6731@nanos.tec.linutronix.de> <20191119223234.ov323rcln4slj7br@e107158-lin.cambridge.arm.com>
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

On Tue, 19 Nov 2019, Qais Yousef wrote:
> On 11/19/19 23:21, Thomas Gleixner wrote:
> > On Wed, 30 Oct 2019, Qais Yousef wrote:
> > >  void machine_shutdown(void)
> > >  {
> > >  #ifdef CONFIG_HOTPLUG_CPU
> > > -	int cpu;
> > > -
> > > -	for_each_online_cpu(cpu) {
> > > -		if (cpu != smp_processor_id())
> > > -			cpu_down(cpu);
> > > -	}
> > > +	/* TODO: Can we use disable_nonboot_cpus()? */
> > > +	freeze_secondary_cpus(smp_processor_id());
> > 
> > freeze_secondary_cpus() is only available for CONFIG_PM_SLEEP_SMP=y and
> > disable_nonboot_cpus() is a NOOP for CONFIG_PM_SLEEP_SMP=n :)
> 
> I thought I replied to this :-(
> 
> My plan was to simply make freeze_secondary_cpus() available and protected by
> CONFIG_SMP only instead.
> 
> Good plan?

No. freeze_secondary_cpus() is really for hibernation. Look at the exit
conditions there.

So you really want a seperate function which depends on CONFIG_HOTPLUG_CPU
and provides an inline stub for the CONFIG_HOTPLUG_CPU=n case.

But I have a hard time to see how that stuff works at all on
ia64:

  cpu_down() might sleep, i.e. it must be called from preemptible
  context. smp_processor_id() is invalid from preemtible context.

As this is obviously broken and ia64 is in keep compile mode only, it
should just go away.

Thanks,

	tglx
