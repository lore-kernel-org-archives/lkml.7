Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1742EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76CA206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h/rHSH1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfDYNea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:34:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53418 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDYNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:34:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3PDYOs9094149;
        Thu, 25 Apr 2019 08:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556199264;
        bh=i9mEhmUGLrNWrfeFznZNhY8HW+IfGPT2dPvBI7ziNFw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=h/rHSH1aJE6sPAnpkjUFzvXyCwZUvYQMkfPpc2SxqYWXG+oXERkURVs8b36XmEdKM
         dX1tBgKiHacX3whE8otpMldlzszPMk0qO+4h1c8sVbRozCovAQXK4Wdn7IH95EpmwK
         BLKJvbjvCriJ3zbVOF1rvLiqUFf+4uKIyG6upVEY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3PDYNs0043477
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Apr 2019 08:34:23 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Apr 2019 08:34:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Apr 2019 08:34:23 -0500
Received: from [158.218.117.39] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3PDYMja029775;
        Thu, 25 Apr 2019 08:34:23 -0500
Subject: Re: [PATCH net-next 16/19] net: ethernet: ti: cpsw: move common hw
 init code in separate func
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
From:   Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <71d13a87-a078-a49d-43b2-33beb19f0e46@ti.com>
Date:   Thu, 25 Apr 2019 09:38:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2019 09:09 AM, Grygorii Strashko wrote:
> move common hw init code in separate function as preparation for adding new
> switchdev driver.
All of the changes indicates a better name for the file is 
cpsw_common.c; commit log, new function cpsw_init_common() etc. Any 
specific reason to use cpsw_priv.[ch]?

> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>   drivers/net/ethernet/ti/Makefile    |   2 +-
>   drivers/net/ethernet/ti/cpsw.c      | 106 ++---------------------
>   drivers/net/ethernet/ti/cpsw_priv.c | 128 ++++++++++++++++++++++++++++
>   drivers/net/ethernet/ti/cpsw_priv.h |   3 +
>   4 files changed, 137 insertions(+), 102 deletions(-)
>   create mode 100644 drivers/net/ethernet/ti/cpsw_priv.c
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 2f159a71f88e..de1561596646 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -14,7 +14,7 @@ obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
>   obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
>   obj-$(CONFIG_TI_CPTS_MOD) += cpts.o
>   obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
> -ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o
> +ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o
>   
>   obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
>   keystone_netcp-y := netcp_core.o cpsw_ale.o
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 7dffc67f0cf4..a6c3d8be1649 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -3007,16 +3007,12 @@ static int cpsw_probe(struct platform_device *pdev)
>   	struct cpsw_platform_data	*data;
>   	struct net_device		*ndev;
>   	struct cpsw_priv		*priv;
> -	struct cpdma_params		dma_params;
> -	struct cpsw_ale_params		ale_params;
>   	void __iomem			*ss_regs;
> -	void __iomem			*cpts_regs;
>   	struct resource			*res, *ss_res;
>   	struct gpio_descs		*mode;
> -	u32 slave_offset, sliver_offset, slave_size;
>   	const struct soc_device_attribute *soc;
>   	struct cpsw_common		*cpsw;
> -	int ret = 0, i, ch;
> +	int ret = 0, ch;
>   	int irq;
>   
>   	cpsw = devm_kzalloc(dev, sizeof(struct cpsw_common), GFP_KERNEL);
> @@ -3096,103 +3092,12 @@ static int cpsw_probe(struct platform_device *pdev)
>   
>   	cpsw->rx_packet_max = max(rx_packet_max, CPSW_MAX_PACKET_SIZE);
>   
> -	cpsw->rx_ch_num = 1;
> -	cpsw->tx_ch_num = 1;
>   
> -	cpsw->version = readl(&cpsw->regs->id_ver);
> -
> -	memset(&dma_params, 0, sizeof(dma_params));
> -	memset(&ale_params, 0, sizeof(ale_params));
> -
> -	switch (cpsw->version) {
> -	case CPSW_VERSION_1:
> -		cpsw->host_port_regs = ss_regs + CPSW1_HOST_PORT_OFFSET;
> -		cpts_regs		= ss_regs + CPSW1_CPTS_OFFSET;
> -		cpsw->hw_stats	     = ss_regs + CPSW1_HW_STATS;
> -		dma_params.dmaregs   = ss_regs + CPSW1_CPDMA_OFFSET;
> -		dma_params.txhdp     = ss_regs + CPSW1_STATERAM_OFFSET;
> -		ale_params.ale_regs  = ss_regs + CPSW1_ALE_OFFSET;
> -		slave_offset         = CPSW1_SLAVE_OFFSET;
> -		slave_size           = CPSW1_SLAVE_SIZE;
> -		sliver_offset        = CPSW1_SLIVER_OFFSET;
> -		dma_params.desc_mem_phys = 0;
> -		break;
> -	case CPSW_VERSION_2:
> -	case CPSW_VERSION_3:
> -	case CPSW_VERSION_4:
> -		cpsw->host_port_regs = ss_regs + CPSW2_HOST_PORT_OFFSET;
> -		cpts_regs		= ss_regs + CPSW2_CPTS_OFFSET;
> -		cpsw->hw_stats	     = ss_regs + CPSW2_HW_STATS;
> -		dma_params.dmaregs   = ss_regs + CPSW2_CPDMA_OFFSET;
> -		dma_params.txhdp     = ss_regs + CPSW2_STATERAM_OFFSET;
> -		ale_params.ale_regs  = ss_regs + CPSW2_ALE_OFFSET;
> -		slave_offset         = CPSW2_SLAVE_OFFSET;
> -		slave_size           = CPSW2_SLAVE_SIZE;
> -		sliver_offset        = CPSW2_SLIVER_OFFSET;
> -		dma_params.desc_mem_phys =
> -			(u32 __force) ss_res->start + CPSW2_BD_OFFSET;
> -		break;
> -	default:
> -		dev_err(dev, "unknown version 0x%08x\n", cpsw->version);
> -		ret = -ENODEV;
> -		goto clean_dt_ret;
> -	}
> -
> -	for (i = 0; i < cpsw->data.slaves; i++) {
> -		struct cpsw_slave *slave = &cpsw->slaves[i];
> -		void __iomem		*regs = cpsw->regs;
> -
> -		slave->slave_num = i;
> -		slave->data	= &cpsw->data.slave_data[i];
> -		slave->regs	= regs + slave_offset;
> -		slave->sliver	= regs + sliver_offset;
> -		slave->port_vlan = slave->data->dual_emac_res_vlan;
> -
> -		slave_offset  += slave_size;
> -		sliver_offset += SLIVER_SIZE;
> -	}
> -
> -	ale_params.dev			= dev;
> -	ale_params.ale_ageout		= ale_ageout;
> -	ale_params.ale_entries		= data->ale_entries;
> -	ale_params.ale_ports		= CPSW_ALE_PORTS_NUM;
> -
> -	cpsw->ale = cpsw_ale_create(&ale_params);
> -	if (!cpsw->ale) {
> -		dev_err(dev, "error initializing ale engine\n");
> -		ret = -ENODEV;
> -		goto clean_dt_ret;
> -	}
> -
> -	dma_params.dev		= dev;
> -	dma_params.rxthresh	= dma_params.dmaregs + CPDMA_RXTHRESH;
> -	dma_params.rxfree	= dma_params.dmaregs + CPDMA_RXFREE;
> -	dma_params.rxhdp	= dma_params.txhdp + CPDMA_RXHDP;
> -	dma_params.txcp		= dma_params.txhdp + CPDMA_TXCP;
> -	dma_params.rxcp		= dma_params.txhdp + CPDMA_RXCP;
> -
> -	dma_params.num_chan		= data->channels;
> -	dma_params.has_soft_reset	= true;
> -	dma_params.min_packet_size	= CPSW_MIN_PACKET_SIZE;
> -	dma_params.desc_mem_size	= data->bd_ram_size;
> -	dma_params.desc_align		= 16;
> -	dma_params.has_ext_regs		= true;
> -	dma_params.desc_hw_addr         = dma_params.desc_mem_phys;
> -	dma_params.bus_freq_mhz		= cpsw->bus_freq_mhz;
> -	dma_params.descs_pool_size	= descs_pool_size;
> -
> -	cpsw->dma = cpdma_ctlr_create(&dma_params);
> -	if (!cpsw->dma) {
> -		dev_err(dev, "error initializing dma\n");
> -		ret = -ENOMEM;
> +	ret = cpsw_init_common(cpsw, ss_regs, ale_ageout,
> +			       (u32 __force)ss_res->start + CPSW2_BD_OFFSET,
> +			       descs_pool_size);
> +	if (ret)
>   		goto clean_dt_ret;
> -	}
> -
> -	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
> -	if (IS_ERR(cpsw->cpts)) {
> -		ret = PTR_ERR(cpsw->cpts);
> -		goto clean_dma_ret;
> -	}
>   
>   	ch = cpsw->quirk_irq ? 0 : 7;
>   	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, ch, cpsw_tx_handler, 0);
> @@ -3300,7 +3205,6 @@ static int cpsw_probe(struct platform_device *pdev)
>   	unregister_netdev(ndev);
>   clean_cpts:
>   	cpts_release(cpsw->cpts);
> -clean_dma_ret:
>   	cpdma_ctlr_destroy(cpsw->dma);
>   clean_dt_ret:
>   	cpsw_remove_dt(pdev);
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
> new file mode 100644
> index 000000000000..208c544d0b80
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/cpsw_priv.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments Ethernet Switch Driver
> + *
> + * Copyright (C) 2019 Texas Instruments
> + */
> +
> +#include <linux/if_ether.h>
> +#include <linux/if_vlan.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/skbuff.h>
> +
> +#include "cpts.h"
> +#include "cpsw_ale.h"
> +#include "cpsw_priv.h"
> +#include "davinci_cpdma.h"
> +
> +int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
> +		     int ale_ageout, u32 desc_mem_phys, int descs_pool_size)
> +{
> +	u32 slave_offset, sliver_offset, slave_size;
> +	struct cpsw_ale_params ale_params;
> +	struct cpsw_platform_data *data;
> +	struct cpdma_params dma_params;
> +	struct device *dev = cpsw->dev;
> +	void __iomem *cpts_regs;
> +	int ret = 0, i;
> +
> +	data = &cpsw->data;
> +	cpsw->rx_ch_num = 1;
> +	cpsw->tx_ch_num = 1;
> +
> +	cpsw->version = readl(&cpsw->regs->id_ver);
> +
> +	memset(&dma_params, 0, sizeof(dma_params));
> +	memset(&ale_params, 0, sizeof(ale_params));
> +
> +	switch (cpsw->version) {
> +	case CPSW_VERSION_1:
> +		cpsw->host_port_regs = ss_regs + CPSW1_HOST_PORT_OFFSET;
> +		cpts_regs	     = ss_regs + CPSW1_CPTS_OFFSET;
> +		cpsw->hw_stats	     = ss_regs + CPSW1_HW_STATS;
> +		dma_params.dmaregs   = ss_regs + CPSW1_CPDMA_OFFSET;
> +		dma_params.txhdp     = ss_regs + CPSW1_STATERAM_OFFSET;
> +		ale_params.ale_regs  = ss_regs + CPSW1_ALE_OFFSET;
> +		slave_offset         = CPSW1_SLAVE_OFFSET;
> +		slave_size           = CPSW1_SLAVE_SIZE;
> +		sliver_offset        = CPSW1_SLIVER_OFFSET;
> +		dma_params.desc_mem_phys = 0;
> +		break;
> +	case CPSW_VERSION_2:
> +	case CPSW_VERSION_3:
> +	case CPSW_VERSION_4:
> +		cpsw->host_port_regs = ss_regs + CPSW2_HOST_PORT_OFFSET;
> +		cpts_regs	     = ss_regs + CPSW2_CPTS_OFFSET;
> +		cpsw->hw_stats	     = ss_regs + CPSW2_HW_STATS;
> +		dma_params.dmaregs   = ss_regs + CPSW2_CPDMA_OFFSET;
> +		dma_params.txhdp     = ss_regs + CPSW2_STATERAM_OFFSET;
> +		ale_params.ale_regs  = ss_regs + CPSW2_ALE_OFFSET;
> +		slave_offset         = CPSW2_SLAVE_OFFSET;
> +		slave_size           = CPSW2_SLAVE_SIZE;
> +		sliver_offset        = CPSW2_SLIVER_OFFSET;
> +		dma_params.desc_mem_phys = desc_mem_phys;
> +		break;
> +	default:
> +		dev_err(dev, "unknown version 0x%08x\n", cpsw->version);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < cpsw->data.slaves; i++) {
> +		struct cpsw_slave *slave = &cpsw->slaves[i];
> +		void __iomem		*regs = cpsw->regs;
> +
> +		slave->slave_num = i;
> +		slave->data	= &cpsw->data.slave_data[i];
> +		slave->regs	= regs + slave_offset;
> +		slave->sliver	= regs + sliver_offset;
> +		slave->port_vlan = slave->data->dual_emac_res_vlan;
> +
> +		slave_offset  += slave_size;
> +		sliver_offset += SLIVER_SIZE;
> +	}
> +
> +	ale_params.dev			= dev;
> +	ale_params.ale_ageout		= ale_ageout;
> +	ale_params.ale_entries		= data->ale_entries;
> +	ale_params.ale_ports		= CPSW_ALE_PORTS_NUM;
> +
> +	cpsw->ale = cpsw_ale_create(&ale_params);
> +	if (!cpsw->ale) {
> +		dev_err(dev, "error initializing ale engine\n");
> +		return -ENODEV;
> +	}
> +
> +	dma_params.dev		= dev;
> +	dma_params.rxthresh	= dma_params.dmaregs + CPDMA_RXTHRESH;
> +	dma_params.rxfree	= dma_params.dmaregs + CPDMA_RXFREE;
> +	dma_params.rxhdp	= dma_params.txhdp + CPDMA_RXHDP;
> +	dma_params.txcp		= dma_params.txhdp + CPDMA_TXCP;
> +	dma_params.rxcp		= dma_params.txhdp + CPDMA_RXCP;
> +
> +	dma_params.num_chan		= data->channels;
> +	dma_params.has_soft_reset	= true;
> +	dma_params.min_packet_size	= CPSW_MIN_PACKET_SIZE;
> +	dma_params.desc_mem_size	= data->bd_ram_size;
> +	dma_params.desc_align		= 16;
> +	dma_params.has_ext_regs		= true;
> +	dma_params.desc_hw_addr         = dma_params.desc_mem_phys;
> +	dma_params.bus_freq_mhz		= cpsw->bus_freq_mhz;
> +	dma_params.descs_pool_size	= descs_pool_size;
> +
> +	cpsw->dma = cpdma_ctlr_create(&dma_params);
> +	if (!cpsw->dma) {
> +		dev_err(dev, "error initializing dma\n");
> +		return -ENOMEM;
> +	}
> +
> +	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
> +	if (IS_ERR(cpsw->cpts)) {
> +		ret = PTR_ERR(cpsw->cpts);
> +		cpdma_ctlr_destroy(cpsw->dma);
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
> index 8df9ce68696a..4004140fc4d0 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.h
> +++ b/drivers/net/ethernet/ti/cpsw_priv.h
> @@ -447,4 +447,7 @@ struct addr_sync_ctx {
>   	int flush;		/* flush flag */
>   };
>   
> +int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
> +		     int ale_ageout, u32 desc_mem_phys, int descs_pool_size);
> +
>   #endif /* DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_ */
> 
