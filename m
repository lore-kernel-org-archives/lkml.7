Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A6EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B36C218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U3UdrBYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfCVJGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:06:15 -0400
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:37442
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbfCVJGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVvIwTP9WSlwvwdRfp/RhQ0o+naAtdzeHNpxFRHIB8I=;
 b=U3UdrBYo6kNrjs0qyQSxkfGQAvEdV4ZMtANBshG0ZS7TD7JqWzZvC5JUhrrJYVI3NdjrY7tvHBK6rwtO+8h+sRtkD+FYPA52OrLPHQrc/OwpVcD/ArqEe8G4F6cCFQDLz9WU6bCO7u/QzAyc+bybJ5SXSpzLgrFs0nKnfHZ+fFI=
Received: from MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) by
 MN2PR12MB3485.namprd12.prod.outlook.com (20.178.242.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 09:06:10 +0000
Received: from MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::bd70:eab6:121c:d160]) by MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::bd70:eab6:121c:d160%4]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 09:06:10 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: AMD: Configure wclk and bclk of master codec
Thread-Topic: [PATCH] ASoC: AMD: Configure wclk and bclk of master codec
Thread-Index: AQHU4I59NbQ9pdWrkUeMNi8gY2B36w==
Date:   Fri, 22 Mar 2019 09:06:10 +0000
Message-ID: <20190322090532.30448-1-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To MN2PR12MB3088.namprd12.prod.outlook.com
 (2603:10b6:208:c4::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d8c0cd4-ba5c-48aa-3f24-08d6aea5a01a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3485;
x-ms-traffictypediagnostic: MN2PR12MB3485:
x-microsoft-antispam-prvs: <MN2PR12MB34857FA61984A854C7BA5C0DF8430@MN2PR12MB3485.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(376002)(136003)(199004)(189003)(486006)(6436002)(186003)(6116002)(81166006)(8676002)(6512007)(2616005)(71190400001)(71200400001)(476003)(478600001)(53936002)(72206003)(2906002)(14454004)(7416002)(256004)(7736002)(5660300002)(25786009)(8936002)(4326008)(106356001)(66066001)(59246006)(26005)(3846002)(6486002)(305945005)(68736007)(54906003)(97736004)(86362001)(109986005)(81156014)(102836004)(1076003)(50226002)(99286004)(386003)(36756003)(52116002)(1671002)(6506007)(316002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3485;H:MN2PR12MB3088.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A+pQBlrsyvRUyxsdsM2Mu+Buq0Bu4BR+J73R2Hp/qTBdZaKQlBfCctAt4gEEY4ZY21Lv3cjaIv+G1H3PQqX75WlmRyMHCqdmQuNIs8x4zjNihBPAcRWlHPli0YwBPPyOY/A19xGovcagv3ICOKDTwLMUXuOkmd2DSAw+TMaFeb29oaKINMnMZi7n8KJU+WgX3k8BJRP4Y9SV/MVNrkx96sIZYkzOkT4irVY4Gf6jP7pN7Tx/qGlmH62kkl9zLJowIzE/XO7XZgpioRETeDG0LepiwzCjRt/JGNd4PFRriklpH16DPonLr6WpakfTj/l8qr7JLoQ4xLddPbufFfR06yjXfcUJdPTySB9lSiywJXelKhBuDbtHIesqu8GzVI0TZTKbCZFB3ki/4LIpZzCHTv3QYzmgOj/qpnrBi7gx2RY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8c0cd4-ba5c-48aa-3f24-08d6aea5a01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 09:06:10.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CCF support in da7219, we can now set the correct rate of
wclk and bclk.
Setting bclk at lower rate at 1.53Mhz from its earlier default
rate of 3Mhz, also fixes noise issue observed on some dmics.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 40 +++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da721=
9-max98357a.c
index f37a588ba345..1bb5b78b6e10 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -46,7 +46,8 @@
 #define DUAL_CHANNEL		2
=20
 static struct snd_soc_jack cz_jack;
-static struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_wclk;
+static struct clk *da7219_dai_bclk;
 extern int bt_uart_enable;
=20
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
@@ -72,7 +73,8 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd=
)
 		return ret;
 	}
