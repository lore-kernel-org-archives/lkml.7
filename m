Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11722075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="TaTF5SaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCDM7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:59:47 -0500
Received: from mail-eopbgr150138.outbound.protection.outlook.com ([40.107.15.138]:26089
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfCDM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oA1O+sOGKMoIxGePZsXsfGqRcnMBKw49Mnfu8u8v2I=;
 b=TaTF5SaE7Q4KI9KTyLMQIszF4GtL4vuSqbzbkT4KEvMsQ13QAYynWKwK4zNJpT1/4H3cBlMw+67l2vi9vlyHlUUx2Qcqe2IscVHc0vPQsgKcfrxQvEre6t4RuT5HYX/u2xIBFdLl/Kix/zWiXODAoVUEFUePpmPSCl5fQsiEaXo=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1758.EURPRD10.PROD.OUTLOOK.COM (10.165.194.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 12:59:42 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f%3]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 12:59:42 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        Per Noergaard Christensen <pnc@deif.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] net: dsa: mv88e6xxx: support single chip sw_addr offset
Thread-Topic: [RFC PATCH] net: dsa: mv88e6xxx: support single chip sw_addr
 offset
Thread-Index: AQHU0ooiDH2KrqMx8kGD7LZV2/HnjQ==
Date:   Mon, 4 Mar 2019 12:59:42 +0000
Message-ID: <20190304125933.5653-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0051.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::22) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fbdaa5f-6708-4b76-abd8-08d6a0a144dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1758;
x-ms-traffictypediagnostic: VI1PR10MB1758:
x-microsoft-antispam-prvs: <VI1PR10MB1758E03AE0DF5A30FB4EAD038A710@VI1PR10MB1758.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(346002)(366004)(396003)(136003)(189003)(199004)(8936002)(110136005)(54906003)(6436002)(2906002)(316002)(478600001)(97736004)(68736007)(26005)(102836004)(8976002)(476003)(2616005)(386003)(53936002)(6506007)(1076003)(186003)(5660300002)(99286004)(44832011)(52116002)(486006)(50226002)(42882007)(4326008)(6486002)(71190400001)(81156014)(81166006)(8676002)(71200400001)(105586002)(25786009)(14444005)(36756003)(305945005)(74482002)(66066001)(7736002)(256004)(14454004)(6116002)(6512007)(3846002)(106356001)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1758;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB1758;23:t3LDdITlkoFefZBAmOS4lDobWfQDoLlD8662W67?=
 =?iso-8859-1?Q?/MHAtBQx8AQLmFs6FwD193+tEyLKZ8O5TC011uL3bZC3q1u25WM3zGDB3k?=
 =?iso-8859-1?Q?GKSXuCBUTNAntHmsmc734L+nSsYSGRZuaLhj/0D17dJs8CJqADu0I3RHwH?=
 =?iso-8859-1?Q?hqWksFIQPeyT6q9XRfQl62VbwSXIuAu6ix8yaNAaCJXAuRNibNJVGc9MSw?=
 =?iso-8859-1?Q?Mp/8RJYLQD9DbBsKj89ikTCuCJy08OYNZMueAkT9N1/wPekVcNjkllUmQ6?=
 =?iso-8859-1?Q?gvKyYEHom3Ovzi7IdObk+lU8Gq+zC5XlxV5fvTYyAAgg9RlaYk9fWlOV8e?=
 =?iso-8859-1?Q?+GqP2/JvA1kCtohdiJtJvbnNEZ/d8iGVDQP3euqZzpp/hVLZclzK8AZgsA?=
 =?iso-8859-1?Q?AfGX3xPfhp7LE7wy2H7+AUf1qpwKZCKp/rKJZYuzLhHBataAt72usX48BU?=
 =?iso-8859-1?Q?2oqjcy9P4yB3tsrth4RGfKK80EWN0KZZI/ZsbPALjlmomxJWkivZCKoy04?=
 =?iso-8859-1?Q?+hfBap5YxaQmbyCsbhCnQwo0OetEAfn9i22DsYwgNZ1mx/PmrOqxDVZUh1?=
 =?iso-8859-1?Q?2zH1M4ZCn0kdWt25wmEPHt8zyPcHSj78qlPaCuGgv8adNJPbIJxYnt2tNp?=
 =?iso-8859-1?Q?0wso2jUF5X4BYBxeXxdWRJibxLMS+zj0upnvk1bRtUpdC/ckmwC3ipdE+F?=
 =?iso-8859-1?Q?xyNMBT0y+4ZofQv1TZjufDnQHHq8szTvqEufjWLt0gztNpkXXw9XpHBuLu?=
 =?iso-8859-1?Q?97Z97v19gWC5rshTj8FojPsk8NVPd3xJgjM+Vgf6lSzfO+zmSTdDM7Mr0d?=
 =?iso-8859-1?Q?OpIyK6OgRS2yCsPQ1W8SBA4KkexmXpd+Iil8Py6+M5aKjt5iZmy3cqVzkb?=
 =?iso-8859-1?Q?jtD/kPf4WVNfkFN3jgN/y72Dwr/DWBreDUJ5ewJSeorP3V29jRj5SuMjg0?=
 =?iso-8859-1?Q?AbD9+VAR2nSXyeVg8v+JHC1bn7E6xGnS8kbWoKCpo1bajNFTOXOPm932Ya?=
 =?iso-8859-1?Q?/9J+XX7uHHS1PvHMdh4yCfNUurGj/LwuoTpRDmYGVAOcjoqgHBf+jGEVLK?=
 =?iso-8859-1?Q?Au4SOguEQMJ0hCMeL/bh91ChRksF5jV7xtjmXVAb1ZAiYq/56txqUn7V6+?=
 =?iso-8859-1?Q?Zmrr/1H9/r0MGL2Ada6OWPoRC5fvnv56B6JVQM6SPkHxeYmykoSt1STnoN?=
 =?iso-8859-1?Q?aKuEYV9y0cpJ36CqQA8PvqZksq/ZbgqxPAtz0JWZGnCB2PnA4W6i2dLta7?=
 =?iso-8859-1?Q?Xn0O2PyXkxKFdHHrwMOvc1B99uQihGQG/S5e3cn3wEeUQA7n7MOPPAxFxV?=
 =?iso-8859-1?Q?Cg=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WLZuEKOOdeDVE/srjHzRzQ1LtAguQG/Xr6AcRPArlGYcu/fK3/cGSSdzjBZkiF+hyUC1IHv7qVKqMJzxaxnBSL4xaAidQGrMKesOshZDd1wNGnE6F3PSvuzgavkJoMpikBfP1T13Q097d5tl4FOfQoghY40i4RYDnggdjpFYGwTVb4/smzFrK0RUeJdyr+Nj44z5SLBFgTinM3ACZod0NCXlTkKfEdbOpDz/CXz0EtGYKiLOmy544MWulkzBIxuE95XAlccnpPX4ied3jE9fid/2T0CEDB1csLi88iXN35GrlGx2l85iCmw3zIvrKZYBguwLRSq8pcr2zv4cytbn6hDY8MsvlnxniqURcLz7zvyUJLRTxaZ6AJfu2D0moUFohDaAdpJYLKurlLwrj3CkeyVQNPRKg6FEhVyBFoqXeHU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbdaa5f-6708-4b76-abd8-08d6a0a144dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 12:59:42.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Per Noergaard Christensen <pnc@deif.com>

