Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E32FC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C12720862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbfFJKAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:00:38 -0400
Received: from foss.arm.com ([217.140.110.172]:39332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388056AbfFJKAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:00:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F84C344;
        Mon, 10 Jun 2019 03:00:37 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B2E13F246;
        Mon, 10 Jun 2019 03:02:17 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:00:33 +0100
From:   Andre Przywara <andre.przywara@foss.arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20190610110033.28d21d21@donnerap.cambridge.arm.com>
In-Reply-To: <AM0PR04MB448168C72F1D40C1B9BEB1F788130@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
        <20190603083005.4304-3-peng.fan@nxp.com>
        <866db682-785a-e0a6-b394-bb65c7a694c6@gmail.com>
        <20190606142056.68272dc0@donnerap.cambridge.arm.com>
        <AM0PR04MB448168C72F1D40C1B9BEB1F788130@AM0PR04MB4481.eurprd04.prod.outlook.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 01:32:49 +0000
Peng Fan <peng.fan@nxp.com> wrote:

Hi Peng,

[ ... ]

> > > > +
> > > > +	irq_count = platform_irq_count(pdev);
> > > > +	if (irq_count == -EPROBE_DEFER)
> > > > +		return irq_count;
> > > > +
> > > > +	if (irq_count && irq_count != val) {
> > > > +		dev_err(dev, "Interrupts not match num-chans\n");  
> > >
> > > Interrupts property does not match \"arm,num-chans\" would be more  
> > correct.
> > 
> > Given that interrupts are optional, do we have to rely on this?   
> 
> If there is interrupt property, the interrupts should match channel counts.
> 
> Do we actually
> > need one interrupt per channel?  
> 
> I thought about this, provide one interrupt for all channels.
> But there is no good way to let interrupt handlers know which
> channel triggers the interrupt. So I use one interrupt per channel.

Yeah, I was wondering about this as well. Seems like we need this indeed.
Just sounds wasteful, but I guess we don't expect many channels anyway,
normally.

Cheers,
Andre.
