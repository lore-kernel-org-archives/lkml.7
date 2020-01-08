Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D1C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870D62075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgAHB5o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:57:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2981 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgAHB5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:57:44 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 5BA10D82BF5FA9737FFB;
        Wed,  8 Jan 2020 09:57:42 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 09:57:42 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Wed, 8 Jan 2020 09:57:35 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Topic: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Index: AQHVwRzFqRRtqHdXdESmtZr5m5x/BafeywsAgAE0VVA=
Date:   Wed, 8 Jan 2020 01:57:34 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340B8545@dggemm526-mbx.china.huawei.com>
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
 <20200107144940.GA47473@bogus>
In-Reply-To: <20200107144940.GA47473@bogus>
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
> Sent: Tuesday, January 07, 2020 10:50 PM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki; Sudeep Holla;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] cpu-topology: Skip the exist but not possible cpu
> nodes
> 
> On Thu, Jan 02, 2020 at 11:24:49AM +0800, Zeng Tao wrote:
> > When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the
> device
> > tree, the cpu node parsing will fail. And this is not reasonable for a
> > legal device tree configs.
> > In this patch, skip such cpu nodes rather than return an error.
> >
> > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> > ---
> >  drivers/base/arch_topology.c | 35
> ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 5fe44b3..4cddfeb 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -250,20 +250,34 @@ core_initcall(free_raw_capacity);
> >  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> >  static int __init get_cpu_for_node(struct device_node *node)
> >  {
> > -	struct device_node *cpu_node;
> > +	struct device_node *cpu_node, *t;
> >  	int cpu;
> > +	bool found = false;
> >
> >  	cpu_node = of_parse_phandle(node, "cpu", 0);
> >  	if (!cpu_node)
> > -		return -1;
> > +		return -EINVAL;
> > +
> > +	for_each_of_cpu_node(t)
> > +		if (t == cpu_node) {
> > +			found = true;
> > +			break;
> > +		}
> > +
> > +	if (!found) {
> > +		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> > +		return -EINVAL;
> > +	}
> >
> 
> The whole extra logic added above sounds redundant, details below...

The above logic is different from what is done in of_cpu_node_to_id:
1. The above checks if the cpu node exist in the dts.
2. The of_cpu_node_to_id checks if the cpu node exist in the possible
 cpus.

And basically my idea is:
1. check if the cpu node exist or not.
If not exist, just return an error to indicate that this is a broken dts.
If exist, goto 2.
2. check if the cpu node is a possible one?
And happy to continue if possible, or just skip and warn if not possible.

> 
> >  	cpu = of_cpu_node_to_id(cpu_node);
> >  	if (cpu >= 0)
> >  		topology_parse_cpu_capacity(cpu_node, cpu);
> > -	else
> > -		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> > +	else {
> > +		pr_warn("CPU node for %pOF exist but the possible cpu range
> is :%*pbl\n",
> > +			cpu_node, cpumask_pr_args(cpu_possible_mask));
> > +		cpu = -ENODEV;
> 
> .. of_cpu_node_to_id returns -ENODEV anyways so above assignment is
> also
> redundant. All you achieved is explicit error message. I think we should
> be fine combining them. Just extend existing error log with both message.
> 
> > +	}
> >
> > -	of_node_put(cpu_node);
> >  	return cpu;
> >  }
> >
> > @@ -287,10 +301,13 @@ static int __init parse_core(struct
> device_node *core, int package_id,
> >  				cpu_topology[cpu].core_id = core_id;
> >  				cpu_topology[cpu].thread_id = i;
> >  			} else {
> > -				pr_err("%pOF: Can't get CPU for thread\n",
> > -				       t);
> > +				if (cpu != -ENODEV)
> > +					pr_err("%pOF: Can't get CPU for thread\n",
> > +					       t);
> > +				else
> > +					cpu = 0;
> 
> I would rather use another variable instead of reusing 'cpu'
> 
> >  				of_node_put(t);
> > -				return -EINVAL;
> > +				return cpu;
> 
> Shouldn't we continue here if cpu == -ENODEV instead of returning 0 ?

Good catch, I just focus on core parsing, and thread parsing shoud work 
the same way.

> 
> >  			}
> >  			of_node_put(t);
> >  		}
> > @@ -307,7 +324,7 @@ static int __init parse_core(struct device_node
> *core, int package_id,
> >
> >  		cpu_topology[cpu].package_id = package_id;
> >  		cpu_topology[cpu].core_id = core_id;
> > -	} else if (leaf) {
> > +	} else if (leaf && cpu != -ENODEV) {
> 
> I am still not sure on the approach, it is based on -ENODEV as valid
> error and allow to continue. It may be fine, I just need to make sure.
>

I have the same concern, I have tried to find out some other return values
But seems not good enough.
Maybe it's better to introduce a new function to replace of_cpu_node_to_id
Any good suggestion?

Thanks 

Regards
Zengtao 
