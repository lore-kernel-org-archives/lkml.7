Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26B820898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kiplqxM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKULr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:47:59 -0500
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:14208
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbfKULr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:47:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYD3IBJ/6S3L7DJ0p7VFKOqQQyS9BvUcmg9Isfy5yfE4jnI7z0JwarrB5Li3cNJRMVq5hEzksRnn7qhJRxCu5Oky0FcIm1lCm0Te/zdv1aRpDPt9u8ogF2au9pOpzvnO2WIdy3FoU2vV94IIbCFZ/PwGdjIiAyt//M1ArES6SD8DQEdMa97YCKFkLb95bRk85TUK7LR/EwgzJU+P1e2OyVJazE6r8dSlKgUBvsz/bdZlgXPaUcmyf0v30A3I6FXowYMhchJSu3w3xjLkTEVEVqGMolH8p9QUkPvWO0vxvfCU+aZErH4AcNiEznOatyrHzCrFEo/WQrLWprltD7dheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXAvRQ+AVPnWXVhDq0aWH8Wt/V7M1Kh1Cy2rd2jnZYs=;
 b=RWQx/ty6zN1N7EFJAEGLvSkyRMsKPlIPznhA+rTbN73uJ+7zT3yLQBJK22D/obGRHfsV53vvBSGqxkDa7U4yoXQfqRuTw6G/mPdwalh7hUEmVszpHXoWYgofZ0VvxK6m3zN/1UVJ3KYM6HDQ7FW1Udld26Y23TNkK4LpLx35VkcSKz0gvIcpkIH3EJn4HQKlZ4V/qCGUGty7FxnambKCZJ8dKvMi6UEcAKBD67dw2NZA0opUQUB4fFbfyV76NpIC3Xo2SBswNico9OIdV8V4pSY48abal6jFCnrRcBp1ATMwkssGnQeJmmFCvGULpZ/A0LQPiwDpDCGxyVAWkzNueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXAvRQ+AVPnWXVhDq0aWH8Wt/V7M1Kh1Cy2rd2jnZYs=;
 b=kiplqxM4yWVrYHpxpPG9Jk2taGfztOmoZWEB+qIZWHA07AeGMePLHgw5LBTtoqPimTEj8yP6pT+TLgm7gLX2/T6UoipoKT01yyz9ut6KETI9VhpfSSuh2F4faaLRcqffD3jV8qYbuSZ4NTCvbUqUKIJPHsZoy6o29JCMz0YWCDM=
Received: from SN1PR12CA0052.namprd12.prod.outlook.com (2603:10b6:802:20::23)
 by MWHPR12MB1678.namprd12.prod.outlook.com (2603:10b6:301:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Thu, 21 Nov
 2019 11:47:56 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by SN1PR12CA0052.outlook.office365.com
 (2603:10b6:802:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.17 via Frontend
 Transport; Thu, 21 Nov 2019 11:47:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 21 Nov 2019 11:47:55 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 Nov
 2019 05:47:44 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 21 Nov 2019 05:47:40 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>, <Akshu.Agrawal@amd.com>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v11 4/6] ASoC: amd: add ACP3x TDM mode support
Date:   Thu, 21 Nov 2019 17:15:59 +0530
Message-ID: <1574336761-16717-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574336761-16717-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574336761-16717-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(199004)(189003)(16586007)(54906003)(316002)(8676002)(8936002)(50226002)(81156014)(81166006)(47776003)(356004)(6666004)(2906002)(1671002)(53416004)(109986005)(4326008)(50466002)(48376002)(336012)(36756003)(2616005)(5660300002)(26005)(86362001)(186003)(11346002)(446003)(426003)(76176011)(51416003)(70206006)(305945005)(70586007)(478600001)(7696005)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1678;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd36416e-1fde-41d4-b48f-08d76e78a629
X-MS-TrafficTypeDiagnostic: MWHPR12MB1678:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16784CC30546387EF9449871E74E0@MWHPR12MB1678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0228DDDDD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+dM2b4hIMIAaf3wEmTCjvSjHz+b7QPMbbUcxcawAD68k49hamQfYjTg+sAhzFYv8/f60Rfl3wgN4xn3uQAGefJEO8kdeeg5QRr/xXYdxRYwBk1DZrHizGYH/ply19yUmiu/FfU4i9SA5N2eSw1UznWFSwFb2NJBbLUo5O/lbzGsr3rRhhNDmi0QtVSWLrfqecT0c3uANHTUTxhqxH4Bodj7sNdGz+a05MxsMh8zCo2ttLWkS9QrIqbMeASw2sQVK1pz8vfcujfcnEoGoOsIDmHqji4DrvXAmjYtf4mnJ6Qw/Y+WfeQikAgHnm06HDi0/wZuMA6lw3LRMfNh3GfC9sPoLGxW2cqwoKTIw1thUSNYGi2cyc/ETeyzkiFnjylZWZcyAFsAi7ald1asKHhxlctjy9YAjRrz/p3eP6witHP47r85pIBD09kyYQh6316X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 11:47:55.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd36416e-1fde-41d4-b48f-08d76e78a629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1678
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 24 ++++++++++++++++++++----
 sound/soc/amd/raven/acp3x.h     |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 246eac4..9a6f0269 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -70,11 +70,27 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 
 	frm_len = FRM_LEN | (slots << 15) | (slot_len << 18);
 	if (adata->substream_type == SNDRV_PCM_STREAM_PLAYBACK) {
-		reg_val = mmACP_BTTDM_ITER;
-		frmt_val = mmACP_BTTDM_TXFRMT;
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			reg_val = mmACP_BTTDM_ITER;
+			frmt_reg = mmACP_BTTDM_TXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = mmACP_I2STDM_ITER;
+			frmt_reg = mmACP_I2STDM_TXFRMT;
+		}
 	} else {
-		reg_val = mmACP_BTTDM_IRER;
-		frmt_val = mmACP_BTTDM_RXFRMT;
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			reg_val = mmACP_BTTDM_IRER;
+			frmt_reg = mmACP_BTTDM_RXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = mmACP_I2STDM_IRER;
+			frmt_reg = mmACP_I2STDM_RXFRMT;
+		}
 	}
 	val = rv_readl(adata->acp3x_base + reg_val);
 	rv_writel(val | 0x2, adata->acp3x_base + reg_val);
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index a82d2c5..bf0a683 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -75,6 +75,7 @@ struct acp3x_platform_info {
 struct i2s_dev_data {
 	bool tdm_mode;
 	unsigned int i2s_irq;
+	u16 i2s_instance;
 	u32 tdm_fmt;
 	u32 substream_type;
 	void __iomem *acp3x_base;
-- 
2.7.4

