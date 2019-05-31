Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67CAC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E352673B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfEaJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:54:36 -0400
Received: from foss.arm.com ([217.140.101.70]:49254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfEaJyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:54:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFAB5341;
        Fri, 31 May 2019 02:54:34 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9353F59C;
        Fri, 31 May 2019 02:54:30 -0700 (PDT)
Date:   Fri, 31 May 2019 10:54:28 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "Andrew F. Davis" <afd@ti.com>, Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
Message-ID: <20190531095428.GC10919@e105550-lin.cambridge.arm.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-2-atish.patra@wdc.com>
 <49f41e62-5354-a674-d95f-5f63851a0ca6@ti.com>
 <20190530115103.GA10919@e105550-lin.cambridge.arm.com>
 <20190530214254.tuxsnyv52a2fyhck@shell.armlinux.org.uk>
 <20190531093743.GB18292@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531093743.GB18292@e107155-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:37:43AM +0100, Sudeep Holla wrote:
> On Thu, May 30, 2019 at 10:42:54PM +0100, Russell King - ARM Linux admin wrote:
> > On Thu, May 30, 2019 at 12:51:03PM +0100, Morten Rasmussen wrote:
> > > On Wed, May 29, 2019 at 07:39:17PM -0400, Andrew F. Davis wrote:
> > > > On 5/29/19 5:13 PM, Atish Patra wrote:
> > > > >From: Sudeep Holla <sudeep.holla@arm.com>
> > > > >
> > > > >The current ARM DT topology description provides the operating system
> > > > >with a topological view of the system that is based on leaf nodes
> > > > >representing either cores or threads (in an SMT system) and a
> > > > >hierarchical set of cluster nodes that creates a hierarchical topology
> > > > >view of how those cores and threads are grouped.
> > > > >
> > > > >However this hierarchical representation of clusters does not allow to
> > > > >describe what topology level actually represents the physical package or
> > > > >the socket boundary, which is a key piece of information to be used by
> > > > >an operating system to optimize resource allocation and scheduling.
> > > > >
> > > >
> > > > Are physical package descriptions really needed? What does "socket" imply
> > > > that a higher layer "cluster" node grouping does not? It doesn't imply a
> > > > different NUMA distance and the definition of "socket" is already not well
> > > > defined, is a dual chiplet processor not just a fancy dual "socket" or are
> > > > dual "sockets" on a server board "slotket" card, will we need new names for
> > > > those too..
> > >
> > > Socket (or package) just implies what you suggest, a grouping of CPUs
> > > based on the physical socket (or package). Some resources might be
> > > associated with packages and more importantly socket information is
> > > exposed to user-space. At the moment clusters are being exposed to
> > > user-space as sockets which is less than ideal for some topologies.
> >
> > Please point out a 32-bit ARM system that has multiple "socket"s.
> >
> > As far as I'm aware, all 32-bit systems do not have socketed CPUs
> > (modern ARM CPUs are part of a larger SoC), and the CPUs are always
> > in one package.
> >
> > Even the test systems I've seen do not have socketed CPUs.
> >
> 
> As far as we know, there's none. So we simply have to assume all
> those systems are single socket(IOW all CPUs reside inside a single
> SoC package) system.

Right, but we don't make that assumption. Clusters are reported as
sockets/packages for arm, just like they are for arm64. My comment above
applied to what can be described using DT, not what systems actually
exists. We need to be able describe packages for architecture where we
can't make assumptions.

arm example (ARM TC2):
root@morras01-tc2:~# lstopo
Machine (985MB)
  Package L#0
    Core L#0 + PU L#0 (P#0)
    Core L#1 + PU L#1 (P#1)
  Package L#1
    Core L#2 + PU L#2 (P#2)
    Core L#3 + PU L#3 (P#3)
    Core L#4 + PU L#4 (P#4)

Morten
