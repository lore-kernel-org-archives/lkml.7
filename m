Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42222C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108E020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pa5Sdu+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDBMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:45:57 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:24078
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729165AbfDBMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v23ZKkQHRk5YODMuye+vtoJV99Ye4sWjvxHGNvkmRk=;
 b=Pa5Sdu+cxk+SQZZAfg3kCVswrurkqm0kL8PDu8s9AbN/5Pe8hg6QYMExygrEWc5VXwpS2I/D0RoWA2l3WbHvgEtFulN31+Eq9mF1UwF5gK+b7jW+oXzgIesWhOw60Fgg2T252zy0oWuKR5iWp4LVHQ9vVZPrp8NOEQYb3B3amCA=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB6405.eurprd04.prod.outlook.com (20.179.244.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 12:45:53 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159%4]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 12:45:53 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: lpspi: add missing complete in abort func at dma mode
Thread-Topic: [PATCH] spi: lpspi: add missing complete in abort func at dma
 mode
Thread-Index: AQHU6VIBRlYUz7qkm0iTks1lZ+egJA==
Date:   Tue, 2 Apr 2019 12:45:53 +0000
Message-ID: <20190402124609.22157-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9574e3b8-7359-4148-a2d1-08d6b769242c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB6405;
x-ms-traffictypediagnostic: AM6PR04MB6405:
x-microsoft-antispam-prvs: <AM6PR04MB64054B90A282E695414D5D7FF3560@AM6PR04MB6405.eurprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(53936002)(1076003)(102836004)(2351001)(3846002)(2501003)(71190400001)(6116002)(26005)(6506007)(386003)(2906002)(54906003)(81166006)(8936002)(1730700003)(5640700003)(6512007)(68736007)(478600001)(36756003)(6486002)(81156014)(52116002)(99286004)(50226002)(4326008)(8676002)(316002)(14454004)(25786009)(14444005)(256004)(6436002)(86362001)(71200400001)(106356001)(5660300002)(66066001)(4744005)(105586002)(6916009)(186003)(486006)(2616005)(305945005)(476003)(7736002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6405;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9uBgXwuHq+pkMm90XLIM7g7tNyMwdf1J3G4pELS9P6xHsUjUK+/lacI6k/MTsSlqoKS/lsfYOz1OllPvEQlDPdG9KwHG4WkBR7LTLPm+v7tiCviL+/8VI5WOzGeav/AT2M6qcBQgkcpaycns6hYmtxMiyJsNQXTEgbNT80Rrykh6t9jwRzZiDj2Lz46RR+zs5YMvoJ5wSR+a/7oZCAdK1sF/NrnzgkUAI8L3fD2KQ9riMIXh5EAWiePH9Fo766/yB24d1F+OhqHmLQHHjFps3Pa4uZ8lcEYlxI4ypmN8cQG8M4YTT4Rh1Mb55EFHRtOqFtGxorr/sNmaHUJt0+1UTbILQAXrAmpebi3RG+JKPxVWl9XUn7QSFM36v1YGwreZuAQsafBwOqE38bFa2IKkmexdpx28wFcCsoc37PzRpJw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9574e3b8-7359-4148-a2d1-08d6b769242c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 12:45:53.0421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing complete operations for dma_completion to fix the
problem of blocking at the wait_for_completion_interruptible()
function when use spi_slave_abort().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 0252cae0b35b..33b6a8affd55 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -482,7 +482,13 @@ static int fsl_lpspi_slave_abort(struct spi_controller=
 *controller)
 				spi_controller_get_devdata(controller);
=20
 	fsl_lpspi->slave_aborted =3D true;
-	complete(&fsl_lpspi->xfer_done);
+	if (!fsl_lpspi->usedma)
+		complete(&fsl_lpspi->xfer_done);
+	else {
+		complete(&fsl_lpspi->dma_tx_completion);
+		complete(&fsl_lpspi->dma_rx_completion);
+	}
+
 	return 0;
 }
=20
--=20
2.17.1

