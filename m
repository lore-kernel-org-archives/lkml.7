Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9026C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B953320830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1TO5MgJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfCZJCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:02:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38555 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZJCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XDs/KgFUoInGdggOFdpVw6KfgNdSrenn9lgevu+Z1Es=; b=1TO5MgJTK4OrtlRJ6ljeCbwTvE
        8WR4Bw0VUSpUhktMG8ycD2EYJtYZL5zMK7k/H78dxpPT2qc5O5nMzFFGi0sPJHGq6x8hur31p3zi8
        Hw3/HookO1dhLeqjgUuXLvZ/18h4HOXKquusF+Oz179Gkru0QzsWdOgzXtPIGgXQBTos=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h8hxu-0000eo-Fl; Tue, 26 Mar 2019 10:01:50 +0100
Date:   Tue, 26 Mar 2019 10:01:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-ethernet: fix incorrect PHY mode
Message-ID: <20190326090150.GE31524@lunn.ch>
References: <20190325204801.7013-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325204801.7013-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void cvm_set_rgmii_delay(struct device_node *np, int iface, int port)
> +static void cvm_set_rgmii_delay(struct octeon_ethernet *priv, int iface,
> +				int port)
>  {
> +	struct device_node *np = priv->of_node;
>  	u32 delay_value;
> +	bool rx_delay;
> +	bool tx_delay;
>  
> -	if (!of_property_read_u32(np, "rx-delay", &delay_value))
> +	/* By default, both RX/TX delay is enabled in
> +	 * __cvmx_helper_rgmii_enable().
> +	 */
> +	rx_delay = true;
> +	tx_delay = true;
> +
> +	if (!of_property_read_u32(np, "rx-delay", &delay_value)) {
>  		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(port, iface), delay_value);
> -	if (!of_property_read_u32(np, "tx-delay", &delay_value))
> +		rx_delay = delay_value > 0;
> +	}
> +	if (!of_property_read_u32(np, "tx-delay", &delay_value)) {
>  		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(port, iface), delay_value);
> +		tx_delay = delay_value > 0;
> +	}
> +
> +	if (!rx_delay && !tx_delay)
> +		priv->phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
> +	else if (!rx_delay)
> +		priv->phy_mode = PHY_INTERFACE_MODE_RGMII_RXID;
> +	else if (!tx_delay)
> +		priv->phy_mode = PHY_INTERFACE_MODE_RGMII_TXID;
> +	else
> +		priv->phy_mode = PHY_INTERFACE_MODE_RGMII;

Humm, that is unique, as far as i know. Every other MAC driver uses
of_get_phy_mode() to get the value out of device tree. The proprietary
delay values can then be used to fine tune the basic delay setting
read from DT.

	Andrew
