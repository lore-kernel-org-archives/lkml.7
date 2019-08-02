Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E52C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF42320665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="N3q1ZFib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436897AbfHBSEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:04:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436886AbfHBSEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:04:01 -0400
Received: from zn.tnic (p200300EC2F0D960074257EA672617BE7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:9600:7425:7ea6:7261:7be7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CDC31EC04CD;
        Fri,  2 Aug 2019 20:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564769037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RIAxST4zt9d+7dJCodvecwMSEFvlCmNJFIiEs29iOfE=;
        b=N3q1ZFib/tR3J3bve+sXeIFNxizbfixJWEdtXZyvH/pQ7RQAu0/+36j+1Q5HktkNej2JY0
        KHHJ1kCIQB0Kk2kLvQb8to9dB7pMr5H0xOPSG1QsxbyBKo+mr2go7pm41QVnOpM0q6MvIY
        cFQKTe6kPj6BbVmVgyylGyuheg9alhY=
Date:   Fri, 2 Aug 2019 20:03:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190802180352.GE30661@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:29:35AM -0700, Reinette Chatre wrote:
> Deterministic cache parameters can be learned from CPUID leaf 04H.
> Executing CPUID with a particular index in EAX would return the cache
> parameters associated with that index in the EAX, EBX, ECX, and EDX
> registers.
> 
> At this time, when discovering cache parameters for a particular cache
> index, only the parameters returned in EAX, EBX, and ECX are parsed.
> Parameters returned in EDX are ignored. One of the parameters in EDX,
> whether the cache is inclusive of lower level caches, is valuable to
> know when determining if a system can support L3 cache pseudo-locking.
> If the L3 cache is not inclusive then pseudo-locked data within the L3
> cache would be evicted when migrated to L2.
> 
> Add support for parsing the cache parameters obtained from EDX and make
> the inclusive cache parameter available via the cacheinfo that can be
> queried from the cache pseudo-locking code.
> 
> Do not expose this information to user space at this time. At this time
> this information is required within the kernel only. Also, it is
> not obvious what the best formatting of this information should be in
> support of the variety of ways users may use this information.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/cacheinfo.c | 42 +++++++++++++++++++++++++++++----
>  include/linux/cacheinfo.h       |  4 ++++
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index c7503be92f35..3b678f46be53 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -154,10 +154,33 @@ union _cpuid4_leaf_ecx {
>  	u32 full;
>  };
>  
> +/*
> + * According to details about CPUID instruction documented in Intel SDM
> + * the third bit of the EDX register is used to indicate if complex
> + * cache indexing is in use.
> + * According to AMD specification (Open Source Register Reference For AMD
> + * Family 17h processors Models 00h-2Fh 56255 Rev 3.03 - July, 2018), only
> + * the first two bits are in use. Since HYGON is based on AMD the
> + * assumption is that it supports the same.
> + *
> + * There is no consumer for the complex indexing information so this bit is
> + * not added to the declaration of what processor can provide in EDX
> + * register. The declaration thus only considers bits supported by all
> + * architectures.
> + */

I don't think you need all that commenting in here since it'll become
stale as soon as the other vendors change their respective 0x8000001D
leafs. It is sufficient to say that the union below is going to contain
only the bits shared by all vendors.

> +union _cpuid4_leaf_edx {
> +	struct {
> +		unsigned int		wbinvd_no_guarantee:1;
					^^^^^^^^^^^^^^^^^^^^^

That's unused so no need to name the bit. You only need "inclusive".

> +		unsigned int		inclusive:1;
> +	} split;
> +	u32 full;
> +};
> +
>  struct _cpuid4_info_regs {
>  	union _cpuid4_leaf_eax eax;
>  	union _cpuid4_leaf_ebx ebx;
>  	union _cpuid4_leaf_ecx ecx;
> +	union _cpuid4_leaf_edx edx;
>  	unsigned int id;
>  	unsigned long size;
>  	struct amd_northbridge *nb;
> @@ -595,21 +618,24 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
>  	union _cpuid4_leaf_eax	eax;
>  	union _cpuid4_leaf_ebx	ebx;
>  	union _cpuid4_leaf_ecx	ecx;
> -	unsigned		edx;
> +	union _cpuid4_leaf_edx	edx;
> +
> +	edx.full = 0;

Yeah, the proper way to shut up gcc is to do this (diff ontop):

---
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3b678f46be53..4ff4e95e22b4 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -252,7 +252,8 @@ static const enum cache_type cache_type_map[] = {
 static void
 amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 		     union _cpuid4_leaf_ebx *ebx,
-		     union _cpuid4_leaf_ecx *ecx)
+		     union _cpuid4_leaf_ecx *ecx,
+		     union _cpuid4_leaf_edx *edx)
 {
 	unsigned dummy;
 	unsigned line_size, lines_per_tag, assoc, size_in_kb;
@@ -264,6 +265,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	eax->full = 0;
 	ebx->full = 0;
 	ecx->full = 0;
+	edx->full = 0;
 
 	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
 	cpuid(0x80000006, &dummy, &dummy, &l2.val, &l3.val);
@@ -620,14 +622,12 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 	union _cpuid4_leaf_ecx	ecx;
 	union _cpuid4_leaf_edx	edx;
 
-	edx.full = 0;
-
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
 			cpuid_count(0x8000001d, index, &eax.full,
 				    &ebx.full, &ecx.full, &edx.full);
 		else
-			amd_cpuid4(index, &eax, &ebx, &ecx);
+			amd_cpuid4(index, &eax, &ebx, &ecx, &edx);
 		amd_init_l3_cache(this_leaf, index);
 	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		cpuid_count(0x8000001d, index, &eax.full,

>  
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>  		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
>  			cpuid_count(0x8000001d, index, &eax.full,
> -				    &ebx.full, &ecx.full, &edx);
> +				    &ebx.full, &ecx.full, &edx.full);
>  		else
>  			amd_cpuid4(index, &eax, &ebx, &ecx);
>  		amd_init_l3_cache(this_leaf, index);
>  	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>  		cpuid_count(0x8000001d, index, &eax.full,
> -			    &ebx.full, &ecx.full, &edx);
> +			    &ebx.full, &ecx.full, &edx.full);
>  		amd_init_l3_cache(this_leaf, index);
>  	} else {
> -		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
> +		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full,
> +			    &edx.full);

