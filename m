Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A32EC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B8E21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgABMrM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 07:47:12 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:42558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbgABMrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:47:11 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id E330456DA67CEAB62900;
        Thu,  2 Jan 2020 20:47:08 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 20:47:08 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0439.000;
 Thu, 2 Jan 2020 20:47:01 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Morten Rasmussen" <morten.rasmussen@arm.com>
Subject: RE: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Topic: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6CAAAyngIAAlqWw
Date:   Thu, 2 Jan 2020 12:47:01 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
In-Reply-To: <20200102112955.GC4864@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Thursday, January 02, 2020 7:30 PM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> linux-kernel@vger.kernel.org; Morten Rasmussen
> Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts
> with lower layer
> 
> On Thu, Jan 02, 2020 at 03:05:40AM +0000, Zengtao (B) wrote:
> > Hi Sudeep:
> >
> > Thanks for your reply.
> >
> > > -----Original Message-----
> > > From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> > > Sent: Wednesday, January 01, 2020 12:41 AM
> > > To: Zengtao (B)
> > > Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> > > linux-kernel@vger.kernel.org; Sudeep Holla; Morten Rasmussen
> > > Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations
> conflicts
> > > with lower layer
> > >
> > > On Mon, Dec 23, 2019 at 04:16:19PM +0800, z00214469 wrote:
> > > > As we know, from sched domain's perspective, the DIE layer should
> be
> > > > larger than or at least equal to the MC layer, and in some cases, MC
> > > > is defined by the arch specified hardware, MPIDR for example, but
> > > NUMA
> > > > can be defined by users,
> > >
> > > Who are the users you are referring above ?
> > For example, when I use QEMU to start a guest linux, I can define the
> > NUMA topology of the guest linux whatever i want.
> 
> OK and how is the information passed to the kernel ? DT or ACPI ?
> We need to fix the miss match if any during the initial parse of those
> information.
> 

Both, For the current QEMU, we don't have the correct cpu topology
passed to linux. Luckily drjones planed to deal with the issue.
https://patchwork.ozlabs.org/cover/939301/

> > > > with the following system configrations:
> > >
> > > Do you mean ACPI tables or DT or some firmware tables ?
> > >
> > > > *************************************
> > > > NUMA:      	 0-2,  3-7
> > >
> > > Is the above simply wrong with respect to hardware and it actually
> match
> > > core_siblings ?
> > >
> > Actually, we can't simply say this is wrong, i just want to show an
> example.
> > And this example also can be:
> > NUMA:  0-23,  24-47
> > core_siblings:   0-15,  16-31, 32-47
> >
> 
> Are you sure of the above ? Possible values w.r.t hardware config:
> core_siblings:   0-15,  16-23, 24-31, 32-47
> 
> But what you have specified above is still wrong core_siblings IMO.
> 
It depends on the hardware, on my platform, 16 cores per cluster.

> 
> [...]
> 
> > > > diff --git a/drivers/base/arch_topology.c
> b/drivers/base/arch_topology.c
> > > > index 1eb81f11..5fe44b3 100644
> > > > --- a/drivers/base/arch_topology.c
> > > > +++ b/drivers/base/arch_topology.c
> > > > @@ -439,10 +439,18 @@ const struct cpumask
> > > *cpu_coregroup_mask(int cpu)
> > > >  	if (cpumask_subset(&cpu_topology[cpu].core_sibling,
> core_mask)) {
> > > >  		/* not numa in package, lets use the package siblings */
> > > >  		core_mask = &cpu_topology[cpu].core_sibling;
> > > > -	}
> > > > +	} else
> > > > +		pr_warn_once("Warning: suspicous broken topology:
> cpu:[%d]'s
> > > core_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
> > > > +			cpu,
> cpumask_pr_args(&cpu_topology[cpu].core_sibling),
> > > > +			cpumask_pr_args(core_mask));
> > > > +
> > >
> > > Won't this print warning on all systems that don't have numa within a
> > > package ? What are you trying to achieve here ?
> >
> > Since in my case, when this corner case happens, the linux kernel just fall
> into
> > dead loop with no prompt, here this is a helping message will help a lot.
> >
> 
> As I said, wrong configurations need to be detected when generating
> DT/ACPI if possible. The above will print warning on systems with NUMA
> within package.
> 
> NUMA:  0-7, 8-15
> core_siblings:   0-15
> 
> The above is the example where the die has 16 CPUs and 2 NUMA nodes
> within a package, your change throws error to the above config which is
> wrong.
>
From your example, the core 7 and core 8 has got different LLC but the same Low
Level cache?
From schedule view of point, lower level sched domain should be a subset of higher
Level sched domain.

> > >
> > > >  	if (cpu_topology[cpu].llc_id != -1) {
> > > >  		if (cpumask_subset(&cpu_topology[cpu].llc_sibling,
> core_mask))
> > > >  			core_mask = &cpu_topology[cpu].llc_sibling;
> > > > +		else
> > > > +			pr_warn_once("Warning: suspicous broken topology:
> > > cpu:[%d]'s llc_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
> > > > +				cpu,
> > > cpumask_pr_args(&cpu_topology[cpu].llc_sibling),
> > > > +				cpumask_pr_args(core_mask));
> > > >  	}
> > > >
> > >
> > > This will trigger warning on all systems that lack cacheinfo topology.
> > > I don't understand the intent of this patch at all. Can you explain
> > > all the steps you follow and the issue you face ?
> >
> > Can you show me an example, what I really want to warn is the case that
> > NUMA topology conflicts with lower level.
> >
> 
> I was wrong here, I mis-read this section. I still fail to understand
> why the above change is needed. I understood the QEMU example, but you
> haven't specified how cacheinfo looks like there.
> 

My idea:
(1) If the dtb/acpi is not legal, the linux kernel should check or prompt to help debug.
(2)From scheduler view of point, low level sched domain should be a subset of high level
Sched domain.

I am very sure about (2), any example to show me (2) is wrong?

Thanks. 
Zengtao 

