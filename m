Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF0DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4E220700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfC1Kpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:45:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfC1Kpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:45:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 631E815AB;
        Thu, 28 Mar 2019 03:45:51 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F653F59C;
        Thu, 28 Mar 2019 03:45:48 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:45:42 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Message-ID: <20190328104542.GA27459@e107981-ln.cambridge.arm.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 06:40:07PM +0000, Leonard Crestez wrote:
> On Wed, 2019-03-27 at 17:45 +0000, Marc Zyngier wrote:
> > On 27/03/2019 16:06, Lucas Stach wrote:
> > > Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:
> > > > On 27/03/2019 15:44, Lucas Stach wrote:
> > > > > Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
> > > > > > This work is a workaround I'm looking into (more as a background task)
> > > > > > in order to add support for cpuidle on i.MX8MQ based platforms.
> > > > > > 
> > > > > > The main idea here is getting around the missing GIC wake_request signal
> > > > > > (due to integration design issue) by waking up a each individual core through
> > > > > > some dedicated SW power-up bits inside the power controller (GPC) right before
> > > > > > every IPI is requested for that each individual core.
> > > > > 
> > > > > Just a general comment, without going into the details of this series:
> > > > > this issue is not only affecting IPIs, but also MSIs terminated at the
> > > > > GIC. Currently MSIs are terminated at the PCIe core, but terminating
> > > > > them at the GIC is clearly preferable, as this allows assigning CPU
> > > > > affinity to individual MSIs and lowers IRQ service overhead.
> > > > > 
> > > > > I'm not sure what the consequences are for upstream Linux support yet,
> > > > > but we should keep in mind that having a workaround for IPIs is only
> > > > > solving part of the issue.
> > > > 
> > > > If this erratum is affecting more than just IPIs, then indeed I don't
> > > > see how this patch series solves anything.
> > > > 
> > > > But the erratum documentation seems to imply that only SGIs are
> > > > affected, and goes as far as suggesting to use an external interrupt
> > > > would solve it. How comes this is not the case? Or is it that anything
> > > > directly routed to a redistributor is also affected? This would break
> > > > LPIs (and thus MSIs) and PPIs (the CPU timer, among others).
> > > 
> > > Anything that isn't visible to the GPC and requires the GIC
> > > wake_request signal to behave as specified is broken by this erratum.
> > 
> > I really wonder how a timer interrupt (a PPI, hence not routed through
> > the GPC) can wake up the CPU in this case. It really feels like
> > something like "program CNTV_CVAL_EL0 to expire at some later point;
> > WFI" could result in the CPU going to a deep sleep state, and not
> > wake-up at all.
> 
> This is already a common issue for cpuidle implementions handled by the
> "local-timer-stop" property. imx has other timer blocks in the SOC,
> they generate SPIs which are connected to GPC.

It is not a common issue. The tick-broadcast mechanism relies on
IPIs that are sent to specific CPUs upon timer expiry.

If IPIs don't work for CPUs in shutdown state (which is what this patch
is fixing AFAIU), the only reason I can see how a CPU can resume from
idle on a timer expiry is the GPC waking up all cores upon the global
timer SPI; if that's the case there is precious little point in
implementing CPUidle at all - too bad people worked hard to implement
NOHZ in a power efficient manner.

> > This would indicate that not only cpuidle is broken with this, but
> > absolutely every interrupt that is not routed through the GPC.
> 
> Yes, cpuidle is broken for irqs not routed through GPC. However:
> 
> * All SPIs are connected to GPC in a 1:1 mapping
> * This series deals with SGIs
> * The timer PPIs are not required; covered by local-timer-stop
> * LPIs are currently unused (I understand imx-pci uses SPI by default
> from Lucas)
> 
> Anything missing?

Yes, LPIs must be able to wake up CPUs and only the CPU for which
an IRQ is actually pending.

From an architectural perspective, an ARM core executing the WFI
instruction must resume execution upon an IRQ occurrence targeted
at it and that's true regardless of the idle state entered.

Anything deviating from this behaviour is not architecture compliant.

> My understanding is that this wake request feature via GIC is new in v3
> and this is maybe why HW team missed it during integration. Older
> imx6/7 has GICv2 and has deep idle states which always rely on GPC to
> wakeup so the approach can work.

If HW designers really wanted to have sensible power management policy
in this SoC they would have paid attention, I am against patching the
kernel heavily to fix a platform bug.

Thanks,
Lorenzo
