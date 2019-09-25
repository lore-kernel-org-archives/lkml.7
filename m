Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D810FC4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A152421D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569444258;
	bh=BDZHp0eNrun4oNBdl/+/8wVxzKPCel7N+XQ75rREyFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oedD5e9VfkK1RuDk7Y56QWhMxLviY+bs3PkQ6DMPWkBday65AuUfOA5JU3FeBOHaa
	 HUUd4H6iCoDjIExTUgMB/husCBJaNBjnL0uRAiQMOv/+wInHbRG3QbUnc/Jp1iF/su
	 KCgguMWmGoRYwMllglxc9oWtjD4TcqB0H3a9xjtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbfIYUoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbfIYUoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:44:17 -0400
Received: from localhost (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E06121D79;
        Wed, 25 Sep 2019 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569444256;
        bh=BDZHp0eNrun4oNBdl/+/8wVxzKPCel7N+XQ75rREyFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvSZk6EmJYtebbar7RnApJACQRlI0QLUMPDYSjK2aT7BCs6xdyrelFGWXOU6x6xfn
         btFGu+hhdiedT/1UdTcG0vsFFGu0sZE2m9lEdCkKbyTSrXM2s0LKabUpFUx2O0RHWb
         ycSxoeylFrqoOP5TSLqKRa/ZgSnVhtP+geQnNNJU=
Date:   Wed, 25 Sep 2019 13:43:15 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: iop-adma: make array 'handler' static const,
 makes object smaller
Message-ID: <20190925204315.GK3824@vkoul-mobl>
References: <20190905163726.19690-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905163726.19690-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-09-19, 17:37, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array 'handler' on the stack but instead make it
> static const. Makes the object code smaller by 80 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   38225	   9084	     64	  47373	   b90d	drivers/dma/iop-adma.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   38081	   9148	     64	  47293	   b8bd	drivers/dma/iop-adma.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/iop-adma.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
> index a3f942a6a946..4dc5478fc156 100644
> --- a/drivers/dma/iop-adma.c
> +++ b/drivers/dma/iop-adma.c
> @@ -1359,9 +1359,11 @@ static int iop_adma_probe(struct platform_device *pdev)
>  	iop_adma_device_clear_err_status(iop_chan);
>  
>  	for (i = 0; i < 3; i++) {
> -		irq_handler_t handler[] = { iop_adma_eot_handler,
> -					iop_adma_eoc_handler,
> -					iop_adma_err_handler };
> +		static const irq_handler_t handler[] = {
> +			iop_adma_eot_handler,
> +			iop_adma_eoc_handler,
> +			iop_adma_err_handler

would it not be more apt to declare the handler outside the loop!

> +		};
>  		int irq = platform_get_irq(pdev, i);
>  		if (irq < 0) {
>  			ret = -ENXIO;
> -- 
> 2.20.1

-- 
~Vinod
