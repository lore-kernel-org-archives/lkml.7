Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8762EECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C9E207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bQFAYv4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfIKGjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:39:31 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:32797 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfIKGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:39:31 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 4MjtpdDzsT8UazPDyHxKTpMh8uF/Ui8oIJyJmN0/RWJkDTPE4ffPz2BsV9M8pXNWemfZuaJUZ+
 FMDQpBLedgcqElVeRaG4vhNf+SegoPdaJQCAKOxtBINouQJ+BjUwn47Fv2os9gxBUOqsgogEd3
 lrXpYC4k+cphl5nBHW8sdeqNMKtkGRAgzltWgrCJVhpFG6alhNekDBMcVim1VCO+NcwU31Gztb
 J1lGjREJYVhWciDfrXOL0qYOI2RCTkeiG68uIivx/p5DyW6b5LeLKfVMB2Z+XbpMvxMcQ8K30C
 e8k=
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="48626358"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2019 23:39:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Sep 2019 23:39:21 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Sep 2019 23:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMKMXl8VanIhJ5JFWqc+esDnlLEu3/eRyYq5hML9ri6/fT+CDxgP6JTxb+yMtjcinDWaffSu2/xJr5KKQyu0FopnqyIvVJWte7tMdcKJL+bT6lInO1D/Zr8VFr77IPd/TBGhWDCDu1wuOWfex2fl61lwr+UCdBEpAdyo0hdDcApz4E2g7LfIdbSiJLCENGxQ8mYh11S+1MRShnQgD3Wx6nSem/Qg4yJ7d6djVW+f1ZAcHdh9XFDd02wVJ8j1xfDvbHzR/CPs52L2nk7SAyFWjeHVOfIkFwQI+RgJnmLL+MarpEZ5GQVJdK11rMyC1FAihtRhg6wGirEUhM6ML2w6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clgXdp6N4YZ5vYtAVU2H2dia15Jmgb6KwvWmO9tQor8=;
 b=K/F5iKshuZOVOtePt/0RAMmKNGjmvMjb59fwuQlpHoKU1f+sn3zoj5gxAmUYXwDd5vqkZbvQupaH386xcXMTpUEw/qRSEdqUssmz4SmyJCyGMiG1Rpup5ml7BpT6Ily15U8Rpj3ORwIBijhpL4Mc4DjLcEmTasBOqSa+52agfX/UPLdj4Kz4e5m+ceA6jX6rqFHsoxhZY0iuwiSPJ4uHLqtJvcb6EgWk5wY9YVHLOJWW7pkfq/M2EJ6QuYjPLIgtoAWGRvOg7iCvWR7b1q1v7zFVwXl3TvQFpiYMFi9L7S8NmKT9jt9+nqTUwGGT+zkYUUINAFP2Wmm9cBi/u2Z1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clgXdp6N4YZ5vYtAVU2H2dia15Jmgb6KwvWmO9tQor8=;
 b=bQFAYv4CErNTZ4C0g+dncgW8The+1tw34CiepQ4coAldnYb6aecnVrPmtePFyMoHXVhHfQ7TXrOBis5pi/4laYGwgHFIgX/ej/UdlYc4rVpEmsSUq/E2/HerOO0Art0RyXjTjwzkJZxl002PeP8v+VycTc1ymc2kD26s+/ySXlY=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1946.namprd11.prod.outlook.com (10.175.88.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Wed, 11 Sep 2019 06:39:20 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.018; Wed, 11 Sep
 2019 06:39:20 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
Thread-Topic: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
Thread-Index: AQHVaGukjPTRbry/ckGMFC3Lf3IeQA==
Date:   Wed, 11 Sep 2019 06:39:20 +0000
Message-ID: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::23) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25e91481-975b-48a5-f39b-08d73682c698
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1946;
x-ms-traffictypediagnostic: DM5PR11MB1946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB194647A27D01C43742279D06E8B10@DM5PR11MB1946.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(25786009)(8936002)(478600001)(2201001)(99286004)(36756003)(6512007)(8676002)(81156014)(476003)(52116002)(4326008)(2906002)(50226002)(71190400001)(107886003)(86362001)(7736002)(6486002)(2501003)(186003)(6436002)(66946007)(66476007)(66556008)(64756008)(66446008)(2616005)(5660300002)(486006)(53936002)(81166006)(71200400001)(305945005)(4744005)(316002)(256004)(54906003)(3846002)(6116002)(110136005)(14444005)(26005)(66066001)(6506007)(386003)(102836004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1946;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r8GbFVnW6YZ9XwzwNiO7E8KP1dQa7YvG5DeubnDOVg9MuzE3r3+VApYSpo+lxgIh38nrkpqjp2hLjkkHKPPQh5tv+oR3/wPcoYpkh1RGfjQsyucZ9QdhQyDnvovw6BHuKIA4nsJkw1y8zeHHobLlEzffULxR7xOdmxDhGhzdzCuq7AlgMXeFBeJXX1qORp/yyRvylWc1C7cipdtfv71Dn+cOTMGj2MOGudqdUiU8IC/Wie9EXM5LLZH0eBUPa2/h2Vx1MkGYYtNwspj7tiYbELrwqeQLClGkWsy1i3EMLjq3hqjPjm9DMYYWRbYZ2AFyuD/xA3JDVgFbq+mrqzlIOPO+QIqbBWRWcVClZRAPWBO/KfB0Ew5UM4DshRjJh2CP7CDLCgr/pjFSQXi3UWr+KyRvLO31V12CU9ZVZTYbClY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e91481-975b-48a5-f39b-08d73682c698
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 06:39:20.5203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9RDofPCMYAAgsTdjxP8E6utXaEb4WaImlmiKP/LNfa1nvTL6JuM92jz5tn33R/7DPDRrM7to4pirNKRqGaihmDyAibbkeJp8DASKburk+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The PLL input range needs to be able to allow 24 Mhz crystal as input
Update the range accordingly in plla characteristics struct

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/clk/at91/sama5d2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 6509d09..0de1108 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -21,7 +21,7 @@ static const struct clk_range plla_outputs[] =3D {
 };
=20
 static const struct clk_pll_characteristics plla_characteristics =3D {
-	.input =3D { .min =3D 12000000, .max =3D 12000000 },
+	.input =3D { .min =3D 12000000, .max =3D 24000000 },
 	.num_output =3D ARRAY_SIZE(plla_outputs),
 	.output =3D plla_outputs,
 	.icpll =3D plla_icpll,
--=20
2.7.4

