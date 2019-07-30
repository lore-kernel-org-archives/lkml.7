Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC54C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F83E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rkz2n/Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfG3Q6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42954 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfG3Q6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so30140346pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kNH9892mMSdbgyYPq04/DOS1+jjJ5DNNUuFxNaUc4lA=;
        b=Rkz2n/Z4fx/N0ovqStcb1ANvDKtxcDrtxVH5xiavqxMZ1id3tmJKj9s3v/0i79OK1q
         oslYjKScx1QzaiiFKAhy912qj3Jku9gLgZoi51x/zngQxhCvSItaR+EwuJ1BxjG44yqC
         3r5vhAlvt9FrFziJLdNbUMqNe+fKrl8yEPIAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kNH9892mMSdbgyYPq04/DOS1+jjJ5DNNUuFxNaUc4lA=;
        b=lKOFM18dOweDly6K10bNJIUz6AkbQv8tUSP3N+QIHO8GGgd93d6QxBv7qiyn7D4ush
         NBXg1NpmZXujmLg/A5UH5gkjgNQSlptbDvfqxx+GdIzCM1cp1T+iXxMQ32TPyO9q8AOP
         IYwfo8kA1nSWRRhx0bAmbnSTo/PRhdNGAtVUphrjUhw+jtUnUeZ4mMyUbxiOhUzT+Rwh
         eW1tqJkZ9hCzNKSYHJknxGvX3p3465r/5R352KJUG1eyaqSG4UFQ4cqP+zwiTPZ7ikCJ
         C+dFmer6I7UosA7CQG0qkXynIi8eLun3bdpF4YPDSStZ4O3Trnr/LHJpRzwAz3xM0EaC
         Nr5g==
X-Gm-Message-State: APjAAAXebLkDf70QDiNIAdoulVn3VeS+9eVX/XQPRsplywbXaIPa4G80
        Xc6wqgHL4SKbi7zbs7HNFeArdg==
X-Google-Smtp-Source: APXvYqxlkNe5qlW5oU8NKyA6zXOWROGHVUAwS/f3z/hvi4mf0dRFgYBwSNr9otMt3pnou4o4biWeGQ==
X-Received: by 2002:a17:90a:33c4:: with SMTP id n62mr121088686pjb.28.1564505912808;
        Tue, 30 Jul 2019 09:58:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y22sm76514188pfo.39.2019.07.30.09.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 09:58:31 -0700 (PDT)
Date:   Tue, 30 Jul 2019 09:58:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-dma: Mark expected switch fall-through
Message-ID: <201907300958.5F8CC90AD1@keescook>
References: <20190729225221.GA24269@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729225221.GA24269@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:52:21PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: arm):
> 
> drivers/dma/imx-dma.c: In function ‘imxdma_xfer_desc’:
> drivers/dma/imx-dma.c:542:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (slot == IMX_DMA_2D_SLOT_A) {
>       ^
> drivers/dma/imx-dma.c:559:2: note: here
>   case IMXDMA_DESC_MEMCPY:
>   ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/dma/imx-dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index 00a089e24150..5c0fb3134825 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -556,6 +556,7 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
>  		 * We fall-through here intentionally, since a 2D transfer is
>  		 * similar to MEMCPY just adding the 2D slot configuration.
>  		 */
> +		/* Fall through */
>  	case IMXDMA_DESC_MEMCPY:
>  		imx_dmav1_writel(imxdma, d->src, DMA_SAR(imxdmac->channel));
>  		imx_dmav1_writel(imxdma, d->dest, DMA_DAR(imxdmac->channel));
> -- 
> 2.22.0
> 

-- 
Kees Cook
