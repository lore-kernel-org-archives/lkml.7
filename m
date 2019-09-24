Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33972C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003CD20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bDdAXuOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409528AbfIXKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:39:25 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:60264 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409464AbfIXKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:39:24 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: yxcAnS5Cx+0OSZh7J9sGXRZzFwMaKALUT2joS+c3oZ+pjIhgJzfrS6DW9efHMJ7aUQVffBHa12
 8xAZdP4IZRSePdj07+6BBana0UolKoCCxVZlUsVtTYDq5+gczOx8wqZ5+++u0dF7oCNBtf8XBD
 bzILHuBSf+tiQsy0cHLizs0bgroWJuQ3U3b6xzEcXTRX2jVMiyEUd6/7U1priV4DsTSRSk2SQc
 IFi1d5TsNxKd64m9wRLi5brV4PQWIGm7uzYrRzzLp0E9MM3CF4PEd76psVn2U/QRtdJtg5PKAI
 +1U=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="50092179"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 03:39:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 03:39:10 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 03:39:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knu2YOFDwn3FBf1C3HU6ryty9bfxJIlZGRdEdPjpu35r3nfRTOofTbDu9dkrOIFK+nuvjORK+dulZx7UqYfPNpg3WuV7dg1oEMZHmalc5W/X9iVbP804BfkZDJkySIPK2g8hUzi8ESPJSIR6oWwhnohJOWS2Z19OKq1eOCqkeYyqYf/eMB0qgdLDHqWjHLubOW68z3B3mNp3Ai7mTLr7MjQnWtrnD2vhCumGGVRi9tzJvnsCWxpHWrYoG+zV0ln31pJ795lgKkUbnoTbtbtpTiLCQVsV3TOn1YHVsemboIBBf/tX3I3nxFM3CXtyamR+2539zELLofgFY44FWbQk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As+ms4wjLa7Le5WArmHHH+aFlBCBe04coxYEtc3ySY4=;
 b=Uguk2v15AC0hpfpfjmJJR90dwEj6uYHtAgxoED4PtKtRjzO6nRG4NPMbsWj4HcTkkemXNu3ULapD8KBVhMjgzy3VN2GTHUd7oojZlTLgj71dlL1gWfQO0jo4sBmQ0oc1m6QqdnSv4DY8dS86wen5tQSb+KHqKWCMqb9UEffUL+WTnVM1fy/QXBzyL0VhLRbSoONXPxPqcPY4E79wc1GwNitsa5D7s0uFmlNvvef0vDGdRhml99avz9M2jYC1pgep2OlrlEShgF9UZyjIQ36B+EgufIC/pcROOB44utDFKy24fyHgJxr1FkdqqBcFPgh5B6Y3gqs95+Fpbnh7WoolOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As+ms4wjLa7Le5WArmHHH+aFlBCBe04coxYEtc3ySY4=;
 b=bDdAXuOu3i5Vo7iE3DxyiosTvnvcQbcWiW2UcqIu1L0gsN4k4Rr4A9p9F7S2awOjxh5yGKlxjnhRs1woi8qxueyCPRasJ6S31yGbJG+rmCrlZLugBwOXsU/e022eODkXH0BNgqdWLWguBTgyiuk6ek4vwDR3KyfSrspGxSStCM4=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1499.namprd11.prod.outlook.com (10.172.36.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 10:39:09 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2284.023; Tue, 24 Sep
 2019 10:39:09 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH] clk: at91: sam9x60: fix programmable clock
Thread-Topic: [PATCH] clk: at91: sam9x60: fix programmable clock
Thread-Index: AQHVcsRMYTeAx/4mlU+eM6N6BpGrrQ==
Date:   Tue, 24 Sep 2019 10:39:09 +0000
Message-ID: <1569321191-27606-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0253.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::26) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb2a32c4-f020-4372-ac07-08d740db6e6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB1499;
x-ms-traffictypediagnostic: DM5PR11MB1499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB149913BF3E3D3E8F806F74F9E8840@DM5PR11MB1499.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(6506007)(71190400001)(66066001)(4326008)(6486002)(256004)(486006)(71200400001)(66946007)(2616005)(3846002)(6116002)(81156014)(81166006)(14454004)(6436002)(186003)(26005)(8936002)(2501003)(107886003)(54906003)(36756003)(50226002)(66446008)(52116002)(476003)(305945005)(99286004)(6512007)(8676002)(66476007)(110136005)(4744005)(2906002)(316002)(66556008)(64756008)(7736002)(25786009)(478600001)(386003)(5660300002)(86362001)(2201001)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1499;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Vix6hbLYP+kAVTxq9EiNHIylqXiM0kNFM9T4WzeqiEpunr2lF2J5TkIMQVyswh9MXOIFgV4tAyxvniDTBAtweKIhIpRa9lfd29+/CxLMLUT/ILJPc5Ui35EFyE0gyUz+H48eJ5R4fx2eCRDDyi5FuyOrz5Q7bu3IqnsxxNbH/beiFyzEwdoArWKeUdz3pOYJgZymmttipXvVGnqd25WsFImeZcNdehr3bMp6I/3O4Jjsi/UGvbgZ53cIODNZA0W4W0qREEXOAaTCU9nEAKeaKfD0jAmGMRWHLZH4r51s+5GyZZ4hXknYYmYlAcB21gTV82N3jK54q6Jm+2Fh8yIRTaTkvmDInx/OwjIdRKQ6SZTvntWzJZF7tCACPwntQbNyegFvneB4qR8lfgYP/+lts7WTWdI/u1bC0hJFuwSgpM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2a32c4-f020-4372-ac07-08d740db6e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 10:39:09.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9vAC58vMy3FKJEHDO50y/jnT8UuPDFMuvfFMiZNb/cZEg0fOUt55dXWOIyhHnqW+QWwGFKEV3wv1S9/uvBRHbrKv3E7XpJREzuzMGQ8AF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The prescaler mask for sam9x60 must be 0xff (8 bits).
Being set to 0, means that we cannot set any prescaler, thus the
programmable clocks do not work (except the case with prescaler 0)
Set the mask accordingly in layout struct.

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/clk/at91/sam9x60.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 9790ddf..86238d5 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -43,6 +43,7 @@ static const struct clk_pll_characteristics upll_characte=
ristics =3D {
 };
=20
 static const struct clk_programmable_layout sam9x60_programmable_layout =
=3D {
+	.pres_mask =3D 0xff,
 	.pres_shift =3D 8,
 	.css_mask =3D 0x1f,
 	.have_slck_mck =3D 0,
--=20
2.7.4

