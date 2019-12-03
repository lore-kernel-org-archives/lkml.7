Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C0C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0608820659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qA5A0Zng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLCFs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:48:57 -0500
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:58577
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfLCFsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:48:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihR/RVx4KOgjF9Rt9IXjSWmDHHH7ut4PbIzV8zhfV7YEoJ/LkRoyb702PozxcB+NttBawTC4MHGo51NeDWbg4tBkm+jyzCBdqUv80k0A075cL2+2D6B8Z4S163qGshBrf49tRXjY5Q9ULEZV/nwMkpedIoTAyLjlUrxH5h8JHXar9zyP3agKoRlQ1+ojicJdn+XTW+ICJ785S1OBnaHbZlWiEbmjtEhYJffhapmZWguwwFbM0h7XFgtKjVi8ipr6eey12QSN5gUzwz39n7LlyNJ9cdTt8bI7WCnUmVBuTIWT2Mhw1jcCrl/ntkjDTTeaczUQPz8r+3bLB3q+Yet/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CqRUNc9tXcT5prHNw+TdpNR5CHkemlsy3wdLX/y3/I=;
 b=AkyY0EftPf6yPsqXlnSVfuUw/EBNt0rhyiHE1hYbfz8/jUAq9pyi8rccW6Dh25Y+TfVBd7SJZd7nLtlf6rZssBexOlCRJddxYkOrnx7oQkG+PcP16Zu1eaTVa7xPZiLTQSAl55CFaOOGuUBhHqCWyEYLgnnF5B8HDN/vND+EKxU/g++xQ5v3DUTLKA4vCtN2oS6EgvOuBrI/tVaFw/tjSJJYY9IkYUktYpWsx1f70w6Bgg4Egai1C7ECt8znZeK4c//UmvWBxeVNC3nrl8FUp67PzYHvKYAQwuHbUli8mInc9yfycwU8PbpmTUjbRHBgS2IJZEAd9WSlg3QPLVZlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CqRUNc9tXcT5prHNw+TdpNR5CHkemlsy3wdLX/y3/I=;
 b=qA5A0ZngPeXnrdKXUPuot8NRfNiLjFDGU+R3XrzGL5jVjH5CZvqQ4OsUB9qmw29x2nljmc66F2yuiJnjDCk7d8EWcz/G1WGFn5xzr7DRj6eGMjkKduQ/Z7P6WcvlAJIA25hgOw37Y7kq4QbrEcwFWqVKp63q6hkekMboDDa1Wcs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1592.namprd12.prod.outlook.com (10.172.70.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 05:48:54 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 05:48:54 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v2 1/3] tee: allow compilation of tee subsystem for AMD CPUs
Date:   Tue,  3 Dec 2019 10:26:21 +0530
Message-Id: <1f051737dcdf13d05d0852b45c92162d7e9481b1.1575272984.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1575272984.git.Rijo-john.Thomas@amd.com>
References: <cover.1575272984.git.Rijo-john.Thomas@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f4cf274-6e19-48ea-406e-08d777b47af0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1592:|CY4PR12MB1592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1592940AFF667967DBB29FFECF420@CY4PR12MB1592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(11346002)(51416003)(52116002)(3846002)(6666004)(6116002)(2616005)(4326008)(25786009)(14454004)(446003)(6506007)(386003)(26005)(8936002)(478600001)(118296001)(99286004)(47776003)(5660300002)(186003)(7736002)(6512007)(66946007)(16586007)(66476007)(66556008)(316002)(81166006)(81156014)(50226002)(54906003)(14444005)(36756003)(86362001)(6436002)(8676002)(2906002)(66066001)(48376002)(6486002)(4744005)(76176011)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1592;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QIJ8Ye71pD1wMk9tYv5f/AWDw+YXuOmmPCsKTzFPHLxyQED5BVyPGZeaFtMsx7ko6a0pGlQ3ahLZLYbOUeqbz/xEmu5f4zORD36Ph+xFvVqT1c0fGwhloWM6ASh+CPwQ9KJCXnYK/gkmjW8PHpeHoV/IeE5dGA49nsQFj3KW6aHjWaGll51CNKxAX5NQ+ZpFEeSmvFQcXPbDIPAqvme1bHtO049suwXR4y+rS5Z+9ltM5nXIk0//J9n1gcFkBF7wE4C1R5n9wqWtUxXPKu7d8NJGuNfsiXTDVYdddkRq0g1IYVqks5mJCjeKNTzC/YYEW2oyvzwKs6xpR/AWYcC0yGVKaUPmcuBLuMzQNReGZYKGJw2XP2RKxHBoHXPreSdnIN6ZE9vHJuJ9vq+0aNCNpFEJJvab1mZs6O4TRXdifJd7LzVNrZiscqWF79gseMZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4cf274-6e19-48ea-406e-08d777b47af0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 05:48:54.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI2B/Xmuxe4fLUjXEqIKDhNoDIV7zTr0gRCCJt9YuKTs9ocDpp2ESIfOYeY6mDYDc6RUPiP0Ny/iDmA/UxU56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow compilation of tee subsystem for AMD's CPUs which have a dedicated
AMD Secure Processor for Trusted Execution Environment (TEE).

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Co-developed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 676ffcb..4f3197d 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -2,7 +2,7 @@
 # Generic Trusted Execution Environment Configuration
 config TEE
 	tristate "Trusted Execution Environment support"
-	depends on HAVE_ARM_SMCCC || COMPILE_TEST
+	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
 	help
-- 
1.9.1

