Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832A5C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 04:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5943E20718
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 04:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577162240;
	bh=MTC8x6597YAibU9FQCS3ExzUhGCIVEAaMacsH86pYiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p9ylcYrtA9hw7u1Z8Vker935eBRbl7JqlG2QPRkF5K6N/N15ZuR4cZkXlAfAk/aqq
	 bHS50vSlEMU0iiHjOxuZ2zhoQ3wI9ogni0TnP0Ow6dwrVTr8t7tpbgh4s6FBuRR4+0
	 TCk4jkwS7nMKOXGkmZX8qLW+StsHEhkeA5DOFDpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLXEhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 23:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfLXEhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 23:37:18 -0500
Received: from localhost (unknown [122.167.68.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4468C206CB;
        Tue, 24 Dec 2019 04:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577162238;
        bh=MTC8x6597YAibU9FQCS3ExzUhGCIVEAaMacsH86pYiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJljMcQgPMazwkiE30XJib/B4iEsUNt3YxCMH1ktyaETGf4selR9MDcqqVGUilygL
         Q4xJ5UaKJo1npm3kuwuTi2WSw1YgmJWwYoV+UiAq+zMwsrjbexjmq489g3kMSRVzg0
         7a7ld1ZJlG98f0G5/Y18AkfBHOjh6jEszOWYBCvQ=
Date:   Tue, 24 Dec 2019 10:07:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>
Subject: Re: [PATCH 2/5] dmaengine: Call module_put() after
 device_free_chan_resources()
Message-ID: <20191224043713.GH2536@vkoul-mobl>
References: <20191216190120.21374-1-logang@deltatee.com>
 <20191216190120.21374-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216190120.21374-3-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-19, 12:01, Logan Gunthorpe wrote:
> The module reference is taken to ensure the callbacks still exist
> when they are called. If the channel holds the last reference to the
> module, the module can disappear before device_free_chan_resources() is
> called and would cause a call into free'd memory.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/dmaengine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 4b604086b1b3..776fdf535a3a 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -250,7 +250,6 @@ static void dma_chan_put(struct dma_chan *chan)
>  		return;
>  
>  	chan->client_count--;
> -	module_put(dma_chan_to_owner(chan));
>  
>  	/* This channel is not in use anymore, free it */
>  	if (!chan->client_count && chan->device->device_free_chan_resources) {
> @@ -259,6 +258,8 @@ static void dma_chan_put(struct dma_chan *chan)
>  		chan->device->device_free_chan_resources(chan);
>  	}
>  
> +	module_put(dma_chan_to_owner(chan));
> +
>  	/* If the channel is used via a DMA request router, free the mapping */
>  	if (chan->router && chan->router->route_free) {
>  		chan->router->route_free(chan->router->dev, chan->route_data);

I think this should be moved here after route_free() and will take care
of route cleanup as well

Thanks
-- 
~Vinod
