Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C90C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFA420679
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390290AbfFJNT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:19:26 -0400
Received: from foss.arm.com ([217.140.110.172]:42796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388848AbfFJNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:19:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3C0C344;
        Mon, 10 Jun 2019 06:19:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A58933F557;
        Mon, 10 Jun 2019 06:19:23 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:19:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Abel Vesa <abelvesa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bai Ping <ping.bai@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Message-ID: <20190610131921.GB14647@lakrids.cambridge.arm.com>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610121346.15779-1-abel.vesa@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:13:44PM +0300, Abel Vesa wrote:
> This is another alternative for the RFC:
> https://lkml.org/lkml/2019/3/27/545
> 
> This new workaround proposal is a little bit more hacky but more contained
> since everything is done within the irq-imx-gpcv2 driver.
> 
> Basically, it 'hijacks' the registered gic_raise_softirq __smp_cross_call
> handler and registers instead a wrapper which calls in the 'hijacked' 
> handler, after that calling into EL3 which will take care of the actual
> wake up. This time, instead of expanding the PSCI ABI, we use a new vendor SIP.

IIUC from last time [1,2], this erratum affects all interrupts
targetting teh idle CPU, not just IPIs, so even if the bodge is more
self-contained, it doesn't really solve the issue, and there are still
cases where a CPU will not be woken from idle when it should be (e.g.
upon receipt of an LPI).

IIUC, Marc, Lorenzo, and Rafael [1,2,3] all thought that that this was
not worthwhile. What's changed?

Thanks,
Mark.

[1] https://lkml.org/lkml/2019/3/28/197
[2] https://lkml.org/lkml/2019/3/28/203
[3] https://lkml.org/lkml/2019/3/28/198

> 
> I also have the patches ready for TF-A but I'll hold on to them until I see if
> this has a chance of getting in.
> 
> Abel Vesa (2):
>   irqchip: irq-imx-gpcv2: Add workaround for i.MX8MQ ERR11171
>   arm64: dts: imx8mq: Add idle states and gpcv2 wake_request broken
>     property
> 
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 +++++++++++++++
>  drivers/irqchip/irq-imx-gpcv2.c           | 42 +++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> -- 
> 2.7.4
> 
