Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0FFC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7720820882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j9Xjhia7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfL0Mxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:53:54 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:44936
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfL0Mxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:53:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTc6LtlX/K5825MdOxEy/AATHxOEaU91cfZ2Hc9fkzAkv3TQkhDMtVJsbvTH0dxLCzw67IRDyeIOiNyQ+HAc6vFMjT66NapaBt1G4wl5Rxr/OgsIw9I7xc1koat/8J70v/bdXSYhvsxnbgrz1buOYbSDTARN6/TZWo7PE5TxFMxBKDRc5MlUhmXc9NIpzStHSQ/Pbjs3iy59+6+c72iJmbHJEisZUFMmiih/nPSsFqg9n10h++8ngI5JXyCTt8ZiFbkIDHWdMOQVw+EbT+4LbFzjz/LpEJkVryovu2pgru8aLonw5pt3KgpwLZBHPRa6MfX1xDazbbMQUsbcrdBcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mdgek00TsSnoMxIS21IWGmJHkoCuyKMVtdhq/coqliQ=;
 b=eovRetw6cv78k3JyGgqs6qXPjaNYsqyLuKBsXlHn91G2NczGPah71+9tJafH6fehbgYE0VdMCsxbHQ5C8Dfaha9jUWP57aTEBBG0xAh0UUi/K0H2uXDP9i8pwHEiaNWGg4z261BDIoi+pHYJr7ylaC87O6UArXdLkiLpZDyCwARsMv2NpQFotXPHekGdb5PKOKOiyx6cyPKarMAj63n4Un7i7+Ve7Bgg5hyCehWc26K7ixIB/F/GOnKAZrU3fgrDs0KnPWz5tu7k6tAJ4ncx9cbJ35nve/qZ6UDiJOMWdJGgXJTkxOn5K7JQ3hKEOndlwy8L77WBG7dU/5LLXnqpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mdgek00TsSnoMxIS21IWGmJHkoCuyKMVtdhq/coqliQ=;
 b=j9Xjhia7+0jUa7BkGf6QAA7s095NyFV/uzf/kJkKqzhOmzxlfJYZxgpUuM4K4VJv+tDh597CEh6qCKhtnkxb6vhihdCbKDJFT7/epA8/lM7MbIXziu9QoTRFSlyNrO9ugemRNwyLV7T+JwazqIu8jC3hviGQLz316604c2QyHFo=
Received: from CY4PR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:910:16::14) by DM6PR12MB3323.namprd12.prod.outlook.com
 (2603:10b6:5:11f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Fri, 27 Dec
 2019 12:53:11 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by CY4PR1201CA0004.outlook.office365.com
 (2603:10b6:910:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend
 Transport; Fri, 27 Dec 2019 12:53:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 12:53:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 27 Dec
 2019 06:53:10 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 27 Dec
 2019 06:53:10 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 27 Dec 2019 06:53:07 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] ASoC: amd: add ACP3x TDM mode support
Date:   Fri, 27 Dec 2019 18:20:52 +0530
Message-ID: <1577451055-9182-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577451055-9182-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1577451055-9182-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(189003)(199004)(5660300002)(36756003)(478600001)(26005)(2906002)(70206006)(70586007)(86362001)(6666004)(356004)(8936002)(7696005)(2616005)(4326008)(336012)(426003)(8676002)(81166006)(81156014)(316002)(54906003)(109986005)(186003)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3323;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840095a9-3532-4872-d5e6-08d78acbbad7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3323:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3323E167DE1224DE381EBB5DE72A0@DM6PR12MB3323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0264FEA5C3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yB2qeoqhdm2tjnKgFq+L5o/Hn6BX4AdgXE1hZfUsoKQrpun9BEUx3XixvKsMM5/LcOmuolCbQHKGT6fwxwasjhW4eXtFPchF7VP0RnBFBUaHJhX/leGUPHld+/GwQTa5vCY3kLzxivSC/uzdHhzDi5ntnr0ZtZbkOEUQ+LCH1XWnhuYmpynOdqxNHRXZvIBPsOQCg9zXyxI45Y2EW5MMH3+1sJkwQCcxSf7JK9JY5zdTUqNQd7d1uyPEjFq70ZH/Z2PRcIxPTMpFA8/RJwjrgXTOgE25nsv+BF+zRwdmzt/4u8+EMel15kSKKqHJc+RA9lXzPyp7WR7utVmQy9iKQPhe1BAstSrHIL1jAhHpJKQJQKHqVfwI2tDcRFJVCWBoPz9CZ7nfb1CYh1XG63s3xMRYlIctSeLwX9Ca/idGjrdw/Sc0w+dAllYtxONABdFFUh9DXxZSr8sST4pGsF46c7JKoRIMJ/S2wAq+UMuQxG0je1rq7AaGiVIYlIu3f0QU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2019 12:53:11.2313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840095a9-3532-4872-d5e6-08d78acbbad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 28 ++++++++++++++++++++++------
 sound/soc/amd/raven/acp3x.h     |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 7f05782..0856e0c 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -43,7 +43,7 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 		u32 tx_mask, u32 rx_mask, int slots, int slot_width)
 {
 	struct i2s_dev_data *adata;
-	u32 val, reg_val, frmt_val, frm_len;
+	u32 val, reg_val, frmt_reg, frm_len;
 	u16 slot_len;
 
 	adata = snd_soc_dai_get_drvdata(cpu_dai);
@@ -70,15 +70,31 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 
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
-	rv_writel(frm_len, adata->acp3x_base + frmt_val);
+	rv_writel(frm_len, adata->acp3x_base + frmt_reg);
 	adata->tdm_fmt = frm_len;
 	return 0;
 }
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index a1cdc4e..43213ae 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -78,6 +78,7 @@ struct acp3x_platform_info {
 struct i2s_dev_data {
 	bool tdm_mode;
 	unsigned int i2s_irq;
+	u16 i2s_instance;
 	u32 tdm_fmt;
 	u32 substream_type;
 	void __iomem *acp3x_base;
-- 
2.7.4

