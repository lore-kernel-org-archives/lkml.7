Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F7C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A6625959
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfE3NMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:12:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfE3NMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:12:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E194A78;
        Thu, 30 May 2019 06:12:48 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C29753F59C;
        Thu, 30 May 2019 06:12:43 -0700 (PDT)
Date:   Thu, 30 May 2019 14:12:41 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-riscv@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v6 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
Message-ID: <20190530131241.GB10919@e105550-lin.cambridge.arm.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-2-atish.patra@wdc.com>
 <49f41e62-5354-a674-d95f-5f63851a0ca6@ti.com>
 <20190530115103.GA10919@e105550-lin.cambridge.arm.com>
 <70639181-09d1-4644-f062-b19e06db7471@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70639181-09d1-4644-f062-b19e06db7471@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 08:56:03AM -0400, Andrew F. Davis wrote:
> On 5/30/19 7:51 AM, Morten Rasmussen wrote:
> >On Wed, May 29, 2019 at 07:39:17PM -0400, Andrew F. Davis wrote:
> >>On 5/29/19 5:13 PM, Atish Patra wrote:
> >>>From: Sudeep Holla <sudeep.holla@arm.com>
> >>>
> >>>The current ARM DT topology description provides the operating system
> >>>with a topological view of the system that is based on leaf nodes
> >>>representing either cores or threads (in an SMT system) and a
> >>>hierarchical set of cluster nodes that creates a hierarchical topology
> >>>view of how those cores and threads are grouped.
> >>>
> >>>However this hierarchical representation of clusters does not allow to
> >>>describe what topology level actually represents the physical package or
> >>>the socket boundary, which is a key piece of information to be used by
> >>>an operating system to optimize resource allocation and scheduling.
> >>>
> >>
> >>Are physical package descriptions really needed? What does "socket" imply
> >>that a higher layer "cluster" node grouping does not? It doesn't imply a
> >>different NUMA distance and the definition of "socket" is already not well
> >>defined, is a dual chiplet processor not just a fancy dual "socket" or are
> >>dual "sockets" on a server board "slotket" card, will we need new names for
> >>those too..
> >
> >Socket (or package) just implies what you suggest, a grouping of CPUs
> >based on the physical socket (or package). Some resources might be
> >associated with packages and more importantly socket information is
> >exposed to user-space. At the moment clusters are being exposed to
> >user-space as sockets which is less than ideal for some topologies.
> >
> 
> I see the benefit of reporting the physical layout and packaging information
> to user-space for tracking reasons, but from software perspective this
> doesn't matter, and the resource partitioning should be described elsewhere
> (NUMA nodes being the go to example).

That would make defining a NUMA node mandatory even for non-NUMA
systems?

> >At the moment user-space is only told about hw threads, cores, and
> >sockets. In the very near future it is going to be told about dies too
> >(look for Len Brown's multi-die patch set).
> >
> 
> Seems my hypothetical case is already in the works :(

Indeed. IIUC, the reasoning behind it is related to actual multi-die
x86 packages and some rapl stuff being per-die or per-core.

> 
> >I don't see how we can provide correct information to user-space based
> >on the current information in DT. I'm not convinced it was a good idea
> >to expose this information to user-space to begin with but that is
> >another discussion.
> >
> 
> Fair enough, it's a little late now to un-expose this info to userspace so
> we should at least present it correctly. My worry was this getting out of
> hand with layering, for instance what happens when we need to add die nodes
> in-between cluster and socket?

If we want the die mask to be correct for arm/arm64/riscv we need die
information from somewhere. I'm not in favour of adding more topology
layers to the user-space visible topology description, but others might
have a valid reason and if it is exposed I would prefer if we try to
expose the right information.

Btw, for packages, we already have that information in ACPI/PPTT so it
would be nice if we could have that for DT based systems too.

Morten
