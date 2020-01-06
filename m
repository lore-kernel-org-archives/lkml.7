Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A3C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8E62072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFOb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:31:28 -0500
Received: from foss.arm.com ([217.140.110.172]:44612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgAFOb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:31:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA4A231B;
        Mon,  6 Jan 2020 06:31:26 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8043E3F6C4;
        Mon,  6 Jan 2020 06:31:25 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
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
 <c0e82c31-8ed6-4739-6b01-2594c58df95a@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340B3203@dggemm526-mbx.china.huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <51a7d543-e35f-6492-fa51-02828832c154@arm.com>
Date:   Mon, 6 Jan 2020 15:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340B3203@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2020 02:48, Zengtao (B) wrote:

[...]

>> -----Original Message-----
>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>> Sent: Saturday, January 04, 2020 1:21 AM
>> To: Valentin Schneider; Zengtao (B); Sudeep Holla
>> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
>> linux-kernel@vger.kernel.org; Morten Rasmussen
>> Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts
>> with lower layer
>>
>> On 03/01/2020 13:14, Valentin Schneider wrote:
>>> On 03/01/2020 10:57, Valentin Schneider wrote:

>> Still don't see the actual problem case. The closest I came is:
>>
>> qemu-system-aarch64 -kernel ... -append ' ... loglevel=8 sched_debug'
>> -smp cores=4,sockets=2 ... -numa node,cpus=0-2,nodeid=0
>> -numa node,cpus=3-7,nodeid=1
>>
> 
> It's related to the HW topology, if you hw have got 2 clusters 0~3, 4~7, 
> with the mainline qemu, you will see the issue.
> I think you can manually modify the MPIDR parsing to reproduce the 
> issue.
> Linux will use the MPIDR to guess the MC topology since currently qemu
> don't provide it.
> Refer to: https://patchwork.ozlabs.org/cover/939301/

That makes sense to me. Valentin and I already discussed this setup as a
possible system where this issue can happen.

I already suspected that virt machines only support flat cpu toplogy.
Good to know. Although I was able to to pass '... -smp cores=8 -dtb
foo.dtb ...' into mainline qemu to achieve a 2 cluster system (MC and
DIE sd level) with an extra cpu-map entry in the dts file:

               cpu-map {
                        cluster0 {
                                core0 {
                                        cpu = <&A53_0>;
                                };
                                ...
                        };

                        cluster1 {
                                core0 {
                                        cpu = <&A53_4>;
                                };
                                ...
                        };
                };

But I didn't succeed in combining this with the '... -numa
node,cpus=0-3,nodeid=0 -numa node,cpus=4-7,nodeid=1 ...' params to
create a system like yours.

Your issue is related to the 'numa mask check for scheduler MC
selection' functionality.  It was introduced by commit 37c3ec2d810f and
re-introduced by commit e67ecf647020 later. I don't know why we need
this functionality?

How does your setup behave when you revert commit e67ecf647020? Or do
you want an explicit warning in case of NUMA boundaries not respecting
physical topology?
