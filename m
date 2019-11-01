Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE0CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE5208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o67e2w6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfKAGe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:34:59 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:49990
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfKAGe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:34:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3KjZ2ziqQWMSjroTDSJY6a1e1Wa3aEbfzarxwmGb5xfFjuUs5NpnSljxaD9JoyyjcB3SzanC3LnqP/i5eA7HxHHS6rGgZAQ2ntKFJENjFPNuR3DwT6Yxxes4HrG663orUfWJL1FCVnDNnsumi5udIY0YvH1TJnLWaU1bYcfUhvZoWOHpoyG5wHgh+NDm8luIvJp8goROhCRj446xF0p7NqUfJF+Bjz25Y+U+ipJK2WYiN4Nea7a/wo+MtLeyKSj36u9snu6ddPSwMW80ZBAWMEGd4XOJsqYpJgrrjqcDb9xtqFfxJsurAOySvse2wKV3WjoJ/i6hSQdHvoRxJLU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTMcrEk/ISQbtedODoeBsBi9Jlfwv9cAu24a8svn6ME=;
 b=HlJdjKis2cfJZCIkW+uVBDrF6kbFCeh+0b3WqA2Sf41SYwdR9bT507m37c5zzYcu1UmCigIUIrEKkvuKmP6doMccziEr23ts9cpwttBjip6Irx7xCxUmEKl1d+HzXbd4+JjUCr3aissiEWUfQxXZUhvJRy7P1KN5miH1QgaxXhlTOtQjwiVh2CNu/iV515k00hoCRN/b1h6Gi73BSJQZP4vCjMU93h5sQRVXBnvGhiIPyqNyq+OahvWAeNOo75gw/rIx2CDbWtpmg8eEOPyBZawXiUa5dprfRhQjuTACwBAQkcPR12uCfgQucXfKizwQYOx4vL56pI9CnxZLY+Jb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTMcrEk/ISQbtedODoeBsBi9Jlfwv9cAu24a8svn6ME=;
 b=o67e2w6mbF+ubP39rMD9Ak61+5nNWkDyGyhOSU/zUfFJj5EL6hDoE+6WDpmePJjEgQKqt/99JMnDTDocP4umkhdjZVq38nrF4o4KOQ4O0de58wqc/dMb+GfmjnW5uVfBgv97KFGy2AK18ZSxGJAR8eE8wiiTqX2hQ9vMsGmGBSE=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.232.225) by
 VE1PR04MB6591.eurprd04.prod.outlook.com (20.179.234.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 06:34:55 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::e052:9278:76a3:27c]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::e052:9278:76a3:27c%6]) with mapi id 15.20.2387.025; Fri, 1 Nov 2019
 06:34:55 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: wm8524: Add support S32_LE
Thread-Topic: [PATCH] ASoC: wm8524: Add support S32_LE
Thread-Index: AQHVkH55CRF9MhGYp0KQjdFHSlLOew==
Date:   Fri, 1 Nov 2019 06:34:54 +0000
Message-ID: <20191101063349.32222-1-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK0P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::16) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11c::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e190d80d-e2c9-42af-099f-08d75e959b59
x-ms-traffictypediagnostic: VE1PR04MB6591:|VE1PR04MB6591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB659157DCD91E93913FF4FF24E3620@VE1PR04MB6591.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(486006)(7416002)(2501003)(26005)(186003)(5660300002)(52116002)(36756003)(14444005)(256004)(1250700005)(4744005)(110136005)(6512007)(6506007)(476003)(1076003)(2616005)(316002)(6486002)(71190400001)(71200400001)(66946007)(66476007)(2201001)(6116002)(3846002)(7736002)(81156014)(2906002)(64756008)(50226002)(66446008)(386003)(102836004)(66556008)(478600001)(8676002)(14454004)(25786009)(86362001)(81166006)(99286004)(8936002)(6436002)(305945005)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6591;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5BaoGiNJ/+ryOYWXjpQv5rLuRxDJapQru72fVqzGOZDWFA6a/frTKSMrzq3XKqlWNEVL+jlQlhTLGjwxaOtoKl/A6SbR2wPdAwAIAO2NklRiAqr+8knvebBeKUZkH0CS8+MqdNPAfiChRq15qpcoLLjNIL4NTs6NMcN+P6DKE+ItfjRuvvfdrWKoHrdX7CPFRVtIhF3hPn1NCrBp0tJUZoT/75kN1hCFj19vIzvVDpW4LJA7IqosyEYCLdTptlTqIdZ5YSce528Py2jwsof1bgL9yvxrUzYc3TES0jkNeXTTCR8DXKct8xNDA269YffMaeOGTL/fRup2yr5fc7it4d5SahO5zkcQ7BAqeX3vxzH041ZPdStnZBxDAlzqsFywsTf6VWPO1QOpoPbrdoNqR/VkggafZ8r2ogBg0fddm/n4/IyiGRoyetducNK7Om0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e190d80d-e2c9-42af-099f-08d75e959b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 06:34:54.9973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTtG/QoZh+gn1Upf7ABzuU05uprqoGI///yZtjsNiCA5+Vh+zY187dRr+OjTjLMeSSA88ENTF71S7ks9Rzg9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6591
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow 32bit sample with this codec.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8524.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index 91e3d1570c45..4e9ab542f648 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -159,7 +159,9 @@ static int wm8524_mute_stream(struct snd_soc_dai *dai, =
int mute, int stream)
=20
 #define WM8524_RATES SNDRV_PCM_RATE_8000_192000
=20
-#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			SNDRV_PCM_FMTBIT_S24_LE |\
+			SNDRV_PCM_FMTBIT_S32_LE)
=20
 static const struct snd_soc_dai_ops wm8524_dai_ops =3D {
 	.startup	=3D wm8524_startup,
--=20
2.21.0

