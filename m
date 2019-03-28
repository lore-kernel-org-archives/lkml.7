Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5832173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS6pyS9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfC1UJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:09:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39526 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfC1UJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:09:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so650328wrn.6;
        Thu, 28 Mar 2019 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vcpn2Ue2n4mV8I8pzZBhW0jbgNjO9NWjtIKQDZafjyA=;
        b=dS6pyS9TmjDbuTqGq98rqp/SBNrfpWBfCfg8p8nJcjOOUd7DExqZo+ktSSUTmt4jUA
         X3MSd06FS/goOP7Zmcvq588rpLmOxW0RCZWyqkx3ELXxt/ZhfbjJDhJ0RSvqyuOwFAD0
         XlyvLEOaUBzRQ+9mhmhnwimzW/R4yflMVJ6e5egGVMdbF/eA3MqOgD5x2XjxRNBLUOan
         kabbEIxHGDFUZbLpyj4quEN2crAKVppjkUoPdVZ0urnaDxDq9d917a2s+3C8SwDvjpdI
         E8YuxMLqqqIWJ5mpREQ//EZM3S/Jz+OdNbWqcS47g0tSJp9DyM7SoWYtwUsxz2ed2DV1
         8mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vcpn2Ue2n4mV8I8pzZBhW0jbgNjO9NWjtIKQDZafjyA=;
        b=tuXrnBc2tTb09s7vOVe7Rph7l+/gKk7VoXG/jh8RhF76u42ZGCq98TIA1loJN8QBPF
         VShyb/l2G/fc4IMM2oOGpiWd9HE7k6/+Yq7yyj2e/eYcSR9Z5eoPdP+fWjgpr/E4Z60q
         1M9opQ1T0K2AfL5GTw31/XlBK2T6/naTl5gCrMeKKjrmuFDh0zwDmTOuLHb6sNKCbfFA
         mKeY1TRd3t3bYNDcSkT1Lek0U+uBBlVloyNUky9K2DvAmCp2n3KZ9F+mU9tHX2BZyF5i
         LLSxhEMShC39d5Z2/PsjUWn27qVKhzpwm7T3Ty7x2TAkps71JH2/XXJZAiBQFXBoe88s
         kFzA==
X-Gm-Message-State: APjAAAUi2OEeL+aRGU681CZgmMsXZOfRU/d2nyuw4+MVxcpRfdIascgE
        zAdDo2OLMHWU6QB1rtZoqsA=
X-Google-Smtp-Source: APXvYqzt7FnfXuuCbQjdDc5lrU1o5lKcF7ErPB/e7y/SMhAGl/SVkgMhLr/lFx8QZM4/zoPg59N6Tg==
X-Received: by 2002:adf:ee0e:: with SMTP id y14mr11490539wrn.21.1553803745338;
        Thu, 28 Mar 2019 13:09:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc4:dc00:347a:eb2e:ca45:166d? (p200300EA8BC4DC00347AEB2ECA45166D.dip0.t-ipconnect.de. [2003:ea:8bc4:dc00:347a:eb2e:ca45:166d])
        by smtp.googlemail.com with ESMTPSA id v14sm65192wrr.20.2019.03.28.13.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:09:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] net: phy: mscc: add support for VSC8514 PHY
