Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404B7218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Efw9KCke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfB1KHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:07:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50982 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731514AbfB1KHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:07:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190228100751euoutp0126a6987378ecba6988a65ee4364a102d~HfzcYYXDC2730027300euoutp01Q
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:07:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190228100751euoutp0126a6987378ecba6988a65ee4364a102d~HfzcYYXDC2730027300euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551348471;
        bh=g5mHOciPkWRskyRb13xzIT2/49q30wJtRcCyv9XcQ8o=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=Efw9KCke3XAvAGx/+NIE+1xcrM8lqAOXds4xNk9TDgtW3zHn1YcOdi1nHudgP/Xyk
         q4OCjj8YOjaIWeikMPMCLTtGlTV7/6cfOnRCg9lxXfS4uFpLfAmgotCmj27kX271Tk
         yNH/XJClxPJWt4+05P+R+6nqZdeKdf3pNvDcok4E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190228100750eucas1p1d696c971c2b0cf3ebe52a044b88be998~HfzcA1FCl2024320243eucas1p14;
        Thu, 28 Feb 2019 10:07:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.C2.04806.6F2B77C5; Thu, 28
        Feb 2019 10:07:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190228100749eucas1p2ab54edc15b352fb73b69dd7ec3bd55f2~Hfza8Fsa82278422784eucas1p2Q;
        Thu, 28 Feb 2019 10:07:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190228100749eusmtrp27c0b7252c7fdc0d98510d0f123ff9748~Hfzaqd0A40758707587eusmtrp2O;
        Thu, 28 Feb 2019 10:07:49 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-b5-5c77b2f674dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.44.04284.5F2B77C5; Thu, 28
        Feb 2019 10:07:49 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190228100748eusmtip17a3328bab6e9bc5de7be67e75bc3c6d0~HfzaM62y20724107241eusmtip1B;
        Thu, 28 Feb 2019 10:07:48 +0000 (GMT)
Subject: Re: [PATCH] tty: serial: samsung: Enable baud clock during
 initialisation
To:     Stuart Menefy <stuart.menefy@mathembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ed76663a-d50e-e8f1-df84-d44100af8ecd@samsung.com>
Date:   Thu, 28 Feb 2019 11:07:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190212214022.9446-1-stuart.menefy@mathembedded.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7rfNpXHGFydpGDRvHg9m8WUDR+Y
        LM6f38BucXnXHDaLGef3MVmcWdzLbnHlQx+bA7vHplWdbB77565h9zj08hCTx/otV1k8Pm+S
        C2CN4rJJSc3JLEst0rdL4Mq4t+oha8F9hYpft26zNzDOlOpi5OSQEDCRaD85k7WLkYtDSGAF
        o8TK3y9ZIJwvjBKbHv1ihnA+M0r0X/3EDtPSvG0DVMtyRom3P2awQzjvGSWWn//NDFIlLBAi
        0X/5EhNIQkSgl0li5enzTCAJNgFDia63XWwgNq+AncTxr9eAFnJwsAioSrR8EgIxRQViJA4t
        LoOoEJQ4OfMJC4jNKeAs8XjGVkYQm1lAXmL72znMELa4xK0n88FWSQisY5eYeOQxG8SlLhKb
        J7axQtjCEq+Ob4H6QEbi/06YhmZGifYZs9ghnB5Gia1zdkB1W0scPn6RFeQiZgFNifW79CHC
        jhJnlu9nBglLCPBJ3HgrCHEEn8SkbdOhwrwSHW1CENVqErOOr4Nbe/DCJWYI20Oi8UI/4wRG
        xVlI3pyF5LVZSF6bhXDDAkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIFJ6PS/4193
        MO77k3SIUYCDUYmHV6OnLEaINbGsuDL3EKMEB7OSCO/HteUxQrwpiZVVqUX58UWlOanFhxil
        OViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhg3Tsq776U8afKEjZ9cbn98nWHtOnMih+vS
        eKapagfE/gWoirq+nZa/ROdPVARX7E0T0ZbX/lv6zp3TO3U3xuphx9kpdzNWLIrdNFnlxRnd
        1He/gp+ct+jcNk2/ep/JfbvmiJvfP0YdcnavlPL7Pfl3n+2/6jesX4Ie2rssc1h4W30fz/6+
        N19WKLEUZyQaajEXFScCAEEfmFY+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7pfN5XHGKx8KW7RvHg9m8WUDR+Y
        LM6f38BucXnXHDaLGef3MVmcWdzLbnHlQx+bA7vHplWdbB77565h9zj08hCTx/otV1k8Pm+S
        C2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4
        t+oha8F9hYpft26zNzDOlOpi5OSQEDCRaN62gbWLkYtDSGApo8T6Qw3MEAkZiZPTGlghbGGJ
        P9e62EBsIYG3jBJLp7uB2MICIRL9ly8xgTSLCPQzSXRO2MYGMWkao8SSx4+YQKrYBAwlut5C
        dPMK2Ekc/3qNpYuRg4NFQFWi5ZMQSFhUIEbiw90bTBAlghInZz5hAbE5BZwlHs/YyghiMwuo
        S/yZd4kZwpaX2P52DpQtLnHryXymCYyCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn
        5haX5qXrJefnbmIERte2Yz8372C8tDH4EKMAB6MSD69GT1mMEGtiWXFl7iFGCQ5mJRHej2vL
        Y4R4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5Hxj5eSXxhqaG5haWhubG5sZmFkrivOcNKqOE
        BNITS1KzU1MLUotg+pg4OKUaGCsSX4WeVpnsed63fZeKE8tSjynpEx2aY2Lndm348vLtI3Xp
        4F+3ohd9DntV8vLJQ95s475pkV8zzi+4xhRZslhMq2Fa8PEPlXzqWx8yJk126by180DqsZrN
        M61WqsjPn60bl+Fy5r6eRcmvjL7FRjHCx102v9q+utqm66bQpYPxG/xDZ3RIuCmxFGckGmox
        FxUnAgD3Y/atxAIAAA==
