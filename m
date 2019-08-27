Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D320C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A9C204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mIRYGT9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfH0FsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:48:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59046 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0FsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:48:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R5ltnu083856;
        Tue, 27 Aug 2019 00:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566884875;
        bh=UoHPb4KaxqBqlyC0xsWIA/tO9fn/nvecWMW+jVJ0Oe8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=mIRYGT9DJQHh+l08l2+r4yH39skOR9lcXb+keE+j447JctqvjnvS+daoCkDa9L/cs
         +tCTIijh+Zb6BiZKHd453irPy7K8BVWDe0JB7cKokopuSL8cfZx1d+5M9k94+UpkMQ
         y6IREVzLLFLH502QoGgDpY9y9oZgH5zXMn/kulrM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R5lt4q015935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 00:47:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 00:47:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 00:47:55 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R5lpdD070891;
        Tue, 27 Aug 2019 00:47:52 -0500
Subject: Re: [RESEND PATCH v3 05/20] mtd: spi-nor: Add default_init() hook to
 tweak flash parameters
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-6-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <49af749d-1716-8c88-bb81-25f493a10a2e@ti.com>
Date:   Tue, 27 Aug 2019 11:18:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-6-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:38 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> As of now, the flash parameters initialization logic is as following:
> 
> a/ default flash parameters init in spi_nor_init_params()
> b/ manufacturer specific flash parameters updates, split across entire
>    spi-nor core code
> c/ flash parameters updates based on SFDP tables
> d/ post BFPT flash parameter updates
> 
> In the quest of removing the manufacturer specific code from the spi-nor
> core, we want to impose a timeline/priority on how the flash parameters
> are updated. The following sequence of calls is pursued:
> 
> 1/ spi-nor core parameters init based on 'flash_info' struct:
> 	spi_nor_info_init_params()
> 
> which can be overwritten by:
> 2/ MFR-based manufacturer flash parameters init:
> 	nor->manufacturer->fixups->default_init()
> 
> which can be overwritten by:
> 3/ specific flash_info tweeks done when decisions can not be done just on
>    MFR:
> 	nor->info->fixups->default_init()
> 
> which can be overwritten by:
> 4/ SFDP tables flash parameters init - SFDP knows better:
> 	spi_nor_sfdp_init_params()
> 
> which can be overwritten by:
> 5/ post SFDP tables flash parameters updates - in case manufacturers get
>    the serial flash tables wrong or incomplete.
> 	nor->info->fixups->post_sfdp()
>    The later can be extended to nor->manufacturer->fixups->post_sfdp() if
>    needed.
> 
> This patch opens doors for steps 2/ and 3/.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: reword description
> 
>  drivers/mtd/spi-nor/spi-nor.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 9dd6cd8cd13c..8fd60e1eebd2 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -154,12 +154,16 @@ struct sfdp_bfpt {
>  
>  /**
>   * struct spi_nor_fixups - SPI NOR fixup hooks
> + * @default_init: called after default flash parameters init. Used to tweak
> + *                flash parameters when information provided by the flash_info
> + *                table is incomplete or wrong.
>   * @post_bfpt: called after the BFPT table has been parsed
>   *
>   * Those hooks can be used to tweak the SPI NOR configuration when the SFDP
>   * table is broken or not available.
>   */
>  struct spi_nor_fixups {
> +	void (*default_init)(struct spi_nor *nor);
>  	int (*post_bfpt)(struct spi_nor *nor,
>  			 const struct sfdp_parameter_header *bfpt_header,
>  			 const struct sfdp_bfpt *bfpt,
> @@ -4133,6 +4137,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	return err;
>  }
>  
> +/**
> + * spi_nor_manufacturer_init_params() - Initialize the flash's parameters and
> + * settings based on ->default_init() hook.
> + * @nor:	pointer to a 'struct spi-nor'.
> + */
> +static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
> +{
> +	if (nor->info->fixups && nor->info->fixups->default_init)
> +		nor->info->fixups->default_init(nor);
> +}
> +
>  static int spi_nor_init_params(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = &nor->params;
> @@ -4233,6 +4248,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
>  			params->quad_enable = info->quad_enable;
>  	}
>  
> +	spi_nor_manufacturer_init_params(nor);
> +
>  	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
>  	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
>  		struct spi_nor_flash_parameter sfdp_params;
> 

-- 
Regards
Vignesh
