Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3284C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712202466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j99tCUAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLFGLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:11:46 -0500
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:62170
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbfLFGLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 01:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7JEefUitDzeL7I7DnLcNG9hpDfxpnJIW2I+wsS05ipid7U270mOpEyMvPMvTtpgmAkiVIsK8jcLwEaLzXfIS+/rqOXZWZw1emOPIT/si4wQL/s7uwKi6OJUI94ET3e4Rr9mkzv6VdeZpnpL+ewPLkkxQh2e9q03q1SXXFju4ULnsQd2LCKMhvCfVNnwwJWVMY80XpFV5kPm3r8U08u2fs7C3EzHybWNsxJVpxNzzhwEcyu744K3tQ/OCfY1aCv4fLfRUoAHFgZRkXk63i77V8yS1s7idwPhiRomkXpM2nWe+0qxzNa2prsl8w04ZIItCT1AKYTDVcG+oyihz4dbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CqRUNc9tXcT5prHNw+TdpNR5CHkemlsy3wdLX/y3/I=;
 b=fmp6dpaQOJvNpFqoGBogkbjZU63U2UfaH4b+upgcmsbXIKbbET+VTNVdD6iMn4SDe3G7aF8hcvBbXAMf/q2ApMWA3arQOCeg4BOyy+RK47jSoB+n2xFZzUeynPfhzmI1mbO0O4VoA42qvHSuAFNEho8MNdKSFrbPdUNFH5CH9yljKbDKTkgL96eUYtiYuQcD3yUDa3vQVoiy/HwN0OXyTkS68680yeAh7ZqjfgYI2Ep0UKtcD+XMpYRKSxCYwn02yD+vUwxv4FSMb4luxHpWNiE7GNJdRcCU/yXd+3ftkTbqsfqQvRzP97jrWLu2fEAGjZq2qjQ8Aliq0qB4g22O+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CqRUNc9tXcT5prHNw+TdpNR5CHkemlsy3wdLX/y3/I=;
 b=j99tCUAH/k8vsFEfObFa6WxWbEjjL8kWWki45tyW4hgqs8iyHeV8qTThZPBJpVwPTo7tDdbctKNcjR9VuEdduxXcMEb+hdF88TlFekkxsCrLSm9ilvAPQyWMKJ7KIet2re4LGUFkGE5t1sqvbQd8b1sM/NUTGmN48d+tJdueEoI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1495.namprd12.prod.outlook.com (10.172.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 06:11:42 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 06:11:42 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Subject: [RFC PATCH v3 1/4] tee: allow compilation of tee subsystem for AMD CPUs
Date:   Fri,  6 Dec 2019 10:48:41 +0530
Message-Id: <b84dd09390938d3273e2a4a637e97a00a8aa9a37.1575608819.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
References: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::28) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76f56ee2-100e-4f3e-342b-08d77a132971
X-MS-TrafficTypeDiagnostic: CY4PR12MB1495:|CY4PR12MB1495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB149524DFA63C2DE9D1DF2806CF5F0@CY4PR12MB1495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(6512007)(6486002)(66946007)(14454004)(48376002)(14444005)(99286004)(66556008)(66476007)(6506007)(8676002)(305945005)(86362001)(8936002)(50226002)(81156014)(51416003)(76176011)(52116002)(478600001)(81166006)(11346002)(36756003)(16586007)(316002)(118296001)(26005)(50466002)(25786009)(186003)(2906002)(4326008)(54906003)(4744005)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1495;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ/Ccl9YzyMuLYgRkGIyKRHn76kWz4AJCFzSvbpzUfqOy0sK7zJXSm2dj4e5wmkKdj9BIWdv0KWjdoATdVk8q4p8BKREApYBHNH0FX+ljbTPedhJgx679J6+7xmh83OXt7Q4V4KYQO+kfA2x+vRGKARanRBLxqtD9SAwIkcuQuVPQ+Nyanq/d5yixuYgTILlpZquGn2Jn3mb/dGr/KidQaHIoiOE2cGmLXrUJ6BjbVcjSZbihhZcY22KQt4NVisnzzr+YeNdA6aDFkiNOJj80eB8Ys30t7S8tNSgvFOoQbPhyYc2kRcz0ByCSKrr7V+UylJ3+CIJeIuU3H2qksQEF9f+RjgWch+u1esUea716pOvMsuM/2PbYikZL+ZbMjIAQuhUNszlpQ7MMBu4AdmvBdZiEA7pMOzCmXGUN8CdcgMNlLrqqxNkkktuZoyVBaz6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f56ee2-100e-4f3e-342b-08d77a132971
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 06:11:41.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4Z2su48DeiZXAo4Zw7Kyk/KUWmaYRsEk3SH2Gc7F6HeJWg3lSGUkOc6AUrBCTfg924O6qqtdfgfXeSWJE1QGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
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

