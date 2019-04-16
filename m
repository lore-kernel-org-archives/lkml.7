Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0BDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A623220651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QF55lwaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfDPTEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:04:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1649 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDPTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555441442; x=1586977442;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IJ3fPP63TF8cH0dmKYkBRMkS0543JoINwkzRoG/vzjk=;
  b=QF55lwaQcn2+l41z7qXTq7225u+lpv+BAqTzlaW4/ouDGlBz9qTkp8QI
   3JfM2HSJso+VnQW3E1gl3Nt2E30u83TPEY81UWU0lg82XPE2H+wDCXUGJ
   1B5/uUinPYqEGAqqA6xhRTppeXP2D7s+iqtH/0tCXoQAiBmjbIi1TrfIW
   dwqHE39N0FGtrrw+FQsxqf7g76a0nSsjpHLJnRNzIvzNWUq8uh41PWFWr
   K+lxBiHtbN0gIef8lvaz6/kFX6gH8F/aSpjGxSJGS3Ui6Jr+gd61vsd3t
   mxdwHpu1LGK54SdxSF+9BSVSIGg5eYfqhPAnivSKfqKs8eLIETjtDndqz
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,358,1549900800"; 
   d="scan'208";a="106121517"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2019 03:04:01 +0800
IronPort-SDR: bbCHCSIU9reHiQvqHKOS+mZ40rvcl3S0w0+fVvnPCBkEdCKo6bxWDNCsTsHUr8gRAsLWZscK+b
 7+R2GtfGvXjKFCSIExJ/bxsfTc3C+6DtlJelan7K75rZXaDFJs6s3gHRU/E9sfCrnpPu5jtn3f
 i94WgkB0imFdVxJfIi/7ooiAc2mRspyhzJq2ov0xsBfZ58ek0Nww0/TwKPtsZ8K5c0Xx88i4Jm
 rFZpnidjTsAsAPTM+xcsLTbQcl+uTk6D5ohXpqlM5KMWiwbWzgubCQAk6YanW4b9e+8N1Ym7yS
 tUbgMn33b0+UyHT3e19EtQ6L
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 16 Apr 2019 11:40:45 -0700
IronPort-SDR: JukLHjcF6xpXlpQepaUzkReDiLDKBO89GrQWwPeRqwPEHreAM8IQNA3uFwcPFVID2ZWZHv1wJF
 +INahz0cT1xzzapPXOwZFf7LisM7AeDoori+lHd1MvpuOHm6StC7l0TDbYYE4eaK4rvJkoVKy6
 egDGHjV57+66zWbSAjxOvuBVbECvSczLrmq+cEO1Zs3zU9ivyTGTo//tCbkVaoYAxybveM2aMn
 DnvobdoSRrXgfH24jgZF/m7zNyGzm7rAqRhl/kuxCJS+rK11PFMRRrfn5lpg/+a+hiITg36RtD
 bHQ=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2019 12:04:00 -0700
Subject: Re: [RFT/RFC PATCH v3 4/5] arm: Use common cpu_topology
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <20190320234806.19748-5-atish.patra@wdc.com>
 <20190415153147.GB28623@e107155-lin>
 <41f890e9-3893-9092-bac7-3daca99f181b@wdc.com>
 <20190416130916.GA24669@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <7118dc22-ddd6-d224-733c-fbe160bab28f@wdc.com>
Date:   Tue, 16 Apr 2019 12:04:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416130916.GA24669@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 6:09 AM, Sudeep Holla wrote:
> On Mon, Apr 15, 2019 at 02:16:43PM -0700, Atish Patra wrote:
>> On 4/15/19 8:31 AM, Sudeep Holla wrote:
>>> On Wed, Mar 20, 2019 at 04:48:05PM -0700, Atish Patra wrote:
>>>> Currently, ARM32 and ARM64 uses different data structures to
>>>> represent their cpu toplogies. Since, we are moving the ARM64
>>>> topology to common code to be used by other architectures, we
>>>> can reuse that for ARM32 as well.
>>>>
>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>> ---
>>>>    arch/arm/include/asm/topology.h | 22 +---------------------
>>>>    arch/arm/kernel/topology.c      | 10 +++++-----
>>>>    include/linux/arch_topology.h   | 10 +++++++++-
>>>>    3 files changed, 15 insertions(+), 27 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
>>>> index d4e76e0a..7c850611 100644
>>>> --- a/include/linux/arch_topology.h
>>>> +++ b/include/linux/arch_topology.h
>>>> @@ -36,17 +36,25 @@ unsigned long topology_get_freq_scale(int cpu)
>>>>    struct cpu_topology {
>>>>    	int thread_id;
>>>>    	int core_id;
>>>> +#ifdef CONFIG_ARM_CPU_TOPOLOGY
>>>> +	int socket_id;
>>>
>>> Sorry, but I can't find any reason why we need to do this ifdef dance
>>> here, especially for socket_id vs package_id ?
>>
>> I was not sure if we can rename socket_id to package_id from a semantic
>> point of view. If you are okay with it, I will change it to package_id and
>> send a v4.
>>
> 
> Thanks, all make sure to cc linux-arm-kernel@lists.infradead.org,
> just noticed that's missing and you are asking for testing on ARM
> platforms :)
> 

