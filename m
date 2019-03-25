Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96349C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB6F2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OQZIXTX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfCYGic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:38:32 -0400
Received: from mail-eopbgr800059.outbound.protection.outlook.com ([40.107.80.59]:32118
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729400AbfCYGic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBGy8hQD5aMuQMKN60damyAbgozKfUan923MvIdEV+o=;
 b=OQZIXTX1omObnwSrvqKd/poimmvdUaEJmXZsXRdOCfCaigLdmXqVgKgE/pQPR+/8wSMCx6DPUIC0AENLNJYAghGX6ek67B+nGT4VLWWTg4h5foWZRaqTWZ9FVnGaBIRW47oei6EcXxT/pg0ye0QGDTya9lkbPzCSRmslWdT6dd4=
Received: from MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) by
 MN2PR12MB3630.namprd12.prod.outlook.com (20.178.243.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 06:38:28 +0000
Received: from MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::bd70:eab6:121c:d160]) by MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::bd70:eab6:121c:d160%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 06:38:28 +0000
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
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [v2] ASoC: AMD: Configure wclk and bclk of master codec
Thread-Topic: [v2] ASoC: AMD: Configure wclk and bclk of master codec
Thread-Index: AQHU4tVaxqRzJs0jwkWEwXDlOIqfuw==
Date:   Mon, 25 Mar 2019 06:38:27 +0000
Message-ID: <20190325063759.28300-1-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::22) To MN2PR12MB3088.namprd12.prod.outlook.com
 (2603:10b6:208:c4::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e5e7988-19dc-42ae-4da7-08d6b0ec7ce2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3630;
x-ms-traffictypediagnostic: MN2PR12MB3630:
x-microsoft-antispam-prvs: <MN2PR12MB3630AFE539D8ECD6F89175AAF85E0@MN2PR12MB3630.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(99286004)(316002)(71190400001)(71200400001)(386003)(6506007)(6436002)(1076003)(26005)(7416002)(52116002)(186003)(6486002)(6512007)(4326008)(36756003)(50226002)(97736004)(8936002)(54906003)(1671002)(5660300002)(53936002)(305945005)(7736002)(86362001)(6116002)(25786009)(68736007)(109986005)(3846002)(2616005)(476003)(106356001)(72206003)(66066001)(81166006)(81156014)(486006)(2906002)(478600001)(102836004)(105586002)(256004)(14454004)(8676002)(59246006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3630;H:MN2PR12MB3088.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: soM0a2fv/x2rO7ReBtRuqAD6OTeTjhUovdmkWOqZBD9pr/AVuheP1VjWXV90zx6qVkCHQhCxyQlQ4fN1E8dy5NkeOschbXTWFwFmLJ7iJNNUtdj4v1CsjuIoHdVXkJckVomN4xrIDuathWagrxngc375AVcPyA8+PPR0jMSeCiwi8Z5DRkmF4u6nNUZhd1394hOLqF5R4rx1SQ0ydTRYYSoSyRWLq4Bldu8gB2N3M3JVFC8odRRDt8ZRhbxiDF8PjDfJO5uGW2mVQSa6q7PK1tL89/3fUKjih7rIlqkh7WIr+hH5hmdm4fKOt7+MSQlZfFK3eFgEy49afgdgtS4NSuLgw4VQi7LlqFM4tcxvC0Wk5qeHORJfjWmigX6SzJol5QW8S9OYDwK9InJUKbwBXb8aDx0AII1aGqoNhdTb2r4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5e7988-19dc-42ae-4da7-08d6b0ec7ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 06:38:28.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3630
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CCF support in da7219, we can now set the correct rate of
wclk and bclk.
Setting bclk at lower rate at 1.53Mhz from its earlier default
rate of 3Mhz, also fixes noise issue observed on some dmics.

v2: Removed clk set rate and enable/disable from da7219 ops as
da7219 codec takes care of them internally. Clock configuration
kept for those codecs where da7219 acts as master of clock.
As suggested by Adam Thomson.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 45 +++++++++++++++++-----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da721=
9-max98357a.c
index 8e2ce369a295..7737c6dc026a 100644
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
@@ -173,12 +178,7 @@ static int cz_da7219_cap_startup(struct snd_pcm_substr=
eam *substream)
=20
 	machine->cap_i2s_instance =3D I2S_SP_INSTANCE;
 	machine->capture_channel =3D CAP_CHANNEL1;
-	return da7219_clk_enable(substream);
-}
-
-static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
-{
-	da7219_clk_disable();
+	return 0;
 }
=20
 static int cz_max_startup(struct snd_pcm_substream *substream)
@@ -199,7 +199,7 @@ static int cz_max_startup(struct snd_pcm_substream *sub=
stream)
 				   &constraints_rates);
=20
 	machine->play_i2s_instance =3D I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static void cz_max_shutdown(struct snd_pcm_substream *substream)
@@ -225,7 +225,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *s=
ubstream)
 				   &constraints_rates);
=20
 	machine->cap_i2s_instance =3D I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
@@ -247,7 +247,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *s=
ubstream)
=20
 	machine->cap_i2s_instance =3D I2S_SP_INSTANCE;
 	machine->capture_channel =3D CAP_CHANNEL0;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
@@ -255,29 +255,40 @@ static void cz_dmic_shutdown(struct snd_pcm_substream=
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
-	.shutdown =3D cz_da7219_shutdown,
 };
=20
 static const struct snd_soc_ops cz_da7219_cap_ops =3D {
 	.startup =3D cz_da7219_cap_startup,
-	.shutdown =3D cz_da7219_shutdown,
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

