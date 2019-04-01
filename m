Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A192C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F6620896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfDAScJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:32:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33810 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbfDAScH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:32:07 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hB1ix-00078O-HA; Mon, 01 Apr 2019 20:31:59 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX offload for rockchip devices
Date:   Mon, 01 Apr 2019 20:31:58 +0200
Message-ID: <2839092.mkRqKCgQVQ@diego>
In-Reply-To: <20190401181840.31255-1-papadakospan@gmail.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonidas,

Am Montag, 1. April 2019, 20:18:40 CEST schrieb Leonidas P. Papadakos:
> From: =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>
> 
> Some rockchip boards exhibit an issue where tx checksumming does not work with
> packets larger than 1498.
> 
> This is bad for network stability.
> 
> The previous approach was using force_thresh_dma_mode in the board dts, which
> does more than we need.
> 
> Signed-off-by: Leonidas P. Papadakos <papadakospan@gmail.com>

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 3031f2bf1..807cf5826 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -519,6 +519,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
>  		pr_warn("force_sf_dma_mode is ignored if force_thresh_dma_mode is set.");
>  	}
>  
> +	plat->bugged_tx_coe = of_property_read_bool(np, "rockchip,bugged_tx_coe");
> +

you're adding a new devicetree property, so please
(1) also update the binding doc in
    Documentation/devicetree/bindings/net/rockchip-dwmac.txt
(2) Cc devicetree maintainers and lists (via get_maintainer.pl once
    you've added the binding change) to let them look at it.


Thanks
Heiko

>  	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
>  
>  	plat->axi = stmmac_axi_setup(pdev);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 4335bd771..60c411f43 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -162,6 +162,7 @@ struct plat_stmmacenet_data {
>  	int pmt;
>  	int force_sf_dma_mode;
>  	int force_thresh_dma_mode;
> +	int bugged_tx_coe;
>  	int riwt_off;
>  	int max_speed;
>  	int maxmtu;
> 




