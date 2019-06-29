Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA9BC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93687214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kg/T8ZN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfF2PYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:24:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40974 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfF2PYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:24:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5TFKfvP148349;
        Sat, 29 Jun 2019 15:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4OHLK4IWIUnj6L3SkVEiPHXjBaVqnaA9UEdmYiKZwwg=;
 b=Kg/T8ZN0wWYoQgjjRK105k/MzXc/SM0KUMguWeKPQi1wCDb5KkowkOKAc+eZEBt3PysI
 FopjaD0TSGtkdMGsA9IdYfmqRP2Z0xOQ5Axsy+oEJyxiGSGeR36yeu2XmUm199B+iNTa
 O2mIIIIJXGZIW22hJo7vlHrl/CL8bs55KIzBljsKtFpQ0qgi8zWBzhpQf7Ugb2NUbUpe
 glyog0BLncSx51SxU6CXDwZw4snTa6ZTlBmfi2bo7q4B6Q33w7fKKHTi3lHZVJ5elZQ8
 in7+oetTHEFUa6A6POE/cm5jOLD3b53I/FiFs6JuwEFi94emEPeOnCGW1tJ6mGZ7t8U1 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tb8d8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jun 2019 15:24:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5TFO3k5139273;
        Sat, 29 Jun 2019 15:24:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tdw3sdjdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jun 2019 15:24:31 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5TFOQoj019427;
        Sat, 29 Jun 2019 15:24:26 GMT
Received: from [10.175.49.61] (/10.175.49.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Jun 2019 08:24:26 -0700
Subject: Re: [PATCH v8 4/5] x86/xsave: Make XSAVE check the base CPUID
 features before enabling
To:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
References: <20171005215256.25659-1-andi@firstfloor.org>
 <20171005215256.25659-5-andi@firstfloor.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <a36a8cc2-3d9e-dc70-bbe4-bfc5edef395a@oracle.com>
Date:   Sat, 29 Jun 2019 17:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20171005215256.25659-5-andi@firstfloor.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9303 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906290192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9303 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906290192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/17 11:52 PM, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Before enabling XSAVE, not only check the XSAVE specific CPUID bits,
> but also the base CPUID features of the respective XSAVE feature.
> This allows to disable individual XSAVE states using the existing
> clearcpuid= option, which can be useful for performance testing
> and debugging, and also in general avoids inconsistencies.
> 
> v2:
> Add curly brackets (Thomas Gleixner)
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   arch/x86/kernel/fpu/xstate.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index f1d5476c9022..924bd895b5ee 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -15,6 +15,7 @@
>   #include <asm/fpu/xstate.h>
>   
>   #include <asm/tlbflush.h>
> +#include <asm/cpufeature.h>
>   
>   /*
>    * Although we spell it out in here, the Processor Trace
> @@ -36,6 +37,19 @@ static const char *xfeature_names[] =
>   	"unknown xstate feature"	,
>   };
>   
> +static short xsave_cpuid_features[] = {
> +	X86_FEATURE_FPU,
> +	X86_FEATURE_XMM,
> +	X86_FEATURE_AVX,
> +	X86_FEATURE_MPX,
> +	X86_FEATURE_MPX,
> +	X86_FEATURE_AVX512F,
> +	X86_FEATURE_AVX512F,
> +	X86_FEATURE_AVX512F,
> +	X86_FEATURE_INTEL_PT,
> +	X86_FEATURE_PKU,
> +};
> +
>   /*
>    * Mask of xstate features supported by the CPU and the kernel:
>    */
> @@ -726,6 +740,7 @@ void __init fpu__init_system_xstate(void)
>   	unsigned int eax, ebx, ecx, edx;
>   	static int on_boot_cpu __initdata = 1;
>   	int err;
> +	int i;
>   
>   	WARN_ON_FPU(!on_boot_cpu);
>   	on_boot_cpu = 0;
> @@ -759,6 +774,14 @@ void __init fpu__init_system_xstate(void)
>   		goto out_disable;
>   	}
>   
> +	/*
> +	 * Clear XSAVE features that are disabled in the normal CPUID.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
> +		if (!boot_cpu_has(xsave_cpuid_features[i]))
> +			xfeatures_mask &= ~BIT(i);
> +	}
> +
>   	xfeatures_mask &= fpu__get_supported_xfeatures_mask();
>   
>   	/* Enable xstate instructions to be able to continue with initialization: */
> 

Hi,

The commit for this patch in mainline
(ccb18db2ab9d923df07e7495123fe5fb02329713) causes the kernel to hang on
boot when passing the "nofxsr" option:

$ kvm -cpu host -kernel arch/x86/boot/bzImage -append "console=ttyS0 
nofxsr earlyprintk=ttyS0" -serial stdio -display none -smp 2
early console in extract_kernel
input_data: 0x0000000001dea276
input_len: 0x0000000000500704
output: 0x0000000001000000
output_len: 0x00000000012c79b4
kernel_total_size: 0x0000000000f24000
booted via startup_32()
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel.
[..hang..]

If I revert it from Linus's tree (~5.2-rc6) then it boots again:

early console in extract_kernel
input_data: 0x00000000024192e9
input_len: 0x00000000005d8ea1
output: 0x0000000001000000
output_len: 0x00000000019c7fa4
kernel_total_size: 0x000000000162c000
trampoline_32bit: 0x000000000009d000
booted via startup_32()
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel.
Linux version 5.2.0-rc6+ (vegard@t460) (gcc version 5.5.0 20171010 
(Ubuntu 5.5.0-12ubuntu1~16.04)) #98 SMP PREEMPT Sat Jun 29 17:13:31 CEST 
2019
Command line: console=ttyS0 nofxsr earlyprintk=ttyS0
[..normal boot..]

/proc/cpuinfo inside the VM is:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 78
model name      : Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
stepping        : 3
microcode       : 0x1
cpu MHz         : 2496.000
cache size      : 4096 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon rep_good nopl cpuid tsc_known_freq 
pni pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 
3dnowprefetch cpuid_fault invpcid_single pti ssbd ibrs ibpb tpr_shadow 
vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep 
bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec 
xgetbv1 xsaves arat
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass 
l1tf mds
bogomips        : 4992.00
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management:


Vegard
