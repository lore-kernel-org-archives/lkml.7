Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BACC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F82070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570091400;
	bh=Q+ALnmiIQm4I+dBjWKqJOW6YOe9VQb6alWxAIjH2W2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Smi3ktcL75VXE4cvUh7tnitMajvRdlQY+8DqfsE9rRD8ykhgJ+UJ7zDpPTvLX70Jv
	 c0bzRCZR4slTGMffQIbNwRWErqytaXusM9WCb5omFJHHA/OEsfAZSBs0TblRcX4tMs
	 hJu2EakkqfuljWwRlF29of1csR8nEyQZjz/H6h2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfJCIaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:30:00 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:44786 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbfJCI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:29:59 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFwUh-0004Iy-Pa; Thu, 03 Oct 2019 10:29:51 +0200
Date:   Thu, 3 Oct 2019 09:29:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/7] irqchip/irq-bcm2836: Add support for the 7211
 interrupt controller
Message-ID: <20191003092950.04440d74@why>
In-Reply-To: <72f07d2e-b070-301a-6a5d-8e89d32adcd7@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
        <20191001224842.9382-6-f.fainelli@gmail.com>
        <20191002134041.5a181d96@why>
        <72f07d2e-b070-301a-6a5d-8e89d32adcd7@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, eric@anholt.net, wahrenst@gmx.net, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019 10:06:31 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 10/2/19 5:40 AM, Marc Zyngier wrote:
> > On Tue,  1 Oct 2019 15:48:40 -0700
> > Florian Fainelli <f.fainelli@gmail.com> wrote:
> >   
> >> The root interrupt controller on 7211 is about identical to the one
> >> existing on BCM2836, except that the SMP cross call are done through the
> >> standard ARM GIC-400 interrupt controller. This interrupt controller is
> >> used for side band wake-up signals though.  
> > 
> > I don't fully grasp how this thing works.
> > 
> > If the 7211 interrupt controller is root and the GIC is used for SGIs,
> > this means that the GIC outputs (IRQ/FIQ/VIRQ/VFIQ, times eight) are
> > connected to individual inputs to the 7211 controller. Seems totally
> > braindead, and unexpectedly so.
> > 
> > If the GIC is root and the 7211 outputs into the GIC all of its
> > interrupts as a secondary irqchip, it would at least match an existing
> > (and pretty bad) pattern.
> > 
> > So which one of the two is it?  
> 
> The nominal configuration on 7211 is to have all interrupts go through
> the ARM GIC. It is possible however, to fallback to the legacy 2836 mode
> whereby the root interrupt controller for peripheral interrupts is this
> ARMCTL IC. There is a mux that the firmware can control which will
> dictate which root interrupt controller is used for peripherals.
> 
> I have used this mostly for silicon verification and since those are
> fairly harmless patches, just decided to send them out to avoid
> maintaining them out of tree.

This doesn't really answer my question. What I understand is that your
system is laid out like this:

     DEVICES -> ARMCTL -> CPUs
                  ^
                 GIC

How are the various GIC outputs mapped into the ARMCTL? It has 4 of
them per CPU (IRQ/FIQ + vIRQ/vFIQ), which the ARMCTL must somehow map
to its own interrupts, specially if you want to signal IPIs using the
GIC's SGIs (to which you hint in the commit log).

There is a link I'm missing here.

> We have a plan to use those as an "alternate" interrupt domain for low
> power modes and use the fact that peripheral interrupts could be active
> in both domains (GIC and ARMCTRL IC) to help support configuring and
> identifying wake-up sources fro m within Linux.

That's usually done with a hierarchy, where the ARMCTL IC would be a
child of the GIC and see all interrupt configuration calls before they
reach the GIC driver. We have plenty of examples in the tree already.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
