Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D136DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9966920715
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p4oiB1Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLBOHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:07:37 -0500
Received: from mail-eopbgr770079.outbound.protection.outlook.com ([40.107.77.79]:52088
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbfLBOHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:07:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYYaDfP8PCWgq2AfGdIHgwypaMukqcQjeBM7JZxLITpeNUEYu9SmXMIATONVVR+lHpF8mG8gTHmgl8/VIdP8LlMSTQkb0yV4cZia4cPP6rIMJ3lQQCTLGJIjBglBO5mgVDPqMsRFZ4oLgktzuSOJbyyIUmXC9nSpJlWmtrZM4JFLEyY/m8IjaWCt3OT4fA7uhbdIQKKs9qpt4WjIjIV1BlPqiC8YDf0/l6l7M1vN3Pk0uj9Gt60v6IZWkaDZvrCVd75DkwJRuC0BfoTaVyx/u3Skd/b+avyvlW6RiSOl7Bx0k657250k+IWAUX08WQomodzlXix4DVtvohUD4kOvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+PJA8YsSavTKQ4DUxOIyr2gdRZwUH2qDtnbKAyINNI=;
 b=M6rNIsjXB/pBMEwRCEXr13K5ekPM/YxUT7vU0gK68C+cRV7q7hBjTtda6LE6pmKUvhe3ZhqjZDFVhIAEMsX8k9p+2K/+C5KbC6lJqonyRJ/FiH1DrdFsIv9e3uf9d7uAfkx5iGUoMwshONmV3619mw8uyVo7NbyNP8TK0ueERFGucSuRrdjy8NYp5sAryscVRGLre2UUudZ3c7Jw1UMiQVqQVoe+nkWIleEhQO+cM1wPFH0+uLhueJd5eZ5w+BNt40W0PtPSk5p5sSUkCMjRWFSHc/0zspxcgo4L4YFwYL18m2B1IYd2I4OsEcXUXmjeL9Ctc8XfIvBIu94B6MiGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+PJA8YsSavTKQ4DUxOIyr2gdRZwUH2qDtnbKAyINNI=;
 b=p4oiB1MwZhEnEjIByTYeauNb6H9UbGLMZmDg0fZxy1o0udLOf3Kgjr0QGBK18aeeNUyyzIT0uaRW8/buus2Kd+muiBif8NTMQsaJWMPtlLHdAQVS1aPOcstej8/OoYs9hjjY16bbsz9XdSExrNiEbfxPYkVITo1cF+VYhnp5igU=
Received: from MWHPR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:301:4a::33) by BN6PR1201MB0164.namprd12.prod.outlook.com
 (2603:10b6:405:4e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Mon, 2 Dec
 2019 14:06:55 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::204) by MWHPR1201CA0023.outlook.office365.com
 (2603:10b6:301:4a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.17 via Frontend
 Transport; Mon, 2 Dec 2019 14:06:54 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 2 Dec 2019 14:06:54 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 08:06:40 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Dec 2019 08:06:37 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 4/7] ASoC: amd: add ACP3x TDM mode support
Date:   Mon, 2 Dec 2019 19:34:38 +0530
Message-ID: <1575295481-9076-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575295481-9076-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1575295481-9076-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(428003)(199004)(189003)(316002)(50466002)(51416003)(70206006)(70586007)(305945005)(7696005)(8676002)(81156014)(50226002)(47776003)(86362001)(356004)(2906002)(5660300002)(36756003)(16586007)(48376002)(109986005)(1671002)(76176011)(8936002)(81166006)(53416004)(4326008)(478600001)(446003)(426003)(11346002)(336012)(186003)(2616005)(26005)(54906003)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB0164;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb78d5d-fc1d-4175-6e14-08d77730e2b7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0164:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0164B142BB6B5708DFAB8E13E7430@BN6PR1201MB0164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /F65ByPMk//rOOhuExpbmUcimi7snkFVPqf1nH++jMY2dGbrwi1dM5daq0Okj5An1nJ/pe1zoZFfZhL16eZQHzx5SThcpHftTsBhupH8Y9btFHQoC20crpJpAg7Qy7lyA0etQlC0UIADZXOBgvP3AmzilZUeeyzBkDPvuVFc2NbGvr8wbGY4U9Sqo9mfuDtNeE+oX1lfz1K2/ZGuc/IILabjXIpY5RFOI9txFHa5W+Ci4kO2E7pRrFSy257nuOCEBUGJaHs4sRjZvw4szE8nPloUZ1WV5qYonG1hSe1fl7YfbeNQvy+oNVV6pi4fNU64DTJKZmOhcE7Y4tNRhDhmyDa0+cDAkGhHaR0WE/eehBAVAJq+TgvUE96OkhVirVSI2n4FIRMHH4Pr7Dfgk1A8oX7rEOr7ANkQNmXIJEYyPTp/A1Ki49CmGDHba/uq8FD2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 14:06:54.1181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb78d5d-fc1d-4175-6e14-08d77730e2b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0164
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
index ed1acbc..3c28644 100644
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

