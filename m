Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC8C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5162920842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TsZVYuIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfI3OFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:05:47 -0400
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:52063
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfI3OFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYW76Bz222ZSXVcTPLRrhphM2lF6GtlNKVD4jRCjBhlAZpAxvzcn0B6bXEIp5MwA4NFA/S+RGVwV37l+6IHnDqREOLCa8pRp0fqdGryU0LssmahBMLLtrU1uzSzABKyxNML54JpMK4UnojHD1bO0EMX+Qx+Taru0n6mPwo2NCvmaJof2teg8k6ehyBTSREwPVRSqNeTYSHdyjgW4OcTPYIEXqJ65W8vQKb5jWVTmJdQJ2tONDwk6HVrVfATpf4Yge3stQrJlGz05Dabw/d51/5DPW1esMPebzfa5jLFx9HFXT2QllYNKT97J6bZ6X1ypttHd+SDHV6wUP+JYoMjYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQz4KewW0jjJaHgm/tkT+fG1prUhUjrgh0AAmeiBq5I=;
 b=d2Ou03VpBuZS65i5x7dvNXeM2+J3rHqs2hrJmZqcfcMCWr9ufh5TxMTUiz9E8VeExkHgpwLoHq4vNW/tMHhDiJ7JTNodinTTevctRQk5vCfKuvek1o02vEVRg0QzU7SFVv32X3LoLO1/+li1LalEywbwlBdJVoK8lH1rHE3//zaYJoL3Mc6nPRkj939vwUDE2HKMzH5IXdOE67xeH2Zj6ZfEOCtwiJCRwmc+rMqtr9U4B1H5yWTiYZfwA1zT9GDBTsToy6QcJFIyAcYHq+pvd1czqRo6xHOvMvIqwnXLOpJvCFTPJFxrvmFC9yqon/IPWSAY2vAWB7PPYGXrapJg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQz4KewW0jjJaHgm/tkT+fG1prUhUjrgh0AAmeiBq5I=;
 b=TsZVYuIQZEiHse0grgVU3psNJNbco/K8almMVtTCp5Blx/3ZYPNpR80D30F8gLMsLmVPzutr1hw163cVMEyQDTZVGW0TyVST97oZDDqoi3RywRsXQsoFZdAKhcigLTeTi4oyMkSSeMwjKIjRlb36SBmW54OemcmQEnhfeNQgfPg=
Received: from DM3PR12CA0110.namprd12.prod.outlook.com (2603:10b6:0:55::30) by
 CY4PR12MB1223.namprd12.prod.outlook.com (2603:10b6:903:38::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 14:05:44 +0000
Received: from CO1NAM03FT023.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::203) by DM3PR12CA0110.outlook.office365.com
 (2603:10b6:0:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Mon, 30 Sep 2019 14:05:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT023.mail.protection.outlook.com (10.152.80.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 14:05:43 +0000
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXCHOV01.amd.com (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1;
 Mon, 30 Sep 2019 09:05:41 -0500
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
        "Maruthi Srinivas Bayyavarapu" <Maruthi.Bayyavarapu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Date:   Tue, 1 Oct 2019 06:28:09 +0530
Message-ID: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(428003)(199004)(189003)(109986005)(336012)(476003)(126002)(426003)(47776003)(53416004)(2616005)(81156014)(8676002)(4326008)(486006)(478600001)(7696005)(51416003)(36756003)(8936002)(86362001)(50226002)(2906002)(316002)(50466002)(54906003)(5660300002)(70206006)(70586007)(186003)(305945005)(81166006)(16586007)(6666004)(1671002)(48376002)(356004)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1223;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3143d3c-bcea-44f8-5a03-08d745af48f7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1223:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1223F701F600C91DBF9A2955E7820@CY4PR12MB1223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 01762B0D64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxzZGzEHl6Htj2m7qKN3g3Q3ecx130oPX7/AUvFbERuu7FUi7yhECwDD7TuK9TJEU5yXYFiw9m1hBCTqNAhbx39Qm5TTDp35F+kVKZXBrcskQ9z/cfPe5ouw6wohCyROYV+bSXE+l0D9mA5Kx/HA55JkfyNTD0a8HHJiqFFx2Of7FcOPTy9xg0PujwV/nFUG5LSpxzPiAC57Ba3K3KXGw33BXlbBmFq0mwU0GRd2c/U/DUOGIeV01AyQ5C2JLjmQMiS1/M5rdvRMNW+WMPvR+1/auM0sE6Dv02RIvtyr0E5rrevRTQYiqnsDN1/T1RQdvcXFomrxc3VJ/ewTcLWBifj3ADNiFKg0w7bMRnOine5Ndv4NGaCHoF7tEchpErYQc9MYanCpQvIbo0VfxBgpoG/+GsaeA0cqf0NXabnpQ3Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 14:05:43.8214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3143d3c-bcea-44f8-5a03-08d745af48f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1223
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP-PCI controller driver does not depends msi interrupts.
So removed msi related pci functions which have no
use and does not impact on existing functionality.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index facec24..8f6bf00 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -46,14 +46,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		goto release_regions;
 	}
 
-	/* check for msi interrupt support */
-	ret = pci_enable_msi(pci);
-	if (ret)
-		/* msi is not enabled */
-		irqflags = IRQF_SHARED;
-	else
-		/* msi is enabled */
-		irqflags = 0;
+	irqflags = 0;
 
 	addr = pci_resource_start(pci, 0);
 	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
@@ -112,7 +105,6 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	return 0;
 
 unmap_mmio:
-	pci_disable_msi(pci);
 	iounmap(adata->acp3x_base);
 release_regions:
 	pci_release_regions(pci);
@@ -129,7 +121,6 @@ static void snd_acp3x_remove(struct pci_dev *pci)
 	platform_device_unregister(adata->pdev);
 	iounmap(adata->acp3x_base);
 
-	pci_disable_msi(pci);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
-- 
2.7.4

