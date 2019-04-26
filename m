Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E607AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B511F208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556279456;
	bh=Lwhq3yGTLwZBXZG7d5cZPZUNHsm6dVmKEROQ8WGGliM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nXdE9eD/CaiAbAl8LWmjhcThAF6E2K1s/TRrmcv3fx7ywwYnXpOXfz83euPx0ozW2
	 QaiQIDWZ3Q4cNW+6jOp0XwknpvdUQKZeXx+gMBB59L+fCCOX1gqZixgDM/mZRrcErY
	 nEqPtz1UWgBRMLLH8hMNaJOkv9zkdqq8G9b72/98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDZLu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZLuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:50:55 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40FA2084F;
        Fri, 26 Apr 2019 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556279454;
        bh=Lwhq3yGTLwZBXZG7d5cZPZUNHsm6dVmKEROQ8WGGliM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OE7X96wLJ7r/44OQU/ONgLqbtBQX7QoV3QL1ig4fkpoXr7iI9ywW2ec1D04l93k/o
         qEsS92zXBO446tnIdei/yZe7BrE6iVH4dpvvqCqm9Owdwl+33QHhP+Hj059DB0P8U1
         TRQHEwHFiJULFK9HMQ55/A1W3iZRkSIxmrbBO9Ks=
Date:   Fri, 26 Apr 2019 17:20:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-qdma: fixed the source/destination
 descriptior format
Message-ID: <20190426115047.GW28103@vkoul-mobl>
References: <20190419084629.41742-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419084629.41742-1-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-19, 08:46, Peng Ma wrote:
> CMD of Source/Destination descriptior format should be lower of

s/descriptior/descriptor

> struct fsl_qdma_engine number data address.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  drivers/dma/fsl-qdma.c |   29 ++++++++++++++++++-----------
>  1 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index aa1d0ae..542765a 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -113,6 +113,7 @@
>  /* Field definition for Descriptor offset */
>  #define QDMA_CCDF_STATUS		20
>  #define QDMA_CCDF_OFFSET		20
> +#define QDMA_SDDF_CMD(x)		(((u64)(x)) << 32)
>  
>  /* Field definition for safe loop count*/
>  #define FSL_QDMA_HALT_COUNT		1500
> @@ -214,6 +215,12 @@ struct fsl_qdma_engine {
>  
>  };
>  
> +static inline void
> +qdma_sddf_set_cmd(struct fsl_qdma_format *sddf, u32 val)
> +{
> +	sddf->data = QDMA_SDDF_CMD(val);
> +}
> +
>  static inline u64
>  qdma_ccdf_addr_get64(const struct fsl_qdma_format *ccdf)
>  {
> @@ -341,6 +348,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
>  static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  				      dma_addr_t dst, dma_addr_t src, u32 len)
>  {
> +	u32 cmd;
>  	struct fsl_qdma_format *sdf, *ddf;
>  	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
>  
> @@ -353,6 +361,7 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  
>  	memset(fsl_comp->virt_addr, 0, FSL_QDMA_COMMAND_BUFFER_SIZE);
>  	memset(fsl_comp->desc_virt_addr, 0, FSL_QDMA_DESCRIPTOR_BUFFER_SIZE);
> +
>  	/* Head Command Descriptor(Frame Descriptor) */
>  	qdma_desc_addr_set64(ccdf, fsl_comp->bus_addr + 16);
>  	qdma_ccdf_set_format(ccdf, qdma_ccdf_get_offset(ccdf));
> @@ -369,14 +378,14 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  	/* This entry is the last entry. */
>  	qdma_csgf_set_f(csgf_dest, len);
>  	/* Descriptor Buffer */
> -	sdf->data =
> -		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
> -			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
> -	ddf->data =
> -		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
> -			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
> -	ddf->data |=
> -		cpu_to_le64(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
> +	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> +			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
> +	qdma_sddf_set_cmd(sdf, cmd);
> +
> +	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> +			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
> +	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
> +	qdma_sddf_set_cmd(ddf, cmd);
>  }
>  
>  /*
> @@ -701,10 +710,8 @@ static irqreturn_t fsl_qdma_error_handler(int irq, void *dev_id)
>  
>  	intr = qdma_readl(fsl_qdma, status + FSL_QDMA_DEDR);
>  
> -	if (intr) {
> +	if (intr)
>  		dev_err(fsl_qdma->dma_dev.dev, "DMA transaction error!\n");
> -		return IRQ_NONE;
> -	}

this seems unrelated can you explain?

>  
>  	qdma_writel(fsl_qdma, FSL_QDMA_DEDR_CLEAR, status + FSL_QDMA_DEDR);
>  	return IRQ_HANDLED;
> -- 
> 1.7.1

-- 
~Vinod
