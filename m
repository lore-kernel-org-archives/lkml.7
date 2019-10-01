Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99082C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6228E216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SCsjOXPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfI3OGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:06:48 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:4482
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731381AbfI3OGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkbhhxlnjv0HcXHgU5mGSuDr7QnDk+X7zwy/i0pbCp3HFArxge8DZixPAim0fziWt0BKb7gnlBDqulOyxJ38Tqb3tJpm42kxiqSVpRK1dAgfLng/pl+bmh3x3Ngrz7+cble/v2K41ANh1nsJqe6M1P0eYFIjaMxlKlxh3YApiMMn590C3DsGeCvLZAjkw0Q79RwoQYWpDD7Gr71+1esUs3jlChILoYtVBVHnbRuopFmqZi/X5kSqlcD8+s4BA9SrliVsrtZ2ki2aFcdO7RhaOq72JNMWGYrSpGOsQlAiVXXerOt5FJUDEDo4VeekcGdC4qfuSxeUk4CzuuRg1wu5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z72Gb8xh+zH2VaK2bqc1+WBNdSjmEIiqOhkNjFaB6Zk=;
 b=gUAqrS/xZz26hA/T4/NrFe4zLwtCJAo3p1JTks6gN3I970Bf5e+dqaRjkiGuUl9AWjNxszys+sQI34keBQY5VsUxQGiPKPVZvZU3lPZsihklF6a5On9RZDvNj+IL/Gz82WGTPbYyBznC6cBovBjRTMGiZ+P6YESlnbdciVPCst1kLXhu0tkl1/vF48gqsd+zsRqO9Fnige1EwjIlI/d0BbpSfPTepTDgMRGvXSF+0quLuYKdZWAr/BPsn6eOvXKAHfDhC7mKPwfTE/i1VQXT42K3WHYzA8U/m9up6PA89+uvXdAOfg0/ddIuM+REWLA40oKEJ7K9G6M70WSYMa3kQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z72Gb8xh+zH2VaK2bqc1+WBNdSjmEIiqOhkNjFaB6Zk=;
 b=SCsjOXPW2L9nNQhouBEf430p2w2WW8NgjkK9EFG8GWKhIhCHyLnHHKvGnuR5yyjMZIx/4qahVJQe+hcZ337pYN+IXKasYbyf9zjSDcAieBPahSdQLEVpyxkVrrMplgh4uycdnAusr6YKeWy+/eDYBCYLpEb3poMH4jJafTD9ehE=
Received: from SN1PR12CA0106.namprd12.prod.outlook.com (2603:10b6:802:21::41)
 by DM6PR12MB3996.namprd12.prod.outlook.com (2603:10b6:5:1cd::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Mon, 30 Sep
 2019 14:06:44 +0000
Received: from CO1NAM03FT046.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::204) by SN1PR12CA0106.outlook.office365.com
 (2603:10b6:802:21::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18 via Frontend
 Transport; Mon, 30 Sep 2019 14:06:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT046.mail.protection.outlook.com (10.152.81.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 14:06:44 +0000
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXCHOV01.amd.com (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1;
 Mon, 30 Sep 2019 09:06:38 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Maruthi Bayyavarapu" <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] ASoC: AMD: handle ACP3x i2s-sp watermark interrupt
Date:   Tue, 1 Oct 2019 06:28:14 +0530
Message-ID: <1569891524-18875-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(428003)(189003)(199004)(53416004)(336012)(426003)(4326008)(54906003)(50466002)(11346002)(446003)(70206006)(16586007)(36756003)(70586007)(2616005)(476003)(126002)(486006)(109986005)(478600001)(5660300002)(6666004)(8676002)(81156014)(81166006)(356004)(47776003)(51416003)(2906002)(305945005)(186003)(86362001)(1671002)(26005)(8936002)(50226002)(76176011)(7696005)(48376002)(316002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3996;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d9eeb4-755c-41ab-0cbc-08d745af6cc9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3996:|DM6PR12MB3996:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3996430E01A0983220E84B0DE7820@DM6PR12MB3996.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 01762B0D64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paQ45teMZu+AGLgfwsy2fikhBQz37tbRo0LzPQV5u3gIuSVOsoZP+zySWZP7glP/BuKUkyWuO7Cs3Hb14H94MMm5/5yXtQ04O6YTB4NTuOsAz4Yvmwx3tYCUaRqTeIfocy+6tzcKztQCTguh2odAjhUVOAcd4NzI8dikeDtgM3uIW9LiDoXOSVPC+gD4mkFC1grYCZ2DLlYzvgQrwI8f365rjtbpXHUoWSX6UWc0o0Ek4OFJJgxDEoxA29xavn8QezF4rhPzrURmDtE9P1iavnxcRqePdlc2Rk37EJdp/LTPWw8WDyvAyhwzYkapjAi27PUcJJI04ocAWQF9OM8sERqg39Nb7u6m/mgyZGz+glpdjbRXpCN71kYuZ2WHwidNqH3l87BpT3aNWkRkQWD8V8TJtA3lKjsZnT+5W7P+6sk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 14:06:44.1001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d9eeb4-755c-41ab-0cbc-08d745af6cc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3996
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever audio data equal to I2S-SP fifo watermark level is
produced/consumed, interrupt is generated.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 6fa892a..49f640f 100644
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

