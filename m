Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF072184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066563;
	bh=Nfnfhu0c82XqgZzyOrfd03WeTxW95KtMNoYxuCEYNrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SNFu3bvfxKfm/u8B87m4YXXFxvg7OFEyqG2qXLq8Gnq8ckvdVpUiXspwQhkPgY2mH
	 GVFN8PSx0c2RE1BgOKHg/FUw8PfEv1EIqMQy5CnrIfxe2SvI3RTZSCpXY8hD078eml
	 pX0ltMSdytDnbJvodyS4DHdtgL6Prh9CvthT2wJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCTHWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTHWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:22:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7868921841;
        Wed, 20 Mar 2019 07:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066561;
        bh=Nfnfhu0c82XqgZzyOrfd03WeTxW95KtMNoYxuCEYNrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJAESGhJYSnjRBJHvpeBnuBTiAAdLdcIapObFQzfpB62nDo/gmSpZcLsoDCjEakqT
         Ht9hGu0UouIrzs1eIlYUampVbUIyTHZwUrBKOnEi8nvqFHkrz//h07mXlT90rv7gDm
         Ns3ihKwJPq9fTBHsRJ+VjWb329VuaecCY9Gh/0Aw=
Date:   Wed, 20 Mar 2019 08:22:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] staging: mt7621-mmc: Check for nonzero number
 of scatterlist entries
Message-ID: <20190320072237.GC1914@kroah.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
 <20190319022012.11051-8-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319022012.11051-8-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:20:08PM -0600, George Hilliard wrote:
> The buffer descriptor setup loop is correct only if it is setting up at
> least one bd struct.  Besides, there is an error somewhere if
> dma_map_sg() returns 0.  So add a paranoid check for this condition.
> 
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index c272aa780719..31c5b44bd29f 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -593,7 +593,12 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
>  	struct bd *bd;
>  	u32 j;
>  
> -	BUG_ON(sglen > MAX_BD_NUM); /* not support currently */
> +	// Shouldn't happen; we configure the mmc host layer
> +	// based on MAX_BD_NUM:
> +	BUG_ON(sglen > MAX_BD_NUM);
> +	// Correct setup below requires at least one bd
> +	// (and dma_map_sg should not return 0):
> +	BUG_ON(sglen == 0);

Same here, no new BUG_ON().  To quote one kernel developer, "BUG_ON()
means that the programmer is lazy" :)

thanks,

greg k-h
