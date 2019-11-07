Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D65C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7F92187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N++zfTDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfKGN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:27:05 -0500
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:30128
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388215AbfKGN1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:27:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsucbXRzNnPuQZujzwNRUJk9zmiSFoJQ4r+odeGG2kxIWmoIzg0sG3SDvl4Rxd6RWBknkGFhfA40sNOZlCx/E/+xmC3paGWygmvq8BTfeGLerq4sw67Pe7tQGNEqeSps6/ZQuIIr3YObmfiRbtBGb7Y6Q4eH6kkClWbAvBozpgT/L6Ug/NFRJfVDfTp/VkYMRW59Ws+oFUhAxlu1um0/k1CdppD+qf0n3xKImmMylD9QO/3IJhG9EULQ8sR7MmCG9qUQp2CIOZUJnv/7aqt7MtW0mvH9SlAm5T7cwGuz7Z4rY0YRV8ghcTnb8uFKvIR9c6JrEDlumIWEzQtn09xDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJW4tW8qCFWr8bQpfEGKbKEJw7NGt8EcRH/yHlZdEZc=;
 b=S5NXe3ZWafbmm9tiljCLNW/uQVupsfowx0pY/WeMwCc73yDbTrndrP5zvqjIeyOng8I4ahcewG3CTRJo3KlZJZBrrlr1Ssqs6OUWCFrfmUmJumeepbmEu+Ajz/XjHblLLUyjJyYKUsmG0FQnjYSQLegNzZmPyvuuXieq+GQzGTj/QjkcfugtWGyTCvdXsIoxljVX2nLzCXkHkfLLXz4B2O7Seisl/zTLS8hohKq6lIPSlt2Va/GtKYjCD5YZxpw4B9CkjKJB9w7KjrdyNI/NlgleEuUNN7FNf+paMRMrGO8kYNtj4cRpeWLyFWJ+CXs1lxgQKS/t9jahLblbIhyumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJW4tW8qCFWr8bQpfEGKbKEJw7NGt8EcRH/yHlZdEZc=;
 b=N++zfTDsmdC/+XvkUv43S4xiwkChvrvsLWMCkIimsQYgDEdJss5eNK3O7t0qUq4bRq1GUjmqTlv1JxX6XvH0SQwkmGcg8HKNqVQteJDdGppmteSytU7dKI89OqcfE0PU5YGUQe1GvCIttkxsqb4lOm9jGu2BPvtFQc7GWDROfok=
Received: from BN4PR12CA0005.namprd12.prod.outlook.com (2603:10b6:403:2::15)
 by DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23; Thu, 7 Nov
 2019 13:27:00 +0000
Received: from DM3NAM03FT056.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by BN4PR12CA0005.outlook.office365.com
 (2603:10b6:403:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 13:27:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT056.mail.protection.outlook.com (10.152.83.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 13:27:00 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 07:26:59 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 07:26:55 -0600
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
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 4/6] ASoC: amd: add ACP3x TDM mode support
Date:   Thu, 7 Nov 2019 18:54:51 +0530
Message-ID: <1573133093-28208-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573133093-28208-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573133093-28208-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(428003)(189003)(199004)(54906003)(47776003)(316002)(5660300002)(70586007)(70206006)(426003)(356004)(6666004)(53416004)(26005)(336012)(186003)(51416003)(76176011)(7696005)(16586007)(126002)(476003)(2616005)(11346002)(446003)(486006)(305945005)(478600001)(2906002)(4326008)(8676002)(81166006)(81156014)(50226002)(86362001)(109986005)(36756003)(8936002)(48376002)(50466002)(1671002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4028;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e7184e1-f9e5-438c-381f-08d763862b64
X-MS-TrafficTypeDiagnostic: DM6PR12MB4028:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40287808B91A6748DFBBD835E7780@DM6PR12MB4028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbSM3c2sPHfrD4zy5X832INP0pSKqiqP6TtBrxfLS2qAMm0b0RnTScNfEF9oVR4KSLWT0cmIMWxVKLZIX45Rk+6b/7o4uKINhsaGJgKVuW8Qo89ZlgN4o2KYwr9UVRTSUI50+8DU9JeZhbDBrqFzTcaAzDFyPjH0DM2xOLnjUkC1w0SIeUTQyXM4Mrt7WHTwik5GL1Tmo9AX4Ui3kWuAN3NPmFsW14IwYH+/65azAO6HNq+Snk4VFs2AVsSI6x+Z18ZAmKBFdbwKLn7dOElX6FAejrH5G0veXsRORCwPRw2psUQ7IQVsP6ErxYWMhoi/3bQgOz6UjQFCGtQDzBZCnk8vxb7WoBpSEBdmt/YRg7PNMPsLTqJmQ4l3ojov0R+AY6yiV/+lR+bI3OY5+K1qmhRkE8E28Wg+XCOn6f9IxbDiiRGArP4BgFal0SB9vN8s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 13:27:00.0079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7184e1-f9e5-438c-381f-08d763862b64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4028
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
index 6fdf118..8c0df5f 100644
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

