Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2826320896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553527561;
	bh=exN7xmui7kI37OvWlbdnOW3Atokiit5D+Hid93/mJfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=haAfPJAw/Z1Ic+6p2pos2kS9T1MqMx6hPmJsKB7RRRmgUax5vS1O5HL5iG0GnJKP1
	 gdPHWM0Bej0jK6DtcaQtaIMfOcdltrYEfwCSXW5S3M9DH2kN5kNVqm5m/6sDCQpvut
	 9e5R4XQugOLocG+TMb6t+3nKpUAhwxd3car1yS5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfCYP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfCYPZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:25:59 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E8F2087E;
        Mon, 25 Mar 2019 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553527558;
        bh=exN7xmui7kI37OvWlbdnOW3Atokiit5D+Hid93/mJfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RA/zEFdSw6OPeRF+lxQXPKvk7zYiQfBldpFke/OJWd71dqxYiRSVQp0BtuZ/nTZE3
         YN5gETOkr5TPP7iwHEX0/C9a25tNfHfTIzOy4yPnVBeHjhlw5hQSG3CqNTTpl7ezcU
         nwGfJkZDiVUIVG0V0rfUBbILzbFV4Q8cyNebDsgs=
Date:   Mon, 25 Mar 2019 20:55:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Revert "dmaengine: stm32-mdma: Add a check on
 read_u32_array"
Message-ID: <20190325152552.GQ5348@vkoul-mobl>
References: <1553525187-13533-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553525187-13533-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-19, 15:46, Pierre-Yves MORDRET wrote:

Please use the right subsystem name dmaengine, revert is not a subsystem
name!

> This reverts commit 906b40b246b0acb54c4dc97e815cf734761c9820.

This should use the cannonical form for commits commit-sha1: ("title....") 
> 
> As stated by bindings "st,ahb-addr-masks" is optional.
> The statement inserted by this commit makes this property
> mandatory and prevents MDMA to be probed in case property not present.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
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

so if st,ahb-addr-masks is not present what value does count contain?

>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 2.7.4

-- 
~Vinod
