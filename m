Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6F1ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8C820B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfJIK4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:56:52 -0400
Received: from foss.arm.com ([217.140.110.172]:59804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfJIK4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:56:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4999C28;
        Wed,  9 Oct 2019 03:56:51 -0700 (PDT)
Received: from [10.37.12.37] (unknown [10.37.12.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2B713F703;
        Wed,  9 Oct 2019 03:56:48 -0700 (PDT)
Subject: Re: [PATCH v2] of: Make of_dma_get_range() work on bus nodes
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20191008195239.12852-1-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <597158a7-ce42-c4d0-62b0-5aab1ead8313@arm.com>
Date:   Wed, 9 Oct 2019 11:56:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008195239.12852-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-08 8:52 pm, Rob Herring wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Since the "dma-ranges" property is only valid for a node representing a
> bus, of_dma_get_range() currently assumes the node passed in is a leaf
> representing a device, and starts the walk from its parent. In cases
> like PCI host controllers on typical FDT systems, however, where the PCI
> endpoints are probed dynamically the initial leaf node represents the
> 'bus' itself, and this logic means we fail to consider any "dma-ranges"
> describing the host bridge itself. Rework the logic such that
> of_dma_get_range() also works correctly starting from a bus node
> containing "dma-ranges".
> 
> While this does mean "dma-ranges" could incorrectly be in a device leaf
> node, there isn't really any way in this function to ensure that a leaf
> node is or isn't a bus node.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [robh: Allow for the bus child node to still be passed in]
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Resending, hit send too quickly.
> 
> v2:
>   - Ensure once we find dma-ranges, every parent has it.
>   - Only get the #{size,address}-cells after we find non-empty dma-ranges
>   - Add a check on the 'dma-ranges' length
> 
> This is all that remains of the dma-ranges series. I've applied the rest
> of the series prep and fixes. I dropped "of: Ratify of_dma_configure()
> interface" as the assertions that the node pointer being the parent only
> when struct device doesn't have a DT node pointer is not always
> true.

I'd still like to rework of_dma_configure() so that callers don't have 
to pass a redundant node in the common case, but that can wait. For now, 
this looks good enough to un-block the various 32-bit-PCI folks at 
least, and we can consider further improvements on top. For the changes:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> I didn't include any tested-bys as this has changed a bit. A git branch
> is here[1].
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dma-masks-v2
> 
>   drivers/of/address.c | 44 ++++++++++++++++++--------------------------
>   1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 5ce69d026584..99c1b8058559 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -930,47 +930,39 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>   	const __be32 *ranges = NULL;
>   	int len, naddr, nsize, pna;
>   	int ret = 0;
> +	bool found_dma_ranges = false;
>   	u64 dmaaddr;
>   
> -	if (!node)
> -		return -EINVAL;
> -
> -	while (1) {
> -		struct device_node *parent;
> -
> -		naddr = of_n_addr_cells(node);
> -		nsize = of_n_size_cells(node);
> -
> -		parent = __of_get_dma_parent(node);
> -		of_node_put(node);
> -
> -		node = parent;
> -		if (!node)
> -			break;
> -
> +	while (node) {
>   		ranges = of_get_property(node, "dma-ranges", &len);
>   
>   		/* Ignore empty ranges, they imply no translation required */
>   		if (ranges && len > 0)
>   			break;
>   
> -		/*
> -		 * At least empty ranges has to be defined for parent node if
> -		 * DMA is supported
> -		 */
> -		if (!ranges)
> -			break;
> +		/* Once we find 'dma-ranges', then a missing one is an error */
> +		if (found_dma_ranges && !ranges) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +		found_dma_ranges = true;
> +
> +		node = of_get_next_dma_parent(node);
>   	}
>   
> -	if (!ranges) {
> +	if (!node || !ranges) {
>   		pr_debug("no dma-ranges found for node(%pOF)\n", np);
>   		ret = -ENODEV;
>   		goto out;
>   	}
>   
> -	len /= sizeof(u32);
> -
> +	naddr = of_bus_n_addr_cells(node);
> +	nsize = of_bus_n_size_cells(node);
>   	pna = of_n_addr_cells(node);
> +	if ((len / sizeof(__be32)) % (pna + naddr + nsize)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>   
>   	/* dma-ranges format:
>   	 * DMA addr	: naddr cells
> @@ -978,7 +970,7 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>   	 * size		: nsize cells
>   	 */
>   	dmaaddr = of_read_number(ranges, naddr);
> -	*paddr = of_translate_dma_address(np, ranges);
> +	*paddr = of_translate_dma_address(node, ranges + naddr);
>   	if (*paddr == OF_BAD_ADDR) {
>   		pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
>   		       dmaaddr, np);
> 
