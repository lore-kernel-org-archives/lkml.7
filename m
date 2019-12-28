Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53788C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF6E21582
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AQgtSQ3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL1NnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 08:43:24 -0500
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:21161
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfL1NnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 08:43:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAOYMSU/O1CD1OuiPnQA7KoFaT+ZwlILbWXmPumY9fOiPk+1AJWqfQBaoEXEH2Dhg7+EB6q64SceR/t6M6XPgEYy333wKQHIEc51VrqOvT5m1hEP2M/NbKYXlf5D217+mjb7PV0lSmCJz2Z/Cgpp9DMAOEe9kE9RQoEwjLhKyVcofGd6vTryDsnJQZY6Mt2naPUne8FZZ0FPhcJBIZVcAYGzG/saIDX7OXKgYFNKynMcXkoaKqyM5rcnYFrKsHECCP+p9oQbd0uW9I2a4FYKgSaJrejZ6ukk9t+62ZiaidcBYCIKxmkKIz2gL+CLCW1qqeJpGxQ+AumGNPY/Jxxsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs1iC6WkRXnElFVdHO5iHBOqfRvBCxLOuccgTbnC/oU=;
 b=NAr7XKotT9nrsLjkRmFZh4AniqXJ21oh1ZEfiitI4oDFLeEG/YRwIPMX7GJxIKJJKGUkvHS0jC3kvH3CL2wThbLw30wf9kHFsqnvwIbNyV8uCzzaYLSdeTD2V1+hVnPA77TueH4eF3JWAWwc+Q4WOj2DmFLDAlKe49BYNJPfHF0gmp83jfSp8t8Eni4Z2E0cT97dvct2TyGwD9fR4lSe/UnZavB5GJHvTj/xgnEIxfmtv1P0WN9M34FbHJaoiYzxGTMwh0npFN7nkM0IyQer2X8JJ/RtzN+Agsl6JQf2+6kjLEeM87ONsRqY9JfV4/o8IUlP3wwsRAmI4q1hHztHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs1iC6WkRXnElFVdHO5iHBOqfRvBCxLOuccgTbnC/oU=;
 b=AQgtSQ3II7Cesr3n2SZQLVY3I7G+U6GdchjmJefxkLUEqydElTDdX50FRjmrqwDAHP0+KmIDNa6Az8JYZT75SFvsdw8OC+Bch2J2CMa07qNBHzubaMd0MoBcDnaYnqYTdALhFj/EAXMjJZlVFgpqzxNeDCDJBPCoWS3Or+NxXPs=
Received: from MWHPR12CA0054.namprd12.prod.outlook.com (2603:10b6:300:103::16)
 by BN7PR12MB2769.namprd12.prod.outlook.com (2603:10b6:408:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Sat, 28 Dec
 2019 13:43:18 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::204) by MWHPR12CA0054.outlook.office365.com
 (2603:10b6:300:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Sat, 28 Dec 2019 13:43:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2581.11 via Frontend Transport; Sat, 28 Dec 2019 13:43:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 28 Dec
 2019 07:43:17 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 28 Dec
 2019 07:43:17 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sat, 28 Dec 2019 07:43:13 -0600
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
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Colin Ian King <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] ASoC: amd MMAP_INTERLEAVED Support
Date:   Sat, 28 Dec 2019 19:11:00 +0530
Message-ID: <1577540460-21438-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577540460-21438-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1577540460-21438-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(428003)(199004)(189003)(86362001)(2616005)(54906003)(70586007)(356004)(2906002)(36756003)(316002)(426003)(70206006)(6666004)(478600001)(336012)(81156014)(186003)(8936002)(8676002)(109986005)(7696005)(4326008)(5660300002)(26005)(81166006)(7416002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2769;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce36e64-1915-44d1-2e6a-08d78b9be573
X-MS-TrafficTypeDiagnostic: BN7PR12MB2769:|BN7PR12MB2769:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2769E1CDDAD257E42C4D42D6E7250@BN7PR12MB2769.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02652BD10A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZbX5p4uvpOcJ7fVFJBu3snCp0avmkGblr4dMh5ONBqZRfhbiU1EGb15p8HaFJzig5HZpxSvCpvu7vLOHcp/83nPMvcui9aT8nFKOjwmHT8Wx0tk50SPC/S/qXeYguG2VXHlKyf5ViTFG4P/E6VxUWALGpuNrLmqz4eccMlsM7d91hoAybseBVFndcrYTRnEhjo+SNv4xa+oPL5Oh6YFbDSHF954ow+n7Ez7ZBCwUeJtXCVge8JEtJWwaFhAKQhZ62CkWQYfBySusIKFRkCNib/s2QDGFe+ydIeGsiXL3wZYSjbCWVsFOspt3znExdoeiL8aKgnCgBP3ZRj80IuwGAtnIq1zLeXzOmfMG6NQvYGGYb2E/m4PGmM9P2deFFvTI6UaV+/11BUSILg6O5dOHwa0JVbHnXuCh0aNIGHCnVDNMS9a4hifr/zgZdzQJLlbMuDHziycnz8uaH/zcS6LBAa4C0y0ZkbqxuPvm4C/rIw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2019 13:43:18.1516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce36e64-1915-44d1-2e6a-08d78b9be573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2769
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP-I2S device support MMAP_INTERLEAVED.
Added support for the same.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 151daa9..5c3ec3c 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -21,6 +21,7 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_BATCH |
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
 		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE |
@@ -41,7 +42,8 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_capture = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_BATCH |
-	    SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
 		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE |
 		   SNDRV_PCM_FMTBIT_S32_LE,
-- 
2.7.4

