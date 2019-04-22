Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C661C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174B7213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lndl/gJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDVGGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:06:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35038 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:06:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id j132so7780560oib.2;
        Sun, 21 Apr 2019 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YL7btH+7sS5SswkL4nKQGnguewVz+r1ICuhuRhG2W9Q=;
        b=Lndl/gJD9rr1e3cgFWMkRyFEhnptZpuj6k64Y/CuLBCY2aRjzZrZenH1SPNo8Qjk0f
         CQiYoCnm2+f39rPR2UiZUAHte9g/TC+XTk6TCP/tmYhO/5pe2I5sZeZWsbq63Xu8pTJQ
         /MpS9IiekQ3tO+u2tfx40AkO7Jb7MDWCG1V8xguJ2IuR3KveGcpbqKYLwY5BIhFMp7Y+
         5dEA5NpORLOvpZ6xZ0/lxiZVTeDNwZawljjHxRy2o/QZBKSZZ+IEp0gG+XlfvH7ye4tv
         WCHKkmSFCpJcIHlAehNu3CaW1rfljrgOclf80kUcSoAqN30MFYzhRLpJAp5OuiEDKQ0z
         hoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YL7btH+7sS5SswkL4nKQGnguewVz+r1ICuhuRhG2W9Q=;
        b=GDVDeKg0BucnVfNVSta+lZura69RubCN1KlcOWcmgFkl0GSpe7oM0M3afAFEA5Ggl6
         SEWNW6kcXrBTDGEFxCUdR2Z6apOuuEN3XbpuE2d7etvco3KhNgs71A74w4GFP4QsKtYK
         xerTE/0vzoKHQsU1r/iZd7e2a0sD70DKR81xSrlTjQLS2dsPoZfunMOuAtmWhrbRDW7E
         dCjDbPBlZd7W3GJWFVq4CunCNKtfTPoor89llTT/zqNNSdfe2NjMcYLSyfp0IzNh+xm3
         WEb58n4/DCXo817axcdlnAQKp/TU8K96HLiL7Ubsb0eKFo1wxJ+Dt1cKHtux77v7+lQ0
         OlgQ==
X-Gm-Message-State: APjAAAURE98vvWo0KXzsFICdzcZbq3Tsu32Y6+5jnBhk1Q1ipqubTS/+
        cwQVbYvxaFYb6fGBuNKlDtSYZAmP19VXEedeTYA=
X-Google-Smtp-Source: APXvYqypV19ASomSbVt1KC3GDc62UZvBAkYv54RdvL5OWkxiZfzrBw/IPWQ948Po9gNyus9siuEXafj9/bPZYq9yug4=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr8604078oig.148.1555913170819;
 Sun, 21 Apr 2019 23:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190418052620.20835-1-o.rempel@pengutronix.de> <20190418052620.20835-4-o.rempel@pengutronix.de>
