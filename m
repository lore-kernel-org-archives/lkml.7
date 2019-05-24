Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA04EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB41B2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfEXR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:57:11 -0400
Received: from foss.arm.com ([217.140.101.70]:48016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfEXR5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:57:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C1C4A78;
        Fri, 24 May 2019 10:57:09 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1993F703;
        Fri, 24 May 2019 10:57:06 -0700 (PDT)
Date:   Fri, 24 May 2019 18:56:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Message-ID: <20190524175658.GA5045@e107155-lin>
References: <20190523060437.11059-1-peng.fan@nxp.com>
 <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:30:50AM -0700, Florian Fainelli wrote:
> Hi,
>
> On 5/22/19 10:50 PM, Peng Fan wrote:
> > This is a modified version from Andre Przywara's patch series
> > https://lore.kernel.org/patchwork/cover/812997/.
> > [1] is a draft implementation of i.MX8MM SCMI ATF implementation that
> > use smc as mailbox, power/clk is included, but only part of clk has been
> > implemented to work with hardware, power domain only supports get name
> > for now.
> >
> > The traditional Linux mailbox mechanism uses some kind of dedicated hardware
> > IP to signal a condition to some other processing unit, typically a dedicated
> > management processor.
> > This mailbox feature is used for instance by the SCMI protocol to signal a
> > request for some action to be taken by the management processor.
> > However some SoCs does not have a dedicated management core to provide
> > those services. In order to service TEE and to avoid linux shutdown
> > power and clock that used by TEE, need let firmware to handle power
> > and clock, the firmware here is ARM Trusted Firmware that could also
> > run SCMI service.
> >
> > The existing SCMI implementation uses a rather flexible shared memory
> > region to communicate commands and their parameters, it still requires a
> > mailbox to actually trigger the action.
>
> We have had something similar done internally with a couple of minor
> differences:
>
> - a SGI is used to send SCMI notifications/delayed replies to support
> asynchronism (patches are in the works to actually add that to the Linux
> SCMI framework). There is no good support for SGI in the kernel right
> now so we hacked up something from the existing SMP code and adding the
> ability to register our own IPI handlers (SHAME!). Using a PPI should
> work and should allow for using request_irq() AFAICT.
>

We have been thinking this since we were asked if SMC can be transport.
Generally out of 16 SGIs, 8 are reserved for secure side and non-secure
has 8. Of these 8, IIUC 7 is already being used by kernel. So unless we
manage to get the last one reserved exclusive to SCMI, it makes it
difficult to add SGI support in SCMI.

We have been telling partners/vendors about this limitation if they
use SMC as transport and need to have dedicated h/w interrupt for the
notifications.

Another issue could be with virtualisation(using HVC) and EL handling
so called SCMI SGI. We need to think about those too. I will try to get
more info on this and come back on this.

--
Regards,
Sudeep
