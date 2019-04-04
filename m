Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEF8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EE421741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfDDOqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:46:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726888AbfDDOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:46:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34EjH7a106967
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 10:46:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rnjrevk9m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 10:46:36 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 4 Apr 2019 15:46:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 15:46:24 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34EkNON60031206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 14:46:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BDEAA405B;
        Thu,  4 Apr 2019 14:46:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B260BA4060;
        Thu,  4 Apr 2019 14:46:21 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Apr 2019 14:46:21 +0000 (GMT)
Date:   Thu, 4 Apr 2019 17:46:19 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/3] arm64: kdump: support reserving crashkernel above 4G
References: <20190403030546.23718-1-chenzhou10@huawei.com>
 <20190403030546.23718-2-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403030546.23718-2-chenzhou10@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19040414-0012-0000-0000-0000030B47C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040414-0013-0000-0000-000021435741
Message-Id: <20190404144618.GB6433@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 03, 2019 at 11:05:44AM +0800, Chen Zhou wrote:
> When crashkernel is reserved above 4G in memory, kernel should
> reserve some amount of low memory for swiotlb and some DMA buffers.
> 
> Kernel would try to allocate at least 256M below 4G automatically
> as x86_64 if crashkernel is above 4G. Meanwhile, support
> crashkernel=X,[high,low] in arm64.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/arm64/kernel/setup.c |  3 ++
>  arch/arm64/mm/init.c      | 71 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 413d566..82cd9a0 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -243,6 +243,9 @@ static void __init request_standard_resources(void)
>  			request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
>  		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +		    crashk_low_res.end <= res->end)
> +			request_resource(res, &crashk_low_res);
>  		if (crashk_res.end && crashk_res.start >= res->start &&
>  		    crashk_res.end <= res->end)
>  			request_resource(res, &crashk_res);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6bc1350..ceb2a25 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -64,6 +64,57 @@ EXPORT_SYMBOL(memstart_addr);
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  
>  #ifdef CONFIG_KEXEC_CORE
> +static int __init reserve_crashkernel_low(void)
> +{
> +	unsigned long long base, low_base = 0, low_size = 0;
> +	unsigned long total_low_mem;
> +	int ret;
> +
> +	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
> +	if (ret) {
> +		/*
> +		 * two parts from lib/swiotlb.c:
> +		 * -swiotlb size: user-specified with swiotlb= or default.
> +		 *
> +		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> +		 * to 8M for other buffers that may need to stay low too. Also
> +		 * make sure we allocate enough extra low memory so that we
> +		 * don't run out of DMA buffers for 32-bit devices.
> +		 */
> +		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> +	} else {
> +		/* passed with crashkernel=0,low ? */
> +		if (!low_size)
> +			return 0;
> +	}
> +
> +	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, SZ_2M);
> +	if (!low_base) {
> +		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> +				(unsigned long)(low_size >> 20));
> +		return -ENOMEM;
> +	}
> +
> +	ret = memblock_reserve(low_base, low_size);
> +	if (ret) {
> +		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
> +		return ret;
> +	}
> +
> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> +			(unsigned long)(low_size >> 20),
> +			(unsigned long)(low_base >> 20),
> +			(unsigned long)(total_low_mem >> 20));
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +
> +	return 0;
> +}
> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -74,19 +125,28 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
> +	bool high = false;
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
>  	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> +	if (ret || !crash_size) {
> +		/* crashkernel=X,high */
> +		ret = parse_crashkernel_high(boot_command_line, memblock_phys_mem_size(),
> +				&crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +		high = true;
> +	}
>  
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	if (crash_base == 0) {
>  		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> +		crash_base = memblock_find_in_range(0,
> +				high ? memblock_end_of_DRAM()
> +				: ARCH_LOW_ADDRESS_LIMIT,
>  				crash_size, SZ_2M);
>  		if (crash_base == 0) {
>  			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> @@ -112,6 +172,11 @@ static void __init reserve_crashkernel(void)
>  	}
>  	memblock_reserve(crash_base, crash_size);
>  
> +	if (crash_base >= SZ_4G && reserve_crashkernel_low()) {
> +		memblock_free(crash_base, crash_size);
> +		return;
> +	}
> +

This very reminds what x86 does. Any chance some of the code can be reused
rather than duplicated?

>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>  		crash_base, crash_base + crash_size, crash_size >> 20);
>  
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

