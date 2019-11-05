Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6C0C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A7217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b450AcR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbfKETO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:14:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38902 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390526AbfKETOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:14:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so9976907plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 11:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TptDIMYHBsCDqy+HkL6V+b/bHQZLC29YDFuLacz6Ro0=;
        b=b450AcR6dSpamN1nXnsy7DXmH8RMmViL1wdAaDgMNZt3VbLPDMgpUfYogPiwrAmkSb
         mQxIX23t5RKrFdiLQLHmFz9Bq0vIVjRymITw54zL1jaxMUQ5DkyL37cJfC7/ApUbcbXn
         wC7VI+ZeVbRYsY4N/pj+YGYWXzfz2jxCtvNiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TptDIMYHBsCDqy+HkL6V+b/bHQZLC29YDFuLacz6Ro0=;
        b=ULUE6Q95lpxvIgBv5C3QSwnIa52zZurgGDEcFG11kNL5AvIGeVjJJLJPqoO22wglEL
         ul0vfsrw0gugxEk74/nw7Y1WhKabCPdJ6o3obqCuDwkjDdoRj4qrkjVKkKPnucySWtaY
         JNkpWydBLdu3HQAilVy6g2tAhK0lUaXg782M7D6mZFTKN1CAS1vYT/Cy5p9I7f975Xzj
         K5oaY9am+bv5mWlh1ZKQ9sf55SeGuThPv7TNUA0Ax58v/D9ZZSS2oLJDA3F0ZhTQtR+L
         CDoycbFy78JHMeFBJGEQ32TQLjl+hcmeIu0hA9HRp1N5lcvmILh+KHQE+PnrAYLGo2Kr
         oLmQ==
X-Gm-Message-State: APjAAAU2IgQMWhjihFJmWI2o6K32svCDsj0ZSAvAEEq8jPXuYa+4AXzw
        Pcs+Wksg+ZVH5eAmAR0K7cNg4PSSN8Y7xjG5FG25HUj7jOewS3+UgOmITJRbHi7bJ7UlxBFYquL
        mKFTpddj8H9ZVABnOdBYsCo/VBAclbeExHy3W2bN9jcpeyqR/Rpsp3n//5ysTQgpXFeAEDxPHgu
        MNAVBg2BUlItU=
X-Google-Smtp-Source: APXvYqxzd6Kyq1UsO+18jc2l+8uJZlLtakGiCMyYhIJQn7st3RvsOeEF1c+R5w1wjEmPFCUFaHh/7A==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr33961423pld.71.1572981262428;
        Tue, 05 Nov 2019 11:14:22 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e26sm24517125pgb.48.2019.11.05.11.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 11:14:21 -0800 (PST)
Subject: Re: [PATCH net 1/3] net: bcmgenet: use RGMII loopback for MAC reset
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1572980846-37707-1-git-send-email-opendmb@gmail.com>
 <1572980846-37707-2-git-send-email-opendmb@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8c5c8028-a897-bf70-95ba-a1ffc8b68264@broadcom.com>
