Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86BCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B82217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfC1Tz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:55:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54534 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfC1Tz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:55:28 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2C86028227F;
        Thu, 28 Mar 2019 19:55:26 +0000 (GMT)
Date:   Thu, 28 Mar 2019 20:55:22 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <broonie@kernel.org>, <bbrezillon@kernel.org>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <dwmw2@infradead.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>
Subject: Re: [LINUX PATCH 2/3] spi: spi-mem: call
 spi_mem_default_supports_op() first
Message-ID: <20190328205522.272e1da6@collabora.com>
In-Reply-To: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 16:46:24 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> Call spi_mem_default_supports_op() first, before calling controller
> specific ctlr->supports_op().
> With this, controller drivers can drop checking the buswidths again.

No, this was done on purpose, in case the controller does not want the
default check to be applied (say it does not need bus-width props to
be defined and has another way to check if a device can be accessed in
dual, quad or octal mode).
Just call spi_mem_default_supports_op() from your driver
->supports_op() hook if needed.

> 
> Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Details can be found at https://lkml.org/lkml/2019/3/1/183
> ---
>  drivers/spi/spi-mem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 5217a56..56aa158 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -189,11 +189,14 @@ static bool spi_mem_internal_supports_op(struct spi_mem *mem,
>  					 const struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
> +	bool ret;
> +
> +	ret = spi_mem_default_supports_op(mem, op);
>  
>  	if (ctlr->mem_ops && ctlr->mem_ops->supports_op)
> -		return ctlr->mem_ops->supports_op(mem, op);
> +		ret =  ctlr->mem_ops->supports_op(mem, op);
>  
> -	return spi_mem_default_supports_op(mem, op);
> +	return ret;
>  }
>  
>  /**

