Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF73C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SlMPsNn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfIQPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:42 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:8110 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbfIQPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:33 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: W6e3A3urWHfRUtE5GbDbHhDSm14ypSq5z8iWNaLLxIz4RA9Win3pcAcFrMk9BnDI0I5TD7IuE+
 IBQjTG8grs4QCf0F9mS/8Cuun2BjNuGGG4eEsN1bn9BMIynXW3+8tCnerMPrhFHfTGzg9iwLBn
 PT0f/p35s3wBbSpT7hXIzrD4mWLqaOAfthAveUKz3gVXRTyFBts1/oEZ84mGNnw7sPjOGsOhEM
 gUjew7x7ob3f8rHOMlkn4O3ngwLTgcTVaKleaikyGZEfrVz2b1EJUUJ3Sntyedfo2gpJ0iJK/0
 D4Y=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="46517782"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:55:32 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSo/k/wKKEKCQAogFQO8KMbLhmv3KunaU2Yr89/RFOXd8AS7PiTqZnxvwHYukTy88MEt9f/pjYA31+uvcveYYBwFb1BCojqEUbXmFJzxasKbluJ2+vnHq6/9J278UWMF4ktMqfdTDC2oWIkhXPOf2WhpYnL9z0G2SzIlBThW/IhL60Dmat+WUlkPjXDg70klBUlj4a+rW7Xv3wwilT77ColOc63c6aXmUQBJb8DTz45y4hAa2Ug09zA7320lHgxHj9vaf5D4iHo4D9LriMaSSFusi4KviCFouMdmK6JjRfKQTGpQ8S8d5XGz5Ebijqq2ZbA0l4S7BeqoCWDz9QHbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5/g0lwApDKVGpkmk3ZFMtF7NqjQRER6QfSnVFEfA8c=;
 b=XwHEC1mdo6V2ERSg4fSgV0HWCdRbuY04fXpqjjHhlpv/HgHb1VgqDjpJgDlLmvlCmRUSP43tKANWdTxh0Zk0LvDuPcADNuM4MAst9cEe8EocbnnLB1Er60i4SlTbeYptaCc+NhVDtxLI2HvynP1H2kZUIOI603BiwZ5uOT5tJRBva7ohRMeUwTIbjdgE+PVyj05vpwcWtjNFJAS6DecdykM9Awei4qjNuAZ193H4P12PoY07ODQDt/nYyqwpKP99rgz1DDEArGqWGa/cHm+KfqjeLCqyhVKWIrMt1tyxwJ7h7cLuUkhphW5QQR0k7b03M7jeNHz2Z6AAwc+mPInJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5/g0lwApDKVGpkmk3ZFMtF7NqjQRER6QfSnVFEfA8c=;
 b=SlMPsNn+0pBHHD47LcDIy37J9grJVcPGgWki4i1S1wKSqEJCCJoDn87lnq8BHR577suim3xNEPNNLSA/HlhyndpAmhI6WMeAWuXokatq4UTevhXexwhYYljHnetThJD4jUV6QNwRlqPDR9LExQEYpalnATkwi1pE4UerTOktTOE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:55:26 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:55:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 14/23] mtd: spi-nor: Drop duplicated new line
Thread-Topic: [PATCH 14/23] mtd: spi-nor: Drop duplicated new line
Thread-Index: AQHVbXBSRN+it9xUPUKx+lZiCnNVTQ==
Date:   Tue, 17 Sep 2019 15:55:26 +0000
Message-ID: <20190917155426.7432-15-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7a2e377-9195-43ba-b09a-08d73b87747b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984567E602C8389857650F0F08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(14444005)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ReqTEVTBbIT0q/cmXTdr9pWYAdqx0YzzJFidkakULJtFLcHra2cxo22x77tc4ZqxSjudsq9gDziKk5SyNeq2mYBLsYTpCjqzAMIf+Ph5I2Ae6wA9se+Va0j4axnFA9li0q9RE9qI7Jc6wkHtThDY0gHn+bHLpB1e9tVFgz8ZoGOntkwZztheM5TT8R8TSs+aTMpE/giENPJL/Pw1zml1vBOrPl1yNgMkD4A1U39r5nrex/cF7MAz7pamR78LwDWbNfSMR0o2hq1IFAMRClZl6ij6hCBuZxZgmdHxql+eU/EGjEPbgw64M430feEkGAkm3OyxoKO+MoAm+2j9f4UaiEjmXISnSjR2ZswwoyLj9YbfLlcj0swqcgv6KEgauadYqgWebg9CxEzQTa7FPjXhz4g7EVP5ayYORSJGsRQL1PM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a2e377-9195-43ba-b09a-08d73b87747b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:55:26.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2ae0vWKCrSB4G9fjdCppmJiE5C3cgLrvT4BYDBK5aSK8ANTKwZeESWmDFgllKHGCDIP83M0UptYgw9m7cgDzzCNDR3bbcd3Y/FlNPbMOEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Two new lines, remove one.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 62b9298473b4..3e4691b6522d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -841,7 +841,6 @@ static struct spi_nor *mtd_to_spi_nor(struct mtd_info *=
mtd)
 	return mtd->priv;
 }
=20
-
 static u8 spi_nor_convert_opcode(u8 opcode, const u8 table[][2], size_t si=
ze)
 {
 	size_t i;
--=20
2.9.5

