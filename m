Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13604C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD59D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n7c/ixN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfDPSyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:54:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2610 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555440890; x=1586976890;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZT0B97dSH1Ijy8Uz6tkERdBIjfHUkvFmhigXZV6/kCM=;
  b=n7c/ixN7PQk+hAc7y2Bx38M56mVqxTUUwDHhDgxVtzz7+YzqzTl2BeBQ
   ce7grs/swLMGUEGWnKBpFZ9BkYVv55QsVnZgGqGABX6MHlsLyeXDo2j4r
   HtSQrghNXSYez8vKlKxJ2qL22clOoG+/VusX9BVh0LYdlYzTuMtLSLd4E
   hpRWKVsFqERuTtSqdg1CGtRWYjxBIKA53k8wmMhCDhem1Er01Rd+e2ORM
   5Z5zvICYGfAE2uTvNlJZXqrgIivLB2XVSPOgXFsx2Qbgr9GSdJexzB9Ib
   GNtIojM3gOj9cbe27rs55hBVbSxWggVjOwezL49zNSMpZmQLyWtbtgiTH
   A==;
X-IronPort-AV: E=Sophos;i="5.60,358,1549900800"; 
   d="scan'208";a="211868828"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2019 02:54:50 +0800
IronPort-SDR: b/rkYS4O/bz9eFZYrnOpNimtaoNBbZrFb/4ZnDQWAFzPkqJB59XMhcOoomHq15PBOMnW+1uw0v
 G/tY+Fm2gL30YzqdBqR1zThmGGnan9dWjQ5VxRpiM6H/UlGhIEtf5EJv3QVyiZ7uc1i1kU0iFW
 IdfzzvTlQ6YpnTzAwzlBlL5iioE/Wy3tlS2viWy4kQozF1OmjOP0hxuF6QqXNzNgATWA4pWOjU
 +3GR3p7k2JsXo2LzFPYE9yceIir5KN+Nl7NJFUafPxjzCA+JmFgZJW3eHWUAU99oNKTvPmD7Ec
 H90YtWtGLFs5yuI7amRS6d+L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 16 Apr 2019 11:33:43 -0700
IronPort-SDR: lp/jOdP+DmZq8I6+T6uki2xICfwqvEelUfHXocVeqDgAp7Jutc6jpm3A3kdRfNpBMZQcL153Ng
 jSzTEyR35BoZwlMzAWuCm+7N4Ovs5k1pa199lkoQFLypTJUhotRW/rSOu84pQQSAYlz7XVQWSV
 oaBFQJQz9+GyPCmmFCWXw48jXcGz5GWGS8z62Bm2zZEUlO/VtZyyMLdvQQ8GnNDxiy3kQxVIf/
 pF2xCkK/STyOzjLCY2DwXC+ipD1EPZmggngSUTXd9MbmuenvxS84uPaoS3tpfjqrSdNqpI3cPi
 ZsE=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2019 11:54:49 -0700
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
 <5c5b720f-414a-706c-3415-642c27baef1f@wdc.com>
 <20190416132324.GB24669@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <ad175efb-9545-5772-e0dc-ac0b0ae5139b@wdc.com>
Date:   Tue, 16 Apr 2019 11:54:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416132324.GB24669@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 6:23 AM, Sudeep Holla wrote:
> On Mon, Apr 15, 2019 at 03:08:45PM -0700, Atish Patra wrote:
>> On 4/15/19 8:27 AM, Sudeep Holla wrote:
>>> Hi Atish,
>>>
>>> Thanks again for doing this. Overall changes look good except a couple
>>> of minor nit, see below.
>>>
>>> On Wed, Mar 20, 2019 at 04:48:04PM -0700, Atish Patra wrote:
>>>> Both RISC-V & ARM64 are using cpu-map device tree to describe
>>>> their cpu topology. It's better to move the relevant code to
>>>> a common place instead of duplicate code.
>>>>
>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>> ---
>>>>    arch/arm64/include/asm/topology.h |  23 ---
>>>>    arch/arm64/kernel/topology.c      | 303 +-----------------------------
>>>>    drivers/base/arch_topology.c      | 298 ++++++++++++++++++++++++++++-
>>>>    drivers/base/topology.c           |   1 +
>>>>    include/linux/arch_topology.h     |  28 +++
>>>>    5 files changed, 330 insertions(+), 323 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>>>> index edfcf8d9..6cc6a860 100644
>>>> --- a/drivers/base/arch_topology.c
>>>> +++ b/drivers/base/arch_topology.c
>>>> @@ -6,8 +6,8 @@
>>>>     * Written by: Juri Lelli, ARM Ltd.
>>>>     */
>>>> -#include <linux/acpi.h>
>>>>    #include <linux/arch_topology.h>
>>>> +#include <linux/acpi.h>
>>>>    #include <linux/cpu.h>
>>>>    #include <linux/cpufreq.h>
>>>>    #include <linux/device.h>
>>>> @@ -16,6 +16,11 @@
>>>>    #include <linux/string.h>
>>>>    #include <linux/sched/topology.h>
>>>>    #include <linux/cpuset.h>
>>>> +#include <linux/cpumask.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/percpu.h>
>>>> +#include <linux/sched.h>
>>>> +#include <linux/smp.h>
>>>>    DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>>>> @@ -278,3 +283,294 @@ static void parsing_done_workfn(struct work_struct *work)
>>>>    #else
>>>>    core_initcall(free_raw_capacity);
>>>>    #endif
>>>> +
>>>> +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>>>
>>> Why can't the above one be just GENERIC_ARCH_TOPOLOGY ?
>>> I may be missing to find it myself, but would like to know.
>>>
>> GENERIC_ARCH_TOPOLOGY is now used for both RISCV, ARM & ARM64.
>> The below functions under this #ifdef have different implementation for ARM
>> and ARM64.
>>
>> parse_dt_topology
>> cpu_coregroup_mask
>> update_siblings_masks
>>
>> While we can combine the later two functions and move them to common code as
>> well, parse_dt_topology is significantly different.
>>
> 
> Sure, had a quick glance and indeed they may look different, but won't
> it defeat the purpose of this binding consolidation ?
> 
I didn't want change too much at first go.

>> That's why we need some kind of #ifdef or renaming of parse_dt_topology for
>> ARM32 code.
>>
> 
> I am fine if we want to take this up later to keep the impact minimum.
> But cpu_coregroup_mask and update_siblings_masks can and must be unified.

Sure. I will just leave parse_dt_topology as it is for now and unify 
other two functions.

I think we should unify parse_dt_topology in separate series.

Regards,
Atish
> In fact the existing generic version must work on ARM32 too.
> 
>> Thanks for the review!!
>>
> 
> You are welcome.
> 
> --
> Regards,
> Sudeep
> 

