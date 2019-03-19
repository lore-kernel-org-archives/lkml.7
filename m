Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4287E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pfqf2MhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCSFRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:17:39 -0400
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:47697
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbfCSFRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENSShnOdJ6MbtTp0EH6aydGHweGUU/Ib3ogZlsXJ+sY=;
 b=pfqf2MhTMdCl9LAg5b4dqoiX6Hg8r97tYFtrDhiQOyvAE7Tf81iCdVe8WLfvwIC3RSbR35t0M0PRv/18LHZWMbaBtLKGd7A4Y5sKlNJ+Q7qW7ibDGbu02OdwqvKaQJhr4A9d15kGOl1ab5iaX0PdlsvKuyNIa0BxO/dVpmXpIZk=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4796.eurprd04.prod.outlook.com (20.176.233.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 05:17:31 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:17:31 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 5/5] can: flexcan: add imx8qm support
Thread-Topic: [PATCH V2 5/5] can: flexcan: add imx8qm support
Thread-Index: AQHU3hMN44d+G2aUlEatjh+Xy2BBdQ==
Date:   Tue, 19 Mar 2019 05:17:31 +0000
Message-ID: <20190319051512.14950-6-qiangqing.zhang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2d83b202-36d8-4505-cdf2-08d6ac2a3001
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4796;
x-ms-traffictypediagnostic: DB7PR04MB4796:
x-microsoft-antispam-prvs: <DB7PR04MB47961CEAE051203F35B4618BE6400@DB7PR04MB4796.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(54534003)(5660300002)(1076003)(76176011)(7736002)(52116002)(53936002)(478600001)(6512007)(14454004)(305945005)(4326008)(71190400001)(99286004)(6506007)(106356001)(102836004)(105586002)(26005)(2501003)(8936002)(97736004)(71200400001)(446003)(25786009)(11346002)(50226002)(86362001)(66066001)(81166006)(476003)(81156014)(186003)(486006)(6116002)(256004)(68736007)(8676002)(386003)(6436002)(2616005)(3846002)(6486002)(110136005)(2906002)(54906003)(316002)(36756003)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4796;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0+cSlgFigdWjv8oeJ0Z7X7IKuO5bKiCcXrS4WP+4wSS/hTVHWZOIYOhkLV9rDylxIIjjf/Qs1nAT+ODNsUN3Qb04zFvxT9UscRxUUgWoiXV6N93oPJbmSVhCHnDNU0mFgnxVAxfFWUdiz6vNMN6+EmLz+6KeJFksiur0Iz2H84x6AbkRrWZ3gg37vi3rGJN+QWsRFDElDqNmvXAF07YTv+gtmYUIQnLxvmgnEcGXwuRInpFn69ElJY4bb96mSH5rWpFWz0n7hGNmc10DjOimv6ubjPSBFiSUcNgrWesM6CfLdwYus9R4KP9OzUkVV0xWS4/khyyVUGRX/LWx32+AzJntGijusb7wYQtQQb/3qeI3fTz/ob6KVdu1W3jif3VVYroOYf9+rq+tCazX+8cDg2ZOe3uaM9wZWPp4V6Q/vKA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d83b202-36d8-4505-cdf2-08d6ac2a3001
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:17:31.6504
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

The Flexcan on i.MX8QM supports CAN FD protocol.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

ChangeLog:
----------
V1->V2:
	*None
---
 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index bcc935ebd105..064bdb960cb7 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -346,6 +346,12 @@ static const struct flexcan_devtype_data fsl_imx6q_dev=
type_data =3D {
 		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
=20
+static struct flexcan_devtype_data fsl_imx8qm_devtype_data =3D {
+	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
 	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
@@ -1630,6 +1636,7 @@ static int flexcan_setup_stop_mode(struct platform_de=
vice *pdev)
 }
=20
 static const struct of_device_id flexcan_of_match[] =3D {
+	{ .compatible =3D "fsl,imx8qm-flexcan", .data =3D &fsl_imx8qm_devtype_dat=
a, },
 	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx53-flexcan", .data =3D &fsl_imx25_devtype_data,=
 },
--=20
2.17.1

