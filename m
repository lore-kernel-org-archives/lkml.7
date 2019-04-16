Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD36C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAA820821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415371;
	bh=tBug0k26lfhe+YjlBGweMCvHQ8XmI6Cu/5UrIpNkXig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KwaqO9JJ5k0f4ETN0vHuVvSberXDDvFUCrvv/H/mieKV/s8T78SHEImWSVtivIDZP
	 FQtST5ofmFDm3IEjaBbdYlSNkP8lyIGxs7oaXiPBqpX4soB4Zro8o9Qcazs9tYJ3eX
	 0WYvG1c0xon9kvhh867NQjZ3W0EOBZ5DukLnzUAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfDPLt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfDPLt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:49:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A430820821;
        Tue, 16 Apr 2019 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415367;
        bh=tBug0k26lfhe+YjlBGweMCvHQ8XmI6Cu/5UrIpNkXig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x7nxRR35dBzN0pfxwUuOArgYIWB9SXxCVnmODQNeqCBApKsiFLlc73umxzrFVAORU
         9mie9ZKaCzOW2ham1QO+Z/3QprQTweyV8P6Ro45Ex4yd6NKlr5/mOUaU037u3slM91
         MTIrJBw9zSniqD9C8KI8AvLd0OTqYsys3DPuLGbM=
Date:   Tue, 16 Apr 2019 13:44:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: mt7621-mmc: Use DIV_ROUND_UP in function
 msdc_set_mclk
Message-ID: <20190416114427.GA17623@kroah.com>
References: <20190403151608.27326-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403151608.27326-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:16:08AM -0500, Madhumitha Prabakaran wrote:
> Use DIV_ROUND_UP to make code simple and more understandable.
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 4b26ec896a96..b12ed2c988fd 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -240,7 +240,7 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
>  			div  = 1;         /* mean div = 1/4 */
>  			sclk = hclk >> 2; /* sclk = clk / 4 */
>  		} else {
> -			div  = (hclk + ((hz << 2) - 1)) / (hz << 2);
> +			div  = DIV_ROUND_UP(hclk, (hz << 2));
>  			sclk = (hclk >> 2) / div;
>  		}
>  	} else if (hz >= hclk) { /* bug fix */
> @@ -253,7 +253,7 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
>  			div  = 0;         /* mean div = 1/2 */
>  			sclk = hclk >> 1; /* sclk = clk / 2 */
>  		} else {
> -			div  = (hclk + ((hz << 2) - 1)) / (hz << 2);
> +			div  = DIV_ROUND_UP(hclk, (hz << 2));
>  			sclk = (hclk >> 2) / div;
>  		}
>  	}

This file is no longer in the kernel tree :(
