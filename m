Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3F0C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AF822DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n/L9sp23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfHUDVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:21:17 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:64769
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfHUDVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwGpkcIbXlHzYVEdIqIVrbR6GAlEBTAywsDespWYXag04QWH64s5NdKNcB1CQp604pMWnc5v/ubSgCuwGhAA/IF4GBbr8IvfEYmqle34FydlTxV6GJ2ix1P6vmsqzuOqFNdM79IS1KuuBjJsLJB/3yD60VdPFKZ86eprNp5tt8Vj5p1acSf1L1eVl1bii4ulnG7CqGo0mgXr2F2zfiUaJBlFvFZ7oE93dJzOLYxnGYkH43YNpu9773FVECRlufOomwfakauGU2vg+whU7mAh+WUfWb0R9xuywhtjrQoljONjOX4JRvlvsqxs6wMnKx6F1CAzJTTxf3fKkn1HVEKCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io7iFwEynykuufGsUCfJxElOts6gbTulmWFJMu94KDo=;
 b=L3niB4ohNLMYh428hJf4oiQ1u1axx+r0GVlObn8rVmu7qPaz6r3nXNYx1Zp9TuBVjh2Uw5N65nWUn4Zis0ZiZqcl/9FXkZXIr21DPiwRIt3VntoPqAve1LQ/xrterwnaJ6zDqhMT6mxB4I4hIeU7tH/Jv5kYVeI28eBOvW9VgAIGY+Zl844e32KKkzj2JaMKbmEX/EI/3fAt0H4gKCU6UdODQvh7IqQVGgg9U2XFQUKqim7TkKQvfy1k7B5NMXy+Dm6DUqfISekdQ1pD8w3A2kEp2vMLQ4APisDaqw2/NbMhIA+Zao2nbfog1lHq+zPZyMIHziXmu6JEXJZgN7aOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io7iFwEynykuufGsUCfJxElOts6gbTulmWFJMu94KDo=;
 b=n/L9sp23VSxLZiTJU1g7i5l39um+lySy7076aEwN9QF3WL5W6yUpcKPohVIQihUFxABRZgEw6MxSb2IiG5PDFC8MUHhzwwmNHC5vesewmsaOz8VzGFYBI56arum2c3gyydw4UZ3ssnWWlVx1RKoziXXhXB1qXDMJ6dqk/Iukp3g=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4465.eurprd04.prod.outlook.com (52.135.148.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 03:20:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 03:20:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] nvmem: imx: scu: support hole region check
Thread-Topic: [PATCH 1/2] nvmem: imx: scu: support hole region check
Thread-Index: AQHVV89jBufiQMcQikKEwxbrgUBx8A==
Date:   Wed, 21 Aug 2019 03:20:31 +0000
Message-ID: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13110226-f539-4aed-91f3-08d725e685bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4465;
x-ms-traffictypediagnostic: AM0PR04MB4465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4465391BCB74D011B3ABB30A88AA0@AM0PR04MB4465.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(43544003)(52116002)(66446008)(26005)(71200400001)(5660300002)(71190400001)(110136005)(2616005)(66946007)(66476007)(54906003)(8936002)(64756008)(14454004)(256004)(386003)(102836004)(66556008)(7736002)(486006)(305945005)(2906002)(6506007)(25786009)(44832011)(316002)(186003)(86362001)(4326008)(476003)(66066001)(6436002)(6512007)(50226002)(36756003)(478600001)(3846002)(6116002)(99286004)(8676002)(2501003)(81156014)(81166006)(53936002)(2201001)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4465;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zPV0jZHlKfBSE/uZ7pYfGcOPHsneuUVFbzTqqMBNDgvameuhYpcEZvxn5fpuRT4vd9Sdr9Xsasbr9sYAwv8qMVMXNymU6arH5XU5MAsVqOwYnWF4mCvRvxHKleS2Q929lIx5leXoxJr860xz9Oqw86i+CKGmfOdwS4EbmqpqKHrXJ8Le5cXjTnOcNG9QqMDRO4f/JvFRWN8FQseXxXXl/v7R0eu6Xdn0EaWSY6DKh9cwLoeF1Ua3hryqPrMFG3NVxUtQ0NqTnsQ516Tr9iPL6d3zjUPUT7+GrhZWu0P7+0CplYeDpisz4C13HyEMW6hldgg1HnAaUsBPtGt14SgJKkGX5pYT+J4cT4Wy6d4+8Q5jmf5g3t1QLWFqL3V7IGwcV8B/eeiOQGhmfNkVLpmkD/ZqLf7XQNz1cYMAanyuUAo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13110226-f539-4aed-91f3-08d725e685bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 03:20:31.4826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb3/CX0+oobM+Ah5v1eaJ3+z6BQ0We2fxed0FKf9L7QkiotusmTYNCEVgwy1cJfx6AqB7oiRTNcyWsXIq7Xc1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce HOLE/ECC_REGION flag and in_hole helper to ease the check
of hole region. The ECC_REGION is also introduced here which is
preparing for programming support. ECC_REGION could only be programmed
once, so need take care.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp-scu.c | 42 +++++++++++++++++++++++++++++++++++++--=
---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index d9dc482ecb2f..2f339d7432e6 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -18,9 +18,20 @@ enum ocotp_devtype {
 	IMX8QXP,
 };
=20
+#define ECC_REGION	BIT(0)
+#define HOLE_REGION	BIT(1)
+
+struct ocotp_region {
+	u32 start;
+	u32 end;
+	u32 flag;
+};
+
 struct ocotp_devtype_data {
 	int devtype;
 	int nregs;
+	u32 num_region;
+	struct ocotp_region region[];
 };
=20
 struct ocotp_priv {
@@ -37,8 +48,31 @@ struct imx_sc_msg_misc_fuse_read {
 static struct ocotp_devtype_data imx8qxp_data =3D {
 	.devtype =3D IMX8QXP,
 	.nregs =3D 800,
+	.num_region =3D 3,
+	.region =3D {
+		{0x10, 0x10f, ECC_REGION},
+		{0x110, 0x21F, HOLE_REGION},
+		{0x220, 0x31F, ECC_REGION},
+	},
 };
=20
+static bool in_hole(void *context, u32 index)
+{
+	struct ocotp_priv *priv =3D context;
+	const struct ocotp_devtype_data *data =3D priv->data;
+	int i;
+
+	for (i =3D 0; i < data->num_region; i++) {
+		if (data->region[i].flag & HOLE_REGION) {
+			if ((index >=3D data->region[i].start) &&
+			    (index <=3D data->region[i].end))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
 				     u32 *val)
 {
@@ -85,11 +119,9 @@ static int imx_scu_ocotp_read(void *context, unsigned i=
nt offset,
 	buf =3D p;
=20
 	for (i =3D index; i < (index + count); i++) {
-		if (priv->data->devtype =3D=3D IMX8QXP) {
-			if ((i > 271) && (i < 544)) {
-				*buf++ =3D 0;
-				continue;
-			}
+		if (in_hole(context, i)) {
+			*buf++ =3D 0;
+			continue;
 		}
=20
 		ret =3D imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
--=20
2.16.4

