Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70084C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C6E217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bCpxT4Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfKFOiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:38:16 -0500
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:35990
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfKFOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:38:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCaZVr/cI66MIzoiHVrd4TnexhFwB4Cxp1QUREt96WwVwh8E667hE9OxFJyqugd+6hHXO/Qruw0rL6ACFAMRWb6tMEcmJr34DuJ79MQWMqAcgLxmJeczWO66m/F6P9yXrzCz266oiisiji+RjYDwgC16bW1uilddHsPTpe/jPhcNloYngu7rXGvoEVZi2z7Jpc29/Uhgf6floBdNyP9cgAfLshfXiu7ecU5H7irFoWKe+QFs0OzF7bZr0Il1JwfoA5sllrlNbeL0GAfa+iGGsZxa2W2blOVFgCyW/rPQy0SuUBH4dHYAxumfArwBVGHQ+AR+cOIyzA7TcviNdYhQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNhOW6eCdp3wgEWBnOmOhrPdPfIzwRaUn8K7hKknOyk=;
 b=HvrnQ84/p4/u9dZCmvFxvjbQwXqU5vetBal0bhqlSNSBsMDxylz0o2e3YCaUIp+5TIAD+Tgp6WxSKOgnZaox2NGUf/PSqiw8bQZUvGWuh2gzDaxevW0ZCcs+XbFoSYJc/DcTvfvLwDW/ZG7KI/cIwiiWKmZXz2uDF9re57yHlIC36H7zi2VTPECx9q3vg19DLBY/UANl4l8hMOUkK83ieJlrTg8ReGhuSzYcFDDNrER8OuUu5gIDSR1ZhOT3XvKWW+wKYC0Lw2GgmOprqdjWNm2K0SUH0dYbQPHehanrjWxOBIjCQRg/trQxqEOF8FavX8RxGWMhmi5ScageImAddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNhOW6eCdp3wgEWBnOmOhrPdPfIzwRaUn8K7hKknOyk=;
 b=bCpxT4IoF8O9ZP/acKChHAhD43mfkV+Q94bojm5XNRztgu5tH/J7owcJwIKdx5AatN0gnmlTn8Unjjh3DKKC5sF1j35TbCgBw8Dmh/O4BCxbGneahqY3FNq9sL5RxC0aJPZMdkzTXim9tl4+MPRvDsmE8o7TVEL3H19KW9jILPU=
Received: from MWHPR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:301:4a::14) by BYAPR12MB3239.namprd12.prod.outlook.com
 (2603:10b6:a03:137::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 6 Nov
 2019 14:38:12 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MWHPR1201CA0004.outlook.office365.com
 (2603:10b6:301:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 14:38:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Wed, 6 Nov 2019 14:38:12 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 08:38:11 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 08:38:01 -0600
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
        Sanju R Mehta <sanju.mehta@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2 4/7] ASoC: amd: add ACP3x TDM mode support
Date:   Thu, 7 Nov 2019 20:06:01 +0530
Message-ID: <1573137364-5592-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(136003)(39860400002)(346002)(376002)(428003)(199004)(189003)(476003)(126002)(305945005)(356004)(486006)(109986005)(5660300002)(4326008)(446003)(26005)(336012)(36756003)(186003)(81156014)(81166006)(426003)(478600001)(53416004)(8676002)(70206006)(8936002)(2616005)(76176011)(51416003)(11346002)(7696005)(50466002)(54906003)(2906002)(70586007)(86362001)(316002)(16586007)(48376002)(1671002)(47776003)(50226002)(266003)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3239;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62abb821-1e9a-4555-9e26-08d762c6f38a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3239:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3239C481319F7DBC7F77662FE7790@BYAPR12MB3239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk8of4U9RF/+qXBz1TF1sxso3KLPVJovKqfyfk0BpV7I+4jZbYa1jQAce/kvwa5GGrjVLVDx49GOXkC0EJ5ojnxRgg2HfiE1rzuwQjxBvNElZ9Lc+e1xZBWa0OacazFbPtw2fYvKdIO7isBZ/7/zumThPIwwya+A57hnxeDG7Jo0IAi8ph3Bz0D9ZbFyOJSsccvJgzdsffHZFmKaUIoE5b7V7bn0kVmyeEQotWVWpbpNJBe9B4QzMDvSdsLyAaozcc5Dtp9/Nu8mdAm2kQFVZZKzkVE/zgD/nv/QIVgrmhKJ9ykEiJtBNRvnrpc99tPZjV9o6tCRs8jhrkO5eUBZUhm1eJIz1xCujpZA0h3dqa7UtoLMikwtxzPj9fOCkL+YhLJhOOqxVFJp8kI+ULJzCs6WLygun26VrTTYNjmiXbBFuyd3b62N7IoiYpCZRBXU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 14:38:12.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62abb821-1e9a-4555-9e26-08d762c6f38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 52 +++++++++++++++++++++++++++++++++--------
 sound/soc/amd/raven/acp3x.h     |  2 ++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 725e71a..04c740d 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -43,7 +43,8 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 		u32 rx_mask, int slots, int slot_width)
 {
 	u32 val = 0;
-	u16 slot_len;
+	u32 mode = 0;
+	u16 slot_len, flen;
 
 	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
 
@@ -64,16 +65,47 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
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

