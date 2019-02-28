Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225D021850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MrqSwz5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfB1G5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:57:25 -0500
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:50120
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfB1G5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+kHA2UpzB9l+eWWgRLDvG6kgnk10wyLwwgHD6d+1Yk=;
 b=MrqSwz5ZjhrEpDQJ/q1bDu6/CqNCO9JuJskvlP0fhaKfGgQRpsO0+QpOoOsezyryz7c9VxdyuVjXVHvITH0xObKXD5K8O01d4ptp0ezbKxD6aWxRDgQ9nOlwt4+6QJppKd71l03P8vgTEIu29WaT9UTjxxr5/sKdSOpO7fRXruo=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5322.eurprd04.prod.outlook.com (20.176.236.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 06:57:15 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 06:57:15 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 1/2] can: flexcan: add CANFD BRS support and improve bittiming
 setting
Thread-Topic: [PATCH 1/2] can: flexcan: add CANFD BRS support and improve
 bittiming setting
Thread-Index: AQHUzzLWpZCmQqzzWUajIFMd/2fHSQ==
Date:   Thu, 28 Feb 2019 06:57:14 +0000
Message-ID: <20190228065506.3488-2-qiangqing.zhang@nxp.com>
References: <20190228065506.3488-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190228065506.3488-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7303c74-d51f-4f43-60d2-08d69d49f88a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5322;
x-ms-traffictypediagnostic: DB7PR04MB5322:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5322;23:7xwz73c7GWRw136E3A47TqteXavmSXiFbo/U2uK?=
 =?iso-8859-1?Q?Y9EfNVnEpAL6dwQZfn4uZ45lIiW/1l76cxCsoQeVrb4fA4t96z1DPF+uuk?=
 =?iso-8859-1?Q?VG9VQaiAgZsS9hAv/k65QrrVF0J/1ZLL+qWPZu9OD8MXBz75F0IGsu2H+P?=
 =?iso-8859-1?Q?tyR1wpzRgnUfaIHPJhbtK2/VjooxbxRzFureE0Yi3Y3/j6lt7U19RvTsV8?=
 =?iso-8859-1?Q?4NPCqRpwXEL2bN/0LFRXjgkS6LLV17ZpGgNddysp5+ORaBm2rzUZ6VNkw8?=
 =?iso-8859-1?Q?wpPDVFJne03PM98rST1fYIrUUgeZjjQrF76B1mi+TIRe5J54PgIDShjBZl?=
 =?iso-8859-1?Q?TX1JklKNPfkKK1O5s9LDx9DHOrsycaWMszXKv4lGZqLFj/ON/tNrjAkOVX?=
 =?iso-8859-1?Q?jtSMY/pmlUlI2GkZRAHN6Ss6yfSi3jnScmMaBci2mpeE8IhWoC8IClnZx1?=
 =?iso-8859-1?Q?E28+LDwYP+FB0zh0ZBf3ih1UTLA9iXSjB2GwP6vjfc4oHnEnjSikXTjW02?=
 =?iso-8859-1?Q?RpZkXuk9i90d/5CXUggkVPnYuvDog2QbZXjuLEQ8/wYCFzII6b8xNMMn3x?=
 =?iso-8859-1?Q?sDAuDF4knYAv4TDstby/rqnQAHiNp6NSl7weBBnUUvFHllb4xixihsNxNN?=
 =?iso-8859-1?Q?8P9qERwW1G2KDQlqHrZPEsL41QX65hS0nf25adLxvh3XzDadDHjxEx5uJT?=
 =?iso-8859-1?Q?43eAB/zpEzFe4WP20/8tgAuAEdAuwMGTTnyiTmpyty/zExyMDxI5MSxVff?=
 =?iso-8859-1?Q?FNDkCurUyy/CJZDgBjeWt4xnfB7Kdw8xJkyoXg9o1Am+kyiPpu6vaOpJnl?=
 =?iso-8859-1?Q?XG+KQ2b5SKsGDEfghts1five2+DJkvFT44h9Snx5GGAsFc+6MCgcxWgl/J?=
 =?iso-8859-1?Q?3hmcuJhIaPh8xVYzf6XnD+CsFgzYaOBoJLFBkcP78joL8D+AFltXpSjKIR?=
 =?iso-8859-1?Q?EcRnVmwpWUrn/6lGpa4f6p3Ul/3IdM1foFrWwZhMdeBbQfJrnwP7D5kgo+?=
 =?iso-8859-1?Q?j2YVVD26AKELKI/cfLTQ/SDgYZAFGoLUbuy02i+ITx8J1OnQQeevuqYQTg?=
 =?iso-8859-1?Q?KexmezzdllXsWi/AUeA8g8FGI8/YLWUXwXhTHcvuVAQl8rhpRkjDBCiw8J?=
 =?iso-8859-1?Q?oB0T3rFZ0GpMfgwNmEQd5eT5MGKEM81dX19VaZU6nMy9Zw4zA9LWjR2wZt?=
 =?iso-8859-1?Q?wxxKxPTdX0yNVH4V9BgksfFO43lfOy/XNH+vEHBNRfnEQZz1SqH9BNZEAL?=
 =?iso-8859-1?Q?ZB9X0NPDQuweBjeP8JBxXbZz21085LxAdSXQ7DKzTIBxknmzHNOVVGWnW0?=
 =?iso-8859-1?Q?8k=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB53228253DF72F1BD9AC0C4EAE6750@DB7PR04MB5322.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(6512007)(53936002)(105586002)(14454004)(25786009)(478600001)(81156014)(81166006)(6486002)(36756003)(52116002)(6436002)(6116002)(3846002)(66066001)(76176011)(99286004)(7736002)(8676002)(186003)(305945005)(71200400001)(2616005)(11346002)(476003)(446003)(2906002)(71190400001)(2501003)(486006)(256004)(14444005)(1076003)(5660300002)(26005)(86362001)(316002)(102836004)(110136005)(4326008)(106356001)(8936002)(54906003)(50226002)(6506007)(386003)(97736004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5322;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rAetyTSR/SKB7kv7PWU2KCF4FNdMJUQBlQQCMVhIsfKpH+k0vP/TC6+0uR9c6hfpmclr3y4ntg/eiykR9VRVGlCTVn+WgN+2VxW6qaErECMC3xc3L2ON98PgvvdwA3z8dA+NpYkE45gQa7vm48geEw/agtjuolz0OfdOMeuWprMT2NLlYBPZUjSyt7eeIqLwrWyEmAcaH2M/YJowBGHfc1E3ELF6kpKR6blCB+b6HJYTaN89Z9kmM1leVPucVhK/ZKVMkXIVc7VaNI/u6IcT+ADVCdBAmhJamSJ63lTTTL0PNltTN+c2YDddoPoayx/WbQeLyi9CpFnt05zrqjOs/cMjC04/w5DTEcj9RCMDugymFf8KTl2ZogfKbXVZCqNA4q8ovxjWtMFbPUP0gFUYYCz1k6MqTYSFv8TYw/q3yf0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7303c74-d51f-4f43-60d2-08d69d49f88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 06:57:11.8274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

This patch intends to add CANFD BitRate Switch(BRS) support. Bit timing
must be set in CBT register other than CTRL1 register when CANFD
supports BRS, it will extend the range of all CAN bit timing variables
(PRESDIV, PROPSEG, PSEG1, PSEG2 and RJW), which will improve the bit
timing accuracy.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/net/can/flexcan.c | 107 ++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f997f07b6cf9..4ba35f9eb515 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -137,6 +137,14 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
 	 FLEXCAN_ESR_WAK_INT)