The 88e6250 does not support multi-chip addressing. However, one can
still have two of them on the same mdio bus, since the device only
uses 16 of the 32 possible addresses, either addresses 0x00-0x0F or
0x10-0x1F depending on the ADDR4 pin at reset [since ADDR4 is
internally pulled high, the latter is the default].

In order to prepare for supporting the 88e6250, change
mv88e6xxx_smi_init and the single_chip_{read,write} functions to allow
and honour a non-zero sw_addr in single chip mode. Since this only
changes the behaviour in the sw_addr!=3D0 && !chip->info->multi_chip
case from returning -EINVAL, it should not break existing setups.

Signed-off-by: Per Noergaard Christensen <pnc@deif.com>
[RV: reword commit message]
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index 9588a5f8719b..b482058d11dc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -87,7 +87,7 @@ static int mv88e6xxx_smi_single_chip_read(struct mv88e6xx=
x_chip *chip,
 {
 	int ret;
=20
-	ret =3D mdiobus_read_nested(chip->bus, addr, reg);
+	ret =3D mdiobus_read_nested(chip->bus, addr + chip->sw_addr, reg);
 	if (ret < 0)
 		return ret;
=20
@@ -101,7 +101,7 @@ static int mv88e6xxx_smi_single_chip_write(struct mv88e=
6xxx_chip *chip,
 {
 	int ret;
=20
-	ret =3D mdiobus_write_nested(chip->bus, addr, reg, val);
+	ret =3D mdiobus_write_nested(chip->bus, addr + chip->sw_addr, reg, val);
 	if (ret < 0)
 		return ret;
=20
@@ -4601,11 +4601,12 @@ static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(=
struct device *dev)
 static int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
 			      struct mii_bus *bus, int sw_addr)
 {
-	if (sw_addr =3D=3D 0)
-		chip->smi_ops =3D &mv88e6xxx_smi_single_chip_ops;
-	else if (chip->info->multi_chip)
-		chip->smi_ops =3D &mv88e6xxx_smi_multi_chip_ops;
-	else
+	if (sw_addr >=3D 0 && sw_addr <=3D 31) {
+		if (chip->info->multi_chip && sw_addr)
+			chip->smi_ops =3D &mv88e6xxx_smi_multi_chip_ops;
+		else
+			chip->smi_ops =3D &mv88e6xxx_smi_single_chip_ops;
+	} else
 		return -EINVAL;
=20
 	chip->bus =3D bus;
--=20
2.20.1

