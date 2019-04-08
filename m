Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69643C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCE020870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="uyPfsns6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfDHGLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:11:06 -0400
Received: from mail-eopbgr710053.outbound.protection.outlook.com ([40.107.71.53]:34222
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfDHGLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYkFD2Jq4mL6BGDgRBkBhU7dppL7qnzM8I0IUmfYLYg=;
 b=uyPfsns6cNCSwT1JC5gKpxelrZWftrGGKznoJ9d6eCfoBcqHb09vm6xrJ9OdqjKuoybEongMhKzuW4f5XraphW29EaMfVpSvkqwngMUuGevEhqqKTvZWRcQTnR9jKMwq6WC0EBuBc6jWm8MbyolfbwKHb0tax7fNT+24dbHtEfY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3510.namprd03.prod.outlook.com (52.135.213.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 06:10:59 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 06:10:59 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHV0yp6Fa7I5USr12hPuITf3g==
Date:   Mon, 8 Apr 2019 06:10:58 +0000
Message-ID: <20190408140301.3dcbccdd@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:404::31)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1758977c-6a37-4436-93eb-08d6bbe8f7e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR03MB3510;
x-ms-traffictypediagnostic: BYAPR03MB3510:
x-microsoft-antispam-prvs: <BYAPR03MB3510ED5FFFF4B958CB927DB7ED2C0@BYAPR03MB3510.namprd03.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(366004)(136003)(199004)(189003)(14444005)(30864003)(9686003)(97736004)(26005)(486006)(256004)(8676002)(86362001)(2201001)(102836004)(5660300002)(105586002)(71200400001)(71190400001)(6486002)(2501003)(6436002)(53936002)(52116002)(25786009)(1076003)(66066001)(2906002)(476003)(99286004)(186003)(106356001)(81156014)(81166006)(50226002)(8936002)(6512007)(68736007)(3846002)(6506007)(110136005)(478600001)(14454004)(72206003)(305945005)(316002)(6116002)(386003)(7736002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3510;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +xTJ62OoFR8Egoz2hYacrrgZwmoifORrcPZ/3Lu4wNk5w5EI9IzdA8lYxYEUYIRzHxTG/a0UzNTYz234MgpDKM4KTualeukkw6mQWxUepCJjwXw6h6tRSwFV6A9kzt9vpqh29ExFKCMUISu9koEuUnxGCJoKPhp5cC4YQnmMXddbsVvcBYJN7qOUOcGNsepQfFHdh8ctVdl5E0uOFpEkvNr8ZXWr4r6ZlC+j7RDbNAuKCqB8TPNb7z8vQYzO48a/Knf/TdwNm427JfhdtawNHmHcqXPPMevffauYGs3MYWfA9D4jdzUr3l24/081gqPGZqDwVrE7hn42tZgz2hhk7gN8KicA2rtlL6JP1IJdKqx2SIX03tZqxSpnLNOAnys/tgon8FWZvpoBB8bZKYGjZSSfMjDVLXwjDTSbLVECI8U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11353D8539B5DA4F97BCB9F418629B6A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1758977c-6a37-4436-93eb-08d6bbe8f7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 06:10:58.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I met below warning on raspberry pi 3B+:

[    4.833207] ------------[ cut here ]------------
[    4.833442] irq 79 handler irq_default_primary_handler+0x0/0x8 enabled i=
nterrupts
[    4.833758] WARNING: CPU: 0 PID: 0 at __handle_irq_event_percpu+0x124/0x=
150
[    4.834037] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0+ #8
[    4.834266] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
[    4.834511] pstate: 60000005 (nZCv daif -PAN -UAO)
[    4.834702] pc : __handle_irq_event_percpu+0x124/0x150
[    4.834904] lr : __handle_irq_event_percpu+0x124/0x150
[    4.835103] sp : ffffffc035fb5600
[    4.835236] x29: ffffffc035fb5600 x28: ffffff8010720480
[    4.835446] x27: 0000000000000001 x26: ffffff8010650fa0
[    4.835655] x25: ffffff8010757ec6 x24: ffffffc034784e00
[    4.835864] x23: 000000000000004f x22: ffffffc035fb568c
[    4.836073] x21: 0000000000000000 x20: 0000000000000002
[    4.836282] x19: ffffffc03330af00 x18: 0000000000000000
[    4.836495] x17: 0000000000000000 x16: 0000000000000000
[    4.836704] x15: 0000000000aaaaaa x14: 7265746e69206465
[    4.836914] x13: 0000000000000001 x12: 00000000ffffffff
[    4.837122] x11: ffffff801059cf48 x10: 0000000000000001
[    4.837331] x9 : 0000000000000001 x8 : 0000000000000020
[    4.837540] x7 : 0000000000000000 x6 : 00000000000000b7
[    4.837748] x5 : ffffff80102a9f50 x4 : 0000000000000001
[    4.837956] x3 : 0000000000000000 x2 : 0000000000000004
[    4.838165] x1 : ffffff8010720480 x0 : 0000000000000045
[    4.838374] Call trace:
[    4.838480]  __handle_irq_event_percpu+0x124/0x150
[    4.838672]  handle_irq_event_percpu+0x1c/0x68
[    4.842134]  handle_irq_event+0x48/0x78
[    4.845527]  handle_simple_irq+0x9c/0xd8
[    4.848890]  generic_handle_irq+0x28/0x40
[    4.852186]  intr_complete+0xb4/0xe8
[    4.855315]  __usb_hcd_giveback_urb+0x58/0xd0
[    4.858368]  usb_giveback_urb_bh+0x94/0xd8
[    4.861323]  tasklet_action_common.isra.1+0x88/0x130
[    4.864268]  tasklet_hi_action+0x24/0x30
[    4.867112]  __do_softirq+0x114/0x224
[    4.869907]  irq_exit+0x9c/0xb8
[    4.872752]  __handle_domain_irq+0x64/0xb8
[    4.875604]  bcm2836_arm_irqchip_handle_irq+0x60/0xc0
[    4.878544]  el1_irq+0xb0/0x128
[    4.881472]  arch_cpu_idle+0x10/0x18
[    4.884411]  do_idle+0x12c/0x140
[    4.887324]  cpu_startup_entry+0x24/0x28
[    4.890285]  rest_init+0xd0/0xdc
[    4.893247]  arch_call_rest_init+0xc/0x14
[    4.896271]  start_kernel+0x314/0x328
[    4.899291] ---[ end trace 122fa03fe3c21930 ]---

Per my understanding, the proper handling of PHY irq is to make use of
PHY_IGNORE_INTERRUPT then call phy_mac_interrupt when INT_ENP_PHY_INT
is triggered.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/usb/lan78xx.c | 208 +++-----------------------------------
 1 file changed, 16 insertions(+), 192 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3d92ea6fcc02..246a0d1bbc6c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -20,10 +20,6 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <net/ip6_checksum.h>
-#include <linux/interrupt.h>
-#include <linux/irqdomain.h>
-#include <linux/irq.h>
-#include <linux/irqchip/chained_irq.h>
 #include <linux/microchipphy.h>
 #include <linux/phy_fixed.h>
 #include <linux/of_mdio.h>
@@ -87,38 +83,6 @@
 /* statistic update interval (mSec) */
 #define STAT_UPDATE_TIMER		(1 * 1000)
=20
-/* defines interrupts from interrupt EP */
-#define MAX_INT_EP			(32)
-#define INT_EP_INTEP			(31)
-#define INT_EP_OTP_WR_DONE		(28)
-#define INT_EP_EEE_TX_LPI_START		(26)
-#define INT_EP_EEE_TX_LPI_STOP		(25)
-#define INT_EP_EEE_RX_LPI		(24)
-#define INT_EP_MAC_RESET_TIMEOUT	(23)
-#define INT_EP_RDFO			(22)
-#define INT_EP_TXE			(21)
-#define INT_EP_USB_STATUS		(20)
-#define INT_EP_TX_DIS			(19)
-#define INT_EP_RX_DIS			(18)
-#define INT_EP_PHY			(17)
-#define INT_EP_DP			(16)
-#define INT_EP_MAC_ERR			(15)
-#define INT_EP_TDFU			(14)
-#define INT_EP_TDFO			(13)
-#define INT_EP_UTX			(12)
-#define INT_EP_GPIO_11			(11)
-#define INT_EP_GPIO_10			(10)
-#define INT_EP_GPIO_9			(9)
-#define INT_EP_GPIO_8			(8)
-#define INT_EP_GPIO_7			(7)
-#define INT_EP_GPIO_6			(6)
-#define INT_EP_GPIO_5			(5)
-#define INT_EP_GPIO_4			(4)
-#define INT_EP_GPIO_3			(3)
-#define INT_EP_GPIO_2			(2)
-#define INT_EP_GPIO_1			(1)
-#define INT_EP_GPIO_0			(0)
-
 static const char lan78xx_gstrings[][ETH_GSTRING_LEN] =3D {
 	"RX FCS Errors",
 	"RX Alignment Errors",
@@ -350,15 +314,6 @@ struct statstage {
 	struct lan78xx_statstage64	curr_stat;
 };
=20
-struct irq_domain_data {
-	struct irq_domain	*irqdomain;
-	unsigned int		phyirq;
-	struct irq_chip		*irqchip;
-	irq_flow_handler_t	irq_handler;
-	u32			irqenable;
-	struct mutex		irq_lock;		/* for irq bus access */
-};
-
 struct lan78xx_net {
 	struct net_device	*net;
 	struct usb_device	*udev;
@@ -415,8 +370,6 @@ struct lan78xx_net {
=20
 	int			delta;
 	struct statstage	stats;
-
-	struct irq_domain_data	domain_data;
 };
=20
 /* define external phy id */
@@ -1251,6 +1204,7 @@ static void lan78xx_defer_kevent(struct lan78xx_net *=
dev, int work)
 static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 {
 	u32 intdata;
+	struct phy_device *phydev =3D dev->net->phydev;
=20
 	if (urb->actual_length !=3D 4) {
 		netdev_warn(dev->net,
@@ -1264,9 +1218,7 @@ static void lan78xx_status(struct lan78xx_net *dev, s=
truct urb *urb)
 	if (intdata & INT_ENP_PHY_INT) {
 		netif_dbg(dev, link, dev->net, "PHY INTR: 0x%08x\n", intdata);
 		lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
-
-		if (dev->domain_data.phyirq > 0)
-			generic_handle_irq(dev->domain_data.phyirq);
+		phy_mac_interrupt(phydev);
 	} else
 		netdev_warn(dev->net,
 			    "unexpected interrupt: 0x%08x\n", intdata);
@@ -1875,127 +1827,6 @@ static void lan78xx_link_status_change(struct net_d=
evice *net)
 	}
 }
=20
-static int irq_map(struct irq_domain *d, unsigned int irq,
-		   irq_hw_number_t hwirq)
-{
-	struct irq_domain_data *data =3D d->host_data;
-
-	irq_set_chip_data(irq, data);
-	irq_set_chip_and_handler(irq, data->irqchip, data->irq_handler);
-	irq_set_noprobe(irq);
-
-	return 0;
-}
-
-static void irq_unmap(struct irq_domain *d, unsigned int irq)
-{
-	irq_set_chip_and_handler(irq, NULL, NULL);
-	irq_set_chip_data(irq, NULL);
-}
-
-static const struct irq_domain_ops chip_domain_ops =3D {
-	.map	=3D irq_map,
-	.unmap	=3D irq_unmap,
-};
-
-static void lan78xx_irq_mask(struct irq_data *irqd)
-{
-	struct irq_domain_data *data =3D irq_data_get_irq_chip_data(irqd);
-
-	data->irqenable &=3D ~BIT(irqd_to_hwirq(irqd));
-}
-
-static void lan78xx_irq_unmask(struct irq_data *irqd)
-{
-	struct irq_domain_data *data =3D irq_data_get_irq_chip_data(irqd);
-
-	data->irqenable |=3D BIT(irqd_to_hwirq(irqd));
-}
-
-static void lan78xx_irq_bus_lock(struct irq_data *irqd)
-{
-	struct irq_domain_data *data =3D irq_data_get_irq_chip_data(irqd);
-
-	mutex_lock(&data->irq_lock);
-}
-
-static void lan78xx_irq_bus_sync_unlock(struct irq_data *irqd)
-{
-	struct irq_domain_data *data =3D irq_data_get_irq_chip_data(irqd);
-	struct lan78xx_net *dev =3D
-			container_of(data, struct lan78xx_net, domain_data);
-	u32 buf;
-	int ret;
-
-	/* call register access here because irq_bus_lock & irq_bus_sync_unlock
-	 * are only two callbacks executed in non-atomic contex.
-	 */
-	ret =3D lan78xx_read_reg(dev, INT_EP_CTL, &buf);
-	if (buf !=3D data->irqenable)
-		ret =3D lan78xx_write_reg(dev, INT_EP_CTL, data->irqenable);
-
-	mutex_unlock(&data->irq_lock);
-}
-
-static struct irq_chip lan78xx_irqchip =3D {
-	.name			=3D "lan78xx-irqs",
-	.irq_mask		=3D lan78xx_irq_mask,
-	.irq_unmask		=3D lan78xx_irq_unmask,
-	.irq_bus_lock		=3D lan78xx_irq_bus_lock,
-	.irq_bus_sync_unlock	=3D lan78xx_irq_bus_sync_unlock,
-};
-
-static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
-{
-	struct device_node *of_node;
-	struct irq_domain *irqdomain;
-	unsigned int irqmap =3D 0;
-	u32 buf;
-	int ret =3D 0;
-
-	of_node =3D dev->udev->dev.parent->of_node;
-
-	mutex_init(&dev->domain_data.irq_lock);
-
-	lan78xx_read_reg(dev, INT_EP_CTL, &buf);
-	dev->domain_data.irqenable =3D buf;
-
-	dev->domain_data.irqchip =3D &lan78xx_irqchip;
-	dev->domain_data.irq_handler =3D handle_simple_irq;
-
-	irqdomain =3D irq_domain_add_simple(of_node, MAX_INT_EP, 0,
-					  &chip_domain_ops, &dev->domain_data);
-	if (irqdomain) {
-		/* create mapping for PHY interrupt */
-		irqmap =3D irq_create_mapping(irqdomain, INT_EP_PHY);
-		if (!irqmap) {
-			irq_domain_remove(irqdomain);
-
-			irqdomain =3D NULL;
-			ret =3D -EINVAL;
-		}
-	} else {
-		ret =3D -EINVAL;
-	}
-
-	dev->domain_data.irqdomain =3D irqdomain;
-	dev->domain_data.phyirq =3D irqmap;
-
-	return ret;
-}
-
-static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
-{
-	if (dev->domain_data.phyirq > 0) {
-		irq_dispose_mapping(dev->domain_data.phyirq);
-
-		if (dev->domain_data.irqdomain)
-			irq_domain_remove(dev->domain_data.irqdomain);
-	}
-	dev->domain_data.phyirq =3D 0;
-	dev->domain_data.irqdomain =3D NULL;
-}
-
 static int lan8835_fixup(struct phy_device *phydev)
 {
 	int buf;
@@ -2124,16 +1955,15 @@ static int lan78xx_phy_init(struct lan78xx_net *dev=
)
 		return -EIO;
 	}
=20
-	/* if phyirq is not set, use polling mode in phylib */
-	if (dev->domain_data.phyirq > 0)
-		phydev->irq =3D dev->domain_data.phyirq;
-	else
-		phydev->irq =3D 0;
-	netdev_dbg(dev->net, "phydev->irq =3D %d\n", phydev->irq);
-
 	/* set to AUTOMDIX */
 	phydev->mdix =3D ETH_TP_MDI_AUTO;
=20
+	ret =3D phy_read(phydev, LAN88XX_INT_STS);
+	ret =3D phy_write(phydev, LAN88XX_INT_MASK,
+			LAN88XX_INT_MASK_MDINTPIN_EN_ |
+			LAN88XX_INT_MASK_LINK_CHANGE_);
+	phydev->irq =3D PHY_IGNORE_INTERRUPT;
+
 	ret =3D phy_connect_direct(dev->net, phydev,
 				 lan78xx_link_status_change,
 				 dev->interface);
@@ -2571,6 +2401,11 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	}
 	ret =3D lan78xx_write_reg(dev, MAC_CR, buf);
=20
+	/* enable PHY interrupts */
+	ret =3D lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	buf |=3D INT_ENP_PHY_INT;
+	ret =3D lan78xx_write_reg(dev, INT_EP_CTL, buf);
+
 	ret =3D lan78xx_read_reg(dev, MAC_TX, &buf);
 	buf |=3D MAC_TX_TXEN_;
 	ret =3D lan78xx_write_reg(dev, MAC_TX, buf);
@@ -2981,13 +2816,6 @@ static int lan78xx_bind(struct lan78xx_net *dev, str=
uct usb_interface *intf)
=20
 	dev->net->hw_features =3D dev->net->features;
=20
-	ret =3D lan78xx_setup_irq_domain(dev);
-	if (ret < 0) {
-		netdev_warn(dev->net,
-			    "lan78xx_setup_irq_domain() failed : %d", ret);
-		goto out1;
-	}
-
 	dev->net->hard_header_len +=3D TX_OVERHEAD;
 	dev->hard_mtu =3D dev->net->mtu + dev->net->hard_header_len;
=20
@@ -2995,13 +2823,13 @@ static int lan78xx_bind(struct lan78xx_net *dev, st=
ruct usb_interface *intf)
 	ret =3D lan78xx_reset(dev);
 	if (ret) {
 		netdev_warn(dev->net, "Registers INIT FAILED....");
-		goto out2;
+		goto out;
 	}
=20
 	ret =3D lan78xx_mdio_init(dev);
 	if (ret) {
 		netdev_warn(dev->net, "MDIO INIT FAILED.....");
-		goto out2;
+		goto out;
 	}
=20
 	dev->net->flags |=3D IFF_MULTICAST;
@@ -3010,10 +2838,7 @@ static int lan78xx_bind(struct lan78xx_net *dev, str=
uct usb_interface *intf)
=20
 	return ret;
=20
-out2:
-	lan78xx_remove_irq_domain(dev);
-
-out1:
+out:
 	netdev_warn(dev->net, "Bind routine FAILED");
 	cancel_work_sync(&pdata->set_multicast);
 	cancel_work_sync(&pdata->set_vlan);
@@ -3025,7 +2850,6 @@ static void lan78xx_unbind(struct lan78xx_net *dev, s=
truct usb_interface *intf)
 {
 	struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)(dev->data[0]);
=20
-	lan78xx_remove_irq_domain(dev);
=20
 	lan78xx_remove_mdio(dev);
=20
--=20
2.20.1

