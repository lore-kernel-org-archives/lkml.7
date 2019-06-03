Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCB2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D7D2744C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfFCRYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:24:48 -0400
Received: from foss.arm.com ([217.140.101.70]:56416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfFCRYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:24:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF6BA15AB;
        Mon,  3 Jun 2019 10:24:47 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A4F3F5AF;
        Mon,  3 Jun 2019 10:24:45 -0700 (PDT)
Date:   Mon, 3 Jun 2019 18:24:42 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Message-ID: <20190603182442.4183959b@donnerap.cambridge.arm.com>
In-Reply-To: <AM0PR04MB4481C97696C68ECF5E6D4A7988190@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190523060437.11059-1-peng.fan@nxp.com>
        <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
        <AM0PR04MB4481C44F9B5EFCDD076EF728881D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <20190530122329.235d13c7@donnerap.cambridge.arm.com>
        <AM0PR04MB4481C97696C68ECF5E6D4A7988190@AM0PR04MB4481.eurprd04.prod.outlook.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 01:39:45 +0000
Peng Fan <peng.fan@nxp.com> wrote:

Hi,

(CC:ing Julien for Xen)

> > > > Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered
> > > > mailbox
> > > >
> > > > Hi,
> > > >
> > > > On 5/22/19 10:50 PM, Peng Fan wrote:  
> > > > > This is a modified version from Andre Przywara's patch series
> > > > >  
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
> > > > re.ke  
> > rnel.org%2Fpatchwork%2Fcover%2F812997%2F&amp;data=02%7C01%7Cpe  
> > > >  
> > ng.fan%40nxp.com%7C010c9ddd5df645c9c66b08d6dfa46cb2%7C686ea1d3b  
> > > >  
> > c2b4c6fa92cd99c5c301635%7C0%7C0%7C636942294631442665&amp;sdat  
> > > >  
> > a=BbS5ZQtzMANSwaKRDJ62NKrPrAyaED1%2BvymQaT6Qr8E%3D&amp;rese  
> > > > rved=0.  
> > > > > [1] is a draft implementation of i.MX8MM SCMI ATF implementation
> > > > > that use smc as mailbox, power/clk is included, but only part of
> > > > > clk has been implemented to work with hardware, power domain only
> > > > > supports get name for now.
> > > > >
> > > > > The traditional Linux mailbox mechanism uses some kind of
> > > > > dedicated hardware IP to signal a condition to some other
> > > > > processing unit, typically a dedicated management processor.
> > > > > This mailbox feature is used for instance by the SCMI protocol to
> > > > > signal a request for some action to be taken by the management  
> > processor.  
> > > > > However some SoCs does not have a dedicated management core to  
> > > > provide  
> > > > > those services. In order to service TEE and to avoid linux
> > > > > shutdown power and clock that used by TEE, need let firmware to
> > > > > handle power and clock, the firmware here is ARM Trusted Firmware
> > > > > that could also run SCMI service.
> > > > >
> > > > > The existing SCMI implementation uses a rather flexible shared
> > > > > memory region to communicate commands and their parameters, it
> > > > > still requires a mailbox to actually trigger the action.  
> > > >
> > > > We have had something similar done internally with a couple of minor
> > > > differences:
> > > >
> > > > - a SGI is used to send SCMI notifications/delayed replies to
> > > > support asynchronism (patches are in the works to actually add that
> > > > to the Linux SCMI framework). There is no good support for SGI in
> > > > the kernel right now so we hacked up something from the existing SMP
> > > > code and adding the ability to register our own IPI handlers
> > > > (SHAME!). Using a PPI should work and should allow for using request_irq()  
> > AFAICT.  
> > >
> > > So you are also implementing a firmware inside ATF for SCMI usecase, right?
> > >
> > > Introducing SGI in ATF to notify Linux will introduce complexity,
> > > there is no good framework inside ATF for SCMI, and I use
> > > synchronization call for simplicity for now.  
> > 
> > I think we don't disagree, but just to clarify on one thing:
> > 
> > I think we should avoid tying this driver to specific protocol or software on the
> > other end, be it ATF or SCMI. After all it's just a mailbox driver, meant to signal
> > some event (and parameters) to some external entity. Yes, SCMI (or SCPI back
> > then) was the reason to push for this, but it should be independent from that.  
> 
> Thanks, I agree.
> 
> > I am not even sure we should mention it too much in the documentation.  
> 
> I think we need a usecase here, so it should be fine.
> 
> > 
> > So whether the receiving end is ATF or something else it irrelevant, I think. For
> > instance we have had discussions in Xen to provide guests some virtualised
> > device management support, and using an HVC mailbox seems like a neat
> > solution. This could be using the SCMI (or SCPI) protocol, but that's not a
> > requirement. In this case the Xen hypervisor would be the one to pick up the
> > mailbox trigger, probably forwarding the request to something else (Dom0 in
> > this case).  
> 
> I do not get the point "forwarding the request", DomU HVC will trap to Xen,
> so how to forward to Dom0?

I don't think there is something easily available in Xen/ARM at the moment, but we could either use something like an event channel, or utilise some planned extension to allow Dom0 to register on MMIO traps.
My point was that most likely Dom0 would be in control of the resources handled by the interface (clocks, regulators), so Xen wouldn't know how to deal with those requests.

Cheers,
Andre.


> 
> Thanks,
> Peng.
> 
> > Also having a generic SMC mailbox could avoid having the actual hardware
> > mailbox drivers in the kernel, so EL3 firmware could forward the request to an
> > external management processor, and Linux would just work, without the need
> > to describe the actual hardware mailbox device in some firmware tables. This
> > might help ACPI on those devices.
> > 
> > Cheers,
> > Andre.
> >   
> > > >
> > > > - the mailbox identifier is indicated as part of the SMC call such
> > > > that we can have multiple SCMI mailboxes serving both standard
> > > > protocols and non-standard (in the 0x80 and above) range, also they
> > > > may have different throughput (in hindsight, these could simply be
> > > > different channels)
> > > >
> > > > Your patch series looks both good and useful to me, I would just put
> > > > a provision in the binding to support an optional interrupt such
> > > > that asynchronism gets reasonably easy to plug in when it is
> > > > available (and desirable).  
> > >
> > > Ok. Let me think about and add that in new version patch.
> > >
> > > Thanks,
> > > Peng.
> > >  
> > > >  
> > > > >
> > > > > This patch series provides a Linux mailbox compatible service
> > > > > which uses smc calls to invoke firmware code, for instance taking
> > > > > care of SCMI  
> > > > requests.  
> > > > > The actual requests are still communicated using the standard SCMI
> > > > > way of shared memory regions, but a dedicated mailbox hardware IP
> > > > > can be replaced via this new driver.
> > > > >
> > > > > This simple driver uses the architected SMC calling convention to
> > > > > trigger firmware services, also allows for using "HVC" calls to
> > > > > call into hypervisors or firmware layers running in the EL2 exception  
> > level.  
> > > > >
> > > > > Patch 1 contains the device tree binding documentation, patch 2
> > > > > introduces the actual mailbox driver.
> > > > >
> > > > > Please note that this driver just provides a generic mailbox
> > > > > mechanism, though this is synchronous and one-way only (triggered
> > > > > by the OS only, without providing an asynchronous way of
> > > > > triggering request from the firmware).
> > > > > And while providing SCMI services was the reason for this
> > > > > exercise, this driver is in no way bound to this use case, but can
> > > > > be used generically where the OS wants to signal a mailbox
> > > > > condition to firmware or a hypervisor.
> > > > > Also the driver is in no way meant to replace any existing
> > > > > firmware interface, but actually to complement existing interfaces.
> > > > >
> > > > > [1]
> > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > > gith
> > > > >  
> > > >  
> > ub.com%2FMrVan%2Farm-trusted-firmware%2Ftree%2Fscmi&amp;data=02  
> > > > %7C01%7  
> > > > >  
> > > >  
> > Cpeng.fan%40nxp.com%7C010c9ddd5df645c9c66b08d6dfa46cb2%7C686ea1  
> > > > d3bc2b4  
> > > > >  
> > > >  
> > c6fa92cd99c5c301635%7C0%7C0%7C636942294631442665&amp;sdata=kN  
> > > > 9bEFFcsZA  
> > > > > 1ePeNLLfHmONpVaG6O5ajVQvKMuaBXyk%3D&amp;reserved=0
> > > > >
> > > > > Peng Fan (2):
> > > > >   DT: mailbox: add binding doc for the ARM SMC mailbox
> > > > >   mailbox: introduce ARM SMC based mailbox
> > > > >
> > > > >  .../devicetree/bindings/mailbox/arm-smc.txt        |  96  
> > > > +++++++++++++  
> > > > >  drivers/mailbox/Kconfig                            |   7 +
> > > > >  drivers/mailbox/Makefile                           |   2 +
> > > > >  drivers/mailbox/arm-smc-mailbox.c                  | 154  
> > > > +++++++++++++++++++++  
> > > > >  include/linux/mailbox/arm-smc-mailbox.h            |  10 ++
> > > > >  5 files changed, 269 insertions(+)  create mode 100644
> > > > > Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > > >  create mode 100644 drivers/mailbox/arm-smc-mailbox.c  create  
> > mode  
> > > > > 100644 include/linux/mailbox/arm-smc-mailbox.h
> > > > >  
> > > >
> > > >
> > > > --
> > > > Florian  
> 

