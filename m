Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F83DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFC220651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="gjIlz0/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfC0Oa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:30:57 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com ([40.107.7.113]:35543
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727972AbfC0Oay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdjVWfpKaEvk96aAb9OOjnieMh6+4UP3G9ErD3SwCOk=;
 b=gjIlz0/WHeor3g/tQEnG2rfY/GhyZJ79dPiu9BSaarJupYFe27My7WN0FcTlVvaRoLvy2jMZt7CVpjZwtUqawy4K/U/R/GvYbW1wpDsN9jwAt+ZUJJd6i4bbVmGcfR0bpvYDHcbcacUCtMaXDGkjqDu5zULEXgDYiji7arwu+q8=
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM (20.179.1.31) by
 AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM (52.134.117.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 14:30:50 +0000
Received: from AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14]) by AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a442:a35b:115a:ef14%2]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 14:30:50 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [RFC PATCH 1/4] spi: spi-fsl-spi: remove always-true conditional in
 fsl_spi_do_one_msg
Thread-Topic: [RFC PATCH 1/4] spi: spi-fsl-spi: remove always-true conditional
 in fsl_spi_do_one_msg
Thread-Index: AQHU5KmslSS7/P637kGSh+cRRYuD0g==
Date:   Wed, 27 Mar 2019 14:30:50 +0000
Message-ID: <20190327143040.16013-2-rasmus.villemoes@prevas.dk>
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
x-ms-office365-filtering-correlation-id: ccc19e32-f820-4422-6464-08d6b2c0cefc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR10MB1877;
x-ms-traffictypediagnostic: AM6PR10MB1877:
x-microsoft-antispam-prvs: <AM6PR10MB187793FC65CBF8B76E60C84C8A580@AM6PR10MB1877.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39850400004)(376002)(346002)(199004)(189003)(386003)(7736002)(72206003)(5660300002)(186003)(76176011)(8936002)(2906002)(4326008)(305945005)(102836004)(26005)(42882007)(97736004)(68736007)(71200400001)(71190400001)(99286004)(25786009)(66066001)(6506007)(52116002)(53936002)(81166006)(3846002)(256004)(105586002)(107886003)(486006)(446003)(14444005)(6436002)(106356001)(2501003)(6116002)(11346002)(1076003)(6512007)(6486002)(54906003)(81156014)(110136005)(8676002)(74482002)(316002)(50226002)(14454004)(36756003)(2616005)(44832011)(476003)(478600001)(8976002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB1877;H:AM6PR10MB2661.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wUr3bzxgeR39SQdm27QZYgUSEOOh609QE3/JYW/atnA+iBuKjeSPf1NoQzrRv6F0aEmE3/AioHjtKNLQMIXJuAn8dirVfcRHERuMh7y3GwTs4/GvY2d8BBSfeox8+D2hGTtukUzV9AUzb691SBF/rwi//yl10ofk0YyW8h1JsWtS/AfEoI945GkF9cVLLNbNxjQ1duTR1XaO6pBLgDIWh76fvppTLvFjGHeDJBnsqa2KKJDoZm4Tn6S4Sdt1Of3QBauYBfio8+sQfszS3KCv6G7F/kn+lHARATEh6he8kDTwcNlAHaO7sEa6PWax1rKz5PdTapmah1kJ50cKNkalbapVJPnkkqaIOGM3+ygppBuuikFB2OUc/efbAdMZY3jWYNjgSkynK/I+Qsr/UF0VqJ6bpb6BTlhNnQA/FmVyvm0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc19e32-f820-4422-6464-08d6b2c0cefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:30:50.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__spi_validate() in the generic SPI code sets ->speed_hz and
->bits_per_word to non-zero values, so this condition is always true.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
This of course relies on no spi_message reaching
->transfer_one_message without having been through __spi_validate. I
believe that's ok.

 drivers/spi/spi-fsl-spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 3d7b50c65f36..6d114daa178a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -384,12 +384,10 @@ static int fsl_spi_do_one_msg(struct spi_master *mast=
er,
 	cs_change =3D 1;
 	status =3D -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			if (cs_change)
-				status =3D fsl_spi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
+		if (cs_change)
+			status =3D fsl_spi_setup_transfer(spi, t);
+		if (status < 0)
+			break;
=20
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
--=20
2.20.1

