Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92484C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A48021872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDLJzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:55:39 -0400
Received: from foss.arm.com ([217.140.101.70]:56754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfDLJzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:55:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45D0F15AB;
        Fri, 12 Apr 2019 02:55:38 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDE343F59C;
        Fri, 12 Apr 2019 02:55:36 -0700 (PDT)
Date:   Fri, 12 Apr 2019 10:55:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RESEND][PATCH v2] firmware/psci: add support for SYSTEM_RESET2
Message-ID: <20190412095528.GA12424@e107155-lin>
References: <20190411103346.22462-1-sudeep.holla@arm.com>
 <AM0PR07MB6019AB10C7DD38F7AFECF0E0F42F0@AM0PR07MB6019.eurprd07.prod.outlook.com>
 <20190411164936.GB5327@e107155-lin>
 <20190411182637.GC16745@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411182637.GC16745@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 09:26:37PM +0300, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Apr 11, 2019 at 05:49:36PM +0100, Sudeep Holla wrote:
> > On Thu, Apr 11, 2019 at 11:42:28AM +0000, Koskinen, Aaro (Nokia - FI/Espoo) wrote:
> > > From: Sudeep Holla [sudeep.holla@arm.com]:
> > > >  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> > > >  {
> > > > +       if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> > >
> > > I would omit the REBOOT_SOFT here.
> >
> > I included REBOOT_SOFT for 2 reasons:
> > 1. drivers/firmware/efi/reboot.c - efi_reboot treats WARM and SOFT reboots same
> > 2. If the vendors specific reboots are added and handled in EFI, I assume it
> >    will be categorised under REBOOT_SOFT.
> >
> > If that's wrong I can drop REBOOT_SOFT.
>
> Not a big issue, but it's just unclear what SOFT means. WARM at least maps
> nicely to the PSCI spec.
>

OK, I will keep it for now.

> > > > +           psci_system_reset2_supported)
> > > > +               /*
> > > > +                * reset_type[31] = 0 (architectural)
> > > > +                * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
> > > > +                * cookie = 0 (ignored by the implementation)
> > > > +                */
> > > > +               invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
> > > > +
> > > >        invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> > >
> > > Use else here, so that we fall back to system halt if SYSTEM_RESET2 fails.
> >
> > Will that not change current behaviour ? IOW, is that expected behaviour ?
> > I am not sure if halt can be prefer over cold reboot in absence of warm/soft
> > reboot when the system is request to reboot. From PSCI perspective, since
> > SYSTEM_RESET is mandatory I prefer that unless Linux has any restriction
> > on this behaviour.
>
> Hmm, so does it mean that even if firmware tells that SYSTEM_RESET2
> is implemented it does not imply that SYSTEM_WARM_RESET is
> available? I.e. the firmware could choose to implement only some
> vendor-specific resets but not architectural ones. In that case, could
> we fall back to cold reset only if NOT_SUPPORTED is returned? My point
> is that if the warm reset fails unexpectedly, we should halt the system
> like we do if the cold reset fails.
>

OK, I understood. Sorry I was under the assumption that architectural
reset was mandatory if SYSTEM_RESET2 is implemented. I checked the PSCI
specification and I am wrong. So I am happy to add else as per your
suggestion.

--
Regards,
Sudeep
