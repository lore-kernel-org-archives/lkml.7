Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2158C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DC2218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yM+bROJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfB1G53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:57:29 -0500
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:50120
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfB1G5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVpTT9N9BfpSTzNQ/mYWPhgkmWRlQmUXbSnjcUBNarE=;
 b=yM+bROJdPcuG2/yes7zxF+3VMyIJrTO6yyA+IN8lnIdYFQAgezwRPXZXpa/9BykAJFZNAcJNMj79PfaW54fUHaRIbFSO2I3XvbF/6xzwM1cB36oKRTCTIIp5MH5GEkpy12AqcviYe02Cof/TPr56Vft4B/eyBh7kQumr1KuOYA0=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5322.eurprd04.prod.outlook.com (20.176.236.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 06:57:18 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 06:57:18 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/2] can: flexcan: add ISO CAN FD feature support
Thread-Topic: [PATCH 2/2] can: flexcan: add ISO CAN FD feature support
Thread-Index: AQHUzzLYpxYA2O6KK0+nwrwDzpVlbA==
Date:   Thu, 28 Feb 2019 06:57:18 +0000
Message-ID: <20190228065506.3488-3-qiangqing.zhang@nxp.com>
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
x-ms-office365-filtering-correlation-id: e0107d85-60ec-47f8-61bc-08d69d49fa88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5322;
x-ms-traffictypediagnostic: DB7PR04MB5322:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5322;23:LUHY0vFmI2qkrfb3giihKWwdynRhmNECW/7GI9m?=
 =?iso-8859-1?Q?dCILb06L+QstKQL+jRm5ZDatkJE0pl7UfI2/mkGRLVG7R3GeeihnKujFFa?=
 =?iso-8859-1?Q?AKS5QSQUhotZQgQYnH9VexRyGcOVQQ3BVY4Ar1mzpBSWbMzzbPZiTWlr62?=
 =?iso-8859-1?Q?zMleO2CENK42XTM8iwg7RSdcLZfNHrbHKLca2kttaLY5ydrlA6PnPV/Fvg?=
 =?iso-8859-1?Q?uPBfvbJ7WkO/zdZk58/bAS+ACTf8C9YFpwTkPpvyRSmWG8SCIB1SeYyvUk?=
 =?iso-8859-1?Q?inLxopeDs4wwgxl5usPCgs2PfGoekXGrHU/4X4aRDH7/nKurnCDJgNa6qo?=
 =?iso-8859-1?Q?+ImjEFy3wESdaH8KLr9bmnImQ2c5iKLzdNJScmT2ZRYiget977qE4XIvIY?=
 =?iso-8859-1?Q?Abd68dwaorgCosV7WbN+yPhTSgN3E/TjAo86EFVvYO+zNZMP9WzmhKDwxw?=
 =?iso-8859-1?Q?eHdr9FzrU809gjGFiPnD2FZkvAKrxZWXTqPXeYDPeWuQ0qyj+J0whozFh3?=
 =?iso-8859-1?Q?KqpjO49JBxCva5lm9LKVtmJxENjCZsbaBVLzKJnjl/FYcYE2DKDzyfY3OX?=
 =?iso-8859-1?Q?bq5R8WbDIgEgs2uMBjsRWRr/gtLYil0f54AsAofUW+5L3bc5SDWt+/vDU+?=
 =?iso-8859-1?Q?f9zjtbGdg87kzlIg3R4kuzSxHU76D+x0je3jqp2rt0igegLKOfs+RQTzK+?=
 =?iso-8859-1?Q?RSzlvzFZnBQTJC3cWT/ji4rTN2LcdVQH3ooi1x+RiZU41WT9nD1Z7A5DgV?=
 =?iso-8859-1?Q?M8at9MdQirrDYZ8D6AUvSz4AbUZc037azt1QmuDXluIQnrKpHPdofDrffR?=
 =?iso-8859-1?Q?JsyGwboUx/YzC//7KG79GP6vS5tkbYCRitJagZf5/rj1jcEGyGFS+3e5jD?=
 =?iso-8859-1?Q?miMbUH6AN536hGOroewIxXPqBhzhFVAhaY3kW52H7ysZWmzh8ZsMM8PK3s?=
 =?iso-8859-1?Q?VF72JYwOD8TbnH4hCFgOIuC8VKzl6CCqaaKshYm67yOOOyNfL/9nSs199m?=
 =?iso-8859-1?Q?xZaqZpbUpbeZb6sypbmYfZ3lghuNCJo7G+PMFKy1HIyA3JUXNxN6eUItic?=
 =?iso-8859-1?Q?izAEKcw18zC6+5PPoUz1uIRTbPtAEKFd2LEiyivXq8JI2rp41EKN9dUPZl?=
 =?iso-8859-1?Q?21wKfy9BrKxPVZevelop0MDJvo8US1TMnfG6VuvxeDX08oTW2WchW6rnx1?=
 =?iso-8859-1?Q?MTkzLQbWI3PM0SJMdIgKvMmy0tjhSElmnK3eFx23GEK7TL+8P9LIZ8Idvw?=
 =?iso-8859-1?Q?5PjLQ3dHwdVXiQGrPxxRHRpVhVWJC5O+1HfvY48qSeufBChXyersO4YShi?=
 =?iso-8859-1?Q?uk=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB53229C20A04CF58929FFB498E6750@DB7PR04MB5322.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(6512007)(53936002)(105586002)(14454004)(25786009)(478600001)(81156014)(81166006)(6486002)(36756003)(52116002)(6436002)(6116002)(3846002)(66066001)(76176011)(99286004)(7736002)(8676002)(186003)(305945005)(71200400001)(2616005)(11346002)(476003)(446003)(2906002)(71190400001)(2501003)(486006)(256004)(14444005)(1076003)(5660300002)(26005)(86362001)(316002)(102836004)(110136005)(4326008)(106356001)(8936002)(54906003)(50226002)(6506007)(386003)(97736004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5322;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n8sBcjVhjHc8bHIEysHI/39mIzAqbyoBRteDFnKDXhkZTA5h3aDWcyUSwLjAdLJRKLpX4dLjSOQJ2nmGchA4ZSQhlHetCnBX3G1BFJSAF/BeFizGwlPYWmct2SOAVNZZYaZMsfNb9lTG+MHO+L0VBRVdhP8I2alc7bi+tYGCQ0q/CakTY7U2/A3A8U0KbGobDJhlT9FaRc4l3/xC+UdrOcZsxb/OWDd28yof9jqLVKg2ygd5j2rWZ1w/Tg9w4WjWkr3NVeiJzAOfkxxGSE/gHa8wKdV2ILXPxUhyisSEXtTgXU4/Cw9yfimJ/I0OFi36kYS3ZeERwe6shiASEAIsBFx1ryOBRX0hDPWhWkkrYshhWnYmHnRkPrpw3ky947jMPHh4VpbDbp0mzsHkGrmisK9Ss1jJHB4bvYZnl3r4Rj0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0107d85-60ec-47f8-61bc-08d69d49fa88
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 06:57:15.3179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ISO CAN FD is introduced to increase the failture detection capability
than non-ISO CAN FD. The non-ISO CAN FD is still supported by FlexCAN so
that it can be used mainly during an intermediate phase, for evaluation
and development purposes.

Therefore, it is strongly recommended to configure FlexCAN to the ISO
CAN FD protocol by setting the ISOCANFDEN field in the CTRL2 register.

Test Command:
ISO FD MODE:
ip link set can0 type can bitrate 1000000 dbitrate 4000000 fd on
fd-non-iso off

non-ISO FD MODE:
ip link set can0 type can bitrate 1000000 dbitrate 4000000 fd on
fd-non-iso on

NOTE: if you only set "fd on", driver will use ISO FD MODE by default.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4ba35f9eb515..25e077a68db9 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -91,6 +91,7 @@
 #define FLEXCAN_CTRL2_MRP		BIT(18)
 #define FLEXCAN_CTRL2_RRS		BIT(17)
 #define FLEXCAN_CTRL2_EACEN		BIT(16)
+#define FLEXCAN_CTRL2_ISOCANFDEN	BIT(12)
=20
 /* FLEXCAN memory error control register (MECR) bits */
 #define FLEXCAN_MECR_ECRWRDIS		BIT(31)
@@ -1227,6 +1228,12 @@ static int flexcan_chip_start(struct net_device *dev=
)
 		priv->write(reg_fdctrl, &regs->fdctrl);
 		reg_mcr =3D priv->read(&regs->mcr);
 		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);
+
+		reg_ctrl2 =3D flexcan_read(&regs->ctrl2);
+		if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+			flexcan_write(reg_ctrl2 | FLEXCAN_CTRL2_ISOCANFDEN, &regs->ctrl2);
+		else
+			flexcan_write(reg_ctrl2 & ~FLEXCAN_CTRL2_ISOCANFDEN, &regs->ctrl2);
 	}
=20
 	if ((priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) &&
@@ -1729,7 +1736,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
 		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 			priv->offload.is_canfd =3D true;
-			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON=
_ISO;
 			priv->can.bittiming_const =3D &flexcan_fd_bittiming_const;
 			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
 		} else {
--=20
2.17.1

