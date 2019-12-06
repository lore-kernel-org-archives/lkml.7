Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F03C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115D62466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vdM+UTVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfLFGLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:11:55 -0500
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:6034
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbfLFGLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 01:11:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jow8HtHUQ7zRidfXDVu+BlFbwFCpxXZ9oivro87u5EZw48YaqYt/C6INumGR5mWlsPH0j5WFHKAMZvqVliqYJbG1gpVn0B4X6MarxkhMDHG2Wt7D+h9p4r+dAG8tVl9ZyKEVHV53cTsQxlQMfIUxqgLd07gnZV6VyfHJzu601QMU2teefkKI+oQcJ2HcsNz+omacJDICuc7TS+unhycNa6y9hqp+TDBPqO0Gvajwkn6i1qt5ZyzZv/G9jKeqTHrmkk1mPYnARoGNVvMrIjYzYqzPVJjhloHfVQ/lSqgmlv83ZmRPEa/mVRiKn8X6tvN08HqY4ADQSYkifF6qJDhLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP+WiSpFbCtD3rXmd4YFrVb0J8y4F6xBFYXT8CnnXrw=;
 b=Mgi3v7qgC0vw2C3zYSsDG6p/hXZ1AM5NBfR9mJYFToEgvO7jf4scz3vic8k5zCJBS5YDz9+TNrtk2bVXu4JfjLtKLZf1u+qRh+nhlxRbpRG5UKLMmHgjgVhILODOIbqLcZoXrF7AHHPhXUQ7bzOyyTt+7UkpWfU52gOfMKcglMhENu6Jy2/utarWQLHerDXbCRE4rXCzlDG8yCZXu/beXvthU7+3mrwbW91PFZXCtlbOVsPeA20g//lgLP3AB/tT1SswYZt+VqGg3kWRmrbhOT0f6eUE5vkqhgkFD2fXrtJayJrvDLSjnfmuf8fTkYgPjxo7T0UfmSQf0xOl+hSoBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP+WiSpFbCtD3rXmd4YFrVb0J8y4F6xBFYXT8CnnXrw=;
 b=vdM+UTVdXV/k1dbqgXBuauSSfgKyiAi4NjdW2L6Trp+twVMFakXhCslZb03uMIGX1wupyfo7x6WIJknDmxvcy3bBDSBtgD1dGLpN+pKUHgSe2S7uvbxHCxtN/MQC6AJWdB5+fzAyfmIv4k5kbrGkMnOtflNOFc6t4w4VA9Kbyas=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1495.namprd12.prod.outlook.com (10.172.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 06:11:50 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 06:11:50 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Subject: [RFC PATCH v3 3/4] tee: amdtee: check TEE status during driver initialization
Date:   Fri,  6 Dec 2019 10:48:43 +0530
Message-Id: <2558a14bc5e8761631f504cff06dbe07c1a1b0cd.1575608819.git.Rijo-john.Thomas@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c13630bd-f764-4659-b673-08d77a132e5e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1495:|CY4PR12MB1495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB14958A8732D81E2F3A35F321CF5F0@CY4PR12MB1495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(6512007)(6486002)(66946007)(14454004)(48376002)(99286004)(66556008)(66476007)(6506007)(8676002)(305945005)(86362001)(8936002)(50226002)(81156014)(51416003)(76176011)(52116002)(478600001)(81166006)(11346002)(36756003)(16586007)(316002)(6666004)(118296001)(26005)(50466002)(25786009)(186003)(2906002)(4326008)(54906003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1495;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmZ3qE8Uk/VBdwF/SWa3AFJV2SOv40U7sqMfGYhlD3udC0wmz25iJ+2mjjJBhded+43JhS/tclU6gX0KBDfjBIYV2WEDdCO4W5jQaparhPuotqa0Cb5nFSn277BeU0r1DGbiZcJbVOUVFrpBUIxeZP8saDu5/TYS+c2Xy1vXpBlQKsIlBiivL7rJ//qxyXV9p08/ibByUQy7UiAALMLxzXzUaCzvEO+tBm2kbJStVlcHc5X5Pwu6V5lktub08ivyD5iqf3Gj8jrUA/gLT715GCVrFH/z3aTNWhdQqNIMsscLhrQNQjGhH8VjbuyU/Q+wRwFCoSabqcN9ut2yJRcZJsaNCpguWAoSN5B9vwb6J8dLNvk/sfvebXUud9Nz7FoDHSkpf5Bo/D327R5Sjhfr3XTck8BsFHlziDsy0RSHVmNRaTYuPXomFAAeTd5LKKn3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13630bd-f764-4659-b673-08d77a132e5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 06:11:50.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIQXYnkcUlrMVvwER9tW5V+3nwTjPFd/hmwrXOusp7eCTSjcwGwFNbWTuBbMo4BK9sobiLXvB7Y9OpTHZLCNEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD-TEE driver should check if TEE is available before
registering itself with TEE subsystem. This ensures that
there is an TEE which the driver can talk to before proceeding
with tee device node allocation.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/crypto/ccp/tee-dev.c | 11 +++++++++++
 drivers/tee/amdtee/core.c    |  6 ++++++
 include/linux/psp-tee.h      | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
index 555c8a7..5e697a9 100644
--- a/drivers/crypto/ccp/tee-dev.c
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -362,3 +362,14 @@ int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf, size_t len,
 	return 0;
 }
 EXPORT_SYMBOL(psp_tee_process_cmd);
+
+int psp_check_tee_status(void)
+{
+	struct psp_device *psp = psp_get_master_device();
+
+	if (!psp || !psp->tee_data)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL(psp_check_tee_status);
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index dd360f3..9d0cee1 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -16,6 +16,7 @@
 #include <linux/firmware.h>
 #include "amdtee_private.h"
 #include "../tee_private.h"
+#include <linux/psp-tee.h>
 
 static struct amdtee_driver_data *drv_data;
 static DEFINE_MUTEX(session_list_mutex);
@@ -438,6 +439,10 @@ static int __init amdtee_driver_init(void)
 	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
 	int rc;
 
+	rc = psp_check_tee_status();
+	if (rc)
+		goto err_fail;
+
 	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
 	if (IS_ERR(drv_data))
 		return -ENOMEM;
@@ -485,6 +490,7 @@ static int __init amdtee_driver_init(void)
 	kfree(drv_data);
 	drv_data = NULL;
 
+err_fail:
 	pr_err("amd-tee driver initialization failed\n");
 	return rc;
 }
diff --git a/include/linux/psp-tee.h b/include/linux/psp-tee.h
index 63bb221..cb0c95d 100644
--- a/include/linux/psp-tee.h
+++ b/include/linux/psp-tee.h
@@ -62,6 +62,19 @@ enum tee_cmd_id {
 int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf, size_t len,
 			u32 *status);
 
+/**
+ * psp_check_tee_status() - Checks whether there is a TEE which a driver can
+ * talk to.
+ *
+ * This function can be used by AMD-TEE driver to query if there is TEE with
+ * which it can communicate.
+ *
+ * Returns:
+ * 0          if the device has TEE
+ * -%ENODEV   if there is no TEE available
+ */
+int psp_check_tee_status(void);
+
 #else /* !CONFIG_CRYPTO_DEV_SP_PSP */
 
 static inline int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf,
@@ -69,5 +82,10 @@ static inline int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf,
 {
 	return -ENODEV;
 }
+
+static inline int psp_check_tee_status(void)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_CRYPTO_DEV_SP_PSP */
 #endif /* __PSP_TEE_H_ */
-- 
1.9.1

