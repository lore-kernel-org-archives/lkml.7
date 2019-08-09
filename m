Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721EAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219F32086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437145AbfHIQST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:18:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:60753 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437088AbfHIQSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:18:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 09:18:16 -0700
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="203967750"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.6.227]) ([10.251.6.227])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 09 Aug 2019 09:18:17 -0700
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
 <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
 <20190806191559.GB4698@zn.tnic>
 <18004821-577d-b0dd-62b8-13b6f9264e72@intel.com>
 <20190806204054.GD4698@zn.tnic>
 <98eeaa53-d100-28ff-0b68-ba57e0ea90fb@intel.com>
 <20190808080841.GA20745@zn.tnic> <20190808081342.GB20745@zn.tnic>
 <1b0b14aa-2c78-8259-9fdc-06ee7f6050f4@intel.com>
 <20190809073350.GB2152@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0ce45f5f-38a8-10c9-1b94-9b70a8026e84@intel.com>
Date:   Fri, 9 Aug 2019 09:18:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809073350.GB2152@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/9/2019 12:33 AM, Borislav Petkov wrote:
> On Thu, Aug 08, 2019 at 01:08:59PM -0700, Reinette Chatre wrote:
>> With the goal of following these guidelines exactly I came up with the
>> below that is an incremental diff on top of what this review started out as.
> 
> Thanks but pls in the future, do not use windoze to send a diff - it
> mangles it to inapplicability.

I am sorry about that.

