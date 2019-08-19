Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCE622CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MWtSopOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfHSU3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:29:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4862 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfHSU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:29:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5b069d0000>; Mon, 19 Aug 2019 13:29:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Aug 2019 13:29:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Aug 2019 13:29:18 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 20:29:17 +0000
Received: from [10.2.167.147] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 20:29:16 +0000
Subject: Re: [PATCH 10/14] serial: tegra: add support to use 8 bytes trigger
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shardar Shariff Md" <smohammed@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-11-git-send-email-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <dda0d866-ae7a-8655-7b26-4c28249c0be8@nvidia.com>
Date:   Mon, 19 Aug 2019 21:29:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565609303-27000-11-git-send-email-kyarlagadda@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566246557; bh=WyjGFMCx57IDIkIARHgc/p/3DlhW1CTKBnwe7XnjJY8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MWtSopOR49l87pUtrMYz3a1WgQUITI3/vrtW8PIEM/d5lyR+MgP4+2FviE+v2getX
         wwB9d+NUWSNlhdaU2fl9UMMKBbvYsVUmUvwx8LZX/J8UIlUXZs9wegKw6spKfCrNTm
         /j8xTB3QrqedefG4bJivLueowAphXQWodyuHfeCOaL34j1Hc/OuPqDveB+mu0pL8Bg
         mjhkk8FX0vGA8SjBFN8Op5/wgpFAyU+j3k0suK9tqWDoSSzXht1dSqIrvtG9UjVBi4
         tuxb4KWAWcEvJxuNDnumqfJ8oVUVcW0DOPjS2qvwP36OQOh4YNfn/piFxOabaEHYfc
         uUtxMU13PRwCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/08/2019 12:28, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
> 
> Add support to use 8 bytes trigger for Tegra186 SOC.
> 
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index 329923c..03d1d20 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -88,6 +88,7 @@ struct tegra_uart_chip_data {
>  	bool	support_clk_src_div;
>  	bool	fifo_mode_enable_status;
>  	int	uart_max_port;
> +	int	dma_burst_bytes;

I assume that this is a maximum, so why not say max_dma_burst_bytes?

>  };
>  
>  struct tegra_uart_port {
> @@ -933,7 +934,12 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
>  	 * programmed in the DMA registers.
>  	 */
>  	tup->fcr_shadow = UART_FCR_ENABLE_FIFO;
> -	tup->fcr_shadow |= UART_FCR_R_TRIG_01;
> +
> +	if (tup->cdata->dma_burst_bytes == 8)
> +		tup->fcr_shadow |= UART_FCR_R_TRIG_10;
> +	else
> +		tup->fcr_shadow |= UART_FCR_R_TRIG_01;
> +
>  	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
>  	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
>  
> @@ -1046,7 +1052,7 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
>  		}
>  		dma_sconfig.src_addr = tup->uport.mapbase;
>  		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> -		dma_sconfig.src_maxburst = 4;
> +		dma_sconfig.src_maxburst = tup->cdata->dma_burst_bytes;
>  		tup->rx_dma_chan = dma_chan;
>  		tup->rx_dma_buf_virt = dma_buf;
>  		tup->rx_dma_buf_phys = dma_phys;
> @@ -1325,6 +1331,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
>  	.support_clk_src_div		= false,
>  	.fifo_mode_enable_status	= false,
>  	.uart_max_port			= 5,
> +	.dma_burst_bytes		= 4,

Isn't it simpler to store the TRIG value here?

Jon

-- 
nvpublic
