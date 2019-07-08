Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F6C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9262086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfGHLWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:22:40 -0400
Received: from foss.arm.com ([217.140.110.172]:45264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730444AbfGHLWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:22:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551A2360;
        Mon,  8 Jul 2019 04:22:39 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B56EC3F738;
        Mon,  8 Jul 2019 04:22:36 -0700 (PDT)
Subject: Re: [RFC PATCH 1/6] sched/dl: Improve deadline admission control for
 asymmetric CPU capacities
To:     luca abeni <luca.abeni@santannapisa.it>,
        Quentin Perret <quentin.perret@arm.com>
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
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-2-luca.abeni@santannapisa.it>
 <20190507134850.yreebscc3zigfmtd@queper01-lin>
 <20190507162523.6a405d48@nowhere>
 <20190507143125.cjfhdxngcugqmko3@queper01-lin>
 <20190507164349.2823fdaa@nowhere>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3ddfc5ce-8870-a8d5-265a-462763fb348c@arm.com>
Date:   Mon, 8 Jul 2019 13:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190507164349.2823fdaa@nowhere>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 4:43 PM, luca abeni wrote:
> On Tue, 7 May 2019 15:31:27 +0100
> Quentin Perret <quentin.perret@arm.com> wrote:
> 
>> On Tuesday 07 May 2019 at 16:25:23 (+0200), luca abeni wrote:
>>> On Tue, 7 May 2019 14:48:52 +0100
>>> Quentin Perret <quentin.perret@arm.com> wrote:
>>>   
>>>> Hi Luca,
>>>>
>>>> On Monday 06 May 2019 at 06:48:31 (+0200), Luca Abeni wrote:  

[...]

>> Right and things moved recently in this area, see bb1fbdd3c3fd
>> ("sched/topology, drivers/base/arch_topology: Rebuild the sched_domain
>> hierarchy when capacities change")
> 
> Ah, thanks! I missed this change when rebasing the patchset.
> I guess this part of the patch has to be updated (and probably became
> useless?), then.

[...]

>>> This achieved the effect of correctly setting up the "rd_capacity"
>>> field, but I do not know if there is a better/simpler way to achieve
>>> the same result :)  
>>
>> OK, that's really an implementation detail, so no need to worry too
>> much about it at the RFC stage I suppose :-)

What about we integrate the code to calculate the rd capacity into
build_sched_domains() (next to the code to establish the rd
max_cpu_capacity)?

root@juno:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
446
1024
1024
446
446
446

root@juno:~# dmesg | grep "rd capacity"
/*  before CPUfreq max CPU freq calibration */
[    0.749389] rd span: 0-5 rd capacity: 4360 max cpu_capacity: 1024
/* after CPUfreq max CPU freq calibration */
[    3.372759] rd span: 0-5 rd capacity: 3832 max cpu_capacity: 1024

/* 2*1024 + 4*446 = 3832 */

root@juno:~# echo 0 > /sys/devices/system/cpu/cpu5/online

root@juno:~# dmesg | grep "rd capacity"
...
[ 2715.068198] rd span: 0-4 rd capacity: 3386 max cpu_capacity: 1024

root@juno:~# echo 1 > /sys/devices/system/cpu/cpu5/online

root@juno:~# dmesg | grep "rd capacity"
...
[ 2807.200662] rd span: 0-5 rd capacity: 3832 max cpu_capacity: 1024


--->8---

@@ -768,6 +769,7 @@ struct root_domain {
        cpumask_var_t           rto_mask;
        struct cpupri           cpupri;
 
+       unsigned long           capacity;
        unsigned long           max_cpu_capacity;
 
        /*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f751ce0b783e..68acdca27eaf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2000,6 +2000,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
                if (rq->cpu_capacity_orig > READ_ONCE(d.rd->max_cpu_capacity))
                        WRITE_ONCE(d.rd->max_cpu_capacity, rq->cpu_capacity_orig);
 
+               WRITE_ONCE(d.rd->capacity,
+                          READ_ONCE(d.rd->capacity) + rq->cpu_capacity_orig);
+
                cpu_attach_domain(sd, d.rd, i);
        }
        rcu_read_unlock();
@@ -2008,8 +2011,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
                static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
 
        if (rq && sched_debug_enabled) {
-               pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
-                       cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
+               pr_info("rd span: %*pbl rd capacity: %lu max cpu_capacity: %lu\n",
+                       cpumask_pr_args(cpu_map), rq->rd->capacity,
+                       rq->rd->max_cpu_capacity);
        }