Let that line stick out and rename "index" to "idx" so that it fits the
80 cols rule.

>  	}
>  
>  	if (eax.split.type == CTYPE_NULL)
> @@ -618,6 +644,7 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
>  	this_leaf->eax = eax;
>  	this_leaf->ebx = ebx;
>  	this_leaf->ecx = ecx;
> +	this_leaf->edx = edx;
>  	this_leaf->size = (ecx.split.number_of_sets          + 1) *
>  			  (ebx.split.coherency_line_size     + 1) *
>  			  (ebx.split.physical_line_partition + 1) *
> @@ -982,6 +1009,13 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  	this_leaf->number_of_sets = base->ecx.split.number_of_sets + 1;
>  	this_leaf->physical_line_partition =
>  				base->ebx.split.physical_line_partition + 1;

<---- newline here.

> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	     boot_cpu_has(X86_FEATURE_TOPOEXT)) ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
> +		this_leaf->attributes |= CACHE_INCLUSIVE_SET;
> +		this_leaf->inclusive = base->edx.split.inclusive;

A whole int for a single bit?

Why don't you define the CACHE_INCLUSIVE_SET thing as CACHE_INCLUSIVE to
mean if set, the cache is inclusive, if not, it isn't or unknown?

> +	}
>  	this_leaf->priv = base->nb;
>  }
>  
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 46b92cd61d0c..cdc7a9d6923f 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -33,6 +33,8 @@ extern unsigned int coherency_max_size;
>   * @physical_line_partition: number of physical cache lines sharing the
>   *	same cachetag
>   * @size: Total size of the cache
> + * @inclusive: Cache is inclusive of lower level caches. Only valid if
> + *	CACHE_INCLUSIVE_SET attribute is set.
>   * @shared_cpu_map: logical cpumask representing all the cpus sharing
>   *	this cache node
>   * @attributes: bitfield representing various cache attributes
> @@ -55,6 +57,7 @@ struct cacheinfo {
>  	unsigned int ways_of_associativity;
>  	unsigned int physical_line_partition;
>  	unsigned int size;
> +	unsigned int inclusive;
>  	cpumask_t shared_cpu_map;
>  	unsigned int attributes;
>  #define CACHE_WRITE_THROUGH	BIT(0)
> @@ -66,6 +69,7 @@ struct cacheinfo {
>  #define CACHE_ALLOCATE_POLICY_MASK	\
>  	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
>  #define CACHE_ID		BIT(4)
> +#define CACHE_INCLUSIVE_SET	BIT(5)
>  	void *fw_token;
>  	bool disable_sysfs;
>  	void *priv;
> -- 
> 2.17.2

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
