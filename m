Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885A020651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="VgpML7xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfC0ObM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:31:12 -0400
Received: from mail-eopbgr50132.outbound.protection.outlook.com ([40.107.5.132]:15327
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727709AbfC0Oaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTy2Yqlb0ksCKbuvBwJDDfOMe7ESWB83Ex/4UpntVdQ=;
 b=VgpML7xtVsjpJqHZIZglcMQgiDt/XJvsMRBEyRa8Ah93hBS17/Q0drg6m4l14ohs1acrSMCFlKbt9lqzoNfBs1oyTrP3vgpJxhceVORNfci7k6hComEvXdE8FsrzI2Vaz+sobWJZS0C9D9xoEEfS8QUhquaMTaXrIvxEkwU05Sw=
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM (20.179.1.31) by
 AM6PR10MB1894.EURPRD10.PROD.OUTLOOK.COM (52.134.117.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 14:30:52 +0000
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14]) by AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14%2]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 14:30:52 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [RFC PATCH 4/4] spi: spi-fsl-spi: automatically adapt bits-per-word
 in cpu mode
Thread-Topic: [RFC PATCH 4/4] spi: spi-fsl-spi: automatically adapt
 bits-per-word in cpu mode
Thread-Index: AQHU5KmutKOAcVt2iECfNjtmXOx7lA==
Date:   Wed, 27 Mar 2019 14:30:52 +0000
Message-ID: <20190327143040.16013-5-rasmus.villemoes@prevas.dk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0055.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::44) To AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:a5::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceb9f35c-7e0a-4a34-adc4-08d6b2c0d0c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR10MB1894;
x-ms-traffictypediagnostic: AM6PR10MB1894:
x-microsoft-antispam-prvs: <AM6PR10MB189441A9EBFBE2A6116DE5B88A580@AM6PR10MB1894.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(99286004)(72206003)(74482002)(66066001)(2501003)(14454004)(44832011)(6512007)(25786009)(256004)(5660300002)(53936002)(107886003)(7736002)(4326008)(305945005)(478600001)(6486002)(105586002)(106356001)(81166006)(8676002)(81156014)(68736007)(42882007)(54906003)(110136005)(71200400001)(102836004)(8976002)(50226002)(8936002)(186003)(26005)(6506007)(386003)(2906002)(36756003)(97736004)(71190400001)(76176011)(6436002)(3846002)(6116002)(1076003)(52116002)(446003)(11346002)(2616005)(316002)(486006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB1894;H:AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ri7o7yBT+iVSxKbDma2ovoPY0K0PHJztcIbgbKzgvWPxgM3WimQ8DxfjBJoAFC5Ss0YT2RzkxZJq8hn8y+oQusHpwZNYkL8e/uBwNFccrAb9/4VZudkviWEI6tpWxRafKxht5eHG3ab66iW6cIUsuUAVDOWF7p9EKQ4j0jS8TQ2Yq+q/eiwjjkZ+zVH/St3eo/TZC5GfobxKiXoppcCKI6SZiDnX08k8UYwjev1qmAGo6ljkTIEG+/dnmeyYmZ7MavmRPCbkoN2NWQQ32Ec5ZAW9rYU9Bsw798h5sDOLnD2uuRmysW3E7r2wtHyxRFdIva9gvue1mawK/1sTXKTpvfk7jOpZ09Dz4TAX9HGgUMPjhXh4TfmTlzvEaLitJHezGA8jSKL4FPyC4pMi2X3D75FmaFjgE6f5c3DyRXYVFZo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb9f35c-7e0a-4a34-adc4-08d6b2c0d0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:30:52.8829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking one interrupt for every byte is rather slow. Since the
controller is perfectly capable of transmitting 32 bits at a time,
change t->bits_per-word to 32 when the length is divisible by 4 and
large enough that the reduced number of interrupts easily compensates
for the one or two extra fsl_spi_setup_transfer() calls this causes.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/spi/spi-fsl-spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e2b341943796..b36ac6aa3b1f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -363,12 +363,28 @@ static int fsl_spi_bufs(struct spi_device *spi, struc=
t spi_transfer *t,
 static int fsl_spi_do_one_msg(struct spi_master *master,
 			      struct spi_message *m)
 {
+	struct mpc8xxx_spi *mpc8xxx_spi =3D spi_master_get_devdata(master);
 	struct spi_device *spi =3D m->spi;
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs =3D 50;
 	int status, last_bpw;
=20
+	/*
+	 * In CPU mode, optimize large byte transfers to use larger
+	 * bits_per_word values to reduce number of interrupts taken.
+	 */
+	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			if (t->len < 256 || t->bits_per_word !=3D 8)
+				continue;
+			if ((t->len & 3) =3D=3D 0)
+				t->bits_per_word =3D 32;
+			else if ((t->len & 1) =3D=3D 0)
+				t->bits_per_word =3D 16;
+		}
+	}
+
 	/* Don't allow changes if CS is active */
 	cs_change =3D 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
--=20
2.20.1