My bad!! I didn't realize that linux-arm-kernel is not included. Thanks 
for pointing that out.

>> Other's I can understand
>>> as there are new, but I am sure we can find a way and get away with
>>> #ifdefery here completely.
>>>
>> That would be good. Any suggestions on how to do that?
>>
> 
> Do you see any issues having extra structure members for ARM ?
> Something like below seem to compile + boot fine on my 32-bit TC2 with
> proper topology info on top of your series. Of course, more testing is
> better, but I don't see any issue keeping llc_{id,sibling} around for
> ARM eliminating the need for #ifdefs
> 

I thought adding unused members for ARM32 might be unacceptable :).
I will update my v4 with this.

Regards,
Atish
> Let me know if I am missing something.
> 
> -->8
> 
> diff --git i/arch/arm/kernel/topology.c w/arch/arm/kernel/topology.c
> index 0ddb24c76c17..f2aa942e0cfa 100644
> --- i/arch/arm/kernel/topology.c
> +++ w/arch/arm/kernel/topology.c
> @@ -206,7 +206,7 @@ void update_siblings_masks(unsigned int cpuid)
>   	for_each_possible_cpu(cpu) {
>   		cpu_topo = &cpu_topology[cpu];
>   
> -		if (cpuid_topo->socket_id != cpu_topo->socket_id)
> +		if (cpuid_topo->package_id != cpu_topo->package_id)
>   			continue;
>   
>   		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
> @@ -250,12 +250,12 @@ void store_cpu_topology(unsigned int cpuid)
>   			/* core performance interdependency */
>   			cpuid_topo->thread_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>   			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> -			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
> +			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
>   		} else {
>   			/* largely independent cores */
>   			cpuid_topo->thread_id = -1;
>   			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> -			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>   		}
>   	} else {
>   		/*
> @@ -265,7 +265,7 @@ void store_cpu_topology(unsigned int cpuid)
>   		 */
>   		cpuid_topo->thread_id = -1;
>   		cpuid_topo->core_id = 0;
> -		cpuid_topo->socket_id = -1;
> +		cpuid_topo->package_id = -1;
>   	}
>   
>   	update_siblings_masks(cpuid);
> @@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
>   	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
>   		cpuid, cpu_topology[cpuid].thread_id,
>   		cpu_topology[cpuid].core_id,
> -		cpu_topology[cpuid].socket_id, mpidr);
> +		cpu_topology[cpuid].package_id, mpidr);
>   }
>   
>   static inline int cpu_corepower_flags(void)
> @@ -306,7 +306,7 @@ void __init init_cpu_topology(void)
>   
>   		cpu_topo->thread_id = -1;
>   		cpu_topo->core_id =  -1;
> -		cpu_topo->socket_id = -1;
> +		cpu_topo->package_id = -1;
>   		cpumask_clear(&cpu_topo->core_sibling);
>   		cpumask_clear(&cpu_topo->thread_sibling);
>   	}
> diff --git i/include/linux/arch_topology.h w/include/linux/arch_topology.h
> index 7c850611986d..8e82389c2bed 100644
> --- i/include/linux/arch_topology.h
> +++ w/include/linux/arch_topology.h
> @@ -36,13 +36,9 @@ unsigned long topology_get_freq_scale(int cpu)
>   struct cpu_topology {
>   	int thread_id;
>   	int core_id;
> -#ifdef CONFIG_ARM_CPU_TOPOLOGY
> -	int socket_id;
> -#else
>   	int package_id;
>   	int llc_id;
>   	cpumask_t llc_sibling;
> -#endif
>   	cpumask_t thread_sibling;
>   	cpumask_t core_sibling;
>   };
> @@ -50,11 +46,7 @@ struct cpu_topology {
>   #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
>   extern struct cpu_topology cpu_topology[NR_CPUS];
>   
> -#ifdef CONFIG_ARM_CPU_TOPOLOGY
> -#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
> -#else
>   #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
> -#endif
>   #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
>   #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
>   #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
> 

