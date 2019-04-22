Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F38C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EAB20693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xt+ZGRZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfDVNZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:25:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39776 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVNZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n84smHgC/Wc8uv7v7bbiG5OoOPCMtv9oaEVNA1pTPMk=; b=xt+ZGRZjS2yZXgPUZ79iPvAOmc
        GNkyK3iqMlWUQmAbv8hW3YCDZ3L23rPeoHLfpfeOI55yM160bwlrjMz4GKmYXnNOzf+ZW7M5SP3et
        XJ7sb/LSWB3+dwRlBvzGO0p8FX0rEF6zxpTEc5acrpaCplwP3liIDQcO5jCVU1K0rPEU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hIYwv-0003u9-Uh; Mon, 22 Apr 2019 15:25:33 +0200
Date:   Mon, 22 Apr 2019 15:25:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/3] net: ethernet: add ag71xx driver
Message-ID: <20190422132533.GA12718@lunn.ch>
References: <20190422064046.2822-1-o.rempel@pengutronix.de>
 <20190422064046.2822-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422064046.2822-4-o.rempel@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 08:40:46AM +0200, Oleksij Rempel wrote:
> +static int ag71xx_msg_enable = -1;
> +
> +module_param_named(msg_enable, ag71xx_msg_enable, uint,
> +		   (S_IRUSR|S_IRGRP|S_IROTH));
> +MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h for bitmap)");

Hi Oleksij

Module parameters are generally not liked.

Please use .set_msglevel.

