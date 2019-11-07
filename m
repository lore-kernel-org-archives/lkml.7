Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB2C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95369217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G2HPILww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfKFOiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:38:25 -0500
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:32742
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfKFOiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:38:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kil2UdAjJu3Ltr7RCw+ThmrdakEUg3lppqprX5G8vcEJYicaOpbhCRDsmi7rYUXjAuzM4wCnHL5ikfCsT+EpLOP87SY7FLuJIt7etUe5rcTOj/+pCjib0+W54EmqzPcOSHTQVpoWjUamw7PHyMltwu1Z58X8CpiTfQV1s7AIzaMpYQkqv0cPsj4vkT73yB+5igl2LDx167KVqi0bo936YbenoRKnF3ZIRcnuWY47ITHtlAnO+djLefumUE5iYnL90vkEQLW8SWUOUW7sk0XZsvNj9d80V09UW/aXcm67fCTB9tGQdOgh7FA9HkXqVb4FfzZkRr0Qm8Ikc4hSYPLSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP950m9Lua3CxdO/VEl54zPIkv84dlcsHExu98kMj2E=;
 b=HIFJLM6rFXulk2EL5oZ9pGf3mBvxf8RFRDxA59/9s/5G0qWaKOXgqoOQWqerKrvBdGmFs1QmTSMp7am8x/1E2KQYP5aDbATCkiyb2SFF3lDXXrXMq72C8X5HGPgJ0TSKaQ2ErA12p9wYRYqvMRL9IKHiWRAhX3m/81Z9rHdZ6ZE/MvefSWd4vd+rlTYtgD9eKwtPifEbqV4HA46jf3/b/UgcKkXIGHMCXNpUA9qQbQjcx7TD2MK0LxRyZasDt/nibFd46hwp6KNYMbeqLoNGQLFMBKrcqwNkYniQFtbHZoMv9KQ3R1rpT04sD+6eDeYu8LJi9ky4LDaNY0t6luiQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP950m9Lua3CxdO/VEl54zPIkv84dlcsHExu98kMj2E=;
 b=G2HPILww2neDJMia3TMUMOMggIFyg85PrFh7r9MRyXBWPKnlX2wEuB9HQtvVCJBISuA6vV6ZIZLLpqPcxHFh6faRjpvdv3f8oaqaa5A3+8AG/2d3oC+CfUJliu8BVv2Uqj9f24xUVvpRbQFDm+U5A8yjmTu+V0ce+bd8hDFOm9g=
Received: from CY4PR12CA0034.namprd12.prod.outlook.com (2603:10b6:903:129::20)
 by DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 6 Nov
 2019 14:38:21 +0000
Received: from DM3NAM03FT060.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by CY4PR12CA0034.outlook.office365.com
 (2603:10b6:903:129::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 14:38:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT060.mail.protection.outlook.com (10.152.83.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Wed, 6 Nov 2019 14:38:21 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 08:38:20 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 08:38:14 -0600
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
        "Maruthi Bayyavarapu" <maruthi.bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2 5/7] ASoC: amd: handle ACP3x i2s-sp watermark interrupt.
Date:   Thu, 7 Nov 2019 20:06:02 +0530
Message-ID: <1573137364-5592-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(428003)(199004)(189003)(47776003)(486006)(476003)(336012)(2616005)(126002)(53416004)(356004)(11346002)(109986005)(426003)(54906003)(6666004)(446003)(16586007)(70586007)(316002)(70206006)(2906002)(5660300002)(26005)(478600001)(86362001)(4326008)(186003)(36756003)(50466002)(1671002)(50226002)(48376002)(8676002)(8936002)(51416003)(76176011)(81156014)(81166006)(305945005)(7696005)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3370;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae07e60-1bb3-48eb-8b66-08d762c6f8c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:|DM6PR12MB3370:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3370EDBCFF619C019F78B868E7790@DM6PR12MB3370.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WznM1EnCSUcrBm61a6fO7RW2xPuLfOWfNUSEuf/jd+s778MMg50SvQiVniUQa4a9P6S1IATsdBIcrnuLQgXJkeUzlPZuolkdMKumw4NEJHQ0BVMEY5UMF9UBBQq2C0+P0sbGdz4JVBYQJNI4rCCxjFRAGjGlEhRX7vE2nXb8FHcrNNp1HMPhgdzh3j6gmAkyK3oFPUqtrdOzBGBev28TPBJ/nwSIrx8lYqGVLwpOeJ6bGR2nV6o+W7s/1zgzzq3UqEIm+uDFz3pnC2JpPxmZehwjK/hIhJIcykIpRV9bHEaNHw6rZSuB2tbLqnlC07UP7DVB/OVy3bR6W0Q9b7CQ/bNjxXM1m3lnhFdXZMniYAvCAWjWtVW/Ym70TIJlcG8KJQToBmBmeJ0FvD7Hi9k+rz9bAMlkiERgB+a3SRDjJRhFUTfKEpq1bCRHw7X7HO3C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 14:38:21.2378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae07e60-1bb3-48eb-8b66-08d762c6f8c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

whenever audio data equal to I2S-SP fifo watermark level is
produced/consumed, interrupt is generated.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 58db11b..689e234 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -176,6 +176,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 		snd_pcm_period_elapsed(rv_i2s_data->play_stream);
 		play_flag = 1;
 	}
+	if ((val & BIT(I2S_TX_THRESHOLD)) &&
+				rv_i2s_data->i2ssp_play_stream) {
+		rv_writel(BIT(I2S_TX_THRESHOLD),
+			rv_i2s_data->acp3x_base	+ mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->i2ssp_play_stream);
+		play_flag = 1;
+	}
 
 	if ((val & BIT(BT_RX_THRESHOLD)) && rv_i2s_data->capture_stream) {
 		rv_writel(BIT(BT_RX_THRESHOLD), rv_i2s_data->acp3x_base +
@@ -183,6 +190,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 		snd_pcm_period_elapsed(rv_i2s_data->capture_stream);
 		cap_flag = 1;
 	}
+	if ((val & BIT(I2S_RX_THRESHOLD)) &&
+				rv_i2s_data->i2ssp_capture_stream) {
+		rv_writel(BIT(I2S_RX_THRESHOLD),
+			 rv_i2s_data->acp3x_base + mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->i2ssp_capture_stream);
+		cap_flag = 1;
+	}
 
 	if (play_flag | cap_flag)
 		return IRQ_HANDLED;
-- 
2.7.4

