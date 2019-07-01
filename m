Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E6BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725FE20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561957074;
	bh=Xoo66K/G7tcXAmjXGTmitRGCFyxgVt2d479uVZAiUpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pa2e3gx/MHojTz5dluMwVh83QSUjeKFFHIdgkMXsdMED/IwbR+1Lh9KJBTqYRjbmW
	 t4N2WYbB81HB6F533A6yQctrmixS6wh1C6XLhPvRVU6r+clp90zByebBEKNiEHrlH8
	 s+4bIl0mhLac4C/YGNnMoHmq+TxgUw77U1y4t/Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfGAE5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 00:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfGAE5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 00:57:52 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059FD208E4;
        Mon,  1 Jul 2019 04:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561957071;
        bh=Xoo66K/G7tcXAmjXGTmitRGCFyxgVt2d479uVZAiUpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pOjHruXzLwzMCPIasWt3ujiDoE1q3JURU5+mwfNEZTqecdT0+TkspW//60OUJq1m
         1pN5yUlaCNm71cv6rmBxMFtzhyDNEbcINKK0DzXPztRRr1KfIxfy+L5fKF9ZswnzOe
         NIqXYqNIXB2J2Dt/P77Guw+sjH1KU/xS6cTsXEdY=
Date:   Mon, 1 Jul 2019 10:24:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/87] dma: imx-sdma: Remove call to memset after
 dma_alloc_coherent
Message-ID: <20190701045443.GI2911@vkoul-mobl>
References: <20190627173536.2457-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627173536.2457-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-19, 01:35, Fuqian Huang wrote:
>     In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
>     dma_alloc_coherent has already zeroed the memory.
>     So memset is not needed.

Please point to the exact commit and not the merge commit. Hint use git
blame on that file...

> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/dma/imx-sdma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 99d9f431ae2c..54d86359bdf8 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1886,10 +1886,6 @@ static int sdma_init(struct sdma_engine *sdma)
>  	sdma->context_phys = ccb_phys +
>  		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
>  
> -	/* Zero-out the CCB structures array just allocated */
> -	memset(sdma->channel_control, 0,
> -			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control));
> -
>  	/* disable all channels */
>  	for (i = 0; i < sdma->drvdata->num_events; i++)
>  		writel_relaxed(0, sdma->regs + chnenbl_ofs(sdma, i));
> -- 
> 2.11.0

-- 
~Vinod
