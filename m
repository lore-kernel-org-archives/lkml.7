Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18048C352A9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03E5208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LN0WFAi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfI0CY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:24:28 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:55097
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfI0CY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWTGtQm4fkZ0aCyUoo6YP/kBCU/Bwp0fT0p547oCWJzIaXqiYsenAWXQqX7n1hfFESU198eZGgJ/ZIGs8hCCYA2lySKND2ikM6wSOvn/DMaUISeq9VIGl3a9IIcXC926vVh2pE0VV8E00k1kDpq0KGEZrhAsSOYDixURzF5Bm6yHa9z0e9cMHMmBhQw0qaNMnX7w9Zl9ApHKxFRDXTD8uDmahEbhtZla2RyOZIt4X/+62YUqgg5HNFNTXjnmOE2EduyY3CsOMKCDeWWoMeFA+CNYlS76KOzsv3gqaNceDDhwqYZjOJexvzutz9hwdtFSBg//X7pbxs4ebWIL1Tzoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx05gsKG28o2amlhGhMrgN0keLE9klZMa40p9JDiAXY=;
 b=nHnNWOF1pCBNJ6QvW6hyP2edYqOm+GqeX4GGkY3aLgBSmi+fFrkZJANQKcRFDATKqGHFyK8OiQvazv58cd/Zm3FemlRPfjKIoUu/m79JU8Hqs8K0yXpeLRzQo5WkpFjUlhc4ceHBL9sUBajKRaGHSerdc5QlWnjHF98kURN4OKe8k0CB1zxOtIKquvHzkw4KgVbz2kroUV3ZuXDKj8gSRnzZ/DXwoY8LC6O2p9oYS78Z/wGZYWRu3Rj/hoZ7/f8Cvt6y6B2jH9lrNX5ewez5ESSJZDShcusqD+0IL+arbC4qJalbX0EjW+QIkeIqNFqMNZLV6GeangJOWL49sqFMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx05gsKG28o2amlhGhMrgN0keLE9klZMa40p9JDiAXY=;
 b=LN0WFAi7kYlHiGZYfhKpC9V7XJYpno6+VWo7cGW7NeiWUyjBv5kAra/ZrMlsV7VHfgThGgp/EnqnBlDspnoRWn50g8nhdyxxCkX/US7xxIi33JYqrFyqOno5JWFID0WDe1V+s5v8lAMEXeaKWfMxww62dBfgXPhcfCn9wqW3SJk=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB5338.eurprd04.prod.outlook.com (52.135.128.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 02:23:41 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 02:23:41 +0000
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
Subject: [PATCH V2 1/2] nvmem: imx: scu: support hole region check
Thread-Topic: [PATCH V2 1/2] nvmem: imx: scu: support hole region check
Thread-Index: AQHVdNqTeL3qiyvuR0mH+QIEq+72lw==
Date:   Fri, 27 Sep 2019 02:23:41 +0000
Message-ID: <1569550913-10176-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12b17aef-c8ea-4f89-a52d-08d742f1b65d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5338;
x-ms-traffictypediagnostic: DB7PR04MB5338:|DB7PR04MB5338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5338153CBDA7566958BE1E2288810@DB7PR04MB5338.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(43544003)(199004)(189003)(54906003)(6436002)(110136005)(6486002)(81166006)(81156014)(50226002)(8676002)(2501003)(64756008)(8936002)(2201001)(66446008)(186003)(66556008)(66476007)(6512007)(6506007)(52116002)(478600001)(386003)(99286004)(4326008)(6116002)(86362001)(26005)(102836004)(256004)(44832011)(7736002)(5660300002)(305945005)(36756003)(66946007)(3846002)(316002)(2616005)(14454004)(486006)(2906002)(66066001)(476003)(71190400001)(71200400001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5338;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i9tWJR9lbvzZ5SjzxhZL2wreggZ6xooxAYQ+mW5cx8YbTjEDe7B4ZkWDL4sfBA/LLSPD/UgPwtlQb6ilKpOe35+FYf74EZs7BwJbzr+xU/j7dkuuu0uJzOVOfFUszRNtTZeWU3hhFwY6b30gfUQQFMuoQVWZgzbVzxHePrU69DL69wmo/xLmmsJ4yTj9Ntu0gHXZE4QZiAd+hNwL5vfqciQRJoUbwN0ftR1Q/j4Bsm5oVf71BZtjb+trOO2jNu7fZtktWn8ZQgkWJigD/PlWv0BGOIo9foPMaPsHleGWWjD5crTWNgBoyBS+DgcXkELoeq4Lm/7YBuWOpTRs7ijFOU5sNoPSPRkWf7AtLo8GONqJCG54lcAztD64uRLTFwRfF14exu8GY15zaOpcCuLVZANcuvqxREb8OxzOb38cuAU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b17aef-c8ea-4f89-a52d-08d742f1b65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 02:23:41.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTKDOCU5zzGx2EkQF9dNTx4yB14/V/Yzp2l4Q6eLdCso9G+q8Z7Z6ueodJbX3GciSFudVmuAMlatLBG5nXlQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5338
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

V2:
 Rebased on latest linux-next

 drivers/nvmem/imx-ocotp-scu.c | 47 ++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 61a17f943f47..030e27ba4dfb 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -19,9 +19,20 @@ enum ocotp_devtype {
 	IMX8QM,
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
@@ -38,13 +49,41 @@ struct imx_sc_msg_misc_fuse_read {
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
 static struct ocotp_devtype_data imx8qm_data =3D {
 	.devtype =3D IMX8QM,
 	.nregs =3D 800,
+	.num_region =3D 2,
+	.region =3D {
+		{0x10, 0x10f, ECC_REGION},
+		{0x1a0, 0x1ff, ECC_REGION},
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
@@ -91,11 +130,9 @@ static int imx_scu_ocotp_read(void *context, unsigned i=
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

