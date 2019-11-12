Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8590521783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UWM44IOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKLJla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:41:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41756 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfKLJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:41:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so17693422wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXiOCXbM4hw5/3nPee56/EdpSLE3wJqZQ92WaGPKTtA=;
        b=UWM44IOvoZ9FhoUnupZJm2BQFl/dP/dnwJFhgZo424WXsHGHlR39NSakhkIT3pjI5d
         rouMzU8HmYTqnhCPF95o2Pdiq7m2Up/zCcu+FT29Supvq7i13u4U7BXeVL1qYPDc1V0Z
         +H68aOS1wpGKLezfzj2xZS2Oq3a1Wokrx0ji1HFt2cxq9xAygKXdIaAH7RQjBdu3izjP
         8/0qq779rehuKgcaZfzwpmEaIPptoAmz20PkhPLjE4q3PF7l5+zVjWmIRLihq+6Ip1JA
         /NtYNCkFyfc1hpA6LMF+pLKh1pK8V1CP253GLqHEa7tboT+yEiUjpNxJrLoUgIuiH6ui
         fMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXiOCXbM4hw5/3nPee56/EdpSLE3wJqZQ92WaGPKTtA=;
        b=ukfSbkz1LdgQM7gm9IT/lYoLGa6QEfZVKSja1cCpW+0kKsFEkvO5hlKhm6G9b96cmh
         WBpbao4dYdNPbGezXD9C1Q8/bqwVUJBSLlsoXU5Kud6B+A3R21vfJKBcRuJJGS0ti1Pl
         W5KYgxuCzEj4VS7Ylb1N9K29ia7hQRqYzFB8QpTaDIFm65LEwGRsHvOl5sseC8deW/C2
         7h8wJ2C8lRvDkRXrHZGAaiEEGV9q+u7vV/K5FkPmam1omJkKEasSAV4jljLYsZBERwPA
         Mz27q2rhcbRJeuW7dmgYt4z8ahgdk8U/Z1hJ2JDlACIi99k2GL9WxBSYpD1rSDVk62oi
         P56A==
X-Gm-Message-State: APjAAAXltUUfAy1B+joAgnRD+GJV6oHSwQd4KM9rkyIPE7XA2Hpq4kfY
        e5t+g5iggVfkdRxYOhmcdodHOA==
X-Google-Smtp-Source: APXvYqy+zzcIPBiT2pyPQASExyEfhnKgezJ13Qq3+j6/2qXeVluF1V7SCkinvcEoerJDcqTtnHTcvA==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr23508130wrw.291.1573551687750;
        Tue, 12 Nov 2019 01:41:27 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id g5sm3573129wmf.37.2019.11.12.01.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 01:41:27 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:41:26 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Po Liu <po.liu@nxp.com>
Cc:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [net-next, 2/2] enetc: update TSN Qbv PSPEED set according to
 adjust link speed
Message-ID: <20191112094125.jhcwrf3eb3wonlfn@netronome.com>
References: <20191111042715.13444-1-Po.Liu@nxp.com>
 <20191111042715.13444-2-Po.Liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111042715.13444-2-Po.Liu@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:41:39AM +0000, Po Liu wrote:
