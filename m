Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790F421925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GVft+9yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfKKOwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:52:12 -0500
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:26816
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726878AbfKKOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTKdSDrUEJQNZIjk4arHRH9AwDWLha1Or4/8vRMAi3Hx0Orxj2yXzS2yqCh1nIrT155FaXZsyJg6Ue/8JUGPshZ0HlsjyZ3u5iwKlQ8DRu5EDQCov1KlX7eQGXwRnXCktZ/fKKGthp6rDeh33IIQ3lU4a/KMM1jIIsCMERa1uQIi2Afyou93cMnwumWGjDNG7Ro5zs2moC2lwevPMnOcWVJrrQgI35vXydHWA1RGHzlATDmnmrzv9H+nU0EhyH2o1fhKF8v114s7Jdav/yNh9wun4gyf6onA/PoRjXGQhmvXztd/+DS5Mg1Wgsf7Jk0TYHRelpgnuPs95Mo9Dv9zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLPIAKLEjVonlAaHkIJsqjB82FIYgfUPiLNRgE+lJ80=;
 b=nJDpNK7vc/mx0Dy1k54XMqimYhLZOTuc1xivWVZoCVfBVJArJBTRiHxSXZT4NX6zzDC2Wb5Ozs7DKfkNu5k5dbmUh8tKSiAYoFZ7kPL/oCwbc0snPsxxVSOrLC8rhSXhCpUtyq7RWNsxJciZnbe8Sr4O2pIAbC8oj1ycq9kSw55mM9Yx73nEWHeUNc3JcHidYWc9l/dryxvnAWAfXX2+r3HGd7b3DOONpCG2NB5n9CZArT3Y9aEGBc6QR07YCo5UI6So9+dw+/iIVDgbs3hBDMulxBaGXjp+OXJdpPnlWGNr2umkDSSVexlSramYpon6NOCqW7GHxGl6muSeqtZKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLPIAKLEjVonlAaHkIJsqjB82FIYgfUPiLNRgE+lJ80=;
 b=GVft+9ykU0h09xj/dLbH0+EVsL8DonOZVaXwTP5W5h789T97nswKYpLLtpwrgMHyQbqSJanNEe47bbmblJop4jhpNHYjQCeBU5XUlCp8n8fnhaCANUICFxxcU4lIN8DvGqJ1jLIVqUeKR110L6UxH5qLFz/n8iuAax04KX1wdbk=
