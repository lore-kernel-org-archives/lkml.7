Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA460C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68345206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/FFYXPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfCFKBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:01:04 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:15840
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729974AbfCFKBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6al7h09oOKQg+Bm/A5PnH25LbpnXRxssqrxptcfSUk=;
 b=F/FFYXPaMljjynwe4rcsNkGFLGj3f4yW5brxbTlxnf/Ss+SSUc79vmtWpUTD32Xo1urp9zRR/VbFPwDs/pWU7XbnP4EE0mtb6UQpmh6hnF2MR23bWrqgvEOkoLXxJdGaTU7ET3f0t7TY71vbLE6qjSsSSOJyVzvjGFvSLmV49cU=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5404.eurprd04.prod.outlook.com (20.178.104.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 10:00:57 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1686.018; Wed, 6 Mar 2019
 10:00:57 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 2/5] can: flexcan: add CAN FD mode support
Thread-Topic: [PATCH RESEND 2/5] can: flexcan: add CAN FD mode support
Thread-Index: AQHU1AN+EXBiWkG+6EWDBQkIpHmKDw==
Date:   Wed, 6 Mar 2019 10:00:57 +0000
Message-ID: <20190306095833.20922-3-qiangqing.zhang@nxp.com>
References: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8baa9dbe-ba85-45f4-e731-08d6a21aa0de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5404;
x-ms-traffictypediagnostic: DB7PR04MB5404:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5404;23:kmC0jJ5gM47jzxliwuyKS6hNXAE4qBWt+SY8J4f?=
 =?iso-8859-1?Q?Man6oYyeQI0wX+ZhpmqYn1l5AzzOXq9Bhw6ZLFepQvvwX+Naka7LAkZMgN?=
 =?iso-8859-1?Q?DGNSx6hC8Els1QAcYEFXiltdY7BOr/FxLlQCyxQa74uXQyWr1O75WlxcdM?=
 =?iso-8859-1?Q?WqXnzhC+JOUaF38aXjUaILxAIzaEEDu4tji400hn5xivSINmF+jVcPjfgy?=
 =?iso-8859-1?Q?rtKeWu/XCMVQSVjvcpF2QL/SzBeHkPHapL3pzZNRBb/sbtNDtPy6hRK6n4?=
 =?iso-8859-1?Q?wfhCggXiEex1eA57P1Gv14cDlIz94Ch5kG1DbMbjVnGzybzmlgOUos6Q/w?=
 =?iso-8859-1?Q?xnCEHo1kHARixlocFN1R+dW1bYt+lK/aPTG7wIw1Dtpxoy6eaMqCHzVDVq?=
 =?iso-8859-1?Q?vuRPRJLJ4gbme/hwIU9f3ndw7O3Ej23bXWc0sCHzlSrMpSpnDcUYrLYz9G?=
 =?iso-8859-1?Q?KvCpm5khtV2y1Mr+3lWIo8vMsVn33xUEyXwwQ9vt9M2Id3ZOh7Wh4tx1zZ?=
 =?iso-8859-1?Q?aTWbnyHzIPVOqhobwkvaJ1++hmM2QyRFQlwau/5XUS/YxPwZBln6btZr+e?=
 =?iso-8859-1?Q?1CH3J/D7o47RSCFeosCeLJjCu/rMjaCOxwPS+Vdqtsfk5evPnAUv2fr+tB?=
 =?iso-8859-1?Q?t5yMSWG8DFlgfyC8kAwW8QWSImmiQiw7pmMJ1yfaNyKU4CC61QwECC0q/f?=
 =?iso-8859-1?Q?oxJw+oUtwEeGjeumepijge2RqyhN58WcVzFL0sL7s6dTxIESP+iqFvwKIw?=
 =?iso-8859-1?Q?ONTwz+nHnu2Uba109WAMcg+o8O4lIycWdFBhBsS+0ZyB3dIFChrvQ9pxql?=
 =?iso-8859-1?Q?Ir1GlR8DWZrrsH/uluunxFAEdyjze7ZbrGaUyqkpsjNMjhY6VSsxAqKTF9?=
 =?iso-8859-1?Q?vDNxvQ90b0aeEfyXWtpPDxORyqPsMQQ80fA6ODiIUxRoBubssJzvgL8af8?=
 =?iso-8859-1?Q?uq8bgi26OHhny0zxXZc2dbvTsD3IkeNX4P3QTce0GKunV/4Tk3xZe0AUWQ?=
 =?iso-8859-1?Q?A/AT599eO1fteVOeAzcswxe/FDKYCV2nXNpiEzgyLyd9OLEf+uLei9to/X?=
 =?iso-8859-1?Q?Oj5AoQqMffaoWJyO4pnRPXhyxV/qClbz1ppzpPfb6lt5EK3UZ88MX1mPsg?=
 =?iso-8859-1?Q?jArhUt2iHU6C5bqmH5LsuzgrAwwoKNeUu3ELJDs0A6ipb6nOTmVKC+L9SD?=
 =?iso-8859-1?Q?jfHuWTcAufnhnwv7J6Umy/2FZJ73CSq+CU75IcCB/qx5YSOxy48RTq6l2l?=
 =?iso-8859-1?Q?BgovVMCMt566tz/1bISPy9ZuMI0QJTipgPQznXgHcXwoLxoRpsUI+RsCIy?=
 =?iso-8859-1?Q?nQ=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB54049E8E02343B2AAD3AFC09E6730@DB7PR04MB5404.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(54906003)(6436002)(99286004)(8936002)(26005)(305945005)(186003)(4326008)(36756003)(6506007)(102836004)(11346002)(105586002)(446003)(2616005)(486006)(256004)(14444005)(106356001)(386003)(2906002)(71190400001)(25786009)(2501003)(1076003)(71200400001)(476003)(52116002)(81156014)(97736004)(81166006)(6116002)(3846002)(14454004)(68736007)(5660300002)(8676002)(6512007)(110136005)(316002)(53936002)(76176011)(478600001)(50226002)(86362001)(66066001)(7736002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5404;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F3vb0wb1jKTCMzryuTcj1J+w11quHgrd3Nak2iw7L5X6qwIKHWcWyx90yD4s3YjNALxqaZFyNgDP/3T7pwsC/VO+w4r9SNeZ6jtHGRECYzGQdW5rtUhNEbt0bndor11JyrRlO2JRMGU0fDsllTe1+UV5me+AIYXFE1dY47OCMnGt/UKi3gyE4tQI9AlO+UgEZN+8HU/wHCYk1b3X4y7urxyD8cttA4aDHjdJnIjfInTBCvbK3h2AcRkTUfoBzjPJ/LooDstVYAyGL9oqeYfBuIBQ/HI1OIzj72ewNkVr/3n6SFomePtpYMy3oYvm3oD/5/aoiGBBk3wcbOV1CXE+F++EJCR1oSWDspvZJVP6WcgrA3PtkDABKv9b7EjlUnXrweyDEZLWUQbQijIqeMh88pVWuYljOu8sRy82udAhLDk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baa9dbe-ba85-45f4-e731-08d6a21aa0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:00:57.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

This patch intends to add CAN FD mode support in driver, it means that
payload size can extend up to 64 bytes.

NOTE: Bit rate switch (BRS) enabled by system reset when it enables CAN
FD mode (explicitly set BRS again in driver). So CAN hardware has support
BRS, but now driver has not support it due to bit timing must set in CBT
register other than CTRL1 register. It will add in next patch.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 109 ++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e35083ff31ee..eee0c23bb805 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -52,6 +52,7 @@
 #define FLEXCAN_MCR_IRMQ		BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
+#define FLEXCAN_MCR_FDEN		BIT(11)
 /* MCR_MAXMB: maximum used MBs is MAXMB + 1 */
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
 #define FLEXCAN_MCR_IDAM_A		(0x0 << 8)
@@ -137,6 +138,20 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
 	 FLEXCAN_ESR_WAK_INT)
