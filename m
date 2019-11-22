Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99451C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C0B20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4PV7O2xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfKVJqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:46:13 -0500
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:37694
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbfKVJqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/zkyiPffchDQqZTdRX3qsAGiTDiVFdd8Hntb+h0G5xt6SD3scRZmnSwKrkG3HLt5rqmyEEHM6KNUFYW8ZZFxwRFloD0RptSoa3YCJ2LXeIe9frgkEhN3LlMvHum8S6+KKN//pmgr6dHzlHaqYgVnoZjsJdk0UlKmWE9YAP03Ob5LXkMS7TMDp/eLYXE/DXM5Ju26SnQaYFdfmWRlGSpj3gesgrqir4VLDvlOGVSiykxxo09OHqU+dyZE8T4XK5SKop9+4TJZfE/sef1ndaBzo2FTR3Ce0YOGpaM7uKMzl9wyv3r24FiwNd3UqUCz+9caRPdvrYOPyLKW9aGTbiCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn47bwPpuwfRtPF1wOQvW1Z98oETzTmK8xV3skX2Q38=;
 b=kC8LbPauP1isq50uogbW+XPpuAX3jcG0spqzP+XiLRkXpa0TJpjTPV3wFIEjaQtqz3huRGeEiWDZY7xgLYmYl4/Lr4Y8x6mzrlTlwnVzZCMANnQ3ls4HrgqEUXGjDBdfJlGtXEdkb54RU3ADiOu0ojf3T8mo+tC1enO/zdFPKRyeBIthFVlc1Z1BiIREtIAhLEZH0h0PoTwDbVGm3OtbZ29UoH9uRq5anmYEUJCGN4O+Y9b7DZdbhsxkCI8PM/+sDJzIKGCK6GquowdziZCsp+rYVL9M5VyCZS8r6RH5ubd1Ig1kuiqL1LlSqC8JsaFYMjhu++RLY2Be+WqqRdMwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn47bwPpuwfRtPF1wOQvW1Z98oETzTmK8xV3skX2Q38=;
 b=4PV7O2xIC1Is3kHeeciSccWchYQndaUtLLcPNdLeqnYjVmkGSFBYO/FCz36o3ua1RDV/fT/b7ERv44BAKALj6BsXOocECa/s4G6yraiCvz2Ai6pLRQhEJ8TQS0ka1/4AAmPiUUWwSG7Q/fViec7cNWKnjmo+YBN508bXtyuH48Q=
Received: from MWHPR12CA0039.namprd12.prod.outlook.com (2603:10b6:301:2::25)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Fri, 22 Nov
 2019 09:46:07 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by MWHPR12CA0039.outlook.office365.com
 (2603:10b6:301:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.16 via Frontend
 Transport; Fri, 22 Nov 2019 09:46:07 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 22 Nov 2019 09:46:06 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 22 Nov
 2019 03:46:06 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 03:46:03 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>, <Akshu.Agrawal@amd.com>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v12 4/6] ASoC: amd: add ACP3x TDM mode support
Date:   Fri, 22 Nov 2019 15:14:24 +0530
Message-ID: <1574415866-29715-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574415866-29715-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574415866-29715-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(428003)(189003)(199004)(109986005)(1671002)(48376002)(47776003)(7696005)(76176011)(2616005)(446003)(426003)(26005)(186003)(50466002)(86362001)(11346002)(51416003)(336012)(36756003)(2906002)(4326008)(70206006)(305945005)(316002)(16586007)(70586007)(54906003)(53416004)(50226002)(356004)(6666004)(478600001)(8936002)(81166006)(8676002)(81156014)(5660300002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2397;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae62920f-c2d8-42ec-3a9f-08d76f30cc17
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2397E6BFA143E96BE607F687E7490@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmtirQw6YzxkqW5rW3rVc0c7snPJz9+NjStA66TflbcK38zZsqJ++ftdatJGW0aqFS7L+KS/WhSWgLrrj+ZW8NiUd2gWZZO8lqHzz1q1bv/FSUItrDEo53PoMi7Rz3leYE4qgVV7RntzeoVRD3mNsHwHcCY5RgTdA8gEI5MUSd0Bhvv7eQ6tXipoZaykAbEiOEVAJYFlhjYArwK4oMTZdHHJT6Q9Kpz8H9Iy1JdIHsZZSgqHIFhsk/e9WRe+EcuWVZbNGBKXq4T4/TalHmdyqa7LTX5odJDp23/YAfxOVj8z6+C2NsEgA836BLnUafw5FyhwIeM/g9yPt6lqe2RYzSrhL8fg1ASjFbInRpgUwglDGdH11oxSuDv11sx0ws6pJacDvqOJ7XLIsAj73Gi0yosxJRXkTassSjnu3aPIfLegzUrhxLtznEYvkXmxBT8M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 09:46:06.8981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae62920f-c2d8-42ec-3a9f-08d76f30cc17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 24 ++++++++++++++++++++----
 sound/soc/amd/raven/acp3x.h     |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 7f05782..cea7311 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -70,11 +70,27 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 
 	frm_len = FRM_LEN | (slots << 15) | (slot_len << 18);
 	if (adata->substream_type == SNDRV_PCM_STREAM_PLAYBACK) {
-		reg_val = mmACP_BTTDM_ITER;
-		frmt_val = mmACP_BTTDM_TXFRMT;
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			reg_val = mmACP_BTTDM_ITER;
+			frmt_reg = mmACP_BTTDM_TXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = mmACP_I2STDM_ITER;
+			frmt_reg = mmACP_I2STDM_TXFRMT;
+		}
 	} else {
-		reg_val = mmACP_BTTDM_IRER;
-		frmt_val = mmACP_BTTDM_RXFRMT;
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			reg_val = mmACP_BTTDM_IRER;
+			frmt_reg = mmACP_BTTDM_RXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = mmACP_I2STDM_IRER;
+			frmt_reg = mmACP_I2STDM_RXFRMT;
+		}
 	}
 	val = rv_readl(adata->acp3x_base + reg_val);
 	rv_writel(val | 0x2, adata->acp3x_base + reg_val);
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index ed1acbc..3c28644 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -78,6 +78,7 @@ struct acp3x_platform_info {
 struct i2s_dev_data {
 	bool tdm_mode;
 	unsigned int i2s_irq;
+	u16 i2s_instance;
 	u32 tdm_fmt;
 	u32 substream_type;
 	void __iomem *acp3x_base;
-- 
2.7.4

