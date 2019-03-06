Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D3CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AF420828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RBPB9oZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfCFKBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:01:13 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:55781
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729791AbfCFKBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RetfmJWC18bDg/PuoiGdMUf0/moJDNF+h6OomEBQZ98=;
 b=RBPB9oZqpkAdJP/JeCH6xlhTflbS6zMSlM8ywJCsG4T+aem8NaBb+sushbVtuVV+wgQ1wmOCIIWSczLSIaYZ6EKe2dDHYMjPZTFCLmlNVu1H/8nCNMDKnI2EFyH/Z+ac5g6TUHYNB5Gw82fw1LOTq3AxLqTZ027iggJXG9lNGgk=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4763.eurprd04.prod.outlook.com (20.176.233.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Wed, 6 Mar 2019 10:01:01 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1686.018; Wed, 6 Mar 2019
 10:01:01 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 3/5] can: flexcan: add CANFD BRS support and improve
 bittiming setting
Thread-Topic: [PATCH RESEND 3/5] can: flexcan: add CANFD BRS support and
 improve bittiming setting
Thread-Index: AQHU1AOAH9okgRdH/kW7LKgtJViqVQ==
Date:   Wed, 6 Mar 2019 10:01:01 +0000
Message-ID: <20190306095833.20922-4-qiangqing.zhang@nxp.com>
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
x-ms-office365-filtering-correlation-id: fa228954-5d8e-4bab-2db0-08d6a21aa32a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4763;
x-ms-traffictypediagnostic: DB7PR04MB4763:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB4763;23:gcCaxnvakJuzRUVEG1xQD6EtrcCUeZgnx9KLGjD?=
 =?iso-8859-1?Q?dsucHj1vCp4wGLpAC+onzut5nIaCT9ywQdCDextSdJf3Pz4+3mR6ucHcP4?=
 =?iso-8859-1?Q?gBSuE4kgkchRefDcE9bCNA05G1CRBReHR6QjIzD/P3fwyQCBiKxK8ATk3w?=
 =?iso-8859-1?Q?wTdDrZKfo1JyAndzQH+vndprwI1ND0f9wSncAr2mYSXN4rbnnJVJ6LNJxB?=
 =?iso-8859-1?Q?LX94LEqNQNRaLEGsi4DMlS4R/9rQ7oDVnLBdjH70/rTzZH5hVMzRCvu0QO?=
 =?iso-8859-1?Q?N37fPCxuPLeZTxDyhndT0YO06rR4u6oxXQ8A07zklX3NLf/RpmOY77hHDb?=
 =?iso-8859-1?Q?u81T2p4E+CfLZappUo/i5Nu7mpJ8usS0tT35Vg3J/Lm3o0ZMbUo4RpoXid?=
 =?iso-8859-1?Q?DTnE9J7osV5r3V3oA2Xe7BuFSswcJP7Km0lV4rhITZJq1KQN7XQPNoZZdJ?=
 =?iso-8859-1?Q?PhikTAMQPkvICup/lWXc3aRTxYBeL9HDo23xA4LlBjCESE9HtDLr7KJ1G+?=
 =?iso-8859-1?Q?Kp+b7h636qAIsAuLz++hcrpL9BDt3VW9/IRR07UewsuodFdlegXR+iFflh?=
 =?iso-8859-1?Q?iw9cXg2GKAQPuN8+rOOiYlyuq4hV0F+a2RP4wmPJjwmn2hlEkiAIsNgdED?=
 =?iso-8859-1?Q?Fr80Lp2W3GqQR/pV0Ri2cv4p+pJZpqPFvYi/a2jRpXZcmT0/5NuZ8skHf6?=
 =?iso-8859-1?Q?Y0Ri1srebZqXEkj01yWUOD79d6Ca51FyalltnRf1sOu6ob9mYZnbhlD4eQ?=
 =?iso-8859-1?Q?EW5hcqXDHzQF4/6wRqE3g2tkDwRdtQzXZVvOcKhE5Swy9ZngIN1gLBJof0?=
 =?iso-8859-1?Q?crG2gOApCGi8II+t8EyJFshvP6h+vQJnVhVo4AqgluejwgywkNvJMwwkzf?=
 =?iso-8859-1?Q?cnERiDf4o63y3PGw3/fT/aNS55rYsLkHu6DfdAj7aHJi60PsKrReCrZh8i?=
 =?iso-8859-1?Q?Vh1Wl+iyEfWZMrQ4FhQt/MJ3gUuhkf7oAqhXzeZC0MlETtW7433JenCfKk?=
 =?iso-8859-1?Q?KC/LbSrV+Q3s4Nlp9pL0+Hx+Q2QZSen20szVfFD1dYRkyAYnp+9ItA82yk?=
 =?iso-8859-1?Q?8TMXYwHAnbToouTQURrmmvPgioyC7mZqEfCcpxK/l0jIdGWY1RSa4GEih4?=
 =?iso-8859-1?Q?fuWFjaFI3em4kTFHw9AWRNDPpfutw47L3i6TT2xNQCYi4wjyTVcjoSzFIt?=
 =?iso-8859-1?Q?PkR7F+3RFcCZBlT5/zprzYoSJ8Sud8Df2vCYJk/E5F8F6PmWencUo4Vbnq?=
 =?iso-8859-1?Q?qjKGlrr+Y4WBgPvrFQlmpp1mdxzl0TpH3O/eNv/smkAaswl7qVofeZN1dj?=
 =?iso-8859-1?Q?EOFd8kXyHbE4sbZAPzlF1fxkRO+gaEcphy6z0bvh5ZZp3dbjiI2Isn9ylz?=
 =?iso-8859-1?Q?mfxXbXqhnUgsF3YIo0LJGoXKzG7pt?=
