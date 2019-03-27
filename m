Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23680C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56F320651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="dl31YhMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfC0ObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:31:01 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com ([40.107.7.113]:35543
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728588AbfC0Oa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHj/08tgktO7OGiX91vK1lw4a50Xf/wTD6czHxmcRxg=;
 b=dl31YhMPbd+EJcKKLZ4ThoTkNSF+R8fVHOf7RMAibeMo9EMzoiWJKllGbOnmLA9tyxT3Rardj4jeH9TzaBSf3uS6lSPE1vCbHxj8DOfI42qukV4Rg/5n7UZGmFVLGWKMw7txBNyrDNqzuF5UOJbDgKKgCDYT2seKCajjsr7lBWE=
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM (20.179.1.31) by
 AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM (52.134.117.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 14:30:52 +0000
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
Subject: [RFC PATCH 3/4] spi: spi-fsl-spi: allow changing bits_per_word while
 CS is still active
Thread-Topic: [RFC PATCH 3/4] spi: spi-fsl-spi: allow changing bits_per_word
 while CS is still active
Thread-Index: AQHU5KmtcGfHbrXiqki/KvhP3QsOXw==
Date:   Wed, 27 Mar 2019 14:30:51 +0000
Message-ID: <20190327143040.16013-4-rasmus.villemoes@prevas.dk>
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
x-ms-office365-filtering-correlation-id: 81f6e81a-5bea-4d80-e6df-08d6b2c0d03c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR10MB1877;
x-ms-traffictypediagnostic: AM6PR10MB1877:
x-microsoft-antispam-prvs: <AM6PR10MB18778DB05C072672141AB0D38A580@AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39850400004)(376002)(346002)(199004)(189003)(386003)(7736002)(72206003)(5660300002)(186003)(76176011)(8936002)(2906002)(4326008)(305945005)(102836004)(26005)(42882007)(97736004)(68736007)(71200400001)(71190400001)(99286004)(25786009)(66066001)(6506007)(52116002)(53936002)(81166006)(3846002)(256004)(105586002)(107886003)(486006)(446003)(6436002)(106356001)(2501003)(6116002)(11346002)(1076003)(6512007)(6486002)(54906003)(81156014)(110136005)(8676002)(74482002)(316002)(50226002)(14454004)(36756003)(2616005)(44832011)(476003)(478600001)(8976002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB1877;H:AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DRj/FXXbVNwPurmqv8L4o8jTHpQj04EW99f38Y1NkG3a+41qfR13sbqJHndifJVUkBSkxnumXLt+he4Xk6JzW1MnvNCMel/Y1ua4IfWx0a4LgYvDngUpL825/dedsyMS4IzBSkC8aVQmzf+ulKyQ7/qIa++0hgRX92yctO1g17rKZNDvAan2FPrKMPWRRvYJgbv0KU5p4O13hSaH6SqGPEdDShfi/v8x4ZhvMiU0pxvWpZgN7KiCMum7PvlG5N7X1Mu02B9F9UXZqtZeiCrJEpnCSc71jJ2tabjDLmYEpJYdARWUmXnquQTTswOQT0gIds1E7aE4AWKjZhN8LQFn9z3VhuCrmmZEDvC1TGKhWl8lzxeRQC6T0hDc+pXXbdOyEB0/oQe86jLY8FS3nI+szHf4jczwIg3MC944yjYaEUI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f6e81a-5bea-4d80-e6df-08d6b2c0d03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:30:52.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c9bfcb315104 (spi_mpc83xx: much improved driver) introduced
logic to ensure bits_per_word and speed_hz stay the same for a series
of spi_transfers with CS active, arguing that

    The current driver may cause glitches on SPI CLK line since one
    must disable the SPI controller before changing any HW settings.

This sounds quite reasonable. So this is a quite naive attempt at
relaxing this sanity checking to only ensure that speed_hz is
constant - in the faint hope that if we do not causes changes to the
clock-related fields of the SPMODE register (DIV16 and PM), those
glitches won't appear.

The purpose of this change is to allow automatically optimizing large
transfers to use 32 bits-per-word; taking one interrupt for every byte
is extremely slow.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/spi/spi-fsl-spi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 481b075689b5..e2b341943796 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -367,7 +367,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master=
,
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs =3D 50;
-	int status;
+	int status, last_bpw;
=20
 	/* Don't allow changes if CS is active */
 	cs_change =3D 1;
@@ -375,21 +375,22 @@ static int fsl_spi_do_one_msg(struct spi_master *mast=
er,
 		if (cs_change)
 			first =3D t;
 		cs_change =3D t->cs_change;
-		if ((first->bits_per_word !=3D t->bits_per_word) ||
-			(first->speed_hz !=3D t->speed_hz)) {
+		if (first->speed_hz !=3D t->speed_hz) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz cannot change while CS is active\n");
+				"speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
=20
+	last_bpw =3D -1;
 	cs_change =3D 1;
 	status =3D -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (cs_change)
+		if (cs_change || last_bpw !=3D t->bits_per_word)
 			status =3D fsl_spi_setup_transfer(spi, t);
 		if (status < 0)
 			break;
+		last_bpw =3D t->bits_per_word;
=20
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
--=20
2.20.1

