Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49008C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15442206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bnmDN6aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLCFtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:49:05 -0500
Received: from mail-eopbgr760048.outbound.protection.outlook.com ([40.107.76.48]:19258
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbfLCFtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:49:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxFk7v6G60ol3cJ/ywbYtD0CWwSVafxWGWshNugsBrgF5gu030VtXuLEXyIHTNDH9ZKOVGlvcRhpTQ9U4NV5XQtzLhm+jyE864p69SriD3F8xG5hMNT9LDEfo4CawQPk4JmKeS89FOhj4Ox0q2cYoTzrWnq30tMq06rkSE5GD/UU5tj6ZaPDT66UUrn1Alqmt6b22ZobcPUkq/J35BPl0Fge0aaPJcobdWqOAYpthvcWxoGJsr3n6dDkRZDAc5jEV3d8XaSEcYIX/4gEE+S4j4HhZ+0eYp8p7nFuR/9ZvEiKAJ2SNRBSk14mk5SHR8omNukk5Mpc2SBedcLeRyJroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP+WiSpFbCtD3rXmd4YFrVb0J8y4F6xBFYXT8CnnXrw=;
 b=BydwoUuRyE/OPs/n3U46lRIApIZFIi0QI5WwoI+6+fOQ0HMsaVaHM9gT9gncNORBQr2xMpweMI44qetg4U1N06mM5OkJrp4UgcP5bBZAF5wiF3vn2v9PJpF9ipbHJGpbmiVHm7fI9zq606JRKLaI7RlLMFJ2ryZApcZ0ZNGsydby3R7FVtPhSlO1IAxi1spddk1013JpFIQVj2VEyowteksz7v8J+AFiFJHZkry5otwpD3LejEY7EaasYYKgoQ/CoQhWEMwTk041giGBtuAuRPpFMVDsraHOLZRDVczmcTPyNiXR5usd84ilgVkb65jsElvW6AnXkUyIRiYU0Nw3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP+WiSpFbCtD3rXmd4YFrVb0J8y4F6xBFYXT8CnnXrw=;
 b=bnmDN6ajJHo4amPrpFIv+yFr2BDNoeYNHvsyTUMAYLq/AQW2fTD5KxV8AQn4kSqwdinQJifXEGQ0LOujTH9DbAlgPymWInN8TWKunWmcliu7yL1Smzryt6HwKjhScZFi0+Zww75hhzW5GOfGu/pCfydns9OjYIcBS0eHI/Zd4Mo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1592.namprd12.prod.outlook.com (10.172.70.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 05:49:00 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 05:49:00 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v2 3/3] tee: amdtee: check TEE status during driver initialization
Date:   Tue,  3 Dec 2019 10:26:23 +0530
Message-Id: <5dfd1f04c75aeae94f97748610a51fddc9161392.1575272984.git.Rijo-john.Thomas@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7041e6d-087e-4eda-fc63-08d777b47e8c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1592:|CY4PR12MB1592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1592679D2A5B57B16588CAD7CF420@CY4PR12MB1592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(11346002)(51416003)(52116002)(3846002)(6666004)(6116002)(2616005)(4326008)(25786009)(14454004)(446003)(6506007)(386003)(26005)(8936002)(478600001)(118296001)(99286004)(47776003)(5660300002)(186003)(7736002)(6512007)(66946007)(16586007)(66476007)(66556008)(316002)(81166006)(81156014)(50226002)(54906003)(36756003)(86362001)(6436002)(8676002)(2906002)(66066001)(48376002)(6486002)(76176011)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1592;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4OyuiJTKRkmLSgJH5jCs9vviUdElHYt419FY8he/vaI8Uj+nOwhzgCxFN990Lz+8vqK2E2wt/rwJkgviDhG1zsqgy8ij7WVXzrgx2exiOJSf3Oei6l1Jhuuq1uO2cEV3GbTwO2vgH+N74R4cYCudQDP1exMj4vK4t2ftggEru8QFTFhV6GPxBfbdPK8EKj0DmbSnO4WxyK1oNpxPA6cX8eiu/jgaA9CNNJ9WE/iRQ38mmiycPZiKg5s7+qK1mBd3RYGfNpqLGxXkYm1iJEPwZ4ZxLgmZQCxqK03z5DvlvZGWx0zmOk0zyN5AcW8IU3gZp/UCbeP/ozSV03jxEAMMjr+Mklo4zmQdfQSmYln42iHkrfZdziX9AM050YoGmiFc/UKdi1QdoG5rkEf3NSR3jZcm8NOaGqERudGxcl1+TyviDCB0EEB937hlZE9+HEN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7041e6d-087e-4eda-fc63-08d777b47e8c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 05:49:00.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8uig4heFpHul9NgPRrzwQanDXLLqezz1N55VCIxwzic/55GgLj/+a8BRq7hQfCqCWWPEtUXOHkTE8QqjRaJ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1592
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

