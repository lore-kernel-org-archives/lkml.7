Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C985C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9C120685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="CPzlOTb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCSMtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:49:15 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47288 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCSMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:49:14 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 00BF425BE0A;
        Tue, 19 Mar 2019 23:49:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552999752; bh=svEFM2qF8slEC7neYjvg6fmK5DaeIaXx5e5A6cepaUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPzlOTb2uXyKmWIOkac61iLgeqkZpQ9MPjE4sM0ZGXTvOaQ4OL5i5rWv9Ajt0iWSo
         NOJfwobSB8wkKLmxBHZu5zTx6i+Lp7sHMNu2+X1SgqST5oHhmKCQkqJ1YkGPF2YiK7
         iYvKV7sGHrv0nDt5NK79Cn9lu4vBCM5B5I4v2O0c=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 52A3E940663; Tue, 19 Mar 2019 13:49:10 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:49:10 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/6] regulator: da9063: remove platform_data support
Message-ID: <20190319124909.7dj6ns5kkgdj4lop@verge.net.au>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-2-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:47:53PM +0100, Wolfram Sang wrote:
> There are no in-kernel users anymore, so remove this outdated interface.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/regulator/da9063-regulator.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index 2b0c7a85306a..73c85039d0cf 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -730,7 +730,6 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
>  static int da9063_regulator_probe(struct platform_device *pdev)
>  {
>  	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> -	struct da9063_pdata *da9063_pdata = dev_get_platdata(da9063->dev);
>  	struct of_regulator_match *da9063_reg_matches = NULL;
>  	struct da9063_regulators_pdata *regl_pdata;
>  	const struct da9063_dev_model *model;
> @@ -740,11 +739,7 @@ static int da9063_regulator_probe(struct platform_device *pdev)
>  	bool bcores_merged, bmem_bio_merged;
>  	int id, irq, n, n_regulators, ret, val;
>  
> -	regl_pdata = da9063_pdata ? da9063_pdata->regulators_pdata : NULL;
> -
> -	if (!regl_pdata)
> -		regl_pdata = da9063_parse_regulators_dt(pdev,
> -							&da9063_reg_matches);
> +	regl_pdata = da9063_parse_regulators_dt(pdev, &da9063_reg_matches);
>  
>  	if (IS_ERR(regl_pdata) || regl_pdata->n_regulators == 0) {
>  		dev_err(&pdev->dev,
> -- 
> 2.11.0
> 
