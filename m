Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84042146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="U1fJ9z6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfC0Oa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:30:57 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com ([40.107.7.113]:35543
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728349AbfC0Oa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVnuYrZwY9ZJ5Fjgt34t0Djxbar20i/E1BPSEJkgNdk=;
 b=U1fJ9z6q0LRelk8dDZYaHKwXJPmyRcI3i3a2pLCYOJPFSpEN935hOLtEftTP44csmCnLdQIoxCaiypxpmuyn08Y/xfJm5uz4xR3I5UVvk0njaanI0tODQeWiR0eun8OkeKUz4gktD7xDHVfeL/YvkPnajslzGK7SCr6GvcggQXE=
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM (20.179.1.31) by
 AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM (52.134.117.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 14:30:51 +0000
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14]) by AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14%2]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 14:30:51 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [RFC PATCH 2/4] spi: spi-fsl-spi: relax message sanity checking a
 little
Thread-Topic: [RFC PATCH 2/4] spi: spi-fsl-spi: relax message sanity checking
 a little
Thread-Index: AQHU5KmtUp6fohYQCkCUFzODOvwphA==
Date:   Wed, 27 Mar 2019 14:30:51 +0000
Message-ID: <20190327143040.16013-3-rasmus.villemoes@prevas.dk>
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
x-ms-office365-filtering-correlation-id: 2e01c5ec-167e-4c54-7b1d-08d6b2c0cfa8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR10MB1877;
x-ms-traffictypediagnostic: AM6PR10MB1877:
x-microsoft-antispam-prvs: <AM6PR10MB18771A8C375E2CE03F8B98058A580@AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39850400004)(376002)(346002)(199004)(189003)(386003)(7736002)(72206003)(5660300002)(186003)(76176011)(8936002)(2906002)(4326008)(305945005)(102836004)(26005)(42882007)(97736004)(68736007)(71200400001)(71190400001)(99286004)(25786009)(66066001)(6506007)(52116002)(53936002)(81166006)(3846002)(256004)(105586002)(107886003)(486006)(446003)(6436002)(106356001)(2501003)(6116002)(11346002)(1076003)(6512007)(6486002)(54906003)(81156014)(110136005)(8676002)(74482002)(316002)(50226002)(14454004)(36756003)(2616005)(44832011)(476003)(478600001)(8976002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB1877;H:AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SlRhxXh1XQnDD3ZgQxN5H7z9TG9fZqvR+OwtZSSdtqDcbkuI0/m18bTfVhNMr8YaMIbX0xTdQ+XOP5kQ0ILRtyjlw7mjLSY4Cs74dJpE77++NNjCGF7ksXMCIURE1m9PnjYZsYAURE9+v2XealrcZoMLEAaBBaX/V2LmnXbYDXZtPSLvVjGme1auG9bvSFtEwX8BY8u02y1xlSM1mxwZXm0/gT/rPHblH3KPmA57cMycVnoq9XZEDcb9tqkEnZR8BhaD0BG6g6G+y6hdwkF0v61raZ1exfIy5nawrRXHNHXnl7NdL5bbc+Nh8ib5GGMMpp7gLPdb7eI2bN9uOqXd1VcgvaAW83m1xypzFryBs//lWMzy2vik9pW1JiKyUgoj3Gno/sa5GOan+5m/o0i4t217qU0ZWU48FEBgBL3ms6g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e01c5ec-167e-4c54-7b1d-08d6b2c0cfa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:30:51.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment says that we should not allow changes (to
bits_per_word/speed_hz) while CS is active, and indeed the code below
does fsl_spi_setup_transfer() when the ->cs_change of the previous
spi_transfer was set (and for the very first transfer).

So the sanity checking is a bit too strict - we can change it to
follow the same logic as is used by the actual transfer loop.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/spi/spi-fsl-spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 6d114daa178a..481b075689b5 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -370,13 +370,15 @@ static int fsl_spi_do_one_msg(struct spi_master *mast=
er,
 	int status;
=20
 	/* Don't allow changes if CS is active */
-	first =3D list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
+	cs_change =3D 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (cs_change)
+			first =3D t;
+		cs_change =3D t->cs_change;
 		if ((first->bits_per_word !=3D t->bits_per_word) ||
 			(first->speed_hz !=3D t->speed_hz)) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+				"bits_per_word/speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
--=20
2.20.1