To:     Kavyasree.Kotagiri@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quentin.schulz@bootlin.com
References: <20190328054253.10016-1-kavyasree.kotagiri@microchip.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <cdaffafd-7be6-9f74-72d3-1cf74fa2d6a4@gmail.com>
Date:   Thu, 28 Mar 2019 21:08:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328054253.10016-1-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.03.2019 06:43, Kavyasree.Kotagiri@microchip.com wrote:
> From: Kavya Sree <kavyasree.kotagiri@microchip.com>
> 
> From: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
> 
> The VSC8514 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
> 1000BASE-X, can communicate with the MAC via QSGMII.
> The MAC interface protocol for each port within QSGMII can
> be either 1000BASE-X or SGMII, if the QSGMII MAC that the VSC8514 is
> connecting to supports this functionality.
> VSC8514 also supports SGMII MAC-side autonegotiation on each individual
> port, downshifting, can set the blinking pattern of each of its 4 LEDs,
> SyncE, 1000BASE-T Ring Resiliency as well as HP Auto-MDIX detection.
> 
> This adds support for 10BASE-T, 100BASE-TX, and 1000BASE-T,
> QSGMII link with the MAC, downshifting, HP Auto-MDIX detection
> and blinking pattern for its 4 LEDs.
> 
> The GPIO register bank is a set of registers that are common to all PHYs
> in the package. So any modification in any register of this bank affects
> all PHYs of the package.
> 
> If the PHYs haven't been reset before booting the Linux kernel and were
> configured to use interrupts for e.g. link status updates, it is
> required to clear the interrupts mask register of all PHYs before being
> able to use interrupts with any PHY. The first PHY of the package that
> will be init will take care of clearing all PHYs interrupts mask
> registers. Thus, we need to keep track of the init sequence in the
> package, if it's already been done or if it's to be done.
> 
> Most of the init sequence of a PHY of the package is common to all PHYs
> in the package, thus we use the SMI broadcast feature which enables us
> to propagate a write in one register of one PHY to all PHYs in the same
> package.
> 
> Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Co-developed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
> 
> Changes in v2:
> - Sorted varible declarations.
> 
>  drivers/net/phy/Kconfig |   2 +-
>  drivers/net/phy/mscc.c  | 381 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 382 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3d187cd50eb0..17d022e5d8f6 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -382,7 +382,7 @@ config MICROCHIP_T1_PHY
>  config MICROSEMI_PHY
>  	tristate "Microsemi PHYs"
>  	---help---
> -	  Currently supports VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
> +	  Currently supports VSC8514, VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
>  
>  config NATIONAL_PHY
>  	tristate "National Semiconductor PHYs"
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index db50efb30df5..940087b82b78 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -85,12 +85,29 @@ enum rgmii_rx_clock_delay {
>  #define LED_MODE_SEL_MASK(x)		  (GENMASK(3, 0) << LED_MODE_SEL_POS(x))
>  #define LED_MODE_SEL(x, mode)		  (((mode) << LED_MODE_SEL_POS(x)) & LED_MODE_SEL_MASK(x))
>  
> +#define MSCC_EXT_PAGE_CSR_CNTL_17           17
> +#define MSCC_EXT_PAGE_CSR_CNTL_18           18
> +
> +#define MSCC_EXT_PAGE_CSR_CNTL_19           19
> +#define MSCC_PHY_CSR_CNTL_19_REG_ADDR(x)    (x)
> +#define MSCC_PHY_CSR_CNTL_19_TARGET(x)      ((x) << 12)

Using the macros from bitfield.h may be an alternative.
But it's not a must here.

> +#define MSCC_PHY_CSR_CNTL_19_READ           BIT(14)
> +#define MSCC_PHY_CSR_CNTL_19_CMD            BIT(15)
> +
> +#define MSCC_EXT_PAGE_CSR_CNTL_20           20
> +#define MSCC_PHY_CSR_CNTL_20_TARGET(x)      (x)
> +
> +#define PHY_MCB_TARGET                    0x07
> +#define PHY_MCB_S6G_WRITE                 0x80000000
> +#define PHY_MCB_S6G_READ                  0x40000000
> +
Any specific reason why you don't use BIT(x) here?

>  #define MSCC_EXT_PAGE_ACCESS		  31
>  #define MSCC_PHY_PAGE_STANDARD		  0x0000 /* Standard registers */
>  #define MSCC_PHY_PAGE_EXTENDED		  0x0001 /* Extended registers */
>  #define MSCC_PHY_PAGE_EXTENDED_2	  0x0002 /* Extended reg - page 2 */
>  #define MSCC_PHY_PAGE_EXTENDED_3	  0x0003 /* Extended reg - page 3 */
>  #define MSCC_PHY_PAGE_EXTENDED_4	  0x0004 /* Extended reg - page 4 */
> +#define MSCC_PHY_PAGE_CSR_CNTL		  MSCC_PHY_PAGE_EXTENDED_4
>  /* Extended reg - GPIO; this is a bank of registers that are shared for all PHYs
>   * in the same package.
>   */
> @@ -216,6 +233,7 @@ enum rgmii_rx_clock_delay {
>  #define MSCC_PHY_TR_MSB			  18
>  
>  /* Microsemi PHY ID's */
> +#define PHY_ID_VSC8514			  0x00070670
>  #define PHY_ID_VSC8530			  0x00070560
>  #define PHY_ID_VSC8531			  0x00070570
>  #define PHY_ID_VSC8540			  0x00070760
> @@ -1742,6 +1760,319 @@ static int vsc8584_did_interrupt(struct phy_device *phydev)
>  	return (rc < 0) ? 0 : rc & MII_VSC85XX_INT_MASK_MASK;
>  }
>  
> +static int vsc8514_config_pre_init(struct phy_device *phydev)
> +{
> +	const struct reg_val pre_init1[] = {
> +		{0x0f90, 0x00688980},
> +		{0x0786, 0x00000003},
> +		{0x07fa, 0x0050100f},
> +		{0x0f82, 0x0012b002},
> +		{0x1686, 0x00000004},
> +		{0x168c, 0x00d2c46f},
> +		{0x17a2, 0x00000620},
> +		{0x16a0, 0x00eeffdd},
> +		{0x16a6, 0x00071448},
> +		{0x16a4, 0x0013132f},
> +		{0x16a8, 0x00000000},
> +		{0x0ffc, 0x00c0a028},
> +		{0x0fe8, 0x0091b06c},
> +		{0x0fea, 0x00041600},
> +		{0x0f80, 0x00fffaff},
> +		{0x0fec, 0x00901809},
> +		{0x0ffe, 0x00b01007},
> +		{0x16b0, 0x00eeff00},
> +		{0x16b2, 0x00007000},
> +		{0x16b4, 0x00000814},

An explanation where this magic comes from and what it does would be
helpful.

> +	};
> +	unsigned int i;
> +	u16 reg;
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
> +
> +	/* all writes below are broadcasted to all PHYs in the same package */
> +	reg = phy_base_read(phydev, MSCC_PHY_EXT_CNTL_STATUS);
> +	reg |= SMI_BROADCAST_WR_EN;
> +	phy_base_write(phydev, MSCC_PHY_EXT_CNTL_STATUS, reg);
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
> +
> +	reg = phy_base_read(phydev, MSCC_PHY_TEST_PAGE_8);
> +	reg |= 0x8000;

Use BIT(15) here?

> +	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_8, reg);
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
> +
> +	for (i = 0; i < ARRAY_SIZE(pre_init1); i++)
> +		vsc8584_csr_write(phydev, pre_init1[i].reg, pre_init1[i].val);
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
> +
> +	reg = phy_base_read(phydev, MSCC_PHY_TEST_PAGE_8);
> +	reg &= ~0x8000;

Same as comment before.

> +	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_8, reg);
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
> +
> +	reg = phy_base_read(phydev, MSCC_PHY_EXT_CNTL_STATUS);
> +	reg &= ~SMI_BROADCAST_WR_EN;
> +	phy_base_write(phydev, MSCC_PHY_EXT_CNTL_STATUS, reg);
> +
> +	return 0;
> +}
> +
> +static u32 vsc85xx_csr_ctrl_phy_read(struct phy_device *phydev,
> +				     u32 target, u32 reg)
> +{
> +	unsigned long deadline;
> +	u32 val, val_l, val_h;
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_CSR_CNTL);
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_20,
> +		       MSCC_PHY_CSR_CNTL_20_TARGET(target >> 2));
> +
> +	if (target >> 2 == 0x1)
> +		/* non-MACsec access */
> +		target &= 0x3;
> +	else
> +		target = 0;
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_19,
> +		       MSCC_PHY_CSR_CNTL_19_CMD | MSCC_PHY_CSR_CNTL_19_READ |
> +		       MSCC_PHY_CSR_CNTL_19_REG_ADDR(reg) |
> +		       MSCC_PHY_CSR_CNTL_19_TARGET(target));
> +
> +	deadline = jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
> +	do {
> +		val = phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_19);

