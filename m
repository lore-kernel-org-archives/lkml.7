Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08314C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D032721907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfISK2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:28:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52961 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbfISK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:27:59 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iAtfK-0005Fo-Jo; Thu, 19 Sep 2019 12:27:58 +0200
Message-ID: <7d694da8ffe098c6c8f6fe9c3a2306fda55eb655.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] dmaengine: imx-sdma: fix buffer ownership
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        linux-kernel@vger.kernel.org
Cc:     yibin.gong@nxp.com, fugang.duan@nxp.com, dan.j.williams@intel.com,
        vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 Sep 2019 12:27:58 +0200
In-Reply-To: <20190919102319.23368-2-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
         <20190919102319.23368-1-philipp.puschmann@emlix.com>
         <20190919102319.23368-2-philipp.puschmann@emlix.com>
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

Hi Philipp,

On Do, 2019-09-19 at 12:23 +0200, Philipp Puschmann wrote:
> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the
> buffer, when 0 ARM owns it. When processing the buffers in
> sdma_update_channel_loop the ownership of the currently processed
> buffer was set to SDMA again before running the callback function of
> the buffer and while the sdma script may be running in parallel. So
> there was the possibility to get the buffer overwritten by SDMA
> before
> it has been processed by kernel leading to kind of random errors in
> the
> upper layers, e.g. bluetooth.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> 
> ---
> 
> Changelog v2:
>  - add dma_wb()
> 
>  drivers/dma/imx-sdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 9ba74ab7e912..e029a2443cfc 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct
> sdma_channel *sdmac)
>  		*/
>  
>  		desc->chn_real_count = bd->mode.count;
> -		bd->mode.status |= BD_DONE;
>  		bd->mode.count = desc->period_len;
>  		desc->buf_ptail = desc->buf_tail;
>  		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
> @@ -817,6 +816,9 @@ static void sdma_update_channel_loop(struct
> sdma_channel *sdmac)
>  		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
>  		spin_lock(&sdmac->vc.lock);
>  
> +		dma_wb();

Has this change been tested? The function you want here is called
dma_wmb().

Regards,
Lucas

> +		bd->mode.status |= BD_DONE;
> +
>  		if (error)
>  			sdmac->status = old_status;
>  	}

