Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1946AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BE220840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565671481;
	bh=SpfUN57SJ7lgvjo3JXsVpHsmNRBqwd9iNm1bTWA2dBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vNkuV0es7BNnDuxvcNHlOSzLQz/x0IMKXK8kibkflTwKa9hHbr1BdCK+psYwcehhl
	 E2XD6vVnOsnkbbsn1zVMRrBP5J0DyAjia42BN9YvBpbpU3JQwHAXZEVFYNyDUkA2EB
	 Yw4OZNnBhhP8HTOV+9PZDrix8P7LcG+87RHLgTuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfHMEok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfHMEok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:44:40 -0400
Received: from localhost (unknown [106.201.103.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4412063F;
        Tue, 13 Aug 2019 04:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565671479;
        bh=SpfUN57SJ7lgvjo3JXsVpHsmNRBqwd9iNm1bTWA2dBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz0bbGaBsgvLWWy35YepM+f5dhcj7me+fQd4N51wJm9lz5d+um7ezxDjsDe5361j2
         /Kg05/kvodmBq5uKqLp3U/6IR69z31Ky5oa4l+utMIK5KpAO5+qyiCncEInOggXQVz
         SRfO35xvOYBl8lBsY/OSlS38SbPABv7euo+HBwAU=
Date:   Tue, 13 Aug 2019 10:13:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH linux-next] drivers: dma: Fix sparse warning for
 mux_configure32
Message-ID: <20190813044327.GR12733@vkoul-mobl.Dlink>
References: <20190812074205.96759-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812074205.96759-1-maowenan@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-08-19, 15:42, Mao Wenan wrote:

Patch title is incorrect, it should mention the changes in patch, for
example make mux_configure32 static

Do read up on Documentation/process/submitting-patches.rst again!

> There is one sparse warning in drivers/dma/fsl-edma-common.c,

It will help to explain the warning before the fix

> fix it by setting mux_configure32() as static.
> 
> make allmodconfig ARCH=mips CROSS_COMPILE=mips-linux-gnu-
> make C=2 drivers/dma/fsl-edma-common.o ARCH=mips CROSS_COMPILE=mips-linux-gnu-

Make cmds are not relevant for the log

> drivers/dma/fsl-edma-common.c:93:6: warning: symbol 'mux_configure32' was not declared. Should it be static?

This one is and should be retained

> 
> Fixes: 232a7f18cf8ec ("dmaengine: fsl-edma: add i.mx7ulp edma2 version support")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/dma/fsl-edma-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 6d6d8a4..7dbf7df 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -90,8 +90,8 @@ static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
>  	iowrite8(val8, addr + off);
>  }
>  
> -void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
> -		     u32 off, u32 slot, bool enable)
> +static void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,

just change this to static

> +			    u32 off, u32 slot, bool enable)

and dont change anything else.

If you feel to change this, propose a new patch for this line explaining
why this should be changed

>  {
>  	u32 val;
>  
> -- 
> 2.7.4

-- 
~Vinod