> ENETC has a register PSPEED to indicate the link speed of hardware.
> It is need to update accordingly. PSPEED field needs to be updated
> with the port speed for QBV scheduling purposes. Or else there is
> chance for gate slot not free by frame taking the MAC if PSPEED and
> phy speed not match. So update PSPEED when link adjust. This is
> implement by the adjust_link.
> 
> Signed-off-by: Po Liu <Po.Liu@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Singed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 13 +++++--
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  7 ++++
>  .../net/ethernet/freescale/enetc/enetc_pf.c   |  3 ++
>  .../net/ethernet/freescale/enetc/enetc_qos.c  | 34 +++++++++++++++++++
>  4 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index d58dbc2c4270..f6b00c68451b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -742,9 +742,14 @@ void enetc_get_si_caps(struct enetc_si *si)
>  	si->num_rss = 0;
>  	val = enetc_rd(hw, ENETC_SIPCAPR0);
>  	if (val & ENETC_SIPCAPR0_RSS) {
> -		val = enetc_rd(hw, ENETC_SIRSSCAPR);
> -		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(val);
> +		u32 rss;
> +
> +		rss = enetc_rd(hw, ENETC_SIRSSCAPR);
> +		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
>  	}
> +
> +	if (val & ENETC_SIPCAPR0_QBV)
> +		si->hw_features |= ENETC_SI_F_QBV;
>  }
>  
>  static int enetc_dma_alloc_bdr(struct enetc_bdr *r, size_t bd_size)
> @@ -1314,8 +1319,12 @@ static void enetc_disable_interrupts(struct enetc_ndev_priv *priv)
>  
>  static void adjust_link(struct net_device *ndev)
>  {
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	struct phy_device *phydev = ndev->phydev;
>  
> +	if (priv->active_offloads & ENETC_F_QBV)
> +		enetc_sched_speed_set(ndev);
> +
>  	phy_print_status(phydev);
>  }
>  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 8676631041d5..e85e5301c578 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -118,6 +118,8 @@ enum enetc_errata {
>  	ENETC_ERR_UCMCSWP	= BIT(2),
>  };
>  
> +#define ENETC_SI_F_QBV  (1<<0)
> +
>  /* PCI IEP device data */
>  struct enetc_si {
>  	struct pci_dev *pdev;
> @@ -133,6 +135,7 @@ struct enetc_si {
>  	int num_fs_entries;
>  	int num_rss; /* number of RSS buckets */
>  	unsigned short pad;
> +	int hw_features;
>  };
>  
>  #define ENETC_SI_ALIGN	32
> @@ -173,6 +176,7 @@ struct enetc_cls_rule {
>  enum enetc_active_offloads {
>  	ENETC_F_RX_TSTAMP	= BIT(0),
>  	ENETC_F_TX_TSTAMP	= BIT(1),
> +	ENETC_F_QBV             = BIT(2),
>  };
>  
>  struct enetc_ndev_priv {
> @@ -188,6 +192,8 @@ struct enetc_ndev_priv {
>  	u16 msg_enable;
>  	int active_offloads;
>  
> +	u32 speed; /* store speed for compare update pspeed */

struct phy_device seems to use int for speed.
Perhaps that would be a more appropriate type here,
and likewise in enetc_sched_speed_set().

> +
>  	struct enetc_bdr *tx_ring[16];
>  	struct enetc_bdr *rx_ring[16];
>  
> @@ -246,3 +252,4 @@ int enetc_get_rss_table(struct enetc_si *si, u32 *table, int count);
>  int enetc_set_rss_table(struct enetc_si *si, const u32 *table, int count);
>  int enetc_send_cmd(struct enetc_si *si, struct enetc_cbd *cbd);
>  int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> +void enetc_sched_speed_set(struct net_device *ndev);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 7da79b816416..e7482d483b28 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -742,6 +742,9 @@ static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  
>  	ndev->priv_flags |= IFF_UNICAST_FLT;
>  
> +	if (si->hw_features & ENETC_SI_F_QBV)
> +		priv->active_offloads |= ENETC_F_QBV;
> +
>  	/* pick up primary MAC address from SI */
>  	enetc_get_primary_mac_addr(&si->hw, ndev->dev_addr);
>  }
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> index 036bb39c7a0b..801104dd2ba6 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> @@ -11,6 +11,40 @@ static u16 enetc_get_max_gcl_len(struct enetc_hw *hw)
>  		& ENETC_QBV_MAX_GCL_LEN_MASK;
>  }
>  
> +void enetc_sched_speed_set(struct net_device *ndev)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct phy_device *phydev = ndev->phydev;
> +	u32 old_speed = priv->speed;
> +	u32 speed, pspeed;
> +
> +	if (phydev->speed == old_speed)
> +		return;
> +
> +	speed = phydev->speed;
> +	switch (speed) {
> +	case SPEED_1000:
> +		pspeed = ENETC_PMR_PSPEED_1000M;
> +		break;
> +	case SPEED_2500:
> +		pspeed = ENETC_PMR_PSPEED_2500M;
> +		break;
> +	case SPEED_100:
> +		pspeed = ENETC_PMR_PSPEED_100M;
> +		break;
> +	case SPEED_10:
> +	default:
> +		pspeed = ENETC_PMR_PSPEED_10M;
> +		netdev_err(ndev, "Qbv PSPEED set speed link down.\n");
> +	}
> +
> +	priv->speed = speed;
> +	enetc_port_wr(&priv->si->hw, ENETC_PMR,
> +		      (enetc_port_rd(&priv->si->hw, ENETC_PMR)
> +		      & (~ENETC_PMR_PSPEED_MASK))
> +		      | pspeed);

The above two lines could be combined.

Also, the parentheses seem unnecessary.

> +}
> +
>  static int enetc_setup_taprio(struct net_device *ndev,
>  			      struct tc_taprio_qopt_offload *admin_conf)
>  {
> -- 
> 2.17.1
> 
