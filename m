Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30209C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F7121582
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rIYGqi4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfL1NnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 08:43:11 -0500
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:33611
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfL1NnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 08:43:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao76RBznfntRTaslV2RyrDapUJv9JY/zmp5XCKcFZpX8zu1cOdaASmQHFI/XUIHpxmrhh2gLK8gk6adONGeTZJofiLBmd8oueIe7lLPl4ITJoneqipTWrajHCv2+Eh95SQ7vWsqmge5fusB0+6G+5qTSWtLKcovSQnNHT+rRlr7g7kkVxIZAh0JogJSnGVXaGJxbmxdfoFdSmglkIeZetEgEaZJcurnIrSwj9glvQSbRu/LKcNBvJY31HsAu38eXP9irItmfivxerp/YVVaMdfJkqQRKptlhY0V7qmp4ryfkMVt461bRiGD5Pa4qtDicAujRSnwwPg1u/GtGVW1aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCAcfYM7AfOyxh0k0dFtO/vwK1F7bu/hlqtNnNUuVsM=;
 b=diRVvmCBhP2EwRiCO3rVgkCj16C7MLUVCh3PxyXiLdGtQ8mbRG0joM4SLn9iI7BV5zTvLj80//NSnmxuv/oC2VzSJMmD+rmaq5tRAt4qHkhAnLlRfrnFOBsYL3fSesk0vXxWnJ22HkWXVtPHhHvTZrnKw8CtJnzDSMkePBeUKu2dqCwDxL65uaQKCyX05brXM7PpWnZZHVtX41M4IGdlaQrt1PnYP9X0Ee3jKws/i9mkW5MuawceSXEDrMDZ4HGeT3YJme3tCVqkUdPGKFXlQxXcq+veP8esFMr2G2vEGp2yMQURXeWY+eZqgse1PbuxTm+8roDDYaSSSgPGRcLi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCAcfYM7AfOyxh0k0dFtO/vwK1F7bu/hlqtNnNUuVsM=;
 b=rIYGqi4ChWVlVAf88iVmkRv/j8GnImQZx/2NJ5Xb+kpjQ+E27YgZzRkkj3sDKawO8JroSsp/eF7oPOC9sV+lKeo9XQEjUQ0MyXv7nhz1WZo27q85hreklNNM7sBOPnWSiXoO3Ke8OpU3wAedccGGTCpQNp1VW+LIvADjDPv+2V8=
Received: from DM5PR12CA0016.namprd12.prod.outlook.com (2603:10b6:4:1::26) by
 BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Sat, 28 Dec
 2019 13:43:06 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0016.outlook.office365.com
 (2603:10b6:4:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Sat, 28 Dec 2019 13:43:06 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2581.11 via Frontend Transport; Sat, 28 Dec 2019 13:43:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 28 Dec
 2019 07:43:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 28 Dec
 2019 07:43:05 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sat, 28 Dec 2019 07:43:01 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <broonie@kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] ASoC: amd: Handle ACP3x I2S-SP Interrupts.
Date:   Sat, 28 Dec 2019 19:10:58 +0530
Message-ID: <1577540460-21438-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577540460-21438-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1577540460-21438-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(189003)(199004)(36756003)(2906002)(8936002)(5660300002)(26005)(478600001)(336012)(426003)(7696005)(2616005)(70586007)(8676002)(6666004)(4326008)(86362001)(54906003)(186003)(109986005)(81166006)(81156014)(316002)(356004)(70206006)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR12MB4065;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37dec913-076c-422b-3069-08d78b9bde39
X-MS-TrafficTypeDiagnostic: BY5PR12MB4065:|BY5PR12MB4065:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4065A75F20191C1DBC2FB524E7250@BY5PR12MB4065.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 02652BD10A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oR6GvunDYmDaXdyf/h8SoLUqgFSWj7wCOAaJmWnbVlzSNf44BEIwm3ErXvuCy2CLQ0xJLD6wErQocQvpYooDiVCehKYS2PaNqD4WS1tpESXO7MepttJl7YD6mUvqD8P7NDlQGKBBkdKFimEYjUNzUuAr/XL+IYIKa3COmPuT+/c6E3giXP6qGmKIbRlS7HqWheYP/+ncyT8UfrGgcEVKYy9lltyyXg42GRMpQWK2nX9s7cdC3ymbJwtE6ud/oLas9KNkKppAL62NHArMsq7crGpeu1hjOrA9jhI2KM0WA9A+mj4aik7CToYlsAqRt8eCxWWiWVFMuOil+09Abi53U0KvHEoQU2RkHYSgDi87WDhYF8WQ+jSjNgB/ZB6XQwxZGBkQCQfAhULlRNlZpTt+HsqCI8udzIn5X54R89SsbVIr1FKOwCSx0g+SOqRGVhof9JQz/4W6y8AUaEWUCU8wR83+AI2R5jf4gWwpmRN+hXhDdOiEK5BBDVkf6UhsmCms
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2019 13:43:05.9854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dec913-076c-422b-3069-08d78b9bde39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled support for I2S-SP interrupt handling.
Previous to this implementation, driver supports only interrupts
on BT instance.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 040a8be5..c5d7f35 100644
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

