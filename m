Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B610C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53990233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="T0itXIYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfH2Gut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:50:49 -0400
Received: from mail-eopbgr800070.outbound.protection.outlook.com ([40.107.80.70]:5761
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfH2Gus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBm58wJxs2qy3YUnafCsjeabbRFESggqhztF1mSgEoNIFqzYJXMArWlplLpKx962TSDrbfC/D3wS6Lqx72Ya8sqoIPcPfkvCaprZAuuPKYNVfv7QyH5vyHLptez7P0SUpqBQhNWux5yR/C2SujvDn3MjRXWbmMb0EjcF1rtRSPewJyEQBnOaJKaudqVV1fcastlU3jSwRcW1vrCfjnzV/1qCpM1VqtneBOyS7P1DpQyI9yXqDCq6L6p+fnPo6outYh4Mcwt20yHvJKYNhxLL437dzJ97OXdtgYpkO5LAsSD+FprimAwfDdJ3sRecnRWuW0HRjaXrNfo/v4SgiJGP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCp40C6IjLT/8M35Sw05aEaWggjACiqwIBFfQvZVUo8=;
 b=dd/ppfKJbMUOqaYOVSTalxtKi6z+iefvJ0NdoMvMBSI6Gkug+i9y1gwMPKsDoWrTMuEaJ1axKP/vnZ3eMqWErYYsrAB8QZnVF9KprL+tFwYgAnuVt8EJBNoXcTd5JitdrsqMjLEF523nlXi1Bb0Qxf3dypAyvqQEmA3oPh5TYPLJ3nTQ4nrBWUMthLU2kjjf3PlnfHTnLKZQ17T1bn5g7HYe/f6M1YkNJUR1TyQ+WAn2s9iozf4Y4bttNTH+BF1hcxtxIR5TwVmYtKyrSF5vWMWkg2OYi2nVERw4zCK0KXESEI2flqbd63NuIlLOEOD80DD8KxECHnBgjAv3xYX8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCp40C6IjLT/8M35Sw05aEaWggjACiqwIBFfQvZVUo8=;
 b=T0itXIYg6eT8ZLdnACJMbVomot27cdpvKZ/InI6anKOJaxu9uQWBXdRzXMpcUWzpsM+AuYV+QSM0BgcdghNSyjE+rKDSnUH09XJhIgNowvF6/9WblHf4Icr9gHarPrOPNjin40uFtLpXBBhwcIoMTN7tTi+pwdKC9KxnFzwOjNI=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4824.namprd03.prod.outlook.com (20.179.93.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 06:50:46 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c%4]) with mapi id 15.20.2220.013; Thu, 29 Aug 2019
 06:50:46 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: sy8824x: add prefixes to BUCK_EN and MODE macros
Thread-Topic: [PATCH] regulator: sy8824x: add prefixes to BUCK_EN and MODE
 macros
Thread-Index: AQHVXjYVr5Wcj2kkE0e1JjF92GMQJQ==
Date:   Thu, 29 Aug 2019 06:50:46 +0000
Message-ID: <20190829143927.395d0385@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:404:e2::30) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2feaa274-f3c8-45b3-0146-08d72c4d384a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4824;
x-ms-traffictypediagnostic: BYAPR03MB4824:
x-microsoft-antispam-prvs: <BYAPR03MB4824AF9B5D02D82120A77D18EDA20@BYAPR03MB4824.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(102836004)(386003)(6506007)(476003)(66946007)(64756008)(66556008)(66476007)(186003)(66446008)(1076003)(26005)(14444005)(5660300002)(7736002)(2906002)(256004)(305945005)(14454004)(86362001)(71190400001)(71200400001)(3846002)(6116002)(66066001)(81156014)(81166006)(8676002)(8936002)(316002)(110136005)(486006)(478600001)(50226002)(6512007)(53936002)(9686003)(4326008)(25786009)(52116002)(99286004)(6436002)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4824;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X8XLVtgXbR6YWdKw0QFzecNLyv6EXLWnux0Wn5hA7/zAplw89xEIiyXxtWwtHscOPrn3zriaGXSbipj72/ZCJr2PqAFFzBXqNiR5C+mqbnSfjTGigKDZmcAe71Up/NuOhsCzv1+a8Cn2dhUucwF+FsSTYifTQidyEJMbWq1IJe2wuFArrdv4vX6Jir9GdyPzoQj0cxknJ3rVti75XDur5ne/uSEbOVCxdPDUYYR7SydAc8E5ovr1vQUfV5oOEbWY0VR6+O2rOxA95NjlwN0tHCaE8ILdQ1aabhOgZve8zdcStOgK1rnFljeVjzb94gMqmScpvG+QYuuOGSjcwAAfjRPOd+AcWdn+gZP6TWqlaS1csPBekxATbRqWf633h4xG0gHihmitzbaQvATRKcblZdx7bUq9Xc9JgMv9186but4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AD7C5D872796047A01746415C3F6C0F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2feaa274-f3c8-45b3-0146-08d72c4d384a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 06:50:46.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzbU7EM3hxdcf/1Jwgw3McehZwXAREqJCnCQEce02VC3+rnzWJmME76EMVre+tTYmykHdEREAtjOkA6e8DVmaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefixes to BUCK_EN and MODE macros to namespace them.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8824x.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index d806fa7020d4..92adb4f3ee19 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -13,8 +13,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
=20
-#define BUCK_EN		(1 << 7)
-#define MODE		(1 << 6)
+#define SY8824C_BUCK_EN		(1 << 7)
+#define SY8824C_MODE		(1 << 6)
=20
 struct sy8824_config {
 	/* registers */
@@ -41,10 +41,12 @@ static int sy8824_set_mode(struct regulator_dev *rdev, =
unsigned int mode)
=20
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		regmap_update_bits(rdev->regmap, cfg->mode_reg, MODE, MODE);
+		regmap_update_bits(rdev->regmap, cfg->mode_reg,
+				   SY8824C_MODE, SY8824C_MODE);
 		break;
 	case REGULATOR_MODE_NORMAL:
-		regmap_update_bits(rdev->regmap, cfg->mode_reg, MODE, 0);
+		regmap_update_bits(rdev->regmap, cfg->mode_reg,
+				   SY8824C_MODE, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -62,7 +64,7 @@ static unsigned int sy8824_get_mode(struct regulator_dev =
*rdev)
 	ret =3D regmap_read(rdev->regmap, cfg->mode_reg, &val);
 	if (ret < 0)
 		return ret;
-	if (val & MODE)
+	if (val & SY8824C_MODE)
 		return REGULATOR_MODE_FAST;
 	else
 		return REGULATOR_MODE_NORMAL;
@@ -94,7 +96,7 @@ static int sy8824_regulator_register(struct sy8824_device=
_info *di,
 	rdesc->type =3D REGULATOR_VOLTAGE;
 	rdesc->n_voltages =3D cfg->vsel_count;
 	rdesc->enable_reg =3D cfg->enable_reg;
-	rdesc->enable_mask =3D BUCK_EN;
+	rdesc->enable_mask =3D SY8824C_BUCK_EN;
 	rdesc->min_uV =3D cfg->vsel_min;
 	rdesc->uV_step =3D cfg->vsel_step;
 	rdesc->vsel_reg =3D cfg->vol_reg;
--=20
2.23.0

