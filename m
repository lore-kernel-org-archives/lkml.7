Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BDDC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977072084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556281079;
	bh=de4ui+tuZDXUFHeZfBrIGjZoQ8NU2gODJGhbz3Cpnjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EMM2EiUNQrPhsqzzrDphW6VBFqp0/gkWJQHBPzg1X+5hiKDdwKA92ysSUYHW+6GdR
	 hYWXWNeuKdbgUkRoyE5igYQ6hM2M1SlEYw6bfCPHR3Se4agwETbhzU69X91BmL6cvD
	 4P4/m+4xC4O+2cYkndGtKqgDbkGMOoGJcUpS4vkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfDZMR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZMR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:17:58 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73FCF2089E;
        Fri, 26 Apr 2019 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556281077;
        bh=de4ui+tuZDXUFHeZfBrIGjZoQ8NU2gODJGhbz3Cpnjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0pB7TXqBuFjcpZPFv/22gI3vnaBkSJqd/a0HdtbiXx8m09Kaqn1uUEJ3GVwyMfdH
         JK80Bd0SMsJ5Vu8ZXnynkAN3+SPvc64/IokPcSYcGcq6KMNyETIM4xyzJJzDzM6QYI
         rNhtzv3TXhjKZYHwJN/JGf6y9nrvQHXsFp5RuwZc=
Date:   Fri, 26 Apr 2019 17:47:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dma: fix residue calculation in
 stm32-dma
Message-ID: <20190426121751.GC28103@vkoul-mobl>
References: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

Sorry for delay in review, the conference travel/vacation plan delayed
this.

On 27-03-19, 13:21, Arnaud Pouliquen wrote:
> During residue calculation. the DMA can switch to the next sg. When
> this race condition occurs, the residue returned value is not valid.
> Indeed the position in the sg returned by the hardware is the position
> of the next sg, not the current sg.
> Solution is to check the sg after the calculation to verify it.
> If a transition is detected we consider that the DMA has switched to
> the beginning of next sg.

Now, that sounds like duct tape. Why should we bother doing that.

Also looking back at the stm32_dma_desc_residue() and calls to it from
stm32_dma_tx_status() am not sure we are doing the right thing

why are we looking at next_sg here, can you explain me that please

> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  drivers/dma/stm32-dma.c | 70 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index 4903a40..30309d2 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -1038,33 +1038,77 @@ static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
>  	return ndtr << width;
>  }
>  
> +static bool stm32_dma_is_current_sg(struct stm32_dma_chan *chan)
> +{
> +	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
> +	struct stm32_dma_sg_req *sg_req;
> +	u32 dma_scr, dma_smar, id;
> +
> +	id = chan->id;
> +	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
> +
> +	if (!(dma_scr & STM32_DMA_SCR_DBM))
> +		return true;
> +
> +	sg_req = &chan->desc->sg_req[chan->next_sg];
> +
> +	if (dma_scr & STM32_DMA_SCR_CT) {
> +		dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM0AR(id));
> +		return (dma_smar == sg_req->chan_reg.dma_sm0ar);
> +	}
> +
> +	dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM1AR(id));
> +
> +	return (dma_smar == sg_req->chan_reg.dma_sm1ar);
> +}
> +
>  static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
>  				     struct stm32_dma_desc *desc,
>  				     u32 next_sg)
>  {
>  	u32 modulo, burst_size;
> -	u32 residue = 0;
> +	u32 residue;
> +	u32 n_sg = next_sg;
> +	struct stm32_dma_sg_req *sg_req = &chan->desc->sg_req[chan->next_sg];
>  	int i;
>  
> +	residue = stm32_dma_get_remaining_bytes(chan);
> +
>  	/*
> -	 * In cyclic mode, for the last period, residue = remaining bytes from
> -	 * NDTR
> +	 * Calculate the residue means compute the descriptors
> +	 * information:
> +	 * - the sg currently transferred
> +	 * - the remaining position in this sg (NDTR).
> +	 *
> +	 * The issue is that a race condition can occur if DMA is
> +	 * running. DMA can have started to transfer the next sg before
> +	 * the position in sg is read. In this case the remaing position
> +	 * can correspond to the new sg position.
> +	 * The strategy implemented in the stm32 driver is to check the
> +	 * sg transition. If detected we can not trust the SxNDTR register
> +	 * value, this register can not be up to date during the transition.
> +	 * In this case we can assume that the dma is at the beginning of next
> +	 * sg so we calculate the residue in consequence.
>  	 */
> -	if (chan->desc->cyclic && next_sg == 0) {
> -		residue = stm32_dma_get_remaining_bytes(chan);
> -		goto end;
> +
> +	if (!stm32_dma_is_current_sg(chan)) {
> +		n_sg++;
> +		if (n_sg == chan->desc->num_sgs)
> +			n_sg = 0;
> +		residue = sg_req->len;
>  	}
>  
>  	/*
> -	 * For all other periods in cyclic mode, and in sg mode,
> -	 * residue = remaining bytes from NDTR + remaining periods/sg to be
> -	 * transferred
> +	 * In cyclic mode, for the last period, residue = remaining bytes
> +	 * from NDTR,
> +	 * else for all other periods in cyclic mode, and in sg mode,
> +	 * residue = remaining bytes from NDTR + remaining
> +	 * periods/sg to be transferred
>  	 */
> -	for (i = next_sg; i < desc->num_sgs; i++)
> -		residue += desc->sg_req[i].len;
> -	residue += stm32_dma_get_remaining_bytes(chan);
> +	if (!chan->desc->cyclic || n_sg != 0)
> +		for (i = n_sg; i < desc->num_sgs; i++)
> +			residue += desc->sg_req[i].len;
>  
> -end:
>  	if (!chan->mem_burst)
>  		return residue;
>  
> -- 
> 2.7.4

-- 
~Vinod