Maybe use a delay here?

> +	} while (time_before(jiffies, deadline) &&
> +		!(val & MSCC_PHY_CSR_CNTL_19_CMD));
> +
Shouldn't a timeout be somehow handled?

> +	val_l = phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_17);
> +	val_h = phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_18);
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
> +		       MSCC_PHY_PAGE_STANDARD);
> +
> +	return (val_h << 16) | val_l;
> +}
> +
> +static void vsc85xx_csr_ctrl_phy_write(struct phy_device *phydev,
> +				       u32 target, u32 reg, u32 val)
> +{
> +	unsigned long deadline;
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_CSR_CNTL);
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_20,
> +		       MSCC_PHY_CSR_CNTL_20_TARGET(target >> 2));
> +
> +	if ((target >> 2 == 0x1) || (target >> 2 == 0x3))
> +		target &= 0x3;
> +	else
> +		/* MACsec access */
> +		target = 0;
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_17, (u16)val);
> +	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_18, (u16)(val >> 16));
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_CSR_CNTL_19,
> +		       MSCC_PHY_CSR_CNTL_19_CMD |
> +		       MSCC_PHY_CSR_CNTL_19_REG_ADDR(reg) |
> +		       MSCC_PHY_CSR_CNTL_19_TARGET(target));
> +
> +	deadline = jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
> +	do {
> +		val = phy_base_read(phydev, MSCC_EXT_PAGE_CSR_CNTL_19);
> +	} while (time_before(jiffies, deadline) &&
> +		 !(val & MSCC_PHY_CSR_CNTL_19_CMD));
> +
See previous comments.

> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
> +		       MSCC_PHY_PAGE_STANDARD);
> +}
> +
> +static int __phy_write_mcb_s6g(struct phy_device *phydev, u32 reg, u8 mcb,
> +			       u32 op)
> +{
> +	unsigned long deadline;
> +	u32 val;
> +
> +	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, reg, op |
> +				   (1 << mcb));
> +
> +	deadline = jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
> +	do {
> +		val = vsc85xx_csr_ctrl_phy_read(phydev, PHY_MCB_TARGET, reg);

Same regarding the delay.

> +	} while (time_before(jiffies, deadline) && (val & op));
> +
> +	if (val & op)
> +		return -ETIMEDOUT;
> +
Here you handle a timeout, why not in the other cases?

> +	return 0;
> +}
> +
> +/* vtss_phy_mcb_rd_trig_private */
> +static int phy_update_mcb_s6g(struct phy_device *phydev, u32 reg, u8 mcb)
> +{
> +	return __phy_write_mcb_s6g(phydev, reg, mcb, PHY_MCB_S6G_READ);
> +}
> +
> +/* vtss_phy_mcb_wr_trig_private */
> +static int phy_commit_mcb_s6g(struct phy_device *phydev, u32 reg, u8 mcb)
> +{
> +	return __phy_write_mcb_s6g(phydev, reg, mcb, PHY_MCB_S6G_WRITE);
> +}
> +
> +static int vsc8514_config_init(struct phy_device *phydev)
> +{
> +	struct vsc8531_private *vsc8531 = phydev->priv;
> +	unsigned long deadline;
> +	u16 val, addr;
> +	int ret, i;
> +	u32 reg;
> +
> +	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
> +
> +	mutex_lock(&phydev->mdio.bus->mdio_lock);
> +
> +	__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> +			MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_EXTENDED);
> +	addr = __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
> +			      MSCC_PHY_EXT_PHY_CNTL_4);
> +	addr >>= PHY_CNTL_4_ADDR_POS;
> +
> +	val = __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
> +			     MSCC_PHY_ACTIPHY_CNTL);
> +
> +	if (val & PHY_ADDR_REVERSED)
> +		vsc8531->base_addr = phydev->mdio.addr + addr;
> +	else
> +		vsc8531->base_addr = phydev->mdio.addr - addr;
> +
> +	/* Some parts of the init sequence are identical for every PHY in the
> +	 * package. Some parts are modifying the GPIO register bank which is a
> +	 * set of registers that are affecting all PHYs, a few resetting the
> +	 * microprocessor common to all PHYs.
> +	 * All PHYs' interrupts mask register has to be zeroed before enabling
> +	 * any PHY's interrupt in this register.
> +	 * For all these reasons, we need to do the init sequence once and only
> +	 * once whatever is the first PHY in the package that is initialized and
> +	 * do the correct init sequence for all PHYs that are package-critical
> +	 * in this pre-init function.
> +	 */
> +	if (!vsc8584_is_pkg_init(phydev, val & PHY_ADDR_REVERSED ? 1 : 0)) {
> +		if ((phydev->phy_id & phydev->drv->phy_id_mask) ==
> +		    (PHY_ID_VSC8514 & phydev->drv->phy_id_mask))
> +			ret = vsc8514_config_pre_init(phydev);
> +		else
> +			ret = -EINVAL;
> +
> +		if (ret)
> +			goto err;
> +	}
> +
> +	vsc8531->pkg_init = true;
> +
> +	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
> +		       MSCC_PHY_PAGE_EXTENDED_GPIO);
> +
> +	val = phy_base_read(phydev, MSCC_PHY_MAC_CFG_FASTLINK);
> +
> +	val &= ~MAC_CFG_MASK;
> +	val |= MAC_CFG_QSGMII;
> +	ret = phy_base_write(phydev, MSCC_PHY_MAC_CFG_FASTLINK, val);
> +
> +	if (ret)
> +		goto err;
> +
> +	ret = vsc8584_cmd(phydev,
> +			  PROC_CMD_MCB_ACCESS_MAC_CONF |
> +			  PROC_CMD_RST_CONF_PORT |
> +			  PROC_CMD_READ_MOD_WRITE_PORT | PROC_CMD_QSGMII_MAC);
> +	if (ret)
> +		goto err;
> +
> +	usleep_range(10000, 20000);
> +
Maybe add a comment to explain the need for this longer delay?

