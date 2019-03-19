Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C2AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101D02133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ho4oKh0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfCSM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:26:02 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47013 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCSM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:26:02 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E72B225B76D;
        Tue, 19 Mar 2019 23:25:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552998359; bh=W13YZhaBJ5eucexeaUcxCJszOyKnR0lgBq5HCNITuBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ho4oKh0COPLG40kwmANq3K+879KolZ1z43eIO2M7k7VZ7gwHJHWkDnpDf2qlVjRku
         pNHAx50aXvfBff3DNhkB3P50pzI3J7BbKvAbseiWizPVVCD8o3thhHNU4ymC7SzOqj
         QRQ8oMnR7fv5s8upm8IeBOCQUiqKNWvmxWRN8fQs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 414FB940663; Tue, 19 Mar 2019 13:25:57 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:25:57 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 3/6] mfd: da9063: remove platform_data support
Message-ID: <20190319122556.7wpabcnwklv3fg3v@verge.net.au>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-4-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:47:55PM +0100, Wolfram Sang wrote:
> There are no in-kernel users anymore, so remove this outdated interface.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mfd/da9063-core.c | 20 ++------------------
>  drivers/mfd/da9063-i2c.c  |  1 -
>  drivers/mfd/da9063-irq.c  |  1 -
>  3 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index 6e4ce49b4405..65ca288b0c90 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -26,7 +26,6 @@
>  #include <linux/regmap.h>
>  
>  #include <linux/mfd/da9063/core.h>
> -#include <linux/mfd/da9063/pdata.h>
>  #include <linux/mfd/da9063/registers.h>
>  
>  #include <linux/proc_fs.h>
> @@ -165,7 +164,6 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
>  
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  {
> -	struct da9063_pdata *pdata = da9063->dev->platform_data;
>  	int model, variant_id, variant_code;
>  	int ret;
>  
> @@ -173,24 +171,10 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  	if (ret < 0)
>  		dev_err(da9063->dev, "Cannot clear fault log\n");
>  
> -	if (pdata) {
> -		da9063->flags = pdata->flags;
> -		da9063->irq_base = pdata->irq_base;
> -	} else {
> -		da9063->flags = 0;
> -		da9063->irq_base = -1;
> -	}
> +	da9063->flags = 0;
> +	da9063->irq_base = -1;

If the flag and irq_base fields have fixed values can
they be removed? As a follow-up?

>  	da9063->chip_irq = irq;
>  
> -	if (pdata && pdata->init != NULL) {
> -		ret = pdata->init(da9063);
> -		if (ret != 0) {
> -			dev_err(da9063->dev,
> -				"Platform initialization failed.\n");
> -			return ret;
> -		}
> -	}
> -
>  	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_ID, &model);
>  	if (ret < 0) {
>  		dev_err(da9063->dev, "Cannot read chip model id.\n");
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 50a24b1921d0..5f707b100e69 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -22,7 +22,6 @@
>  
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/da9063/core.h>
> -#include <linux/mfd/da9063/pdata.h>
>  #include <linux/mfd/da9063/registers.h>
>  
>  #include <linux/of.h>
> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> index ecc0c8ce6c58..ac02c31c5802 100644
> --- a/drivers/mfd/da9063-irq.c
> +++ b/drivers/mfd/da9063-irq.c
> @@ -19,7 +19,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/da9063/core.h>
> -#include <linux/mfd/da9063/pdata.h>
>  
>  #define	DA9063_REG_EVENT_A_OFFSET	0
>  #define	DA9063_REG_EVENT_B_OFFSET	1
> -- 
> 2.11.0
> 