In-Reply-To: <20190418052620.20835-4-o.rempel@pengutronix.de>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Sun, 21 Apr 2019 23:05:59 -0700
Message-ID: <CAKxU2N_f1EoidnHRHy25-Q+RSwWcYAzL=JFV0CqTAU6qq_4FuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: ethernet: add ag71xx driver
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:27 PM Oleksij Rempel <o.rempel@pengutronix.de> w=
rote:
>
> Add support for Atheros/QCA AR7XXX/AR9XXX/QCA95XX built-in ethernet mac s=
upport
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/ethernet/atheros/Kconfig  |   11 +-
>  drivers/net/ethernet/atheros/Makefile |    1 +
>  drivers/net/ethernet/atheros/ag71xx.c | 1984 +++++++++++++++++++++++++
>  3 files changed, 1995 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/atheros/ag71xx.c
>
> diff --git a/drivers/net/ethernet/atheros/Kconfig b/drivers/net/ethernet/=
atheros/Kconfig
> index e05b25675333..1aa4af3721d6 100644
> --- a/drivers/net/ethernet/atheros/Kconfig
> +++ b/drivers/net/ethernet/atheros/Kconfig
> @@ -5,7 +5,7 @@
>  config NET_VENDOR_ATHEROS
>         bool "Atheros devices"
>         default y
> -       depends on PCI
> +       depends on (PCI || ATH79)
>         ---help---
>           If you have a network (Ethernet) card belonging to this class, =
say Y.
>
> @@ -16,6 +16,15 @@ config NET_VENDOR_ATHEROS
>
>  if NET_VENDOR_ATHEROS
>
> +config AG71XX
> +       tristate "Atheros AR7XXX/AR9XXX built-in ethernet mac support"
> +       depends on ATH79
> +       select PHYLIB
> +       select MDIO_BITBANG
> +       help
> +         If you wish to compile a kernel for AR7XXX/91XXX and enable
> +         ethernet support, then you should always answer Y to this.
> +
>  config ATL2
>         tristate "Atheros L2 Fast Ethernet support"
>         depends on PCI
> diff --git a/drivers/net/ethernet/atheros/Makefile b/drivers/net/ethernet=
/atheros/Makefile
> index aa3d394b87e6..aca696cb6425 100644
> --- a/drivers/net/ethernet/atheros/Makefile
> +++ b/drivers/net/ethernet/atheros/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the Atheros network device drivers.
>  #
>
> +obj-$(CONFIG_AG71XX) +=3D ag71xx.o
>  obj-$(CONFIG_ATL1) +=3D atlx/
>  obj-$(CONFIG_ATL2) +=3D atlx/
>  obj-$(CONFIG_ATL1E) +=3D atl1e/
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet=
/atheros/ag71xx.c
> new file mode 100644
> index 000000000000..5aa6a0aaef8d
> --- /dev/null
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -0,0 +1,1984 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Atheros AR71xx built-in ethernet mac driver
> + *
> + *  Copyright (C) 2019 Oleksij Rempel <o.rempel@pengutronix.de>
> + *
> + *  List of authors contributed to this driver before mainlining:
> + *  Alexander Couzens <lynxis@fe80.eu>
> + *  Christian Lamparter <chunkeey@gmail.com>
> + *  Chuanhong Guo <gch981213@gmail.com>
> + *  Daniel F. Dickinson <cshored@thecshore.com>
> + *  David Bauer <mail@david-bauer.net>
> + *  Felix Fietkau <nbd@nbd.name>
> + *  Gabor Juhos <juhosg@freemail.hu>
> + *  Hauke Mehrtens <hauke@hauke-m.de>
> + *  Johann Neuhauser <johann@it-neuhauser.de>
> + *  John Crispin <john@phrozen.org>
> + *  Jo-Philipp Wich <jo@mein.io>
> + *  Koen Vandeputte <koen.vandeputte@ncentric.com>
> + *  Lucian Cristian <lucian.cristian@gmail.com>
> + *  Matt Merhar <mattmerhar@protonmail.com>
> + *  Milan Krstic <milan.krstic@gmail.com>
> + *  Petr =C5=A0tetiar <ynezz@true.cz>
> + *  Rosen Penev <rosenp@gmail.com>
> + *  Stephen Walker <stephendwalker+github@gmail.com>
> + *  Vittorio Gambaletta <openwrt@vittgam.net>
> + *  Weijie Gao <hackpascal@gmail.com>
> + *  Imre Kaloz <kaloz@openwrt.org>
> + */
> +
> +#include <linux/if_vlan.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/clk.h>
> +
> +/*
> + * For our NAPI weight bigger does *NOT* mean better - it means more
> + * D-cache misses and lots more wasted cycles than we'll ever
> + * possibly gain from saving instructions.
> + */
> +#define AG71XX_NAPI_WEIGHT     32
> +#define AG71XX_OOM_REFILL      (1 + HZ/10)
> +
> +#define AG71XX_INT_ERR (AG71XX_INT_RX_BE | AG71XX_INT_TX_BE)
> +#define AG71XX_INT_TX  (AG71XX_INT_TX_PS)
> +#define AG71XX_INT_RX  (AG71XX_INT_RX_PR | AG71XX_INT_RX_OF)
> +
> +#define AG71XX_INT_POLL        (AG71XX_INT_RX | AG71XX_INT_TX)
> +#define AG71XX_INT_INIT        (AG71XX_INT_ERR | AG71XX_INT_POLL)
> +
> +#define AG71XX_TX_MTU_LEN      1540
> +
> +#define AG71XX_TX_RING_SPLIT           512
> +#define AG71XX_TX_RING_DS_PER_PKT      DIV_ROUND_UP(AG71XX_TX_MTU_LEN, \
> +                                                    AG71XX_TX_RING_SPLIT=
)
> +#define AG71XX_TX_RING_SIZE_DEFAULT    128
> +#define AG71XX_RX_RING_SIZE_DEFAULT    256
> +
> +#define AG71XX_MDIO_RETRY      1000
> +#define AG71XX_MDIO_DELAY      5
> +#define AG71XX_MDIO_MAX_CLK    5000000
> +
> +/* quirks */
> +#define AG71XX_ETH0_NO_MDIO    BIT(0)
> +
> +/* Register offsets */
> +#define AG71XX_REG_MAC_CFG1    0x0000
> +#define MAC_CFG1_TXE           BIT(0)  /* Tx Enable */
> +#define MAC_CFG1_STX           BIT(1)  /* Synchronize Tx Enable */
> +#define MAC_CFG1_RXE           BIT(2)  /* Rx Enable */
> +#define MAC_CFG1_SRX           BIT(3)  /* Synchronize Rx Enable */
> +#define MAC_CFG1_TFC           BIT(4)  /* Tx Flow Control Enable */
> +#define MAC_CFG1_RFC           BIT(5)  /* Rx Flow Control Enable */
> +#define MAC_CFG1_SR            BIT(31) /* Soft Reset */
> +#define MAC_CFG1_INIT  (MAC_CFG1_RXE | MAC_CFG1_TXE | \
> +                        MAC_CFG1_SRX | MAC_CFG1_STX)
> +
> +#define AG71XX_REG_MAC_CFG2    0x0004
> +#define MAC_CFG2_FDX           BIT(0)
> +#define MAC_CFG2_PAD_CRC_EN    BIT(2)
> +#define MAC_CFG2_LEN_CHECK     BIT(4)
> +#define MAC_CFG2_IF_1000       BIT(9)
> +#define MAC_CFG2_IF_10_100     BIT(8)
> +
> +#define AG71XX_REG_MAC_MFL     0x0010
> +
> +#define AG71XX_REG_MII_CFG     0x0020
> +#define MII_CFG_CLK_DIV_4      0
> +#define MII_CFG_CLK_DIV_6      2
> +#define MII_CFG_CLK_DIV_8      3
> +#define MII_CFG_CLK_DIV_10     4
> +#define MII_CFG_CLK_DIV_14     5
> +#define MII_CFG_CLK_DIV_20     6
> +#define MII_CFG_CLK_DIV_28     7
> +#define MII_CFG_CLK_DIV_34     8
> +#define MII_CFG_CLK_DIV_42     9
> +#define MII_CFG_CLK_DIV_50     10
> +#define MII_CFG_CLK_DIV_58     11
> +#define MII_CFG_CLK_DIV_66     12
> +#define MII_CFG_CLK_DIV_74     13
> +#define MII_CFG_CLK_DIV_82     14
> +#define MII_CFG_CLK_DIV_98     15
> +#define MII_CFG_RESET          BIT(31)
> +
> +#define AG71XX_REG_MII_CMD     0x0024
> +#define MII_CMD_WRITE          0x0
> +#define MII_CMD_READ           0x1
> +
> +#define AG71XX_REG_MII_ADDR    0x0028
> +#define MII_ADDR_SHIFT         8
> +
> +#define AG71XX_REG_MII_CTRL    0x002c
> +#define AG71XX_REG_MII_STATUS  0x0030
> +#define AG71XX_REG_MII_IND     0x0034
> +#define MII_IND_BUSY           BIT(0)
> +#define MII_IND_INVALID                BIT(2)
> +
> +#define AG71XX_REG_MAC_IFCTL   0x0038
> +#define MAC_IFCTL_SPEED                BIT(16)
> +
> +#define AG71XX_REG_MAC_ADDR1   0x0040
> +#define AG71XX_REG_MAC_ADDR2   0x0044
> +#define AG71XX_REG_FIFO_CFG0   0x0048
> +#define FIFO_CFG0_WTM          BIT(0)  /* Watermark Module */
> +#define FIFO_CFG0_RXS          BIT(1)  /* Rx System Module */
> +#define FIFO_CFG0_RXF          BIT(2)  /* Rx Fabric Module */
> +#define FIFO_CFG0_TXS          BIT(3)  /* Tx System Module */
> +#define FIFO_CFG0_TXF          BIT(4)  /* Tx Fabric Module */
> +#define FIFO_CFG0_ALL  (FIFO_CFG0_WTM | FIFO_CFG0_RXS | FIFO_CFG0_RXF \
> +                       | FIFO_CFG0_TXS | FIFO_CFG0_TXF)
> +#define FIFO_CFG0_INIT (FIFO_CFG0_ALL << FIFO_CFG0_ENABLE_SHIFT)
> +
> +#define FIFO_CFG0_ENABLE_SHIFT 8
> +
> +#define AG71XX_REG_FIFO_CFG1   0x004c
> +#define AG71XX_REG_FIFO_CFG2   0x0050
> +#define AG71XX_REG_FIFO_CFG3   0x0054
> +#define AG71XX_REG_FIFO_CFG4   0x0058
> +#define FIFO_CFG4_DE           BIT(0)  /* Drop Event */
> +#define FIFO_CFG4_DV           BIT(1)  /* RX_DV Event */
> +#define FIFO_CFG4_FC           BIT(2)  /* False Carrier */
> +#define FIFO_CFG4_CE           BIT(3)  /* Code Error */
> +#define FIFO_CFG4_CR           BIT(4)  /* CRC error */
> +#define FIFO_CFG4_LM           BIT(5)  /* Length Mismatch */
> +#define FIFO_CFG4_LO           BIT(6)  /* Length out of range */
> +#define FIFO_CFG4_OK           BIT(7)  /* Packet is OK */
> +#define FIFO_CFG4_MC           BIT(8)  /* Multicast Packet */
> +#define FIFO_CFG4_BC           BIT(9)  /* Broadcast Packet */
> +#define FIFO_CFG4_DR           BIT(10) /* Dribble */
> +#define FIFO_CFG4_LE           BIT(11) /* Long Event */
> +#define FIFO_CFG4_CF           BIT(12) /* Control Frame */
> +#define FIFO_CFG4_PF           BIT(13) /* Pause Frame */
> +#define FIFO_CFG4_UO           BIT(14) /* Unsupported Opcode */
> +#define FIFO_CFG4_VT           BIT(15) /* VLAN tag detected */
> +#define FIFO_CFG4_FT           BIT(16) /* Frame Truncated */
> +#define FIFO_CFG4_UC           BIT(17) /* Unicast Packet */
> +#define FIFO_CFG4_INIT (FIFO_CFG4_DE | FIFO_CFG4_DV | FIFO_CFG4_FC | \
> +                        FIFO_CFG4_CE | FIFO_CFG4_CR | FIFO_CFG4_LM | \
> +                        FIFO_CFG4_LO | FIFO_CFG4_OK | FIFO_CFG4_MC | \
> +                        FIFO_CFG4_BC | FIFO_CFG4_DR | FIFO_CFG4_LE | \
> +                        FIFO_CFG4_CF | FIFO_CFG4_PF | FIFO_CFG4_UO | \
> +                        FIFO_CFG4_VT)
> +
> +#define AG71XX_REG_FIFO_CFG5   0x005c
> +#define FIFO_CFG5_DE           BIT(0)  /* Drop Event */
> +#define FIFO_CFG5_DV           BIT(1)  /* RX_DV Event */
> +#define FIFO_CFG5_FC           BIT(2)  /* False Carrier */
> +#define FIFO_CFG5_CE           BIT(3)  /* Code Error */
> +#define FIFO_CFG5_LM           BIT(4)  /* Length Mismatch */
> +#define FIFO_CFG5_LO           BIT(5)  /* Length Out of Range */
> +#define FIFO_CFG5_OK           BIT(6)  /* Packet is OK */
> +#define FIFO_CFG5_MC           BIT(7)  /* Multicast Packet */
> +#define FIFO_CFG5_BC           BIT(8)  /* Broadcast Packet */
> +#define FIFO_CFG5_DR           BIT(9)  /* Dribble */
> +#define FIFO_CFG5_CF           BIT(10) /* Control Frame */
> +#define FIFO_CFG5_PF           BIT(11) /* Pause Frame */
> +#define FIFO_CFG5_UO           BIT(12) /* Unsupported Opcode */
> +#define FIFO_CFG5_VT           BIT(13) /* VLAN tag detected */
> +#define FIFO_CFG5_LE           BIT(14) /* Long Event */
> +#define FIFO_CFG5_FT           BIT(15) /* Frame Truncated */
> +#define FIFO_CFG5_16           BIT(16) /* unknown */
> +#define FIFO_CFG5_17           BIT(17) /* unknown */
> +#define FIFO_CFG5_SF           BIT(18) /* Short Frame */
> +#define FIFO_CFG5_BM           BIT(19) /* Byte Mode */
> +#define FIFO_CFG5_INIT (FIFO_CFG5_DE | FIFO_CFG5_DV | FIFO_CFG5_FC | \
> +                        FIFO_CFG5_CE | FIFO_CFG5_LO | FIFO_CFG5_OK | \
> +                        FIFO_CFG5_MC | FIFO_CFG5_BC | FIFO_CFG5_DR | \
> +                        FIFO_CFG5_CF | FIFO_CFG5_PF | FIFO_CFG5_VT | \
> +                        FIFO_CFG5_LE | FIFO_CFG5_FT | FIFO_CFG5_16 | \
> +                        FIFO_CFG5_17 | FIFO_CFG5_SF)
> +
> +#define AG71XX_REG_TX_CTRL     0x0180
> +#define TX_CTRL_TXE            BIT(0)  /* Tx Enable */
> +
> +#define AG71XX_REG_TX_DESC     0x0184
> +#define AG71XX_REG_TX_STATUS   0x0188
> +#define TX_STATUS_PS           BIT(0)  /* Packet Sent */
> +#define TX_STATUS_UR           BIT(1)  /* Tx Underrun */
> +#define TX_STATUS_BE           BIT(3)  /* Bus Error */
> +
> +#define AG71XX_REG_RX_CTRL     0x018c
> +#define RX_CTRL_RXE            BIT(0)  /* Rx Enable */
> +
> +#define AG71XX_REG_RX_DESC     0x0190
> +#define AG71XX_REG_RX_STATUS   0x0194
> +#define RX_STATUS_PR           BIT(0)  /* Packet Received */
> +#define RX_STATUS_OF           BIT(2)  /* Rx Overflow */
> +#define RX_STATUS_BE           BIT(3)  /* Bus Error */
> +
> +#define AG71XX_REG_INT_ENABLE  0x0198
> +#define AG71XX_REG_INT_STATUS  0x019c
> +#define AG71XX_INT_TX_PS       BIT(0)
> +#define AG71XX_INT_TX_UR       BIT(1)
> +#define AG71XX_INT_TX_BE       BIT(3)
> +#define AG71XX_INT_RX_PR       BIT(4)
> +#define AG71XX_INT_RX_OF       BIT(6)
> +#define AG71XX_INT_RX_BE       BIT(7)
> +
> +#define AG71XX_REG_FIFO_DEPTH  0x01a8
> +#define AG71XX_REG_RX_SM       0x01b0
> +#define AG71XX_REG_TX_SM       0x01b4
> +
> +#define ETH_SWITCH_HEADER_LEN  2
> +
> +#define AG71XX_DEFAULT_MSG_ENABLE      \
> +       (NETIF_MSG_DRV                  \
> +       | NETIF_MSG_PROBE               \
> +       | NETIF_MSG_LINK                \
> +       | NETIF_MSG_TIMER               \
> +       | NETIF_MSG_IFDOWN              \
> +       | NETIF_MSG_IFUP                \
> +       | NETIF_MSG_RX_ERR              \
> +       | NETIF_MSG_TX_ERR)
> +
> +static int ag71xx_msg_enable =3D -1;
> +
> +module_param_named(msg_enable, ag71xx_msg_enable, uint,
> +                  (S_IRUSR|S_IRGRP|S_IROTH));
> +MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h=
 for bitmap)");
