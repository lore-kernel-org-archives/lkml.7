Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE152082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C41Hjbj1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="omxBTwnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfC2NeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:34:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfC2NeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:34:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70A7B60F3E; Fri, 29 Mar 2019 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553866443;
        bh=Qn3GgO6xO2R18mYItmxSk4wjKildwxIYqd909cQkAok=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C41Hjbj1KH+ErAPThWoN8pLJA3IB1Qh7ClIUKBxQjZDq8YotL22XZzAxUa7l4EKYf
         w8O782if5KuyS5rc8LNep4lTYkcal5CVpwinFJ86hjLG9Oh7QY4uS9CY2XHqBKhkDo
         Cif4f2JPR8kNl81KnlnI1qhqp11qZ/v6tOZM21vo=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B7B660F3E;
        Fri, 29 Mar 2019 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553866441;
        bh=Qn3GgO6xO2R18mYItmxSk4wjKildwxIYqd909cQkAok=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=omxBTwndgwMAtKQN8+lL7NxnCDyGlYJl2R59m6o0APaUmOeyilbQ7HXLy4UNpjlGp
         YMNW/W+hom5F9ZKtjINT9ZrWl35/tzCy2vNm1q4DBppsfwGKK145W5OAA/HPaSikL8
         SFLSnOJzbtmsQAFn1EvjjpafxmOYnlToUDsybEkE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B7B660F3E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] i2c: imx: don't leak the i2c adapter on error
To:     laurentiu.tudor@nxp.com, linux-i2c@vger.kernel.org,
        wsa+renesas@sang-engineering.com
Cc:     linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2c5f68e0-5377-cfd3-f527-e235c0e19bef@codeaurora.org>
Date:   Fri, 29 Mar 2019 19:03:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 6:18 PM, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Make sure to free the i2c adapter on the error exit path.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/i2c/busses/i2c-imx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 42fed40198a0..2dfd33f48cd8 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1169,11 +1169,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
>   	/* Init DMA config if supported */
>   	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
>   	if (ret < 0)
> -		goto clk_notifier_unregister;
> +		goto del_adapter;
>   
>   	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>   	return 0;   /* Return OK */
>   
> +del_adapter:
> +	 i2c_del_adapter(&i2c_imx->adapter);
>   clk_notifier_unregister:
>   	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>   rpm_disable:
