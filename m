Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B119C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EFE21900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552751286;
	bh=yxJHAekYatzlkBF2IMFg9oMXkspoY+eJ0UJCMGESBNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ahvUdWWGSqODumNOpcKr8+iPT+iAjhtUOi8zc0u2X1A6a2IDmnRqNgvttpR4bNx40
	 Cvzf5q0OIZugggrntpuxpO/h230PF7eCTqnv3FTVjxY/xljO9aRezTlzHfcaTuT7X2
	 VY0ZyphX3ryiTWthM6OchtE+IiyCP1PfNUEWaRsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCPPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbfCPPsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:48:04 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6724218E0;
        Sat, 16 Mar 2019 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552751283;
        bh=yxJHAekYatzlkBF2IMFg9oMXkspoY+eJ0UJCMGESBNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bT59y0HfLbKnObd45mvVjlPxm6oC1Kg5iIbBSXS/YTxmB2e22Uznzx7b7yEPEJQAR
         jG+68CnNWA1anf+Gg73e39ThRMBkphJ40oiA4U7taQGp2Tmx60yZE/w46DuaFt6MPL
         8Thkj73ptYX5y2WHOUKwQgfsZnGB9C1eutFwJWek=
Date:   Sat, 16 Mar 2019 15:47:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: xilinx: fix potential use-after-free on
 remove
Message-ID: <20190316154758.27c59b82@archlinux>
In-Reply-To: <20190310185826.25916-1-TheSven73@gmail.com>
References: <20190310185826.25916-1-TheSven73@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2019 14:58:24 -0400
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> When cancel_delayed_work() returns, the delayed work may still
> be running. This means that the core could potentially free
> the private structure (struct xadc) while the delayed work
> is still using it. This is a potential use-after-free.
> 
> Fix by calling cancel_delayed_work_sync(), which waits for
> any residual work to finish before returning.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
This appears 'obviously correct' to me so I'll apply it to the fixes
togreg branch of iio.git and mark it for stable.

However I won't be sending a pull request for that branch until at
least next weekend, so if anyone more familiar with the hardware
has a chance to take a look that would be great.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 3f6be5ac049a..1960694e8007 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1320,7 +1320,7 @@ static int xadc_remove(struct platform_device *pdev)
>  	}
>  	free_irq(xadc->irq, indio_dev);
>  	clk_disable_unprepare(xadc->clk);
> -	cancel_delayed_work(&xadc->zynq_unmask_work);
> +	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
>  	kfree(xadc->data);
>  	kfree(indio_dev->channels);
>  

