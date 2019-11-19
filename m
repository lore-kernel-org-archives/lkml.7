Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC33CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67CE222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i34BzZ2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfKSMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:13:03 -0500
Received: from mail-eopbgr790047.outbound.protection.outlook.com ([40.107.79.47]:19289
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSMND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:13:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ7TqXzUBBXqMpQ+MCBb8GuWtluZmVM2IqvKbbuGpGdaobaeQeh8cdc8oe3drbuAyI2muSgBJEWSYQo58cfKJ4SXpIyH+pCsTievwDyEBH9J7+zv+Il5IkcoXhCgK1U9eNfkOISkp2LnYu7xWQiws9WDkhPHjLWzTBIOTaUV6pC/TBJDI1yF14edeqLofMwyMSA0JzOBS70bSwlIHGCdQmZEPDGDvp9XCN4XtobOXI1D6R3f5/O3lyLqF/8+XtArH7PsPSlVqu/l4/i4b4DScoW897tvUk372+h+CCURjgsxdGWfrEkH0cA4yyE9eUqlls3wNWJrPZbSe3A6yL5gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdqAZdh5U6sOBgDkyVbY7DpGtb3eXsXXJFDNqcmuy34=;
 b=UvPasBAhEtcZ6/ouyaeinL77dA4eBgTBbnHcl7ztorT2GnvzjTebAu2z4MWBJv/+LAUHbWDj8TEJv1PKXAeEHaFQSfZxEULP3/4PfLwXJFsrJyxjsuHL40OkuD6ZuBzE2LLuBbQnwbIAqc51WsybGyFs9L8bwfLrF5xme9uny35WnqC5yBNS27S8B5+UJ4TGQCcxxqdveTllotONVe0+nXJ8GxQjye/UWkH9shfyn3OIWkwLELAecHV53RnRnp1uXknO1TdIZmlQDiqGjR4WsQ66Y3buWBjBHEbUfsffgcZUDjfWYjb+q9EgJoLGv/Sxyy/k6UA+qFB73Rc+sirStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdqAZdh5U6sOBgDkyVbY7DpGtb3eXsXXJFDNqcmuy34=;
 b=i34BzZ2zugP0wAsyNcjr+qRRBWrE274fDAtAYEZXDKeik/oMPKsPh/2F1yrXr+XW5HI+HuuYItHitiU9FERaDdt07zEIxKKISRYCqmGkLWps74kjS5CDV8/jb3UfXjgMsVXQBCUAOGyUQlk2v34Wkuy+MnYEFOiinZ0xP3g4wI0=
Received: from DM3PR12CA0078.namprd12.prod.outlook.com (2603:10b6:0:57::22) by
 BN6PR1201MB2464.namprd12.prod.outlook.com (2603:10b6:404:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 19 Nov
 2019 12:12:57 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::206) by DM3PR12CA0078.outlook.office365.com
 (2603:10b6:0:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 19 Nov 2019 12:12:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 12:12:57 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 06:12:56 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 06:12:53 -0600
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
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v9 4/6] ASoC: amd: add ACP3x TDM mode support
Date:   Tue, 19 Nov 2019 17:41:14 +0530
Message-ID: <1574165476-24987-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574165476-24987-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574165476-24987-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(428003)(199004)(189003)(316002)(16586007)(5660300002)(7696005)(8936002)(51416003)(50226002)(76176011)(4326008)(54906003)(86362001)(8676002)(81156014)(81166006)(109986005)(186003)(36756003)(11346002)(48376002)(1671002)(478600001)(53416004)(26005)(446003)(70586007)(70206006)(426003)(336012)(305945005)(6666004)(47776003)(356004)(486006)(476003)(126002)(2616005)(50466002)(2906002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB2464;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc24277-17c9-4790-bfc9-08d76ce9d04f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2464:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24646E1320F37E807E35A327E74C0@BN6PR1201MB2464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 022649CC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNkXRNPfCvuGHOTVq1+mUe9m0eu/C1xc0mDPU1RF09PhkvFCD2i5Irzjb3JIdZmw0z7eO1WEd/IxJIr3FpSCU0d18OifsNkXtL9AT2kGtaAwXiEmjBPgJmJcbY7TbAT+pbYTLLGYur6AHC44xKMkj8YA0djvOe8NIAcylEucxoht2d4CJNrUZBUDXCVY+bBjW/mqSZT7Jkh96yM3AN3dJFxhW0NeXlLv/veze1p6e33KSVMCgd4/rmCTDvjBNTYHuVtsMSc9k3Na4OvtDT5TkJiODWppaVs3A957I9jTcVuKq+PyQMeff+LZjEnOcUFZ4DzgA0oRoQTxCrc0YdBMYHtxRoQm05qZkTHSn4pNLiAqQaNFShRSmMDD1Q67Mso5g/sE6P9lE03GVzE8V7vWSqhRDuMZbj8MkFhHGuU+c7/ElcGQlkFjUAHLpOABWSlO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 12:12:57.3861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc24277-17c9-4790-bfc9-08d76ce9d04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2464
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 42 +++++++++++++++++++++++++++++++----------
 sound/soc/amd/raven/acp3x.h     |  2 ++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index b039dac..d7aa345 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -44,8 +44,8 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 		u32 rx_mask, int slots, int slot_width)
 {
 	struct i2s_dev_data *adata;
-	u32 val;
 	u16 slot_len;
+	u32 val, flen, reg_val, frmt_reg;
 
 	adata = snd_soc_dai_get_drvdata(cpu_dai);
 
@@ -68,16 +68,38 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 		return -EINVAL;
 	}
 
-	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
-	rv_writel(val | 0x2, adata->acp3x_base + mmACP_BTTDM_ITER);
-	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
-	rv_writel(val | 0x2, adata->acp3x_base + mmACP_BTTDM_IRER);
-
-	val = FRM_LEN | (slots << 15) | (slot_len << 18);
-	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_TXFRMT);
-	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_RXFRMT);
+	/* Enable I2S / BT channels TDM and respective
+	 * I2S/BT`s TX/RX Formats frame lengths.
+	 */
+	flen = FRM_LEN | (slots << 15) | (slot_len << 18);
 
-	adata->tdm_fmt = val;
+	if (adata->substream_type == SNDRV_PCM_STREAM_PLAYBACK) {
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
+	} else {
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
+	}
+	val = rv_readl(adata->acp3x_base + reg_val);
+	rv_writel(val | 0x2, adata->acp3x_base + reg_val);
+	rv_writel(flen,	adata->acp3x_base + frmt_reg);
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

