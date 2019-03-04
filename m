Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EE12070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n9NTDpEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCDWAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:00:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCDWAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:00:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x24LwqFH047978;
        Mon, 4 Mar 2019 22:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iftc3XDYTZq/gzcZsTMIzD/nEyzJYHyftabqtY97/AA=;
 b=n9NTDpEck6H+xcvk1F1mHS/x9+m610iWAk3WdJgJSbQYWTR/rMFMe95e1a8bdWfL/UbX
 5UFcNjKfrLoBmDwDpTHlADIf59wPIA1Ow8E3zyMl+6pX3RvXVxRwBHQcFRxsN6Y5Hzhh
 /TYilu43dUpniL15I0LcO5G9g+8f6b4BhDuz2ce3KGtMFWe9dZOU16O/atdvfCb3CkDo
 ZEG9yN/mg5dZYlSI6NO2S+2hYc2kdRG1EczuFYrrF8S+PBd88PY90R2L0QxNT6DKel/G
 abfSzvQ7WMhV7VClc14A2ZzO/oJ7o0uIJm5cdctmeeerSM65DkoH9xKfI5egnBrlM7nl Lg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qyjfr9ds5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Mar 2019 22:00:15 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x24M0EEw004579
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 22:00:14 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x24M0BGI022127;
        Mon, 4 Mar 2019 22:00:12 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 14:00:11 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 3F2016A012E; Mon,  4 Mar 2019 17:00:10 -0500 (EST)
Date:   Mon, 4 Mar 2019 17:00:10 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Message-ID: <20190304220010.GD30350@char.us.oracle.com>
References: <20190304195951.1118807-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304195951.1118807-1-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903040154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:59:03PM +0100, Arnd Bergmann wrote:
> This reverts commit b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR"), which
> introduced an overflow warning in configurations that have a larger
> dma_addr_t than phys_addr_t:
> 
> In file included from include/linux/dma-direct.h:5,
>                  from kernel/dma/swiotlb.c:23:
> kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
> include/linux/dma-mapping.h:136:28: error: conversion from 'long long unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
>  #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
>                             ^
> kernel/dma/swiotlb.c:544:9: note: in expansion of macro 'DMA_MAPPING_ERROR'
>   return DMA_MAPPING_ERROR;
> 
> The configuration that caused this is on 32-bit ARM, where the DMA address
> space depends on the enabled hardware platforms, while the physical
> address space depends on the type of MMU chosen (classic vs LPAE).
> 
> I tried a couple of alternative approaches, but the previous version
> seems as good as any other, so I went back to that.

That is really a bummer.

What about making the phys_addr_t and dma_addr_t have the same
width with some magic #ifdef hackery?

> 
> Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/xen/swiotlb-xen.c | 4 ++--
>  include/linux/swiotlb.h   | 3 +++
>  kernel/dma/swiotlb.c      | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 877baf2a94f4..57a98279bf4f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -406,7 +406,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  
>  	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
>  				     attrs);
> -	if (map == DMA_MAPPING_ERROR)
> +	if (map == SWIOTLB_MAP_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
>  	dev_addr = xen_phys_to_bus(map);
> @@ -557,7 +557,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>  								 sg_phys(sg),
>  								 sg->length,
>  								 dir, attrs);
> -			if (map == DMA_MAPPING_ERROR) {
> +			if (map == SWIOTLB_MAP_ERROR) {
>  				dev_warn(hwdev, "swiotlb buffer is full\n");
>  				/* Don't panic here, we expect map_sg users
>  				   to do proper error handling. */
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 361f62bb4a8e..a65a36551f58 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -44,6 +44,9 @@ enum dma_sync_target {
>  	SYNC_FOR_DEVICE = 1,
>  };
>  
> +/* define the last possible byte of physical address space as a mapping error */
> +#define SWIOTLB_MAP_ERROR (~(phys_addr_t)0x0)
> +
>  extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  					  dma_addr_t tbl_dma_addr,
>  					  phys_addr_t phys, size_t size,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 12059b78b631..922880b84387 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -541,7 +541,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
> -	return DMA_MAPPING_ERROR;
> +	return SWIOTLB_MAP_ERROR;
>  found:
>  	io_tlb_used += nslots;
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> @@ -659,7 +659,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
>  	/* Oh well, have to allocate and map a bounce buffer. */
>  	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
>  			*phys, size, dir, attrs);
> -	if (*phys == DMA_MAPPING_ERROR)
> +	if (*phys == SWIOTLB_MAP_ERROR)
>  		return false;
>  
>  	/* Ensure that the address returned is DMA'ble */
> -- 
> 2.20.0
> 
