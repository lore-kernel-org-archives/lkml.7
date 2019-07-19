Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F187C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1821849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563522898;
	bh=XfKSAltxhi5qlxrolSDXSYwAaXTxg5dKO4f6VkfLQH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ioMESQXas1G17uKpq0u73ixgg5brlWMnc27h9E3K1Gyw2bFlfacvRR8CGaQInFQiv
	 aZXVHYT69h6txmDNjCQaEm5osT9+cJrhK3f5Lzh5bQBNI2ZjnJrrfLBtkqnrVYLy8s
	 tmKSsD5KUMw3wMd9kAJaCbTCSyI+CdlIxos2Tc5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfGSHy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfGSHy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:54:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1759A20651;
        Fri, 19 Jul 2019 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563522895;
        bh=XfKSAltxhi5qlxrolSDXSYwAaXTxg5dKO4f6VkfLQH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWzJZ/Q9EiDkpgygmeLpAqsq7jAzJf69p1P63qFb/0qsuHbPjUUaFvyo9oj7k9Sel
         9H8f5WCczndHkwewiOnS75Z7TDs6KI/UI/HAYeQM6DPq4JtLrBhCfhfmMKIpchPaP2
         x8RCre9eBUXIRERHXMm1Th9jwTQ/gAiPawNN0Q5A=
Date:   Fri, 19 Jul 2019 08:54:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        Frank Li <frank.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mark.rutland@arm.com
Subject: Re: [PATCH] perf tool: arch: arm64: change the way for
 get_cpuid_str() function
Message-ID: <20190719075450.xcm4i4a5sfaxlfap@willie-the-truck>
References: <20190718061853.10403-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718061853.10403-1-qiangqing.zhang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:21:30AM +0000, Joakim Zhang wrote:
> Now the get_cpuid__str function returns the MIDR string of the first
> online cpu from the range of cpus asscociated with the PMU CORE device.
> 
> It can work when pass a perf_pmu entity to get_cpuid_str. However, it
> will pass NULL via perf_pmu__find_map from metricgroup.c if we want to add
> metric group for arm64. When pass NULL to get_cpuid_str, it can't return
> the MIDR string.

Why is this code passing a NULL PMU? What information does it actually
need? Other functions, such as print_pmu_events(), iterate over all PMUs.

> There are three methods from userspace getting MIDR string for arm64:
> 1. parse sysfs(/sys/devices/system/cpu/cpu?/regs/identification/midr_el1)
> 2. parse procfs(/proc/cpuinfo)
> 3. read the hwcaps(MIDR register) with getauxval(AT_HWCAP)
> 
> Perfer to select #3 as it is more simple and direct.

That's probably terminally broken for heterogeneous systems, so I'm not
at all happy with this patch.

Will

> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index 534cd2507d83..f58f08af0be8 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -2,64 +2,46 @@
>  #include <stdlib.h>
>  #include <api/fs/fs.h>
>  #include "header.h"
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
>  
> -#define MIDR "/regs/identification/midr_el1"
>  #define MIDR_SIZE 19
>  #define MIDR_REVISION_MASK      0xf
>  #define MIDR_VARIANT_SHIFT      20
>  #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
>  
> -char *get_cpuid_str(struct perf_pmu *pmu)
> +#define get_cpuid(id) ({					\
> +		unsigned long __val;				\
> +		asm("mrs %0, "#id : "=r" (__val));		\
> +		__val;						\
> +	})
> +
> +char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>  {
>  	char *buf = NULL;
> -	char path[PATH_MAX];
> -	const char *sysfs = sysfs__mountpoint();
> -	int cpu;
> -	u64 midr = 0;
> -	struct cpu_map *cpus;
> -	FILE *file;
> +	unsigned long midr = 0;
>  
> -	if (!sysfs || !pmu || !pmu->cpus)
> +	if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
> +		fputs("CPUID registers unavailable\n", stderr);
>  		return NULL;
> +	}
>  
> -	buf = malloc(MIDR_SIZE);
> -	if (!buf)
> +	midr = get_cpuid(MIDR_EL1);
> +	if (!midr) {
> +		fputs("Failed to get cpuid string\n", stderr);
>  		return NULL;
> +	}
>  
> -	/* read midr from list of cpus mapped to this pmu */
> -	cpus = cpu_map__get(pmu->cpus);
> -	for (cpu = 0; cpu < cpus->nr; cpu++) {
> -		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
> -				sysfs, cpus->map[cpu]);
> -
> -		file = fopen(path, "r");
> -		if (!file) {
> -			pr_debug("fopen failed for file %s\n", path);
> -			continue;
> -		}
> -
> -		if (!fgets(buf, MIDR_SIZE, file)) {
> -			fclose(file);
> -			continue;
> -		}
> -		fclose(file);
> +	/* Ignore/clear Variant[23:20] and
> +	 * Revision[3:0] of MIDR
> +	 */
> +	midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
>  
> -		/* Ignore/clear Variant[23:20] and
> -		 * Revision[3:0] of MIDR
> -		 */
> -		midr = strtoul(buf, NULL, 16);
> -		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
> -		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
> -		/* got midr break loop */
> -		break;
> -	}
> +	buf = malloc(MIDR_SIZE);
> +	if (!buf)
> +		return NULL;
>  
> -	if (!midr) {
> -		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
> -		free(buf);
> -		buf = NULL;
> -	}
> +	scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
>  
> -	cpu_map__put(cpus);
>  	return buf;
>  }
> -- 
> 2.17.1
> 