=20
+/* FLEXCAN FD control register (FDCTRL) bits */
+#define FLEXCAN_FDCTRL_FDRATE		BIT(31)
+#define FLEXCAN_FDCTRL_MBDSR3(x)	(((x) & 0x3) << 25)
+#define FLEXCAN_FDCTRL_MBDSR2(x)	(((x) & 0x3) << 22)
+#define FLEXCAN_FDCTRL_MBDSR1(x)	(((x) & 0x3) << 19)
+#define FLEXCAN_FDCTRL_MBDSR0(x)	(((x) & 0x3) << 16)
+
+/* FLEXCAN FD Bit Timing register (FDCBT) bits */
+#define FLEXCAN_FDCBT_FPRESDIV(x)	(((x) & 0x3ff) << 20)
+#define FLEXCAN_FDCBT_FRJW(x)		(((x) & 0x07) << 16)
+#define FLEXCAN_FDCBT_FPROPSEG(x)	(((x) & 0x1f) << 10)
+#define FLEXCAN_FDCBT_FPSEG1(x)		(((x) & 0x07) << 5)
+#define FLEXCAN_FDCBT_FPSEG2(x)		((x) & 0x07)
+
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
 #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
@@ -148,6 +163,10 @@
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
=20
 /* FLEXCAN message buffers */
