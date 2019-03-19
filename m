Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5D42147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ojJaqxyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCSMtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:49:50 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47320 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCSMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:49:49 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 690C825BEFA;
        Tue, 19 Mar 2019 23:49:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552999786; bh=RFTQBYqWmUxW3EYPl7gvbgDBTS9WEt713FJ0/BUT5tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojJaqxydQUDv5oALVKmDH3rUlpbM/OLQsSH2TlwRrlJl3suvTiURfqN8/b0omUpfE
         Xt7/Oy9Dj6c4vSBVlSNHaD9dd6GTd2LBnPUMCRT+H+B0QgTpg317ot+4rC4mHv43eP
         e1AMIetaNfEjrCQKiRoIpRPlndFvhwkK6QNW8Tp4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D851E940663; Tue, 19 Mar 2019 13:49:44 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:49:44 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/6] regulator: da9063: move definitions out of a header
 into the driver
Message-ID: <20190319124944.rdo2qzuprisdhq6h@verge.net.au>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:47:56PM +0100, Wolfram Sang wrote:
> Those definitions are only used within the driver meanwhile, so put them
> there.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/regulator/da9063-regulator.c | 44 +++++++++++++++++++++++++++++++-
>  include/linux/mfd/da9063/pdata.h     | 49 ------------------------------------
>  2 files changed, 43 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index 73c85039d0cf..c05859ad63d8 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -25,7 +25,6 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
>  #include <linux/mfd/da9063/core.h>
> -#include <linux/mfd/da9063/pdata.h>
>  #include <linux/mfd/da9063/registers.h>
>  
>  
> @@ -34,6 +33,49 @@
>  	REG_FIELD(_reg, __builtin_ffs((int)_mask) - 1, \
>  		sizeof(unsigned int) * 8 - __builtin_clz((_mask)) - 1)
>  
> +/* DA9063 and DA9063L regulator IDs */
> +enum {
> +	/* BUCKs */
> +	DA9063_ID_BCORE1,
> +	DA9063_ID_BCORE2,
> +	DA9063_ID_BPRO,
> +	DA9063_ID_BMEM,
> +	DA9063_ID_BIO,
> +	DA9063_ID_BPERI,
> +
> +	/* BCORE1 and BCORE2 in merged mode */
> +	DA9063_ID_BCORES_MERGED,
> +	/* BMEM and BIO in merged mode */
> +	DA9063_ID_BMEM_BIO_MERGED,
> +	/* When two BUCKs are merged, they cannot be reused separately */
> +
> +	/* LDOs on both DA9063 and DA9063L */
> +	DA9063_ID_LDO3,
> +	DA9063_ID_LDO7,
> +	DA9063_ID_LDO8,
> +	DA9063_ID_LDO9,
> +	DA9063_ID_LDO11,
> +
> +	/* DA9063-only LDOs */
> +	DA9063_ID_LDO1,
> +	DA9063_ID_LDO2,
> +	DA9063_ID_LDO4,
> +	DA9063_ID_LDO5,
> +	DA9063_ID_LDO6,
> +	DA9063_ID_LDO10,
> +};
> +
> +/* Old regulator platform data */
> +struct da9063_regulator_data {
> +	int				id;
> +	struct regulator_init_data	*initdata;
> +};
> +
> +struct da9063_regulators_pdata {
> +	unsigned int			n_regulators;
> +	struct da9063_regulator_data	*regulator_data;
> +};
> +
>  /* Regulator capabilities and registers description */
>  struct da9063_regulator_info {
>  	struct regulator_desc desc;
> diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
> index 50bed4f89c1a..21a2d107f0cf 100644
> --- a/include/linux/mfd/da9063/pdata.h
> +++ b/include/linux/mfd/da9063/pdata.h
> @@ -16,55 +16,6 @@
>  #ifndef __MFD_DA9063_PDATA_H__
>  #define __MFD_DA9063_PDATA_H__
>  
> -#include <linux/regulator/machine.h>
> -
> -/*
> - * Regulator configuration
> - */
> -/* DA9063 and DA9063L regulator IDs */
> -enum {
> -	/* BUCKs */
> -	DA9063_ID_BCORE1,
> -	DA9063_ID_BCORE2,
> -	DA9063_ID_BPRO,
> -	DA9063_ID_BMEM,
> -	DA9063_ID_BIO,
> -	DA9063_ID_BPERI,
> -
> -	/* BCORE1 and BCORE2 in merged mode */
> -	DA9063_ID_BCORES_MERGED,
> -	/* BMEM and BIO in merged mode */
> -	DA9063_ID_BMEM_BIO_MERGED,
> -	/* When two BUCKs are merged, they cannot be reused separately */
> -
> -	/* LDOs on both DA9063 and DA9063L */
> -	DA9063_ID_LDO3,
> -	DA9063_ID_LDO7,
> -	DA9063_ID_LDO8,
> -	DA9063_ID_LDO9,
> -	DA9063_ID_LDO11,
> -
> -	/* DA9063-only LDOs */
> -	DA9063_ID_LDO1,
> -	DA9063_ID_LDO2,
> -	DA9063_ID_LDO4,
> -	DA9063_ID_LDO5,
> -	DA9063_ID_LDO6,
> -	DA9063_ID_LDO10,
> -};
> -
> -/* Regulators platform data */
> -struct da9063_regulator_data {
> -	int				id;
> -	struct regulator_init_data	*initdata;
> -};
> -
> -struct da9063_regulators_pdata {
> -	unsigned			n_regulators;
> -	struct da9063_regulator_data	*regulator_data;
> -};
> -
> -
>  /*
>   * RGB LED configuration
>   */
> -- 
> 2.11.0
> 
