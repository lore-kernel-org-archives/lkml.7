Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1144FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF532196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mq9Zugu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKKOwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:52:21 -0500
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:15824
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbfKKOwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:52:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQh3M7/NL2abihgXxKVRbD4as6DgoOvg1OpB1wYXk+HrzA7R7x7Yxqo81BJIONKYKeETNDRaCOJ1DtUyb9ImDLKfQp2rPeFrQ5hlR5qNhQzXmOS4aZlPQzI4yGQKAqVJsdO86I3Jm+jNesKkkvngJnhzKQ5sjNDV45l5AXF1qkFXDoA8N8cVT8sOuQYb4yx6E8xLogtF9gejZjnPJGauf5uCE2zWmyM1um1BNLN4OBUE3Xdr1pVnenO/EK4qGvYnQeIVRG9QByEcEFxpa0Ec417i9W1OVB5EQWWA0G31Gbcy26iyPXxIQQIVGMsElo1SV7ymQKo/pEhXcG+lHaFUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H65aaJcfq96vI44D51yul3iAimd3z3yS1JC+9TcHqow=;
 b=nYm5RuEPYqhWScwJulJhP5uyuOVgN9/7HwZIo3qq4xMI1RwJSrFdcLzWjITLlPL1+f/SAy8l5hFP0krBaPoXPz7lSbuoMv4tyssll1q2IyAgh8pF5ykpKjJUWlL+2HDw/LZVq2jhcuhz/xqBvE4s9qWS94qFyQ0fiqaWX30SGd6Fwc1EGhLTd8YrxN62xfBolwYyY+axTwHppuDKeOfR1JQ7l6d6lmcXRqEWpcl9UTbDvz+OeE00wdqdyETyN7ESbASbEKIFj0w1zGedqHSO+fFw3Hoj6n85+4A9TqIsVio9N07u9c/tnmIr6tWNvMoA316ZumDTzfsSvMZ+6atuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H65aaJcfq96vI44D51yul3iAimd3z3yS1JC+9TcHqow=;
 b=Mq9Zugu4wXANBqM/T0kGYbpFN7yQHFI//BvRccrKlvG91o/4Xqo8j6VomUZ0gv8sNPfvH3HBW9OubbagzGhfgNZbHSzrp8svgfiuUohzIYbnMOnHBzIEvcPbjGuo3dSFPd4Z0hT/aq/9X1fmvR5VYkW74pHwLkTXPQ2awDCaUO8=
Received: from BN6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:405:70::18)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Mon, 11 Nov
 2019 14:52:14 +0000
Received: from CO1NAM03FT012.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by BN6PR12CA0032.outlook.office365.com
 (2603:10b6:405:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Mon, 11 Nov 2019 14:52:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT012.mail.protection.outlook.com (10.152.80.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Mon, 11 Nov 2019 14:52:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 11 Nov
 2019 08:52:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 11 Nov
 2019 08:52:12 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 11 Nov 2019 08:52:08 -0600
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
Subject: [PATCH v4 5/6] ASoC: amd: handle ACP3x i2s-sp interrupt.
Date:   Mon, 11 Nov 2019 20:19:53 +0530
Message-ID: <1573483794-8921-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573483794-8921-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573483794-8921-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(428003)(189003)(199004)(478600001)(54906003)(26005)(6666004)(356004)(86362001)(50466002)(48376002)(53416004)(36756003)(186003)(316002)(2906002)(47776003)(109986005)(305945005)(126002)(70586007)(70206006)(50226002)(486006)(2616005)(476003)(81156014)(81166006)(8936002)(8676002)(336012)(4326008)(1671002)(11346002)(76176011)(426003)(7696005)(51416003)(446003)(16586007)(5660300002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1870;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aca98503-a43f-4ab8-b5cb-08d766b6bcd4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:|MWHPR12MB1870:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18707AFF9D7F240052B784BFE7740@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0218A015FA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQE6pwwOzrwdhhhIIBVsV3LCYJt1U7BNAYYvU9JAekh+riR0ByynGPCChbEjCzleGWBhD1e1+F1I1PzFz+deKtd1qABcnbEsasKU8vVh/++9uO3aHSmkJNPGtjwGj9QgNcJNyoxtMBYL0Fn3NX23ZotsUa+mrUeC0XvSWJq+yBCWOHkFlk9QBD13dza/ODnBBMpkXba/Zdfy+2SPu1xdftFtwmYNzGIOlcIqoCsAq4in+r+m5kAQC+ytBtxM4iSM6pVYH1NW03sllkBjIRhu82EThCaEADF2ZRWs5+oqpylj7F1GvghfI473n4sV20Ip+CcYhrXkwoVc6ExP8pBC0Si/609NS+kLaUr18AeN7n4pVoTChy/XvAG36+D0/XHwNN5vNUASWcaBDFEIAkIJ15ZW/GZ0vkht3BH7wrGLfUekSqqA65bF6Jh6zXfOM9sX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 14:52:13.2741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca98503-a43f-4ab8-b5cb-08d766b6bcd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled support for handling i2s-sp interrupt.
previous to this,Driver support only BT instance and
interrupt on i2s-sp were not handled.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 6e70fa8..8a8b135 100644
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

