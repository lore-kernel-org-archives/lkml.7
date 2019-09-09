Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A3DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2F620863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TzTKABUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfIIPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:30:38 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:47177 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfIIPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:30:37 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ccbNsLOoifjEPI11f+uOX5ZNG0AiPYIuluuO9997OB7beS40YzhY2f5EyydeHenaQ75K093Zfs
 48TcixKRMXuFLnKQ2jQ48lgKEERiWJbrnZcwVVCUMbs23fqucxUzJXo2RpVArJJFr/Qca+Us3R
 RHbjJtmntYrKA1PI+CVhZnDcJjejJHiA8lwkKqTEpDVU5eFsmcXsk+NS5sdo7OcKzOB69T/yYS
 hl46X70tIh7XYZRYfrUlCtMZhD+l+X7XI9BsZNRdC8SlwnK1cVy/lH8kGcCFR6nDIBVIZeONtc
 oW4=
X-IronPort-AV: E=Sophos;i="5.64,486,1559545200"; 
   d="scan'208";a="49761958"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2019 08:30:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Sep 2019 08:30:35 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Sep 2019 08:30:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhUyBeGQw4Hyz5M6CpdXu38cheWebHZ+XB4p7Nxt0E2NFf3NQqUPitDschPTG9/1MavQazrpHc+qly4qweS+mixECRCh5auuRr82/LLeYe2F9nhWXa0dh9zxLYulKTR9uEsU5aX7iozjYsYLI4MuCGNxxtOtHTIZzivr6rvx9Cbay2Kn+EImQ5DQ+3uOJSdIAb2rv4gOprlHyQ++jWB9UTwPXTZLBTzKose9x1XQeBXEOYZEPWo3bWE+Q9JOZGSBuTH8jXGISJa/MuDlC0rIWl1nFNtsvT0NHrzKcFFh1pFpvsSMykKALb2cm0n7BpAJq2r3a2Rhtp0GPl05ZPI7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpRhqvFsjSjdI2XEvbiXask3H/Hnl+qkBaPeZxpmvT8=;
 b=AttRS6lDVMpvEWCmQpK5E9NEqaz5Ova/PnObqGwWVuijIoiMXs20GpqZ9MKrCquXGChifNigZKPsyDQvKhVMdFmg9KlJAhEzWDrn3zIfngr7Z+jIN9k7YjTqWKaOMjNk3HtV8d4ouOEhoTmZJ1XeXGwtvSsTm/NTs1/ZFf1tlAzV1JujA8lgMOgFYC/k+gHyjhJxBKsDqG1d5V7sUILQ1AnXR2zkq/4gF7kYjOVgVjfiF09oRJ9gvdH1Fh3ktZKY6ndYNcITppdaIgTwf5HHBjw3b6SCjt36t4R4jUOVVWXo7rJUqUfobt8gDwGeAOBWjtHGE1Y1sIB2Gcy8o+qqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpRhqvFsjSjdI2XEvbiXask3H/Hnl+qkBaPeZxpmvT8=;
 b=TzTKABURKNIN9Nu6ThgXByfAo38XPouHhFMZXk/ZzJL1uxZrEMVSphsuMZiWALsC5SwccQgA3237Lsg+PM3RLIx0vsdkQ+535uUWTTqFlQYd+tiGBNBaZbVRs9JPXRxUlYjYCy4QyU9AA86+PhDCwcswKnOREAcdbryPlosLTDc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1899.namprd11.prod.outlook.com (10.175.87.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 15:30:34 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 15:30:34 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 2/2] clk: at91: select parent if main oscillator or bypass is
 enabled
Thread-Topic: [PATCH 2/2] clk: at91: select parent if main oscillator or
 bypass is enabled
