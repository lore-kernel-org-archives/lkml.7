Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F01C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C886206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xfag+hcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfG2MPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:15:18 -0400
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:40654
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbfG2MPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:15:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U96lCyEQ0s+/Sg5KLeINhKlSa54+I39lKQXMqGw7LUs0qZqT1009RTSR3dlUtfDbVDb5WbFXmSJrd/2jFG5OQVu3Ctw8PY9SAKmbSPK2Kk8Nk/7ZiNKfUHmwmii4C9yMCFxapbSi4BmnKbstjsljEG6130+b+pTpz6KUzdS2fvxLCFhuiYpCU7hPw/qymzms2li0vlYn5lsSoxbSR5xLwHVQ23XhI/CFMs9+Zy6hRyT//gqkQZdgkd06i+vVDCIgr8wY8jCLUsmJJtFesebXdHWE3rBfUQau64sI5gt3sBkIWjowQWAB2cbYL1QcHEpy51Nd8Rqxdix8bChQ/yADGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fz4utKxUE7fldrbZ2bvj3Cc8O6BbWVdybm87o97p0c=;
 b=XK451W0Yru3YdXXRQZARlEFOtZ3XYZ8Xbx4QEZFDiN+WJgkG172r+OkflGRBEYy3y0giokVssLqies+tBn84/vVeHO5Kayzq+XX2tsN9E03dJUho1Ot3RKkwsHVu3USkOLkjZuy+cdFiE8V6V+LsZilB7hTY5rd7Gt9ntE6u7X7hGl4y6wvhrlcBEpk2c1zp+RxM/D1X8bm7XCcnVJEYb5wxv96A+xBsvnzKoagn6u85lBE6Kw0GSeNIggezILHnJ7g0Bg/CE2rhjf0Zu++mKywmECFG5gJ76pi/TJOZFP7GO4piSVkBOAK8ayTUfr0LOL/1bAeuAcMfPZMuJX9MQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=amd.com;dmarc=permerror action=none
 header.from=amd.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fz4utKxUE7fldrbZ2bvj3Cc8O6BbWVdybm87o97p0c=;
 b=xfag+hcz6HIKQKRKU18EXrtNl92vkLOA9UAbGV/3RMeYxsNcgW1V+w46Txy7rl8solEGsCkw5I4sdYd72IULQ/ag3cgpmt9IHmnNQO9N2cWpOm4RvNE0jwQoza8sc81Ac2x4+A6qbRS4aPFJgcHXk2FWPfHfkNBB8xuQuA+3/ak=
Received: from DM6PR12CA0026.namprd12.prod.outlook.com (2603:10b6:5:1c0::39)
 by MW2PR12MB2426.namprd12.prod.outlook.com (2603:10b6:907:8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Mon, 29 Jul
 2019 12:15:15 +0000
Received: from DM3NAM03FT035.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by DM6PR12CA0026.outlook.office365.com
 (2603:10b6:5:1c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.15 via Frontend
 Transport; Mon, 29 Jul 2019 12:15:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT035.mail.protection.outlook.com (10.152.82.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Mon, 29 Jul 2019 12:15:14 +0000
Received: from vishnu-All-Series.amd.com (10.34.1.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Mon, 29 Jul 2019
 07:15:13 -0500
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
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC : amd: reduced period size
Date:   Mon, 29 Jul 2019 17:38:31 +0530
Message-ID: <1564402115-5043-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(428003)(189003)(199004)(86362001)(8676002)(446003)(476003)(11346002)(126002)(316002)(16586007)(54906003)(2616005)(426003)(478600001)(70206006)(6666004)(356004)(70586007)(336012)(5660300002)(36756003)(53416004)(81166006)(81156014)(109986005)(305945005)(50226002)(50466002)(48376002)(4326008)(8936002)(486006)(68736007)(2906002)(53936002)(47776003)(186003)(7696005)(51416003)(1671002)(76176011)(26005)(266003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2426;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e3deac-f884-4931-282b-08d7141e6989
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:MW2PR12MB2426;
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2426086EEEDB13D7806D5000E7DD0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 01136D2D90
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: V+70G1wmObDP1XtV2jPbXEssiLYblU4iJQVG45Rli+GC+hJT4LMpFb4u42i5Ws63kec16VG/r1d1o0kuddXAbYHgv5fdNHa8MI8iffFmttlJGYYKkHwocPBX9XW9kN2WiKN0900YoW3//vD3lGh+jmblcPTrT0TXtKtjP0mGrTrL8zZ4BGc8cNUNgmut5XLYkGhzvIt6rm9NorCY24y+zAEroYmuMqN8H30h2TphZMAntpxjzMBJNRQ4LKrtYppsHrbvirST5UcRCaf6VwzS/T5EMIieJwppgUl9Xw7/W0k+VB2yJmgmLyB4m9oG7TkyHZ+haKASxgZC+pC65CBlcHmP4TkMj5PgIgx3kvpPcbq8o41TMzy4+ke2lu7X80CkSxlPWn5DmENrN6QnvbQT4eJs7AqFFum2zbUOffoGYVo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2019 12:15:14.5512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e3deac-f884-4931-282b-08d7141e6989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduced period size and offsets.

Signed-off-by:Ravulapati, Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 4f2cadd..033e2a9 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -23,17 +23,17 @@
 #define ACP_SRAM_PTE_OFFSET	0x02050000
 #define PAGE_SIZE_4K_ENABLE 0x2
 #define MEM_WINDOW_START	0x4000000
-#define PLAYBACK_FIFO_ADDR_OFFSET 0x400
-#define CAPTURE_FIFO_ADDR_OFFSET  0x500
+#define PLAYBACK_FIFO_ADDR_OFFSET 0x00
+#define CAPTURE_FIFO_ADDR_OFFSET  0x04
 
 #define PLAYBACK_MIN_NUM_PERIODS    2
 #define PLAYBACK_MAX_NUM_PERIODS    8
-#define PLAYBACK_MAX_PERIOD_SIZE    16384
-#define PLAYBACK_MIN_PERIOD_SIZE    4096
+#define PLAYBACK_MAX_PERIOD_SIZE    8192
+#define PLAYBACK_MIN_PERIOD_SIZE    1024
 #define CAPTURE_MIN_NUM_PERIODS     2
 #define CAPTURE_MAX_NUM_PERIODS     8
-#define CAPTURE_MAX_PERIOD_SIZE     16384
-#define CAPTURE_MIN_PERIOD_SIZE     4096
+#define CAPTURE_MAX_PERIOD_SIZE     8192
+#define CAPTURE_MIN_PERIOD_SIZE     1024
 
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
-- 
2.7.4

