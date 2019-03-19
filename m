Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39942C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC9620685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="FpWGh1nI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCSMuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:50:08 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47345 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCSMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:50:08 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 14BF725BE0A;
        Tue, 19 Mar 2019 23:50:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552999806; bh=Trn5wbqGz4FJIxPnNY0CKGbjouA+Sz4+3WION/EDIXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpWGh1nIheR/+y7Ct1T09r0UT+yosoHaLu+JoHkQODhT610bx9g3tDy+bFcG2ryhl
         pP88InG3iMod6WGkpfjqT3ZBQv9gmu05xzlFoLIoc8TmA5FzmvPxai44zxgX3F8dGM
         +TL0H4UJg0HVJUc4QIgl/18Arab/mWTAtKw7//uk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 85CDB940663; Tue, 19 Mar 2019 13:50:04 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:50:04 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 6/6] regulator: da9063: platform_data is gone, depend on
 OF
Message-ID: <20190319125004.bpx3jcxqiajeupiy@verge.net.au>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-7-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:47:58PM +0100, Wolfram Sang wrote:
> With OF being the only configuration possibility left, depend on it to
> simplify some code.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/regulator/Kconfig            |  2 +-
>  drivers/regulator/da9063-regulator.c | 10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index b7f249ee5e68..6663cd6cb96c 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -256,7 +256,7 @@ config REGULATOR_DA9062
>  
>  config REGULATOR_DA9063
>  	tristate "Dialog Semiconductor DA9063 regulators"
> -	depends on MFD_DA9063
> +	depends on MFD_DA9063 && OF
>  	help
>  	  Say y here to support the BUCKs and LDOs regulators found on
>  	  DA9063 PMICs.
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index c05859ad63d8..2eda8d985756 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -681,7 +681,6 @@ static const struct regulator_init_data *da9063_get_regulator_initdata(
>  	return NULL;
>  }
>  
> -#ifdef CONFIG_OF
>  static struct of_regulator_match da9063_matches[] = {
>  	[DA9063_ID_BCORE1]           = { .name = "bcore1"           },
>  	[DA9063_ID_BCORE2]           = { .name = "bcore2"           },
> @@ -759,15 +758,6 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
>  	*da9063_reg_matches = da9063_matches;
>  	return pdata;
>  }
> -#else
> -static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
> -		struct platform_device *pdev,
> -		struct of_regulator_match **da9063_reg_matches)
> -{
> -	*da9063_reg_matches = NULL;
> -	return ERR_PTR(-ENODEV);
> -}
> -#endif
>  
>  static int da9063_regulator_probe(struct platform_device *pdev)
>  {
> -- 
> 2.11.0
> 
