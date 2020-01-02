Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC297C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265F215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbgABDFu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:05:50 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbgABDFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:05:50 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 60D58FD560CAB9E30672;
        Thu,  2 Jan 2020 11:05:47 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 11:05:47 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0439.000;
 Thu, 2 Jan 2020 11:05:40 +0800
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
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6A=
Date:   Thu, 2 Jan 2020 03:05:40 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
In-Reply-To: <20191231164051.GA4864@bogus>
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

Hi Sudeep:

Thanks for your reply.

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Wednesday, January 01, 2020 12:41 AM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> linux-kernel@vger.kernel.org; Sudeep Holla; Morten Rasmussen
> Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts
> with lower layer
> 
> On Mon, Dec 23, 2019 at 04:16:19PM +0800, z00214469 wrote:
> > As we know, from sched domain's perspective, the DIE layer should be
> > larger than or at least equal to the MC layer, and in some cases, MC
> > is defined by the arch specified hardware, MPIDR for example, but
> NUMA
> > can be defined by users,
> 
> Who are the users you are referring above ?
For example, when I use QEMU to start a guest linux, I can define the
 NUMA topology of the guest linux whatever i want.
> > with the following system configrations:
> 
> Do you mean ACPI tables or DT or some firmware tables ?
> 
> > *************************************
> > NUMA:      	 0-2,  3-7
> 
> Is the above simply wrong with respect to hardware and it actually match
> core_siblings ?
> 
Actually, we can't simply say this is wrong, i just want to show an example.
 And this example also can be:
 NUMA:  0~23,  24~47
 core_siblings:   0-15,  16-31, 32~47

> > core_siblings:   0-3,  4-7
> > *************************************
> > Per the current code, for core 3, its MC cpu map fallbacks to 3~7(its
> > core_sibings is 0~3 while its numa node map is 3~7).
> >
> > For the sched MC, when we are build sched groups:
> > step1. core3 's sched groups chain is built like this: 3->4->5->6->7->3
> > step2. core4's sched groups chain is built like this: 4->5->6->7->4
> > so after step2, core3's sched groups for MC level is overlapped, more
> > importantly, it will fall to dead loop if while(sg != sg->groups)
> >
> > Obviously, the NUMA node with cpu 3-7 conflict with the MC level cpu
> > map, but unfortunately, there is no way even detect such cases.
> >
> 
> Again, is cpu 3-7 actually in a NUMA node or is it 4-7 ?
> 
> > In this patch, prompt a warning message to help with the above cases.
> >
> > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> > ---
> >  drivers/base/arch_topology.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 1eb81f11..5fe44b3 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -439,10 +439,18 @@ const struct cpumask
> *cpu_coregroup_mask(int cpu)
> >  	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
> >  		/* not numa in package, lets use the package siblings */
> >  		core_mask = &cpu_topology[cpu].core_sibling;
> > -	}
> > +	} else
> > +		pr_warn_once("Warning: suspicous broken topology: cpu:[%d]'s
> core_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
> > +			cpu, cpumask_pr_args(&cpu_topology[cpu].core_sibling),
> > +			cpumask_pr_args(core_mask));
> > +
> 
> Won't this print warning on all systems that don't have numa within a
> package ? What are you trying to achieve here ?

Since in my case, when this corner case happens, the linux kernel just fall into
dead loop with no prompt, here this is a helping message will help a lot.

> 
> >  	if (cpu_topology[cpu].llc_id != -1) {
> >  		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
> >  			core_mask = &cpu_topology[cpu].llc_sibling;
> > +		else
> > +			pr_warn_once("Warning: suspicous broken topology:
> cpu:[%d]'s llc_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
> > +				cpu,
> cpumask_pr_args(&cpu_topology[cpu].llc_sibling),
> > +				cpumask_pr_args(core_mask));
> >  	}
> >
> 
> This will trigger warning on all systems that lack cacheinfo topology.
> I don't understand the intent of this patch at all. Can you explain
> all the steps you follow and the issue you face ?

Can you show me an example, what I really want to warn is the case that 
NUMA topology conflicts with lower level. 

> 
> --
> Regards,
> Sudeep