> +	/* 6g mcb */
> +	phy_update_mcb_s6g(phydev, 0x3f, 0);
> +	/* lcpll mcb */
> +	phy_update_mcb_s6g(phydev, 0x11, 0);
> +	/* pll5gcfg0 */
> +	vsc85xx_csr_ctrl_phy_write(phydev,
> +				   PHY_MCB_TARGET, 0x06, 0x7036f145);
> +	phy_commit_mcb_s6g(phydev, 0x11, 0);
> +	/* pllcfg */
> +	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET,
> +				   0x2b, (3 << 21) | (120 << 8) | (0 << 7));
> +	/* commoncfg */
> +	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET,
> +				   0x2c, (0 << 31) | (0 << 18) | (0 << 8)
> +				   | (0 << 6) | (3 << 4));

Can these magic numbers be replaced with meaningful constants?

> +	/* misccfg */
> +	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, 0x3b, 1);
> +
> +	/* gpcfg */
> +	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, 0x2e, 768);
> +
> +	phy_commit_mcb_s6g(phydev, 0x3e, 0);
> +
> +	deadline = jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
> +	do {
> +		phy_update_mcb_s6g(phydev, 0x3f, 0);

Does this really have to be written in each iteration?

> +		reg = vsc85xx_csr_ctrl_phy_read(phydev,
> +						PHY_MCB_TARGET, 0x31);
> +	} while (time_before(jiffies, deadline) && (reg & BIT(12)));
> +	if (reg & BIT(12)) {
> +		mutex_unlock(&phydev->mdio.bus->mdio_lock);
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* misccfg */
> +	vsc85xx_csr_ctrl_phy_write(phydev, PHY_MCB_TARGET, 0x3b, 0);
> +
> +	phy_commit_mcb_s6g(phydev, 0x3f, 0);
> +
> +	deadline = jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
> +	do {
> +		phy_update_mcb_s6g(phydev, 0x3f, 0);

Same as above.

> +		reg = vsc85xx_csr_ctrl_phy_read(phydev,
> +						PHY_MCB_TARGET, 0x2f);
> +	} while (time_before(jiffies, deadline) && !(reg & BIT(8)));
> +
> +	if (!(reg & BIT(8))) {
> +		mutex_unlock(&phydev->mdio.bus->mdio_lock);
> +		return -ETIMEDOUT;
> +	}
> +
> +	mutex_unlock(&phydev->mdio.bus->mdio_lock);
> +
> +	phy_write(phydev, MSCC_EXT_PAGE_ACCESS,
> +		  MSCC_PHY_PAGE_STANDARD);
> +
> +	val = phy_read(phydev, MSCC_PHY_EXT_PHY_CNTL_1);
> +	val &= ~MEDIA_OP_MODE_MASK;
> +	val |= MEDIA_OP_MODE_COPPER;
> +	ret = phy_write(phydev, MSCC_PHY_EXT_PHY_CNTL_1, val);
> +
> +	ret = genphy_soft_reset(phydev);
> +
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < vsc8531->nleds; i++) {
> +		ret = vsc85xx_led_cntl_set(phydev, i, vsc8531->leds_mode[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return genphy_config_init(phydev);
> +
> +err:
> +	mutex_unlock(&phydev->mdio.bus->mdio_lock);
> +	return ret;
> +}
> +
>  static int vsc85xx_ack_interrupt(struct phy_device *phydev)
>  {
>  	int rc = 0;
> @@ -1791,6 +2122,30 @@ static int vsc85xx_read_status(struct phy_device *phydev)
>  	return genphy_read_status(phydev);
>  }
>  
> +static int vsc8514_probe(struct phy_device *phydev)
> +{
> +	struct vsc8531_private *vsc8531;
> +	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
> +	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
> +	   VSC8531_DUPLEX_COLLISION};
> +
This could be defined outside as static const array.

> +	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
> +	if (!vsc8531)
> +		return -ENOMEM;
> +
> +	phydev->priv = vsc8531;
> +
> +	vsc8531->nleds = 4;
> +	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
> +	vsc8531->hw_stats = vsc85xx_hw_stats;
> +	vsc8531->nstats = ARRAY_SIZE(vsc85xx_hw_stats);
> +	vsc8531->stats = devm_kmalloc_array(&phydev->mdio.dev, vsc8531->nstats,
> +					    sizeof(u64), GFP_KERNEL);

Or better use devm_kcalloc() to zero-initialize the allocated memory?

> +	if (!vsc8531->stats)
> +		return -ENOMEM;
> +	return vsc85xx_dt_led_modes_get(phydev, default_mode);
> +}
> +
>  static int vsc8574_probe(struct phy_device *phydev)
>  {
>  	struct vsc8531_private *vsc8531;
> @@ -1878,6 +2233,31 @@ static int vsc85xx_probe(struct phy_device *phydev)
>  
>  /* Microsemi VSC85xx PHYs */
>  static struct phy_driver vsc85xx_driver[] = {
> +{
> +	.phy_id		= PHY_ID_VSC8514,
> +	.name		= "Microsemi GE VSC8514 SyncE",
> +	.phy_id_mask	= 0xfffffff0,

You could use macro PHY_ID_MATCH_MODEL() here.

> +	.features	= PHY_GBIT_FEATURES,
> +	.soft_reset	= &genphy_soft_reset,
> +	.config_init    = &vsc8514_config_init,
> +	.config_aneg    = &vsc85xx_config_aneg,
> +	.aneg_done	= &genphy_aneg_done,
> +	.read_status	= &vsc85xx_read_status,
> +	.ack_interrupt  = &vsc85xx_ack_interrupt,
> +	.config_intr    = &vsc85xx_config_intr,
> +	.suspend	= &genphy_suspend,
> +	.resume		= &genphy_resume,
> +	.probe		= &vsc8514_probe,
> +	.set_wol	= &vsc85xx_wol_set,
> +	.get_wol	= &vsc85xx_wol_get,
> +	.get_tunable	= &vsc85xx_get_tunable,
> +	.set_tunable	= &vsc85xx_set_tunable,
> +	.read_page      = &vsc85xx_phy_read_page,
> +	.write_page     = &vsc85xx_phy_write_page,
> +	.get_sset_count = &vsc85xx_get_sset_count,
> +	.get_strings    = &vsc85xx_get_strings,
> +	.get_stats      = &vsc85xx_get_stats,
> +},
>  {
>  	.phy_id		= PHY_ID_VSC8530,
>  	.name		= "Microsemi FE VSC8530",
> @@ -2034,6 +2414,7 @@ static struct phy_driver vsc85xx_driver[] = {
>  module_phy_driver(vsc85xx_driver);
>  
>  static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
> +	{ PHY_ID_VSC8514, 0xfffffff0, },

Same as above, macro PHY_ID_MATCH_MODEL could be used here.

>  	{ PHY_ID_VSC8530, 0xfffffff0, },
>  	{ PHY_ID_VSC8531, 0xfffffff0, },
>  	{ PHY_ID_VSC8540, 0xfffffff0, },
> 

