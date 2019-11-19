Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC56C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187D3222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iDxg7H1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfKSMNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:13:50 -0500
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:21185
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbfKSMNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:13:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3QWZRwP+/iLW7Hg1Q44SvpxE4Ql1yQ06B4e+sRyI/NBnpZCPGhZLsd9HICYdkqo23Cn68Fvfx6bv/lApx/vuxHiyqZ73FyXlDAgnwbM9IcyYizLUU2Cy5BBLeNJoevYIU1tI7SZUwd5YaYQ6dM6BTqazFLoAfkuU300k1EyKNnIe1Wt7wDESbtSh9ya+r7SFe4/n7cFUl3B9gYgwrXrqrele4Fnxrx9kJJKFP4gMzh9mkq9s5e09AgeyM5428+M+Qv6ztOQg4XygMkIOCKE5XLp+DjdOFdRJsZeIOggTY6l+Wa2OfzUQ/5o/7mlQfHeho6gh+W3d50848BqjlEtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF3ObpMDNGS6u6mbWRwaVQmx6sADTc0lqCjP4+6OrHc=;
 b=cyWqY+QSCS1pbZvIkRLW/y87v7U5qjPPdun9YxE4tLJ/5yYh9TvullftxfwEs7B6Wx1/IR7aiW2vyTpvK3LfLPQr7WWYCT2cadN54drvM3pDGW+L8fHA0aBSdRCw+8815gi+X7ezJTfT+6fJkA5HGp7cZ7CRnDyKnXNcEFFP+aAhM+rdJqI9tPkkyteA05qaUiMKY37HfnlPhPKt1T2oV00eiMejC1MizAVaO63FYdBEf6hab3M/Gmxnceh82DRu5nz/GhVbJmsN0u8ED7x+N53+cJ/WNYti6oNZ1stuL8TnnWuNSGwinQlajVSljqDSGZGSqpuRxCxxwuKtzHTrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF3ObpMDNGS6u6mbWRwaVQmx6sADTc0lqCjP4+6OrHc=;
 b=iDxg7H1EvUj4uCa1oj66m6wG8bzbb7Bu5HT9A2lcicxM7JGXL8Y8Y8qLl8b3iJxoYWMPmJ1CFIbVuFUjGhsRp8kOZyWQ5n/JqdXgYYb2cOdc6rRjgvbsznjdAiTuZEnWnEKaQxvRcmJuEzVb7XEc0g5hoa6Sz/MOa9ZtS216Z58=
Received: from DM3PR12CA0107.namprd12.prod.outlook.com (2603:10b6:0:55::27) by
 BN8PR12MB3121.namprd12.prod.outlook.com (2603:10b6:408:40::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 12:13:02 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by DM3PR12CA0107.outlook.office365.com
 (2603:10b6:0:55::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 19 Nov 2019 12:13:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 12:13:01 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 06:13:01 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 06:12:57 -0600
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
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v9 5/6] ASoC: amd: Handle ACP3x I2S-SP Interrupts.
Date:   Tue, 19 Nov 2019 17:41:15 +0530
Message-ID: <1574165476-24987-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574165476-24987-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574165476-24987-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(428003)(189003)(199004)(16586007)(11346002)(316002)(50466002)(336012)(4326008)(8676002)(8936002)(2906002)(47776003)(305945005)(446003)(426003)(186003)(86362001)(70206006)(70586007)(48376002)(1671002)(53416004)(478600001)(486006)(109986005)(2616005)(126002)(5660300002)(476003)(51416003)(54906003)(26005)(81166006)(81156014)(7696005)(36756003)(356004)(6666004)(76176011)(50226002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB3121;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b42268f-59c2-404d-3f03-08d76ce9d2f7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3121:|BN8PR12MB3121:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31218294C6675903C45B21C9E74C0@BN8PR12MB3121.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 022649CC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3irtINoZouAutCcGBOMvWuYn46Yjw9ZPmXy6Ji4Dknc6J5mP8UiYnY7amY7R+IiUl1bjhQ1NgG6qx44cZ62C86fCbeHr8kC8qcbPP+UC3mEGChm2Z6ACQFg7zVq39jMUzK6qByu9Ud7iIFdMYKXRWzvAWcw/LqROgMkIT1w45opdcMhXWE9YS/VCYMV63LHtmxv7mq6BtkJr/cej56XtVtg++mWe6EqgViT8tdx8i1BUB7YodMGmCDqJSS0irbGYwx6ygHoqpcbqx5IjQKm1lqz+BB8OjOI195jiyvUNg4vaJrFQtoeypSt5RX0blfI/J9ucNJUzQB0gqtDZlhU0MgOdCrvDEwaL71vIFGLhuII/6K/YtkscykEuHTNt5uSdNLq7NMgCwsv4IUKvCMfDaie2hmXynUaPsDA59WHwRNLgRxV+7n2qYaJur5AtGtS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 12:13:01.8386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b42268f-59c2-404d-3f03-08d76ce9d2f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3121
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
index 4fd3fc8..819ec3a 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -177,6 +177,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
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
@@ -184,6 +191,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
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