Date:   Tue, 5 Nov 2019 11:14:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572980846-37707-2-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 2019-11-05 11:07 a.m., Doug Berger wrote:
> As noted in commit 28c2d1a7a0bf ("net: bcmgenet: enable loopback
> during UniMAC sw_reset") the UniMAC must be clocked while sw_reset
> is asserted for its state machines to reset cleanly.
>
> The transmit and receive clocks used by the UniMAC are derived from
> the signals used on its PHY interface. The bcmgenet MAC can be
> configured to work with different PHY interfaces including MII,
> GMII, RGMII, and Reverse MII on internal and external interfaces.
> Unfortunately for the UniMAC, when configured for MII the Tx clock
> is always driven from the PHY which places it outside of the direct
> control of the MAC.
>
> The earlier commit enabled a local loopback mode within the UniMAC
> so that the receive clock would be derived from the transmit clock
> which addressed the observed issue with an external GPHY disabling
> it's Rx clock. However, when a Tx clock is not available this
> loopback is insufficient.
>
> This commit implements a workaround that leverages the fact that
> the MAC can reliably generate all of its necessary clocking by
> enterring the external GPHY RGMII interface mode with the UniMAC in
> local loopback during the sw_reset interval. Unfortunately, this
> has the undesirable side efect of the RGMII GTXCLK signal being
> driven during the same window.
>
> In most configurations this is a benign side effect as the signal
> is either not routed to a pin or is already expected to drive the
> pin. The one exception is when an external MII PHY is expected to
> drive the same pin with its TX_CLK output creating output driver
> contention.
>
> This commit exploits the IEEE 802.3 clause 22 standard defined
> isolate mode to force an external MII PHY to present a high
> impedance on its TX_CLK output during the window to prevent any
> contention at the pin.
>
> The MII interface is used internally with the 40nm internal EPHY
> which agressively disables its clocks for power savings leading to
> incomplete resets of the UniMAC and many instabilities observed
> over the years. The workaround of this commit is expected to put
> an end to those problems.
>
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>   drivers/net/ethernet/broadcom/genet/bcmgenet.c |  2 --
>   drivers/net/ethernet/broadcom/genet/bcmmii.c   | 33 ++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 0f138280315a..a1776ed8d7a1 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -1996,8 +1996,6 @@ static void reset_umac(struct bcmgenet_priv *priv)
>   
>   	/* issue soft reset with (rg)mii loopback to ensure a stable rxclk */
>   	bcmgenet_umac_writel(priv, CMD_SW_RESET | CMD_LCL_LOOP_EN, UMAC_CMD);
> -	udelay(2);
> -	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
>   }
>   
>   static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> index 17bb8d60a157..fcd181ae3a7d 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> @@ -221,8 +221,38 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
>   	const char *phy_name = NULL;
>   	u32 id_mode_dis = 0;
>   	u32 port_ctrl;
> +	int bmcr = -1;
> +	int ret;
>   	u32 reg;
>   
> +	/* MAC clocking workaround during reset of umac state machines */
> +	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
> +	if (reg & CMD_SW_RESET) {
> +		/* An MII PHY must be isolated to prevent TXC contention */
> +		if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
> +			ret = phy_read(phydev, MII_BMCR);
> +			if (ret >= 0) {
> +				bmcr = ret;
> +				ret = phy_write(phydev, MII_BMCR,
> +						bmcr | BMCR_ISOLATE);
> +			}
> +			if (ret) {
> +				netdev_err(dev, "failed to isolate PHY\n");
> +				return ret;
> +			}
> +		}
> +		/* Switch MAC clocking to RGMII generated clock */
> +		bcmgenet_sys_writel(priv, PORT_MODE_EXT_GPHY, SYS_PORT_CTRL);
> +		/* Ensure 5 clks with Rx disabled
> +		 * followed by 5 clks with Reset asserted
> +		 */
> +		udelay(4);
How do these magic delays work, they are different values?
In one case you have a udelay(4) to ensure rx disabled for 5 clks.
Yet below you have a udelay(2) to ensure 4 more clocks?
> +		reg &= ~(CMD_SW_RESET | CMD_LCL_LOOP_EN);
> +		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
> +		/* Ensure 5 more clocks before Rx is enabled */
> +		udelay(2);
> +	}
> +
>   	priv->ext_phy = !priv->internal_phy &&
>   			(priv->phy_interface != PHY_INTERFACE_MODE_MOCA);
>   
> @@ -254,6 +284,9 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
>   		phy_set_max_speed(phydev, SPEED_100);
>   		bcmgenet_sys_writel(priv,
>   				    PORT_MODE_EXT_EPHY, SYS_PORT_CTRL);
> +		/* Restore the MII PHY after isolation */
> +		if (bmcr >= 0)
> +			phy_write(phydev, MII_BMCR, bmcr);
>   		break;
>   
>   	case PHY_INTERFACE_MODE_REVMII:

