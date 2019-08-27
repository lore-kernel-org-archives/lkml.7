Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF25C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8052186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="dYpZIM3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfH0QOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:14:24 -0400
Received: from mail-eopbgr150125.outbound.protection.outlook.com ([40.107.15.125]:22699
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfH0QOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2HfTjcN+NivObkw6zyBU3FWMHb2qTT1MUqgiIGcm4IWXLFzyGKTI8h/b27aaVVfY06RbFutoIlu3/1vjhz+k6i21KIDP25mx8bT5sUxMzR0UIyx7+e1DwbCHFogSjXNgAYugMi5wVZGhZ7z2S/d4l+2S1q1AMOZFlHNiu5VEzoTEBTs6/lkHx0CO6P4cCWxkT1BP01c3D+WViwWwGTqax6Eu+j5ZPoAT5tYQhTmk7Pmw3ouqIZM2+fTWhQVXOpoubEyZ7VqxaQ+QAABoiSa8j9zJ8wnsiogzTs+mP65MTrQJlhOr4ZjdFkEsLQ1SHQznQx2gPxoiOubHcQLrIy4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIHm18JBiV3qp4WsVuZV/UpKYJn2b4F8nGbmdGL3pQc=;
 b=BjliTYoQfrz0J5FXhikT61QuD0WDGF5J4JPpM8zCJ3JkpxRBF1RZEudhfwSa9gwoBTGa5u5UuKyggyi2NDWN2Rut/RJyAIV5UeSJ1l9BPc3fACkUAO0toeO/ysIBkNh/sZQFZDxBCJdRckwDqhspSXgyyy6fHqkQXVeKIR6wVJgE7odBiRUipQy6tLo4q3+NTbFqs1Sc/o3xD7IHVZDqSwPTc+gfYPZuQ4LYbwN/sEy/fG8mTcIWpbNPmpnisMnO6S6XJ1lEm9H5AmoHlxxbN9llTjpVzZQS+YSnsCxjrHOqqwZ40A2F59bh9bTB0x22S0pWvrkh9xSntmg4RQkN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIHm18JBiV3qp4WsVuZV/UpKYJn2b4F8nGbmdGL3pQc=;
 b=dYpZIM3W7k4ehrxrzQXXrgRtzMMzGzX83NOWw76PS9rhLrAJtxko3oSiv17eF3sPDAXw08PR8t9jMBfiuLej+/hvY/gq6tbOpaLQ9YFimUgXKg8Ze80ZAFPz1XVpBJlBB+gR4O4Q0rMOtf1om5r9V90mtZ21bQt3nV5RkKhm8+o=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB4912.eurprd02.prod.outlook.com (20.177.203.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 16:14:18 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::7515:8be7:5f4:7392]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::7515:8be7:5f4:7392%7]) with mapi id 15.20.2178.023; Tue, 27 Aug 2019
 16:14:18 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Make the Coresight timestamp perpetual
Thread-Topic: [PATCH] habanalabs: Make the Coresight timestamp perpetual
Thread-Index: AQHVXPJ6iBAPNBt+WU+188tjs82NjQ==
Date:   Tue, 27 Aug 2019 16:14:18 +0000
Message-ID: <20190827161408.20082-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::26) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca062517-0b62-40fe-cb05-08d72b099cac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB4912;
x-ms-traffictypediagnostic: VI1PR02MB4912:
x-microsoft-antispam-prvs: <VI1PR02MB4912496C57BE8DC5BDFBF0D8D2A00@VI1PR02MB4912.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39840400004)(189003)(199004)(5640700003)(6916009)(53936002)(14454004)(6486002)(6436002)(26005)(478600001)(14444005)(256004)(5660300002)(71200400001)(71190400001)(486006)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(66066001)(86362001)(386003)(6506007)(1076003)(2351001)(102836004)(36756003)(476003)(2616005)(52116002)(1361003)(7736002)(4326008)(81156014)(25786009)(8676002)(6512007)(81166006)(99286004)(8936002)(305945005)(3846002)(316002)(6116002)(50226002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4912;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zw8PNtASpEf9WUvUOGLZCw0O6LOhROD9kBrbadfMjm2aOr4nLgkydwdOfYJgIQO8A7Imn823O2mF/wqGPX34c2lRD5H2bwZoRS18FmP3e0EHb9ai8pCzy1EpXVDVUPXs7hnw3UPN8uCe3B3TwagPkJUyB6L8xqUFL2z38Nxm3LdK+ool4Q4DY4MD+4/DTXAY6UcnZOdNLcUBkVq7l+YYMJNaDWgBGQtmF3oIfeUYM5tkXH5ozyGS6sremdY8rO2yWiWerHdDE5EOt76r4tvhimsX9a0yKf1aQQSSSNTaj9iUOt6YAcFXpYNmaepfygzWST4/tQbkQIU/wo6xjkUexgMCRIw39uLFcBanFG3agauGVeaKD/bfG/8xd7fgjSp1LMvg6slSBC+WGEs4SnmKcJ7+YHVWe1jz14laKq78PI0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: ca062517-0b62-40fe-cb05-08d72b099cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 16:14:18.1193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KR+Qkwa2bc3njabwbV+Bhf9KrP4YPfhtvYdZ62zwuoBaj9fAWUOTRtzujpAH0ymJx/Swc+6uAPKPYG+HofnAEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Coresight timestamp is enabled for a specific debug session using
the HL_DEBUG_OP_TIMESTAMP opcode of the debug IOCTL.
In order to have a perpetual timestamp that would be comparable between
various debug sessions, this patch moves the timestamp enablement to be
part of the HW initialization.
The HL_DEBUG_OP_TIMESTAMP opcode turns to be deprecated and shouldn't be
used.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c           | 23 +++++++++++++++++++
 drivers/misc/habanalabs/goya/goya_coresight.c | 17 ++------------
 include/uapi/misc/habanalabs.h                |  2 +-
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index de275cb3bb98..0dd0b4429fee 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2062,6 +2062,25 @@ static void goya_disable_msix(struct hl_device *hdev=
)
 	goya->hw_cap_initialized &=3D ~HW_CAP_MSIX;
 }
