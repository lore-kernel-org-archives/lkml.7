Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B950BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C4220868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h4xIcnYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfCHRkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:40:18 -0500
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:43909
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfCHRkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLPZuDNtAmLY2pBD2Iev2mhnPm4awKRqYHy4yfIG4ow=;
 b=h4xIcnYxt+qwES/MiAsGiGDzdjU7jQI7LEjgsowgPMEMxiOhhpIYmd7AeuUNu4WpzJW+UQooAucI+O7Ggy8YQvkfmKLf+rU8RMtat2ZKjHfa7u2wuHyF04Ro1gERPI4mP2RxZiBNmZ+OaSu22G2eFDh+2LnrXS1j4wMRr1Xl/k4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2781.eurprd04.prod.outlook.com (10.172.255.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 17:39:31 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 17:39:31 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] ASoC: fsl: sai: Fix underrrun for playback stream start
Thread-Topic: [PATCH v2] ASoC: fsl: sai: Fix underrrun for playback stream
 start
Thread-Index: AQHU1dXiyuPWZlRM30GhOcyE/WGqxg==
Date:   Fri, 8 Mar 2019 17:39:30 +0000
Message-ID: <20190308173904.27298-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0075.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::16) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f41f78d-6bef-4ea3-5efe-08d6a3ed050c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2781;
x-ms-traffictypediagnostic: VI1PR0402MB2781:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB2781;23:xDz/Fg3VsIG1oixmWahXmVgP/9qzrp8uJa1t9?=
 =?iso-8859-1?Q?HdZrvhgHoPE97Qdsr1SfI6sSrxsfOLfaPqM54T7bp+n4QsyIN4+HmDztC7?=
 =?iso-8859-1?Q?02mGADKmiAwRfUyurUjJrv2ootiMu03spx4rxIuE2IukPpL6HAjc2QjOdr?=
 =?iso-8859-1?Q?FX/Ry/C+sz/HjTcNrKJgzxVQ1YTI0TQS9Hk4cNGGW9Vk9KV1arexsI2OE0?=
 =?iso-8859-1?Q?dEbQs6lweCN5C5AkkG+iiBIH5GFRD+SED7UG/fKi2uQt0IJukP91Kl84LF?=
 =?iso-8859-1?Q?0KRBcOmB/KN8g8FS9SnDLbQKUeaOMlVKvGnEfUEfyFOdgaVCdncdexDD/O?=
 =?iso-8859-1?Q?8J6T5tGoFpOwVz/v/Xjs1YEYMu4XtkwZAG8NIe3k6kyTZ9ropyG78uGKAE?=
 =?iso-8859-1?Q?nIOxGZALXGCQ5MrNtFlzDEkv+qOTCSGnP/DATlG57xB1wSJJH+vjyCi3J0?=
 =?iso-8859-1?Q?8sCxrVTzd8yP42Dt+yBQkGltnloXT5mtJPXJvARcJSIIKsD8QT8aZZbznP?=
 =?iso-8859-1?Q?UKF1csaxdl1w1BkXxSuBYepUeIK4pQc1k4C6/9RFtWVOAPXk4Tm+NN+pl2?=
 =?iso-8859-1?Q?kA+nfJCBEJWg6acsSXji2QsVV7qpcDzpMtr2x/+aOU/7rmzkE2SKmQKyO4?=
 =?iso-8859-1?Q?j5ZFdfVzQwLBB+B/mFeNrfC4m+xK24MHntfvyrIIfHkLVNnquDxqWXaVtd?=
 =?iso-8859-1?Q?OOca4QEi0Jou/Bn3Y30RTmCnVTPw5jbiApFYQQuMDzgFPcQz4Hk9xxH+Pi?=
 =?iso-8859-1?Q?1GTelOp+kjiChlMiMwsrTTve+OS+2gCrv3s0tt+AIOQkitINfHiUtkeOuS?=
 =?iso-8859-1?Q?VFKIFMd7oaIP/DlAVbuJUsLQUJInPaIAwzpRGA4OpJ/nINNX44TreSn//G?=
 =?iso-8859-1?Q?g8N7829jSHe3thvuZOjRp+E3rNv9sOtWzUCTi2r4xeLdyQRiz9yE/d8Q4P?=
 =?iso-8859-1?Q?TGITOrornEJl2j1KLGE4/kYvAC/enJpyoW/8LrpVcamb93DVkAzUuaav1X?=
 =?iso-8859-1?Q?FTffU5fdxr7HrRKVzvtiteq69gyLpiyBnSrY8Ml4HtlnOnuLyUQ9aNU2cm?=
 =?iso-8859-1?Q?rK44jKIV6yn3ZUkMM9QaQ3XxtrfmB/QJ+kvsfJTJvWjpatUuSggQ1tLAMb?=
 =?iso-8859-1?Q?NEMGtF7uh56w3sLIqhtQsMNMPxEbjGZSNItmUnQ4HXhnL+Fgmas0LyKpaf?=
 =?iso-8859-1?Q?xlD+Zo3BfHjOGAYaeJ7HFbEU9TGP5vpV6kWgKHNEeHmuj24FZK6hGmTdMX?=
 =?iso-8859-1?Q?IYdSoNgBZAahmElzfzmMFbAVS8i/LDW3NjMwABmq/TcNp1kghcGsIUo/D9?=
 =?iso-8859-1?Q?kfC3cSxAxF87Mn7SBfbdstmv9UUWuAIVC9cRsE+JCSN7ZnzmZKuye3ys7H?=
 =?iso-8859-1?Q?c5PIqzjcWn9oTSDFxGg/MiJfY/fVzdjtCv5B+SeRvO+HRrpIUKLIA=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB278108BB4046064F8EAC3D8FF94D0@VI1PR0402MB2781.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(52084003)(6306002)(6512007)(6486002)(6916009)(5640700003)(81166006)(8676002)(316002)(26005)(7736002)(1730700003)(6436002)(54906003)(305945005)(44832011)(81156014)(486006)(86362001)(2616005)(476003)(36756003)(50226002)(66066001)(68736007)(53936002)(97736004)(8936002)(99286004)(256004)(14444005)(105586002)(71200400001)(2351001)(106356001)(52116002)(1076003)(71190400001)(4326008)(966005)(186003)(14454004)(25786009)(6506007)(386003)(2501003)(6116002)(3846002)(478600001)(102836004)(5660300002)(2906002)(49343001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2781;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EmxFJ6dZefxA1KK2weFjn3eqc9ceP94mZjpnZPZWOsH+pNe2eb8OXdkxQIu4q0rYQe//uxluQjucRm0p3gjxLyBBbmjuyHOvcu2f84XFB1OVOvsg3qnIbvGzlnalCda4Tq+z2EQYWxn5Dpic7yB/d96j7EI0WL8wirVFqgrvf+3cmovIfsL3Qwzaui93uG26CftiGlY6OvFy3fZ8Hc1FAWS8/z1OfwfPUSDBXRyG+fSlqgsZ0xixX5UsKDPtXgLs0A391wUsK/ypB+cI6BCWz/moyE2p1okkxTYTuXNaXBnx5EdwQbyKE0EscknDt1R5Ky/yJUXropLPYbLfID+VYkkO11lTboBDG6T5zFauk1uwrRldyPvR/4LoDVKbHcQ6+h5fNRfr+dnBP3R/6uzZsp1Wcvegw8Qhd/tqSYiOU5Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f41f78d-6bef-4ea3-5efe-08d6a3ed050c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 17:39:31.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

For [dir=3Dplayback, cmd =3D PCM_TRIGGER_START], fsl_sai_trigger
does the following:
	* Enable DMA request
	* Enable Transmitter

Now, because DMA doesn't copy data to TDR fast enough we hit
TX FIFO underrun error:

[   37.175974] fsl-sai 308b0000.sai: isr: Transmit underrun detected

The explanation for this can be found in SAI documentation for example
chapter 16.16.3.5.2 FIFO pointers of the i.MX8DXP reference manual [1]

"
If the Transmit FIFO is empty, then to avoid a FIFO underrun,
the Transmit Data Register must be written at least 3 bit clocks
before the start of the next unmasked word. Before enabling the
transmitter, the Transmit FIFO should be initialized with data
(since after the transmitter is enabled, the transmitter will
start a new frame, and if no data is in the FIFO, then the
transmitter will immediately give an error).
"

[1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
 - as per Fabio's request clarify the issue and the solution
 - move words writing before enabling DMA request

 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 2d376e3a3c80..a739baa99c1a 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -522,7 +522,9 @@ static int fsl_sai_trigger(struct snd_pcm_substream *su=
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
@@ -542,6 +544,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *s=
ubstream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		for (i =3D 0; tx && i < channels; i++)
+			regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);
+		if (tx)
+			udelay(10);
+
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
=20
--=20
2.17.1

