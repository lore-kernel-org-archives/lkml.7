Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3047FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F346F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ga/wijIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSKih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:38:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37165 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLSKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:38:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so5463659wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JeijUPwyZnPaABS3BiT1z67fxQFoLcFTSZ/sWrpPro4=;
        b=ga/wijIK+pQ5p3w6UUjhkJRP0CTcHQRRLFXEahtGSUU7K2iwnKTazGFNpstGbyhxvg
         1btzu5Jw1P8GeOMte19VJewN/agXQaInCg5HakoFnmzaEv+eWlqhYSWEGYU3yVEX+cRR
         hftMCleViJQzNo7y1GGRZqgj4yGe9FxVfiW2u7sMboB8B5Cj3s8Ao16kYGYFLLzfls6C
         XOcCUVwwzOROpmX0sCEX9vl0Oc6ELQ3q/ob84IpNLcMr1p0+p+uSWIZOV6g4s6xI+qMY
         4q5zemLbDPrIf4YfJ81pTHSHtnZgskxbiti3lawyXV6JMQT0ns0t2smv5xp4CPbIuSxf
         b96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JeijUPwyZnPaABS3BiT1z67fxQFoLcFTSZ/sWrpPro4=;
        b=DoO+8PMQaRiitvPhRwzdcdR8/0qE8yhtKYb5Foq0H3xVhWGwsVeB1on5XfqAovbeEh
         VvzK9Y/NQkr5chSridFoWVR+M5A/Yabx34nLJ0dZklpWSv9bG65uPn8x8Yu3zxHxnZxZ
         xDdGmrUUYnJzpPngprzarBcXcBsUAnx7DUIsAAzDYb2UrdYNTY6qjEdyA8lMGH+Fd9yo
         obKuHvZZM0f4v+0ikPyOSKU25Mrk0cwyyxJQwHV2+hMUliJppKJLXHFmnNDj7d6C5Pa+
         x8GtVKiCkaStwUjy3xr0bzwMmTEGPGJeYipDkCqPfr5DSinY5ERhmUABfQnk6cPgguzD
         xGLg==
X-Gm-Message-State: APjAAAULIztfpL72n+M1ZNmdjKpk2rLRH7nMqBfh1bvPPJWsq1fdpl9h
        AKuc8pFN5OpgUY1FJcHKxCf2Mw==
X-Google-Smtp-Source: APXvYqyGBm7TiWumGV5/TqYQf8p9++4EWsj/W3KOeOfBJoTpcYeMRGH3AeKfpQtVqRchwlxNG9TjTQ==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr8672952wrw.289.1576751914380;
        Thu, 19 Dec 2019 02:38:34 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k7sm5629197wmi.19.2019.12.19.02.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 02:38:33 -0800 (PST)
Subject: Re: [PATCH] nvmem: add QTI SDAM driver
To:     Shyam Kumar Thella <sthella@codeaurora.org>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1576574432-9649-1-git-send-email-sthella@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ec41d021-ddf3-b052-45ca-d2c1d149c26c@linaro.org>
Date:   Thu, 19 Dec 2019 10:38:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1576574432-9649-1-git-send-email-sthella@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2019 09:20, Shyam Kumar Thella wrote:
> QTI SDAM driver allows PMIC peripherals to access the shared memory
> that is available on QTI PMICs.
> 
> Change-Id: I40005646ab1fbba9e0e4aa68e0a61cfbc7b51ba6
> Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
> ---
>   drivers/nvmem/Kconfig          |   8 ++
>   drivers/nvmem/Makefile         |   1 +
>   drivers/nvmem/qcom-spmi-sdam.c | 197 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 206 insertions(+)
Not repeating comments from Bjorn,
Apart from that I have twos comment.

1>
Any reason why there is no Device tree bindings documented for this driver?

>   create mode 100644 drivers/nvmem/qcom-spmi-sdam.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 73567e9..35efab1 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -109,6 +109,14 @@ config QCOM_QFPROM
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem_qfprom.
>   
> +config NVMEM_SPMI_SDAM
> +	tristate "SPMI SDAM Support"
> +	depends on SPMI
> +	help
> +	  This driver supports the Shared Direct Access Memory Module on
> +	  Qualcomm Technologies, Inc. PMICs. It provides the clients
> +	  an interface to read/write to the SDAM module's shared memory.
> +
>   config ROCKCHIP_EFUSE
>   	tristate "Rockchip eFuse Support"
>   	depends on ARCH_ROCKCHIP || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 9e66782..877a0b0 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_MTK_EFUSE)		+= nvmem_mtk-efuse.o
>   nvmem_mtk-efuse-y		:= mtk-efuse.o
>   obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
>   nvmem_qfprom-y			:= qfprom.o
> +obj-$(CONFIG_NVMEM_SPMI_SDAM)	+= qcom-spmi-sdam.o
>   obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
>   nvmem_rockchip_efuse-y		:= rockchip-efuse.o
>   obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
> new file mode 100644
> index 0000000..e80a446
> --- /dev/null
> +++ b/drivers/nvmem/qcom-spmi-sdam.c
> @@ -0,0 +1,197 @@

...
> +
> +static int sdam_probe(struct platform_device *pdev)
> +{
> +	struct sdam_chip *sdam;
> +	struct nvmem_device *nvmem;
> +	struct nvmem_config *sdam_config;
> +	unsigned int val = 0;
> +	int rc;
> +
> +	sdam = devm_kzalloc(&pdev->dev, sizeof(*sdam), GFP_KERNEL);
> +	if (!sdam)
> +		return -ENOMEM;
> +
> +	sdam_config = devm_kzalloc(&pdev->dev, sizeof(*sdam_config),
> +							GFP_KERNEL);
> +	if (!sdam_config)
> +		return -ENOMEM;
> +
> +	sdam->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!sdam->regmap) {
> +		pr_err("Failed to get regmap handle\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = of_property_read_u32(pdev->dev.of_node, "reg", &sdam->base);
> +	if (rc < 0) {
> +		pr_err("Failed to get SDAM base, rc=%d\n", rc);
> +		return -EINVAL;
> +	}
> +
> +	rc = regmap_read(sdam->regmap, sdam->base + SDAM_SIZE, &val);
> +	if (rc < 0) {
> +		pr_err("Failed to read SDAM_SIZE rc=%d\n", rc);
> +		return -EINVAL;
> +	}
> +	sdam->size = val * 32;
> +
> +	sdam_config->dev = &pdev->dev;
> +	sdam_config->name = "spmi_sdam";
> +	sdam_config->id = pdev->id;
> +	sdam_config->owner = THIS_MODULE,
> +	sdam_config->stride = 1;
> +	sdam_config->word_size = 1;
> +	sdam_config->reg_read = sdam_read;
> +	sdam_config->reg_write = sdam_write;
> +	sdam_config->priv = sdam;
> +
> +	nvmem = nvmem_register(sdam_config);
2>
May be devm_nvmem_register() here would  be better.


--srini
