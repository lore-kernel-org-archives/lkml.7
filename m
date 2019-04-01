Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5640420880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfDASyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:54:51 -0400
Received: from foss.arm.com ([217.140.101.70]:40682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfDASyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:54:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1F6680D;
        Mon,  1 Apr 2019 11:54:48 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50CD83F59C;
        Mon,  1 Apr 2019 11:54:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     netdev@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190401181840.31255-1-papadakospan@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com>
Date:   Mon, 1 Apr 2019 19:54:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401181840.31255-1-papadakospan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 19:18, Leonidas P. Papadakos wrote:
> From: =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>
> 
> Some rockchip boards exhibit an issue where tx checksumming does not work with
> packets larger than 1498.

Is it really a board-level problem? I'm no networking expert, but the 
nature of the workaround suggests this is more likely to be some 
inherent limitation of the IP block in the SoC, rather than something to 
do with how the external pins get wired up. Does anyone have an RK3328 
or RK3399 board that provably *does* checksum large packets correctly?

> This is bad for network stability.
> 
> The previous approach was using force_thresh_dma_mode in the board dts, which
> does more than we need.

If indeed it is a SoC-level thing (or at least we want to treat it as 
such), then couldn't we just hang it off the existing SoC-specific 
compatibles in dwmac-rk.c and avoid the need for a new DT property at 
all? After all, that's precisely why SoC-specific compatibles are a 
thing in the first place.

Robin.

> Signed-off-by: Leonidas P. Papadakos <papadakospan@gmail.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 4 ++++
>   drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 ++
>   include/linux/stmmac.h                                | 1 +
>   3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6a2e1031a..4552147e9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3660,6 +3660,10 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
>   	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
>   		features &= ~NETIF_F_CSUM_MASK;
>   
> +	/* Including very small MTUs of 1498 for Rockchip devices */
> +	if (priv->plat->bugged_tx_coe && (dev->mtu > ETH_DATA_LEN - 2))
> +		features &= ~NETIF_F_CSUM_MASK;
> +
>   	/* Disable tso if asked by ethtool */
>   	if ((priv->plat->tso_en) && (priv->dma_cap.tsoen)) {
>   		if (features & NETIF_F_TSO)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 3031f2bf1..807cf5826 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -519,6 +519,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
>   		pr_warn("force_sf_dma_mode is ignored if force_thresh_dma_mode is set.");
>   	}
>   
> +	plat->bugged_tx_coe = of_property_read_bool(np, "rockchip,bugged_tx_coe");
> +
>   	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
>   
>   	plat->axi = stmmac_axi_setup(pdev);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 4335bd771..60c411f43 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -162,6 +162,7 @@ struct plat_stmmacenet_data {
>   	int pmt;
>   	int force_sf_dma_mode;
>   	int force_thresh_dma_mode;
> +	int bugged_tx_coe;
>   	int riwt_off;
>   	int max_speed;
>   	int maxmtu;
> 
