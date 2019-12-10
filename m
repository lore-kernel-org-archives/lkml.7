Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A061C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1214820663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575957681;
	bh=WNIfmB88s9UZ8M12PiZh81hOpj6ylIlhnBkBtWuyi9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+o/TZMS/xe60NxbtNp7Mx6b+nOl9tk6HJHXWR81HxxzEZrHaLZ55SkEAjNLIBf8/
	 LVkgYPAVcYEr34PrtzSPOtXTolGr7lH6YMRi4qFuZrWajorq0S9yejTEb9FkPrkEYM
	 rPhQhb5JUtifvM82Ekrce1pWpP4gBtMpnJ+0ZZHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfLJGBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:01:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfLJGBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:01:19 -0500
Received: from localhost (unknown [106.201.45.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D69620652;
        Tue, 10 Dec 2019 06:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575957679;
        bh=WNIfmB88s9UZ8M12PiZh81hOpj6ylIlhnBkBtWuyi9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppYs4e1842YT8R2SlHONcx+MnJXqwZKo+ByMr6Elz0Atvfi4zJp/+ru+zwQF0zzEf
         evrGaBdkM7oVk+1hoR2SA+4WisSSIH9h0F70+r+kgYIrwt/GIKmAIWj4wAc3P+Ksfm
         njmlq5yWHvcppV1AJAYUP664gom6eX4KnReyn7D4=
Date:   Tue, 10 Dec 2019 11:31:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
 dma_terminate_all
Message-ID: <20191210060113.GP82508@vkoul-mobl>
References: <1574664121-13451-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574664121-13451-1-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-19, 12:12, Radhey Shyam Pandey wrote:
> Reset DMA channel after stop to ensure that pending transfers and FIFOs
> in the datapath are flushed or completed. It fixes intermittent data
> verification failure reported by xilinx dma test client.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index a9c5d5c..6f1539c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2404,16 +2404,17 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
>  	u32 reg;
>  	int err;
>  
> -	if (chan->cyclic)
> -		xilinx_dma_chan_reset(chan);

So reset is required for non cyclic cases as well now?

> -
> -	err = chan->stop_transfer(chan);
> -	if (err) {
> -		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
> -			chan, dma_ctrl_read(chan, XILINX_DMA_REG_DMASR));
> -		chan->err = true;
> +	if (!chan->cyclic) {
> +		err = chan->stop_transfer(chan);

no stop for cyclic now..?

> +		if (err) {
> +			dev_err(chan->dev, "Cannot stop channel %p: %x\n",
> +				chan, dma_ctrl_read(chan,
> +				XILINX_DMA_REG_DMASR));
> +			chan->err = true;
> +		}
>  	}
>  
> +	xilinx_dma_chan_reset(chan);
>  	/* Remove and free all of the descriptors in the lists */
>  	xilinx_dma_free_descriptors(chan);
>  	chan->idle = true;
> -- 
> 2.7.4

-- 
~Vinod
