Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087422084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="D38VNIIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCZKku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:40:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38810 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfCZKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:40:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so9658040ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2I5YsJACu9UfaNajNSsnu4SMBqpXNXMYkE2FLhEbmaM=;
        b=D38VNIIZKSqHTwYQUV29eGcZ8NlGzdsaUnYdDSoZDtO31XwJsUWJyWymp8fTPPG/fD
         rwsEzsp9AkLah4WMsvFs2MISy+ICJq/+JosWd4CVd/Hj2r2z1mAQ2uOcOP21LqVI4KLY
         S37K2mWVqHZVkmAPMbMbvHnlyqiPdCx7XX6Fh82useYa1LC8awRUV5whcKrbANFRmfJo
         9lta8QAcnxOYRpHzDKWK+2lL3IcBc2DvymTvm0fKfNJfMdlm43G+/hAJzCZGrNscz1rE
         Tq7Ap2hFRyHXhoG0owTmAebzv+GM+IB/MJ85MS5AUOzxuYoonmB3K7NnX0W5RNl5qn1F
         6Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2I5YsJACu9UfaNajNSsnu4SMBqpXNXMYkE2FLhEbmaM=;
        b=oby5V/+ZbAsVQy1nabF27pmahXpdO5sz1wDJ2CkuIOziO5uwhMtWlOwiyBjGGAzTsA
         VSEPyXeGzeYtQrUF29Na2mo1qT1RdHbGuZFq27f2Wu7+QfeSOLOGyySm+UlBY68m9dJX
         s6Le6KZ4WwGKAZ+Ksca6ohfUQNC9B4cAj6CCUsFPQ7GNhw20DpHgvi4Nt5Zl4+yIzFuw
         vbay3ctwJA6Ii8VFXUt9CUc3vhxkbYkG9vliwKy5iroK4djt+9XtkGQxCyEkQIk54i7H
         5pCoyDQinIDpscLSOvlUDq/9RWLqs12lLS7sNYOuH2+5GEKFZCqJdOrIjjb19Xl4LWU2
         e11A==
X-Gm-Message-State: APjAAAVs0xRcyd309BfU0aTcAik4r0sYUgsL79hPjJInMf6MWhLb6lEX
        +9QCiCCw8VCGHjnm8N0t/pUbZQ==
X-Google-Smtp-Source: APXvYqzvZnrjqonjXJsxQ53xUAesmAmpB0WB8n+Yl5J0VBvPLIe21YmezU7TOIGzp9ggl5FDeKpiLQ==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr4718280ljg.189.1553596847668;
        Tue, 26 Mar 2019 03:40:47 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.243])
        by smtp.gmail.com with ESMTPSA id f1sm3956556ljf.40.2019.03.26.03.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:40:47 -0700 (PDT)
Subject: Re: [RFC PATCH v2 5/5] mtd: hyperbus: Add driver for TI's Hyperbus
 memory controller
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tudor.ambarus@microchip.com,
        nsekhar@ti.com, Mason Yang <masonccyang@mxic.com.tw>
References: <20190321174548.9288-1-vigneshr@ti.com>
 <20190321174548.9288-6-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <c537220a-63bd-9279-bbf0-fbbb1b4eb10a@cogentembedded.com>
Date:   Tue, 26 Mar 2019 13:40:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190321174548.9288-6-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2019 08:45 PM, Vignesh Raghavendra wrote:

> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.
> 
> Add basic support for the IP without DMA. Second ChipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[...]
> diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
> index ca61dedd730d..24abd1d43ade 100644
> --- a/drivers/mtd/hyperbus/Makefile
> +++ b/drivers/mtd/hyperbus/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_MTD_HYPERBUS)	+= hyperbus-core.o
> +obj-$(CONFIG_HBMC_AM654)	+= hbmc_am654.o
> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
> new file mode 100644
> index 000000000000..abf2b0959a35
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh Raghavendra <vigneshr@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mtd/hyperbus.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +struct am654_hbmc_priv {
> +	struct hyperbus_ctlr ctlr;
> +	struct hyperbus_device hbdev;
> +	void __iomem	*regbase;
> +};
> +
> +static const struct hyperbus_ops am654_hbmc_ops = {
> +	.calibrate = hyperbus_calibrate,
> +};
> +
> +static int am654_hbmc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct am654_hbmc_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {

   This is redundant as devm_ioremap_resource() checks for !res anyway.

> +		dev_err(&pdev->dev, "failed to get memory resource\n");
> +		return -ENOENT;
> +	}
> +
> +	priv->regbase = devm_ioremap_resource(dev, res);

   BTW, there's devm_platform_ioremap_resource() now...

[...]

MBR, Sergei
