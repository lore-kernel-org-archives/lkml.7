Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DAB206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfC1KiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:38:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52961 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1KiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:38:20 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 5a898933f5c9dee8; Thu, 28 Mar 2019 11:38:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
Date:   Thu, 28 Mar 2019 11:36:17 +0100
Message-ID: <7512439.MQbgvXz0nx@aspire.rjw.lan>
In-Reply-To: <b90bd658-a29d-ea16-abf4-95b388467c8c@arm.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com> <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com> <b90bd658-a29d-ea16-abf4-95b388467c8c@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 28, 2019 11:35:23 AM CET Marc Zyngier wrote:
> On 27/03/2019 18:40, Leonard Crestez wrote:
> > On Wed, 2019-03-27 at 17:45 +0000, Marc Zyngier wrote:
> >> On 27/03/2019 16:06, Lucas Stach wrote:
> >>> Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:
> >>>> On 27/03/2019 15:44, Lucas Stach wrote:
> >>>>> Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
> >>>>>> This work is a workaround I'm looking into (more as a background task)
> >>>>>> in order to add support for cpuidle on i.MX8MQ based platforms.
> >>>>>>
> >>>>>> The main idea here is getting around the missing GIC wake_request signal
> >>>>>> (due to integration design issue) by waking up a each individual core through
> >>>>>> some dedicated SW power-up bits inside the power controller (GPC) right before
> >>>>>> every IPI is requested for that each individual core.
> >>>>>
> >>>>> Just a general comment, without going into the details of this series:
> >>>>> this issue is not only affecting IPIs, but also MSIs terminated at the
> >>>>> GIC. Currently MSIs are terminated at the PCIe core, but terminating
> >>>>> them at the GIC is clearly preferable, as this allows assigning CPU
> >>>>> affinity to individual MSIs and lowers IRQ service overhead.
> >>>>>
> >>>>> I'm not sure what the consequences are for upstream Linux support yet,
> >>>>> but we should keep in mind that having a workaround for IPIs is only
> >>>>> solving part of the issue.
> >>>>
> >>>> If this erratum is affecting more than just IPIs, then indeed I don't
> >>>> see how this patch series solves anything.
> >>>>
> >>>> But the erratum documentation seems to imply that only SGIs are
> >>>> affected, and goes as far as suggesting to use an external interrupt
> >>>> would solve it. How comes this is not the case? Or is it that anything
> >>>> directly routed to a redistributor is also affected? This would break
> >>>> LPIs (and thus MSIs) and PPIs (the CPU timer, among others).
> >>>
> >>> Anything that isn't visible to the GPC and requires the GIC
> >>> wake_request signal to behave as specified is broken by this erratum.
> >>
> >> I really wonder how a timer interrupt (a PPI, hence not routed through
> >> the GPC) can wake up the CPU in this case. It really feels like
> >> something like "program CNTV_CVAL_EL0 to expire at some later point;
> >> WFI" could result in the CPU going to a deep sleep state, and not
> >> wake-up at all.
> > 
> > This is already a common issue for cpuidle implementions handled by the
> > "local-timer-stop" property. imx has other timer blocks in the SOC,
> > they generate SPIs which are connected to GPC.
> > 
> >> This would indicate that not only cpuidle is broken with this, but
> >> absolutely every interrupt that is not routed through the GPC.
> > 
> > Yes, cpuidle is broken for irqs not routed through GPC. However:
> > 
> > * All SPIs are connected to GPC in a 1:1 mapping
> > * This series deals with SGIs
> > * The timer PPIs are not required; covered by local-timer-stop
> > * LPIs are currently unused (I understand imx-pci uses SPI by default
> > from Lucas)
> > 
> > Anything missing?
> > 
> > My understanding is that this wake request feature via GIC is new in v3
> > and this is maybe why HW team missed it during integration. Older
> > imx6/7 has GICv2 and has deep idle states which always rely on GPC to
> > wakeup so the approach can work.
> 
> Certainly the approach can work. The question is whether we want to
> support this in a mainline kernel, spreading random hooks in the generic
> code and adding a firmware interface on top of that.

Not really.

> By all accounts, this HW is broken. You can indeed impose limitations
> (dumb down PCI, mandate the use of a broadcast timer), or you can just
> flag cpuidle as unsupported on this HW. My vote is on the latter.

Agreed.

Thanks,
Rafael

