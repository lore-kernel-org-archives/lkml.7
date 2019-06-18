Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB9C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9584B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560841468;
	bh=bm2DKq2EIZtKPTiAVRzsCQniXdUMQeaYWYo40ocVKd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e0h7tqkLPrB1zikGMyw8ggIxxTd1IMK/t8MxC3ujQxGnzxGEdkHcv/JZ4gKEASz8j
	 B2QDSHwmodmvPPHCo+2sQPN+H/NM45c+jZ7xHn1o+OxjMlvNaOtB1tYvLIMXxTHBd3
	 PC0Gxx26fa1QEfhT91aVBk1ulrceZnKwWDwlsD/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfFRHE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfFRHE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:26 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8711B20665;
        Tue, 18 Jun 2019 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560841465;
        bh=bm2DKq2EIZtKPTiAVRzsCQniXdUMQeaYWYo40ocVKd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5Cp/sFZYyd4zhxGNyiMT4RVBJ5dQioW+ujYpGLtOqgTXmP3MlE8ATBKOkjUQH+V0
         AuhyNNvZtXrsMJYnjJ8dT1b6ddzRNmKMq6YzBez9UJhI50EBiUIKZ+FFBWyjHXNHan
         8FTc4VYvIv/V38X1206XO6H3Sl+vS3TL7Sw2jO7o=
Date:   Tue, 18 Jun 2019 15:03:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org,
        abel.vesa@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx: Add i.MX8MN SoC driver support
Message-ID: <20190618070334.GD29881@dragon>
References: <20190611013125.3434-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611013125.3434-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:31:25AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> This patch adds i.MX8MN SoC driver support:
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/family
> Freescale i.MX
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/machine
> NXP i.MX8MNano DDR4 EVK board
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/soc_id
> i.MX8MN
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/revision
> 1.0
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
> index 3842d09..02309a2 100644
> --- a/drivers/soc/imx/soc-imx8.c
> +++ b/drivers/soc/imx/soc-imx8.c
> @@ -55,7 +55,12 @@ static u32 __init imx8mm_soc_revision(void)
>  	void __iomem *anatop_base;
>  	u32 rev;
>  
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
> +	if (of_machine_is_compatible("fsl,imx8mm"))
> +		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
> +	else if (of_machine_is_compatible("fsl,imx8mn"))
> +		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");

Can we have this anatop compatible in imx8_soc_data, so that we may save
the call to of_machine_is_compatible()?

Shawn

> +	else
> +		np = NULL;
>  	if (!np)
>  		return 0;
>  
> @@ -79,9 +84,15 @@ static const struct imx8_soc_data imx8mm_soc_data = {
>  	.soc_revision = imx8mm_soc_revision,
>  };
>  
> +static const struct imx8_soc_data imx8mn_soc_data = {
> +	.name = "i.MX8MN",
> +	.soc_revision = imx8mm_soc_revision,
> +};
> +
>  static const struct of_device_id imx8_soc_match[] = {
>  	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
>  	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
> +	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
>  	{ }
>  };
>  
> -- 
> 2.7.4
> 
