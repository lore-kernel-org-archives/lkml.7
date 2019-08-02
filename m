Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C49205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436874AbfHBULc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:11:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:33477 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405161AbfHBULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 16:11:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 13:11:29 -0700
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="173320014"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.99]) ([10.24.14.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 02 Aug 2019 13:11:28 -0700
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
 <20190802180352.GE30661@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
Date:   Fri, 2 Aug 2019 13:11:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190802180352.GE30661@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/2/2019 11:03 AM, Borislav Petkov wrote:
> On Tue, Jul 30, 2019 at 10:29:35AM -0700, Reinette Chatre wrote:
>> +/*
>> + * According to details about CPUID instruction documented in Intel SDM
>> + * the third bit of the EDX register is used to indicate if complex
>> + * cache indexing is in use.
>> + * According to AMD specification (Open Source Register Reference For AMD
>> + * Family 17h processors Models 00h-2Fh 56255 Rev 3.03 - July, 2018), only
>> + * the first two bits are in use. Since HYGON is based on AMD the
>> + * assumption is that it supports the same.
>> + *
>> + * There is no consumer for the complex indexing information so this bit is
>> + * not added to the declaration of what processor can provide in EDX
>> + * register. The declaration thus only considers bits supported by all
>> + * architectures.
>> + */
> 
> I don't think you need all that commenting in here since it'll become
> stale as soon as the other vendors change their respective 0x8000001D
> leafs. It is sufficient to say that the union below is going to contain
> only the bits shared by all vendors.

Will do.

> 
>> +union _cpuid4_leaf_edx {
>> +	struct {
>> +		unsigned int		wbinvd_no_guarantee:1;
> 					^^^^^^^^^^^^^^^^^^^^^
> 
> That's unused so no need to name the bit. You only need "inclusive".

Will do.

> 
>> +		unsigned int		inclusive:1;
>> +	} split;
>> +	u32 full;
>> +};
>> +
>>  struct _cpuid4_info_regs {
>>  	union _cpuid4_leaf_eax eax;
>>  	union _cpuid4_leaf_ebx ebx;
>>  	union _cpuid4_leaf_ecx ecx;
>> +	union _cpuid4_leaf_edx edx;
>>  	unsigned int id;
>>  	unsigned long size;
>>  	struct amd_northbridge *nb;
>> @@ -595,21 +618,24 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
>>  	union _cpuid4_leaf_eax	eax;
>>  	union _cpuid4_leaf_ebx	ebx;
>>  	union _cpuid4_leaf_ecx	ecx;
>> -	unsigned		edx;
>> +	union _cpuid4_leaf_edx	edx;
>> +
>> +	edx.full = 0;
> 
> Yeah, the proper way to shut up gcc is to do this (diff ontop):
> 
> ---
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 3b678f46be53..4ff4e95e22b4 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -252,7 +252,8 @@ static const enum cache_type cache_type_map[] = {
>  static void
>  amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
>  		     union _cpuid4_leaf_ebx *ebx,
> -		     union _cpuid4_leaf_ecx *ecx)
> +		     union _cpuid4_leaf_ecx *ecx,
> +		     union _cpuid4_leaf_edx *edx)
>  {
>  	unsigned dummy;
>  	unsigned line_size, lines_per_tag, assoc, size_in_kb;
> @@ -264,6 +265,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
>  	eax->full = 0;
>  	ebx->full = 0;
>  	ecx->full = 0;
> +	edx->full = 0;
>  
>  	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
>  	cpuid(0x80000006, &dummy, &dummy, &l2.val, &l3.val);
> @@ -620,14 +622,12 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
>  	union _cpuid4_leaf_ecx	ecx;
>  	union _cpuid4_leaf_edx	edx;
>  
> -	edx.full = 0;
> -
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>  		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
>  			cpuid_count(0x8000001d, index, &eax.full,
>  				    &ebx.full, &ecx.full, &edx.full);
>  		else
> -			amd_cpuid4(index, &eax, &ebx, &ecx);
> +			amd_cpuid4(index, &eax, &ebx, &ecx, &edx);
>  		amd_init_l3_cache(this_leaf, index);
>  	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>  		cpuid_count(0x8000001d, index, &eax.full,
> 

Thank you very much. I'll fix this.

>>  
>>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>>  		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
>>  			cpuid_count(0x8000001d, index, &eax.full,
>> -				    &ebx.full, &ecx.full, &edx);
>> +				    &ebx.full, &ecx.full, &edx.full);
>>  		else
>>  			amd_cpuid4(index, &eax, &ebx, &ecx);
>>  		amd_init_l3_cache(this_leaf, index);
>>  	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>>  		cpuid_count(0x8000001d, index, &eax.full,
>> -			    &ebx.full, &ecx.full, &edx);
>> +			    &ebx.full, &ecx.full, &edx.full);
>>  		amd_init_l3_cache(this_leaf, index);
>>  	} else {
>> -		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
>> +		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full,
>> +			    &edx.full);
> 
> Let that line stick out and rename "index" to "idx" so that it fits the
> 80 cols rule.

Will do. Do you prefer a new prepare patch that does the renaming before
this patch or will you be ok with the renaming done within this patch?

> 
>>  	}
>>  
>>  	if (eax.split.type == CTYPE_NULL)
>> @@ -618,6 +644,7 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
>>  	this_leaf->eax = eax;
>>  	this_leaf->ebx = ebx;
>>  	this_leaf->ecx = ecx;
>> +	this_leaf->edx = edx;
>>  	this_leaf->size = (ecx.split.number_of_sets          + 1) *
>>  			  (ebx.split.coherency_line_size     + 1) *
>>  			  (ebx.split.physical_line_partition + 1) *
>> @@ -982,6 +1009,13 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>>  	this_leaf->number_of_sets = base->ecx.split.number_of_sets + 1;
>>  	this_leaf->physical_line_partition =
>>  				base->ebx.split.physical_line_partition + 1;
> 
> <---- newline here.
> 

Will do.

>> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
>> +	     boot_cpu_has(X86_FEATURE_TOPOEXT)) ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
>> +		this_leaf->attributes |= CACHE_INCLUSIVE_SET;
>> +		this_leaf->inclusive = base->edx.split.inclusive;
> 
> A whole int for a single bit?
> 
> Why don't you define the CACHE_INCLUSIVE_SET thing as CACHE_INCLUSIVE to
> mean if set, the cache is inclusive, if not, it isn't or unknown?
> 
This patch only makes it possible to determine whether cache is
inclusive for some x86 platforms while all platforms of all
architectures are given visibility into this new "inclusive" cache
information field within the global "struct cacheinfo". I did the above
because I wanted it to be possible to distinguish between the "not
inclusive" vs "unknown" case. With the above the "inclusive" field would
only be considered valid if "CACHE_INCLUSIVE_SET" is set.

You do seem to acknowledge this exact motivation though ... since you
explicitly state "isn't or unknown". Do I understand correctly that you
are ok with it not being possible to distinguish between "not inclusive"
and "unknown"?

Thank you very much for your valuable feedback.

Reinette

