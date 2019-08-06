Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89230C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A33B20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="NKFsaelW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbfHFHiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:38:11 -0400
Received: from mail-eopbgr130109.outbound.protection.outlook.com ([40.107.13.109]:54401
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731835AbfHFHiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO/GKNwKLGaq2Tc5YColdrJL5cIvUwW6OHfP66s3t7RZ03n9EUhb0EatYIEVH/xkW27f4nwhwlkZJ4m8qsF4142HpGu7q0tb+yvnxFWKGlzrBWY5/ac/uHgsgBsJmOSwIZvcwhiJ8hkcqZ6OriRZTdQQqbYbP0oKGjscY0QAE8/ZU2WTwvKJRcltPCop4SWnOceIykaapN8/GID9O869vNmD1e/0FEmHaohHLvkLb1//crg6Y0ZAQSMftJ8Q2UNS9KG/JPT/e7XNaoOtYPKjw3vdIWQBFWmmeOMjlCX/mVLwaezBJnmLFNq+iimQYZ/RMT0Jrb0ZrpFlmX2emHafiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVG6jRdGloEWGWf9UfPmD0nNUjLgLDK2NqHSbsimFoU=;
 b=iG2XUglC/LU/9IkxTLg/CGNPPSTmC64yBMTi3AEaszHh2RIb7g4NgG7zgA+Jsp6hoFbCtFnqXVLibJSB9NiAsAn2isVxRYeyzSplJyrPRNtU2TPooYFu0nnqyY0MaRUkHZVUZuyEnMxf8cXQqhaqaWVn9LA3cY023WqDw8kANDf/7yJbaQjYsDbjM/xZUR72WRGGesF/Hrvm5hbPNNQCzYMHNRaWbXKanDbQqqn8aFo2up98EUlCW62x6WIMHB26/vPg/CtpHiR06/4DC0gvZsXYT8OZLlxozCqoIikPXmIo1RPsFOn7ks6emDSorvuzqe2gtAFWImD7cLMqwXzszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVG6jRdGloEWGWf9UfPmD0nNUjLgLDK2NqHSbsimFoU=;
 b=NKFsaelWV77cgX89VsSGGKT7aGLNUw2Mahrc0lNMPkaYwigTU2CEnJ/f/ICjTAhm5FWKJEhc3/rplWMYLHpq4I3Kud2bJvZ2yOy8lw4Mu14VPVQYOx/9Wuteww7cUgGxH4tEDlCIwbeccax8XvsT/hGpOTyAfh6SfIqyh2D+qqw=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3477.eurprd02.prod.outlook.com (52.133.8.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 07:38:00 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 07:38:00 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] habanalabs: improve security in Debug IOCTL
Thread-Topic: [PATCH 2/2] habanalabs: improve security in Debug IOCTL
Thread-Index: AQHVTCnfX8Wc0Y6qMkqvZE5sJXIMMg==
Date:   Tue, 6 Aug 2019 07:37:59 +0000
Message-ID: <20190806073743.31575-2-oshpigelman@habana.ai>
References: <20190806073743.31575-1-oshpigelman@habana.ai>
In-Reply-To: <20190806073743.31575-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR1PR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::45) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a090929-b239-4377-a4a9-08d71a41018a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3477;
x-ms-traffictypediagnostic: AM6PR0202MB3477:
x-microsoft-antispam-prvs: <AM6PR0202MB347709B1B410305D4F5BF5DCB8D50@AM6PR0202MB3477.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(346002)(396003)(366004)(376002)(189003)(199004)(52116002)(15650500001)(316002)(81166006)(7736002)(478600001)(6486002)(14454004)(2501003)(50226002)(76176011)(4326008)(3846002)(6116002)(6436002)(68736007)(25786009)(6512007)(1361003)(11346002)(476003)(6916009)(26005)(66556008)(2616005)(66446008)(446003)(66946007)(64756008)(8676002)(2906002)(81156014)(8936002)(102836004)(486006)(66476007)(186003)(53936002)(5660300002)(6506007)(386003)(36756003)(86362001)(66066001)(14444005)(256004)(71200400001)(71190400001)(1076003)(305945005)(5640700003)(99286004)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3477;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3tBEjcDe9fKSTdXteYt9MgY0wp5dnwEZue8tlwD/iSCwCLOLMdtCYhjL9oXXo3wJRBQqIk70Qsh8iagUl66w9BFhXs4wtSHadVTAfBxaaU2hBPBvEo/zbvIPJGd0DIrAst1TpQL8iCcSMBhw3gM/63V9bXcXcE7XjZ2V03gmVOW1RDn/Pldjpzdrur4GB2QiH0mA95BFTAOtTrbQZtSN50P3bPE1k72DBAAy/zZG4J8nf8BwBzw4bRhVWFWDLChuNh6xrYYM10ifygsoK4Yqjo7/JagHQxDjblvTpIB9Z6ouBR0N6hhxo5sxfW1eGZZ0Btwp/Lyya51ch9Q6BtHkStV/h3Nuqeh9iKe3wGg+bTfY2ZpKl0mSN4qjUMjTDc7qpt4Eu51RH4SZxSNAN8feXeU6hCCMk5yfZNeK+PIq0yc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a090929-b239-4377-a4a9-08d71a41018a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 07:38:00.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oshpigelman@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the security in the Debug IOCTL.
It adds checks that:
- The register index value is in the allowed range for all opcodes.
- The event types number is in the allowed range in SPMU enable.
- The events number is in the allowed range in SPMU disable.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/goya/goya_coresight.c | 72 ++++++++++++++++---
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/h=
abanalabs/goya/goya_coresight.c
index d7ec7ad84cc6..4f7ffc137ab7 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -15,6 +15,12 @@
=20
 #define GOYA_PLDM_CORESIGHT_TIMEOUT_USEC	(CORESIGHT_TIMEOUT_USEC * 100)
