Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A56C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D632220868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ug+6xfU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCHQJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:09:59 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:27687
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbfCHQJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux24lad/zCdpJy8ibmlBBB6mcTMqq0RqLeKynZ+7CTY=;
 b=Ug+6xfU6cysHmy90PclcPV07ANpLPiuPWtOwunctqtsnROsCABaPJbxiLQUfiLk5QaVozub4YJ+piICoscditf6ZnfPMeK4A163UwlWwBcZE5T4q7/EDCKyvo8D6KNmlwi5f8RUTkofFN9sFIOMSMbd88JDsVZXwmfXR/4kVh20=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2944.eurprd04.prod.outlook.com (10.175.24.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 16:09:53 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 16:09:53 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl: sai: Reduce underrun when stream starts
Thread-Topic: [PATCH] ASoC: fsl: sai: Reduce underrun when stream starts
Thread-Index: AQHU1cldwQAZkpsXykybw4e/cTic5A==
Date:   Fri, 8 Mar 2019 16:09:53 +0000
Message-ID: <20190308160933.29899-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0033.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::21) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 192cbf23-15c9-4581-e09b-08d6a3e07fef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2944;
x-ms-traffictypediagnostic: VI1PR0402MB2944:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2944;23:G9m65UK4bGRrvGVns9RGlmg8v+oSxTLMebEbI?=
 =?iso-8859-1?Q?ykrupHkfFIQjeDnYt6RmFWRrba6T4/E6UE5ODd7BsXxUqxf7Jv8x2Gys01?=
 =?iso-8859-1?Q?g90rFrlmhOoz0DtgDpqy7dr3IXyr2ELVCIm5uyWF/4oJ0nI+DypPkMRubf?=
 =?iso-8859-1?Q?3wuxcSTVro9cwQbaRdTonW4/0hynrtKc0Wn6HcymQLaatAFvPdPI4hOq3a?=
 =?iso-8859-1?Q?UPE0u730uhAXkfJj+ftTQhfdRX9+Vh5FGAq3UMQHvSrFUL+vVUbbi+xPsI?=
 =?iso-8859-1?Q?g9MThe2IQhDw7KY7hgtnKnASPCNl1ftICt9DI37V17XMQIpYxmdI/6isA2?=
 =?iso-8859-1?Q?xpNW3p72VnB5rSQ4Js1U6Tw01rxh69rdHLn4M6WzimqeTMBgTXV0TRtc0q?=
 =?iso-8859-1?Q?59WZgxUb6MW5gRxfimshRuQaKw9j3mPxxVXiH11OtlJ/A4x19QBZjTZVSm?=
 =?iso-8859-1?Q?qAqY/x2rD98Avx9CuTH9GrV38ZLap6xr+WTUdNO2IPKL6aXqzsXsvgle+7?=
 =?iso-8859-1?Q?+4bo45P5A9zgkQb5DX2XZ49sU9bMV7kW0/mz2c4CLtLMinFZTOYrYZcOA8?=
 =?iso-8859-1?Q?V/GBovCvs1n4dKABjzfRjfobxljbk0qImdi1zcHcUVASrNpNlip6fvb4O3?=
 =?iso-8859-1?Q?8W2ycXE0I9qgO7/jKR6VGiMwIgm8gcRW5FvgegDaUQOzrGzeLRGZRWkImJ?=
 =?iso-8859-1?Q?Y8zN1/epBKnZXT7BRn2Y3SjmirBtE/I3eOAW3WlmLEgnqCeCf8XyoGwfD/?=
 =?iso-8859-1?Q?jOnFe45Jc7KVi6SmxOb6dIO+eZ+YsUztmqPMQ5treSi7Gc7YmM4N9FB07Q?=
 =?iso-8859-1?Q?ZylqdhR0Ox2v/z+wt1BkGIKvggPvjRRjYMCyMocIb7/Tn9NEkYGfvlCTyh?=
 =?iso-8859-1?Q?Ep48uyLUUAkqSeUuD70ZHaWfGRMQColE+uBvXoVmG5NMFMOl5P3HWIPS2e?=
 =?iso-8859-1?Q?50JBYDG1+Y8pz9NR/70Nn1ijl+yV3Iq/APvk5U2lRNc5Y/mCbe4//0wPW1?=
 =?iso-8859-1?Q?WH5Df6DkzBzO77nLT3gP+T+vF1Di2uIpcFjWy3w6neFpAhvGepH83hVvx8?=
 =?iso-8859-1?Q?iRrlpnAnQYrZsWf6w6YEpuWcmJXZA8krmXSLoz+l+tqU16kg+bPHTqxdUj?=
 =?iso-8859-1?Q?PKWc/Y/BQmMiDNus9SvbmeBA1qyy6QXJdl/WJdo1Hb8HT3pONiZ3DVX55A?=
 =?iso-8859-1?Q?duFAIsbDEe8p+MFm56Zf7b2Rx2xOJB5IStVXqJL9C4/G9/aMl2alggWPLU?=
 =?iso-8859-1?Q?VQIIK7+tz6xEG3RUqczSbB9NeQo1jJq7Fn5Km9RuSk80fzWDpFSKCgNK7s?=
 =?iso-8859-1?Q?RmGFVe+VXSfJYnrQqdQ3q2wlU?=
