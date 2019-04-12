Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5FD2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfDLNmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:42:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfDLNmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:42:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C342E374;
        Fri, 12 Apr 2019 06:42:31 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0A973F68F;
        Fri, 12 Apr 2019 06:42:29 -0700 (PDT)
Date:   Fri, 12 Apr 2019 14:42:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3] firmware/psci: add support for SYSTEM_RESET2
Message-ID: <20190412134200.GA23351@e107155-lin>
References: <20190412100227.15024-1-sudeep.holla@arm.com>
 <2000694.m04KBuNrDd@kreacher>
 <20190412101522.GB12424@e107155-lin>
 <CAPDyKFrM8hc36vp=2h1CHBZKapy1q242JD3Y5SfrCg-KWA-twg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrM8hc36vp=2h1CHBZKapy1q242JD3Y5SfrCg-KWA-twg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:37:05PM +0200, Ulf Hansson wrote:
> Sudeep, Lorenzo, Mark
> 
> On Fri, 12 Apr 2019 at 12:15, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Apr 12, 2019 at 12:10:45PM +0200, Rafael J. Wysocki wrote:
> > > On Friday, April 12, 2019 12:02:27 PM CEST Sudeep Holla wrote:
> > > > PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
> > > > where the semantics are described by the PSCI specification itself as
> > > > well as vendor-specific resets. Currently only system warm reset
> > > > semantics is defined as part of architectural resets by the specification.
> > > >
> > > > This patch implements support for SYSTEM_RESET2 by making using of
> > > > reboot_mode passed by the reboot infrastructure in the kernel.
> > > >
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/firmware/psci.c   | 24 +++++++++++++++++++++++-
> > > >  include/uapi/linux/psci.h |  2 ++
> > > >  2 files changed, 25 insertions(+), 1 deletion(-)
> >
> > [...]
> >
> > > > --
> > >
> > > So I queued up the PSCI series from Ulf which clashes with this patch.
> > >
> >
> > Ah OK, I wasn't aware(just back from holiday) that it's going through
> > your tree. No worries, I will rebase and repost soon. I want testing
> > by xilinx or Aaro Koskinen before that.
> >
> > > I can take this one too, but I'd rather avoid becoming a PSCI maintainer as a
> > > result. :-)
> > >
> >
> > I can understand, I assure it's one off :)
>
> Speaking about that. I would gladly help out to host a git tree to
> collect patches that you have acked. In this way, we can, for example,
> get the patches pre-tested in linux next before we send the
> pull-request.
>
> If you think sounds like a good idea, just tell me so I can prepare a
> tree for the next release cycle...
>

For now, I just have this one patch. So if Rafael has queued all your
patches, I can just rebase and post it once I get tested-by from Aaro
Koskinen, so that Rafael can queue this too. Or are you planning to
send PR to Rafael, sorry if I missed details already discussed on the
list.

--
Regards,
Sudeep