x-microsoft-antispam-prvs: <DB7PR04MB4763E50FA52F75BC541CC7B7E6730@DB7PR04MB4763.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(99286004)(2501003)(5660300002)(52116002)(71200400001)(71190400001)(53936002)(6436002)(76176011)(6512007)(1076003)(446003)(36756003)(14454004)(11346002)(476003)(2616005)(486006)(14444005)(256004)(26005)(186003)(6486002)(86362001)(386003)(6506007)(102836004)(478600001)(2906002)(7736002)(25786009)(50226002)(54906003)(106356001)(110136005)(6116002)(4326008)(105586002)(66066001)(68736007)(305945005)(8936002)(316002)(97736004)(3846002)(8676002)(81166006)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4763;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 604ifclKGD1Ws0GA9K/KzLblEJPXunXlurjHbkvZotyrSBp5UUaV4g5y0Q5r0oXu4U8iWcOh7zp7EJttf+VMFrJgg3llxtW9ILoxGJNDF/Oj4fjvSIZVwuZM1PmhsCwAhCmH8mG+5LARXIkWlZG1BDGKvg3nz68MtiXAssH9cTh9unbhcU66jaE6sy0iG+a3bspLzePVK6R/qj1gnZDmLdmdafDHhtVuRbCwk2FapQkeuRyU9srY2X7e9QCUklCmGTnbJWjHyVRL6vrCgmtmyVbTTS4yBqutQKKPQHvf/5XBisH/vaHoKjPi4+eUt40fjv57Hm5GJwJnIBZLw+hNEWZLhM89GoBMihKdrEHTcTO9NVY9AHPhXQkr5u3LUNE5003EF2A0TKFhaTiNWNNxqcWTwdw5ZDUrDUIf0IKDrdw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa228954-5d8e-4bab-2db0-08d6a21aa32a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:01:01.2455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4763
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
index eee0c23bb805..688bb09b8123 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -138,6 +138,14 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
 	 FLEXCAN_ESR_WAK_INT)
=20
+/* FLEXCAN Bit Timing register (CBT) bits */
+#define FLEXCAN_CBT_BTF 		BIT(31)
+#define FLEXCAN_CBT_EPRESDIV(x) 	(((x) & 0x3ff) << 21)
+#define FLEXCAN_CBT_ERJW(x)		(((x) & 0x1f) << 16)
+#define FLEXCAN_CBT_EPROPSEG(x) 	(((x) & 0x3f) << 10)
+#define FLEXCAN_CBT_EPSEG1(x)		(((x) & 0x1f) << 5)
+#define FLEXCAN_CBT_EPSEG2(x)		((x) & 0x1f)
+
 /* FLEXCAN FD control register (FDCTRL) bits */
 #define FLEXCAN_FDCTRL_FDRATE		BIT(31)
 #define FLEXCAN_FDCTRL_MBDSR3(x)	(((x) & 0x3) << 25)
@@ -245,7 +253,8 @@ struct flexcan_regs {
 	u32 crcr;		/* 0x44 */
 	u32 rxfgmask;		/* 0x48 */
 	u32 rxfir;		/* 0x4c */
-	u32 _reserved3[12];	/* 0x50 */
+	u32 cbt;                /* 0x50 */
+	u32 _reserved3[11];     /* 0x54 */
 	u8 mb[2][512];		/* 0x80 */
 	/* FIFO-mode:
 	 *			MB
@@ -360,6 +369,18 @@ static const struct can_bittiming_const flexcan_bittim=
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
@@ -665,9 +686,13 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *=
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
@@ -876,6 +901,9 @@ static unsigned int flexcan_mailbox_read(struct can_rx_=
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
@@ -1038,21 +1066,7 @@ static void flexcan_set_bittiming(struct net_device =
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
@@ -1064,17 +1078,60 @@ static void flexcan_set_bittiming(struct net_device=
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
@@ -1199,6 +1256,13 @@ static int flexcan_chip_start(struct net_device *dev=
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
@@ -1683,6 +1747,7 @@ static int flexcan_probe(struct platform_device *pdev=
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

