Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992AAC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697CC208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7n9thBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfFHDcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 23:32:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39453 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbfFHDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 23:32:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so2124366pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8yMs0A1kswOPadFYz1C2fi/C0+bcAjRjGc687sOHgM=;
        b=c7n9thBGRp2TEdtjghoVzImcNhyBb/VGwjyjCm3JbuSUilHIelfibtChp8GIaE13ag
         JNOGB+hr6YlznweL7qHBqLNQTVTGDtYKkRf2j18Y9qAdXrCG+GWCHjakZ6eG8owGdoxP
         Nn0DnoxyIjpF/fzEmh2Sq+lKuLx2brgS3c4ic3En3Eok0EDpahGBcI8woeuCmztpX+hT
         1ynX7bvjVqIZXzxE5zt7kbq8TDS/HkU1IthcxKu99GeKRkqM7xbhzN3ypBD4GyqgshNP
         hJR/Nc4drgs04AE64vN1B+FBz35vmQErDRSlXL+J5SMxFXd2xo/i0qA+X2/h6PjhUuOh
         /tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8yMs0A1kswOPadFYz1C2fi/C0+bcAjRjGc687sOHgM=;
        b=q5b7DZXfPGXtdJXQ+eJ771hghkh9hy1Q02HYvNcDBYkY0DzOtXFi7/33Pyntz4bX5n
         WR9Nc2MFipXGQFtL3OU7518DdQliSB9+AYbIfX9CgLnHooCyGPbJ1uaJ8XwASLzpTKZc
         Mg57V68oTcch7+dorp3sVLmNbXkTIxpSJiGm9xN6RpvzNJBaBa8dVYZ1OA6S/0ELUNqm
         geRu4FWzO2hfyd4a1BEFFrE1u5wCEt3AKn/ZOu27bQUNPqycnSSLUgUMo0toTrBiFi1c
         /bUfIGMp9c3OeSZCBZ0AaWrw3O7tv9Ai6xhG09TlIr/OiG0CUHmcTJA+pBIpv15SdKRi
         G2bw==
X-Gm-Message-State: APjAAAVXycbSibUdjokwWl5tkuAab7D715s5PJYyfijFUCW6St0+0O5w
        QAdoa2icKfxKXMOiH+zTunGC3o3rvz4=
X-Google-Smtp-Source: APXvYqzrB7QuXo0561fGi5AbE7OYmt8MLxD5Fo8pdCLTO0o6oJi2WGdEIJ2vz0ye4zuI2JWRQJG4IA==
X-Received: by 2002:a65:5003:: with SMTP id f3mr5749817pgo.336.1559964752104;
        Fri, 07 Jun 2019 20:32:32 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p65sm7027057pfb.146.2019.06.07.20.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:32:31 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:32:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     robh+dt@kernel.org, sboyd@codeaurora.org, linus.walleij@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] clk: qcom: Add ipq6018 Global Clock Controller
 support
Message-ID: <20190608033229.GE24059@builder>
References: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
 <1559754961-26783-5-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559754961-26783-5-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jun 10:15 PDT 2019, Sricharan R wrote:

> This patch adds support for the global clock controller found on
> the ipq6018 based devices.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: anusha <anusharao@codeaurora.org>
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Please fix your s-o-b chain, as described in my reply to 1/8..

> ---
>  drivers/clk/qcom/Kconfig       |    9 +
>  drivers/clk/qcom/Makefile      |    1 +
>  drivers/clk/qcom/gcc-ipq6018.c | 5267 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 5277 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-ipq6018.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index e1ff83c..e5fb091 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -120,6 +120,15 @@ config IPQ_GCC_8074
>  	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>  	  of ipq8074.
>  
> +config IPQ_GCC_6018

Please maintain sort order.

> +	tristate "IPQ6018 Global Clock Controller"
> +	depends on COMMON_CLK_QCOM
> +	help
> +	  Support for global clock controller on ipq6018 devices.
> +	  Say Y if you want to use peripheral devices such as UART, SPI,
> +	  i2c, USB, SD/eMMC, etc. Select this for the root clock
> +	  of ipq6018.
> +
>  config MSM_GCC_8660
>  	tristate "MSM8660 Global Clock Controller"
>  	help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index f0768fb..025137d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
>  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>  obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
> +obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o

Ditto.

>  obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>  obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
>  obj-$(CONFIG_MDM_LCC_9615) += lcc-mdm9615.o
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
[..]
> +static int gcc_ipq6018_probe(struct platform_device *pdev)
> +{
> +	return qcom_cc_probe(pdev, &gcc_ipq6018_desc);
> +}
> +
> +static int gcc_ipq6018_remove(struct platform_device *pdev)
> +{
> +	return 0;

Just omit .remove from the gcc_ipq6018_driver instead of providing a
dummy function.

> +}
> +
> +static struct platform_driver gcc_ipq6018_driver = {
> +	.probe = gcc_ipq6018_probe,
> +	.remove = gcc_ipq6018_remove,
> +	.driver = {
> +		.name   = "qcom,gcc-ipq6018",
> +		.owner  = THIS_MODULE,

Don't specify .owner in platform drivers.

[..]
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. GCC IPQ6018 Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:gcc-ipq6018");

This modalias won't be used.

Regards,
Bjorn