> +static int ag71xx_mdio_mii_read(struct mii_bus *bus, int addr, int reg)
> +{
> +	struct ag71xx *ag = bus->priv;
> +	struct net_device *ndev = ag->ndev;
> +	int err;
> +	int ret;
> +
> +	err = ag71xx_mdio_wait_busy(ag);
> +	if (err)
> +		return 0xffff;
> +
> +	ag71xx_wr(ag, AG71XX_REG_MII_CMD, MII_CMD_WRITE);

It would be good to comment why you need this. Or is it a copy/paste
error?

> +	ag71xx_wr(ag, AG71XX_REG_MII_ADDR,
> +			((addr & 0xff) << MII_ADDR_SHIFT) | (reg & 0xff));
> +	ag71xx_wr(ag, AG71XX_REG_MII_CMD, MII_CMD_READ);
> +
> +	err = ag71xx_mdio_wait_busy(ag);
> +	if (err)
> +		return 0xffff;
> +
> +	ret = ag71xx_rr(ag, AG71XX_REG_MII_STATUS);
> +	ret &= 0xffff;
> +	ag71xx_wr(ag, AG71XX_REG_MII_CMD, MII_CMD_WRITE);

This one as well.

> +
> +	netif_dbg(ag, link, ndev, "mii_read: addr=%04x, reg=%04x, value=%04x\n",
> +		  addr, reg, ret);
> +
> +	return ret;
> +}
> +
> +static int ag71xx_mdio_mii_write(struct mii_bus *bus, int addr, int reg,
> +				 u16 val)
> +{
> +	struct ag71xx *ag = bus->priv;
> +	struct net_device *ndev = ag->ndev;
> +
> +	netif_dbg(ag, link, ndev, "mii_write: addr=%04x, reg=%04x, value=%04x\n",
> +		  addr, reg, val);
> +
> +	ag71xx_wr(ag, AG71XX_REG_MII_ADDR,
> +			((addr & 0xff) << MII_ADDR_SHIFT) | (reg & 0xff));
> +	ag71xx_wr(ag, AG71XX_REG_MII_CTRL, val);
> +
> +	ag71xx_mdio_wait_busy(ag);
> +
> +	return 0;

Return the -ETIMEOUT from ag71xx_mdio_wait_busy() please.

> +static int ag71xx_mdio_get_divider(struct ag71xx *ag, u32 *div)
> +{
> +	struct device *dev = &ag->pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct clk *ref_clk = of_clk_get(np, 0);
> +	unsigned long ref_clock;
> +	const u32 *table;
> +	int ndivs, i;
> +
> +	if (IS_ERR(ref_clk))
> +		return -EINVAL;
> +
> +	ref_clock = clk_get_rate(ref_clk);

I _think_ you need to prepare and enable the clock before you can use
clk_get_rate(). 

> +	clk_put(ref_clk);
> +
> +	if (ag71xx_is(ag, AR9330) || ag71xx_is(ag, AR9340)) {
> +		table = ar933x_mdio_div_table;
> +		ndivs = ARRAY_SIZE(ar933x_mdio_div_table);
> +	} else if (ag71xx_is(ag, AR7240)) {
> +		table = ar7240_mdio_div_table;
> +		ndivs = ARRAY_SIZE(ar7240_mdio_div_table);
> +	} else {
> +		table = ar71xx_mdio_div_table;
> +		ndivs = ARRAY_SIZE(ar71xx_mdio_div_table);
> +	}
> +
> +	for (i = 0; i < ndivs; i++) {
> +		unsigned long t;
> +
> +		t = ref_clock / table[i];
> +		if (t <= AG71XX_MDIO_MAX_CLK) {
> +			*div = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int ag71xx_mdio_reset(struct mii_bus *bus)
> +{
> +	struct ag71xx *ag = bus->priv;
> +	u32 t;
> +
> +	if (ag71xx_mdio_get_divider(ag, &t)) {
> +		if (ag71xx_is(ag, AR9340))
> +			t = MII_CFG_CLK_DIV_58;
> +		else
> +			t = MII_CFG_CLK_DIV_10;
> +	}

You should return the -ENOENT from ag71xx_mdio_get_divider().

> +
> +	ag71xx_wr(ag, AG71XX_REG_MII_CFG, t | MII_CFG_RESET);
> +	udelay(100);
> +
> +	ag71xx_wr(ag, AG71XX_REG_MII_CFG, t);
> +	udelay(100);
> +
> +	return 0;
> +}
> +
> +static int ag71xx_mdio_probe(struct ag71xx *ag)
> +{
> +	static struct mii_bus *mii_bus;
> +	struct device *dev = &ag->pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	int err;
> +
> +	ag->mii_bus = NULL;
> +
> +	/*
> +	 * On most (all?) Atheros/QCA SoCs dual eth interfaces are not equal.
> +	 *
> +	 * That is to say eth0 can not work independently. It only works
> +	 * when eth1 is working.
> +	 */

Please could you explain that some more? Is there just one MDIO bus
shared by two ethernet controllers? If so, it would be better to have
the MDIO bus controller as a separate driver.

> +	if ((ag->dcfg->quirks & AG71XX_ETH0_NO_MDIO) && !ag->mac_idx)
> +		return 0;
> +
> +	mii_bus = devm_mdiobus_alloc(dev);
> +	if (!mii_bus)
> +		return -ENOMEM;
> +
> +	ag->mdio_reset = of_reset_control_get_exclusive(np, "mdio");

Can this return -EPROBE_DEFFER? If so, you should return it.

> +
> +	mii_bus->name = "ag71xx_mdio";
> +	mii_bus->read = ag71xx_mdio_mii_read;
> +	mii_bus->write = ag71xx_mdio_mii_write;
> +	mii_bus->reset = ag71xx_mdio_reset;
> +	mii_bus->priv = ag;
> +	mii_bus->parent = dev;
> +	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
> +
> +	if (!IS_ERR(ag->mdio_reset)) {
> +		reset_control_assert(ag->mdio_reset);
> +		msleep(100);
> +		reset_control_deassert(ag->mdio_reset);
> +		msleep(200);
> +	}
> +
> +	err = of_mdiobus_register(mii_bus, np);
> +	if (err)
> +		return err;
> +
> +	ag->mii_bus = mii_bus;
> +
> +	return 0;
> +}


> +static void ag71xx_dma_reset(struct ag71xx *ag)
> +{
> +	u32 val;
> +	int i;
> +
> +
> +	/* stop RX and TX */
> +	ag71xx_wr(ag, AG71XX_REG_RX_CTRL, 0);
> +	ag71xx_wr(ag, AG71XX_REG_TX_CTRL, 0);
> +
> +	/*
> +	 * give the hardware some time to really stop all rx/tx activity
> +	 * clearing the descriptors too early causes random memory corruption
> +	 */
> +	mdelay(1);

This does not sounds too safe. Can you walk the descriptor rings to
know it has finished?

> +static unsigned char *ag71xx_speed_str(struct ag71xx *ag)
> +{
> +	switch (ag->speed) {
> +	case SPEED_1000:
> +		return "1000";
> +	case SPEED_100:
> +		return "100";
> +	case SPEED_10:
> +		return "10";
> +	}
> +
> +	return "?";
> +}

phy_speed_to_str()

> +
> +static void ag71xx_link_adjust(struct ag71xx *ag, bool update)
> +{
> +	struct net_device *ndev = ag->ndev;
> +	u32 cfg2;
> +	u32 ifctl;
> +	u32 fifo5;
> +
> +	if (!ag->link && update) {
> +		ag71xx_hw_stop(ag);
> +		netif_carrier_off(ag->ndev);
> +		netif_info(ag, link, ndev, "link down\n");
> +		return;
> +	}
> +
> +	if (!ag71xx_is(ag, AR7100) && !ag71xx_is(ag, AR9130))
> +		ag71xx_fast_reset(ag);
> +
> +	cfg2 = ag71xx_rr(ag, AG71XX_REG_MAC_CFG2);
> +	cfg2 &= ~(MAC_CFG2_IF_1000 | MAC_CFG2_IF_10_100 | MAC_CFG2_FDX);
> +	cfg2 |= (ag->duplex) ? MAC_CFG2_FDX : 0;
> +
> +	ifctl = ag71xx_rr(ag, AG71XX_REG_MAC_IFCTL);
> +	ifctl &= ~(MAC_IFCTL_SPEED);
> +
> +	fifo5 = ag71xx_rr(ag, AG71XX_REG_FIFO_CFG5);
> +	fifo5 &= ~FIFO_CFG5_BM;
> +
> +	switch (ag->speed) {
> +	case SPEED_1000:
> +		cfg2 |= MAC_CFG2_IF_1000;
> +		fifo5 |= FIFO_CFG5_BM;
> +		break;
> +	case SPEED_100:
> +		cfg2 |= MAC_CFG2_IF_10_100;
> +		ifctl |= MAC_IFCTL_SPEED;
> +		break;
> +	case SPEED_10:
> +		cfg2 |= MAC_CFG2_IF_10_100;
> +		break;
> +	default:
> +		BUG();

Please don't use BUG(). That kills the machine. WARN().

> +		return;
> +	}
> +
> +	if (ag->tx_ring.desc_split) {
> +		ag->fifodata[2] &= 0xffff;
> +		ag->fifodata[2] |= ((2048 - ag->tx_ring.desc_split) / 4) << 16;
> +	}
> +
> +	ag71xx_wr(ag, AG71XX_REG_FIFO_CFG3, ag->fifodata[2]);
> +
> +	ag71xx_wr(ag, AG71XX_REG_MAC_CFG2, cfg2);
> +	ag71xx_wr(ag, AG71XX_REG_FIFO_CFG5, fifo5);
> +	ag71xx_wr(ag, AG71XX_REG_MAC_IFCTL, ifctl);
> +
> +	ag71xx_hw_start(ag);
> +
> +	netif_carrier_on(ag->ndev);

You should not need to do anything with the carrier. phylib will do
all that for you.

> +	if (update)
> +		netif_info(ag, link, ndev, "link up (%sMbps/%s duplex)\n",
> +			   ag71xx_speed_str(ag),
> +			   (DUPLEX_FULL == ag->duplex) ? "Full" : "Half");

phy_print_status() is the standard way to do this.

> +}
> +
> +static void ag71xx_phy_link_adjust(struct net_device *ndev)
> +{
> +	struct ag71xx *ag = netdev_priv(ndev);
> +	struct phy_device *phydev = ag->phy_dev;
> +	unsigned long flags;
> +	int status_change = 0;
> +
> +	spin_lock_irqsave(&ag->lock, flags);
> +
> +	if (phydev->link) {
> +		if (ag->duplex != phydev->duplex
> +		    || ag->speed != phydev->speed) {
> +			status_change = 1;
> +		}
> +	}
> +
> +	if (phydev->link != ag->link)
> +		status_change = 1;
> +
> +	ag->link = phydev->link;
> +	ag->duplex = phydev->duplex;
> +	ag->speed = phydev->speed;

It appears you always have some sort of PHY attached, either a real
PHY, or a fixed link. So you can probably simply this, remove
ap->link, ap->dupex, ap->speed, and just get it from phydev when you
need it.

> +
> +	if (status_change)
> +		ag71xx_link_adjust(ag, true);
> +
> +	spin_unlock_irqrestore(&ag->lock, flags);

You are doing a lot of stuff while holding this spinlock. What exactly
are you protecting?

> +}
> +
> +static int ag71xx_phy_connect(struct ag71xx *ag)
> +{
> +	struct device_node *np = ag->pdev->dev.of_node;
> +	struct net_device *ndev = ag->ndev;
> +	struct device_node *phy_node;
> +	int ret;
> +
> +	if (of_phy_is_fixed_link(np)) {
> +		ret = of_phy_register_fixed_link(np);
> +		if (ret < 0) {
> +			netif_err(ag, probe, ndev, "Failed to register fixed PHY link: %d\n",
> +				  ret);
> +			return ret;
> +		}
> +
> +		phy_node = of_node_get(np);
> +	} else {
> +		phy_node = of_parse_phandle(np, "phy-handle", 0);
> +	}
> +
> +	if (!phy_node) {
> +		netif_err(ag, probe, ndev, "Could not find valid phy node\n");
> +		return -ENODEV;
> +	}
> +
> +	ag->phy_dev = of_phy_connect(ag->ndev, phy_node, ag71xx_phy_link_adjust,
> +				     0, ag->phy_if_mode);

ndev->phydev. No need to place it in the private structure.

> +
> +	of_node_put(phy_node);
> +
> +	if (!ag->phy_dev) {
> +		netif_err(ag, probe, ndev, "Could not connect to PHY device\n");
> +		return -ENODEV;
> +	}
> +
> +	phy_attached_info(ag->phy_dev);
> +
> +	return 0;
> +}
> +
> +static int ag71xx_open(struct net_device *ndev)
> +{
> +	struct ag71xx *ag = netdev_priv(ndev);
> +	unsigned int max_frame_len;
> +	int ret;
> +
> +	netif_carrier_off(ndev);
> +	max_frame_len = ag71xx_max_frame_len(ndev->mtu);
> +	ag->rx_buf_size = SKB_DATA_ALIGN(max_frame_len + NET_SKB_PAD + NET_IP_ALIGN);
> +
> +	/* setup max frame length */
> +	ag71xx_wr(ag, AG71XX_REG_MAC_MFL, max_frame_len);
> +	ag71xx_hw_set_macaddr(ag, ndev->dev_addr);
> +
> +	ret = ag71xx_hw_enable(ag);
> +	if (ret)
> +		goto err;
> +
> +	ret = ag71xx_phy_connect(ag);
> +	if (ret)
> +		goto err;
> +
> +	phy_start(ag->phy_dev);
> +
> +	return 0;
> +
> +err:
> +	ag71xx_rings_cleanup(ag);
> +	return ret;
> +}
> +
> +static int ag71xx_stop(struct net_device *ndev)
> +{
> +	struct ag71xx *ag = netdev_priv(ndev);
> +
> +	phy_stop(ag->phy_dev);
> +	ag71xx_hw_disable(ag);
> +

open() does the phy_connect, so close should do the phy_disconnect.

> +	return 0;
> +}
> +
> +static int ag71xx_do_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
> +{
> +	struct ag71xx *ag = netdev_priv(ndev);
> +
> +	switch (cmd) {
> +	case SIOCSIFHWADDR:
> +		if (copy_from_user
> +			(ndev->dev_addr, ifr->ifr_data, sizeof(ndev->dev_addr)))
> +			return -EFAULT;
> +		return 0;
> +
> +	case SIOCGIFHWADDR:
> +		if (copy_to_user
> +			(ifr->ifr_data, ndev->dev_addr, sizeof(ndev->dev_addr)))
> +			return -EFAULT;
> +		return 0;

The core code should handle this for you, dev_ifsioc_locked().

> +
> +	case SIOCGMIIPHY:
> +	case SIOCGMIIREG:
> +	case SIOCSMIIREG:
> +		if (ag->phy_dev == NULL)
> +			break;

It is more normal to just do

        if (ndev->phydev)
                return phy_mii_ioctl(ndev->phydev, req, cmd);

Out side of the switch statement.

> +
> +		return phy_mii_ioctl(ag->phy_dev, ifr, cmd);
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +

  Andrew
