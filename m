Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFDC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378D8217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbfDYHGQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:06:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:45380 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387648AbfDYHGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:06:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="340607711"
Received: from kmsmsx155.gar.corp.intel.com ([172.21.73.106])
  by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2019 00:06:13 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 KMSMSX155.gar.corp.intel.com ([169.254.15.135]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:06:08 +0800
From:   "Voon, Weifeng" <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Giuseppe Cavallaro" <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: RE: [PATCH 3/7] net: stmmac: dma channel control register need to
 be init first
Thread-Topic: [PATCH 3/7] net: stmmac: dma channel control register need to
 be init first
Thread-Index: AQHU+n51zHATXbnSNU2iG6YzCcFjoaZMdYag
Date:   Thu, 25 Apr 2019 07:06:08 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF098@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-4-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-4-git-send-email-weifeng.voon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2MyNGRmODktOGE2NC00MjU1LWE5OTUtODZlNTU3MjZlN2VlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYm1WVEo3V0NnbFVNNWJnSlBZUm1OZVRLcEdyblMyYU1TUUh6N3N1dFZYTU9hSGkyQ1BnaTdaSzI3Rnk1NXNVbSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> stmmac_init_chan() needs to be called before stmmac_init_rx_chan() and
> stmmac_init_tx_chan(). This is because if PBLx8 is to be used,
> "DMA_CH(#i)_Control.PBLx8" needs to be set before programming
> "DMA_CH(#i)_TX_Control.TxPBL" and "DMA_CH(#i)_RX_Control.RxPBL".
> 
> Reviewed-by: Zhang, Baoli <baoli.zhang@intel.com>
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a26e36d..ec031e3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2208,6 +2208,10 @@ static int stmmac_init_dma_engine(struct
> stmmac_priv *priv)
>  	if (priv->plat->axi)
>  		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
> 
> +	/* DMA CSR Channel configuration */
> +	for (chan = 0; chan < dma_csr_ch; chan++)
> +		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
> chan);
> +
>  	/* DMA RX Channel Configuration */
>  	for (chan = 0; chan < rx_channels_count; chan++) {
>  		rx_q = &priv->rx_queue[chan];
> @@ -2233,10 +2237,6 @@ static int stmmac_init_dma_engine(struct
> stmmac_priv *priv)
>  				       tx_q->tx_tail_addr, chan);
>  	}
> 
> -	/* DMA CSR Channel configuration */
> -	for (chan = 0; chan < dma_csr_ch; chan++)
> -		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
> chan);
> -
>  	return ret;
>  }
> 
> --
> 1.9.1

++ stmmac maintainers and c45 experts
