Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA74C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A5322449
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKSWck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:32:40 -0500
Received: from foss.arm.com ([217.140.110.172]:59060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfKSWcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:32:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A358731B;
        Tue, 19 Nov 2019 14:32:38 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3713F52E;
        Tue, 19 Nov 2019 14:32:37 -0800 (PST)
Date:   Tue, 19 Nov 2019 22:32:35 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ia64: Replace cpu_down with freeze_secondary_cpus
Message-ID: <20191119223234.ov323rcln4slj7br@e107158-lin.cambridge.arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-5-qais.yousef@arm.com>
 <alpine.DEB.2.21.1911192318400.6731@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911192318400.6731@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 23:21, Thomas Gleixner wrote:
> On Wed, 30 Oct 2019, Qais Yousef wrote:
> 
> > Use freeze_secondary_cpus() instead of open coding using cpu_down()
> > directly.
> > 
> > This also prepares to make cpu_up/down a private interface for anything
> > but the cpu subsystem.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > CC: Tony Luck <tony.luck@intel.com>
> > CC: Fenghua Yu <fenghua.yu@intel.com>
> > CC: linux-ia64@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  arch/ia64/kernel/process.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> > index 968b5f33e725..70b433eafa5c 100644
> > --- a/arch/ia64/kernel/process.c
> > +++ b/arch/ia64/kernel/process.c
> > @@ -647,12 +647,8 @@ cpu_halt (void)
> >  void machine_shutdown(void)
> >  {
> >  #ifdef CONFIG_HOTPLUG_CPU
> > -	int cpu;
> > -
> > -	for_each_online_cpu(cpu) {
> > -		if (cpu != smp_processor_id())
> > -			cpu_down(cpu);
> > -	}
> > +	/* TODO: Can we use disable_nonboot_cpus()? */
> > +	freeze_secondary_cpus(smp_processor_id());
> 
> freeze_secondary_cpus() is only available for CONFIG_PM_SLEEP_SMP=y and
> disable_nonboot_cpus() is a NOOP for CONFIG_PM_SLEEP_SMP=n :)

I thought I replied to this :-(

My plan was to simply make freeze_secondary_cpus() available and protected by
CONFIG_SMP only instead.

Good plan?

I'll probably do it as a separate patch before this one.

Thanks

--
Qais Yousef
