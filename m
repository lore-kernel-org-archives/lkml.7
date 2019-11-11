Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F99C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6222196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tVIhWB0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKKN3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:29:07 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:3492 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKKN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:29:04 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Ay5tq2Nixy8b/tO9y8IWZu/xAAYwk+tA0JvYCV2b6NQmI3t28RlAmyMRZj+Fk07ROIvCE/7eD+
 rdorvjCC4ePeNIVXYOBZfkW7z7/8RNClIT4YNrqqOq3Mn7qnmyx6/j61Gzjwu6Gq9izJ+mFv1X
 6GvFYopcos1hCNtRP/VfbgbDlqSUhM824Aovsm0Ywf0LvZoPnJzU2huhTrk4xv1B8VQdx0slr9
 ZkPgwFSOXUkOCES23h+4Y1ojyKLtgf9I8U0Q/dvrq+T2tw8neFK2esY/kfQX/4+7eii9cQmBcT
 qLM=
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="54880412"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2019 06:29:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Nov 2019 06:29:00 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Nov 2019 06:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0W8uQsqDKV/0tvIslgZg32f6RlmolCN4iH5waGo3Ja0gLNk76W38pvmeCsgKgOM+EIgP4ixM7CowOgKcDTlEjyQTWM9SfNJOcANdh0PyTrKZPtmMa27OHxnhoOD+s2zufE8sXAO64CqQynZn/RHtf6JhG0GbdI5zxuDaMVmKCthq9QfwnIQT0t5KOq4X92yoZhFUQCqHKcQhfSPqmJ26EhPu9CaD+yzHV984k9SJ+DRgSKeIEXM3PJLlR8EqYQ+2f8BlhdqrcTKcHMbt14/d0M5OFzlDLC64ZZHWTY5qyPeaJ6oLfkFlPZoXrbyDJD2rQcA2k64TNFROmpEWQXDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDLf4SjLygW5bsSavWlu47+tUSzFyMIhYeFOzkX1XOE=;
 b=TR2e8EsD9SfyDeFdIZtCjIMIjOzg4QSKcN0DyAUtO7L+Q28PliJuPpsWZAr4cuNODeLpGRnmvTuJawXyyLuEXABtszemfb+eqTUhi/GN5TaqIMqzSvIP5B1RI4JxI3hNsSSqs0F8xRZDhnnEAtksItGJfYoYGkBPr0mo9xH0VERVgm0tXgL+Jrt74u8QeuLtQwuzLMNG+8XNlEDmTcq4+69mA7zC80qoI94YveaHBebj506wr8G8gS96MBxPKpzuRurYk1ZL23RdNxFurUQcikQe/NZw4/92Gjy29fJmMuCzHgqboZCiJsh8MTLznuFMaNU/SElPKbCNY3K9IPgkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDLf4SjLygW5bsSavWlu47+tUSzFyMIhYeFOzkX1XOE=;
 b=tVIhWB0/RTR7ki+tQG7FlQbVAbjwUcZDoj3IgX4q3siBeJz2/K/cLomKFI7TekBKhwPGdVBkzH9A4qwJGjy63SRT7yJaKHIU1qZtNyddKfBD3WywsZr06JR/dNPATvGNeZ9PH+s1xt7FEQqRFh/StFodtqQfY8YpRLqP5DBpAJc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1449.namprd11.prod.outlook.com (10.172.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 13:28:57 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 13:28:57 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH] clk: at91: sam9x60-pll: adapt PMC_PLL_ACR default value
