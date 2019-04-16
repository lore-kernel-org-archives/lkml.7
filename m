Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA08C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A832077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfDPNXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:23:31 -0400
Received: from foss.arm.com ([217.140.101.70]:54918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDPNXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:23:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D25EBD;
        Tue, 16 Apr 2019 06:23:30 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05E23F557;
        Tue, 16 Apr 2019 06:23:26 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:23:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFT/RFC PATCH v3 3/5] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20190416132324.GB24669@e107155-lin>
References: <20190320234806.19748-1-atish.patra@wdc.com>
 <20190320234806.19748-4-atish.patra@wdc.com>
 <20190415152741.GA28623@e107155-lin>
 <5c5b720f-414a-706c-3415-642c27baef1f@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c5b720f-414a-706c-3415-642c27baef1f@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:08:45PM -0700, Atish Patra wrote:
> On 4/15/19 8:27 AM, Sudeep Holla wrote:
> > Hi Atish,
> >
> > Thanks again for doing this. Overall changes look good except a couple
> > of minor nit, see below.
> >
> > On Wed, Mar 20, 2019 at 04:48:04PM -0700, Atish Patra wrote:
> > > Both RISC-V & ARM64 are using cpu-map device tree to describe
> > > their cpu topology. It's better to move the relevant code to
> > > a common place instead of duplicate code.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > > ---
> > >   arch/arm64/include/asm/topology.h |  23 ---
> > >   arch/arm64/kernel/topology.c      | 303 +-----------------------------
> > >   drivers/base/arch_topology.c      | 298 ++++++++++++++++++++++++++++-
> > >   drivers/base/topology.c           |   1 +
> > >   include/linux/arch_topology.h     |  28 +++
> > >   5 files changed, 330 insertions(+), 323 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > index edfcf8d9..6cc6a860 100644
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -6,8 +6,8 @@
> > >    * Written by: Juri Lelli, ARM Ltd.
> > >    */
> > > -#include <linux/acpi.h>
> > >   #include <linux/arch_topology.h>
> > > +#include <linux/acpi.h>
> > >   #include <linux/cpu.h>
> > >   #include <linux/cpufreq.h>
> > >   #include <linux/device.h>
> > > @@ -16,6 +16,11 @@
> > >   #include <linux/string.h>
> > >   #include <linux/sched/topology.h>
> > >   #include <linux/cpuset.h>
> > > +#include <linux/cpumask.h>
> > > +#include <linux/init.h>
> > > +#include <linux/percpu.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/smp.h>
> > >   DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> > > @@ -278,3 +283,294 @@ static void parsing_done_workfn(struct work_struct *work)
> > >   #else
> > >   core_initcall(free_raw_capacity);
> > >   #endif
> > > +
> > > +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> >
> > Why can't the above one be just GENERIC_ARCH_TOPOLOGY ?
> > I may be missing to find it myself, but would like to know.
> >
> GENERIC_ARCH_TOPOLOGY is now used for both RISCV, ARM & ARM64.
> The below functions under this #ifdef have different implementation for ARM
> and ARM64.
>
> parse_dt_topology
> cpu_coregroup_mask
> update_siblings_masks
>
> While we can combine the later two functions and move them to common code as
> well, parse_dt_topology is significantly different.
>

Sure, had a quick glance and indeed they may look different, but won't
it defeat the purpose of this binding consolidation ?

> That's why we need some kind of #ifdef or renaming of parse_dt_topology for
> ARM32 code.
>

I am fine if we want to take this up later to keep the impact minimum.
But cpu_coregroup_mask and update_siblings_masks can and must be unified.
In fact the existing generic version must work on ARM32 too.

> Thanks for the review!!
>

You are welcome.

--
Regards,
Sudeep
