Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD283C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876812187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ngOUpKMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfKGN1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:27:10 -0500
Received: from mail-eopbgr790055.outbound.protection.outlook.com ([40.107.79.55]:38208
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388209AbfKGN1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:27:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYUUyOqRJUsN6OshetCRW6O0DlzPZyYCOPG/s846EPuimeBFzpnLGlMHIU8MmEhUiINUwdEVk2uiAr/m8/bnjRhVjBayOdLTCMT7ZnmHIxTVqd769VIPeEpr/x7/wj/jUBfh12uftxSVvrl3mfY27go1203iYTYkfaU/cVxPS3TtRUeGy0UZQjuJcsiM87phBRckSWbDWVbhF5jBfHMDLik6Ud8ueub+/8HW9tYJ8VHQbwlR6r8Jp7XqYaLmDX7vGt1V1DF2TQKD/5odqFVaWn7ap6Qd+lnziCtlUGgDboc3+AqC90o1xWlrlu2PpDTCpxWlJKOPQOQJ7cNdyYdYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKZUbaZSH17/e9RV772LPLHjWgMfQ56YGLiFF965dys=;
 b=SdC5fLRgO2/3BygW5bBzRRNetPNqFooLvmte/Ph1YYdEsrPVsch72xCftOMgNYRiGNabLvgTg422B2/rj26DuM6Est2twI45m4AIFmyQU8pobQRlAW5GgpoF89FAa7rdBwbG45Aak5e2ndSoXfO1CGAzpYXh5xgiU12+VPx1LrOlyGmV+P5VYlZ0nE5RqzVW/gU+4pHSF++4SNNBEtRVlykaouQOMwVSFrJCVNCc7bDaeBzQW+W6zHodiCx+sdSgAq51O3lbx0M6MGNGZZ09o/YBKXvQiceuYS0z584a/SQ7py+L45K24bqSsYUcR+xGeAxIow7QWoVHaEP5N8BzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKZUbaZSH17/e9RV772LPLHjWgMfQ56YGLiFF965dys=;
 b=ngOUpKMm0usVsDJMCAxu3yGseRebxdn6I63FOR2GjuXW249+EareQ+gth5xK7iNRPifvWXiCt6+J8bn1vYTEG9kcSPgLZjbFRXAwpyyHX7mNqk4Zbv5Senm2wmlOf9JQG44ckKDd9JRW+yypPNU7ILtUgwhk69K5B4Ri3RjVTj4=
Received: from CY4PR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:910:16::31) by DM5PR12MB1945.namprd12.prod.outlook.com
 (2603:10b6:3:10f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 13:27:07 +0000
Received: from DM3NAM03FT019.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::207) by CY4PR1201CA0021.outlook.office365.com
 (2603:10b6:910:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 13:27:07 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT019.mail.protection.outlook.com (10.152.82.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 13:27:06 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 07:27:06 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 07:27:02 -0600
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
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 5/6] ASoC: amd: handle ACP3x i2s-sp watermark interrupt.
Date:   Thu, 7 Nov 2019 18:54:52 +0530
Message-ID: <1573133093-28208-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573133093-28208-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573133093-28208-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(428003)(189003)(199004)(36756003)(50466002)(478600001)(26005)(186003)(86362001)(4326008)(305945005)(76176011)(51416003)(81166006)(81156014)(5660300002)(7696005)(50226002)(1671002)(48376002)(8676002)(356004)(11346002)(109986005)(126002)(53416004)(2616005)(47776003)(486006)(476003)(16586007)(446003)(70206006)(316002)(70586007)(2906002)(426003)(54906003)(6666004)(336012)(8936002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1945;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e04ea9-bd67-4cd2-135f-08d763862f81
X-MS-TrafficTypeDiagnostic: DM5PR12MB1945:|DM5PR12MB1945:
X-Microsoft-Antispam-PRVS: <DM5PR12MB194565FFBA326A99F4A27655E7780@DM5PR12MB1945.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yq/wd1rTQ4tPFGgLJE22zn7wNrESP5SqvP8wHlnQHsgTmOVxthnDW4iRMrlo9HjXw9QWTeo+DoTDFlLoklDRvcs4cgpJOwtXOkwfRgHXEeGY5whIjM7TYffD4WDuGusghMkLk/Ncjf28L7QHVcR7xGeEPt0Uhh0hbpdOnvTB2mE6UJEcrFgmtgzxSsCuZG3YkWWi4iMErHt0eDKLYx5fwHZpaYRjxNvJ7mmbQlJ/n+uRt6r9gL98hwLN8UV8yVPfGAumGBYkI6OOPdls8CeHxmzHJeavUkSNLR68avO7NZ5RnLxrdBcFZCo0XG9VAnnar5+Fhr0r/YRVFHQdQE+ypwTJczXzsvKwdwcB8+XXx0vkWG5iAxfEffL7w1Twf55nIb6LwFsfOy4B7NqimLYt0hq3GdmDesqyRhmUAnNJdWGwzKJYWqGTUgFWz4n/fo6Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 13:27:06.9134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e04ea9-bd67-4cd2-135f-08d763862f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
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
index 8fab505..629a32f 100644
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

