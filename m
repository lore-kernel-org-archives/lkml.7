Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEC9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7A220866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgACRUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:20:38 -0500
Received: from foss.arm.com ([217.140.110.172]:57204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgACRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:20:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864A7328;
        Fri,  3 Jan 2020 09:20:37 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 457A33F703;
        Fri,  3 Jan 2020 09:20:36 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <7b375d79-2d3c-422b-27a6-68972fbcbeaf@arm.com>
 <66943c82-2cfd-351b-7f36-5aefdb196a03@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c0e82c31-8ed6-4739-6b01-2594c58df95a@arm.com>
Date:   Fri, 3 Jan 2020 18:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <66943c82-2cfd-351b-7f36-5aefdb196a03@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2020 13:14, Valentin Schneider wrote:
> On 03/01/2020 10:57, Valentin Schneider wrote:
>> I'm juggling with other things atm, but let me have a think and see if we
>> couldn't detect that in the scheduler itself.

If this is a common problem, we should detect it in the scheduler rather than in
the arch code.

> Something like this ought to catch your case; might need to compare group
> spans rather than pure group pointers.
> 
> ---
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6ec1e595b1d4..c4151e11afcd 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1120,6 +1120,13 @@ build_sched_groups(struct sched_domain *sd, int cpu)
>  
>  		sg = get_group(i, sdd);
>  
> +		/* sg's are inited as self-looping. If 'last' is not self
> +		 * looping, we set it in a previous visit. No further visit
> +		 * should change the link order, if we do then the topology
> +		 * description is terminally broken.
> +		 */
> +		BUG_ON(last && last->next != last && last->next != sg);
> +
>  		cpumask_or(covered, covered, sched_group_span(sg));
>  
>  		if (!first)
> 

Still don't see the actual problem case. The closest I came is:

qemu-system-aarch64 -kernel ... -append ' ... loglevel=8 sched_debug'
-smp cores=4,sockets=2 ... -numa node,cpus=0-2,nodeid=0
-numa node,cpus=3-7,nodeid=1

but this behaves sane. Since DIE and NUMA have the same span, the former degenerates.

[    0.654451] CPU0 attaching sched-domain(s):
[    0.654483]  domain-0: span=0-2 level=MC
[    0.654635]   groups: 0:{ span=0 cap=1008 }, 1:{ span=1 cap=1015 }, 2:{ span=2 cap=1014 }
[    0.654787]   domain-1: span=0-7 level=NUMA
[    0.654805]    groups: 0:{ span=0-2 cap=3037 }, 3:{ span=3-7 cap=5048 }
[    0.655326] CPU1 attaching sched-domain(s):
[    0.655339]  domain-0: span=0-2 level=MC
[    0.655356]   groups: 1:{ span=1 cap=1015 }, 2:{ span=2 cap=1014 }, 0:{ span=0 cap=1008 }
[    0.655391]   domain-1: span=0-7 level=NUMA
[    0.655407]    groups: 0:{ span=0-2 cap=3037 }, 3:{ span=3-7 cap=5048 }
[    0.655480] CPU2 attaching sched-domain(s):
[    0.655492]  domain-0: span=0-2 level=MC
[    0.655507]   groups: 2:{ span=2 cap=1014 }, 0:{ span=0 cap=1008 }, 1:{ span=1 cap=1015 }
[    0.655541]   domain-1: span=0-7 level=NUMA
[    0.655556]    groups: 0:{ span=0-2 cap=3037 }, 3:{ span=3-7 cap=5048 }
[    0.655603] CPU3 attaching sched-domain(s):
[    0.655614]  domain-0: span=3-7 level=MC
[    0.655628]   groups: 3:{ span=3 cap=984 }, 4:{ span=4 cap=1015 }, 5:{ span=5 cap=1016 }, 6:{ span=6 cap=1016 }, 7:{ span=7 cap=1017 }
[    0.655693]   domain-1: span=0-7 level=NUMA
[    0.655721]    groups: 3:{ span=3-7 cap=5048 }, 0:{ span=0-2 cap=3037 }
[    0.655769] CPU4 attaching sched-domain(s):
[    0.655780]  domain-0: span=3-7 level=MC
[    0.655795]   groups: 4:{ span=4 cap=1015 }, 5:{ span=5 cap=1016 }, 6:{ span=6 cap=1016 }, 7:{ span=7 cap=1017 }, 3:{ span=3 cap=984 }
[    0.655841]   domain-1: span=0-7 level=NUMA
[    0.655855]    groups: 3:{ span=3-7 cap=5048 }, 0:{ span=0-2 cap=3037 }
[    0.655902] CPU5 attaching sched-domain(s):
[    0.655916]  domain-0: span=3-7 level=MC
[    0.655930]   groups: 5:{ span=5 cap=1016 }, 6:{ span=6 cap=1016 }, 7:{ span=7 cap=1017 }, 3:{ span=3 cap=984 }, 4:{ span=4 cap=1015 }
[    0.656545]   domain-1: span=0-7 level=NUMA
[    0.656562]    groups: 3:{ span=3-7 cap=5048 }, 0:{ span=0-2 cap=3037 }
[    0.656775] CPU6 attaching sched-domain(s):
[    0.656796]  domain-0: span=3-7 level=MC
[    0.656835]   groups: 6:{ span=6 cap=1016 }, 7:{ span=7 cap=1017 }, 3:{ span=3 cap=984 }, 4:{ span=4 cap=1015 }, 5:{ span=5 cap=1016 }
[    0.656881]   domain-1: span=0-7 level=NUMA
[    0.656911]    groups: 3:{ span=3-7 cap=5048 }, 0:{ span=0-2 cap=3037 }
[    0.657102] CPU7 attaching sched-domain(s):
[    0.657113]  domain-0: span=3-7 level=MC
[    0.657128]   groups: 7:{ span=7 cap=1017 }, 3:{ span=3 cap=984 }, 4:{ span=4 cap=1015 }, 5:{ span=5 cap=1016 }, 6:{ span=6 cap=1016 }
[    0.657172]   domain-1: span=0-7 level=NUMA
[    0.657186]    groups: 3:{ span=3-7 cap=5048 }, 0:{ span=0-2 cap=3037 }
[    0.657241] root domain span: 0-7 (max cpu_capacity = 1024)