=20
+#define SPMU_SECTION_SIZE		DMA_CH_0_CS_SPMU_MAX_OFFSET
+#define SPMU_EVENT_TYPES_OFFSET		0x400
+#define SPMU_MAX_EVENT_TYPES		((SPMU_SECTION_SIZE - \
+						SPMU_EVENT_TYPES_OFFSET) / 4)
+#define SPMU_MAX_EVENTS			(SPMU_SECTION_SIZE / 4)
+
 static u64 debug_stm_regs[GOYA_STM_LAST + 1] =3D {
 	[GOYA_STM_CPU]		=3D mmCPU_STM_BASE,
 	[GOYA_STM_DMA_CH_0_CS]	=3D mmDMA_CH_0_CS_STM_BASE,
@@ -226,9 +232,16 @@ static int goya_config_stm(struct hl_device *hdev,
 		struct hl_debug_params *params)
 {
 	struct hl_debug_params_stm *input;
-	u64 base_reg =3D debug_stm_regs[params->reg_idx] - CFG_BASE;
+	u64 base_reg;
 	int rc;
=20
+	if (params->reg_idx >=3D ARRAY_SIZE(debug_stm_regs)) {
+		dev_err(hdev->dev, "Invalid register index in STM\n");
+		return -EINVAL;
+	}
+
+	base_reg =3D debug_stm_regs[params->reg_idx] - CFG_BASE;
+
 	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
=20
 	if (params->enable) {
@@ -288,10 +301,17 @@ static int goya_config_etf(struct hl_device *hdev,
 		struct hl_debug_params *params)
 {
 	struct hl_debug_params_etf *input;
-	u64 base_reg =3D debug_etf_regs[params->reg_idx] - CFG_BASE;
+	u64 base_reg;
 	u32 val;
 	int rc;
=20
+	if (params->reg_idx >=3D ARRAY_SIZE(debug_etf_regs)) {
+		dev_err(hdev->dev, "Invalid register index in ETF\n");
+		return -EINVAL;
+	}
+
+	base_reg =3D debug_etf_regs[params->reg_idx] - CFG_BASE;
+
 	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
=20
 	val =3D RREG32(base_reg + 0x304);
@@ -445,11 +465,18 @@ static int goya_config_etr(struct hl_device *hdev,
 static int goya_config_funnel(struct hl_device *hdev,
 		struct hl_debug_params *params)
 {
-	WREG32(debug_funnel_regs[params->reg_idx] - CFG_BASE + 0xFB0,
-			CORESIGHT_UNLOCK);
+	u64 base_reg;
+
+	if (params->reg_idx >=3D ARRAY_SIZE(debug_funnel_regs)) {
+		dev_err(hdev->dev, "Invalid register index in FUNNEL\n");
+		return -EINVAL;
+	}
=20
-	WREG32(debug_funnel_regs[params->reg_idx] - CFG_BASE,
-			params->enable ? 0x33F : 0);
+	base_reg =3D debug_funnel_regs[params->reg_idx] - CFG_BASE;
+
+	WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
+
+	WREG32(base_reg, params->enable ? 0x33F : 0);
=20
 	return 0;
 }
@@ -458,9 +485,16 @@ static int goya_config_bmon(struct hl_device *hdev,
 		struct hl_debug_params *params)
 {
 	struct hl_debug_params_bmon *input;
-	u64 base_reg =3D debug_bmon_regs[params->reg_idx] - CFG_BASE;
+	u64 base_reg;
 	u32 pcie_base =3D 0;
=20
+	if (params->reg_idx >=3D ARRAY_SIZE(debug_bmon_regs)) {
+		dev_err(hdev->dev, "Invalid register index in BMON\n");
+		return -EINVAL;
+	}
+
+	base_reg =3D debug_bmon_regs[params->reg_idx] - CFG_BASE;
+
 	WREG32(base_reg + 0x104, 1);
=20
 	if (params->enable) {
@@ -522,7 +556,7 @@ static int goya_config_bmon(struct hl_device *hdev,
 static int goya_config_spmu(struct hl_device *hdev,
 		struct hl_debug_params *params)
 {
-	u64 base_reg =3D debug_spmu_regs[params->reg_idx] - CFG_BASE;
+	u64 base_reg;
 	struct hl_debug_params_spmu *input =3D params->input;
 	u64 *output;
 	u32 output_arr_len;
@@ -531,6 +565,13 @@ static int goya_config_spmu(struct hl_device *hdev,
 	u32 cycle_cnt_idx;
 	int i;
=20
+	if (params->reg_idx >=3D ARRAY_SIZE(debug_spmu_regs)) {
+		dev_err(hdev->dev, "Invalid register index in SPMU\n");
+		return -EINVAL;
+	}
+
+	base_reg =3D debug_spmu_regs[params->reg_idx] - CFG_BASE;
+
 	if (params->enable) {
 		input =3D params->input;
=20
@@ -543,11 +584,18 @@ static int goya_config_spmu(struct hl_device *hdev,
 			return -EINVAL;
 		}
=20
+		if (input->event_types_num > SPMU_MAX_EVENT_TYPES) {
+			dev_err(hdev->dev,
+				"too many event types values for SPMU enable\n");
+			return -EINVAL;
+		}
+
 		WREG32(base_reg + 0xE04, 0x41013046);
 		WREG32(base_reg + 0xE04, 0x41013040);
=20
 		for (i =3D 0 ; i < input->event_types_num ; i++)
-			WREG32(base_reg + 0x400 + i * 4, input->event_types[i]);
+			WREG32(base_reg + SPMU_EVENT_TYPES_OFFSET + i * 4,
+				input->event_types[i]);
=20
 		WREG32(base_reg + 0xE04, 0x41013041);
 		WREG32(base_reg + 0xC00, 0x8000003F);
@@ -567,6 +615,12 @@ static int goya_config_spmu(struct hl_device *hdev,
 			return -EINVAL;
 		}
=20
+		if (events_num > SPMU_MAX_EVENTS) {
+			dev_err(hdev->dev,
+				"too many events values for SPMU disable\n");
+			return -EINVAL;
+		}
+
 		WREG32(base_reg + 0xE04, 0x41013040);
=20
 		for (i =3D 0 ; i < events_num ; i++)
--=20
2.17.1

