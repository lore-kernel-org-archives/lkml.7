Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E54C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7882081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgAGNMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:12:21 -0500
Received: from foss.arm.com ([217.140.110.172]:57608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbgAGNMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:12:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A2A31B;
        Tue,  7 Jan 2020 05:12:19 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E901B3F703;
        Tue,  7 Jan 2020 05:12:18 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
 <14a39167-5704-f406-614d-4d25b8fe8c68@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340B5552@dggemm526-mbx.china.huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0bd0e87b-e1ad-79a4-d820-f234ec6960fa@arm.com>
Date:   Tue, 7 Jan 2020 14:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340B5552@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 02:35, Zengtao (B) wrote:
>> -----Original Message-----
>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>> Sent: Tuesday, January 07, 2020 2:42 AM
>> To: Zengtao (B); sudeep.holla@arm.com
>> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cpu-topology: Skip the exist but not possible cpu
>> nodes
>>
>> On 02/01/2020 04:24, Zeng Tao wrote:
>>> When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the
>> device
>>> tree, the cpu node parsing will fail. And this is not reasonable for a
>>> legal device tree configs.
>>> In this patch, skip such cpu nodes rather than return an error.
>>
>> Is this extra code really necessary?
>>
>> Currently you get warnings indicating that CONFIG_NR_CPUS is too small
>> so you could correct the setup issue easily.
>>
> 
> Not only about warning messages, the problem is :
> What we are expected to do if the CONFIG_NR_CPUS is too small? I think there
> are two choices:
> 1. Keep the dts parsing result, but skip the the CPU nodes whose id exceeds the 
> the CONFIG_NR_CPUS, and this is what this patch do.
> 2. Just abort all the CPU nodes parsing, and using MPIDR to guess the topology, 
> and this is what the current code do.

Ah, you're referring to:

530 void __init init_cpu_topology(void)
531 {
...
540         else if (of_have_populated_dt() && parse_dt_topology())
541 -->             reset_cpu_topology();

With my Juno example (6 Cpus in DT but CONFIG_NR_CPUS=4):

root@juno:~# dmesg | grep "\*\*\|mpidr"
[    0.084760] ** get_cpu_for_node() cpu=1
[    0.088706] ** get_cpu_for_node() cpu=2
[    0.092592] ** get_cpu_for_node() cpu=0
[    0.096550] ** get_cpu_for_node() cpu=3
[    0.105578] ** get_cpu_for_node() cpu=-19
[    0.116070] ** store_cpu_topology(): cpuid=0
[    0.120355] CPU0: cluster 1 core 0 thread -1 mpidr 0x00000080000100
[    0.242465] ** store_cpu_topology(): cpuid=1
[    0.242471] CPU1: cluster 0 core 0 thread -1 mpidr 0x00000080000000
[    0.286505] ** store_cpu_topology(): cpuid=2
[    0.286510] CPU2: cluster 0 core 1 thread -1 mpidr 0x00000080000001
[    0.330631] ** store_cpu_topology(): cpuid=3
[    0.330637] CPU3: cluster 1 core 1 thread -1 mpidr 0x00000080000101

and with your patch:

root@juno:~# dmesg | grep "\*\*\|mpidr"
[    0.084778] ** get_cpu_for_node() cpu=1
[    0.088742] ** get_cpu_for_node() cpu=2
[    0.092662] ** get_cpu_for_node() cpu=0
[    0.096627] ** get_cpu_for_node() cpu=3
[    0.107942] ** get_cpu_for_node() cpu=-19
[    0.119429] ** get_cpu_for_node() cpu=-19
[    0.123461] ** store_cpu_topology(): cpuid=0
[    0.243571] ** store_cpu_topology(): cpuid=1
[    0.287610] ** store_cpu_topology(): cpuid=2
[    0.331737] ** store_cpu_topology(): cpuid=3

so we bail out of store_cpu_topology() since 'cpuid_topo->package_id != -1'.

> And i think choice 1 is better because:
> 1. It's a legal dts, we should keep the same result whether CONFIG_NR_CPUS is
> too small or not.
> 2. In the function of_parse_and_init_cpus, we just do the same way as choice 1.
> 
> But i am open for the issue, any suggestions are welcomed.

[...]
