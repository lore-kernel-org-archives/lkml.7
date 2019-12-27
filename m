Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C94FC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C0821582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jldZ5Jie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfL0MxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:53:20 -0500
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:39361
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbfL0MxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:53:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyqN91V/1tuRo7chKLOlaPKMDNv5nRJtLd/nigP9QK+2P3rORHZtddrYp4CSY8Zn0fzv5GJRsl0RQoCVnDnZkRZWNFr6uAWozRojSiEVkZCAJdyfwxtIVwp+a3FMWXhMBpI2z7/Utm5gbc34G+Z70s9gWOwrJEV6aZHWZOf2yGcn6r3Gio1qJ6YL7gouFklNCrJffJSndmp/PGKmosXditjKfBiLDvCAsXkT+AReZekY/aJ1jb1D9GFbsrWH+QwHLCu/j3ZHb69eVoroWisQHo0PAwYL6oc6l4l4d1ysX1TdseXRJl6kL2QVpvh1b89IXF/3IOG5uJmMfGhPubRpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECbNNe8aGwdPyr+kto+NO+P5cLl0vqt8HRyLjuAv2I8=;
 b=kAVDxIiecW/gq+/UAO5vWfUaBcUD9V0fa+fRSKVvQ+qRipgmXXluqa3yv20EZu7tXGVu5POJv7d7RsoWQOkaAHWichWpsOfKRh/7gSpTF5GzpUtW8i6OulqiuxV3OKgKoROXmUW3R5eM05xYo654PG0QCZ9rDCjqNIQbdUAkA2dJeQxk7vO9V/QS91zDpNvvTlk28mFH1YwPDVAeYuBtXHbaCarhDKB/iM9IuD7QiY5j66O8rIr8tTLePef2hm+pG1BUDCmnsb5IdQLLmp0dF6/E4+JIJtaPjv+YfGGG51xL9TxpL6HwNZJ+LX0OCM7+qRbVs4NpO/E7TKYTr1jaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECbNNe8aGwdPyr+kto+NO+P5cLl0vqt8HRyLjuAv2I8=;
 b=jldZ5JieD2qCuVc4rIFIZZO7/UctYrDfZ/GusWBKjvnBy9cAXm1an3vfn3lzuN/f7RqnqGCI8rnsvi+rHFF5WwKyy58Bny97V6E6qzaSbwFv+Ay3Qx9GmEu69s0mu3mfD4/sFtK5SfZMTbCLAVhDzcje/4SN+yoTj86H4jQZ5hs=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Fri, 27 Dec
 2019 12:53:16 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Fri, 27 Dec 2019 12:53:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 12:53:15 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 27 Dec
 2019 06:53:15 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 27 Dec 2019 06:53:11 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] ASoC: amd: Handle ACP3x I2S-SP Interrupts.
Date:   Fri, 27 Dec 2019 18:20:53 +0530
Message-ID: <1577451055-9182-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577451055-9182-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1577451055-9182-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(428003)(199004)(189003)(5660300002)(81166006)(81156014)(8676002)(70586007)(70206006)(86362001)(6666004)(109986005)(356004)(7416002)(426003)(186003)(336012)(316002)(2616005)(4326008)(54906003)(2906002)(8936002)(36756003)(478600001)(26005)(7696005)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3402;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3baedc4-3790-4e68-3ec0-08d78acbbda4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3402DE3E9A27D9F6B0012A37E72A0@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0264FEA5C3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2U90hVohUFqeFALDbY/747i8aTrgzgCRemiN1MgdnqbhEoYFeolU+t5MOgfB7iWv7hiRiprbt9VZPQQtcgwoiL3Zw5lOCsboDr7yCIwN5Gr7ymuO2juFK6/3PqtUbi79Cpk4b504sI6Jbz8f6Q0ZFPN/nOY2zlio7KhG/FmI31CuIWAwBlIgoqBDIPMa1bhPx85ugjx30wZjtUpsGci/Pu4u1OMbc4mXaVGB2KyfnC5wBH5gPLOp0v7khJYrqjdjlOBB3Dw1X3IDD+IOHja7HFXo9D1+l95gf97mKo3Bb06p8UKcwD2tjRfDtEnvwwT13EXSoUWstx6p98O+hzm0jthe8nF9tfkJ6DwWhmChwTw6x6OdW8/Ql+TVdAJi0zM5udSmzlwtKK/AGSLMcL6Uf4YJBeDFVqI0jbaltQ0EAuKCbfk7zOOuku/qBFl1t7fF8MWbNIp2dLpFhMNtyTVoJY3cZlgUOboHjjtWPZdJGo2q+xnlgvGVObLcLaTU/U9Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2019 12:53:15.9235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3baedc4-3790-4e68-3ec0-08d78acbbda4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
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
index b67aea3..1bd4f76 100644
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