=20
-	da7219_dai_clk =3D clk_get(component->dev, "da7219-dai-bclk");
+	da7219_dai_wclk =3D clk_get(component->dev, "da7219-dai-wclk");
+	da7219_dai_bclk =3D clk_get(component->dev, "da7219-dai-bclk");
=20
 	ret =3D snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
@@ -94,12 +96,15 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *r=
td)
 	return 0;
 }
=20
-static int da7219_clk_enable(struct snd_pcm_substream *substream)
+static int da7219_clk_enable(struct snd_pcm_substream *substream,
+			     int wclk_rate, int bclk_rate)
 {
 	int ret =3D 0;
 	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
=20
-	ret =3D clk_prepare_enable(da7219_dai_clk);
+	clk_set_rate(da7219_dai_wclk, wclk_rate);
+	clk_set_rate(da7219_dai_bclk, bclk_rate);
+	ret =3D clk_prepare_enable(da7219_dai_bclk);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't enable master clock %d\n", ret);
 		return ret;
@@ -110,7 +115,7 @@ static int da7219_clk_enable(struct snd_pcm_substream *=
substream)
=20
 static void da7219_clk_disable(void)
 {
-	clk_disable_unprepare(da7219_dai_clk);
+	clk_disable_unprepare(da7219_dai_bclk);
 }
=20
 static const unsigned int channels[] =3D {
@@ -151,7 +156,7 @@ static int cz_da7219_play_startup(struct snd_pcm_substr=
eam *substream)
 				   &constraints_rates);
=20
 	machine->play_i2s_instance =3D I2S_SP_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
@@ -173,7 +178,7 @@ static int cz_da7219_cap_startup(struct snd_pcm_substre=
am *substream)
=20
 	machine->cap_i2s_instance =3D I2S_SP_INSTANCE;
 	machine->capture_channel =3D CAP_CHANNEL1;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
@@ -199,7 +204,7 @@ static int cz_max_startup(struct snd_pcm_substream *sub=
stream)
 				   &constraints_rates);
=20
 	machine->play_i2s_instance =3D I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static void cz_max_shutdown(struct snd_pcm_substream *substream)
@@ -225,7 +230,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *s=
ubstream)
 				   &constraints_rates);
=20
 	machine->cap_i2s_instance =3D I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
@@ -247,7 +252,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *s=
ubstream)
=20
 	machine->cap_i2s_instance =3D I2S_SP_INSTANCE;
 	machine->capture_channel =3D CAP_CHANNEL0;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
@@ -255,29 +260,44 @@ static void cz_dmic_shutdown(struct snd_pcm_substream=
 *substream)
 	da7219_clk_disable();
 }
=20
+static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	int wclk, bclk;
+
+	wclk =3D params_rate(params);
+	bclk =3D wclk * params_channels(params) *
+		snd_pcm_format_width(params_format(params));
+	return da7219_clk_enable(substream, wclk, bclk);
+}
 static const struct snd_soc_ops cz_da7219_play_ops =3D {
 	.startup =3D cz_da7219_play_startup,
 	.shutdown =3D cz_da7219_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_da7219_cap_ops =3D {
 	.startup =3D cz_da7219_cap_startup,
 	.shutdown =3D cz_da7219_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_max_play_ops =3D {
 	.startup =3D cz_max_startup,
 	.shutdown =3D cz_max_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_dmic0_cap_ops =3D {
 	.startup =3D cz_dmic0_startup,
 	.shutdown =3D cz_dmic_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_dmic1_cap_ops =3D {
 	.startup =3D cz_dmic1_startup,
 	.shutdown =3D cz_dmic_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static struct snd_soc_dai_link cz_dai_7219_98357[] =3D {
--=20
2.17.1

