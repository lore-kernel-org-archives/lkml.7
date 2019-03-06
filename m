Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20905C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA35620828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktWbAPpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfCFKBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:01:17 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:55781
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729765AbfCFKBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD/8LEcJk870BQjOqZCKqW2UnnmRz2dYq2i9m03ZfF8=;
 b=ktWbAPpU0lNHDWUE2yzl7m5TtT88h8sGjUj3SR0eYViRycMqe+NGdgOxI6vdGduTacpCZfOt0gSFCvM8KmZymCYw1gaTlEir2GJLrVMXINxihCdsciM9XSBeRH4vsB2rX8Y5DrUJn0Wis5SZ2wFzCCJsj3cCQ00VH95dWNeCdEw=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4763.eurprd04.prod.outlook.com (20.176.233.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Wed, 6 Mar 2019 10:01:04 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1686.018; Wed, 6 Mar 2019
 10:01:04 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 4/5] can: flexcan: add ISO CAN FD feature support
Thread-Topic: [PATCH RESEND 4/5] can: flexcan: add ISO CAN FD feature support
Thread-Index: AQHU1AOCNZ8JnmbepUSkKImnrv/m9g==
Date:   Wed, 6 Mar 2019 10:01:04 +0000
Message-ID: <20190306095833.20922-5-qiangqing.zhang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5958a5f8-bf5b-4231-7f2a-08d6a21aa509
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4763;
x-ms-traffictypediagnostic: DB7PR04MB4763:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB4763;23:IDjFg0PWUOqNuJP3GfMGLXqTGrnmgwn8nUEA7UJ?=
 =?iso-8859-1?Q?fDhgospmJRvxa4MYF9z6vjPWyLYIBjOvGVvfINB5AGqwx6DjZmIziwei+S?=
 =?iso-8859-1?Q?6SaklXkilX2EroI51DzpGLzqG2U8DVPOKaAkIagy6/qL7FBb4GaIbJ+STu?=
 =?iso-8859-1?Q?giilbfi0MBRDrhuDSP6FOSamEzILgSkd4V7YB0JZUJmK4Be9+IG/t4EtAU?=
 =?iso-8859-1?Q?cr8O7ze4/DYPM2YuitTO+J2jjlgdUeg9/RooFAsn/K3jZ7gw2KBAj/7t+g?=
 =?iso-8859-1?Q?HgsQkZYyjTgyG4MyK1k1TcMq22Bv7F6kYOU5+GAVzBXMK/sINvEvPGz5I8?=
 =?iso-8859-1?Q?XfMdpo2BklyNdrZtzwLmeGdI3BCocPzSvDcOju2u5kKWux71evlUED+4rs?=
 =?iso-8859-1?Q?3YVMkhUnGFpBP4yUYBB+RqNDeKIbLeWAOf8NDoYEA6h9n6MBC8mMSyFGD4?=
 =?iso-8859-1?Q?RvMzlyaUnyWwFyBK2rwXLzQWT7/ccG75wkhzVF5tjiGzAr478SwjPeBMb6?=
 =?iso-8859-1?Q?WQsv/FbH+9f/+zSEDUYBZYuKKuJOqv8oW8c9npV9hQVzNELHYKI79gtcSD?=
 =?iso-8859-1?Q?3hKarpDfanOb1Y3hxrFsiv4VPNIx+FrmO8hqDsSDNaZodQZr1cIklS5efH?=
 =?iso-8859-1?Q?VfIf8RsXP0uxBk9TPaNri3iSsXL56of0FmN+Bi2qy30eKw2rCl3T2C5xP8?=
 =?iso-8859-1?Q?OHw1FoislJZsN0Uhj4JgX6+vW5IGRpf96mJefT+T1wd3kEB5AHIppIoRO/?=
 =?iso-8859-1?Q?pMEV0WcQx/mtEyrVVVBkkghYgMGVEy5l1nI3w+x0k3WF1ZzB5hd3ZaXI/E?=
 =?iso-8859-1?Q?bgqbz1byPOFJaLUsGzfZj7m6L5qSazC8DTVRctz88OlzPw7jch4TBCifuX?=
 =?iso-8859-1?Q?ne5O30oJzfijFeoSYW/zwIn0W8GUAhPJCIesqJLn9zoHUwhCcCQwfBexW9?=
 =?iso-8859-1?Q?9t7VoAAbZxrKWeti/rT+xpQNXwcf1pES9By5o99yd+vQLd0S4399L7+WdO?=
 =?iso-8859-1?Q?twvZGRPncVVnSkaT9mda601kul74DUVU0IOsytPBVjjWoJGeQmQKqluHx3?=
 =?iso-8859-1?Q?iGHyFBy+yXAYfG3wLvFad0cWj8T6tiiGsWiLnGE1IgKrAy4iuaGsU/hsZs?=
 =?iso-8859-1?Q?e38r1rWE59s7Chg9WxdgZVg8hGb/4+AMdMVMYTNGw5n7844IlkdFMmyDMO?=
 =?iso-8859-1?Q?CdCdClEENKb4F5yzKCV3WxPFhpdwdXQ67UMGkThbx/6VH3e8IG5i54WkKU?=
 =?iso-8859-1?Q?BCHK1gdZgFSpCUianQ0cGRNn72xQBENeXYKyiRBFJcOrsu/7Z0UDgTcIrf?=
 =?iso-8859-1?Q?xw=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB476361A32DDD5989DBEDBFA4E6730@DB7PR04MB4763.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(99286004)(2501003)(5660300002)(52116002)(71200400001)(71190400001)(53936002)(6436002)(76176011)(6512007)(1076003)(446003)(36756003)(14454004)(11346002)(476003)(2616005)(486006)(14444005)(256004)(26005)(186003)(6486002)(86362001)(386003)(6506007)(102836004)(478600001)(2906002)(7736002)(25786009)(50226002)(54906003)(106356001)(110136005)(6116002)(4326008)(105586002)(66066001)(68736007)(305945005)(8936002)(316002)(97736004)(3846002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4763;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WHoZ2Hd6Uht0fuZ0yuPWfysY3qlnaR70ZuJ02Z+29Ilv7drNhwYrRKjimhKmCIrLFK9p67yQwza6S7YUHutlXDtB9614R9t3K/VuqL8G2ljofnN12P7BbtgL57Ubq6pCZTjNBSJDTBdK7a7D9TcjrH7E57+Anl4AXJA6mMUXHMC8k3hus6iHi3fHstDJoH9zK0HJOnAStshnbwj4rcasB2N5joa6ZWcbxw9uzIdcLs0seKS7fIQODbPRIIMfSVJ/Cg7CKsTEj7PguX1cEmBgRLGLKAZX2L4b0b8EcBKKDi1LlcSso1bkh2KxCM5KfbzbOuQBvvIZ8jBBXS7vqzGypXeq5Ak3Jz2fMOl9ydsYL/DJAkZKUj+Vsh2zZ3YO7QxP7esMzHnthQAdWDtgz1Ctj67opQveewJcgW6mdx6+53g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5958a5f8-bf5b-4231-7f2a-08d6a21aa509
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:01:04.3788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4763
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

NOTE: if you only set "fd on", driver will use ISO FD MODE by default.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 688bb09b8123..fca014bc530a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -92,6 +92,7 @@
 #define FLEXCAN_CTRL2_MRP		BIT(18)
 #define FLEXCAN_CTRL2_RRS		BIT(17)
 #define FLEXCAN_CTRL2_EACEN		BIT(16)
+#define FLEXCAN_CTRL2_ISOCANFDEN	BIT(12)
=20
 /* FLEXCAN memory error control register (MECR) bits */
 #define FLEXCAN_MECR_ECRWRDIS		BIT(31)
@@ -1254,6 +1255,12 @@ static int flexcan_chip_start(struct net_device *dev=
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
@@ -1746,7 +1753,7 @@ static int flexcan_probe(struct platform_device *pdev=
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

