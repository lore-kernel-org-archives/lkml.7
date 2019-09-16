Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D53C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D953820830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfIPOa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:30:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46433 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbfIPOa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:30:28 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1i9s1K-0003g6-HX; Mon, 16 Sep 2019 16:30:26 +0200
Message-ID: <fcc6e54f56089d2204ca9aff79ac769a62b3adcb.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] dmaengine: imx-sdma: drop redundant variable
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 16 Sep 2019 16:30:25 +0200
In-Reply-To: <20190911144943.21554-5-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
         <20190911144943.21554-5-philipp.puschmann@emlix.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2019-09-11 at 16:49 +0200, Philipp Puschmann wrote:
> In sdma_prep_dma_cyclic buf is redundant. Drop it.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 6a5a84504858..5b6beeee9f0e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1544,7 +1544,7 @@ static struct dma_async_tx_descriptor
> *sdma_prep_dma_cyclic(
>  	struct sdma_engine *sdma = sdmac->sdma;
>  	int num_periods = buf_len / period_len;
>  	int channel = sdmac->channel;
> -	int i = 0, buf = 0;
> +	int i;
>  	struct sdma_desc *desc;
>  
>  	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
> @@ -1565,7 +1565,7 @@ static struct dma_async_tx_descriptor
> *sdma_prep_dma_cyclic(
>  		goto err_bd_out;
>  	}
>  
> -	while (buf < buf_len) {
> +	for (i = 0; i < num_periods; i++) {
>  		struct sdma_buffer_descriptor *bd = &desc->bd[i];
>  		int param;
>  
> @@ -1592,9 +1592,6 @@ static struct dma_async_tx_descriptor
> *sdma_prep_dma_cyclic(
>  		bd->mode.status = param;
>  
>  		dma_addr += period_len;
> -		buf += period_len;
> -
> -		i++;
>  	}
>  
>  	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);

