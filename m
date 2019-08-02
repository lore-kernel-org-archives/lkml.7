Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36BDC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B908020679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="porYQsY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406544AbfHBNm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:42:57 -0400
Received: from mail-eopbgr690047.outbound.protection.outlook.com ([40.107.69.47]:40495
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfHBNm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgXSMLAuwwJ6qj5Y2oEImUu+NNyuvTt+iQmg5V9+CKlOYN/vNMfAxQy7rfqLh0Tl5Vbv2sArtB6GNexO1KNgW3CgnxuOUpt80BKALG45LzDmvfrLkcGqe4YjBMKE/6bUysroQ6PqHsH8LEFE5UpTHCrrVzPaEBXJNRDmSupV5hOz1oGZ1A/EOxPyA9TuAulGrrJ/Y+pmpJFzRJxHpTbR+01YVPG6cvwVt2tsJzPLmOugDzHhqMb1//8p089ZhZvYKnTy4TNdbdQh215n+frm8y26nyMm9vt4AA6O637Z/mtYVg0MkEShH9aPiwz2kzZxjrU+x4bAoMMUilid+DalvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmeCfkDp+EPjuHjLWJdg3X0ajXQqiLdpvv9EdxNIPYA=;
 b=C4aphddrpfmpW5edYBXAPjaQlTawvoi4Ja7J1/v7DtFnArZp4VU2izYIOilEhg0Q03CKwHk+pwK6tibEjvv2rZwyOiUia6AjzwujZr3UZDUO/fLShoGcilpcpgUj01Nrsj338udjqX/mtSxg3Mb0C1XhnEZsyd2IEEC53EZnsyBmrRUrs9yzaeYhp2+odm/Zm4M9nDWD155+rsIo/h2yaXKknKczYvoIf7raS6jGaodGFJgoJmcbm9bXIHjY5gWYkrspkwNK64vhaRNIWePvx9ia4H0Riuj4mh8FaJN6eGdASpNx9Uro+skStMvuGi+G1P+ffSjfG3mMByZH1tYThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com
 smtp.mailfrom=amd.com;dmarc=permerror action=none
 header.from=amd.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmeCfkDp+EPjuHjLWJdg3X0ajXQqiLdpvv9EdxNIPYA=;
 b=porYQsY+gCdrG/dZAgLg7XZLpSjvda/RlbUKJrG9lFyFrQh+dsTQYPwyuE0vhgX2rpghY7ESCQIfFk282+qDZ/O6TvcnsMVhb/BBi1iRtorObslEtR62tDA4aNp8twLeK/qyxRV2ue2PUfPrZgOhU35G18UbEglJEN/wzyRKL6A=
Received: from MWHPR12CA0048.namprd12.prod.outlook.com (2603:10b6:301:2::34)
 by DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Fri, 2 Aug
 2019 13:42:53 +0000
Received: from DM3NAM03FT031.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MWHPR12CA0048.outlook.office365.com
 (2603:10b6:301:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.13 via Frontend
 Transport; Fri, 2 Aug 2019 13:42:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT031.mail.protection.outlook.com (10.152.82.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2136.14 via Frontend Transport; Fri, 2 Aug 2019 13:42:51 +0000
Received: from LinuxHost.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Fri, 2 Aug 2019
 08:42:50 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma driver
Date:   Fri, 2 Aug 2019 19:21:23 +0530
Message-ID: <1564753899-17124-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(428003)(199004)(189003)(8676002)(81156014)(81166006)(8936002)(478600001)(53936002)(109986005)(70206006)(53416004)(70586007)(2906002)(5660300002)(4326008)(50226002)(68736007)(47776003)(50466002)(48376002)(186003)(476003)(126002)(2616005)(86362001)(36756003)(486006)(426003)(305945005)(356004)(1671002)(6666004)(336012)(54906003)(26005)(316002)(16586007)(7696005)(51416003)(42413003)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3482;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e54de44c-f26b-4b86-b881-08d7174f50e3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM6PR12MB3482;
X-MS-TrafficTypeDiagnostic: DM6PR12MB3482:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3482BCAAB405AA008D415B8797D90@DM6PR12MB3482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 011787B9DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CLnL4hrBsJMuUPBM+duXjeHLvwVbp66svjjEkqQ5NSbfErHSgFD5B1KpmSqCW/8Z61rjRv+VLM/m9SuKULbg74pJTxbXZBmy52HQIq7q34ETOuf8lkZrQg+skIydFoCuUXqyrW52GQG3ASL6JMP6AlKdn5KBNurWQ4mrz8nsVcwj/wKGYBvBuiAdAHw4CNnoPMcQOwKrTgbxAEpryEJfltRV7tFg8BfHBZ5yyNcnk4jH1UIEUtmWCIIrqZvcspcNNWgREipL7xm5TZzMsvJAMu4kBr5yXpojC+OH+BYQbHtRlEBbLlUf9aV23t1d0Z849zL9zwgonHAFYINsI/GbzOlwF384SD8n5LzWOe5k1prforN1F5vS7cVkJpE8ygBgQatcRI+yEbi2cWSevbZWDCeAWIPFaTkgN4/VdS8FrS4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 13:42:51.9418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54de44c-f26b-4b86-b881-08d7174f50e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD platform device acp3x_rv_i2s created by parent PCI device
driver. Pass struct device of the parent to
snd_pcm_lib_preallocate_pages() so dma_alloc_coherent() can use
correct dma_ops. Otherwise, it will use default dma_ops which
is nommu_dma_ops on x86_64 even when IOMMU is enabled and
set to non passthrough mode.

Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index a4ade6b..905ed2f 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -385,9 +385,11 @@ static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_pcm_substream *substream)
 
 static int acp3x_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
+	struct device *parent = component->dev->parent;
 	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
-					      rtd->pcm->card->dev,
-					      MIN_BUFFER, MAX_BUFFER);
+					      parent, MIN_BUFFER, MAX_BUFFER);
 	return 0;
 }
 
-- 
2.7.4

