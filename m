Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A024C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B6E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfCYRMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:12:37 -0400
Received: from foss.arm.com ([217.140.101.70]:52230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfCYRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:12:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFB1280D;
        Mon, 25 Mar 2019 10:12:36 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 021FF3F575;
        Mon, 25 Mar 2019 10:12:34 -0700 (PDT)
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
To:     laurentiu.tudor@nxp.com, linux-i2c@vger.kernel.org,
        ying.zhang22455@nxp.com
Cc:     upstream-release@linux.nxdi.nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Date:   Mon, 25 Mar 2019 17:12:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 15:30, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> If the dma controller is not yet probed, defer i2c probe.
> The error path in probe was slightly modified (no functional change)

There is a functional change for cases like:

> 	ret = pm_runtime_get_sync(&pdev->dev);
> 	if (ret < 0)
> 		goto rpm_disable;

...as rpm_disable will no longer fall through to the call of
clk_disable_unprepare().

> to avoid triggering this WARN_ON():
> "cg-pll0-div1 already disabled
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"

I'm also not sure how this WARN_ON was hit. i2c_imx_probe() calls
clk_prepare_enable() which should increment the reference count. So it
should always be possible to decrememt the enable_count. What am I missing?

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 42fed40198a0..4e34b1572756 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  				pdev->name, i2c_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> -		goto clk_disable;
> +		clk_disable_unprepare(i2c_imx->clk);
> +		return ret;
>  	}
>  
>  	/* Init queue */
> @@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
> +	/* Init DMA config if supported */
> +	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
> +		else
> +			goto del_adapter;
> +	}
> +

This can be simplified by reversing the condition:

	if (ret) {
		if (ret == -EPROBE_DEFER)
			goto del_adapter;
		dev_info();
	}

or even:

	if (ret == -EPROBE_DEFER)
		goto del_adapter;
	else if (ret)
		dev_info();

>  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
>  	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>  		i2c_imx->adapter.name);
>  
> -	/* Init DMA config if supported */
> -	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> -	if (ret < 0)
> -		goto clk_notifier_unregister;
> -
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  	return 0;   /* Return OK */
>  
> +del_adapter:
> +	i2c_del_adapter(&i2c_imx->adapter);

This looks like a separate fix (previously the call to
i2c_add_numbered_adapter() was not undone in case of later errors). It
worth spelling this out in the commit message.

Thanks,

Steve

>  clk_notifier_unregister:
>  	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>  rpm_disable:
> @@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  
> -clk_disable:
> -	clk_disable_unprepare(i2c_imx->clk);
>  	return ret;
>  }
>  
> 

