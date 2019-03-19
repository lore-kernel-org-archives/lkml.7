Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3E020989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rAsv/4NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCSFRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:17:32 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:47940
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727217AbfCSFR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIhuU+lN0AlG0CerfTDJUdiJdAOPMCotryasHjIusSo=;
 b=rAsv/4NSbdaAclGG5f6XZnFw0zc946m4Nix5GvKIN3jpf/QXy6F6SNT8blnPX/UR6OkSX7b9k1KgynkQsS+vqQVWC9738Wb60IFCxEwL6s191HgE4zMBM7QVwMNi+jXNb9Wvitk6ohKZ1yMLXaHzDltyJEx2meH7DXMrynYQNVg=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4796.eurprd04.prod.outlook.com (20.176.233.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 05:17:25 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:17:25 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 3/5] can: flexcan: add CANFD BRS support and improve
 bittiming setting
Thread-Topic: [PATCH V2 3/5] can: flexcan: add CANFD BRS support and improve
 bittiming setting
Thread-Index: AQHU3hMKb8NKSoM460+sFNg8fOKn3w==
Date:   Tue, 19 Mar 2019 05:17:25 +0000
Message-ID: <20190319051512.14950-4-qiangqing.zhang@nxp.com>
References: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0137.apcprd04.prod.outlook.com
 (2603:1096:3:16::21) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fb82244-63ac-419f-d066-08d6ac2a2c69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4796;
x-ms-traffictypediagnostic: DB7PR04MB4796:
x-microsoft-antispam-prvs: <DB7PR04MB4796E25F30C22415A2CB6ECEE6400@DB7PR04MB4796.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(54534003)(5660300002)(1076003)(76176011)(7736002)(52116002)(53936002)(478600001)(6512007)(14454004)(305945005)(4326008)(71190400001)(99286004)(6506007)(106356001)(102836004)(105586002)(26005)(2501003)(8936002)(97736004)(71200400001)(446003)(25786009)(11346002)(50226002)(86362001)(66066001)(81166006)(476003)(81156014)(186003)(486006)(6116002)(14444005)(256004)(68736007)(8676002)(386003)(6436002)(2616005)(3846002)(6486002)(110136005)(2906002)(54906003)(316002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4796;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qdzWTnyNxZTPdX8MNSr7qCiEcbme5tM+5WhVd3aj1Cw9h9JDnHdwhSKcb0LWAIvzW5SWOZyq6kQ624Kil0PV84Pw7ijr2NRrn97IeWVZnamSPOtGgaX69Y9Bv2msHFiOSS2gsmkWdPbVkEp1pCEdQ+N4mpOdrbrDG91/eU+GEXB7fxqzmtCws92X0P4Fxpr/PlKDNgTh7M4M6Rz2phTlw2NID6e6YTlkghSudpRyLKnvkVfZyhvUn9Yj6e3II3IYBRrxd0wr6Gw3xDG++YXhb86RaaWvMmAJDQOKfQSMnzKU3rMXTfCRH612+pib/wDJgjs1id5/3r2/MyRWS8KDhU3nNeFjpA67zDLbjDS6/VOGFCuAlsah3Iu38HY58PWHgzrv8nQqZZrp3tp31jiZukELjOnDHNhZhX6qzhZ1IKY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb82244-63ac-419f-d066-08d6ac2a2c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:17:25.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

This patch intends to add CANFD BitRate Switch(BRS) support. Bit timing
always set in CBT register other than CTRL1 register when CANFD
supports BRS, it will extend the range of all CAN bit timing variables
(PRESDIV, PROPSEG, PSEG1, PSEG2 and RJW), which will improve the bit
timing accuracy.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

ChangeLog:
----------
V1->V2:
	*both normal mode and fd mode use CBT register to set bittimg on
	i.MX8 platform.
---
 drivers/net/can/flexcan.c | 116 +++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f28a4c3e8087..63363f1b85d1 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -138,6 +138,14 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
 	 FLEXCAN_ESR_WAK_INT)
=20
+/* FLEXCAN Bit Timing register (CBT) bits */
+#define FLEXCAN_CBT_BTF		        BIT(31)
+#define FLEXCAN_CBT_EPRESDIV(x)	        (((x) & 0x3ff) << 21)
+#define FLEXCAN_CBT_ERJW(x)		(((x) & 0x1f) << 16)
+#define FLEXCAN_CBT_EPROPSEG(x)	        (((x) & 0x3f) << 10)
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
@@ -1063,18 +1077,63 @@ static void flexcan_set_bittiming(struct net_device=
 *dev)
 	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
 	priv->write(reg, &regs->ctrl);
=20
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
-			FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
-			FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
-			FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
-			FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
-		priv->write(reg, &regs->fdcbt);
+	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
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
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+			reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
+				FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
+				FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
+				FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
+				FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
+			priv->write(reg, &regs->fdcbt);
+
+			if (bt->brp !=3D dbt->brp)
+				netdev_warn(dev, "PRESDIV not the same, may risk transfer errors\n");
+
+			netdev_dbg(dev, "fdbt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+				   dbt->brp - 1, dbt->phase_seg1 - 1, dbt->phase_seg2 - 1,
+				   dbt->sjw - 1, dbt->prop_seg);
+
+			netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x cbt=3D0x%08x fdcbt=3D0x=
%08x\n",
+				   __func__, priv->read(&regs->mcr),
+				   priv->read(&regs->ctrl),
+				   priv->read(&regs->cbt),
+				   priv->read(&regs->fdcbt));
+		}
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
 	}
-
-	/* print chip status */
-	netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
-		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
 }
=20
 /* flexcan_chip_start
@@ -1684,6 +1743,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
 		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.bittiming_const =3D &flexcan_fd_bittiming_const;
 			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
 		} else {
 			dev_err(&pdev->dev, "canfd mode can't work on fifo mode\n");
--=20
2.17.1

