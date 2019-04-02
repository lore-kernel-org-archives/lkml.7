Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E24EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25406206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kMikncg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDBVz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:55:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47825 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDBVzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=B8I6TwpNRM8v2Uv9IGzfdHW5srY9j5y1ue0Au9dbRvc=; b=kMikncg7kkWw8nRXPjxEyeZvw2
        b0Y2g5iuc9qWZnJU49NH0fa4pdyq8kNrp2XIMN9dH/gloIBCZeyaLQe6LV7F9vvMYGD0UU30MXYIS
        sicnKSBVSwPnODkaeiVCOAoQXfY+fCdAMllAHSBotIeZGGhGuh04xm1pEqFkv2veULC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hBRNK-0001bM-EA; Tue, 02 Apr 2019 23:55:22 +0200
Date:   Tue, 2 Apr 2019 23:55:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
Subject: Re: [PATCH net-next 10/17] net: dsa: Introduce driver for NXP
 SJA1105 5-port L2 switch
Message-ID: <20190402215522.GJ22349@lunn.ch>
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-11-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331174232.22060-11-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int sja1105_init_mii_settings(struct sja1105_private *priv,
> +				     struct sja1105_dt_port *ports)
> +{
> +	struct device *dev = &priv->spidev->dev;
> +	struct sja1105_xmii_params_entry *mii;
> +	struct sja1105_table *table;
> +	int i;
> +
> +	table = &priv->static_config.tables[BLK_IDX_XMII_PARAMS];
> +
> +	/* Discard previous xMII Mode Parameters Table */
> +	if (table->entry_count) {
> +		kfree(table->entries);
> +		table->entry_count = 0;
> +	}
> +
> +	table->entries = kcalloc(MAX_XMII_PARAMS_COUNT,
> +				 table->ops->unpacked_entry_size, GFP_KERNEL);
> +	if (!table->entries)
> +		return -ENOMEM;
> +
> +	/* Override table based on phylib DT bindings */
> +	table->entry_count = MAX_XMII_PARAMS_COUNT;
> +
> +	mii = table->entries;
> +
> +	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
> +		switch (ports[i].phy_mode) {
> +		case PHY_INTERFACE_MODE_MII:
> +			mii->xmii_mode[i] = XMII_MODE_MII;
> +			break;
> +		case PHY_INTERFACE_MODE_RMII:
> +			mii->xmii_mode[i] = XMII_MODE_RMII;
> +			break;
> +		case PHY_INTERFACE_MODE_RGMII:
> +		case PHY_INTERFACE_MODE_RGMII_ID:
> +		case PHY_INTERFACE_MODE_RGMII_RXID:
> +		case PHY_INTERFACE_MODE_RGMII_TXID:
> +			mii->xmii_mode[i] = XMII_MODE_RGMII;
> +			break;

https://www.nxp.com/docs/en/data-sheet/SJA1105.pdf

Section 6.2.3 RGMII signaling and encoding

Note that RGMII requires an external delay of between 1.5 ns and 2 ns
on TXC and RXC.

So it sounds like the switch only supports PHY_INTERFACE_MODE_RGMII.

If the port is in MAC mode, you should pass this phy-mode to the PHY
when you connect to it. The PHY can then add the delay if needed.

If however, the port is in PHY mode, and it is asked to do RGMII other
than PHY_INTERFACE_MODE_RGMII, you should report an error. It cannot
do it.

   Andrew