Received: from DM5PR12CA0058.namprd12.prod.outlook.com (2603:10b6:3:103::20)
 by MWHPR12MB1406.namprd12.prod.outlook.com (2603:10b6:300:14::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Mon, 11 Nov
 2019 14:52:06 +0000
Received: from CO1NAM03FT050.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::204) by DM5PR12CA0058.outlook.office365.com
 (2603:10b6:3:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Mon, 11 Nov 2019 14:52:06 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT050.mail.protection.outlook.com (10.152.81.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Mon, 11 Nov 2019 14:52:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 11 Nov
 2019 08:52:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 11 Nov
 2019 08:52:05 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 11 Nov 2019 08:51:56 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <Akshu.Agrawal@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Maruthi Srinivas Bayyavarapu" <Maruthi.Bayyavarapu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v4 4/6] ASoC: amd: add ACP3x TDM mode support
Date:   Mon, 11 Nov 2019 20:19:52 +0530
Message-ID: <1573483794-8921-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573483794-8921-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573483794-8921-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(428003)(189003)(199004)(316002)(11346002)(476003)(47776003)(2616005)(305945005)(426003)(446003)(8676002)(26005)(16586007)(86362001)(5660300002)(336012)(81166006)(36756003)(486006)(81156014)(126002)(6666004)(356004)(50466002)(478600001)(1671002)(76176011)(7696005)(186003)(2906002)(48376002)(51416003)(70206006)(70586007)(109986005)(8936002)(4326008)(54906003)(50226002)(53416004)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1406;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4ca582-a4f8-4364-ffa7-08d766b6b8b0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1406:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1406E612D52AF026A0163EF9E7740@MWHPR12MB1406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0218A015FA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80MSXRCijOJcjG0+S9u8/UR9XbxhAAf2ROUCIJiGE+hk+Wn5S+gWSnhxO6JCySKRELaXPAQrgk4vlHXtpBelzpZCNMDskhJGgJpZprrBXy8d4CCoWVEoX2Un3A8ucboJP3FwlSwj4DcPbQv89PqhCuSJPKrCfUtkfwUp+lzKb9xiQdonQmBAt02m4aNT4ujTbbMqOjdC5uvKAx5B0tPRKqixm4hoRyqu+60QzIOBpkR/0VjK7Iakr+yhPnxKR/0Xg6z0Xkw5NtNR6VwjwDvIyJWBiT+1EaeuPKC7qiX1IpfW0sKqemJg8XlaJOQ4I380/qdVX8YhyT6DP6vYo4xgD9w227rRBisUy+bhp/1Zw3Z0Fn3WtVnbPshYYN7VVi9KRIfRQtT1DafyZ5LzQ3GO+krngL0R1L3D+WzVH8ZUe8z5/YGjICdc99t3v9QNpERy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 14:52:06.3310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4ca582-a4f8-4364-ffa7-08d766b6b8b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1406
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 51 +++++++++++++++++++++++++++++++++--------
 sound/soc/amd/raven/acp3x.h     |  2 ++
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index bd0ec68..f6b306d 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -43,7 +43,7 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 		u32 rx_mask, int slots, int slot_width)
 {
 	u32 val;
-	u16 slot_len;
+	u16 slot_len, flen;
 
 	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
 
@@ -66,16 +66,47 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 		return -EINVAL;
 	}
 
-	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
-	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_ITER);
-	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
-	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_IRER);
+	/* Enable I2S / BT channels TDM and respective
+	 * I2S/BT`s TX/RX Formats frame lengths.
+	 */
+	flen = (FRM_LEN | (slots << 15) | (slot_len << 18));
 
-	val = (FRM_LEN | (slots << 15) | (slot_len << 18));
-	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_TXFRMT);
-	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_RXFRMT);
-
-	adata->tdm_fmt = val;
+	if (adata->substream_type == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
+			rv_writel((val | 0x2),
+				adata->acp3x_base + mmACP_BTTDM_ITER);
+			rv_writel(flen,
+				adata->acp3x_base + mmACP_BTTDM_TXFRMT);
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			val = rv_readl(adata->acp3x_base + mmACP_I2STDM_ITER);
+			rv_writel((val | 0x2),
+				adata->acp3x_base + mmACP_I2STDM_ITER);
+			rv_writel(flen,
+				adata->acp3x_base + mmACP_I2STDM_TXFRMT);
+		}
+	} else {
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
+			rv_writel((val | 0x2),
+				adata->acp3x_base + mmACP_BTTDM_IRER);
+			rv_writel(flen,
+				adata->acp3x_base + mmACP_BTTDM_RXFRMT);
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			val = rv_readl(adata->acp3x_base + mmACP_I2STDM_IRER);
+			rv_writel((val | 0x2),
+				adata->acp3x_base + mmACP_I2STDM_IRER);
+			rv_writel(flen,
+				adata->acp3x_base + mmACP_I2STDM_RXFRMT);
+		}
+	}
+	adata->tdm_fmt = flen;
 	return 0;
 }
 
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index c071477..01b283a 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -76,6 +76,8 @@ struct i2s_dev_data {
 	bool tdm_mode;
 	unsigned int i2s_irq;
 	u32 tdm_fmt;
+	u16 i2s_instance;
+	u32 substream_type;
 	void __iomem *acp3x_base;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
-- 
2.7.4

