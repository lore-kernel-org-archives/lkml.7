Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F3020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XvIL71TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfCKIZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:25:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49558 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfCKIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:25:28 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11AA6255;
        Mon, 11 Mar 2019 09:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552292726;
        bh=e+Vf9PESDyiSHsAUUcaS72nz2DwctR8W9QsLilTiXqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvIL71TBd2DPbF4Av6VKe0ySILWOMj9AfCPUtJ2nfAOptI2hF9nuxhkZMkA5xQBWX
         Sd+0RFCEereli+W+/LULZ6JUtGwsKYx8e6qvZKPOkRzyuv85mbvge10t3WQIPPR238
         B77ELrAatpfzou8fqyhITkw7Cq7XZMliqhN4Y3tE=
Date:   Mon, 11 Mar 2019 10:25:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc_spi: add a status check for spi_sync_locked
Message-ID: <20190311082520.GB4775@pendragon.ideasonboard.com>
References: <20190311055334.13670-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311055334.13670-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch.

On Mon, Mar 11, 2019 at 12:53:33AM -0500, Kangjie Lu wrote:
> In case spi_sync_locked fails, the fix reports the error and
> returns the error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 1b1498805972..a3533935e282 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>  	}
>  
>  	status = spi_sync_locked(spi, &host->m);
> +	if (status < 0) {
> +		dev_dbg(&spi->dev, "read error %d\n", status);
> +		return status;
> +	}
>  
>  	if (host->dma_dev) {
>  		dma_sync_single_for_cpu(host->dma_dev,

-- 
Regards,

Laurent Pinchart
