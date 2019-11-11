Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C3C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFA6214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573447204;
	bh=IbqTizAofEr4fAlNvQZJC9e5XYpXENQc/RRIOCFORfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VVvZyqnH3xx61ce3yTX1wh4y+lCsJlM7yhhV0AOmiscZPvR3swByr233Opr+09r/j
	 9f2CMWa/mtAp76zO7C8UgRU/vJ17Jtdz8wnBNMvtV7lUKEeAPzOD3JXjR0AAR0iBIV
	 81BPEyXgN6m189RoIPeO0/kvZESsPwBuWyo5OfQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfKKEkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 23:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfKKEkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 23:40:03 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B0F20856;
        Mon, 11 Nov 2019 04:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573447202;
        bh=IbqTizAofEr4fAlNvQZJC9e5XYpXENQc/RRIOCFORfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMA4xX1cvwbWOJT0hA/nZrCBydq0lxFRgimzmpVnyya2HCzceOyfJkrKVI8G/SZS1
         98tvL1CrGZrU4BECstDOm7rjbgm7pHuDnrSM4/IncQsFOABV/RhsR9m3RcCNUoojCx
         RG3iHH00fUKscPWTdoARJf3TIlsMeDNz1/Yk8GbU=
Date:   Mon, 11 Nov 2019 10:09:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 05/15] dmaengine: Add support for reporting DMA cached
 data amount
Message-ID: <20191111043957.GL952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-6-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-6-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:
> A DMA hardware can have big cache or FIFO and the amount of data sitting in
> the DMA fabric can be an interest for the clients.
> 
> For example in audio we want to know the delay in the data flow and in case
> the DMA have significantly large FIFO/cache, it can affect the latenc/delay
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/dma/dmaengine.h   | 8 ++++++++
>  include/linux/dmaengine.h | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 501c0b063f85..b0b97475707a 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -77,6 +77,7 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
>  		state->last = complete;
>  		state->used = used;
>  		state->residue = 0;
> +		state->in_flight_bytes = 0;
>  	}
>  	return dma_async_is_complete(cookie, complete, used);
>  }
> @@ -87,6 +88,13 @@ static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
>  		state->residue = residue;
>  }
>  
> +static inline void dma_set_in_flight_bytes(struct dma_tx_state *state,
> +					   u32 in_flight_bytes)
> +{
> +	if (state)
> +		state->in_flight_bytes = in_flight_bytes;
> +}
> +
>  struct dmaengine_desc_callback {
>  	dma_async_tx_callback callback;
>  	dma_async_tx_callback_result callback_result;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 0e8b426bbde9..c4c5219030a6 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -682,11 +682,13 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
>   * @residue: the remaining number of bytes left to transmit
>   *	on the selected transfer for states DMA_IN_PROGRESS and
>   *	DMA_PAUSED if this is implemented in the driver, else 0
> + * @in_flight_bytes: amount of data in bytes cached by the DMA.
>   */
>  struct dma_tx_state {
>  	dma_cookie_t last;
>  	dma_cookie_t used;
>  	u32 residue;
> +	u32 in_flight_bytes;

Should we add this here or use the dmaengine_result()

-- 
~Vinod
