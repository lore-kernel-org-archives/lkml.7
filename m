Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC237C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB2A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GJbI/AzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfDOWIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:08:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46517 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfDOWIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555366128; x=1586902128;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bIdsCbNgVTeGyll6RglGPST7YtEfsxDOqqCeO+0jW6Y=;
  b=GJbI/AzThsSUaKua5mYtveY6SLRLcz+ANpfLiiHEISbhqyxh7l9D+BhJ
   RJqgNjr7t2MQk5ZPJL5n2EDBftB0h5DhON/6sTK/1zxWot9fVbGQeaBxZ
   tZAGl82Wq7y4TRwsOQJDeOPEbpojvD1h/CT+tAs1LTyKMDko0Fyh+g4uA
   1Q9Qp+lDigf+mlqw4MirBmlgtpQeEUy2ATFu83eG7l2W5NsZVZ+FxmzKZ
   oIx1D0mQ+EC2ws87hf6ZVEZ7xQbDXxnuQC9s7Z3+QUnVX75fucHv5ruTl
   yjGnx8m9RhtLdla4uR6MI1UzsYe14+TV9k+r/Jnyi4M0nnMjeOWYYtZ/u
   g==;
X-IronPort-AV: E=Sophos;i="5.60,355,1549900800"; 
   d="scan'208";a="107257940"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2019 06:08:47 +0800
IronPort-SDR: 5d4OUqKGhiammEIZqeTJjry5peow9nHjrwY69BMnPDCRPFAxMd1V4HWtOfB2OrQmST7WrvKX/j
 AjbaUOdTURGO9633XH6QMUe10+Ssk9F3L+EbW38bbEllsuGK+rL6Uc+XGY9SNXjEZjYD4gAQAj
 4uShfLUc8pP/meOk9XwOkvKEJ8bCrmK98VVl93ONHNiYq7HGPh7VWBTFWOItt3duXAK20FmTBU
 Cy54fAYNcB8yoqOXixtGVI4+quoBaiBMgK38qYn2k1stqW67Jh9tncmh5J8KkKJ1o/jVvWmCR3
 v7CPH0zQub8SNDaxN4iSiJc1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 15 Apr 2019 14:47:41 -0700
IronPort-SDR: EqBvw8M5kci9MXpnfo4jBCpv+opR8xO7XpQ7/+x4BwpzyBvetVMzVBUhUt3J+RpsgcbgJcAuz9
 8c55e2v7iTF27P0mAz+gXZZYj2vOLTJzmf+5fgDn+nUrBqhGzgbuT2A+k5e/v42FAIwEaBvmXQ
 dJp47lxy21l2I8EUvM9zoufcm257Vvht+H8NBcfmZOzv7hvU2D7F8sqjnAeW0qLE1IwBItAC7E
 LgXOQqAo8ikg3AkYeX9T+SKEvwPFM1b4+lpS7Cp0t6uUfTaU4e2juVa2clvwMeki2Ur70qjZXL
 uck=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2019 15:08:47 -0700
Subject: Re: [RFT/RFC PATCH v3 3/5] cpu-topology: Move cpu topology code to
 common code.
To:     Sudeep Holla <sudeep.holla@arm.com>
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
        Will Deacon <will.deacon@arm.com>
References: <20190320234806.19748-1-atish.patra@wdc.com>
 <20190320234806.19748-4-atish.patra@wdc.com>
 <20190415152741.GA28623@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <5c5b720f-414a-706c-3415-642c27baef1f@wdc.com>
Date:   Mon, 15 Apr 2019 15:08:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415152741.GA28623@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 8:27 AM, Sudeep Holla wrote:
> Hi Atish,
> 
> Thanks again for doing this. Overall changes look good except a couple
> of minor nit, see below.
> 
> On Wed, Mar 20, 2019 at 04:48:04PM -0700, Atish Patra wrote:
>> Both RISC-V & ARM64 are using cpu-map device tree to describe
>> their cpu topology. It's better to move the relevant code to
>> a common place instead of duplicate code.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/topology.h |  23 ---
>>   arch/arm64/kernel/topology.c      | 303 +-----------------------------
>>   drivers/base/arch_topology.c      | 298 ++++++++++++++++++++++++++++-
>>   drivers/base/topology.c           |   1 +
>>   include/linux/arch_topology.h     |  28 +++
>>   5 files changed, 330 insertions(+), 323 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index edfcf8d9..6cc6a860 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -6,8 +6,8 @@
>>    * Written by: Juri Lelli, ARM Ltd.
>>    */
>>   
>> -#include <linux/acpi.h>
>>   #include <linux/arch_topology.h>
>> +#include <linux/acpi.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpufreq.h>
>>   #include <linux/device.h>
>> @@ -16,6 +16,11 @@
>>   #include <linux/string.h>
>>   #include <linux/sched/topology.h>
>>   #include <linux/cpuset.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/init.h>
>> +#include <linux/percpu.h>
>> +#include <linux/sched.h>
>> +#include <linux/smp.h>
>>   
>>   DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>>   
>> @@ -278,3 +283,294 @@ static void parsing_done_workfn(struct work_struct *work)
>>   #else
>>   core_initcall(free_raw_capacity);
>>   #endif
>> +
>> +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> 
> Why can't the above one be just GENERIC_ARCH_TOPOLOGY ?
> I may be missing to find it myself, but would like to know.
> 
GENERIC_ARCH_TOPOLOGY is now used for both RISCV, ARM & ARM64.
The below functions under this #ifdef have different implementation for 
ARM and ARM64.

parse_dt_topology
cpu_coregroup_mask
update_siblings_masks

While we can combine the later two functions and move them to common 
code as well, parse_dt_topology is significantly different.

That's why we need some kind of #ifdef or renaming of parse_dt_topology 
for ARM32 code.

Thanks for the review!!

Regards,
Atish
>> +
>> +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> 
> Ditto.
> 
> --
> Regards,
> Sudeep
> 

