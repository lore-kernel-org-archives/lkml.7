Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF4C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45DA2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fu9BVBau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfG2MOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:14:50 -0400
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:35744
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbfG2MOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:14:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSEIuwhusDutLGgc026ffhCMkATWTOGT1qX2HJTOCArexyDttoy9L9+XDJwqFaWxF0KOMYH/6/8/CHm0Oi5wJ5//Dm6kQKZsZUdAXWdoiE/gfK5sMSF/2orYIE7/CGSSfeh6uGFrGqcdP70qHW1fAhM50xGwtTPY1kNXL9We/YxAp1Y7zpnnqRnmO/g+h0TaEQScKWzKKFimtGgbRfOGjHkA3a7UoH7Qpi5IXKmpDBwlLBQfOaMhe/uGVdI6CRwG6TZck04s4D0Xms8VEbz2ix7eM4SY67a7FXjGhNC82Fk1jn3HlFQBgzB7I6kNhMg74A8M2d5hdlk6lXCXIK+4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt2Z7zJ7v8ihvP1FrZ8G/yzCqlFzNhXpQffDP2sPaLg=;
 b=iZzNcCG86WMldzfd7/aQkPcHZYkpmGBn3wudX9ulUet68zdxPJauYUqucVzpXajUZ/nN9CTcDiFeXZ8nwBojPT47RzD9uUhYIZaUUYp5JA4GcVDW/qZ1uw4ZwX5s4jKGLktqoGPC+S718voyPgramSsWRKdZFLsa11ax1XqJ2jT732yGpu6O1sByJ98CikmJE3YReDDWjvOLgBqF4CN6bznJI1Df+pOWc+iJy96ke2tz8INndDKtSZsTQjHWEiFmGPKBYn92asNSQn3YTB/dIMnPXRuVyuqNnHM+nkHlJCj31nFEpZ6P1SYvXW+9xVcSZkDo2qTfhs7sAwcaXp5fGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com
 smtp.mailfrom=amd.com;dmarc=permerror action=none
 header.from=amd.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt2Z7zJ7v8ihvP1FrZ8G/yzCqlFzNhXpQffDP2sPaLg=;
 b=fu9BVBauQBH3AENk526qZECivetZ3IQsQ+7GwjVp2xfqOsfBrRkoT1JzhsC6ZUlC0tLQqHPqBvK95bDK2c3imBp3+x8v2yf+SZ4BCVCwTCf4sa7gIHR2otfyb7WjmDoKjKri1xepBvg96yRwzd6gtO3quPqvLHGjSjbahDhgd1w=
Received: from SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:18a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.13; Mon, 29 Jul
 2019 12:14:47 +0000
Received: from DM3NAM03FT010.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by SN1PR12CA0097.outlook.office365.com
 (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2094.16 via Frontend
 Transport; Mon, 29 Jul 2019 12:14:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT010.mail.protection.outlook.com (10.152.82.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Mon, 29 Jul 2019 12:14:46 +0000
Received: from vishnu-All-Series.amd.com (10.34.1.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Mon, 29 Jul 2019
 07:14:42 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Maruthi Bayyavarapu" <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: amd: use DMA addr rather than CPU pa for audio buffer
Date:   Mon, 29 Jul 2019 17:38:29 +0530
Message-ID: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(428003)(189003)(199004)(356004)(6666004)(305945005)(70206006)(1671002)(70586007)(50466002)(48376002)(316002)(53416004)(47776003)(4326008)(126002)(54906003)(51416003)(2616005)(7696005)(68736007)(50226002)(36756003)(81156014)(53936002)(486006)(8676002)(8936002)(16586007)(476003)(426003)(336012)(86362001)(2906002)(109986005)(26005)(5660300002)(186003)(478600001)(81166006)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3514;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be1d4de8-e5b5-4b28-d902-08d7141e58c8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM6PR12MB3514;
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351439D5A99D68BE62D31EBCE7DD0@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01136D2D90
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Y9nPWgL1ZLf6CPi5/48oVV18Pr/f6Irr/hi3u7fd+RwZCztzLYOFmyHtZTgRocmxrWzEfmGjPi2yPer9W9hjEgbY8p54JslgPc8G4wHUUaSiLh4kqFhF4lNPS6TnTR7XYGa4wXkZjrlXqgqFcL1QgEaKkYckiPaBMForhBlNWF87z+swKWaxTUrevwuhRfmbpPb1bj59VE6UrN+dODfHptL6+rx7nA0jjC2+p7hXqYj4jFxKkFQNOx6QdW8IG4Kna6e/KWXp1cdpl3bUZD4dW8I7SvnWymamawHoUdztkyKn105TvfdZhOWQ8nkRam14Shfp+5WG6Rt7nLo22tnKa3WYcY3KoepWpCb3x+SOsabmkTxBqXt+MP/s1tfheqjMBMlXDNdIwn15ExBBuOmd+lyGK5fMAwrkr6EjUjbNIf8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2019 12:14:46.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1d4de8-e5b5-4b28-d902-08d7141e58c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't assume CPU physical address we get from page_to_phys()
is same as DMA address we get from dma_alloc_coherent(). On x86_64,
we won't run into any problem with the assumption when dma_ops is
nommu_dma_ops. However, DMA address is IOVA when IOMMU is enabled.
And it's most likely different from CPU physical address when AMD
IOMMU is not in passthrough mode.

Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Tested-by: RAVULAPATI VISHNU VARDHAN RAO <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index a4ade6b..49c4872 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -31,7 +31,7 @@ struct i2s_stream_instance {
 	u16 num_pages;
 	u16 channels;
 	u32 xfer_resolution;
-	struct page *pg;
+	dma_addr_t dma_addr;
 	u64 bytescount;
 	void __iomem *acp3x_base;
 };
@@ -211,11 +211,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 {
 	u16 page_idx;
-	u64 addr;
+	dma_addr_t addr;
 	u32 low, high, val, acp_fifo_addr;
-	struct page *pg = rtd->pg;
 
-	/* 8 scratch registers used to map one 64 bit address */
+	addr = rtd->dma_addr;
+	/* 8 scratch registers used to map one 64 bit address.
+	 * For 2 pages (8192 * 2 bytes), it will be 16 registers.
+	 */
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
 		val = 0;
 	else
@@ -229,7 +231,6 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 
 	for (page_idx = 0; page_idx < rtd->num_pages; page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
-		addr = page_to_phys(pg);
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
 
@@ -239,7 +240,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 				+ 4);
 		/* Move to next physically contiguos page */
 		val += 8;
-		pg++;
+		addr += PAGE_SIZE;
 	}
 
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -340,10 +341,8 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params)
 {
 	int status;
-	u64 size;
-	struct page *pg;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct i2s_stream_instance *rtd = runtime->private_data;
+	uint64_t size;
+	struct i2s_stream_instance *rtd = substream->runtime->private_data;
 
 	if (!rtd)
 		return -EINVAL;
@@ -355,8 +354,8 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 	pg = virt_to_page(substream->dma_buffer.area);
-	if (pg) {
-		rtd->pg = pg;
+	if (substream->dma_buffer.area) {
+		rtd->dma_addr = substream->dma_buffer.addr;
 		rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
 		config_acp3x_dma(rtd, substream->stream);
 		status = 0;
-- 
2.7.4