x-microsoft-antispam-prvs: <VI1PR0402MB29440D14AF6D9F7B893DCC46F94D0@VI1PR0402MB2944.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(6486002)(3846002)(25786009)(5640700003)(6512007)(4326008)(6436002)(53936002)(186003)(54906003)(36756003)(50226002)(2906002)(14454004)(256004)(68736007)(14444005)(66066001)(7736002)(305945005)(102836004)(316002)(2501003)(71190400001)(71200400001)(486006)(1730700003)(81166006)(386003)(478600001)(8676002)(86362001)(6916009)(6506007)(26005)(44832011)(476003)(2616005)(99286004)(2351001)(81156014)(105586002)(1076003)(52116002)(106356001)(97736004)(6116002)(5660300002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2944;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FOjAFB2qXz/p+oEv6GXeF/3DcjXa/rpgxQZHeC64VCTGFNQzCeln4H/uW/mnx0E1ylqh5TaIKkUwmBMaS1qrLTdP/yHnr3FtHk9vYFug/Tng5Lf49CFhE2ioGz3mnj5nAZE1VSPAtSbIVPzFeccLUaeEZkInkuVE3i9VOUuPWRONMvYGhB1stL9o6vsstyoEz+Ou0VpOitld6QktGF7I/n8fwaU7xGYXVUESZBoH/L1ObHqrYNYWuq4euAOcZGxeIA2mgQhjo3oboXoC8UMPeAiH8XPdtKb7Wi3u5PWizBKv1ih0e/Tfu4/Wy7wHnkQIpd7l5J3NTMuwQEmXVfcINq9PVsE4BloLN2zYOlSTVud59y4i82QV630+AdCpapaFMwI8JIbc58qR55G3SluRphsy8ZqS2nE7zVP2e/OOyps=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192cbf23-15c9-4581-e09b-08d6a3e07fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 16:09:53.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Write initial words into SAI FIFO to reduce the underrun
error.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index db9e0872f73d..99edbba4e8fa 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -503,7 +503,9 @@ static int fsl_sai_trigger(struct snd_pcm_substream *su=
bstream, int cmd,
 {
 	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int channels =3D substream->runtime->channels;
 	u32 xcsr, count =3D 100;
+	int i;
=20
 	/*
 	 * Asynchronous mode: Clear SYNC for both Tx and Rx.
@@ -526,6 +528,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *s=
ubstream, int cmd,
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
=20
+		for (i =3D 0; tx && i < channels; i++)
+			regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);
+		if (tx)
+			udelay(10);
+
 		regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
 				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 		regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
--=20
2.17.1

