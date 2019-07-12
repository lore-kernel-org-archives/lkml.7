Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8504C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817A821019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oAambMlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfGLO4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:56:14 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:39750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfGLO4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QyiS0kgHHxaf+ecZLJsqlwUzDprXVyxPmn7TCjSXpo=;
 b=oAambMlYrfxdQ4HGgfHCK/ZaujF/q1l7DzZHKKnTTmfhsHfvOZhWQl0OklBzTC04GqQZmszM9Ud2c2WRhwVJvHCTtnjjB1MdjROUuElP9t7vb4BA27AFHFdSQNHGEVBmRxpczJb4tBVyk4W49JwNVj4tCpXFrVROCvBnWvz98cE=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5508.eurprd05.prod.outlook.com (20.177.119.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Fri, 12 Jul 2019 14:56:03 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 14:56:03 +0000
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
Subject: [PATCH v3 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Topic: [PATCH v3 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Index: AQHVOMHs0C27s3Y6sk2L0C84XH8y3w==
Date:   Fri, 12 Jul 2019 14:56:03 +0000
Message-ID: <20190712145550.27500-4-oleksandr.suvorov@toradex.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:208:1::49) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 041d7bfa-7233-415a-bd9f-08d706d90f5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5508;
x-ms-traffictypediagnostic: AM6PR05MB5508:
x-microsoft-antispam-prvs: <AM6PR05MB55084A0B57CE03AAA6FE95EDF9F20@AM6PR05MB5508.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(199004)(189003)(102836004)(186003)(66476007)(52116002)(305945005)(26005)(66946007)(64756008)(66446008)(6506007)(5660300002)(6436002)(86362001)(478600001)(1411001)(66556008)(53936002)(8676002)(386003)(7736002)(316002)(76176011)(66066001)(1076003)(6916009)(54906003)(99286004)(50226002)(14454004)(36756003)(71200400001)(71190400001)(68736007)(6116002)(3846002)(486006)(6512007)(2616005)(6486002)(2906002)(44832011)(11346002)(446003)(8936002)(81166006)(81156014)(4326008)(476003)(256004)(14444005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5508;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WloXpiUXsiSiE0BG3xZEOx7LeCjKhRZsS4VUIE/XKDJEtSx6975S/WKWeMF6RT++BHq1Gif/Sm8VXM9MnNe4DJH3+2BPmpkmjkvOPzz9zk+7qEpS6xxrtEZpqybUr2HLGKJXIt0jdj/34U9Dle2442codgIi5gJaJ4Yldf+1dYhQhAG1KAL3OJ1SWjD3V6k41a7j168RBXVJHcPwU/7qdicug3zxIxR/DP7DFNpwig7DdIwh1CrSk0AHL9tb7Y+TexCe5ZpyVVDdxPCm2xwgePsUI7e7rWELNfTv1ZCc2cRV1GMEyclH+lUZaejHznuBCUY/TaakvGWXp1C1sWOfd1oslp0IK/nzq4y3e5wCGiP8MYGKAbOVT/wV8947RBk/leDSNZbrhAGZZCmYQ/I0g0R0cEtWix9IXIWGJAWQ8Pw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041d7bfa-7233-415a-bd9f-08d706d90f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 14:56:03.2779
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

To enable "zero cross detect" for ADC/HP, change
HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
CHIP_ANA_CTRL register.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

---

Changes in v3: None
Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index bb58c997c6914..e813a37910af4 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1289,6 +1289,7 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
 	int ret;
 	u16 reg;
 	struct sgtl5000_priv *sgtl5000 =3D snd_soc_component_get_drvdata(componen=
t);
+	unsigned int zcd_mask =3D SGTL5000_HP_ZCD_EN | SGTL5000_ADC_ZCD_EN;
=20
 	/* power up sgtl5000 */
 	ret =3D sgtl5000_set_power_regs(component);
@@ -1316,9 +1317,8 @@ static int sgtl5000_probe(struct snd_soc_component *c=
omponent)
 	       0x1f);
 	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH, reg);
=20
-	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
-			SGTL5000_HP_ZCD_EN |
-			SGTL5000_ADC_ZCD_EN);
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+		zcd_mask, zcd_mask);
=20
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_MIC_CTRL,
 			SGTL5000_BIAS_R_MASK,
--=20
2.20.1

