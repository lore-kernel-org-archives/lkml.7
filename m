Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8934EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497422087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553531337;
	bh=JE7jb7ygX6NdHQ+II/nw7qf4Ulhfht9v/6x6xYzUq8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nhpr64aaP2PXLxqexqw/FFgveG1wzZ839I/cshyCB6UkVpdz1gnLIWD0rz52CfMgp
	 BrnUaclbbOkGeGjUMupji5OTKavr8wDLj2A5trVoaxrukYRxR7eNShoo6fumjliLX1
	 oD62Y8gapc4cASLhPdu8IY9WXJHygVkFRBQ12yLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfCYQ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:28:55 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7256D20828;
        Mon, 25 Mar 2019 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553531335;
        bh=JE7jb7ygX6NdHQ+II/nw7qf4Ulhfht9v/6x6xYzUq8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0nikvzujm1pUHwDQUWpTW6doZox5Cs480QZ5C1xj6sqO557U7w5h0wImf15JnEVgX
         JH2D48wmjo54nH0s5vwx7Go6tei0dqvOqq860OnXJt1Kk+4UY3wV9r1FsJnLlmAmaw
         ruxPWO86vVqz5skMDGpEAjZWPR5A3eiy29Dk81TI=
Date:   Mon, 25 Mar 2019 21:58:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: stm32-mdma: Revert "Add a check on
 read_u32_array"
Message-ID: <20190325162849.GS5348@vkoul-mobl>
References: <1553530915-1961-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553530915-1961-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-19, 17:21, Pierre-Yves MORDRET wrote:
> This reverts commit 906b40b246b0 ("Add a check on read_u32_array")

This and patch title should contain:
906b40b246b0 ("dmaengine: stm32-mdma: Add a check on read_u32_array")

I have fixed it up and applied.

Thanks

> As stated by bindings "st,ahb-addr-masks" is optional.
> The statement inserted by this commit makes this property
> mandatory and prevents MDMA to be probed in case property not present.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v2:
>        * review commit message
>     v1:
>        * Initial
> ---
> ---
>  drivers/dma/stm32-mdma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 4e0eede..ac0301b 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1578,11 +1578,9 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>  
>  	dmadev->nr_channels = nr_channels;
>  	dmadev->nr_requests = nr_requests;
> -	ret = device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
> +	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
>  				       dmadev->ahb_addr_masks,
>  				       count);
> -	if (ret)
> -		return ret;
>  	dmadev->nr_ahb_addr_masks = count;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 2.7.4

-- 
~Vinod
