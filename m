Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A4DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EA52075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfC0RzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:55:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59949 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfC0RzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:55:15 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h9ClV-0002s6-MI; Wed, 27 Mar 2019 18:55:05 +0100
Message-ID: <1553709304.2561.44.camel@pengutronix.de>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>, Abel Vesa <abel.vesa@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Wed, 27 Mar 2019 18:55:04 +0100
In-Reply-To: <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
         <1553701479.2561.38.camel@pengutronix.de>
         <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
         <1553702767.2561.40.camel@pengutronix.de>
         <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 27.03.2019, 17:45 +0000 schrieb Marc Zyngier:
> On 27/03/2019 16:06, Lucas Stach wrote:
> > Hi Marc,
> > 
> > Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:
> > > On 27/03/2019 15:44, Lucas Stach wrote:
> > > > Hi Abel,
> > > > 
> > > > Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
> > > > > This work is a workaround I'm looking into (more as a background task)
> > > > > in order to add support for cpuidle on i.MX8MQ based platforms.
> > > > > 
> > > > > The main idea here is getting around the missing GIC wake_request signal
> > > > > (due to integration design issue) by waking up a each individual core through
> > > > > some dedicated SW power-up bits inside the power controller (GPC) right before
> > > > > every IPI is requested for that each individual core.
> > > > 
> > > > Just a general comment, without going into the details of this series:
> > > > this issue is not only affecting IPIs, but also MSIs terminated at the
> > > > GIC. Currently MSIs are terminated at the PCIe core, but terminating
> > > > them at the GIC is clearly preferable, as this allows assigning CPU
> > > > affinity to individual MSIs and lowers IRQ service overhead.
> > > > 
> > > > I'm not sure what the consequences are for upstream Linux support yet,
> > > > but we should keep in mind that having a workaround for IPIs is only
> > > > solving part of the issue.
> > > 
> > > If this erratum is affecting more than just IPIs, then indeed I don't
> > > see how this patch series solves anything.
> > > 
> > > But the erratum documentation seems to imply that only SGIs are
> > > affected, and goes as far as suggesting to use an external interrupt
> > > would solve it. How comes this is not the case? Or is it that anything
> > > directly routed to a redistributor is also affected? This would break
> > > LPIs (and thus MSIs) and PPIs (the CPU timer, among others).
> > > 
> > > What is the *exact* status of this thing? I have the ugly feeling that
> > > the true workaround is just to disable cpuidle.
> > 
> > As far as I understand the erratum, the basic issue is that the GIC
> > wake_request signals are not connected to the GPC (the CPU/peripheral
> > power sequencer). The SPIs are routed through the GPC and thus are
> > visible as wakeup sources, which is why the workaround of using an
> > external SPI as wakeup trigger for the IPI works.
> 
> Are all SPIs connected to the GPC?

AFAICS yes.

> > Anything that isn't visible to the GPC and requires the GIC
> > wake_request signal to behave as specified is broken by this erratum.
> 
> I really wonder how a timer interrupt (a PPI, hence not routed through
> the GPC) can wake up the CPU in this case. It really feels like
> something like "program CNTV_CVAL_EL0 to expire at some later point;
> WFI" could result in the CPU going to a deep sleep state, and not
> wake-up at all.

I guess it's broken in the same way. The downstream DT claims
"local-timer-stop" for the CPU sleep state and "arm,no-tick-in-suspend" 
for the armv8-timer, which I guess is not the timer actually stopping
in suspend, but the CPU being unable to wake up due to the timer IRQ.

> This would indicate that not only cpuidle is broken with this, but
> absolutely every interrupt that is not routed through the GPC.

That's my understanding as well. Note that I have no NXP internal
information and can only infer from the published reference manual,
errata notice and downstream kernel.

Regards,
Lucas
