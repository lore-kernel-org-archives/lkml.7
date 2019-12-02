Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A57C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F24820715
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4gCJny6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLBOHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:07:44 -0500
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:1344
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727501AbfLBOHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:07:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvgZIH3OCVN2xrpt2C8QG83YeZLQ0+e1vWBRwg5sssA5tHeiTVyxosCejBa55l29EGjIkh90SJzMiutg5bjjn9WyslUT2ddp47sSa9TVx+MiI1Dwx3XWpT87re3/ohBpK41DYVmkeYUYUlydudYjpOEBg5SaCJrEdojdg0BGbGW+16sgyHzyoEu7HbTDcGjFLhTwuT2A8/2KnBJ9NIXGkaocJfb1zXG/LlBHXtVUYtQWyrvgzKY1Tr2ceAhlX2gQVygOWp+iVRIEAHLeLm45RP6VsXGzMfeQaKbbvqxuwFa3htCfb6vl380y2cZGd03V4/tkp8238yK64DU5yrWiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut0B5CEuA09psSxCpV5btNncQviIbnAjU0/pQKg3nyY=;
 b=NexUbqZNtJczCXb3R88C/oq7ffTFQgst1yDTDnKAX7h6OuruqGoFXS3hfp67tgflfLiq1IQyVgbOIcH9nqtXUVDI/Jx7eDO7FpbWPDYwfpElDyAFWRxFL1I4+ikGIX/hD7AWQEL10EE4c7rZ2lFY/90CWYzGURyYB/L/5oI9QXTM68Rs/hSRKqDQleZnCJmYeams7MmonYGrhB3U9mSMHdbzLO7OGzBvSl1J+A3YBu7ZBJYVENlDq9YQcSon+KlH44FX/mgxjv62bpudY867SMIAYNfz9C6WlZpNWIX70pR5EmmzQskZyHxYXZxeG+enBCK+K+vqjPzvkTOwhl+Mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut0B5CEuA09psSxCpV5btNncQviIbnAjU0/pQKg3nyY=;
 b=4gCJny6tPY4lU9LcmkUIaVmBumyGRWXDN/rDdWveGRDN4h9/ksXTOYosMOM3h7Pfib7dUmCgwmOwpX/abTPj7bMBBT/PRa1t2a9qoOEZwPWCM1yvAy4QIpD7eQcqa9g1C2iipHiUUe7FrETNiC8HwRerLXYEnVJVdXKvxPZ/I9k=
Received: from MWHPR1201CA0022.namprd12.prod.outlook.com
 (2603:10b6:301:4a::32) by BN6PR12MB1681.namprd12.prod.outlook.com
 (2603:10b6:405:7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Mon, 2 Dec
 2019 14:07:01 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by MWHPR1201CA0022.outlook.office365.com
 (2603:10b6:301:4a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.19 via Frontend
 Transport; Mon, 2 Dec 2019 14:07:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 2 Dec 2019 14:07:01 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 08:06:45 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Dec 2019 08:06:41 -0600
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
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 5/7] ASoC: amd: Handle ACP3x I2S-SP Interrupts.
Date:   Mon, 2 Dec 2019 19:34:39 +0530
Message-ID: <1575295481-9076-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575295481-9076-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1575295481-9076-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(428003)(199004)(189003)(81156014)(81166006)(8936002)(54906003)(50226002)(356004)(8676002)(7416002)(305945005)(4326008)(109986005)(2906002)(478600001)(47776003)(26005)(316002)(2616005)(36756003)(16586007)(11346002)(426003)(446003)(186003)(53416004)(336012)(51416003)(76176011)(7696005)(86362001)(70206006)(50466002)(48376002)(1671002)(70586007)(5660300002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1681;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf28011-9adf-42f1-33dd-08d77730e6d6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1681:
X-Microsoft-Antispam-PRVS: <BN6PR12MB168114303501B3E858EC061BE7430@BN6PR12MB1681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1/jCyKurYx66mDd519wmD2asWWKvnuj1/wzCSgUBf+C0ntNx5bYhpH194pYk99nhID0aND2EeYaEpywwKlIjRCca7TI7mRYnsHKZkF8pNmzkejRHOo5vsbElxKyBkc8SshHR5B0Gbr+wpCdhz9Xe6DPN4J1EAoJPm5ggsNYZ3WUsJx3LwrXXT8Hohnc6fi3UEA3IT1bOFkCE7b5rg84g+j3qNJVb6YhWMHCMonrm11c8zBFvAUGDeyBqFxEV84TnhfpWwCyOLU3NP4t2MYtduDvuOgAASSLGK1bKQuyviplzLBvQbEyOoZUyTZDLjSTvhvTC1KYdYC6NC4rjnfs9AWGIzJo7/2+rtzapHFvUXpXpEDwepiTRqU/26XLl+0ZGp47tT3A1x1gCINAB6ECjbKsW1abHDvUR794Pu1DcOqM3UtsbZRoZKVlB/R5zlur
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 14:07:01.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf28011-9adf-42f1-33dd-08d77730e6d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1681
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
index 14ef38e..7a107ea 100644
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

