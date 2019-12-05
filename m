Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33642C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30282464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EAE7jsls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfLENkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:40:02 -0500
Received: from mail-eopbgr700079.outbound.protection.outlook.com ([40.107.70.79]:2685
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729587AbfLENj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:39:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGHBsjytAyCY0H4CZ3lXzq0E26HgrpAlA05e1AGzUv6N4DCK7PlS+A8nOxn4xTaKz6CTAmo6jP9vDABDWCvUeS3GD3Ff/gXqftwYnu8J2hSU3N6EZwBaNYs4zkMcSrWPWK+o/wAb5exA/XiKSmTKjjVfVb78qFOX96DokrWvQdDB91ONRnNL3ll/9+2Ndpqw/0vsdIn98FLg1KexO+zJ3QMyj9OkDxGHnQTK/uP+rvWvjEd/TR8ipK6K3V+b671MyV5bRTv6WqpQj9e1cRVHXlNmhsa6ZWAIlbP6mc9xebmCXghR53IVfTafOfrDOxdyIf/youQTB4tKovD70C14GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw05veT0wqXG28Anw+RY+7stHA6/u8CQER6EsH70v+Y=;
 b=DWXE6dZeF0lyemfwkPwe0ETNmNgT+Hk5VMog+P9Ea1G3/JGccQ4pHi+hv3PNv8S37q6WawahGIDxLbhXvuMWRmsiZ4dPIYs5s8rAdWIdzNfsAcP7nFVKxuWY/+6Z5tTQhMh3Oa/yvghN0ldS2Ro8gVkUrYOBWiyNVD4kFA9BgBjRf4z9w0vKSDPFOQOFFE5wMrfIL3EY4PuEOdM2VsQEJCW7cqwut0/uY9A0ZHo+UpL2L8rEfnHn5UffMa/HoFa8LvvTFkIy8b95xmS2OoL2xbhVOvxs8NMOxp3o2XEl9lO6vD0JWkXlbDyjqUXcgErxM+qeKqEFePu7oVTkvaOh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw05veT0wqXG28Anw+RY+7stHA6/u8CQER6EsH70v+Y=;
 b=EAE7jslsPAWja70EwFjdwofSAumqqXNHvhM6MstOBcqrY+q93lPACJrZrvMguSpCxj+xBjDxrBVGTxLxFnPGzqiiz7B35HIUESsWVshVNhtFRq+7klSN8HevCXJDN/PWicPAijK4sYz/iVksK3pHOpm4LTf/ji5EHZ30JWbA4oE=
Received: from DM5PR12CA0005.namprd12.prod.outlook.com (2603:10b6:4:1::15) by
 CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Thu, 5 Dec 2019 13:39:56 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by DM5PR12CA0005.outlook.office365.com
 (2603:10b6:4:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 13:39:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 5 Dec 2019 13:39:56 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Dec 2019
 07:39:54 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 5 Dec 2019 07:39:50 -0600
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
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 7/7] ASoC: amd MMAP_INTERLEAVED Support
Date:   Thu, 5 Dec 2019 19:07:32 +0530
Message-ID: <1575553053-18344-8-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575553053-18344-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1575553053-18344-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(428003)(189003)(199004)(7416002)(81166006)(2616005)(336012)(70206006)(53416004)(4326008)(76176011)(48376002)(11346002)(478600001)(109986005)(26005)(426003)(54906003)(8936002)(36756003)(186003)(16586007)(14444005)(81156014)(8676002)(86362001)(50466002)(70586007)(51416003)(316002)(6666004)(5660300002)(2906002)(50226002)(7696005)(356004)(305945005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1463;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb034cc-00e5-443b-7eaf-08d779889dab
X-MS-TrafficTypeDiagnostic: CY4PR12MB1463:|CY4PR12MB1463:
X-Microsoft-Antispam-PRVS: <CY4PR12MB146377695A76B3D23A65BF88E75C0@CY4PR12MB1463.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypCJE6abawcS41XOMDw1hkkrudAtq/bJYWyviqIGLlWk1j2Lp/OYh/WV5b7bFRZnqjb5bfCOTCYmlB15cE6Qd11kmV8m2PvJRlUpKQG89aDctIZlbcUFtw8zap9oxn+ibQBlcSQEArqW1CxXUVgTra5qPdUxHjpwcO1f+9pNpDiQ5gl7JEQeZj2LSSX5dbSZqgdwVjsuSOixcRVRolyGHnGuDOn4IcA01xgYc/yuzjnnsx5Of1krIbnGTtKP93PMPbfmYbde62peYFtNEXyGbOdJ48wuiu52/hzpqMENdWjqMfUphHuugDak4jYUWd19h7mR2oAyV8qGQY3XCwUqVw27jWVt4YAXldM1InNZDWOTP1/XrK+c9kotaLCa9Y2GLSNrpXcFiz6NX+5o5KMingoBYq02aKpw/cUiQUBFkZgiuCc+L19fgmWheZKgK2Bs0E+Eu+tZkTvbAxg9Dp5FXMjZ/orazAgaUbAwhKH95oE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 13:39:56.2368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb034cc-00e5-443b-7eaf-08d779889dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1463
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
index 916f0d8..28a3081 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -22,6 +22,7 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_BATCH |
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
 		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE |
@@ -42,7 +43,8 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_capture = {
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

