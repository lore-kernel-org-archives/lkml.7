Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AABC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5611D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfLJRcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:32:05 -0500
Received: from ale.deltatee.com ([207.54.116.67]:37748 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfLJRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:32:05 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iejMh-0006P3-6P; Tue, 10 Dec 2019 10:32:04 -0700
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>, Shyam-sundar.S-k@amd.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us
Cc:     dave.jiang@intel.com, allenbh@gmail.com, will@kernel.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fd958d1b-5abc-b936-2f21-429326a6e5de@deltatee.com>
Date:   Tue, 10 Dec 2019 10:31:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, will@kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, Sanju.Mehta@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] ntb_perf: pass correct struct device to
 dma_alloc_coherent
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-12-10 6:07 a.m., Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Currently, ntb->dev is passed to dma_alloc_coherent
> and dma_free_coherent calls. The returned dma_addr_t
> is the CPU physical address. This works fine as long
> as IOMMU is disabled. But when IOMMU is enabled, we
> need to make sure that IOVA is returned for dma_addr_t.
> So the correct way to achieve this is by changing the
> first parameter of dma_alloc_coherent() as ntb->pdev->dev
> instead.
> 
> Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>

Yes, I did the same thing as one of the patches in my fix-up series that
never got merged. See [1].

Hopefully you can make better progress than I did.

While you're at it I think it's worth doing the same thing in ntb_tool
as well as removing the dma_coerce_mask_and_coherent() calls that are in
the NTB drivers which are meaningless once we get back to using the
correct DMA device.

Thanks,

Logan

[1] https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/

> ---
>  drivers/ntb/test/ntb_perf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index f5df33a..8729838 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -559,7 +559,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
>  		return;
>  
>  	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
> -	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
> +	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
>  			  peer->inbuf, peer->inbuf_xlat);
>  	peer->inbuf = NULL;
>  }
> @@ -588,8 +588,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
>  
>  	perf_free_inbuf(peer);
>  
> -	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
> -					 &peer->inbuf_xlat, GFP_KERNEL);
> +	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
> +					 peer->inbuf_size, &peer->inbuf_xlat,
> +					 GFP_KERNEL);
>  	if (!peer->inbuf) {
>  		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
>  			&peer->inbuf_size);
> 