=20
+static void goya_enable_timestamp(struct hl_device *hdev)
+{
+	/* Disable the timestamp counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
+
+	/* Zero the lower/upper parts of the 64-bit counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0xC, 0);
+	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0x8, 0);
+
+	/* Enable the counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 1);
+}
+
+static void goya_disable_timestamp(struct hl_device *hdev)
+{
+	/* Disable the timestamp counter */
+	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
+}
+
 static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
 {
 	u32 wait_timeout_ms, cpu_timeout_ms;
@@ -2102,6 +2121,8 @@ static void goya_halt_engines(struct hl_device *hdev,=
 bool hard_reset)
 	goya_disable_external_queues(hdev);
 	goya_disable_internal_queues(hdev);
=20
+	goya_disable_timestamp(hdev);
+
 	if (hard_reset) {
 		goya_disable_msix(hdev);
 		goya_mmu_remove_device_cpu_mappings(hdev);
@@ -2504,6 +2525,8 @@ static int goya_hw_init(struct hl_device *hdev)
=20
 	goya_init_tpc_qmans(hdev);
=20
+	goya_enable_timestamp(hdev);
+
 	/* MSI-X must be enabled before CPU queues are initialized */
 	rc =3D goya_enable_msix(hdev);
 	if (rc)
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/h=
abanalabs/goya/goya_coresight.c
index 3d77b1c20336..b4d406af1bed 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -636,24 +636,11 @@ static int goya_config_spmu(struct hl_device *hdev,
 	return 0;
 }
=20
-static int goya_config_timestamp(struct hl_device *hdev,
-		struct hl_debug_params *params)
-{
-	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
-	if (params->enable) {
-		WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0xC, 0);
-		WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0x8, 0);
-		WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 1);
-	}
-
-	return 0;
-}
-
 int goya_debug_coresight(struct hl_device *hdev, void *data)
 {
 	struct hl_debug_params *params =3D data;
 	u32 val;
-	int rc;
+	int rc =3D 0;
=20
 	switch (params->op) {
 	case HL_DEBUG_OP_STM:
@@ -675,7 +662,7 @@ int goya_debug_coresight(struct hl_device *hdev, void *=
data)
 		rc =3D goya_config_spmu(hdev, params);
 		break;
 	case HL_DEBUG_OP_TIMESTAMP:
-		rc =3D goya_config_timestamp(hdev, params);
+		/* Do nothing as this opcode is deprecated */
 		break;
=20
 	default:
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.=
h
index 6cf50177cd21..266bf85056d4 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -451,7 +451,7 @@ struct hl_debug_params_spmu {
 #define HL_DEBUG_OP_BMON	4
 /* Opcode for SPMU component */
 #define HL_DEBUG_OP_SPMU	5
-/* Opcode for timestamp */
+/* Opcode for timestamp (deprecated) */
 #define HL_DEBUG_OP_TIMESTAMP	6
 /* Opcode for setting the device into or out of debug mode. The enable
  * variable should be 1 for enabling debug mode and 0 for disabling it
--=20
2.17.1