Thread-Index: AQHVZyOF1aEN8SUUrUGnVcaoCs40gw==
Date:   Mon, 9 Sep 2019 15:30:34 +0000
Message-ID: <1568042692-11784-2-git-send-email-eugen.hristev@microchip.com>
References: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2ceb05f-a2ff-4a43-6e0f-08d7353aa7d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1899;
x-ms-traffictypediagnostic: DM5PR11MB1899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1899D8333A223A3A3BA44023E8B70@DM5PR11MB1899.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(316002)(76176011)(11346002)(99286004)(14454004)(2501003)(486006)(66556008)(446003)(305945005)(66446008)(64756008)(2906002)(5660300002)(66476007)(6512007)(476003)(2616005)(26005)(102836004)(2201001)(53936002)(6436002)(8936002)(8676002)(52116002)(36756003)(54906003)(81166006)(81156014)(86362001)(110136005)(6506007)(66946007)(256004)(3846002)(6116002)(186003)(7736002)(6486002)(71190400001)(71200400001)(66066001)(107886003)(478600001)(386003)(25786009)(4326008)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1899;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cySd2/30TB3oakWiLWlePWpIyJ2AyKYSHYoFxvAGdl7UL0ikgC/KPjz7JyqeuWCyT72zZCSoi3KJx6ksUknGk6Q4QFyzBnKMC0Kezk5Dqd3YEOyhKN1axsH61ZuYOd7aWiJ8c5I/ek2YUkpW8XqeVjOZUdMTD0Z3hix6Y1S7Fe8sm02cHpoU8wOjyXEwt+03NXnmUnGCRvn59vna9HKiLKlEFZ4bImFZDk1ZHQfPQa5yhJdh1ByLydYe86Udkj0Ur3rQ91vQCX7COToXAAyDEY0gsab/1F7/h6lJ68Ixrn5nO0adVJd51hNKQJ9hHgn9DcQPJygNvSJKS3NCgMs+67vmaAx/FHfSKnw/stw/9om/+MoGjX4dYW3geeyjtENt+FCCNBBbixrdQ42+DxZHatq8ibJhUVo5rCD6YLxeVDg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ceb05f-a2ff-4a43-6e0f-08d7353aa7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 15:30:34.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Pa/x9lHLxBwgi5w8chFc11qLI8eySiTFR5Zd+l59SzBre5PwzJPWCTtfrklfJHcSKOF7xp68i1EMwCkKQSaZonSlDuq1LiwA6bF00tmpl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Selecting the right parent for the main clock is done using only
main oscillator enabled bit.
In case we have this oscillator bypassed by an external signal (no driving
on the XOUT line), we still use external clock, but with BYPASS bit set.
So, in this case we must select the same parent as before.
Create a macro that will select the right parent considering both bits from
the MOR register.
Use this macro when looking for the right parent.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/clk/at91/clk-main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index ebe9b99..87083b3 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -21,6 +21,10 @@
=20
 #define MOR_KEY_MASK		(0xff << 16)
=20
+#define clk_main_parent_select(s)	(((s) & \
+					(AT91_PMC_MOSCEN | \
+					AT91_PMC_OSCBYPASS)) ? 1 : 0)
+
 struct clk_main_osc {
 	struct clk_hw hw;
 	struct regmap *regmap;
@@ -113,7 +117,7 @@ static int clk_main_osc_is_prepared(struct clk_hw *hw)
=20
 	regmap_read(regmap, AT91_PMC_SR, &status);
=20
-	return (status & AT91_PMC_MOSCS) && (tmp & AT91_PMC_MOSCEN);
+	return (status & AT91_PMC_MOSCS) && clk_main_parent_select(tmp);
 }
=20
 static const struct clk_ops main_osc_ops =3D {
@@ -450,7 +454,7 @@ static u8 clk_sam9x5_main_get_parent(struct clk_hw *hw)
=20
 	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
=20
-	return status & AT91_PMC_MOSCEN ? 1 : 0;
+	return clk_main_parent_select(status);
 }
=20
 static const struct clk_ops sam9x5_main_ops =3D {
@@ -492,7 +496,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	clkmain->hw.init =3D &init;
 	clkmain->regmap =3D regmap;
 	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
-	clkmain->parent =3D status & AT91_PMC_MOSCEN ? 1 : 0;
+	clkmain->parent =3D clk_main_parent_select(status);
=20
 	hw =3D &clkmain->hw;
 	ret =3D clk_hw_register(NULL, &clkmain->hw);
--=20
2.7.4

