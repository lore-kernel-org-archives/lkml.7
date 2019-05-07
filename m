Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CDFC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4692087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEGObc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:31:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56028 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfEGObc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:31:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE06680D;
        Tue,  7 May 2019 07:31:31 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ECE73F5C1;
        Tue,  7 May 2019 07:31:29 -0700 (PDT)
Date:   Tue, 7 May 2019 15:31:27 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 1/6] sched/dl: Improve deadline admission control for
 asymmetric CPU capacities
Message-ID: <20190507143125.cjfhdxngcugqmko3@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-2-luca.abeni@santannapisa.it>
 <20190507134850.yreebscc3zigfmtd@queper01-lin>
 <20190507162523.6a405d48@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507162523.6a405d48@nowhere>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 May 2019 at 16:25:23 (+0200), luca abeni wrote:
> On Tue, 7 May 2019 14:48:52 +0100
> Quentin Perret <quentin.perret@arm.com> wrote:
> 
> > Hi Luca,
> > 
> > On Monday 06 May 2019 at 06:48:31 (+0200), Luca Abeni wrote:
> > > diff --git a/drivers/base/arch_topology.c
> > > b/drivers/base/arch_topology.c index edfcf8d982e4..646d6d349d53
> > > 100644 --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -36,6 +36,7 @@ DEFINE_PER_CPU(unsigned long, cpu_scale) =
> > > SCHED_CAPACITY_SCALE; 
> > >  void topology_set_cpu_scale(unsigned int cpu, unsigned long
> > > capacity) {
> > > +	topology_update_cpu_capacity(cpu, per_cpu(cpu_scale, cpu),
> > > capacity);  
> > 
> > Why is that one needed ? Don't you end up re-building the sched
> > domains after this anyways ?
> 
> If I remember correctly, this function was called at boot time when the
> capacities are assigned to the CPU cores.
> 
> I do not remember if the sched domain was re-built after this call, but
> I admit I do not know this part of the kernel very well...

Right and things moved recently in this area, see bb1fbdd3c3fd
("sched/topology, drivers/base/arch_topology: Rebuild the sched_domain
hierarchy when capacities change")

> This achieved the effect of correctly setting up the "rd_capacity"
> field, but I do not know if there is a better/simpler way to achieve
> the same result :)

OK, that's really an implementation detail, so no need to worry too
much about it at the RFC stage I suppose :-)

Thanks,
Quentin
