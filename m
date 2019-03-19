Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02544C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B577B20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f30T+dsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSFRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:17:34 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:47940
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbfCSFRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuQcQtwhn5fuapVv3cJTBAavGgn+z39HenzekLe9TqE=;
 b=f30T+dsiQhWhkdtvoy8tIjxusUbkdxVatqMXsIt0H888OAlQt2MJufFdtXo4MIx0EEzGbDWZcF27nrroY26gMigP6jpd2qT+8KGzV/KDRAeRdrT9H2v91a+GDB+gzNwTc0onJNMKkyCRg9B9ez3cZo23FmP27Y39OnDG+Cir200=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4796.eurprd04.prod.outlook.com (20.176.233.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 05:17:28 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:17:28 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 4/5] can: flexcan: add ISO CAN FD feature support
Thread-Topic: [PATCH V2 4/5] can: flexcan: add ISO CAN FD feature support
Thread-Index: AQHU3hMLnLNyr3dNUUWzbvZa9pXDOA==
Date:   Tue, 19 Mar 2019 05:17:28 +0000
Message-ID: <20190319051512.14950-5-qiangqing.zhang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4103824f-68be-42cf-bacd-08d6ac2a2e21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4796;
x-ms-traffictypediagnostic: DB7PR04MB4796:
x-microsoft-antispam-prvs: <DB7PR04MB4796CE556E44A9974FF2E3B3E6400@DB7PR04MB4796.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(54534003)(5660300002)(1076003)(76176011)(7736002)(52116002)(53936002)(478600001)(6512007)(14454004)(305945005)(4326008)(71190400001)(99286004)(6506007)(106356001)(102836004)(105586002)(26005)(2501003)(8936002)(97736004)(71200400001)(446003)(25786009)(11346002)(50226002)(86362001)(66066001)(81166006)(476003)(81156014)(186003)(486006)(6116002)(14444005)(256004)(68736007)(8676002)(386003)(6436002)(2616005)(3846002)(6486002)(110136005)(2906002)(54906003)(316002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4796;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DOVD/qRU3sOBoTBM43OeEaQ96WYaSlmirfTNFBQ3PWeTWc48cyvSSw4khZkxLPJegnqLXK6jtTE8GL1aegOoA4YLzr87QD7bHS+3c9VfIL53oRoKUxetpA37E44NQlcM6N4+IXOG3ZADJYHRkSJe7nCnGGbdDcEoGpD0yNUfZBtOWS6z5KSw5d1A1csvc66xsBqxzdtsaCHTj9v/TUp2HrodFQZF5kYccmGtzlrRLhduc6fkTRzuD92leeYEX4DKaGtbpWOnaiBg+Iy/n7YtFkao/sscjeSzYG6iphrr063Y0zdHedI/QnsNW42GsMjHdk8qWVqDHqMCB/EL1jWLcGa8ELJ3+dgBauXYPKWX/ZRk0DU6u/8o9lop+/zg53v4dJN8zLT5FUwEwBa4teuALTtpnHHgRvPKKbU71g0j3eo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4103824f-68be-42cf-bacd-08d6ac2a2e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:17:28.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4796
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

ChangeLog:
----------
V1->V2:
	*None
---
 drivers/net/can/flexcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 63363f1b85d1..bcc935ebd105 100644
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
@@ -1257,6 +1258,12 @@ static int flexcan_chip_start(struct net_device *dev=
)
 		reg_mcr =3D priv->read(&regs->mcr);
 		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);
=20
+		reg_ctrl2 =3D flexcan_read(&regs->ctrl2);
+		if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+			flexcan_write(reg_ctrl2 | FLEXCAN_CTRL2_ISOCANFDEN, &regs->ctrl2);
+		else
+			flexcan_write(reg_ctrl2 & ~FLEXCAN_CTRL2_ISOCANFDEN, &regs->ctrl2);
+
 		priv->offload.is_canfd =3D true;
 	}
=20
@@ -1742,7 +1749,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
=20
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
 		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON=
_ISO;
 			priv->can.bittiming_const =3D &flexcan_fd_bittiming_const;
 			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
 		} else {
--=20
2.17.1

