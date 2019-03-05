Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87798C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D0C2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y68nCTE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCEL0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:26:50 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:56184 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfCEL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:26:50 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="28730381"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 04:26:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 04:26:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgJBMcrHYvhXfYzgkZBhgS3dmuYfsomLcxRrYkdZTG0=;
 b=Y68nCTE8oZAk0BzyfzaOHKXfAouXp0yZJcJA610mFq7/r4sQxaph7O7OXSxGmungKyFB9ga8gUiMIDH1ksPhk0+wmxiKu8WNMJJe5GpQ4fUzYJ3+Q0ls6TFqqbsaKXp9jK0AXaZFPD8nFlQFYZ9QhMkrzlEpxXPYRix/iD8PpsE=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1382.namprd11.prod.outlook.com (10.173.16.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 11:26:45 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1665.019; Tue, 5 Mar 2019
 11:26:45 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Cristian.Birsan@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel
 Controller
Thread-Topic: [PATCH 2/2] ASoC: mchp-i2s-mcc: add driver for I2SC
 Multi-Channel Controller
Thread-Index: AQHU00ZQIIUwSm+89EWzJ2mlfJLXYQ==
Date:   Tue, 5 Mar 2019 11:26:45 +0000
Message-ID: <20190305112610.9641-2-codrin.ciubotariu@microchip.com>
References: <20190305112610.9641-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190305112610.9641-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0072.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::16) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e85de05-a8c9-4d83-a96b-08d6a15d72d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1382;
x-ms-traffictypediagnostic: CY4PR11MB1382:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1382;23:EE4V4vjkpKTg9/Trrgktp+OkEA9KpnhjQZ8cKYj?=
 =?iso-8859-1?Q?nRa/JGhFQaN0EMryhXYvdyRPu9JAKtT91EhAunyw+REbwqPh0YVi3ta15E?=
 =?iso-8859-1?Q?6w9lSeamkFpeswIEdtLeXKxcJIsqkY7QUlf23VIKgpWRX3yGD4gouxYzr3?=
 =?iso-8859-1?Q?YciBljJD2AC+OO219mWzlRU1/X4UY8rl1022aFqyIycobPQqFEobMxPpH3?=
 =?iso-8859-1?Q?dG0E179SF4kakMTyvF0m06RgJ1eb2GDGPZK/jz37s/oHT4AbJURrNlN8zF?=
 =?iso-8859-1?Q?DUTSDE5QnGkxlwA7EQSVe8FbL7afdQGDQTDGFq8w0uJe/scEOmvgVcFSU7?=
 =?iso-8859-1?Q?Bttv0gLlq/YDE9KH/VwSUXfbbGmuPETK/eUrpA0aK5c8yIR/UP2+foUqiS?=
 =?iso-8859-1?Q?NwYL1EubJVm+gUHNcm713bICuEHlREpLC4FrTIBz5JdMjpbK4fbQyHu9uB?=
 =?iso-8859-1?Q?foPxi0Fdu5YpAWqH3CoEpJ0xt3AG66XUhgBRhdTVgbgKIv2xk9NIZf3USY?=
 =?iso-8859-1?Q?8uXB1LMR4ZQoNc+0PwxNUZcBkE9/OfOmZgipZVqsjog2z6vU2WpN/Wlwrm?=
 =?iso-8859-1?Q?ptRcphOfTw6fvSmMftcqe1n/q3bZanOyHnP4IR6rcP++V0c321sFSuKqyf?=
 =?iso-8859-1?Q?/aBVSuwrEcs1ufko1Hb1+AZwfzbFBAU7un7p+EvSiynLQaeafiMcJGoER9?=
 =?iso-8859-1?Q?wCAAartEA5ENC8GDe5+dT8Fr2GLAdOp37Xz+VeD4NZDG6z2M+XPQasOLNV?=
 =?iso-8859-1?Q?rI5m+0E+qTVWrObF0/BwRdg582AbZNhAwSzzFeE7Jq6hzItwyQlv4IDjMt?=
 =?iso-8859-1?Q?wotRy+Q11ZyVDi3Q3XgGCRdE+mJYAtYy2MPtTBp0tM66tGEIcoL5mfS4TJ?=
 =?iso-8859-1?Q?XXUKRreJIdCRVP3cs3hMFRMn2KTgcK155kcM0SVwtXrX437wee/FrTmwfY?=
 =?iso-8859-1?Q?bsNTM1kTTnUg+Vj6vYMRxnx7F4Bm8X3na5DtPb3v8obWKWnN07OFOF7scb?=
 =?iso-8859-1?Q?b8DT1Oo6ghzOpFj0+W+HTUleGZBBNCG1XFFYiNNaxsTxUEevHxVKnjsN09?=
 =?iso-8859-1?Q?5a28esO+odXYcCpZeGAQ+71Rzr1/4NP/m6BEJ+28olH2/jT5ktKV/iRWNa?=
 =?iso-8859-1?Q?UzkT7pLU1IPbe/bbnL+iMkuY6UNI+oEGwHM2931v4XMeuXWG5Nck8eMPGF?=
 =?iso-8859-1?Q?3ufcno01EMEMwClSo2VygjHTF0RU4FRMB456qrPEnY6ei/G+cUzoQKNkts?=
 =?iso-8859-1?Q?b4x3bPp+3OBEIEdrLdh0DUxESblgKBm+4QhMgua/Bv78YQ8VGAc8zdVNx9?=
 =?iso-8859-1?Q?XWHeuZypBPfb0qqpkyeM6Ktm9XrBDPKySm/PB19v55+UuUFxAcXN9bGnZE?=
 =?iso-8859-1?Q?a7YLV0e5E+D1FvGHF+tj7hH8UuTxFef9HReXZkjW36dxy5WYfz0bhvNYxK?=
 =?iso-8859-1?Q?/GX93FgXshwjNn9ykWF43q6M9I801FhOdEV?=
