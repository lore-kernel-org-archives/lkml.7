Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C0BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA9A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDLQqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:46:16 -0400
Received: from foss.arm.com ([217.140.101.70]:36700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLQqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:46:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01D4D15AB;
        Fri, 12 Apr 2019 09:46:15 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F40E3F718;
        Fri, 12 Apr 2019 09:46:11 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:45:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Zeev Zilberman <zeev@amazon.com>, Hanna Hawa <hhhawa@amazon.com>,
        tsahee@annapurnalabs.com, antoine.tenart@bootlin.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, ronenk@amazon.com,
        dwmw@amazon.co.uk, vaerov@amazon.com, alisaidi@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 7/7] irqchip/al-msi: Add ACPI support
Message-ID: <20190412164534.GA9071@red-moon>
References: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
 <1554035733-11827-3-git-send-email-hhhawa@amazon.com>
 <86pnq65v48.wl-marc.zyngier@arm.com>
 <cc40b029-b06e-1367-2411-1ec325d3b97b@amazon.com>
 <a882317e-1f19-3bed-b790-10b8b8a3e839@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a882317e-1f19-3bed-b790-10b8b8a3e839@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 01:08:00PM +0100, Marc Zyngier wrote:
> Hi Zeev,
> 
> On 04/04/2019 15:45, Zeev Zilberman wrote:
> > Hi Marc,
> > 
> > We have considered exposing our interrupt controller both via MADT 
> > OEM-specific entry and via DSDT.
> > We've chosen MADT OEM-specific entry, because it seemed like a 
> > reasonable placeholder for custom interrupt controller, but we can move 
> > to DSDT, if this seems like a better way to represent it.
> > 
> > Either way we chose, we'll need to solve the ordering issue of the 
> > drivers probing.
> > The desired order of driver probing in the system, because of the 
> > dependencies, is:
> > GIC -> AL MSIX controller driver -> PCI
> > If we keep using MADT, we can't just use IRQCHIP_DECLARE, because there 
> > is no way we found to control ordering of MADT probing. So, GIC might be 
> > probed after our driver in this case.
> > The reason we used early_initcall, is that the early_initcalls are 
> > invoked after MADT probing in the system (and before DSDT probing).
> > 
> > If we move to using DSDT we need to solve the ordering problem from 
> > another direction - make sure that MSIX driver is probed before PCI.
> > In the patches that were posted for xgene interrupt controller (and 
> > weren't accepted) we saw that they proposed to solve the same issue
> > by modifying ACPI subsystem code by defining a new type for msi drivers 
> > and probing them before PCI drivers 
> > (https://patchwork.ozlabs.org/patch/818771/).
> >  From the feedback on that patch 
> > (https://patchwork.ozlabs.org/cover/818767/#1788415) it seemed that 
> > alternative solution is in the works,
> > but we didn't manage to find any followup on this.
> > 
> > We would be glad to hear what you propose for fixing the ordering issue 
> > and rework the patches accordingly.
> 
> There are multiple issues here, but the main one is that you're trying
> to do something that is completely contrary to the ACPI spec by
> inventing a new interrupt controller.
> 
> The use case for ACPI is quite simple: you have HW that matches the ACPI
> spec, and everything will work out of the box. This means GICv2+GICv2m
> or GICv3+ITS. There is zero space for creativity. Now, if you want your
> own interrupt controller, the only choice is to stick with DT. That's
> the place for weird and wonderful stuff that ACPI cannot support.
> 
> We've been around the block with XGene, and every "solution" was just
> utter crap, prone to failure and in the end unmaintainable. Anything
> involving an initcall definitely falls into that category.
> 
> I'll let Lorenzo speak his mind as the arm64 ACPI maintainer, but from
> an irqchip perspective, I can't see how to support this unless we get
> the ACPI spec to support this type of configuration.

That's pretty much it, as a matter of fact there is not much we can do,
actually it is a problem that {should have been/can be} solved first at
ACPI spec level, every kludge we put together to fix eg Xgene ended up
having implicit dependencies/requirements on firmware that are
non-existing from an ACPI spec binding perspective (eg DSDT objects
ordering).

It is not a kernel problem, however we put it, we can't guess an
IRQ controllers dependency that can't be described.

Lorenzo
