Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E125C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBF320685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="IY3FU19e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCSMtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:49:22 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47299 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCSMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:49:22 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id C93B825BEEF;
        Tue, 19 Mar 2019 23:49:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552999760; bh=otzbqupo+XGLKWFKXNoCFxzgzz2jKW0UruQfZHR+V2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY3FU19eAdj/LzmPUGZPA/ckYTeYbK100qsL7fD7nv3ZpD6Wiktawk3Y+n1wlytn0
         3RPW2fGEAvJMvUg1fvFxqG05FVdfGKQBrSfttIbRbastgsyhvCwLAX9HuGZNtcsOqx
         m5r3WYR2g0eavubroA4dBR2WFR2ZA83bBKPt5xDI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 39123940663; Tue, 19 Mar 2019 13:49:18 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:49:18 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/6] input: da9063_onkey: remove platform_data support
Message-ID: <20190319124917.sidcf742iml2jzam@verge.net.au>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:47:54PM +0100, Wolfram Sang wrote:
> There are no in-kernel users anymore, so remove this outdated interface.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/input/misc/da9063_onkey.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
> index 3e9c353d82ef..e3a273c74123 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -22,7 +22,6 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/mfd/da9063/core.h>
> -#include <linux/mfd/da9063/pdata.h>
>  #include <linux/mfd/da9063/registers.h>
>  #include <linux/mfd/da9062/core.h>
>  #include <linux/mfd/da9062/registers.h>
> @@ -201,8 +200,6 @@ static void da9063_cancel_poll(void *data)
>  
>  static int da9063_onkey_probe(struct platform_device *pdev)
>  {
> -	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> -	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
>  	struct da9063_onkey *onkey;
>  	const struct of_device_id *match;
>  	int irq;
> @@ -229,12 +226,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	if (pdata)
> -		onkey->key_power = pdata->key_power;
> -	else
> -		onkey->key_power =
> -			!of_property_read_bool(pdev->dev.of_node,
> -					       "dlg,disable-key-power");
> +	onkey->key_power = !of_property_read_bool(pdev->dev.of_node,
> +						  "dlg,disable-key-power");
>  
>  	onkey->input = devm_input_allocate_device(&pdev->dev);
>  	if (!onkey->input) {
> -- 
> 2.11.0
> 