> 
>> Some changes to highlight that may be of concern:
>> * In your previous email you do mention that this will be a "single bit
>> of information". Please note that I did not specifically use an actual
>> bit to capture this information but an unsigned int (I am very aware
>> that you also commented on this initially). If you do mean that this
>> should be stored as an actual bit, could you please help me by
>> elaborating how you would like to see this implemented?
> 
> See below for a possible way to do it.
> 
>> * Please note that I moved the initialization to init_intel_cacheinfo()
>> to be specific to Intel. I did so because from what I understand there
>> are some AMD platforms for which this information cannot be determined
>> and I thought it simpler to make it specific to Intel with the new
>> single static variable.
> 
> Yeah, I renamed your function to cacheinfo_l3_inclusive() in case the
> other vendors would want to use it someday.
> 
>> * Please note that while this is a single global static variable it will
>> be set over and over for each CPU on the system.
> 
> That's fine.
> 
> Also, the bits in include/linux/cacheinfo.h need to go too. Here's a diff ontop
> of your patchset:
> 
> ---
> diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
> index 86b63c7feab7..87eca716e03d 100644
> --- a/arch/x86/include/asm/cacheinfo.h
> +++ b/arch/x86/include/asm/cacheinfo.h
> @@ -5,4 +5,6 @@
>  void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
>  void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
>  
> +bool cacheinfo_l3_inclusive(void);
> +
>  #endif /* _ASM_X86_CACHEINFO_H */
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 3b678f46be53..418a6f7392d0 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -188,6 +188,13 @@ struct _cpuid4_info_regs {
>  
>  static unsigned short num_cache_leaves;
>  
> +struct cache_attributes {
> +	u64 l3_inclusive	: 1,
> +	    __resv		: 63;
> +};
> +
> +static struct cache_attributes cache_attrs;
> +
>  /* AMD doesn't have CPUID4. Emulate it here to report the same
>     information to the user.  This makes some assumptions about the machine:
>     L2 not shared, no SMT etc. that is currently true on AMD CPUs.
> @@ -745,6 +752,14 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
>  	num_cache_leaves = find_num_cache_leaves(c);
>  }
>  
> +bool cacheinfo_l3_inclusive(void)
> +{
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +		return false;
> +
> +	return cache_attrs.l3_inclusive;
> +}
> +
>  void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  {
>  	/* Cache sizes */
> @@ -795,6 +810,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  				num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
>  				index_msb = get_count_order(num_threads_sharing);
>  				l3_id = c->apicid & ~((1 << index_msb) - 1);
> +				cache_attrs.l3_inclusive = this_leaf.edx.split.inclusive;
>  				break;
>  			default:
>  				break;
> @@ -1009,13 +1025,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  	this_leaf->number_of_sets = base->ecx.split.number_of_sets + 1;
>  	this_leaf->physical_line_partition =
>  				base->ebx.split.physical_line_partition + 1;
> -	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> -	     boot_cpu_has(X86_FEATURE_TOPOEXT)) ||
> -	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
> -	    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
> -		this_leaf->attributes |= CACHE_INCLUSIVE_SET;
> -		this_leaf->inclusive = base->edx.split.inclusive;
> -	}
>  	this_leaf->priv = base->nb;
>  }
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index b4fff88572bd..644d1780671e 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -26,6 +26,7 @@
>  #include <asm/intel-family.h>
>  #include <asm/resctrl_sched.h>
>  #include <asm/perf_event.h>
> +#include <asm/cacheinfo.h>
>  
>  #include "../../events/perf_event.h" /* For X86_CONFIG() */
>  #include "internal.h"
> @@ -125,30 +126,6 @@ static unsigned int get_cache_line_size(unsigned int cpu, int level)
>  	return 0;
>  }
>  
> -/**
> - * get_cache_inclusive - Determine if cache is inclusive of lower levels
> - * @cpu: CPU with which cache is associated
> - * @level: Cache level
> - *
> - * Context: @cpu has to be online.
> - * Return: 1 if cache is inclusive of lower cache levels, 0 if cache is not
> - *         inclusive of lower cache levels or on failure.
> - */
> -static unsigned int get_cache_inclusive(unsigned int cpu, int level)
> -{
> -	struct cpu_cacheinfo *ci;
> -	int i;
> -
> -	ci = get_cpu_cacheinfo(cpu);
> -
> -	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == level)
> -			return ci->info_list[i].inclusive;
> -	}
> -
> -	return 0;
> -}
> -
>  /**
>   * pseudo_lock_minor_get - Obtain available minor number
>   * @minor: Pointer to where new minor number will be stored
> @@ -341,8 +318,7 @@ static int pseudo_lock_single_portion_valid(struct pseudo_lock_region *plr,
>  		goto err_cpu;
>  	}
>  
> -	if (p->r->cache_level == 3 &&
> -	    !get_cache_inclusive(plr->cpu, p->r->cache_level)) {
> +	if (p->r->cache_level == 3 && !cacheinfo_l3_inclusive()) {
>  		rdt_last_cmd_puts("L3 cache not inclusive\n");
>  		goto err_cpu;
>  	}
> @@ -448,7 +424,7 @@ static int pseudo_lock_l2_l3_portions_valid(struct pseudo_lock_region *plr,
>  		goto err_cpu;
>  	}
>  
> -	if (!get_cache_inclusive(plr->cpu, l3_p->r->cache_level)) {
> +	if (!cacheinfo_l3_inclusive()) {
>  		rdt_last_cmd_puts("L3 cache not inclusive\n");
>  		goto err_cpu;
>  	}
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index cdc7a9d6923f..46b92cd61d0c 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -33,8 +33,6 @@ extern unsigned int coherency_max_size;
>   * @physical_line_partition: number of physical cache lines sharing the
>   *	same cachetag
>   * @size: Total size of the cache
> - * @inclusive: Cache is inclusive of lower level caches. Only valid if
> - *	CACHE_INCLUSIVE_SET attribute is set.
>   * @shared_cpu_map: logical cpumask representing all the cpus sharing
>   *	this cache node
>   * @attributes: bitfield representing various cache attributes
> @@ -57,7 +55,6 @@ struct cacheinfo {
>  	unsigned int ways_of_associativity;
>  	unsigned int physical_line_partition;
>  	unsigned int size;
> -	unsigned int inclusive;
>  	cpumask_t shared_cpu_map;
>  	unsigned int attributes;
>  #define CACHE_WRITE_THROUGH	BIT(0)
> @@ -69,7 +66,6 @@ struct cacheinfo {
>  #define CACHE_ALLOCATE_POLICY_MASK	\
>  	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
>  #define CACHE_ID		BIT(4)
> -#define CACHE_INCLUSIVE_SET	BIT(5)
>  	void *fw_token;
>  	bool disable_sysfs;
>  	void *priv;
> 
> 

I really appreciate that you took the time to put this together. I now
understand how all your suggestions come together.

Thank you for your patience in reviewing this change.

Reinette
