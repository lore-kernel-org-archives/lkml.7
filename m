Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0EAC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242A621582
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lPh+dTpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfL1Nnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 08:43:45 -0500
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:47086
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfL1Nno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 08:43:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdsUt2apUTgadcm0J/2OkWAuHac0Q+DHsOKv+OFTa/8rQV4BEA/42I3FpN2TsFCI1EayTLRwQTNhZMuJWMApBsGB/ofCoks0K66O0Z29JGU20Shq2PDZ/1xggs13O11EjeG6tQtcsVNwNMrAX9FG5jyvTiPBaN/c0zIdnm4fR+fB6BVsjy5Hz03OLcHIWP6e3qkjzfIIDFfHsP4D4fosqBfok8jRa+MhkS882q10fXza2+0cexfkNIN1GvwkRLlSKg9TkU8U5IEwTulHI7HtHB0pUlP5/iTF+XAHSE/4NueszYOSqoqcSb2AXmvxawj7VFfiOOBDFGlTmqtt78PPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuzCJZJNmVlMQ8/cfRcF2fmbV8mN35DHmx/giFla0hE=;
 b=HSTghtgawy6SkS6xuHFwjKcwnb5LbgGNyVib71VRO6iTCqQK9O8lvHA07aCiRCcnM0OcE5C/0rzUEnJOjmUjHy0g9aAHRnyeolthNSiTB179OWeZE/ge/lgdGoO9JdN2cq2vQ3gM/zn01CEeeVwkfDEzBS/LrBH9BzMGUFAB6YfC+dw1+1NpNZIkFni+N4GzNkbxH1VXrddmf0NoN9jZ7HSbH6fioYgBLQORs/H2P5Nt4I4Fi/lTRERlcP1lOOIvO4X6tiyY378n5dpo/KBWlXfGgtwSfd9QHvzDUecq0YsHBWsYOTRQMBYZCSY9nHkOj2FLWiz1gDq9GLME8CCayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuzCJZJNmVlMQ8/cfRcF2fmbV8mN35DHmx/giFla0hE=;
 b=lPh+dTpWZqvMQcbcekaSKXGWItJUeLUTi0pxRmLBVSvS9AjP5dLB8Vi1o/b+tou2ZejQltIaB3rMOqKDdvqFmUhEJ5CalzuEtO7ArQll4zyEwwWDVwdaHUDdPb88b+EKf06G1qiLfUu31yjlsnhZZbGDlfGKp/rMnC8rPnugBBg=
Received: from DM3PR12CA0079.namprd12.prod.outlook.com (2603:10b6:0:57::23) by
 MWHPR12MB1742.namprd12.prod.outlook.com (2603:10b6:300:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Sat, 28 Dec
 2019 13:43:01 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM3PR12CA0079.outlook.office365.com
 (2603:10b6:0:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Sat, 28 Dec 2019 13:43:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2581.11 via Frontend Transport; Sat, 28 Dec 2019 13:43:00 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 28 Dec
 2019 07:43:00 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sat, 28 Dec 2019 07:42:57 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <broonie@kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] ASoC: amd: add ACP3x TDM mode support
Date:   Sat, 28 Dec 2019 19:10:57 +0530
Message-ID: <1577540460-21438-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577540460-21438-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1577540460-21438-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(428003)(199004)(189003)(26005)(186003)(86362001)(7696005)(109986005)(4326008)(478600001)(5660300002)(2616005)(356004)(316002)(8936002)(426003)(54906003)(81156014)(36756003)(81166006)(2906002)(70586007)(70206006)(336012)(8676002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1742;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff56205f-6b31-43b1-3672-08d78b9bdb32
X-MS-TrafficTypeDiagnostic: MWHPR12MB1742:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1742A5374FE8D82DE9D483FCE7250@MWHPR12MB1742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 02652BD10A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zuBlnfltCYAknynHYNQqiLdmLS3tukqgbIWOBC3W5/5Ty2a5CkRxIZJXm/OPjz0zfPnEYNwozthbCmiQ9IER3Dr16fPlado6r9iLOUwn8JQobcn/K7UYZHXN957We1pHP/+Ro1/VsHtA7JR4Y+KzCsHjPN8ia4bpIJ+9kDTxCs8XL4LTT9G1T7FY8ozuScO3yTL1Okyj4uBGPxx7ECuvk1oob6jW/eScbS7M0q7Po3Ak2SyvDKZ4gUtG5KAWDa63kZf0WnAqeQ3yAeGmfXLHh7QS0mDUgWzRnYEW446OhtoGpam9fERYji8BKyAiXuQiPVWFgEjUP1EwmjlkyqAqQ7n3T6vr5R2ocVM1oQsvwC3LNmjNUHJRxUf96FV20059BCJpBz7PBPBus1PudMZ3R4gau9P6OG8tUKb/u6STe/P4o4MfUlAvgQbT72RXrdtaIavgw6z9CTvc1O/kw8oejDAn65glW0yRpRw0Y0BVI1JTmAnYQ9ZSTIYYgbLBvqO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2019 13:43:00.9066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff56205f-6b31-43b1-3672-08d78b9bdb32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1742
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 28 ++++++++++++++++++++++------
 sound/soc/amd/raven/acp3x.h     |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 368e4c85..d9b287b 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -42,7 +42,7 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 		u32 tx_mask, u32 rx_mask, int slots, int slot_width)
 {
 	struct i2s_dev_data *adata;
-	u32 val, reg_val, frmt_val, frm_len;
+	u32 val, reg_val, frmt_reg, frm_len;
 	u16 slot_len;
 
 	adata = snd_soc_dai_get_drvdata(cpu_dai);
@@ -69,15 +69,31 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 
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
-	rv_writel(frm_len, adata->acp3x_base + frmt_val);
+	rv_writel(frm_len, adata->acp3x_base + frmt_reg);
 	adata->tdm_fmt = frm_len;
 	return 0;
 }
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index a1cdc4e..43213ae 100644
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

