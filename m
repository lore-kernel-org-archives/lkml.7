Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB27C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 06:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA9E213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 06:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bZPz666g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="irf3fxEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfDGGeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 02:34:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfDGGeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 02:34:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7591960A60; Sun,  7 Apr 2019 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554618863;
        bh=aNWT/8QGNC2pNgzdXj3Gg0XyzCXORJgelXSiZwb4B24=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bZPz666g0x5kO5sYzU8wFuXyqDl5InKMidJXp1/wWkY6AmNT4R4U6gCJgEj06rAqZ
         XsLw2svPugEI3XxPAnlL1Tp3CtZidrL6IHMSD3Bv8cE0ZSNugrAgFWCSQYSds1eFfj
         mLCi3d9IRC75GjMF9q9BBdZYzDnjTqEuDcuvDwyQ=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA7CA60303;
        Sun,  7 Apr 2019 06:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554618862;
        bh=aNWT/8QGNC2pNgzdXj3Gg0XyzCXORJgelXSiZwb4B24=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=irf3fxEX9iuEExwZm2DzHDZ6gtPup4oiuP0mu9FK5uz2AF5jQcprR0+gt9svWbw5V
         MrBV9UCmdRReE1k1aS8WVWFHiLcqUvp/4Aj2Usm8+L0+ZU6rVmY2kZC3o0aMGUuGZV
         ViPVN4pEq/Uujp/6jU+qNT6/3H5mjqMQmqKFR+aE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA7CA60303
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] powerpc/pseries/iommu: fix set but not used values
To:     Qian Cai <cai@lca.pw>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190407024808.39821-1-cai@lca.pw>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ed223f2f-378b-1147-c482-6911f0e9941d@codeaurora.org>
Date:   Sun, 7 Apr 2019 12:04:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407024808.39821-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/2019 8:18 AM, Qian Cai wrote:
> The commit b7d6bf4fdd47 ("powerpc/pseries/pci: Remove obsolete SW
> invalidate") left 2 variables unused.
>
> arch/powerpc/platforms/pseries/iommu.c: In function 'tce_build_pSeries':
> arch/powerpc/platforms/pseries/iommu.c:108:17: warning: variable 'tces'
> set but not used [-Wunused-but-set-variable]
>    __be64 *tcep, *tces;
>                   ^~~~
> arch/powerpc/platforms/pseries/iommu.c: In function 'tce_free_pSeries':
> arch/powerpc/platforms/pseries/iommu.c:132:17: warning: variable 'tces'
> set but not used [-Wunused-but-set-variable]
>    __be64 *tcep, *tces;
>                   ^~~~
>
> Also, the commit 68c0449ea16d ("powerpc/pseries/iommu: Use memory@ nodes
> in max RAM address calculation") set "ranges" in
> ddw_memory_hotplug_max() but never use it.
>
> arch/powerpc/platforms/pseries/iommu.c: In function
> 'ddw_memory_hotplug_max':
> arch/powerpc/platforms/pseries/iommu.c:948:7: warning: variable 'ranges'
> set but not used [-Wunused-but-set-variable]
>     int ranges, n_mem_addr_cells, n_mem_size_cells, len;
>         ^~~~~~
>
> Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   arch/powerpc/platforms/pseries/iommu.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 36eb1ddbac69..03bbb299320e 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -105,7 +105,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>   			      unsigned long attrs)
>   {
>   	u64 proto_tce;
> -	__be64 *tcep, *tces;
> +	__be64 *tcep;
>   	u64 rpn;
>   
>   	proto_tce = TCE_PCI_READ; // Read allowed
> @@ -113,7 +113,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>   	if (direction != DMA_TO_DEVICE)
>   		proto_tce |= TCE_PCI_WRITE;
>   
> -	tces = tcep = ((__be64 *)tbl->it_base) + index;
> +	tcep = ((__be64 *)tbl->it_base) + index;
>   
>   	while (npages--) {
>   		/* can't move this out since we might cross MEMBLOCK boundary */
> @@ -129,9 +129,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>   
>   static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
>   {
> -	__be64 *tcep, *tces;
> +	__be64 *tcep;
>   
> -	tces = tcep = ((__be64 *)tbl->it_base) + index;
> +	tcep = ((__be64 *)tbl->it_base) + index;
>   
>   	while (npages--)
>   		*(tcep++) = 0;
> @@ -945,7 +945,7 @@ static phys_addr_t ddw_memory_hotplug_max(void)
>   
>   	for_each_node_by_type(memory, "memory") {
>   		unsigned long start, size;
> -		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
> +		int n_mem_addr_cells, n_mem_size_cells, len;
>   		const __be32 *memcell_buf;
>   
>   		memcell_buf = of_get_property(memory, "reg", &len);
> @@ -955,9 +955,6 @@ static phys_addr_t ddw_memory_hotplug_max(void)
>   		n_mem_addr_cells = of_n_addr_cells(memory);
>   		n_mem_size_cells = of_n_size_cells(memory);
>   
> -		/* ranges in cell */
> -		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
> -
>   		start = of_read_number(memcell_buf, n_mem_addr_cells);
>   		memcell_buf += n_mem_addr_cells;
>   		size = of_read_number(memcell_buf, n_mem_size_cells);
