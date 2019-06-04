Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E95C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8167124A3C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559650243;
	bh=bx10crper5s5AYw/kBlidhtOiBbuZXbSa+8Uxao2YZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zTbJg8ipmgBvjf8pt6ZMNVf/vO4I7TWypKw4WLxVNktCptv480o74BzeESI+kTMJA
	 2J9Q3m4wIghqY8t6QE5Zcnh2x4ca8clHK9IgXbFkznC61YwS3FCzILi+atut6r8vJ6
	 J9JIys8bsq8R2UaMqekzTY/y9dYLJ9QTTaOv9OKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfFDMKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfFDMKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:10:41 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328D124A02;
        Tue,  4 Jun 2019 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559650240;
        bh=bx10crper5s5AYw/kBlidhtOiBbuZXbSa+8Uxao2YZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afx9V+aIVbqwBiSR3kTsnxskJZ0D90hjgaW18j81v/vZ4eO0q+t2nn+PZULSBPNY8
         uG54BzSzpIvaKaQLY2ld2MzeMbjT4O+JwmcVfJW56c3YEZVkuvsczGGlkG+BwVFgKO
         7YimuA7USP+Hp1SruKbCgzO8FFSIY0WZD+je0MrE=
Date:   Tue, 4 Jun 2019 17:37:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V3 2/2] dmaengine: fsl-qdma: Add improvement
Message-ID: <20190604120733.GV15118@vkoul-mobl>
References: <20190522032103.13713-1-peng.ma@nxp.com>
 <20190522032103.13713-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522032103.13713-2-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-19, 03:21, Peng Ma wrote:
> When an error occurs we should clean the error register then to return

The patch title is supposed to tell us about the change. "Add
improvement: is a very generic term!

I have change title to "Continue to clear register on error" and applied

> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V3:
> 	- no changed.
> 
>  drivers/dma/fsl-qdma.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index da8fdf5..8e341c0 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -703,10 +703,8 @@ static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
>  
>  	intr = qdma_readl(fsl_qdma, status + FSL_QDMA_DEDR);
>  
> -	if (intr) {
> +	if (intr)
>  		dev_err(fsl_qdma->dma_dev.dev, "DMA transaction error!\n");
> -		return IRQ_NONE;
> -	}
>  
>  	qdma_writel(fsl_qdma, FSL_QDMA_DEDR_CLEAR, status + FSL_QDMA_DEDR);
>  	return IRQ_HANDLED;
> -- 
> 1.7.1

-- 
~Vinod
