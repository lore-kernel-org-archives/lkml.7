Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AFCC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9BF218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567944977;
	bh=I6rWRHaNedcvLoxTXZr5u4VVQbWS7vhOw83Pfjw9FPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FqKgDgJgNGcXgI+TiKOVz/TTgvT5Z1FdyiWL4CHDSIz5ndgMdBFDCBUQ5B3KL50Xw
	 xoqLYz0OFaHovJZiBFp30kVJ+p4G1kugUDJbD05kFvFEBMrFFxGkMtjXCHfPs6Rsmt
	 oy+05yBTWvaZDzGY6pJAJX+aOl1Snm6qshGUEszM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfIHMQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbfIHMQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:16:16 -0400
Received: from localhost (unknown [122.182.221.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41670214D9;
        Sun,  8 Sep 2019 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944976;
        bh=I6rWRHaNedcvLoxTXZr5u4VVQbWS7vhOw83Pfjw9FPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfE6J2n16FueM2f5TUyJrXOXzAoDGX+5c9xf+UpDNVDwAXuRF5fVantJky4mDcWCy
         xnlsN4a5JMT2n0m2eStrpqi6TM0O0PXk2d8xc43HettTdqH14OQzPfm9r/29BA3ik0
         ulNfG32fmow5KfRZE/6hFEfCrS/8I6OollYJ4dnQ=
Date:   Sun, 8 Sep 2019 17:45:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 3/3] dmaengine: Support for requesting channels preferring
 DMA domain controller
Message-ID: <20190908121507.GN2672@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-4-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906141816.24095-4-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-09-19, 17:18, Peter Ujfalusi wrote:
> In case the channel is not requested via the slave API, use the
> of_find_dma_domain() to see if a system default DMA controller is
> specified.
> 
> Add new function which can be used by clients to request channels by mask
> from their DMA domain controller if specified.
> 
> Client drivers can take advantage of the domain support by moving from
> dma_request_chan_by_mask() to dma_domain_request_chan_by_mask()
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c   | 17 ++++++++++++-----
>  include/linux/dmaengine.h |  9 ++++++---
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 6baddf7dcbfd..087450eed68c 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -640,6 +640,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  	struct dma_device *device, *_d;
>  	struct dma_chan *chan = NULL;
>  
> +	/* If np is not specified, get the default DMA domain controller */
> +	if (!np)
> +		np = of_find_dma_domain(NULL);
> +
>  	/* Find a channel */
>  	mutex_lock(&dma_list_mutex);
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
> @@ -751,19 +755,22 @@ struct dma_chan *dma_request_slave_channel(struct device *dev,
>  EXPORT_SYMBOL_GPL(dma_request_slave_channel);
>  
>  /**
> - * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
> - * @mask: capabilities that the channel must satisfy
> + * dma_domain_request_chan_by_mask - allocate a channel by mask from DMA domain
> + * @dev:	pointer to client device structure
> + * @mask:	capabilities that the channel must satisfy
>   *
>   * Returns pointer to appropriate DMA channel on success or an error pointer.
>   */
> -struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
> +struct dma_chan *dma_domain_request_chan_by_mask(struct device *dev,
> +						 const dma_cap_mask_t *mask)

should we really use dma_request_chan_by_mask() why not create a new api
dma_request_chan_by_domain() and use that, it falls back to
dma_request_chan_by_mask() if it doesnt find a valid domain!

-- 
~Vinod