x-microsoft-antispam-prvs: <CY4PR11MB1382FE078ACCA979DF7DE084E7720@CY4PR11MB1382.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(2616005)(81156014)(5660300002)(6436002)(256004)(110136005)(86362001)(107886003)(386003)(11346002)(486006)(186003)(50226002)(66066001)(25786009)(476003)(102836004)(6506007)(2201001)(68736007)(4326008)(54906003)(1076003)(99286004)(76176011)(26005)(316002)(52116002)(30864003)(14444005)(81166006)(72206003)(8676002)(53946003)(6486002)(53936002)(6512007)(446003)(8936002)(97736004)(71190400001)(305945005)(7736002)(478600001)(2501003)(106356001)(105586002)(36756003)(6116002)(14454004)(3846002)(71200400001)(2906002)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1382;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V1epaMWZbUBSTU76SycljPNyvupqUDXqsaZsX12mQkjbkuLMkqxSEm+UxYPyte7AidIh1X1FgZzKGHAuR39s1SDPqIufSShak/BgVXXgSjJHJFvJHLQtoJQLyTToczXYXb6TF5nDjjunclvrwVSwCnDpMX0qsU7DwNYMrlnCJhXmz9TNCnnh+5DdKqEtKZLwlXW6weMzZcL/brYhFAcjJ28rFJlI2T+W5gwNrS8NpvvyULS2qq0S9kFh+1kqgLMuAQhQERuPlrTf6dykmO+6SAsy1/FOvEeZvSGDys8dk+t/1cj/WZc4kDfLUpsF/q/YSelTHROUl7txZOEXv4+6l2AkBjUaCn6NQCacpAaBoBgIKPZfUoAX49ivFIsPtddzdMp+/mO47ZnFiYLqdICnZAhfypS/qzEtsoPjnzcZWIQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e85de05-a8c9-4d83-a96b-08d6a15d72d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 11:26:45.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1382
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

The Inter-IC Sound Controller (I2SMCC) provides a 5-wire, bidirectional,
synchronous, digital audio link to external audio devices: I2SMCC_DIN,
I2SMCC_DOUT, I2SMCC_WS, I2SMCC_CK, and I2SMCC_MCK pins.
The I2SMCC complies with the Inter-IC Sound (I2S) bus specification and
supports a Time Division Multiplexed (TDM) interface with external
multi-channel audio codecs.
The I2SMCC consists of a receiver, a transmitter and a common clock
generator that can be enabled separately to provide Master, Slave or
Controller modes with receiver and/or transmitter active.
DMA Controller channels, separate for the receiver and for the transmitter,
allow a continuous high bit rate data transfer without processor
intervention to the following:
 - Audio CODECs in Master, Slave, or Controller mode
 - Stereo DAC or ADC through a dedicated I2S serial interface
 - Multi-channel or multiple stereo DACs or ADCs, using the TDM format

This IP is embedded in Microchip's new sam9x60 SoC.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/Kconfig        |  14 +
 sound/soc/atmel/Makefile       |   2 +
 sound/soc/atmel/mchp-i2s-mcc.c | 974 +++++++++++++++++++++++++++++++++
 3 files changed, 990 insertions(+)
 create mode 100644 sound/soc/atmel/mchp-i2s-mcc.c

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 64f86f0b87e5..c473b9e463ab 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -109,4 +109,18 @@ config SND_SOC_MIKROE_PROTO
 	  using I2C over SDA (MPU Data Input) and SCL (MPU Clock Input) pins.
 	  Both playback and capture are supported.
=20
+config SND_MCHP_SOC_I2S_MCC
+	tristate "Microchip ASoC driver for boards using I2S MCC"
+	depends on OF && (ARCH_AT91 || COMPILE_TEST)
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select REGMAP_MMIO
+	help
+	  Say Y or M if you want to add support for I2S Multi-Channel ASoC
+	  driver on the following Microchip platforms:
+	  - sam9x60
+
+	  The I2SMCC complies with the Inter-IC Sound (I2S) bus specification
+	  and supports a Time Division Multiplexed (TDM) interface with
+	  external multi-channel audio codecs.
+
 endif
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index 9f41bfa0fea3..1f6890ed3738 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -4,11 +4,13 @@ snd-soc-atmel-pcm-pdc-objs :=3D atmel-pcm-pdc.o
 snd-soc-atmel-pcm-dma-objs :=3D atmel-pcm-dma.o
 snd-soc-atmel_ssc_dai-objs :=3D atmel_ssc_dai.o
 snd-soc-atmel-i2s-objs :=3D atmel-i2s.o
+snd-soc-mchp-i2s-mcc-objs :=3D mchp-i2s-mcc.o
=20
 obj-$(CONFIG_SND_ATMEL_SOC_PDC) +=3D snd-soc-atmel-pcm-pdc.o
 obj-$(CONFIG_SND_ATMEL_SOC_DMA) +=3D snd-soc-atmel-pcm-dma.o
 obj-$(CONFIG_SND_ATMEL_SOC_SSC) +=3D snd-soc-atmel_ssc_dai.o
 obj-$(CONFIG_SND_ATMEL_SOC_I2S) +=3D snd-soc-atmel-i2s.o
+obj-$(CONFIG_SND_MCHP_SOC_I2S_MCC) +=3D snd-soc-mchp-i2s-mcc.o
=20
 # AT91 Machine Support
 snd-soc-sam9g20-wm8731-objs :=3D sam9g20_wm8731.o
diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.=
c
new file mode 100644
index 000000000000..86495883ca3f
--- /dev/null
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -0,0 +1,974 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for Microchip I2S Multi-channel controller
+//
+// Copyright (C) 2018 Microchip Technology Inc. and its subsidiaries
+//
+// Author: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/lcm.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+/*
+ * ---- I2S Controller Register map ----
+ */
+#define MCHP_I2SMCC_CR		0x0000	/* Control Register */
+#define MCHP_I2SMCC_MRA		0x0004	/* Mode Register A */
+#define MCHP_I2SMCC_MRB		0x0008	/* Mode Register B */
+#define MCHP_I2SMCC_SR		0x000C	/* Status Register */
+#define MCHP_I2SMCC_IERA	0x0010	/* Interrupt Enable Register A */
+#define MCHP_I2SMCC_IDRA	0x0014	/* Interrupt Disable Register A */
+#define MCHP_I2SMCC_IMRA	0x0018	/* Interrupt Mask Register A */
+#define MCHP_I2SMCC_ISRA	0X001C	/* Interrupt Status Register A */
+
+#define MCHP_I2SMCC_IERB	0x0020	/* Interrupt Enable Register B */
+#define MCHP_I2SMCC_IDRB	0x0024	/* Interrupt Disable Register B */
+#define MCHP_I2SMCC_IMRB	0x0028	/* Interrupt Mask Register B */
+#define MCHP_I2SMCC_ISRB	0X002C	/* Interrupt Status Register B */
+
+#define MCHP_I2SMCC_RHR		0x0030	/* Receiver Holding Register */
+#define MCHP_I2SMCC_THR		0x0034	/* Transmitter Holding Register */
+
+#define MCHP_I2SMCC_RHL0R	0x0040	/* Receiver Holding Left 0 Register */
+#define MCHP_I2SMCC_RHR0R	0x0044	/* Receiver Holding Right 0 Register */
+
+#define MCHP_I2SMCC_RHL1R	0x0048	/* Receiver Holding Left 1 Register */
+#define MCHP_I2SMCC_RHR1R	0x004C	/* Receiver Holding Right 1 Register */
+
+#define MCHP_I2SMCC_RHL2R	0x0050	/* Receiver Holding Left 2 Register */
+#define MCHP_I2SMCC_RHR2R	0x0054	/* Receiver Holding Right 2 Register */
+
+#define MCHP_I2SMCC_RHL3R	0x0058	/* Receiver Holding Left 3 Register */
+#define MCHP_I2SMCC_RHR3R	0x005C	/* Receiver Holding Right 3 Register */
+
+#define MCHP_I2SMCC_THL0R	0x0060	/* Transmitter Holding Left 0 Register */
+#define MCHP_I2SMCC_THR0R	0x0064	/* Transmitter Holding Right 0 Register *=
/
+
+#define MCHP_I2SMCC_THL1R	0x0068	/* Transmitter Holding Left 1 Register */
+#define MCHP_I2SMCC_THR1R	0x006C	/* Transmitter Holding Right 1 Register *=
/
+
+#define MCHP_I2SMCC_THL2R	0x0070	/* Transmitter Holding Left 2 Register */
+#define MCHP_I2SMCC_THR2R	0x0074	/* Transmitter Holding Right 2 Register *=
/
+
+#define MCHP_I2SMCC_THL3R	0x0078	/* Transmitter Holding Left 3 Register */
+#define MCHP_I2SMCC_THR3R	0x007C	/* Transmitter Holding Right 3 Register *=
/
+
+#define MCHP_I2SMCC_VERSION	0x00FC	/* Version Register */
+
+/*
+ * ---- Control Register (Write-only) ----
+ */
+#define MCHP_I2SMCC_CR_RXEN		BIT(0)	/* Receiver Enable */
+#define MCHP_I2SMCC_CR_RXDIS		BIT(1)	/* Receiver Disable */
+#define MCHP_I2SMCC_CR_CKEN		BIT(2)	/* Clock Enable */
+#define MCHP_I2SMCC_CR_CKDIS		BIT(3)	/* Clock Disable */
+#define MCHP_I2SMCC_CR_TXEN		BIT(4)	/* Transmitter Enable */
+#define MCHP_I2SMCC_CR_TXDIS		BIT(5)	/* Transmitter Disable */
+#define MCHP_I2SMCC_CR_SWRST		BIT(7)	/* Software Reset */
+
+/*
+ * ---- Mode Register A (Read/Write) ----
+ */
+#define MCHP_I2SMCC_MRA_MODE_MASK		GENMASK(0, 0)
+#define MCHP_I2SMCC_MRA_MODE_SLAVE		(0 << 0)
+#define MCHP_I2SMCC_MRA_MODE_MASTER		(1 << 0)
+
+#define MCHP_I2SMCC_MRA_DATALENGTH_MASK			GENMASK(3, 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_32_BITS		(0 << 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_24_BITS		(1 << 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_20_BITS		(2 << 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_18_BITS		(3 << 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_16_BITS		(4 << 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_16_BITS_COMPACT	(5 << 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_8_BITS		(6 << 1)
+#define MCHP_I2SMCC_MRA_DATALENGTH_8_BITS_COMPACT	(7 << 1)
+
+#define MCHP_I2SMCC_MRA_WIRECFG_MASK		GENMASK(5, 4)
+#define MCHP_I2SMCC_MRA_WIRECFG_I2S_1_TDM_0	(0 << 4)
+#define MCHP_I2SMCC_MRA_WIRECFG_I2S_2_TDM_1	(1 << 4)
+#define MCHP_I2SMCC_MRA_WIRECFG_I2S_4_TDM_2	(2 << 4)
+#define MCHP_I2SMCC_MRA_WIRECFG_TDM_3		(3 << 4)
+
+#define MCHP_I2SMCC_MRA_FORMAT_MASK		GENMASK(7, 6)
+#define MCHP_I2SMCC_MRA_FORMAT_I2S		(0 << 6)
+#define MCHP_I2SMCC_MRA_FORMAT_LJ		(1 << 6) /* Left Justified */
+#define MCHP_I2SMCC_MRA_FORMAT_TDM		(2 << 6)
+#define MCHP_I2SMCC_MRA_FORMAT_TDMLJ		(3 << 6)
+
+/* Transmitter uses one DMA channel ... */
+/* Left audio samples duplicated to right audio channel */
+#define MCHP_I2SMCC_MRA_RXMONO			BIT(8)
+
+/* I2SDO output of I2SC is internally connected to I2SDI input */
+#define MCHP_I2SMCC_MRA_RXLOOP			BIT(9)
+
+/* Receiver uses one DMA channel ... */
+/* Left audio samples duplicated to right audio channel */
+#define MCHP_I2SMCC_MRA_TXMONO			BIT(10)
+
+/* x sample transmitted when underrun */
+#define MCHP_I2SMCC_MRA_TXSAME_ZERO		(0 << 11) /* Zero sample */
+#define MCHP_I2SMCC_MRA_TXSAME_PREVIOUS		(1 << 11) /* Previous sample */
+
+/* select between peripheral clock and generated clock */
+#define MCHP_I2SMCC_MRA_SRCCLK_PCLK		(0 << 12)
+#define MCHP_I2SMCC_MRA_SRCCLK_GCLK		(1 << 12)
+
+/* Number of TDM Channels - 1 */
+#define MCHP_I2SMCC_MRA_NBCHAN_MASK		GENMASK(15, 13)
+#define MCHP_I2SMCC_MRA_NBCHAN(ch) \
+	((((ch) - 1) << 13) & MCHP_I2SMCC_MRA_NBCHAN_MASK)
+
+/* Selected Clock to I2SMCC Master Clock ratio */
+#define MCHP_I2SMCC_MRA_IMCKDIV_MASK		GENMASK(21, 16)
+#define MCHP_I2SMCC_MRA_IMCKDIV(div) \
+	(((div) << 16) & MCHP_I2SMCC_MRA_IMCKDIV_MASK)
+
+/* TDM Frame Synchronization */
+#define MCHP_I2SMCC_MRA_TDMFS_MASK		GENMASK(23, 22)
+#define MCHP_I2SMCC_MRA_TDMFS_SLOT		(0 << 22)
+#define MCHP_I2SMCC_MRA_TDMFS_HALF		(1 << 22)
+#define MCHP_I2SMCC_MRA_TDMFS_BIT		(2 << 22)
+
+/* Selected Clock to I2SMC Serial Clock ratio */
+#define MCHP_I2SMCC_MRA_ISCKDIV_MASK		GENMASK(29, 24)
+#define MCHP_I2SMCC_MRA_ISCKDIV(div) \
+	(((div) << 24) & MCHP_I2SMCC_MRA_ISCKDIV_MASK)
+
+/* Master Clock mode */
+#define MCHP_I2SMCC_MRA_IMCKMODE_MASK		GENMASK(30, 30)
+/* 0: No master clock generated*/
+#define MCHP_I2SMCC_MRA_IMCKMODE_NONE		(0 << 30)
+/* 1: master clock generated (internally generated clock drives I2SMCK pin=
) */
+#define MCHP_I2SMCC_MRA_IMCKMODE_GEN		(1 << 30)
+
+/* Slot Width */
+/* 0: slot is 32 bits wide for DATALENGTH =3D 18/20/24 bits. */
+/* 1: slot is 24 bits wide for DATALENGTH =3D 18/20/24 bits. */
+#define MCHP_I2SMCC_MRA_IWS			BIT(31)
+
+/*
+ * ---- Mode Register B (Read/Write) ----
+ */
+/* all enabled I2S left channels are filled first, then I2S right channels=
 */
