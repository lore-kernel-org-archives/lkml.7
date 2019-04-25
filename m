Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661DAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF7C20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556212436;
	bh=8R3D7I9mS1uYDHUzbKNuvFwzHBe1Yd1gkshcJwCaWYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2kGqQ56AG653ld4CzGnKFv4wTn8zl301fv7gjFWFSGkk/zn1dQ39/bzCiVsiUHHYd
	 3LpeEGZXDAlQa6VLMKZ75d4yijFGCemDvux1+T+3tsN5LAfSiW4pulxsE3B+rdE3pU
	 E0ejvNUuvZgjdXOT3hoxjqfue2/zXwtpg93aq5rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfDYRNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfDYRNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:13:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C20320717;
        Thu, 25 Apr 2019 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556212434;
        bh=8R3D7I9mS1uYDHUzbKNuvFwzHBe1Yd1gkshcJwCaWYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA5gBe335jk/bmdniropErZmjCpoJz2PG/zDLQOdTVFNzst5PAcRcvucqiJDd+erv
         IUPeNUyLDFz4/8iVD+fWhdZFutcfmTSiG92BHhzRK/7GdlcXsre7iW0dDrapdTc4VD
         UOs0Gsvvqkca2I0y7fYpiy0kMfjaS6DIAmEtBNNo=
Date:   Thu, 25 Apr 2019 19:13:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: comedi_isadma: Use a non-NULL device
 for DMA API
Message-ID: <20190425171351.GB11105@kroah.com>
References: <20190425162644.21947-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425162644.21947-1-abbotti@mev.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 05:26:44PM +0100, Ian Abbott wrote:
> The "comedi_isadma" module calls `dma_alloc_coherent()` and
> `dma_free_coherent()` with a NULL device pointer which is no longer
> allowed.  If the `hw_dev` member of the `struct comedi_device` has been
> set to a valid device, that can be used instead.  Unfortunately, all the
> current users of the "comedi_isadma" module leave the `hw_dev` member
> set to NULL.  In that case, use a static dummy fallback device structure
> with the coherent DMA mask set to the ISA bus limit of 16MB.
> 
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>  drivers/staging/comedi/drivers/comedi_isadma.c | 15 +++++++++++++--
>  drivers/staging/comedi/drivers/comedi_isadma.h |  3 +++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/comedi_isadma.c b/drivers/staging/comedi/drivers/comedi_isadma.c
> index b77dc8d5d3ff..8929952516a1 100644
> --- a/drivers/staging/comedi/drivers/comedi_isadma.c
> +++ b/drivers/staging/comedi/drivers/comedi_isadma.c
> @@ -14,6 +14,16 @@
>  
>  #include "comedi_isadma.h"
>  
> +/*
> + * Fallback device used when hardware device is NULL.
> + * This can be removed after drivers have been converted to use isa_driver.
> + */
> +static struct device fallback_dev = {
> +	.init_name = "comedi_isadma fallback device",
> +	.coherent_dma_mask = DMA_BIT_MASK(24),
> +	.dma_mask = &fallback_dev.coherent_dma_mask,
> +};

Ick, no, static struct device are a very bad idea as this is a reference
counted structure and making it static can cause odd problems.

Why not just create a "real" one?  Or better yet, use the real device
for the comedi device as all of these drivers should have one now.

thanks,

greg k-h
