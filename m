Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE49C742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31FF2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="gQUv3R1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGLO4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:56:17 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:39750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfGLO4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeGzakFLYMNGL5tN8YvcCsS1C7iTfrhob9c53yaIVeA=;
 b=gQUv3R1M8S4XBFqDq4Gcgy0nTl7vzVfHsI78wRIxoX92C1EA/9ZJjqxOyuFYgsv1iDKATkDFtcenvpmDDTWvL3EUkwaHajz/QMuhmiZpKkGWno289Xs1g0RUy4U9yFAf+gCTy2aS0oOsFf8eQcEOI0UnJI0Vc0YaOZcQf7oVAO8=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5508.eurprd05.prod.outlook.com (20.177.119.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Fri, 12 Jul 2019 14:56:05 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 14:56:05 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Topic: [PATCH v3 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Index: AQHVOMHtwVbKtEmYeEa90rBOQ5pN0w==
Date:   Fri, 12 Jul 2019 14:56:04 +0000
Message-ID: <20190712145550.27500-5-oleksandr.suvorov@toradex.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR08CA0070.eurprd08.prod.outlook.com
 (2603:10a6:205:2::41) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1b1d360-6816-4664-45a8-08d706d91040
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5508;
x-ms-traffictypediagnostic: AM6PR05MB5508:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR05MB55089BD55A2996D68C1AD013F9F20@AM6PR05MB5508.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(199004)(189003)(102836004)(186003)(66476007)(52116002)(305945005)(26005)(66946007)(64756008)(66446008)(6506007)(5660300002)(6436002)(86362001)(478600001)(1411001)(66556008)(53936002)(8676002)(386003)(7736002)(316002)(76176011)(66066001)(1076003)(6916009)(54906003)(99286004)(50226002)(14454004)(36756003)(71200400001)(71190400001)(68736007)(6116002)(3846002)(486006)(6512007)(2616005)(6486002)(6306002)(2906002)(966005)(44832011)(11346002)(446003)(8936002)(81166006)(81156014)(4326008)(476003)(256004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5508;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S67N53762aDFk3ciIRPuW8VCar/1BSbW8uVjiq1BNttakX4AaQCwq1wjmL+it/qfwtqG5vyr/dDaK7Z0LPy5jAt9hqlFZsWjSdtBAGksH/upZxu6cpcZMDFBH7bLXOpukIFYlAwc/aHgcOge4phfZAjhgq0jmzguyjK7wA/bOnqRG3xb70DJ0c4S6bpCnRc+PEWeTDwODJwh512fjAT+92c6wcKtDEr7V45/6IjBzZZ7/vWJodvkepxXtIpTTcmEX+JDMGSKGePJlFzDWjvlJhD1Lfu2r9yR4MFFkH01qLwGrqgt/avVrpWoR2oLqaG4xtb0oN2zuG4JCf0yyTR19JAleo6wtdJiXnmEoJPjB6kIne789DrHiy4oM+B2ADH2ZWYjLnx6YWl8pNC93aZZjVh/uEtxuhfd/+t2elY0Vrc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b1d360-6816-4664-45a8-08d706d91040
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 14:56:04.8650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If VDDA !=3D VDDIO and any of them is greater than 3.1V, charge pump
source can be assigned automatically [1].

[1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

---

Changes in v3:
- Add the reference to NXP SGTL5000 data sheet to commit message
- Fix multi-line comment format

Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index e813a37910af4..c256162750d16 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1174,12 +1174,17 @@ static int sgtl5000_set_power_regs(struct snd_soc_c=
omponent *component)
 					SGTL5000_INT_OSC_EN);
 		/* Enable VDDC charge pump */
 		ana_pwr |=3D SGTL5000_VDDC_CHRGPMP_POWERUP;
-	} else if (vddio >=3D 3100 && vdda >=3D 3100) {
+	} else {
 		ana_pwr &=3D ~SGTL5000_VDDC_CHRGPMP_POWERUP;
-		/* VDDC use VDDIO rail */
-		lreg_ctrl |=3D SGTL5000_VDDC_ASSN_OVRD;
-		lreg_ctrl |=3D SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		/*
+		 * if vddio =3D=3D vdda the source of charge pump should be
+		 * assigned manually to VDDIO
+		 */
+		if (vddio =3D=3D vdda) {
+			lreg_ctrl |=3D SGTL5000_VDDC_ASSN_OVRD;
+			lreg_ctrl |=3D SGTL5000_VDDC_MAN_ASSN_VDDIO <<
+				    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		}
 	}
=20
 	snd_soc_component_write(component, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
--=20
2.20.1