+#define FLEXCAN_MB_CNT_EDL		BIT(31)
+#define FLEXCAN_MB_CNT_BRS		BIT(30)
+#define FLEXCAN_MB_CNT_ESI		BIT(29)
+
 #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
 #define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
@@ -192,6 +211,7 @@
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error p=
assive */
 #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register =
access */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to suppor=
t wakeup */
+#define FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD	BIT(9) /* Use timestamp then su=
pport can fd mode */
=20
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -250,6 +270,9 @@ struct flexcan_regs {
 	u32 rerrdr;		/* 0xaf4 */
 	u32 rerrsynr;		/* 0xaf8 */
 	u32 errsr;		/* 0xafc */
+	u32 _reserved7[64];     /* 0xb00 */
+	u32 fdctrl;             /* 0xc00 */
+	u32 fdcbt;              /* 0xc04 */
 };
=20
 struct flexcan_devtype_data {
@@ -337,6 +360,18 @@ static const struct can_bittiming_const flexcan_bittim=
ing_const =3D {
 	.brp_inc =3D 1,
 };
=20
+static const struct can_bittiming_const flexcan_fd_data_bittiming_const =
=3D {
+	.name =3D DRV_NAME,
+	.tseg1_min =3D 1,
+	.tseg1_max =3D 39,
+	.tseg2_min =3D 1,
+	.tseg2_max =3D 8,
+	.sjw_max =3D 8,
+	.brp_min =3D 1,
+	.brp_max =3D 1024,
+	.brp_inc =3D 1,
+};
+
 /* FlexCAN module is essentially modelled as a little-endian IP in most
  * SoCs, i.e the registers as well as the message buffer areas are
  * implemented in a little-endian fashion.
@@ -609,10 +644,10 @@ static int flexcan_get_berr_counter(const struct net_=
device *dev,
 static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 {
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
-	struct can_frame *cf =3D (struct can_frame *)skb->data;
+	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
 	u32 can_id;
 	u32 data;
-	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
+	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | ((can_len2dlc(cf->len)) << 16);
 	int i;
=20
 	if (can_dropped_invalid_skb(dev, skb))
@@ -630,7 +665,10 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *=
skb, struct net_device *de
 	if (cf->can_id & CAN_RTR_FLAG)
 		ctrl |=3D FLEXCAN_MB_CNT_RTR;
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+	if (can_is_canfd_skb(skb))
+		ctrl |=3D FLEXCAN_MB_CNT_EDL;
+
+	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		data =3D be32_to_cpup((__be32 *)&cf->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
 	}
@@ -790,7 +828,7 @@ static inline struct flexcan_priv *rx_offload_to_priv(s=
truct can_rx_offload *off
 }
=20
 static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
-					 struct can_frame *cf,
+					 struct canfd_frame *cf,
 					 u32 *timestamp, unsigned int n)
 {
 	struct flexcan_priv *priv =3D rx_offload_to_priv(offload);
@@ -836,11 +874,21 @@ static unsigned int flexcan_mailbox_read(struct can_r=
x_offload *offload,
 	else
 		cf->can_id =3D (reg_id >> 18) & CAN_SFF_MASK;
=20
-	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
-		cf->can_id |=3D CAN_RTR_FLAG;
-	cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
+	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
+		cf->len =3D can_dlc2len((reg_ctrl >> 16) & 0x0F);
+	} else {
+		cf->len =3D get_can_dlc((reg_ctrl >> 16) & 0x0F);
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+			cf->can_id |=3D CAN_RTR_FLAG;
+	}
+
+	if (reg_ctrl & FLEXCAN_MB_CNT_ESI) {
+		cf->flags |=3D CANFD_ESI;
+		netdev_warn(priv->can.dev, "ESI Error\n");
+	}
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		__be32 data =3D cpu_to_be32(priv->read(&mb->data[i / sizeof(u32)]));
 		*(__be32 *)(cf->data + i) =3D data;
 	}
@@ -985,6 +1033,7 @@ static void flexcan_set_bittiming(struct net_device *d=
ev)
 {
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
 	const struct can_bittiming *bt =3D &priv->can.bittiming;
+	const struct can_bittiming *dbt =3D &priv->can.data_bittiming;
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 reg;
=20
@@ -1014,6 +1063,15 @@ static void flexcan_set_bittiming(struct net_device =
*dev)
 	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
 	priv->write(reg, &regs->ctrl);
=20
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
+			FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
+			FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
+			FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
+			FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
+		priv->write(reg, &regs->fdcbt);
+	}
+
 	/* print chip status */
 	netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
 		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
@@ -1028,7 +1086,7 @@ static int flexcan_chip_start(struct net_device *dev)
 {
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->regs;
-	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
+	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr, reg_fdctrl;
 	u64 reg_imask;
 	int err, i;
 	struct flexcan_mb __iomem *mb;
@@ -1125,6 +1183,22 @@ static int flexcan_chip_start(struct net_device *dev=
)
 	netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);
 	priv->write(reg_ctrl, &regs->ctrl);
=20
+	/* FDCTRL
+	 *
+	 * support BRS when set CAN FD mode
+	 * 64 bytes payload per MB and 7 MBs per RAM block by default
+	 * enable CAN FD mode
+	 */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg_fdctrl =3D priv->read(&regs->fdctrl);
+		reg_fdctrl |=3D FLEXCAN_FDCTRL_FDRATE;
+		reg_fdctrl |=3D FLEXCAN_FDCTRL_MBDSR3(3) | FLEXCAN_FDCTRL_MBDSR2(3) |
+				FLEXCAN_FDCTRL_MBDSR1(3) | FLEXCAN_FDCTRL_MBDSR0(3);
+		priv->write(reg_fdctrl, &regs->fdctrl);
+		reg_mcr =3D priv->read(&regs->mcr);
+		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);
+	}
+
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
 		reg_ctrl2 =3D priv->read(&regs->ctrl2);
 		reg_ctrl2 |=3D FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
@@ -1261,7 +1335,10 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_close;
=20
-	priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+		priv->mb_size =3D sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
+	else
+		priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
 	priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
 			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
=20
@@ -1600,6 +1677,18 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	priv->clk_src =3D clk_src;
 	priv->devtype_data =3D devtype_data;
 	priv->reg_xceiver =3D reg_xceiver;
+	priv->offload.is_canfd =3D false;
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
+		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+			priv->offload.is_canfd =3D true;
+			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
+		} else {
+			dev_err(&pdev->dev, "canfd mode can't work on fifo mode\n");
+			err =3D -EINVAL;
+		}
+	}
=20
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
--=20
2.17.1

