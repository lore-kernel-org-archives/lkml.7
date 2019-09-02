Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D4C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A378E21874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfIBJLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:11:04 -0400
Received: from shell.v3.sk ([90.176.6.54]:41884 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbfIBJLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:11:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EDC08CE718;
        Mon,  2 Sep 2019 11:11:00 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OkqU5dSpAxIO; Mon,  2 Sep 2019 11:10:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B94ADD8CED;
        Mon,  2 Sep 2019 11:10:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FVUC0wSz7RId; Mon,  2 Sep 2019 11:10:53 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 91A20CE718;
        Mon,  2 Sep 2019 11:10:52 +0200 (CEST)
Message-ID: <ca0213fd439a2b569e0d3bdb000712ee62ff4836.camel@v3.sk>
Subject: Re: [PATCH] pxa168fb: Fix the function used to release some memory
 in an error handling path
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        b.zolnierkie@samsung.com, yuehaibing@huawei.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Mon, 02 Sep 2019 11:10:46 +0200
In-Reply-To: <20190831100024.3248-1-christophe.jaillet@wanadoo.fr>
References: <20190831100024.3248-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-31 at 12:00 +0200, Christophe JAILLET wrote:
> In the probe function, some resources are allocated using 'dma_alloc_wc()',
> they should be released with 'dma_free_wc()', not 'dma_free_coherent()'.
> 
> We already use 'dma_free_wc()' in the remove function, but not in the
> error handling path of the probe function.
> 
> Also, remove a useless 'PAGE_ALIGN()'. 'info->fix.smem_len' is already
> PAGE_ALIGNed.
> 
> Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks,
Lubo

> ---
> The change about PAGE_ALIGN should probably be part of a separate commit.
> However, git history for this driver is really quiet. If you think it
> REALLY deserves a separate patch, either split it by yourself or axe this
> part of the patch. I won't bother resubmitting for this lonely cleanup.
> Hoping for your understanding.
> ---
>  drivers/video/fbdev/pxa168fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index 1410f476e135..1fc50fc0694b 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -766,8 +766,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  failed_free_clk:
>  	clk_disable_unprepare(fbi->clk);
>  failed_free_fbmem:
> -	dma_free_coherent(fbi->dev, info->fix.smem_len,
> -			info->screen_base, fbi->fb_start_dma);
> +	dma_free_wc(fbi->dev, info->fix.smem_len,
> +		    info->screen_base, fbi->fb_start_dma);
>  failed_free_info:
>  	kfree(info);
>  
> @@ -801,7 +801,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  
> -	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
> +	dma_free_wc(fbi->dev, info->fix.smem_len,
>  		    info->screen_base, info->fix.smem_start);
>  
>  	clk_disable_unprepare(fbi->clk);

