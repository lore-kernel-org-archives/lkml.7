Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218D7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF1920885
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vUOsg+n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfKSOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:10:24 -0500
Received: from mail-eopbgr800054.outbound.protection.outlook.com ([40.107.80.54]:7074
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfKSOKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ9pgN7jOI/zYM/tfKyDmLyv2W7F9yT3C9IQIvEmVtD+H4U8wimEHiUSt4iPN/cxhn1aNyBgbdILwsYrOYnHVQAdJz9PUPR9WK3tDqk0kuK1hCAOFiwp3+po+xUmCBVSIKFPkBgQS8cPzKb99CXAhv6sJiaa5N5Wnt3/tTEFlHI+MLIYKhwylNTIVsQMLx/F1BRipY5xuDIpUGWsDqo6wOlWnCJUb5wsJ9BklWfUZxLReYYWs2YUuV/hgOAPj5flRhl8THEqPk7udkJZop46h1uEoITmVIUonfTXR5usTLFHa7HfwUnBsn5jTtNdwRkAoxGlTJyR/LH8ngSNRPqiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF3ObpMDNGS6u6mbWRwaVQmx6sADTc0lqCjP4+6OrHc=;
 b=L3WE5795oV3LAkFIsdEutpThKSOh5xuDd1b53ksKBekBW4K8YBcfo8pg9fXidVXcPsX2CojGoukkXwRUsDDqo4B2xSSN4KQMnXfimesSEgnisrf9a9JdeyYwrd2lvoiu8jnVvRQv2Xd3NhAh0bkPdrjGUWaE3LtbG2hXuquh/AeEtwQMlXeRQGVUVJBSSF3e6TSZH5PTLZTHyw4sWuU3dnmSlVGVK7TFGmyDVRqQqiL/SrNJoj4Y5x/6bKZqW+fawGWf88yiiJKce7vzmmQejJlcAgYabRfDfc4uI7vB+uSoS5KIX1KP2AP6fflCpyGkzupOKmhybPsJcn/d2QZstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF3ObpMDNGS6u6mbWRwaVQmx6sADTc0lqCjP4+6OrHc=;
 b=vUOsg+n1qycUmAvp8lyoqhh9gZYbMeoqy5J64KUDCUj3mKCcMZ3i++tzzxPDdbSDt9aZzjFzwHR1Aa/Gw18qO5CIh6smiIVAmjYbE7xJ3BUEj24ZRU1DJstWMVfsNadGusF1p9c1/yj+ToJp+08zVvl3UPGXfBqTuslYWg4xrGk=
Received: from DM3PR12CA0069.namprd12.prod.outlook.com (2603:10b6:0:57::13) by
 BN6PR12MB1330.namprd12.prod.outlook.com (2603:10b6:404:1e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 14:10:18 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by DM3PR12CA0069.outlook.office365.com
 (2603:10b6:0:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 19 Nov 2019 14:10:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 14:10:17 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 08:10:13 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 08:10:09 -0600
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
Subject: [PATCH v10 5/6] ASoC: amd: Handle ACP3x I2S-SP Interrupts.
Date:   Tue, 19 Nov 2019 19:38:27 +0530
Message-ID: <1574172508-26546-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574172508-26546-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574172508-26546-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(428003)(199004)(189003)(54906003)(316002)(109986005)(16586007)(4326008)(2906002)(5660300002)(478600001)(70586007)(70206006)(47776003)(50466002)(305945005)(86362001)(26005)(336012)(426003)(186003)(6666004)(126002)(486006)(11346002)(1671002)(2616005)(446003)(476003)(48376002)(36756003)(356004)(50226002)(76176011)(8936002)(8676002)(81166006)(81156014)(7696005)(51416003)(53416004)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1330;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e87ae94a-fdad-4da2-5bac-08d76cfa3494
X-MS-TrafficTypeDiagnostic: BN6PR12MB1330:|BN6PR12MB1330:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1330BFA59FED0ADA36EBAFFAE74C0@BN6PR12MB1330.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 022649CC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6+yIAZQ3Mlca44hC83DqSjJXILXGHY6FoaVN6cOis74vF4ix683G6cYfOi1i7WcIKw3F+e8IFQoxQXkeTVX2HZTnPyB3u2XfZVzDh4rjJ4FKSxjppYNqb1E+Kyhse2DLMCyJlCigIYGdOpa3vSYqpyOqjrc1XsZjaC1QhPzL5dv4u0F966hUQhRr4gv7nSkBiURlyiCWd4W87mO4swSORRViBZngdSza14x+UNMiP1uTujfJ7Xy7EMcPyYecooFDxWMI783o4rWhVYtLQs0f20V6Ch69/kl0IeN02VhQL0hGsYKugldQB3IYfTJgQhacwBdRIxeXeSNQVTT//+dp13iqoyKjvuE83VyAQID5u/FKcPlh7XSbNJv28PvEP7g5/itA89YiVjYwTsl7kYFNQ+PhuQZiNvJLi5CibZhQTCtQOP27Gr5yZKdp5Pd2bsW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 14:10:17.5135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87ae94a-fdad-4da2-5bac-08d76cfa3494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
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