=20
+/* FLEXCAN Bit Timing register (CBT) bits */
+#define FLEXCAN_CBT_BTF                 BIT(31)
+#define FLEXCAN_CBT_EPRESDIV(x)         (((x) & 0x3ff) << 21)
+#define FLEXCAN_CBT_ERJW(x)             (((x) & 0x1f) << 16)
+#define FLEXCAN_CBT_EPROPSEG(x)         (((x) & 0x3f) << 10)
+#define FLEXCAN_CBT_EPSEG1(x)           (((x) & 0x1f) << 5)
+#define FLEXCAN_CBT_EPSEG2(x)           ((x) & 0x1f)
+
 /* FLEXCAN FD control register (FDCTRL) bits */
 #define FLEXCAN_FDCTRL_MBDSR3(x)	(((x) & 0x3) << 25)
 #define FLEXCAN_FDCTRL_MBDSR2(x)	(((x) & 0x3) << 22)
@@ -243,7 +251,8 @@ struct flexcan_regs {
 	u32 crcr;		/* 0x44 */
 	u32 rxfgmask;		/* 0x48 */
 	u32 rxfir;		/* 0x4c */
-	u32 _reserved3[12];	/* 0x50 */
+	u32 cbt;                /* 0x50 */
+	u32 _reserved3[11];     /* 0x54 */
 	u8 mb[2][512];		/* 0x80 */
 	/* FIFO-mode:
 	 *			MB
@@ -363,6 +372,18 @@ static const struct can_bittiming_const flexcan_bittim=
ing_const =3D {
 	.brp_inc =3D 1,
 };
=20
+static const struct can_bittiming_const flexcan_fd_bittiming_const =3D {
+	.name =3D DRV_NAME,
+	.tseg1_min =3D 2,
+	.tseg1_max =3D 64,
+	.tseg2_min =3D 1,
+	.tseg2_max =3D 32,
+	.sjw_max =3D 32,
+	.brp_min =3D 1,
+	.brp_max =3D 1024,
+	.brp_inc =3D 1,
+};
+
 static const struct can_bittiming_const flexcan_fd_data_bittiming_const =
=3D {
 	.name =3D DRV_NAME,
 	.tseg1_min =3D 1,
@@ -653,9 +674,13 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *=
skb, struct net_device *de
 	if (cf->can_id & CAN_RTR_FLAG)
 		ctrl |=3D FLEXCAN_MB_CNT_RTR;
=20
-	if (can_is_canfd_skb(skb))
+	if (can_is_canfd_skb(skb)) {
 		ctrl |=3D FLEXCAN_MB_CNT_EDL;
=20
+		if (cf->flags & CANFD_BRS)
+			ctrl |=3D FLEXCAN_MB_CNT_BRS;
+	}
+
 	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		data =3D be32_to_cpup((__be32 *)&cf->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
@@ -834,6 +859,9 @@ static unsigned int flexcan_mailbox_read(struct can_rx_=
offload *offload,
=20
 	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
 		cf->len =3D can_dlc2len((reg_ctrl >> 16) & 0x0F);
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_BRS)
+			cf->flags |=3D CANFD_BRS;
 	} else {
 		cf->len =3D get_can_dlc((reg_ctrl >> 16) & 0x0F);
=20
@@ -1013,21 +1041,7 @@ static void flexcan_set_bittiming(struct net_device =
*dev)
 	u32 reg;
=20
 	reg =3D priv->read(&regs->ctrl);
-	reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
-		 FLEXCAN_CTRL_RJW(0x3) |
-		 FLEXCAN_CTRL_PSEG1(0x7) |
-		 FLEXCAN_CTRL_PSEG2(0x7) |
-		 FLEXCAN_CTRL_PROPSEG(0x7) |
-		 FLEXCAN_CTRL_LPB |
-		 FLEXCAN_CTRL_SMP |
-		 FLEXCAN_CTRL_LOM);
-
-	reg |=3D FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
-		FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
-		FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
-		FLEXCAN_CTRL_RJW(bt->sjw - 1) |
-		FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
-
+	reg &=3D ~(FLEXCAN_CTRL_LPB | FLEXCAN_CTRL_SMP | FLEXCAN_CTRL_LOM);
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
 		reg |=3D FLEXCAN_CTRL_LPB;
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
@@ -1039,17 +1053,60 @@ static void flexcan_set_bittiming(struct net_device=
 *dev)
 	priv->write(reg, &regs->ctrl);
=20
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg =3D FLEXCAN_CBT_EPRESDIV(bt->brp - 1) |
+			FLEXCAN_CBT_EPSEG1(bt->phase_seg1 - 1) |
+			FLEXCAN_CBT_EPSEG2(bt->phase_seg2 - 1) |
+			FLEXCAN_CBT_ERJW(bt->sjw - 1) |
+			FLEXCAN_CBT_EPROPSEG(bt->prop_seg - 1) |
+			FLEXCAN_CBT_BTF;
+		priv->write(reg, &regs->cbt);
+
+		netdev_dbg(dev, "bt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+			   bt->brp - 1, bt->phase_seg1 - 1, bt->phase_seg2 - 1,
+			   bt->sjw - 1, bt->prop_seg - 1);
+
 		reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
 			FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
 			FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
 			FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
 			FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
 		priv->write(reg, &regs->fdcbt);
-	}
=20
-	/* print chip status */
-	netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
-		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
+		if (bt->brp !=3D dbt->brp)
+			netdev_warn(dev, "PRESDIV not the same, may risk transfer errors\n");
+
+		netdev_dbg(dev, "fdbt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+			   dbt->brp - 1, dbt->phase_seg1 - 1, dbt->phase_seg2 - 1,
+			   dbt->sjw - 1, dbt->prop_seg);
+
+		netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x cbt=3D0x%08x fdcbt=3D0x%=
08x\n",
+			   __func__, priv->read(&regs->mcr),
+			   priv->read(&regs->ctrl),
+			   priv->read(&regs->cbt),
+			   priv->read(&regs->fdcbt));
+	} else {
+		reg =3D priv->read(&regs->ctrl);
+		reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
+			 FLEXCAN_CTRL_RJW(0x3) |
+			 FLEXCAN_CTRL_PSEG1(0x7) |
+			 FLEXCAN_CTRL_PSEG2(0x7) |
+			 FLEXCAN_CTRL_PROPSEG(0x7));
+
+		reg |=3D FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
+			FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
+			FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
+			FLEXCAN_CTRL_RJW(bt->sjw - 1) |
+			FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
+		priv->write(reg, &regs->ctrl);
+
+		netdev_dbg(dev, "bt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+			   bt->brp - 1, bt->phase_seg1 - 1, bt->phase_seg2 - 1,
+			   bt->sjw - 1, bt->prop_seg - 1);
+
+		/* print chip status */
+		netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
+			   priv->read(&regs->mcr), priv->read(&regs->ctrl));
+	}
 }
=20
 /* flexcan_chip_start
@@ -1172,6 +1229,13 @@ static int flexcan_chip_start(struct net_device *dev=
)
 		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);
 	}
=20
+	if ((priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) &&
+	    !(priv->can.ctrlmode & CAN_CTRLMODE_FD)) {
+		netdev_err(dev, "fd mode must be enabled\n");
+		err =3D -EOPNOTSUPP;
+		goto out_chip_disable;
+	}
+
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
 		reg_ctrl2 =3D priv->read(&regs->ctrl2);
 		reg_ctrl2 |=3D FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
@@ -1666,6 +1730,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 			priv->offload.is_canfd =3D true;
 			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.bittiming_const =3D &flexcan_fd_bittiming_const;
 			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
 		} else {
 			dev_err(&pdev->dev, "canfd mode can't work on fifo mode\n");
--=20
2.17.1

