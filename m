Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5457223F4E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r1zdFY4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfE2RYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:24:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33354 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2RYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559150750; x=1590686750;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GmwkQjsql+93mksfGBKpKv07dJD3LbLgm/uiMZ0AHPo=;
  b=r1zdFY4MJ6Ewx3vjpjXzAAU7/hxykRnalg5HAAfOCkjQzup0PvIsw4qO
   +/RDxKI2Wjogcbrl/JQtJ/5BwoYR1EL9aQ1/Sr1fZx4hi4zQ8aycEjZMf
   wGSsRuN7PSn/qtXaHmRxtN8K49HgHHX4oBnxliP57k8s9io2rX8z5BYJG
   c47dsRXCzmEPqK77Wx+stCAZKULECyFOLgPN8Vkbr2k/HHNAx4LCLCyj7
   t43MJWPNqDqqv4jKnouQrSe4evjkeAfsrpgvwUvUrBr8trmLlHMIUb3bl
   D7lSbP5vmDQ1n8bW65sSIvSvyEwz3b+fTZ3tQMC4PCDL9P+KUEBSfkWf7
   A==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549900800"; 
   d="scan'208";a="208888300"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 01:25:50 +0800
IronPort-SDR: qJjPorv7NLTsDipQ/quAsdkOhmgOQxd3GEQHDCrxv2fjccRPwl2BvfzQ1r/vsIkVi57XGY1iiA
 IsajZazzTKIXLeHAwBQppRCnbM9TGtPNZ5ntWL+8XMyuRxTtDZowYzbaNI7x6hPlTwf0BVevwT
 88OVgkwuR6SDXq7MQpx8RZWUS0iX1qKywgtouiVnSj7kAHPHfF5V3kKY+jjsGk0Uydqv3KU0kj
 uTWaroTTL1UNAqf2V+nGLr6oH8P05zuSC4jPtRFPcXNx/rih1uv/e5uAc/WYkzfF50Ey/XBOGW
 xsMY6vG/gCghuchMvWHONml5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 May 2019 09:59:56 -0700
IronPort-SDR: qwx1yS5ZHNt0FCMSYqf+WJKfwEZzDe1m1COXuHEaXSEA1gbjcAghTgoZA/pAPmiHYjRRuhMwaS
 4YU0yZuBBWOR8HMPPKVU5iZV0wOR6jpU6gpjoSofyjnMX+Yj+CLJ54VyieeJDHrICAWbFkwZEE
 8fiPHmX0AWUyXp5ROGUHIaH1uox4cxYmupRrmw0K0LfN1+pPMJXpEiN7/T4ppYloUEVMdUMMYe
 0f9cT1yfCL6ZBGsZeJTclAy1epn3qLfhy4lQ1mzKbXDz2qH6YA/AnqpC7lGAh68rWc2HbLUYqk
 pt8=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 May 2019 10:24:46 -0700
Subject: Re: [RFT PATCH v5 3/5] cpu-topology: Move cpu topology code to common
 code.
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190524000653.13005-1-atish.patra@wdc.com>
 <20190524000653.13005-4-atish.patra@wdc.com>
 <20190529104801.GA13155@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <b291e1da-47a7-32b9-ab36-90f65b2a961a@wdc.com>
Date:   Wed, 29 May 2019 10:24:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529104801.GA13155@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 3:48 AM, Sudeep Holla wrote:
> On Thu, May 23, 2019 at 05:06:50PM -0700, Atish Patra wrote:
>> Both RISC-V & ARM64 are using cpu-map device tree to describe
>> their cpu topology. It's better to move the relevant code to
>> a common place instead of duplicate code.
>>
> 
> I couldn't test this on any ARM64 server platforms, tested on Juno
> and other embedded platforms.
> 

Jeff had tested earlier patch series on ARM64 server platform.
Since then, the series has changed. Even though, I don't expect it break 
ARM64, if it can be verified again that would be great.

@Jeff: Can you give it a shot if you have some time ?

> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thanks!

>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/topology.h |  23 ---
>>   arch/arm64/kernel/topology.c      | 303 +-----------------------------
>>   drivers/base/arch_topology.c      | 296 +++++++++++++++++++++++++++++
>>   include/linux/arch_topology.h     |  28 +++
>>   include/linux/topology.h          |   1 +
>>   5 files changed, 329 insertions(+), 322 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 0825c4a856e3..6b95c91e7d67 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>>
> 
> [...]
> 
>> -static int __init parse_cluster(struct device_node *cluster, int depth)
>> -{
>> -	char name[10];
>> -	bool leaf = true;
>> -	bool has_cores = false;
>> -	struct device_node *c;
>> -	static int package_id __initdata;
>> -	int core_id = 0;
> 
> [Ultra minor nit]: you seem to have reordered the above declaration when
> you moved, just noticed as it showed up when comparing.
> 

Arrgh. Sorry!

I think I was trying to fix a checkpatch or something and forgot to 
revert. I will update it.

>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 1739d7e1952a..20a960131bee 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
> 
> [...]
> 
>> +
>> +static int __init parse_cluster(struct device_node *cluster, int depth)
>> +{
>> +	char name[10];
>> +	bool leaf = true;
>> +	bool has_cores = false;
>> +	int core_id = 0;
>> +	static int package_id __initdata;
>> +	struct device_node *c;
>> +	int i, ret;
>> +
> 
> [...]
> 
>> +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>> +void update_siblings_masks(unsigned int cpu);
>> +#endif
>> +void remove_cpu_topology(unsigned int cpuid);
>> +
> 
> Another thing(not a block and we can do it once this is merged) is to
> remove these #ifdefs
> 

This #ifdef is removed in patch 4.

But we should remove the other ones around init_cpu_topology, 
parse_dt_topology and friends in a follow up patch once this is merged.

> --
> Regards,
> Sudeep
> 


-- 
Regards,
Atish