+#define MCHP_I2SMCC_MRB_CRAMODE_LEFT_FIRST	(0 << 0)
+/*
+ * an enabled I2S left channel is filled, then the corresponding right
+ * channel, until all channels are filled
+ */
+#define MCHP_I2SMCC_MRB_CRAMODE_REGULAR		(1 << 0)
+
+#define MCHP_I2SMCC_MRB_FIFOEN			BIT(1)
+
+#define MCHP_I2SMCC_MRB_DMACHUNK_MASK		GENMASK(9, 8)
+#define MCHP_I2SMCC_MRB_DMACHUNK(no_words) \
+	(((fls(no_words) - 1) << 8) & MCHP_I2SMCC_MRB_DMACHUNK_MASK)
+
+#define MCHP_I2SMCC_MRB_CLKSEL_MASK		GENMASK(16, 16)
+#define MCHP_I2SMCC_MRB_CLKSEL_EXT		(0 << 16)
+#define MCHP_I2SMCC_MRB_CLKSEL_INT		(1 << 16)
+
+/*
+ * ---- Status Registers (Read-only) ----
+ */
+#define MCHP_I2SMCC_SR_RXEN		BIT(0)	/* Receiver Enabled */
+#define MCHP_I2SMCC_SR_TXEN		BIT(4)	/* Transmitter Enabled */
+
+/*
+ * ---- Interrupt Enable/Disable/Mask/Status Registers A ----
+ */
+#define MCHP_I2SMCC_INT_TXRDY_MASK(ch)		GENMASK((ch) - 1, 0)
+#define MCHP_I2SMCC_INT_TXRDYCH(ch)		BIT(ch)
+#define MCHP_I2SMCC_INT_TXUNF_MASK(ch)		GENMASK((ch) + 7, 8)
+#define MCHP_I2SMCC_INT_TXUNFCH(ch)		BIT((ch) + 8)
+#define MCHP_I2SMCC_INT_RXRDY_MASK(ch)		GENMASK((ch) + 15, 16)
+#define MCHP_I2SMCC_INT_RXRDYCH(ch)		BIT((ch) + 16)
+#define MCHP_I2SMCC_INT_RXOVF_MASK(ch)		GENMASK((ch) + 23, 24)
+#define MCHP_I2SMCC_INT_RXOVFCH(ch)		BIT((ch) + 24)
+
+/*
+ * ---- Interrupt Enable/Disable/Mask/Status Registers B ----
+ */
+#define MCHP_I2SMCC_INT_WERR			BIT(0)
+#define MCHP_I2SMCC_INT_TXFFRDY			BIT(8)
+#define MCHP_I2SMCC_INT_TXFFEMP			BIT(9)
+#define MCHP_I2SMCC_INT_RXFFRDY			BIT(12)
+#define MCHP_I2SMCC_INT_RXFFFUL			BIT(13)
+
+/*
+ * ---- Version Register (Read-only) ----
+ */
+#define MCHP_I2SMCC_VERSION_MASK		GENMASK(11, 0)
+
+#define MCHP_I2SMCC_MAX_CHANNELS		8
+#define MCHP_I2MCC_TDM_SLOT_WIDTH		32
+
+static const struct regmap_config mchp_i2s_mcc_regmap_config =3D {
+	.reg_bits =3D 32,
+	.reg_stride =3D 4,
+	.val_bits =3D 32,
+	.max_register =3D MCHP_I2SMCC_VERSION,
+};
+
+struct mchp_i2s_mcc_dev {
+	struct wait_queue_head			wq_txrdy;
+	struct wait_queue_head			wq_rxrdy;
+	struct device				*dev;
+	struct regmap				*regmap;
+	struct clk				*pclk;
+	struct clk				*gclk;
+	struct snd_dmaengine_dai_dma_data	playback;
+	struct snd_dmaengine_dai_dma_data	capture;
+	unsigned int				fmt;
+	unsigned int				sysclk;
+	unsigned int				frame_length;
+	int					tdm_slots;
+	int					channels;
+	int					gclk_use:1;
+	int					gclk_running:1;
+	int					tx_rdy:1;
+	int					rx_rdy:1;
+};
+
+static irqreturn_t mchp_i2s_mcc_interrupt(int irq, void *dev_id)
+{
+	struct mchp_i2s_mcc_dev *dev =3D dev_id;
+	u32 sra, imra, srb, imrb, pendinga, pendingb, idra =3D 0;
+	irqreturn_t ret =3D IRQ_NONE;
+
+	regmap_read(dev->regmap, MCHP_I2SMCC_IMRA, &imra);
+	regmap_read(dev->regmap, MCHP_I2SMCC_ISRA, &sra);
+	pendinga =3D imra & sra;
+
+	regmap_read(dev->regmap, MCHP_I2SMCC_IMRB, &imrb);
+	regmap_read(dev->regmap, MCHP_I2SMCC_ISRB, &srb);
+	pendingb =3D imrb & srb;
+
+	if (!pendinga && !pendingb)
+		return IRQ_NONE;
+
+	/*
+	 * Tx/Rx ready interrupts are enabled when stopping only, to assure
+	 * availability and to disable clocks if necessary
+	 */
+	idra |=3D pendinga & (MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels) |
+			    MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels));
+	if (idra)
+		ret =3D IRQ_HANDLED;
+
+	if ((imra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels)) &&
+	    (imra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels)) =3D=3D
+	    (idra & MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels))) {
+		dev->tx_rdy =3D 1;
+		wake_up_interruptible(&dev->wq_txrdy);
+	}
+	if ((imra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels)) &&
+	    (imra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels)) =3D=3D
+	    (idra & MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels))) {
+		dev->rx_rdy =3D 1;
+		wake_up_interruptible(&dev->wq_rxrdy);
+	}
+	regmap_write(dev->regmap, MCHP_I2SMCC_IDRA, idra);
+
+	return ret;
+}
+
+static int mchp_i2s_mcc_set_sysclk(struct snd_soc_dai *dai,
+				   int clk_id, unsigned int freq, int dir)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(dev->dev, "%s() clk_id=3D%d freq=3D%u dir=3D%d\n",
+		__func__, clk_id, freq, dir);
+
+	/* We do not need SYSCLK */
+	if (dir =3D=3D SND_SOC_CLOCK_IN)
+		return 0;
+
+	dev->sysclk =3D freq;
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_set_bclk_ratio(struct snd_soc_dai *dai,
+				       unsigned int ratio)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(dev->dev, "%s() ratio=3D%u\n", __func__, ratio);
+
+	dev->frame_length =3D ratio;
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_set_dai_fmt(struct snd_soc_dai *dai, unsigned int =
fmt)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(dev->dev, "%s() fmt=3D%#x\n", __func__, fmt);
+
+	/* We don't support any kind of clock inversion */
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) !=3D SND_SOC_DAIFMT_NB_NF)
+		return -EINVAL;
+
+	/* We can't generate only FSYNC */
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) =3D=3D SND_SOC_DAIFMT_CBM_CFS)
+		return -EINVAL;
+
+	/* We can only reconfigure the IP when it's stopped */
+	if (fmt & SND_SOC_DAIFMT_CONT)
+		return -EINVAL;
+
+	dev->fmt =3D fmt;
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_set_dai_tdm_slot(struct snd_soc_dai *dai,
+					 unsigned int tx_mask,
+					 unsigned int rx_mask,
+					 int slots, int slot_width)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(dev->dev,
+		"%s() tx_mask=3D0x%08x rx_mask=3D0x%08x slots=3D%d width=3D%d\n",
+		__func__, tx_mask, rx_mask, slots, slot_width);
+
+	if (slots < 0 || slots > MCHP_I2SMCC_MAX_CHANNELS ||
+	    slot_width !=3D MCHP_I2MCC_TDM_SLOT_WIDTH)
+		return -EINVAL;
+
+	if (slots) {
+		/* We do not support daisy chain */
+		if (rx_mask !=3D GENMASK(slots - 1, 0) ||
+		    rx_mask !=3D tx_mask)
+			return -EINVAL;
+	}
+
+	dev->tdm_slots =3D slots;
+	dev->frame_length =3D slots * MCHP_I2MCC_TDM_SLOT_WIDTH;
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_clk_get_rate_diff(struct clk *clk,
+					  unsigned long rate,
+					  struct clk **best_clk,
+					  unsigned long *best_rate,
+					  unsigned long *best_diff_rate)
+{
+	long round_rate;
+	unsigned int diff_rate;
+
+	round_rate =3D clk_round_rate(clk, rate);
+	if (round_rate < 0)
+		return (int)round_rate;
+
+	diff_rate =3D abs(rate - round_rate);
+	if (diff_rate < *best_diff_rate) {
+		*best_clk =3D clk;
+		*best_diff_rate =3D diff_rate;
+		*best_rate =3D rate;
+	}
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_config_divs(struct mchp_i2s_mcc_dev *dev,
+				    unsigned int bclk, unsigned int *mra)
+{
+	unsigned long clk_rate;
+	unsigned long lcm_rate;
+	unsigned long best_rate =3D 0;
+	unsigned long best_diff_rate =3D ~0;
+	unsigned int sysclk;
+	struct clk *best_clk =3D NULL;
+	int ret;
+
+	/* For code simplification */
+	if (!dev->sysclk)
+		sysclk =3D bclk;
+	else
+		sysclk =3D dev->sysclk;
+
+	/*
+	 * MCLK is Selected CLK / (2 * IMCKDIV),
+	 * BCLK is Selected CLK / (2 * ISCKDIV);
+	 * if IMCKDIV or ISCKDIV are 0, MCLK or BCLK =3D Selected CLK
+	 */
+	lcm_rate =3D lcm(sysclk, bclk);
+	if ((lcm_rate / sysclk % 2 =3D=3D 1 && lcm_rate / sysclk > 2) ||
+	    (lcm_rate / bclk % 2 =3D=3D 1 && lcm_rate / bclk > 2))
+		lcm_rate *=3D 2;
+
+	for (clk_rate =3D lcm_rate;
+	     (clk_rate =3D=3D sysclk || clk_rate / (sysclk * 2) <=3D GENMASK(5, 0=
)) &&
+	     (clk_rate =3D=3D bclk || clk_rate / (bclk * 2) <=3D GENMASK(5, 0));
+	     clk_rate +=3D lcm_rate) {
+		ret =3D mchp_i2s_mcc_clk_get_rate_diff(dev->gclk, clk_rate,
+						     &best_clk, &best_rate,
+						     &best_diff_rate);
+		if (ret) {
+			dev_err(dev->dev, "gclk error for rate %lu: %d",
+				clk_rate, ret);
+		} else {
+			if (!best_diff_rate) {
+				dev_dbg(dev->dev, "found perfect rate on gclk: %lu\n",
+					clk_rate);
+				break;
+			}
+		}
+
+		ret =3D mchp_i2s_mcc_clk_get_rate_diff(dev->pclk, clk_rate,
+						     &best_clk, &best_rate,
+						     &best_diff_rate);
+		if (ret) {
+			dev_err(dev->dev, "pclk error for rate %lu: %d",
+				clk_rate, ret);
+		} else {
+			if (!best_diff_rate) {
+				dev_dbg(dev->dev, "found perfect rate on pclk: %lu\n",
+					clk_rate);
+				break;
+			}
+		}
+	}
+
+	/* check if clocks returned only errors */
+	if (!best_clk) {
+		dev_err(dev->dev, "unable to change rate to clocks\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev->dev, "source CLK is %s with rate %lu, diff %lu\n",
+		best_clk =3D=3D dev->pclk ? "pclk" : "gclk",
+		best_rate, best_diff_rate);
+
+	/* set the rate */
+	ret =3D clk_set_rate(best_clk, best_rate);
+	if (ret) {
+		dev_err(dev->dev, "unable to set rate %lu to %s: %d\n",
+			best_rate, best_clk =3D=3D dev->pclk ? "PCLK" : "GCLK",
+			ret);
+		return ret;
+	}
+
+	/* Configure divisors */
+	if (dev->sysclk)
+		*mra |=3D MCHP_I2SMCC_MRA_IMCKDIV(best_rate / (2 * sysclk));
+	*mra |=3D MCHP_I2SMCC_MRA_ISCKDIV(best_rate / (2 * bclk));
+
+	if (best_clk =3D=3D dev->gclk) {
+		*mra |=3D MCHP_I2SMCC_MRA_SRCCLK_GCLK;
+		ret =3D clk_prepare(dev->gclk);
+		if (ret < 0)
+			dev_err(dev->dev, "unable to prepare GCLK: %d\n", ret);
+		else
+			dev->gclk_use =3D 1;
+	} else {
+		*mra |=3D MCHP_I2SMCC_MRA_SRCCLK_PCLK;
+		dev->gclk_use =3D 0;
+	}
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_is_running(struct mchp_i2s_mcc_dev *dev)
+{
+	u32 sr;
+
+	regmap_read(dev->regmap, MCHP_I2SMCC_SR, &sr);
+	return !!(sr & (MCHP_I2SMCC_SR_TXEN | MCHP_I2SMCC_SR_RXEN));
+}
+
+static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+	u32 mra =3D 0;
+	u32 mrb =3D 0;
+	unsigned int channels =3D params_channels(params);
+	unsigned int frame_length =3D dev->frame_length;
+	unsigned int bclk_rate;
+	int set_divs =3D 0;
+	int ret;
+	bool is_playback =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)=
;
+
+	dev_dbg(dev->dev, "%s() rate=3D%u format=3D%#x width=3D%u channels=3D%u\n=
",
+		__func__, params_rate(params), params_format(params),
+		params_width(params), params_channels(params));
+
+	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		if (dev->tdm_slots) {
+			dev_err(dev->dev, "I2S with TDM is not supported\n");
+			return -EINVAL;
+		}
+		mra |=3D MCHP_I2SMCC_MRA_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		if (dev->tdm_slots) {
+			dev_err(dev->dev, "Left-Justified with TDM is not supported\n");
+			return -EINVAL;
+		}
+		mra |=3D MCHP_I2SMCC_MRA_FORMAT_LJ;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		mra |=3D MCHP_I2SMCC_MRA_FORMAT_TDM;
+		break;
+	default:
+		dev_err(dev->dev, "unsupported bus format\n");
+		return -EINVAL;
+	}
+
+	switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* cpu is BCLK and LRC master */
+		mra |=3D MCHP_I2SMCC_MRA_MODE_MASTER;
+		if (dev->sysclk)
+			mra |=3D MCHP_I2SMCC_MRA_IMCKMODE_GEN;
+		set_divs =3D 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		/* cpu is BCLK master */
+		mrb |=3D MCHP_I2SMCC_MRB_CLKSEL_INT;
+		set_divs =3D 1;
+		/* fall through */
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* cpu is slave */
+		mra |=3D MCHP_I2SMCC_MRA_MODE_SLAVE;
+		if (dev->sysclk)
+			dev_warn(dev->dev, "Unable to generate MCLK in Slave mode\n");
+		break;
+	default:
+		dev_err(dev->dev, "unsupported master/slave mode\n");
+		return -EINVAL;
+	}
+
+	if (dev->fmt & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
+		switch (channels) {
+		case 1:
+			if (is_playback)
+				mra |=3D MCHP_I2SMCC_MRA_TXMONO;
+			else
+				mra |=3D MCHP_I2SMCC_MRA_RXMONO;
+			break;
+		case 2:
+			break;
+		default:
+			dev_err(dev->dev, "unsupported number of audio channels\n");
+			return -EINVAL;
+		}
+
+		if (!frame_length)
+			frame_length =3D 2 * params_physical_width(params);
+	} else if (dev->fmt & SND_SOC_DAIFMT_DSP_A) {
+		if (dev->tdm_slots) {
+			if (channels % 2 && channels * 2 <=3D dev->tdm_slots) {
+				/*
+				 * Duplicate data for even-numbered channels
+				 * to odd-numbered channels
+				 */
+				if (is_playback)
+					mra |=3D MCHP_I2SMCC_MRA_TXMONO;
+				else
+					mra |=3D MCHP_I2SMCC_MRA_RXMONO;
+			}
+			channels =3D dev->tdm_slots;
+		}
+
+		mra |=3D MCHP_I2SMCC_MRA_NBCHAN(channels);
+		if (!frame_length)
+			frame_length =3D channels * MCHP_I2MCC_TDM_SLOT_WIDTH;
+	}
+
+	/*
+	 * We must have the same burst size configured
+	 * in the DMA transfer and in out IP
+	 */
+	mrb |=3D MCHP_I2SMCC_MRB_DMACHUNK(channels);
+	if (is_playback)
+		dev->playback.maxburst =3D 1 << (fls(channels) - 1);
+	else
+		dev->capture.maxburst =3D 1 << (fls(channels) - 1);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		mra |=3D MCHP_I2SMCC_MRA_DATALENGTH_8_BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		mra |=3D MCHP_I2SMCC_MRA_DATALENGTH_16_BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		mra |=3D MCHP_I2SMCC_MRA_DATALENGTH_18_BITS |
+		       MCHP_I2SMCC_MRA_IWS;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		mra |=3D MCHP_I2SMCC_MRA_DATALENGTH_20_BITS |
+		       MCHP_I2SMCC_MRA_IWS;
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		mra |=3D MCHP_I2SMCC_MRA_DATALENGTH_24_BITS |
+		       MCHP_I2SMCC_MRA_IWS;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		mra |=3D MCHP_I2SMCC_MRA_DATALENGTH_24_BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		mra |=3D MCHP_I2SMCC_MRA_DATALENGTH_32_BITS;
+		break;
+	default:
+		dev_err(dev->dev, "unsupported size/endianness for audio samples\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * If we are already running, the wanted setup must be
+	 * the same with the one that's currently ongoing
+	 */
+	if (mchp_i2s_mcc_is_running(dev)) {
+		u32 mra_cur;
+		u32 mrb_cur;
+
+		regmap_read(dev->regmap, MCHP_I2SMCC_MRA, &mra_cur);
+		regmap_read(dev->regmap, MCHP_I2SMCC_MRB, &mrb_cur);
+		if (mra !=3D mra_cur || mrb !=3D mrb_cur)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	/* Save the number of channels to know what interrupts to enable */
+	dev->channels =3D channels;
+
+	if (set_divs) {
+		bclk_rate =3D frame_length * params_rate(params);
+		ret =3D mchp_i2s_mcc_config_divs(dev, bclk_rate, &mra);
+		if (ret) {
+			dev_err(dev->dev, "unable to configure the divisors: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	ret =3D regmap_write(dev->regmap, MCHP_I2SMCC_MRA, mra);
+	if (ret < 0)
+		return ret;
+	return regmap_write(dev->regmap, MCHP_I2SMCC_MRB, mrb);
+}
+
+static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+	bool is_playback =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)=
;
+	long err;
+
+	if (is_playback) {
+		err =3D wait_event_interruptible_timeout(dev->wq_txrdy,
+						       dev->tx_rdy,
+						       msecs_to_jiffies(500));
+	} else {
+		err =3D wait_event_interruptible_timeout(dev->wq_rxrdy,
+						       dev->rx_rdy,
+						       msecs_to_jiffies(500));
+	}
+
+	if (err =3D=3D 0) {
+		u32 idra;
+
+		dev_warn_once(dev->dev, "Timeout waiting for %s\n",
+			      is_playback ? "Tx ready" : "Rx ready");
+		if (is_playback)
+			idra =3D MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels);
+		else
+			idra =3D MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels);
+		regmap_write(dev->regmap, MCHP_I2SMCC_IDRA, idra);
+	}
+
+	if (!mchp_i2s_mcc_is_running(dev)) {
+		regmap_write(dev->regmap, MCHP_I2SMCC_CR, MCHP_I2SMCC_CR_CKDIS);
+
+		if (dev->gclk_running) {
+			clk_disable_unprepare(dev->gclk);
+			dev->gclk_running =3D 0;
+		}
+	}
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_trigger(struct snd_pcm_substream *substream, int c=
md,
+				struct snd_soc_dai *dai)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+	bool is_playback =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)=
;
+	u32 cr =3D 0;
+	u32 iera =3D 0;
+	u32 sr;
+	int err;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (is_playback)
+			cr =3D MCHP_I2SMCC_CR_TXEN | MCHP_I2SMCC_CR_CKEN;
+		else
+			cr =3D MCHP_I2SMCC_CR_RXEN | MCHP_I2SMCC_CR_CKEN;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		regmap_read(dev->regmap, MCHP_I2SMCC_SR, &sr);
+		if (is_playback && (sr & MCHP_I2SMCC_SR_TXEN)) {
+			cr =3D MCHP_I2SMCC_CR_TXDIS;
+			dev->tx_rdy =3D 0;
+			/*
+			 * Enable Tx Ready interrupts on all channels
+			 * to assure all data is sent
+			 */
+			iera =3D MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels);
+		} else if (!is_playback && (sr & MCHP_I2SMCC_SR_RXEN)) {
+			cr =3D MCHP_I2SMCC_CR_RXDIS;
+			dev->rx_rdy =3D 0;
+			/*
+			 * Enable Rx Ready interrupts on all channels
+			 * to assure all data is received
+			 */
+			iera =3D MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels);
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if ((cr & MCHP_I2SMCC_CR_CKEN) && dev->gclk_use &&
+	    !dev->gclk_running) {
+		err =3D clk_enable(dev->gclk);
+		if (err) {
+			dev_err_once(dev->dev, "failed to enable GCLK: %d\n",
+				     err);
+		} else {
+			dev->gclk_running =3D 1;
+		}
+	}
+
+	regmap_write(dev->regmap, MCHP_I2SMCC_IERA, iera);
+	regmap_write(dev->regmap, MCHP_I2SMCC_CR, cr);
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+
+	/* Software reset the IP if it's not running */
+	if (!mchp_i2s_mcc_is_running(dev)) {
+		return regmap_write(dev->regmap, MCHP_I2SMCC_CR,
+				    MCHP_I2SMCC_CR_SWRST);
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mchp_i2s_mcc_dai_ops =3D {
+	.set_sysclk	=3D mchp_i2s_mcc_set_sysclk,
+	.set_bclk_ratio =3D mchp_i2s_mcc_set_bclk_ratio,
+	.startup	=3D mchp_i2s_mcc_startup,
+	.trigger	=3D mchp_i2s_mcc_trigger,
+	.hw_params	=3D mchp_i2s_mcc_hw_params,
+	.hw_free	=3D mchp_i2s_mcc_hw_free,
+	.set_fmt	=3D mchp_i2s_mcc_set_dai_fmt,
+	.set_tdm_slot	=3D mchp_i2s_mcc_set_dai_tdm_slot,
+};
+
+static int mchp_i2s_mcc_dai_probe(struct snd_soc_dai *dai)
+{
+	struct mchp_i2s_mcc_dev *dev =3D snd_soc_dai_get_drvdata(dai);
+
+	init_waitqueue_head(&dev->wq_txrdy);
+	init_waitqueue_head(&dev->wq_rxrdy);
+
+	snd_soc_dai_init_dma_data(dai, &dev->playback, &dev->capture);
+
+	return 0;
+}
+
+#define MCHP_I2SMCC_RATES              SNDRV_PCM_RATE_8000_192000
+
+#define MCHP_I2SMCC_FORMATS	(SNDRV_PCM_FMTBIT_S8 |          \
+				 SNDRV_PCM_FMTBIT_S16_LE |      \
+				 SNDRV_PCM_FMTBIT_S18_3LE |     \
+				 SNDRV_PCM_FMTBIT_S20_3LE |     \
+				 SNDRV_PCM_FMTBIT_S24_3LE |     \
+				 SNDRV_PCM_FMTBIT_S24_LE |      \
+				 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mchp_i2s_mcc_dai =3D {
+	.probe	=3D mchp_i2s_mcc_dai_probe,
+	.playback =3D {
+		.stream_name =3D "I2SMCC-Playback",
+		.channels_min =3D 1,
+		.channels_max =3D 8,
+		.rates =3D MCHP_I2SMCC_RATES,
+		.formats =3D MCHP_I2SMCC_FORMATS,
+	},
+	.capture =3D {
+		.stream_name =3D "I2SMCC-Capture",
+		.channels_min =3D 1,
+		.channels_max =3D 8,
+		.rates =3D MCHP_I2SMCC_RATES,
+		.formats =3D MCHP_I2SMCC_FORMATS,
+	},
+	.ops =3D &mchp_i2s_mcc_dai_ops,
+	.symmetric_rates =3D 1,
+	.symmetric_samplebits =3D 1,
+	.symmetric_channels =3D 1,
+};
+
+static const struct snd_soc_component_driver mchp_i2s_mcc_component =3D {
+	.name	=3D "mchp-i2s-mcc",
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id mchp_i2s_mcc_dt_ids[] =3D {
+	{
+		.compatible =3D "microchip,sam9x60-i2smcc",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mchp_i2s_mcc_dt_ids);
+#endif
+
+static int mchp_i2s_mcc_probe(struct platform_device *pdev)
+{
+	struct mchp_i2s_mcc_dev *dev;
+	struct resource *mem;
+	struct regmap *regmap;
+	void __iomem *base;
+	u32 version;
+	int irq;
+	int err;
+
+	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base =3D devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
+				       &mchp_i2s_mcc_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	err =3D devm_request_irq(&pdev->dev, irq, mchp_i2s_mcc_interrupt, 0,
+			       dev_name(&pdev->dev), dev);
+	if (err)
+		return err;
+
+	dev->pclk =3D devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(dev->pclk)) {
+		err =3D PTR_ERR(dev->pclk);
+		dev_err(&pdev->dev,
+			"failed to get the peripheral clock: %d\n", err);
+		return err;
+	}
+
+	/* Get the optional generated clock */
+	dev->gclk =3D devm_clk_get(&pdev->dev, "gclk");
+	if (IS_ERR(dev->gclk)) {
+		if (PTR_ERR(dev->gclk) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_warn(&pdev->dev,
+			 "generated clock not found: %d\n", err);
+		dev->gclk =3D NULL;
+	}
+
+	dev->dev =3D &pdev->dev;
+	dev->regmap =3D regmap;
+	platform_set_drvdata(pdev, dev);
+
+	err =3D clk_prepare_enable(dev->pclk);
+	if (err) {
+		dev_err(&pdev->dev,
+			"failed to enable the peripheral clock: %d\n", err);
+		return err;
+	}
+
+	err =3D devm_snd_soc_register_component(&pdev->dev,
+					      &mchp_i2s_mcc_component,
+					      &mchp_i2s_mcc_dai, 1);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register DAI: %d\n", err);
+		clk_disable_unprepare(dev->pclk);
+		return err;
+	}
+
+	dev->playback.addr	=3D (dma_addr_t)mem->start + MCHP_I2SMCC_THR;
+	dev->capture.addr	=3D (dma_addr_t)mem->start + MCHP_I2SMCC_RHR;
+
+	err =3D devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register PCM: %d\n", err);
+		clk_disable_unprepare(dev->pclk);
+		return err;
+	}
+
+	/* Get IP version. */
+	regmap_read(dev->regmap, MCHP_I2SMCC_VERSION, &version);
+	dev_info(&pdev->dev, "hw version: %#lx\n",
+		 version & MCHP_I2SMCC_VERSION_MASK);
+
+	return 0;
+}
+
+static int mchp_i2s_mcc_remove(struct platform_device *pdev)
+{
+	struct mchp_i2s_mcc_dev *dev =3D platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(dev->pclk);
+
+	return 0;
+}
+
+static struct platform_driver mchp_i2s_mcc_driver =3D {
+	.driver		=3D {
+		.name	=3D "mchp_i2s_mcc",
+		.of_match_table	=3D of_match_ptr(mchp_i2s_mcc_dt_ids),
+	},
+	.probe		=3D mchp_i2s_mcc_probe,
+	.remove		=3D mchp_i2s_mcc_remove,
+};
+module_platform_driver(mchp_i2s_mcc_driver);
+
+MODULE_DESCRIPTION("Microchip I2S Multi-Channel Controller driver");
+MODULE_AUTHOR("Codrin Ciubotariu <codrin.ciubotariu@microchip.com>");
+MODULE_LICENSE("GPL v2");
--=20
2.17.1