X-CMS-MailID: 20190228100749eucas1p2ab54edc15b352fb73b69dd7ec3bd55f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212214034epcas5p41ddd5b935a64ee0999fe7186e0d5c608
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212214034epcas5p41ddd5b935a64ee0999fe7186e0d5c608
References: <CGME20190212214034epcas5p41ddd5b935a64ee0999fe7186e0d5c608@epcas5p4.samsung.com>
        <20190212214022.9446-1-stuart.menefy@mathembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stuart,

On 2019-02-12 22:40, Stuart Menefy wrote:
> The Exynos 5260, like the 5433, appears to require baud clock as
> well as pclk to be running before accessing any of the registers,
> otherwise an external abort is raised.
>
> The serial driver already enables baud clock when required, but only
> if it knows which clock is baud clock. On older SoCs baud clock may be
> selected from a number of possible clocks so to support this the driver
> only selects which clock to use for baud clock when a port is opened,
> at which point the desired baud rate is known and the best clock can be
> selected.
>
> The result is that there are a number of circumstances in which
> registers are accessed without first explicitly enabling baud clock:
>  - while the driver is being initialised
>  - the initial parts of opening a port for the first time
>  - when resuming if the port hasn't been already opened
>
> The 5433 overcomes this currently by marking the baud clock as
> CLK_IGNORE_UNUSED, so the clock is always enabled, however
> for the 5260 I've been trying to avoid this.
>
> This change adds code to pick the first available clock to use
> as baud clock and enables it while initialising the driver.
>
> This code wouldn't be sufficient on a SoC which supports
> multiple possible baud clock sources _and_ requires the
> correct baud clock to be enabled before accessing any of the
> serial port registers (in particular the register which selects
> which clock to use as the baud clock).  As far as I know
> such hardware doesn't exist.

I think that we can use a simpler approach. The driver can simply keep
baud clock enabled together with pclk always when there is only one baud
clock source (s3c24xx_serial_drv_data.num_clks == 1). This will work
both on Exynos 5260 and 5433.

> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/tty/serial/samsung.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 9fc3559f80d9..83fd51607741 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1694,6 +1694,42 @@ s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
>  }
>  #endif
>  
> +static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
> +{
> +	struct device *dev = ourport->port.dev;
> +	struct s3c24xx_uart_info *info = ourport->info;
> +	char clk_name[MAX_CLK_NAME_LENGTH];
> +	unsigned int clk_sel;
> +	struct clk *clk;
> +	int clk_num;
> +	int ret;
> +
> +	clk_sel = ourport->cfg->clk_sel ? : info->def_clk_sel;
> +	for (clk_num = 0; clk_num < info->num_clks; clk_num++) {
> +		if (!(clk_sel & (1 << clk_num)))
> +			continue;
> +
> +		sprintf(clk_name, "clk_uart_baud%d", clk_num);
> +		clk = clk_get(dev, clk_name);
> +		if (IS_ERR(clk))
> +			continue;
> +
> +		ret = clk_prepare_enable(clk);
> +		if (ret) {
> +			clk_put(clk);
> +			continue;
> +		}
> +
> +		ourport->baudclk = clk;
> +		ourport->baudclk_rate = clk_get_rate(clk);
> +		s3c24xx_serial_setsource(&ourport->port, clk_num);
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /* s3c24xx_serial_init_port
>   *
>   * initialise a single serial port from the platform device given
> @@ -1788,6 +1824,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  		goto err;
>  	}
>  
> +	ret = s3c24xx_serial_enable_baudclk(ourport);
> +	if (ret)
> +		pr_warn("uart: failed to enable baudclk\n");
> +
>  	/* Keep all interrupts masked and cleared */
>  	if (s3c24xx_serial_has_interrupt_mask(port)) {
>  		wr_regl(port, S3C64XX_UINTM, 0xf);
> @@ -1901,6 +1941,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	 * and keeps the clock enabled in this case.
>  	 */
>  	clk_disable_unprepare(ourport->clk);
> +	if (!IS_ERR(ourport->baudclk))
> +		clk_disable_unprepare(ourport->baudclk);
>  
>  	ret = s3c24xx_serial_cpufreq_register(ourport);
>  	if (ret < 0)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