Thread-Topic: [PATCH] clk: at91: sam9x60-pll: adapt PMC_PLL_ACR default value
Thread-Index: AQHVmJP4gkFvDXEvgEe8yodmIU1IZg==
Date:   Mon, 11 Nov 2019 13:28:57 +0000
Message-ID: <1573478913-19737-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3aba037-487f-4e8c-5dcd-08d766ab1ae0
x-ms-traffictypediagnostic: DM5PR11MB1449:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1449E834529C0B0C551A144DE8740@DM5PR11MB1449.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(81166006)(81156014)(256004)(14454004)(478600001)(186003)(66446008)(316002)(966005)(8676002)(6512007)(8936002)(6306002)(54906003)(50226002)(52116002)(5660300002)(6486002)(66946007)(110136005)(2501003)(476003)(7736002)(26005)(19627235002)(71190400001)(486006)(71200400001)(107886003)(6506007)(99286004)(102836004)(2906002)(4326008)(86362001)(305945005)(64756008)(66556008)(66476007)(3846002)(386003)(6116002)(6436002)(25786009)(36756003)(2201001)(2616005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1449;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YAFuhW+ratvUl5tv16s2UdEvLa1mmBZSdHMDrL+BMK2v36fAoGWOA2tx4DzxL4vYsOmcH2WqVV22SF38wk0323kZgjHYIg18k+js0hdFTuCpQLYp2W5jzC93LnP0vz8G1AE2j7dH42DFvo1GrH3hPKliOk81+5ZNCyOu9xLpd1rhkh+kHhRTFLnLMxxDrOt3ThdHseCgKqt72DGFlNE7YMvtVgI3EubAX8Pt5FS667hUz8LFmUeWqBdPee+EUH6NdcAd6kmW6smhD87hhZ9trIqVsi+cVyI7TmkumC+fmqDQvE2T8EXXUkDne+JqUZHKgn6HiVLl6Ry2KJOeC8Ljk2wKQsd2ywtCCw+kVEWvr9JG4tWqjzasa7ASPeMg9MzLjmWLrsG5eHe4+6b2IwZ/L+FYC008kJ6zAlJHl7mdUtNVWYl7t9usJHO00En18Gp1pMBpALdDVI+8ctaOODbpEqeLKtjol54CSJfZ5jzmlUc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aba037-487f-4e8c-5dcd-08d766ab1ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 13:28:57.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CYPko8o8LQvvv0Pjd/DV7PyrNYh+/xALlDnLALEZONFQlTiwhkWWgyKHpAq1h3QuCF0sD6hSt16Ay1fB5fkBUMTQupzSc+IhJyTjX+MAqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Product datasheet recommends different values for UPLL and PLLA analog cont=
rol
register.
Adapt accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

datasheet link http://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data=
-Sheet-DS60001579A.pdf
chapter 57.7.10 optimal setting of the PLLA and PLLUTMI

 drivers/clk/at91/clk-sam9x60-pll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9=
x60-pll.c
index 34b8178..dfb354a 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -25,7 +25,8 @@
 #define		PMC_PLL_CTRL1_MUL_MSK		GENMASK(30, 24)
=20
 #define PMC_PLL_ACR	0x18
-#define		PMC_PLL_ACR_DEFAULT		0x1b040010UL
+#define		PMC_PLL_ACR_DEFAULT_UPLL	0x12020010UL
+#define		PMC_PLL_ACR_DEFAULT_PLLA	0x00020010UL
 #define		PMC_PLL_ACR_UTMIVR		BIT(12)
 #define		PMC_PLL_ACR_UTMIBG		BIT(13)
 #define		PMC_PLL_ACR_LOOP_FILTER_MSK	GENMASK(31, 24)
@@ -88,7 +89,10 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
 	}
=20
 	/* Recommended value for PMC_PLL_ACR */
-	val =3D PMC_PLL_ACR_DEFAULT;
+	if (pll->characteristics->upll)
+		val =3D PMC_PLL_ACR_DEFAULT_UPLL;
+	else
+		val =3D PMC_PLL_ACR_DEFAULT_PLLA;
 	regmap_write(regmap, PMC_PLL_ACR, val);
=20
 	regmap_write(regmap, PMC_PLL_CTRL1,
--=20
2.7.4

