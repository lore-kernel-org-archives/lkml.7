Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9032C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D53D206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrI8kgBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfLPP1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:27:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46081 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfLPP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:27:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so7721996wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q3MgqIM7Lebzkf8JO0ojhPzDqiRHLK5vJzUfeZMc1zU=;
        b=zrI8kgBBoboagFSLXfmTf0mbONsvoKKFbRJjR42YqaEaWnlMrQyzcWb1XMd3mJDIDA
         XEZRkQ8P8pAI2TuMYE0eBA7sLbLxsitGBmzo66TAenENXpkSFTIFTH0BiQJz45X9zJoE
         H4pmwfVFQeaforibR4y0VCfdsHWTqBW+kukg7d1cOXYSeCS7D/lHY2Uhncb2P8QqzA70
         QSUUf4iuWxxGW1iyZsIULB6RumULY/boFuV9T8RrnUAG3Ab1ce71ZAZH6Wte3H9d3TUM
         oKjbW/zgqasVXHvbr6TC5orVS8GePjn2BhNh9z4+f09Xp+aUnWtHm6yqFLV/d/iNoCV9
         h5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q3MgqIM7Lebzkf8JO0ojhPzDqiRHLK5vJzUfeZMc1zU=;
        b=ezT7wN2XBXjjsU0hrB0RjYGRnUCqk7uoPc2+FylT0AS5waqJDTslwsUOg8fNz55XNk
         ZM0blAfup5cGHSHplLn8uMu1cxijDXJtkTiPyO+CxCX4gi7X04nNtf+rJ7pQazbWTbm+
         8eZl1BG/S0HtGZvVQsCe2mKz3HtipAjf2TAcL84sUObiBpbwqjqxhxFemJa9un4Ltfxq
         eTKw4nuQvi6t9X7SRxFAyotxxc3x9RwTu624dghNIk7kL3aenJZb9xV6Gg+FaAFTdcao
         RKKFv2Yh92ok3soASk+NhQ5nBfZR2ng5oaLZvcgmRUO3ma6LcuiLxUZj5w+5BKGV2lYN
         et7Q==
X-Gm-Message-State: APjAAAW0ns4oAZdDDDfD2MT3xpuHR2QzePxsyKEFtebwvXV8rwLnmjrR
        BzSzBi7+WZHCdhr9DzymjjOfNw==
X-Google-Smtp-Source: APXvYqzUTemS2PAuC/RnjCOMgKkGPqFGklDx/Gs//sa0fLFQ2EuYXh0JOOt4jLFQ6QC7CwPooTMy4g==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr30708752wrx.153.1576510037406;
        Mon, 16 Dec 2019 07:27:17 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id o66sm17974890wmo.20.2019.12.16.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:27:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:27:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v4 2/5] mfd: rn5t618: add IRQ support
Message-ID: <20191216152715.GH2369@dell>
References: <20191211215409.32764-1-andreas@kemnade.info>
 <20191211215409.32764-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211215409.32764-3-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Andreas Kemnade wrote:

> This adds support for IRQ handling in the RC5T619 which is required
> for properly implementing subdevices like RTC.
> For now only definitions for the variant RC5T619 are included.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v4:
> merge rn5t618-irq.c into rn5t618.c
> use macros for IRQ table
> 
> Changes in v3:
> alignment cleanup
> 
> Changes in v2:
> - no dead code, did some more testing and thinking for that
> - remove extra empty lines
>  drivers/mfd/Kconfig         |  1 +
>  drivers/mfd/rn5t618.c       | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rn5t618.h | 15 ++++++++
>  3 files changed, 104 insertions(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ae24d3ea68ea..522e068d0082 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1057,6 +1057,7 @@ config MFD_RN5T618
>  	depends on OF
>  	select MFD_CORE
>  	select REGMAP_I2C
> +	select REGMAP_IRQ
>  	help
>  	  Say yes here to add support for the Ricoh RN5T567,
>  	  RN5T618, RC5T619 PMIC.
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index da5cd9c92a59..76d997c0cfe4 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -8,6 +8,8 @@
>  
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/rn5t618.h>
>  #include <linux/module.h>
> @@ -45,9 +47,63 @@ static const struct regmap_config rn5t618_regmap_config = {
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>  
> +static const struct regmap_irq rc5t619_irqs[] = {
> +	REGMAP_IRQ_REG(RN5T618_IRQ_SYS, 0, BIT(0)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_DCDC, 0, BIT(1)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_RTC, 0, BIT(2)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_ADC, 0, BIT(3)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_GPIO, 0, BIT(4)),
> +	REGMAP_IRQ_REG(RN5T618_IRQ_CHG, 0, BIT(6)),
> +};
> +
> +static const struct regmap_irq_chip rc5t619_irq_chip = {
> +	.name = "rc5t619",
> +	.irqs = rc5t619_irqs,
> +	.num_irqs = ARRAY_SIZE(rc5t619_irqs),
> +	.num_regs = 1,
> +	.status_base = RN5T618_INTMON,
> +	.mask_base = RN5T618_INTEN,
> +	.mask_invert = true,
> +};
> +
>  static struct rn5t618 *rn5t618_pm_power_off;
>  static struct notifier_block rn5t618_restart_handler;
>  
> +int rn5t618_irq_init(struct rn5t618 *rn5t618)

Static?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