> +
> +struct ag71xx_desc {
> +       u32     data;
> +       u32     ctrl;
> +#define DESC_EMPTY     BIT(31)
> +#define DESC_MORE      BIT(24)
> +#define DESC_PKTLEN_M  0xfff
> +       u32     next;
> +       u32     pad;
> +} __attribute__((aligned(4)));
> +
> +#define AG71XX_DESC_SIZE       roundup(sizeof(struct ag71xx_desc), \
> +                                       L1_CACHE_BYTES)
> +
> +struct ag71xx_buf {
> +       union {
> +               struct sk_buff  *skb;
> +               void            *rx_buf;
> +       };
> +       union {
> +               dma_addr_t      dma_addr;
> +               unsigned int            len;
> +       };
> +};
> +
> +struct ag71xx_ring {
> +       /* "Hot" fields in the data path. */
> +       unsigned int            curr;
> +       unsigned int            dirty;
> +
> +       /* "Cold" fields - not used in the data path. */
> +       struct ag71xx_buf       *buf;
> +       u16                     order;
> +       u16                     desc_split;
> +       dma_addr_t              descs_dma;
> +       u8 *descs_cpu;
> +};
> +
> +enum ag71xx_type {
> +       AR7100,
> +       AR7240,
> +       AR9130,
> +       AR9330,
> +       AR9340,
> +       QCA9530,
> +       QCA9550,
> +};
> +
> +struct ag71xx_dcfg {
> +       u32                     max_frame_len;
> +       const u32               *fifodata;
> +       u32                     quirks;
> +       u16                     desc_pktlen_mask;
> +       bool                    tx_hang_workaround;
> +       enum ag71xx_type        type;
> +};
> +
> +struct ag71xx {
> +       /*
> +        * Critical data related to the per-packet data path are clustere=
d
> +        * early in this structure to help improve the D-cache footprint.
> +        */
> +       struct ag71xx_ring      rx_ring ____cacheline_aligned;
> +       struct ag71xx_ring      tx_ring ____cacheline_aligned;
> +
> +       u16                     rx_buf_size;
> +       u8                      rx_buf_offset;
> +
> +       struct net_device       *ndev;
> +       struct platform_device  *pdev;
> +       spinlock_t              lock;
> +       struct napi_struct      napi;
> +       u32                     msg_enable;
> +       const struct ag71xx_dcfg        *dcfg;
> +
> +       /*
> +        * From this point onwards we're not looking at per-packet fields=
.
> +        */
> +       void __iomem            *mac_base;
> +
> +       struct ag71xx_desc      *stop_desc;
> +       dma_addr_t              stop_desc_dma;
> +
> +       struct phy_device       *phy_dev;
> +       int                     phy_if_mode;
> +
> +       unsigned int            link;
> +       unsigned int            speed;
> +       int                     duplex;
> +
> +       struct delayed_work     restart_work;
> +       struct timer_list       oom_timer;
> +
> +       struct reset_control    *mac_reset;
> +
> +       u32                     fifodata[3];
> +       int                     mac_idx;
> +
> +       struct reset_control    *mdio_reset;
> +       struct mii_bus          *mii_bus;
> +};
> +
> +static int ag71xx_desc_empty(struct ag71xx_desc *desc)
> +{
> +       return (desc->ctrl & DESC_EMPTY) !=3D 0;
> +}
> +
> +static struct ag71xx_desc *ag71xx_ring_desc(struct ag71xx_ring *ring, in=
t idx)
> +{
> +       return (struct ag71xx_desc *) &ring->descs_cpu[idx * AG71XX_DESC_=
SIZE];
> +}
> +
> +static int ag71xx_ring_size_order(int size)
> +{
> +       return fls(size - 1);
> +}
> +
> +static bool ag71xx_is(struct ag71xx *ag, enum ag71xx_type type)
> +{
> +       return ag->dcfg->type =3D=3D type;
> +}
> +
> +static void ag71xx_wr(struct ag71xx *ag, unsigned reg, u32 value)
> +{
> +       __raw_writel(value, ag->mac_base + reg);
> +       /* flush write */
> +       (void) __raw_readl(ag->mac_base + reg);
> +}
> +
> +static u32 ag71xx_rr(struct ag71xx *ag, unsigned reg)
> +{
> +       return __raw_readl(ag->mac_base + reg);
> +}
> +
> +static void ag71xx_sb(struct ag71xx *ag, unsigned reg, u32 mask)
> +{
> +       void __iomem *r;
> +
> +       r =3D ag->mac_base + reg;
> +       __raw_writel(__raw_readl(r) | mask, r);
> +       /* flush write */
> +       (void) __raw_readl(r);
> +}
> +
> +static void ag71xx_cb(struct ag71xx *ag, unsigned reg, u32 mask)
> +{
> +       void __iomem *r;
> +
> +       r =3D ag->mac_base + reg;
> +       __raw_writel(__raw_readl(r) & ~mask, r);
> +       /* flush write */
> +       (void) __raw_readl(r);
> +}
> +
> +static void ag71xx_int_enable(struct ag71xx *ag, u32 ints)
> +{
> +       ag71xx_sb(ag, AG71XX_REG_INT_ENABLE, ints);
> +}
> +
> +static void ag71xx_int_disable(struct ag71xx *ag, u32 ints)
> +{
> +       ag71xx_cb(ag, AG71XX_REG_INT_ENABLE, ints);
> +}
> +
> +static int ag71xx_mdio_wait_busy(struct ag71xx *ag)
> +{
> +       struct net_device *ndev =3D ag->ndev;
> +       int i;
> +
> +       for (i =3D 0; i < AG71XX_MDIO_RETRY; i++) {
> +               u32 busy;
> +
> +               udelay(AG71XX_MDIO_DELAY);
> +
> +               busy =3D ag71xx_rr(ag, AG71XX_REG_MII_IND);
> +               if (!busy)
> +                       return 0;
> +
> +               udelay(AG71XX_MDIO_DELAY);
> +       }
> +
> +       netif_err(ag, link, ndev, "MDIO operation timed out\n");
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static int ag71xx_mdio_mii_read(struct mii_bus *bus, int addr, int reg)
> +{
> +       struct ag71xx *ag =3D bus->priv;
> +       struct net_device *ndev =3D ag->ndev;
> +       int err;
> +       int ret;
> +
> +       err =3D ag71xx_mdio_wait_busy(ag);
> +       if (err)
> +               return 0xffff;
> +
> +       ag71xx_wr(ag, AG71XX_REG_MII_CMD, MII_CMD_WRITE);
> +       ag71xx_wr(ag, AG71XX_REG_MII_ADDR,
> +                       ((addr & 0xff) << MII_ADDR_SHIFT) | (reg & 0xff))=
;
> +       ag71xx_wr(ag, AG71XX_REG_MII_CMD, MII_CMD_READ);
> +
> +       err =3D ag71xx_mdio_wait_busy(ag);
> +       if (err)
> +               return 0xffff;
> +
> +       ret =3D ag71xx_rr(ag, AG71XX_REG_MII_STATUS);
> +       ret &=3D 0xffff;
> +       ag71xx_wr(ag, AG71XX_REG_MII_CMD, MII_CMD_WRITE);
> +
> +       netif_dbg(ag, link, ndev, "mii_read: addr=3D%04x, reg=3D%04x, val=
ue=3D%04x\n",
> +                 addr, reg, ret);
> +
> +       return ret;
> +}
> +
> +static int ag71xx_mdio_mii_write(struct mii_bus *bus, int addr, int reg,
> +                                u16 val)
> +{
> +       struct ag71xx *ag =3D bus->priv;
> +       struct net_device *ndev =3D ag->ndev;
> +
> +       netif_dbg(ag, link, ndev, "mii_write: addr=3D%04x, reg=3D%04x, va=
lue=3D%04x\n",
> +                 addr, reg, val);
> +
> +       ag71xx_wr(ag, AG71XX_REG_MII_ADDR,
> +                       ((addr & 0xff) << MII_ADDR_SHIFT) | (reg & 0xff))=
;
> +       ag71xx_wr(ag, AG71XX_REG_MII_CTRL, val);
> +
> +       ag71xx_mdio_wait_busy(ag);
> +
> +       return 0;
> +}
> +
> +static const u32 ar71xx_mdio_div_table[] =3D {
> +       4, 4, 6, 8, 10, 14, 20, 28,
> +};
> +
> +static const u32 ar7240_mdio_div_table[] =3D {
> +       2, 2, 4, 6, 8, 12, 18, 26, 32, 40, 48, 56, 62, 70, 78, 96,
> +};
> +
> +static const u32 ar933x_mdio_div_table[] =3D {
> +       4, 4, 6, 8, 10, 14, 20, 28, 34, 42, 50, 58, 66, 74, 82, 98,
> +};
> +
> +static int ag71xx_mdio_get_divider(struct ag71xx *ag, u32 *div)
> +{
> +       struct device *dev =3D &ag->pdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +       struct clk *ref_clk =3D of_clk_get(np, 0);
> +       unsigned long ref_clock;
> +       const u32 *table;
> +       int ndivs, i;
> +
> +       if (IS_ERR(ref_clk))
> +               return -EINVAL;
> +
> +       ref_clock =3D clk_get_rate(ref_clk);
> +       clk_put(ref_clk);
> +
> +       if (ag71xx_is(ag, AR9330) || ag71xx_is(ag, AR9340)) {
> +               table =3D ar933x_mdio_div_table;
> +               ndivs =3D ARRAY_SIZE(ar933x_mdio_div_table);
> +       } else if (ag71xx_is(ag, AR7240)) {
> +               table =3D ar7240_mdio_div_table;
> +               ndivs =3D ARRAY_SIZE(ar7240_mdio_div_table);
> +       } else {
> +               table =3D ar71xx_mdio_div_table;
> +               ndivs =3D ARRAY_SIZE(ar71xx_mdio_div_table);
> +       }
> +
> +       for (i =3D 0; i < ndivs; i++) {
> +               unsigned long t;
> +
> +               t =3D ref_clock / table[i];
> +               if (t <=3D AG71XX_MDIO_MAX_CLK) {
> +                       *div =3D i;
> +                       return 0;
> +               }
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +static int ag71xx_mdio_reset(struct mii_bus *bus)
> +{
> +       struct ag71xx *ag =3D bus->priv;
> +       u32 t;
> +
> +       if (ag71xx_mdio_get_divider(ag, &t)) {
> +               if (ag71xx_is(ag, AR9340))
> +                       t =3D MII_CFG_CLK_DIV_58;
> +               else
> +                       t =3D MII_CFG_CLK_DIV_10;
> +       }
> +
> +       ag71xx_wr(ag, AG71XX_REG_MII_CFG, t | MII_CFG_RESET);
> +       udelay(100);
> +
> +       ag71xx_wr(ag, AG71XX_REG_MII_CFG, t);
> +       udelay(100);
> +
> +       return 0;
> +}
> +
> +static int ag71xx_mdio_probe(struct ag71xx *ag)
> +{
> +       static struct mii_bus *mii_bus;
> +       struct device *dev =3D &ag->pdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +       int i, err;
> +
> +       ag->mii_bus =3D NULL;
> +
> +       /*
> +        * On most (all?) Atheros/QCA SoCs dual eth interfaces are not eq=
ual.
> +        *
> +        * That is to say eth0 can not work independently. It only works
> +        * when eth1 is working.
> +        */
> +       if ((ag->dcfg->quirks & AG71XX_ETH0_NO_MDIO) && !ag->mac_idx)
> +               return 0;
> +
> +       mii_bus =3D devm_mdiobus_alloc(dev);
> +       if (!mii_bus)
> +               return -ENOMEM;
> +
> +       ag->mdio_reset =3D of_reset_control_get_exclusive(np, "mdio");
> +
> +       mii_bus->name =3D "ag71xx_mdio";
> +       mii_bus->read =3D ag71xx_mdio_mii_read;
> +       mii_bus->write =3D ag71xx_mdio_mii_write;
> +       mii_bus->reset =3D ag71xx_mdio_reset;
> +       mii_bus->priv =3D ag;
> +       mii_bus->parent =3D dev;
> +       snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac=
_idx);
> +
> +       if (!IS_ERR(ag->mdio_reset)) {
> +               reset_control_assert(ag->mdio_reset);
> +               msleep(100);
> +               reset_control_deassert(ag->mdio_reset);
> +               msleep(200);
> +       }
> +
> +       err =3D of_mdiobus_register(mii_bus, np);
> +       if (err)
> +               return err;
> +
> +       ag->mii_bus =3D mii_bus;
> +
> +       return 0;
> +}
> +
> +static void ag71xx_mdio_remove(struct ag71xx *ag)
> +{
> +       if (ag->mii_bus)
> +               mdiobus_unregister(ag->mii_bus);
> +}
> +
> +static void ag71xx_hw_stop(struct ag71xx *ag)
> +{
> +       /* disable all interrupts and stop the rx/tx engine */
> +       ag71xx_wr(ag, AG71XX_REG_INT_ENABLE, 0);
> +       ag71xx_wr(ag, AG71XX_REG_RX_CTRL, 0);
> +       ag71xx_wr(ag, AG71XX_REG_TX_CTRL, 0);
> +}
> +
> +static bool ag71xx_check_dma_stuck(struct ag71xx *ag)
> +{
> +       unsigned long timestamp;
> +       u32 rx_sm, tx_sm, rx_fd;
> +
> +       timestamp =3D netdev_get_tx_queue(ag->ndev, 0)->trans_start;
> +       if (likely(time_before(jiffies, timestamp + HZ/10)))
> +               return false;
> +
> +       if (!netif_carrier_ok(ag->ndev))
> +               return false;
> +
> +       rx_sm =3D ag71xx_rr(ag, AG71XX_REG_RX_SM);
> +       if ((rx_sm & 0x7) =3D=3D 0x3 && ((rx_sm >> 4) & 0x7) =3D=3D 0x6)
> +               return true;
> +
> +       tx_sm =3D ag71xx_rr(ag, AG71XX_REG_TX_SM);
> +       rx_fd =3D ag71xx_rr(ag, AG71XX_REG_FIFO_DEPTH);
> +       if (((tx_sm >> 4) & 0x7) =3D=3D 0 && ((rx_sm & 0x7) =3D=3D 0) &&
> +           ((rx_sm >> 4) & 0x7) =3D=3D 0 && rx_fd =3D=3D 0)
> +               return true;
> +
> +       return false;
> +}
> +
> +static int ag71xx_tx_packets(struct ag71xx *ag, bool flush)
> +{
> +       struct ag71xx_ring *ring =3D &ag->tx_ring;
> +       struct net_device *ndev =3D ag->ndev;
> +       bool dma_stuck =3D false;
> +       int ring_mask =3D BIT(ring->order) - 1;
> +       int ring_size =3D BIT(ring->order);
> +       int sent =3D 0;
> +       int bytes_compl =3D 0;
> +       int n =3D 0;
> +
> +       netif_dbg(ag, tx_queued, ndev, "processing TX ring\n");
> +
> +       while (ring->dirty + n !=3D ring->curr) {
> +               unsigned int i =3D (ring->dirty + n) & ring_mask;
> +               struct ag71xx_desc *desc =3D ag71xx_ring_desc(ring, i);
> +               struct sk_buff *skb =3D ring->buf[i].skb;
> +
> +               if (!flush && !ag71xx_desc_empty(desc)) {
> +                       if (ag->dcfg->tx_hang_workaround &&
> +                           ag71xx_check_dma_stuck(ag)) {
> +                               schedule_delayed_work(&ag->restart_work, =
HZ / 2);
> +                               dma_stuck =3D true;
> +                       }
> +                       break;
> +               }
> +
> +               if (flush)
> +                       desc->ctrl |=3D DESC_EMPTY;
> +
> +               n++;
> +               if (!skb)
> +                       continue;
> +
> +               dev_kfree_skb_any(skb);
> +               ring->buf[i].skb =3D NULL;
> +
> +               bytes_compl +=3D ring->buf[i].len;
> +
> +               sent++;
> +               ring->dirty +=3D n;
> +
> +               while (n > 0) {
> +                       ag71xx_wr(ag, AG71XX_REG_TX_STATUS, TX_STATUS_PS)=
;
> +                       n--;
> +               }
> +       }
> +
> +       netif_dbg(ag, tx_done, ndev, "%d packets sent out\n", sent);
> +
> +       if (!sent)
> +               return 0;
> +
> +       ag->ndev->stats.tx_bytes +=3D bytes_compl;
> +       ag->ndev->stats.tx_packets +=3D sent;
> +
> +       netdev_completed_queue(ag->ndev, sent, bytes_compl);
> +       if ((ring->curr - ring->dirty) < (ring_size * 3) / 4)
> +               netif_wake_queue(ag->ndev);
> +
> +       if (!dma_stuck)
> +               cancel_delayed_work(&ag->restart_work);
> +
> +       return sent;
> +}
> +
> +static void ag71xx_dma_reset(struct ag71xx *ag)
> +{
> +       u32 val;
> +       int i;
> +
> +
> +       /* stop RX and TX */
> +       ag71xx_wr(ag, AG71XX_REG_RX_CTRL, 0);
> +       ag71xx_wr(ag, AG71XX_REG_TX_CTRL, 0);
> +
> +       /*
> +        * give the hardware some time to really stop all rx/tx activity
> +        * clearing the descriptors too early causes random memory corrup=
tion
> +        */
> +       mdelay(1);
> +
> +       /* clear descriptor addresses */
> +       ag71xx_wr(ag, AG71XX_REG_TX_DESC, ag->stop_desc_dma);
> +       ag71xx_wr(ag, AG71XX_REG_RX_DESC, ag->stop_desc_dma);
> +
> +       /* clear pending RX/TX interrupts */
> +       for (i =3D 0; i < 256; i++) {
> +               ag71xx_wr(ag, AG71XX_REG_RX_STATUS, RX_STATUS_PR);
> +               ag71xx_wr(ag, AG71XX_REG_TX_STATUS, TX_STATUS_PS);
> +       }
> +
> +       /* clear pending errors */
> +       ag71xx_wr(ag, AG71XX_REG_RX_STATUS, RX_STATUS_BE | RX_STATUS_OF);
> +       ag71xx_wr(ag, AG71XX_REG_TX_STATUS, TX_STATUS_BE | TX_STATUS_UR);
> +
> +       val =3D ag71xx_rr(ag, AG71XX_REG_RX_STATUS);
> +       if (val)
> +               pr_alert("%s: unable to clear DMA Rx status: %08x\n",
> +                        ag->ndev->name, val);
> +
> +       val =3D ag71xx_rr(ag, AG71XX_REG_TX_STATUS);
> +
> +       /* mask out reserved bits */
> +       val &=3D ~0xff000000;
> +
> +       if (val)
> +               pr_alert("%s: unable to clear DMA Tx status: %08x\n",
> +                        ag->ndev->name, val);
> +
> +}
> +
> +static void ag71xx_hw_setup(struct ag71xx *ag)
> +{
> +       u32 init =3D MAC_CFG1_INIT;
> +
> +       /* setup MAC configuration registers */
> +       ag71xx_wr(ag, AG71XX_REG_MAC_CFG1, init);
> +
> +       ag71xx_sb(ag, AG71XX_REG_MAC_CFG2,
> +                 MAC_CFG2_PAD_CRC_EN | MAC_CFG2_LEN_CHECK);
> +
> +       /* setup max frame length to zero */
> +       ag71xx_wr(ag, AG71XX_REG_MAC_MFL, 0);
> +
> +       /* setup FIFO configuration registers */
> +       ag71xx_wr(ag, AG71XX_REG_FIFO_CFG0, FIFO_CFG0_INIT);
> +       ag71xx_wr(ag, AG71XX_REG_FIFO_CFG1, ag->fifodata[0]);
> +       ag71xx_wr(ag, AG71XX_REG_FIFO_CFG2, ag->fifodata[1]);
> +       ag71xx_wr(ag, AG71XX_REG_FIFO_CFG4, FIFO_CFG4_INIT);
> +       ag71xx_wr(ag, AG71XX_REG_FIFO_CFG5, FIFO_CFG5_INIT);
> +}
> +
> +static inline unsigned int ag71xx_max_frame_len(unsigned int mtu)
> +{
> +       return ETH_SWITCH_HEADER_LEN + ETH_HLEN + VLAN_HLEN + mtu + ETH_F=
CS_LEN;
> +}
> +
> +static void ag71xx_hw_set_macaddr(struct ag71xx *ag, unsigned char *mac)
> +{
> +       u32 t;
> +
> +       t =3D (((u32) mac[5]) << 24) | (((u32) mac[4]) << 16)
> +         | (((u32) mac[3]) << 8) | ((u32) mac[2]);
> +
> +       ag71xx_wr(ag, AG71XX_REG_MAC_ADDR1, t);
> +
> +       t =3D (((u32) mac[1]) << 24) | (((u32) mac[0]) << 16);
> +       ag71xx_wr(ag, AG71XX_REG_MAC_ADDR2, t);
> +}
> +
> +static void ag71xx_fast_reset(struct ag71xx *ag)
> +{
> +       struct net_device *dev =3D ag->ndev;
> +       u32 rx_ds;
> +       u32 mii_reg;
> +
> +       ag71xx_hw_stop(ag);
> +       wmb();
> +
> +       mii_reg =3D ag71xx_rr(ag, AG71XX_REG_MII_CFG);
> +       rx_ds =3D ag71xx_rr(ag, AG71XX_REG_RX_DESC);
> +
> +       ag71xx_tx_packets(ag, true);
> +
> +       reset_control_assert(ag->mac_reset);
> +       udelay(10);
> +       reset_control_deassert(ag->mac_reset);
> +       udelay(10);
> +
> +       ag71xx_dma_reset(ag);
> +       ag71xx_hw_setup(ag);
> +       ag->tx_ring.curr =3D 0;
> +       ag->tx_ring.dirty =3D 0;
> +       netdev_reset_queue(ag->ndev);
> +
> +       /* setup max frame length */
> +       ag71xx_wr(ag, AG71XX_REG_MAC_MFL,
> +                 ag71xx_max_frame_len(ag->ndev->mtu));
> +
> +       ag71xx_wr(ag, AG71XX_REG_RX_DESC, rx_ds);
> +       ag71xx_wr(ag, AG71XX_REG_TX_DESC, ag->tx_ring.descs_dma);
> +       ag71xx_wr(ag, AG71XX_REG_MII_CFG, mii_reg);
> +
> +       ag71xx_hw_set_macaddr(ag, dev->dev_addr);
> +}
> +
> +static void ag71xx_hw_start(struct ag71xx *ag)
> +{
> +       /* start RX engine */
> +       ag71xx_wr(ag, AG71XX_REG_RX_CTRL, RX_CTRL_RXE);
> +
> +       /* enable interrupts */
> +       ag71xx_wr(ag, AG71XX_REG_INT_ENABLE, AG71XX_INT_INIT);
> +
> +       netif_wake_queue(ag->ndev);
> +}
> +
> +static unsigned char *ag71xx_speed_str(struct ag71xx *ag)
> +{
> +       switch (ag->speed) {
> +       case SPEED_1000:
> +               return "1000";
> +       case SPEED_100:
> +               return "100";
> +       case SPEED_10:
> +               return "10";
> +       }
> +
> +       return "?";
> +}
> +
> +static void ag71xx_link_adjust(struct ag71xx *ag, bool update)
> +{
> +       struct net_device *ndev =3D ag->ndev;
> +       u32 cfg2;
> +       u32 ifctl;
> +       u32 fifo5;
> +
> +       if (!ag->link && update) {
> +               ag71xx_hw_stop(ag);
> +               netif_carrier_off(ag->ndev);
> +               netif_info(ag, link, ndev, "link down\n");
> +               return;
> +       }
> +
> +       if (!ag71xx_is(ag, AR7100) && !ag71xx_is(ag, AR9130))
> +               ag71xx_fast_reset(ag);
> +
> +       cfg2 =3D ag71xx_rr(ag, AG71XX_REG_MAC_CFG2);
> +       cfg2 &=3D ~(MAC_CFG2_IF_1000 | MAC_CFG2_IF_10_100 | MAC_CFG2_FDX)=
;
> +       cfg2 |=3D (ag->duplex) ? MAC_CFG2_FDX : 0;
> +
> +       ifctl =3D ag71xx_rr(ag, AG71XX_REG_MAC_IFCTL);
> +       ifctl &=3D ~(MAC_IFCTL_SPEED);
> +
> +       fifo5 =3D ag71xx_rr(ag, AG71XX_REG_FIFO_CFG5);
> +       fifo5 &=3D ~FIFO_CFG5_BM;
> +
> +       switch (ag->speed) {
> +       case SPEED_1000:
> +               cfg2 |=3D MAC_CFG2_IF_1000;
> +               fifo5 |=3D FIFO_CFG5_BM;
> +               break;
> +       case SPEED_100:
> +               cfg2 |=3D MAC_CFG2_IF_10_100;
> +               ifctl |=3D MAC_IFCTL_SPEED;
> +               break;
> +       case SPEED_10:
> +               cfg2 |=3D MAC_CFG2_IF_10_100;
> +               break;
> +       default:
> +               BUG();
> +               return;
> +       }
> +
> +       if (ag->tx_ring.desc_split) {
> +               ag->fifodata[2] &=3D 0xffff;
> +               ag->fifodata[2] |=3D ((2048 - ag->tx_ring.desc_split) / 4=
) << 16;
> +       }
> +
> +       ag71xx_wr(ag, AG71XX_REG_FIFO_CFG3, ag->fifodata[2]);
> +
> +       ag71xx_wr(ag, AG71XX_REG_MAC_CFG2, cfg2);
> +       ag71xx_wr(ag, AG71XX_REG_FIFO_CFG5, fifo5);
> +       ag71xx_wr(ag, AG71XX_REG_MAC_IFCTL, ifctl);
> +
> +       ag71xx_hw_start(ag);
> +
> +       netif_carrier_on(ag->ndev);
> +       if (update)
> +               netif_info(ag, link, ndev, "link up (%sMbps/%s duplex)\n"=
,
> +                          ag71xx_speed_str(ag),
> +                          (DUPLEX_FULL =3D=3D ag->duplex) ? "Full" : "Ha=
lf");
> +}
> +
> +static void ag71xx_phy_link_adjust(struct net_device *ndev)
> +{
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +       struct phy_device *phydev =3D ag->phy_dev;
> +       unsigned long flags;
> +       int status_change =3D 0;
> +
> +       spin_lock_irqsave(&ag->lock, flags);
> +
> +       if (phydev->link) {
> +               if (ag->duplex !=3D phydev->duplex
> +                   || ag->speed !=3D phydev->speed) {
> +                       status_change =3D 1;
> +               }
> +       }
> +
> +       if (phydev->link !=3D ag->link)
> +               status_change =3D 1;
> +
> +       ag->link =3D phydev->link;
> +       ag->duplex =3D phydev->duplex;
> +       ag->speed =3D phydev->speed;
> +
> +       if (status_change)
> +               ag71xx_link_adjust(ag, true);
> +
> +       spin_unlock_irqrestore(&ag->lock, flags);
> +}
> +
> +static int ag71xx_phy_connect(struct ag71xx *ag)
> +{
> +       struct device_node *np =3D ag->pdev->dev.of_node;
> +       struct net_device *ndev =3D ag->ndev;
> +       struct device_node *phy_node;
> +       int ret;
> +
> +       if (of_phy_is_fixed_link(np)) {
> +               ret =3D of_phy_register_fixed_link(np);
> +               if (ret < 0) {
> +                       netif_err(ag, probe, ndev, "Failed to register fi=
xed PHY link: %d\n",
> +                                 ret);
> +                       return ret;
> +               }
> +
> +               phy_node =3D of_node_get(np);
> +       } else {
> +               phy_node =3D of_parse_phandle(np, "phy-handle", 0);
> +       }
> +
> +       if (!phy_node) {
> +               netif_err(ag, probe, ndev, "Could not find valid phy node=
\n");
> +               return -ENODEV;
> +       }
> +
> +       ag->phy_dev =3D of_phy_connect(ag->ndev, phy_node, ag71xx_phy_lin=
k_adjust,
> +                                    0, ag->phy_if_mode);
> +
> +       of_node_put(phy_node);
> +
> +       if (!ag->phy_dev) {
> +               netif_err(ag, probe, ndev, "Could not connect to PHY devi=
ce\n");
> +               return -ENODEV;
> +       }
> +
> +       phy_attached_info(ag->phy_dev);
> +
> +       return 0;
> +}
> +
> +void ag71xx_phy_disconnect(struct ag71xx *ag)
> +{
> +       phy_disconnect(ag->phy_dev);
> +}
> +
> +static void ag71xx_ring_tx_clean(struct ag71xx *ag)
> +{
> +       struct ag71xx_ring *ring =3D &ag->tx_ring;
> +       struct net_device *ndev =3D ag->ndev;
> +       int ring_mask =3D BIT(ring->order) - 1;
> +       u32 bytes_compl =3D 0, pkts_compl =3D 0;
> +
> +       while (ring->curr !=3D ring->dirty) {
> +               struct ag71xx_desc *desc;
> +               u32 i =3D ring->dirty & ring_mask;
> +
> +               desc =3D ag71xx_ring_desc(ring, i);
> +               if (!ag71xx_desc_empty(desc)) {
> +                       desc->ctrl =3D 0;
> +                       ndev->stats.tx_errors++;
> +               }
> +
> +               if (ring->buf[i].skb) {
> +                       bytes_compl +=3D ring->buf[i].len;
> +                       pkts_compl++;
> +                       dev_kfree_skb_any(ring->buf[i].skb);
> +               }
> +               ring->buf[i].skb =3D NULL;
> +               ring->dirty++;
> +       }
> +
> +       /* flush descriptors */
> +       wmb();
> +
> +       netdev_completed_queue(ndev, pkts_compl, bytes_compl);
> +}
> +
> +static void ag71xx_ring_tx_init(struct ag71xx *ag)
> +{
> +       struct ag71xx_ring *ring =3D &ag->tx_ring;
> +       int ring_size =3D BIT(ring->order);
> +       int ring_mask =3D ring_size - 1;
> +       int i;
> +
> +       for (i =3D 0; i < ring_size; i++) {
> +               struct ag71xx_desc *desc =3D ag71xx_ring_desc(ring, i);
> +
> +               desc->next =3D (u32) (ring->descs_dma +
> +                       AG71XX_DESC_SIZE * ((i + 1) & ring_mask));
> +
> +               desc->ctrl =3D DESC_EMPTY;
> +               ring->buf[i].skb =3D NULL;
> +       }
> +
> +       /* flush descriptors */
> +       wmb();
> +
> +       ring->curr =3D 0;
> +       ring->dirty =3D 0;
> +       netdev_reset_queue(ag->ndev);
> +}
> +
> +static void ag71xx_ring_rx_clean(struct ag71xx *ag)
> +{
> +       struct ag71xx_ring *ring =3D &ag->rx_ring;
> +       int ring_size =3D BIT(ring->order);
> +       int i;
> +
> +       if (!ring->buf)
> +               return;
> +
> +       for (i =3D 0; i < ring_size; i++)
> +               if (ring->buf[i].rx_buf) {
> +                       dma_unmap_single(&ag->pdev->dev, ring->buf[i].dma=
_addr,
> +                                        ag->rx_buf_size, DMA_FROM_DEVICE=
);
> +                       skb_free_frag(ring->buf[i].rx_buf);
> +               }
> +}
> +
> +static int ag71xx_buffer_size(struct ag71xx *ag)
> +{
> +       return ag->rx_buf_size +
> +              SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +}
> +
> +static bool ag71xx_fill_rx_buf(struct ag71xx *ag, struct ag71xx_buf *buf=
,
> +                              int offset,
> +                              void *(*alloc)(unsigned int size))
> +{
> +       struct ag71xx_ring *ring =3D &ag->rx_ring;
> +       struct ag71xx_desc *desc =3D ag71xx_ring_desc(ring, buf - &ring->=
buf[0]);
> +       void *data;
> +
> +       data =3D alloc(ag71xx_buffer_size(ag));
> +       if (!data)
> +               return false;
> +
> +       buf->rx_buf =3D data;
> +       buf->dma_addr =3D dma_map_single(&ag->pdev->dev, data, ag->rx_buf=
_size,
> +                                      DMA_FROM_DEVICE);
> +       desc->data =3D (u32) buf->dma_addr + offset;
> +       return true;
> +}
> +
> +static int ag71xx_ring_rx_init(struct ag71xx *ag)
> +{
> +       struct ag71xx_ring *ring =3D &ag->rx_ring;
> +       struct net_device *ndev =3D ag->ndev;
> +       int ring_size =3D BIT(ring->order);
> +       int ring_mask =3D BIT(ring->order) - 1;
> +       unsigned int i;
> +       int ret;
> +
> +       ret =3D 0;
> +       for (i =3D 0; i < ring_size; i++) {
> +               struct ag71xx_desc *desc =3D ag71xx_ring_desc(ring, i);
> +
> +               desc->next =3D (u32) (ring->descs_dma +
> +                       AG71XX_DESC_SIZE * ((i + 1) & ring_mask));
> +
> +               netif_dbg(ag, rx_status, ndev, "RX desc at %p, next is %0=
8x\n",
> +                         desc, desc->next);
> +       }
> +
> +       for (i =3D 0; i < ring_size; i++) {
> +               struct ag71xx_desc *desc =3D ag71xx_ring_desc(ring, i);
> +
> +               if (!ag71xx_fill_rx_buf(ag, &ring->buf[i], ag->rx_buf_off=
set,
> +                                       netdev_alloc_frag)) {
> +                       ret =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               desc->ctrl =3D DESC_EMPTY;
> +       }
> +
> +       /* flush descriptors */
> +       wmb();
> +
> +       ring->curr =3D 0;
> +       ring->dirty =3D 0;
> +
> +       return ret;
> +}
> +
> +static int ag71xx_ring_rx_refill(struct ag71xx *ag)
> +{
> +       struct ag71xx_ring *ring =3D &ag->rx_ring;
> +       struct net_device *ndev =3D ag->ndev;
> +       int ring_mask =3D BIT(ring->order) - 1;
> +       unsigned int count;
> +       int offset =3D ag->rx_buf_offset;
> +
> +       count =3D 0;
> +       for (; ring->curr - ring->dirty > 0; ring->dirty++) {
> +               struct ag71xx_desc *desc;
> +               unsigned int i;
> +
> +               i =3D ring->dirty & ring_mask;
> +               desc =3D ag71xx_ring_desc(ring, i);
> +
> +               if (!ring->buf[i].rx_buf &&
> +                   !ag71xx_fill_rx_buf(ag, &ring->buf[i], offset,
> +                                       napi_alloc_frag))
> +                       break;
> +
> +               desc->ctrl =3D DESC_EMPTY;
> +               count++;
> +       }
> +
> +       /* flush descriptors */
> +       wmb();
> +
> +       netif_dbg(ag, rx_status, ndev, "%u rx descriptors refilled\n", co=
unt);
> +
> +       return count;
> +}
> +
> +static int ag71xx_rings_init(struct ag71xx *ag)
> +{
> +       struct ag71xx_ring *tx =3D &ag->tx_ring;
> +       struct ag71xx_ring *rx =3D &ag->rx_ring;
> +       int ring_size =3D BIT(tx->order) + BIT(rx->order);
> +       int tx_size =3D BIT(tx->order);
> +
> +       tx->buf =3D kzalloc(ring_size * sizeof(*tx->buf), GFP_KERNEL);
> +       if (!tx->buf)
> +               return -ENOMEM;
> +
> +       tx->descs_cpu =3D dma_alloc_coherent(&ag->pdev->dev, ring_size * =
AG71XX_DESC_SIZE,
> +                                          &tx->descs_dma, GFP_ATOMIC);
> +       if (!tx->descs_cpu) {
> +               kfree(tx->buf);
> +               tx->buf =3D NULL;
> +               return -ENOMEM;
> +       }
> +
> +       rx->buf =3D &tx->buf[BIT(tx->order)];
> +       rx->descs_cpu =3D ((void *)tx->descs_cpu) + tx_size * AG71XX_DESC=
_SIZE;
> +       rx->descs_dma =3D tx->descs_dma + tx_size * AG71XX_DESC_SIZE;
> +
> +       ag71xx_ring_tx_init(ag);
> +       return ag71xx_ring_rx_init(ag);
> +}
> +
> +static void ag71xx_rings_free(struct ag71xx *ag)
> +{
> +       struct ag71xx_ring *tx =3D &ag->tx_ring;
> +       struct ag71xx_ring *rx =3D &ag->rx_ring;
> +       int ring_size =3D BIT(tx->order) + BIT(rx->order);
> +
> +       if (tx->descs_cpu)
> +               dma_free_coherent(&ag->pdev->dev, ring_size * AG71XX_DESC=
_SIZE,
> +                                 tx->descs_cpu, tx->descs_dma);
> +
> +       kfree(tx->buf);
> +
> +       tx->descs_cpu =3D NULL;
> +       rx->descs_cpu =3D NULL;
> +       tx->buf =3D NULL;
> +       rx->buf =3D NULL;
> +}
> +
> +static void ag71xx_rings_cleanup(struct ag71xx *ag)
> +{
> +       ag71xx_ring_rx_clean(ag);
> +       ag71xx_ring_tx_clean(ag);
> +       ag71xx_rings_free(ag);
> +
> +       netdev_reset_queue(ag->ndev);
> +}
> +
> +static void ag71xx_hw_init(struct ag71xx *ag)
> +{
> +       ag71xx_hw_stop(ag);
> +
> +       ag71xx_sb(ag, AG71XX_REG_MAC_CFG1, MAC_CFG1_SR);
> +       udelay(20);
> +
> +       reset_control_assert(ag->mac_reset);
> +       msleep(100);
> +       reset_control_deassert(ag->mac_reset);
> +       msleep(200);
> +
> +       ag71xx_hw_setup(ag);
> +
> +       ag71xx_dma_reset(ag);
> +}
> +
> +static int ag71xx_hw_enable(struct ag71xx *ag)
> +{
> +       int ret;
> +
> +       ret =3D ag71xx_rings_init(ag);
> +       if (ret)
> +               return ret;
> +
> +       napi_enable(&ag->napi);
> +       ag71xx_wr(ag, AG71XX_REG_TX_DESC, ag->tx_ring.descs_dma);
> +       ag71xx_wr(ag, AG71XX_REG_RX_DESC, ag->rx_ring.descs_dma);
> +       netif_start_queue(ag->ndev);
> +
> +       return 0;
> +}
> +
> +static void ag71xx_hw_disable(struct ag71xx *ag)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ag->lock, flags);
> +
> +       netif_stop_queue(ag->ndev);
> +
> +       ag71xx_hw_stop(ag);
> +       ag71xx_dma_reset(ag);
> +
> +       napi_disable(&ag->napi);
> +       del_timer_sync(&ag->oom_timer);
> +
> +       spin_unlock_irqrestore(&ag->lock, flags);
> +
> +       ag71xx_rings_cleanup(ag);
> +}
> +
> +static int ag71xx_open(struct net_device *ndev)
> +{
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +       unsigned int max_frame_len;
> +       int ret;
> +
> +       netif_carrier_off(ndev);
> +       max_frame_len =3D ag71xx_max_frame_len(ndev->mtu);
> +       ag->rx_buf_size =3D SKB_DATA_ALIGN(max_frame_len + NET_SKB_PAD + =
NET_IP_ALIGN);
> +
> +       /* setup max frame length */
> +       ag71xx_wr(ag, AG71XX_REG_MAC_MFL, max_frame_len);
> +       ag71xx_hw_set_macaddr(ag, ndev->dev_addr);
> +
> +       ret =3D ag71xx_hw_enable(ag);
> +       if (ret)
> +               goto err;
> +
> +       ret =3D ag71xx_phy_connect(ag);
> +       if (ret)
> +               goto err;
> +
> +       phy_start(ag->phy_dev);
> +
> +       return 0;
> +
> +err:
> +       ag71xx_rings_cleanup(ag);
> +       return ret;
> +}
> +
> +static int ag71xx_stop(struct net_device *ndev)
> +{
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +
> +       phy_stop(ag->phy_dev);
> +       ag71xx_hw_disable(ag);
> +
> +       return 0;
> +}
> +
> +static int ag71xx_fill_dma_desc(struct ag71xx_ring *ring, u32 addr, int =
len)
> +{
> +       int i;
> +       struct ag71xx_desc *desc;
> +       int ring_mask =3D BIT(ring->order) - 1;
> +       int ndesc =3D 0;
> +       int split =3D ring->desc_split;
> +
> +       if (!split)
> +               split =3D len;
> +
> +       while (len > 0) {
> +               unsigned int cur_len =3D len;
> +
> +               i =3D (ring->curr + ndesc) & ring_mask;
> +               desc =3D ag71xx_ring_desc(ring, i);
> +
> +               if (!ag71xx_desc_empty(desc))
> +                       return -1;
> +
> +               if (cur_len > split) {
> +                       cur_len =3D split;
> +
> +                       /*
> +                        * TX will hang if DMA transfers <=3D 4 bytes,
> +                        * make sure next segment is more than 4 bytes lo=
ng.
> +                        */
> +                       if (len <=3D split + 4)
> +                               cur_len -=3D 4;
> +               }
> +
> +               desc->data =3D addr;
> +               addr +=3D cur_len;
> +               len -=3D cur_len;
> +
> +               if (len > 0)
> +                       cur_len |=3D DESC_MORE;
> +
> +               /* prevent early tx attempt of this descriptor */
> +               if (!ndesc)
> +                       cur_len |=3D DESC_EMPTY;
> +
> +               desc->ctrl =3D cur_len;
> +               ndesc++;
> +       }
> +
> +       return ndesc;
> +}
> +
> +static netdev_tx_t ag71xx_hard_start_xmit(struct sk_buff *skb,
> +                                         struct net_device *ndev)
> +{
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +       struct ag71xx_ring *ring =3D &ag->tx_ring;
> +       int ring_mask =3D BIT(ring->order) - 1;
> +       int ring_size =3D BIT(ring->order);
> +       struct ag71xx_desc *desc;
> +       dma_addr_t dma_addr;
> +       int i, n, ring_min;
> +
> +       if (skb->len <=3D 4) {
> +               netif_dbg(ag, tx_err, ndev, "packet len is too small\n");
> +               goto err_drop;
> +       }
> +
> +       dma_addr =3D dma_map_single(&ag->pdev->dev, skb->data, skb->len,
> +                                 DMA_TO_DEVICE);
> +
> +       i =3D ring->curr & ring_mask;
> +       desc =3D ag71xx_ring_desc(ring, i);
> +
> +       /* setup descriptor fields */
> +       n =3D ag71xx_fill_dma_desc(ring, (u32) dma_addr,
> +                                skb->len & ag->dcfg->desc_pktlen_mask);
> +       if (n < 0)
> +               goto err_drop_unmap;
> +
> +       i =3D (ring->curr + n - 1) & ring_mask;
> +       ring->buf[i].len =3D skb->len;
> +       ring->buf[i].skb =3D skb;
> +
> +       netdev_sent_queue(ndev, skb->len);
> +
> +       skb_tx_timestamp(skb);
> +
> +       desc->ctrl &=3D ~DESC_EMPTY;
> +       ring->curr +=3D n;
> +
> +       /* flush descriptor */
> +       wmb();
> +
> +       ring_min =3D 2;
> +       if (ring->desc_split)
> +           ring_min *=3D AG71XX_TX_RING_DS_PER_PKT;
> +
> +       if (ring->curr - ring->dirty >=3D ring_size - ring_min) {
> +               netif_dbg(ag, tx_err, ndev, "tx queue full\n");
> +               netif_stop_queue(ndev);
> +       }
> +
> +       netif_dbg(ag, tx_queued, ndev, "packet injected into TX queue\n")=
;
> +
> +       /* enable TX engine */
> +       ag71xx_wr(ag, AG71XX_REG_TX_CTRL, TX_CTRL_TXE);
> +
> +       return NETDEV_TX_OK;
> +
> +err_drop_unmap:
> +       dma_unmap_single(&ag->pdev->dev, dma_addr, skb->len, DMA_TO_DEVIC=
E);
> +
> +err_drop:
> +       ndev->stats.tx_dropped++;
> +
> +       dev_kfree_skb(skb);
> +       return NETDEV_TX_OK;
> +}
> +
> +static int ag71xx_do_ioctl(struct net_device *ndev, struct ifreq *ifr, i=
nt cmd)
> +{
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +
> +       switch (cmd) {
> +       case SIOCSIFHWADDR:
> +               if (copy_from_user
> +                       (ndev->dev_addr, ifr->ifr_data, sizeof(ndev->dev_=
addr)))
> +                       return -EFAULT;
> +               return 0;
> +
> +       case SIOCGIFHWADDR:
> +               if (copy_to_user
> +                       (ifr->ifr_data, ndev->dev_addr, sizeof(ndev->dev_=
addr)))
> +                       return -EFAULT;
> +               return 0;
> +
> +       case SIOCGMIIPHY:
> +       case SIOCGMIIREG:
> +       case SIOCSMIIREG:
> +               if (ag->phy_dev =3D=3D NULL)
> +                       break;
> +
> +               return phy_mii_ioctl(ag->phy_dev, ifr, cmd);
> +
> +       default:
> +               break;
> +       }
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +static void ag71xx_oom_timer_handler(struct timer_list *t)
> +{
> +       struct ag71xx *ag =3D from_timer(ag, t, oom_timer);
> +
> +       napi_schedule(&ag->napi);
> +}
> +
> +static void ag71xx_tx_timeout(struct net_device *ndev)
> +{
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +
> +       netif_err(ag, tx_err, ndev, "tx timeout\n");
> +
> +       schedule_delayed_work(&ag->restart_work, 1);
> +}
> +
> +static void ag71xx_restart_work_func(struct work_struct *work)
> +{
> +       struct ag71xx *ag =3D container_of(work, struct ag71xx, restart_w=
ork.work);
> +
> +       rtnl_lock();
> +       ag71xx_hw_disable(ag);
> +       ag71xx_hw_enable(ag);
> +       if (ag->link)
> +               ag71xx_link_adjust(ag, false);
> +       rtnl_unlock();
> +}
> +
> +static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
> +{
> +       struct net_device *ndev =3D ag->ndev;
> +       struct ag71xx_ring *ring =3D &ag->rx_ring;
> +       unsigned int pktlen_mask =3D ag->dcfg->desc_pktlen_mask;
> +       unsigned int offset =3D ag->rx_buf_offset;
> +       int ring_mask =3D BIT(ring->order) - 1;
> +       int ring_size =3D BIT(ring->order);
> +       struct list_head rx_list;
> +       struct sk_buff *next;
> +       struct sk_buff *skb;
> +       int done =3D 0;
> +
> +       netif_dbg(ag, rx_status, ndev, "rx packets, limit=3D%d, curr=3D%u=
, dirty=3D%u\n",
> +                 limit, ring->curr, ring->dirty);
> +
> +       INIT_LIST_HEAD(&rx_list);
> +
> +       while (done < limit) {
> +               unsigned int i =3D ring->curr & ring_mask;
> +               struct ag71xx_desc *desc =3D ag71xx_ring_desc(ring, i);
> +               int pktlen;
> +               int err =3D 0;
> +
> +               if (ag71xx_desc_empty(desc))
> +                       break;
> +
> +               if ((ring->dirty + ring_size) =3D=3D ring->curr) {
> +                       WARN_ONCE(1, "RX out of ring");
> +                       break;
> +               }
> +
> +               ag71xx_wr(ag, AG71XX_REG_RX_STATUS, RX_STATUS_PR);
> +
> +               pktlen =3D desc->ctrl & pktlen_mask;
> +               pktlen -=3D ETH_FCS_LEN;
> +
> +               dma_unmap_single(&ag->pdev->dev, ring->buf[i].dma_addr,
> +                                ag->rx_buf_size, DMA_FROM_DEVICE);
> +
> +               ndev->stats.rx_packets++;
> +               ndev->stats.rx_bytes +=3D pktlen;
> +
> +               skb =3D build_skb(ring->buf[i].rx_buf, ag71xx_buffer_size=
(ag));
> +               if (!skb) {
> +                       skb_free_frag(ring->buf[i].rx_buf);
> +                       goto next;
> +               }
> +
> +               skb_reserve(skb, offset);
> +               skb_put(skb, pktlen);
> +
> +               if (err) {
> +                       ndev->stats.rx_dropped++;
> +                       kfree_skb(skb);
> +               } else {
> +                       skb->dev =3D ndev;
> +                       skb->ip_summed =3D CHECKSUM_NONE;
> +                       list_add_tail(&skb->list, &rx_list);
> +               }
> +
> +next:
> +               ring->buf[i].rx_buf =3D NULL;
> +               done++;
> +
> +               ring->curr++;
> +       }
> +
> +       ag71xx_ring_rx_refill(ag);
> +
> +       list_for_each_entry_safe(skb, next, &rx_list, list)
> +               skb->protocol =3D eth_type_trans(skb, ndev);
> +       netif_receive_skb_list(&rx_list);
> +
> +       netif_dbg(ag, rx_status, ndev, "rx finish, curr=3D%u, dirty=3D%u,=
 done=3D%d\n",
> +                 ring->curr, ring->dirty, done);
> +
> +       return done;
> +}
> +
> +static int ag71xx_poll(struct napi_struct *napi, int limit)
> +{
> +       struct ag71xx *ag =3D container_of(napi, struct ag71xx, napi);
> +       struct net_device *ndev =3D ag->ndev;
> +       struct ag71xx_ring *rx_ring =3D &ag->rx_ring;
> +       int rx_ring_size =3D BIT(rx_ring->order);
> +       unsigned long flags;
> +       u32 status;
> +       int tx_done;
> +       int rx_done;
> +
> +       tx_done =3D ag71xx_tx_packets(ag, false);
> +
> +       netif_dbg(ag, rx_status, ndev, "processing RX ring\n");
> +       rx_done =3D ag71xx_rx_packets(ag, limit);
> +
> +       if (rx_ring->buf[rx_ring->dirty % rx_ring_size].rx_buf =3D=3D NUL=
L)
> +               goto oom;
> +
> +       status =3D ag71xx_rr(ag, AG71XX_REG_RX_STATUS);
> +       if (unlikely(status & RX_STATUS_OF)) {
> +               ag71xx_wr(ag, AG71XX_REG_RX_STATUS, RX_STATUS_OF);
> +               ndev->stats.rx_fifo_errors++;
> +
> +               /* restart RX */
> +               ag71xx_wr(ag, AG71XX_REG_RX_CTRL, RX_CTRL_RXE);
> +       }
> +
> +       if (rx_done < limit) {
> +               if (status & RX_STATUS_PR)
> +                       goto more;
> +
> +               status =3D ag71xx_rr(ag, AG71XX_REG_TX_STATUS);
> +               if (status & TX_STATUS_PS)
> +                       goto more;
> +
> +               netif_dbg(ag, rx_status, ndev, "disable polling mode, rx=
=3D%d, tx=3D%d,limit=3D%d\n",
> +                         rx_done, tx_done, limit);
> +
> +               napi_complete(napi);
> +
> +               /* enable interrupts */
> +               spin_lock_irqsave(&ag->lock, flags);
> +               ag71xx_int_enable(ag, AG71XX_INT_POLL);
> +               spin_unlock_irqrestore(&ag->lock, flags);
> +               return rx_done;
> +       }
> +
> +more:
> +       netif_dbg(ag, rx_status, ndev, "stay in polling mode, rx=3D%d, tx=
=3D%d, limit=3D%d\n",
> +                 rx_done, tx_done, limit);
> +       return limit;
> +
> +oom:
> +       netif_err(ag, rx_err, ndev, "out of memory\n");
> +
> +       mod_timer(&ag->oom_timer, jiffies + AG71XX_OOM_REFILL);
> +       napi_complete(napi);
> +       return 0;
> +}
> +
> +static irqreturn_t ag71xx_interrupt(int irq, void *dev_id)
> +{
> +       struct net_device *ndev =3D dev_id;
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +       u32 status;
> +
> +       status =3D ag71xx_rr(ag, AG71XX_REG_INT_STATUS);
> +
> +       if (unlikely(!status))
> +               return IRQ_NONE;
> +
> +       if (unlikely(status & AG71XX_INT_ERR)) {
> +               if (status & AG71XX_INT_TX_BE) {
> +                       ag71xx_wr(ag, AG71XX_REG_TX_STATUS, TX_STATUS_BE)=
;
> +                       netif_err(ag, intr, ndev, "TX BUS error\n");
> +               }
> +               if (status & AG71XX_INT_RX_BE) {
> +                       ag71xx_wr(ag, AG71XX_REG_RX_STATUS, RX_STATUS_BE)=
;
> +                       netif_err(ag, intr, ndev, "RX BUS error\n");
> +               }
> +       }
> +
> +       if (likely(status & AG71XX_INT_POLL)) {
> +               ag71xx_int_disable(ag, AG71XX_INT_POLL);
> +               netif_dbg(ag, intr, ndev, "enable polling mode\n");
> +               napi_schedule(&ag->napi);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_NET_POLL_CONTROLLER
I would remove this. Eric Dumazet has been removing these from the
tree. See: 0c3b9d1b37df16ae6046a5a01f769bf3d21b838c for an example.
> +/*
> + * Polling 'interrupt' - used by things like netconsole to send skbs
> + * without having to re-enable interrupts. It's not called while
> + * the interrupt routine is executing.
> + */
> +static void ag71xx_netpoll(struct net_device *ndev)
> +{
> +       disable_irq(ndev->irq);
> +       ag71xx_interrupt(ndev->irq, ndev);
> +       enable_irq(ndev->irq);
> +}
> +#endif
> +
> +static int ag71xx_change_mtu(struct net_device *ndev, int new_mtu)
> +{
> +       struct ag71xx *ag =3D netdev_priv(ndev);
> +
> +       ndev->mtu =3D new_mtu;
> +       ag71xx_wr(ag, AG71XX_REG_MAC_MFL,
> +                 ag71xx_max_frame_len(ndev->mtu));
> +
> +       return 0;
> +}
> +
> +static const struct net_device_ops ag71xx_netdev_ops =3D {
> +       .ndo_open               =3D ag71xx_open,
> +       .ndo_stop               =3D ag71xx_stop,
> +       .ndo_start_xmit         =3D ag71xx_hard_start_xmit,
> +       .ndo_do_ioctl           =3D ag71xx_do_ioctl,
> +       .ndo_tx_timeout         =3D ag71xx_tx_timeout,
> +       .ndo_change_mtu         =3D ag71xx_change_mtu,
> +       .ndo_set_mac_address    =3D eth_mac_addr,
> +       .ndo_validate_addr      =3D eth_validate_addr,
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +       .ndo_poll_controller    =3D ag71xx_netpoll,
> +#endif
> +};
> +
> +static const char *ag71xx_get_phy_if_mode_name(phy_interface_t mode)
this can entirely be replaced by phy_modes()
> +{
> +       switch (mode) {
> +       case PHY_INTERFACE_MODE_MII:
> +               return "MII";
> +       case PHY_INTERFACE_MODE_GMII:
> +               return "GMII";
> +       case PHY_INTERFACE_MODE_RMII:
> +               return "RMII";
> +       case PHY_INTERFACE_MODE_RGMII:
> +               return "RGMII";
> +       case PHY_INTERFACE_MODE_SGMII:
> +               return "SGMII";
> +       default:
> +               break;
> +       }
> +
> +       return "unknown";
> +}
> +
> +static const u32 ar71xx_addr_ar7100[] =3D {
> +       0x19000000, 0x1a000000,
> +};
> +
> +static int ag71xx_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       const struct ag71xx_dcfg *dcfg;
> +       struct net_device *ndev;
> +       struct resource *res;
> +       struct ag71xx *ag;
> +       const void *mac_addr;
> +       int tx_size, err, i;
> +
> +       if (!np)
> +               return -ENODEV;
> +
> +       ndev =3D devm_alloc_etherdev(&pdev->dev, sizeof(*ag));
> +       if (!ndev)
> +               return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
> +       dcfg =3D of_device_get_match_data(&pdev->dev);
> +       if (!dcfg)
> +               return -EINVAL;
> +
> +       ag =3D netdev_priv(ndev);
> +       ag->mac_idx =3D -1;
> +       for (i =3D 0; i < ARRAY_SIZE(ar71xx_addr_ar7100); i++) {
> +               if (ar71xx_addr_ar7100[i] =3D=3D res->start)
> +                       ag->mac_idx =3D i;
> +       }
> +
> +       if (ag->mac_idx < 0) {
> +               netif_err(ag, probe, ndev, "unknown mac idx\n");
> +               return -EINVAL;
> +       }
> +
> +       SET_NETDEV_DEV(ndev, &pdev->dev);
> +
> +       ag->pdev =3D pdev;
> +       ag->ndev =3D ndev;
> +       ag->dcfg =3D dcfg;
> +       ag->msg_enable =3D netif_msg_init(ag71xx_msg_enable,
> +                                       AG71XX_DEFAULT_MSG_ENABLE);
> +       memcpy(ag->fifodata, dcfg->fifodata, sizeof(ag->fifodata));
> +       spin_lock_init(&ag->lock);
> +
> +       ag->mac_reset =3D devm_reset_control_get(&pdev->dev, "mac");
> +       if (IS_ERR(ag->mac_reset)) {
> +               netif_err(ag, probe, ndev, "missing mac reset\n");
> +               err =3D PTR_ERR(ag->mac_reset);
> +               goto err_free;
> +       }
> +
> +       ag->mac_base =3D devm_ioremap_nocache(&pdev->dev, res->start,
> +                                           res->end - res->start + 1);
> +       if (!ag->mac_base) {
> +               err =3D -ENOMEM;
> +               goto err_free;
> +       }
> +
> +       ndev->irq =3D platform_get_irq(pdev, 0);
> +       err =3D devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
> +                              0x0, dev_name(&pdev->dev), ndev);
> +       if (err) {
> +               netif_err(ag, probe, ndev, "unable to request IRQ %d\n",
> +                         ndev->irq);
> +               goto err_free;
> +       }
> +
> +       ndev->netdev_ops =3D &ag71xx_netdev_ops;
> +
> +       INIT_DELAYED_WORK(&ag->restart_work, ag71xx_restart_work_func);
> +       timer_setup(&ag->oom_timer, ag71xx_oom_timer_handler, 0);
> +
> +       tx_size =3D AG71XX_TX_RING_SIZE_DEFAULT;
> +       ag->rx_ring.order =3D ag71xx_ring_size_order(AG71XX_RX_RING_SIZE_=
DEFAULT);
> +
> +       ndev->min_mtu =3D 68;
> +       ndev->max_mtu =3D dcfg->max_frame_len - ag71xx_max_frame_len(0);
> +
> +       ag->rx_buf_offset =3D NET_SKB_PAD;
> +       if (!ag71xx_is(ag, AR7100) && !ag71xx_is(ag, AR9130))
> +               ag->rx_buf_offset +=3D NET_IP_ALIGN;
> +
> +       if (ag71xx_is(ag, AR7100)) {
> +               ag->tx_ring.desc_split =3D AG71XX_TX_RING_SPLIT;
> +               tx_size *=3D AG71XX_TX_RING_DS_PER_PKT;
> +       }
> +       ag->tx_ring.order =3D ag71xx_ring_size_order(tx_size);
> +
> +       ag->stop_desc =3D dmam_alloc_coherent(&pdev->dev,
> +                                           sizeof(struct ag71xx_desc),
> +                                           &ag->stop_desc_dma, GFP_KERNE=
L);
> +       if (!ag->stop_desc)
> +               goto err_free;
> +
> +       ag->stop_desc->data =3D 0;
> +       ag->stop_desc->ctrl =3D 0;
> +       ag->stop_desc->next =3D (u32) ag->stop_desc_dma;
> +
> +       mac_addr =3D of_get_mac_address(np);
> +       if (mac_addr)
> +               memcpy(ndev->dev_addr, mac_addr, ETH_ALEN);
> +       if (!mac_addr || !is_valid_ether_addr(ndev->dev_addr)) {
> +               netif_err(ag, probe, ndev, "invalid MAC address, using ra=
ndom address\n");
> +               eth_random_addr(ndev->dev_addr);
> +       }
> +
> +       ag->phy_if_mode =3D of_get_phy_mode(np);
> +       if (ag->phy_if_mode < 0) {
> +               netif_err(ag, probe, ndev, "missing phy-mode property in =
DT\n");
> +               err =3D ag->phy_if_mode;
> +               goto err_free;
> +       }
> +
> +       netif_napi_add(ndev, &ag->napi, ag71xx_poll, AG71XX_NAPI_WEIGHT);
> +
> +       ag71xx_wr(ag, AG71XX_REG_MAC_CFG1, 0);
> +
> +       ag71xx_hw_init(ag);
> +
> +
> +       err =3D ag71xx_mdio_probe(ag);
> +       if (err)
> +               goto err_free;
> +
> +       platform_set_drvdata(pdev, ndev);
> +
> +       err =3D register_netdev(ndev);
> +       if (err) {
> +               netif_err(ag, probe, ndev, "unable to register net device=
\n");
> +               platform_set_drvdata(pdev, NULL);
> +               goto err_mdio_remove;
> +       }
> +
> +       netif_info(ag, probe, ndev, "Atheros AG71xx at 0x%08lx, irq %d, m=
ode:%s\n",
> +                  (unsigned long) ag->mac_base, ndev->irq,
> +                  ag71xx_get_phy_if_mode_name(ag->phy_if_mode));
> +
> +       return 0;
> +
> +err_mdio_remove:
> +       ag71xx_mdio_remove(ag);
> +err_free:
> +       free_netdev(ndev);
> +       return err;
> +}
> +
> +static int ag71xx_remove(struct platform_device *pdev)
> +{
> +       struct net_device *ndev =3D platform_get_drvdata(pdev);
> +       struct ag71xx *ag;
> +
> +       if (!ndev)
> +               return 0;
> +
> +       ag =3D netdev_priv(ndev);
> +       ag71xx_phy_disconnect(ag);
> +       ag71xx_mdio_remove(ag);
> +       unregister_netdev(ndev);
> +       platform_set_drvdata(pdev, NULL);
> +
> +       return 0;
> +}
> +
> +static const u32 ar71xx_fifo_ar7100[] =3D {
> +       0x0fff0000, 0x00001fff, 0x00780fff,
> +};
> +
> +static const u32 ar71xx_fifo_ar9130[] =3D {
> +       0x0fff0000, 0x00001fff, 0x008001ff,
> +};
> +
> +static const u32 ar71xx_fifo_ar9330[] =3D {
> +       0x0010ffff, 0x015500aa, 0x01f00140,
> +};
> +
> +static const struct ag71xx_dcfg ag71xx_dcfg_ar7100 =3D {
> +       .type =3D AR7100,
> +       .fifodata =3D ar71xx_fifo_ar7100,
> +       .max_frame_len =3D 1540,
> +       .desc_pktlen_mask =3D SZ_4K - 1,
> +       .tx_hang_workaround =3D false,
> +       .quirks =3D 0,
> +};
> +
> +static const struct ag71xx_dcfg ag71xx_dcfg_ar7240 =3D {
> +       .type =3D AR7240,
> +       .fifodata =3D ar71xx_fifo_ar7100,
> +       .max_frame_len =3D 1540,
> +       .desc_pktlen_mask =3D SZ_4K - 1,
> +       .tx_hang_workaround =3D true,
> +       .quirks =3D 0,
> +};
> +
> +static const struct ag71xx_dcfg ag71xx_dcfg_ar9130 =3D {
> +       .type =3D AR9130,
> +       .fifodata =3D ar71xx_fifo_ar9130,
> +       .max_frame_len =3D 1540,
> +       .desc_pktlen_mask =3D SZ_4K - 1,
> +       .tx_hang_workaround =3D false,
> +       .quirks =3D 0,
> +};
> +
> +static const struct ag71xx_dcfg ag71xx_dcfg_ar9330 =3D {
> +       .type =3D AR9330,
> +       .fifodata =3D ar71xx_fifo_ar9330,
> +       .max_frame_len =3D 1540,
> +       .desc_pktlen_mask =3D SZ_4K - 1,
> +       .tx_hang_workaround =3D true,
> +       .quirks =3D AG71XX_ETH0_NO_MDIO,
> +};
> +
> +static const struct ag71xx_dcfg ag71xx_dcfg_ar9340 =3D {
> +       .type =3D AR9340,
> +       .fifodata =3D ar71xx_fifo_ar9330,
> +       .max_frame_len =3D SZ_16K - 1,
> +       .desc_pktlen_mask =3D SZ_16K - 1,
> +       .tx_hang_workaround =3D true,
> +       .quirks =3D 0,
> +};
> +
> +static const struct ag71xx_dcfg ag71xx_dcfg_qca9530 =3D {
> +       .type =3D QCA9530,
> +       .fifodata =3D ar71xx_fifo_ar9330,
> +       .max_frame_len =3D SZ_16K - 1,
> +       .desc_pktlen_mask =3D SZ_16K - 1,
> +       .tx_hang_workaround =3D true,
> +       .quirks =3D 0,
> +};
> +
> +static const struct ag71xx_dcfg ag71xx_dcfg_qca9550 =3D {
> +       .type =3D QCA9550,
> +       .fifodata =3D ar71xx_fifo_ar9330,
> +       .max_frame_len =3D 1540,
> +       .desc_pktlen_mask =3D SZ_16K - 1,
> +       .tx_hang_workaround =3D true,
> +       .quirks =3D 0,
> +};
> +
> +static const struct of_device_id ag71xx_match[] =3D {
> +       { .compatible =3D "qca,ar7100-eth", .data =3D &ag71xx_dcfg_ar7100=
 },
> +       { .compatible =3D "qca,ar7240-eth", .data =3D &ag71xx_dcfg_ar7240=
 },
> +       { .compatible =3D "qca,ar7241-eth", .data =3D &ag71xx_dcfg_ar7240=
 },
> +       { .compatible =3D "qca,ar7242-eth", .data =3D &ag71xx_dcfg_ar7240=
 },
> +       { .compatible =3D "qca,ar9130-eth", .data =3D &ag71xx_dcfg_ar9130=
 },
> +       { .compatible =3D "qca,ar9330-eth", .data =3D &ag71xx_dcfg_ar9330=
 },
> +       { .compatible =3D "qca,ar9340-eth", .data =3D &ag71xx_dcfg_ar9340=
 },
> +       { .compatible =3D "qca,qca9530-eth", .data =3D &ag71xx_dcfg_qca95=
30 },
> +       { .compatible =3D "qca,qca9550-eth", .data =3D &ag71xx_dcfg_qca95=
50 },
> +       { .compatible =3D "qca,qca9560-eth", .data =3D &ag71xx_dcfg_qca95=
50 },
> +       {}
> +};
> +
> +static struct platform_driver ag71xx_driver =3D {
> +       .probe          =3D ag71xx_probe,
> +       .remove         =3D ag71xx_remove,
> +       .driver =3D {
> +               .name   =3D "ag71xx",
> +               .of_match_table =3D ag71xx_match,
> +       }
> +};
> +
> +module_platform_driver(ag71xx_driver);
> +MODULE_LICENSE("GPL v2");
> --
> 2.20.1
>
