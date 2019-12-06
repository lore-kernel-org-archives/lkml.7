Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0F8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784A62466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cxn8+h/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFGL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:11:57 -0500
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:6034
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbfLFGL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 01:11:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKO4MfaPheAkarHTkTmKPMdGLBHnV8snRpV4y6/A6t8zFI+qcnqvrnUq509IJyPjPFpxge6+PJlGFmYl8nRTBb7G45Fuf0vqrIOjhe2JbUPhTP3N3aUbr4z4VgZFQ+H4c76LTjhjE/no4SJ8YW/oUOkDselEhDIXF5N2zJ8moHN0DlQkIqNEJm0FOmi61KcyN+qfdMyWoC5oaOG2CSe18r8XfkMnU8MxzDHRp6feBoMDNaiAhNYXSpyP6/+nVjQX8Wn6hJ3H4bLqvZ/Fu8Z4hA21k+n3f0tG+yZ8fIxeYsXZxuSdjqgEMxAxuJYD4QKZ/HikdXLmebHB9iSwx1h01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKpTJieFmsEPzhElMBbJ3O/Ru2YE2+3mooXyq70Rejs=;
 b=U9NmHQfpQpIPRbRRG/yOqxwfVrXLJWpFypPL+1e1GGo0Na1dh+PqpTWQjoHMRuLpX2RaZIQrHaRmnOGoM+sIB6uVilfK5fRi1z3aR2a6mtt9k7RmIM8dFm8p8iCgY89Jb0r306WVY06kEjOHF7zpBhmb4xOEI2uuRu3tfCaZk5ERFsEeuAAfj8+P+zsCzRVFiCaRjKciyBgwz4mhNYp902aL7YdaWGm5ADmGdlFvpLgBxZu0HYkZhuoyQYUc4HS4WS605i5Rs18kjMjdBkNz6gjjUZRRFU+xFXL5CRNmU2LRh3xB6ToRtvz580BjascCM9xuhBEizAbKpLoX8T9qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKpTJieFmsEPzhElMBbJ3O/Ru2YE2+3mooXyq70Rejs=;
 b=Cxn8+h/IlJ3SUS6VvMwW/BwZ2AL9rSLn/nDa9YycPE+J6zXWXcjtKQJlrI2hQknrG/fG3hd44IWUsAEqH/3Fiph5L3JRYXIQtzBv3wV69fb5bWNxV5IUWI/Hi6y3sK9SONpf2hjNYcIphIPSmKeGuXWQIOewv2F2MM1GtZk65TY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1495.namprd12.prod.outlook.com (10.172.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 06:11:54 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 06:11:53 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Subject: [RFC PATCH v3 4/4] Documentation: tee: add AMD-TEE driver details
Date:   Fri,  6 Dec 2019 10:48:44 +0530
Message-Id: <dcb7478485b3c049ac813ce30db385674202009a.1575608819.git.Rijo-john.Thomas@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5204187-53a7-4252-5e97-08d77a133076
X-MS-TrafficTypeDiagnostic: CY4PR12MB1495:|CY4PR12MB1495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB14955D8882C1C8A7588BF1EBCF5F0@CY4PR12MB1495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(966005)(6512007)(6486002)(66946007)(14454004)(48376002)(14444005)(99286004)(66556008)(66476007)(6506007)(8676002)(305945005)(86362001)(8936002)(50226002)(81156014)(51416003)(76176011)(52116002)(478600001)(81166006)(11346002)(36756003)(16586007)(316002)(6666004)(118296001)(26005)(50466002)(25786009)(186003)(2906002)(4326008)(54906003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1495;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWFELUdahKm4rmbpiSEyH56jLxZBhsz/Jp8KVay/5JIZtUyNsxZHMJlt4lvYWAFHaXXLkn7OgUSOjHW1B6gAqoqeukmAQip0Hlzj6i9vpFMLX0XC/L2XWXTbxO9hwB3JBcLoQO4mQ9E9cO1cxbCBZKXpCoU8BrAkFcWq9bmR4Ntqd8y/wsU7eQPtjHvF+eDkdlxfqMO9DnJQ3mur5UFU5JmOpo05J7h6l3bxZadNSYlZnBloNUTqRhuk2OucSnMDy4ePYTW3orZYaJDUdICOSK4LXaM4+AIn1fWyPvbGCfLTkUGgWm1htJJCUt4Z+k79bOLtQsc3eKJonuGlEh5jMPSOcS8LCx1CjXFDMV8+eU9aKeZ7V/mm5bTgqHFBf/0YMHbuNQKKGQSR6e9Xc/mdYVs2BxoKmS7M2WfY3hTNXNRHAqZxB4A56/DgzHLm4pZiOxHlNvbtFKebgJ6oERsB21pFD8ngCER+06DpCwxWfFA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5204187-53a7-4252-5e97-08d77a133076
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 06:11:53.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdN3B8DfFIrDFqJT1X/ARiKa7Dvewx4VIl/cJrwcMw0M6r6IyscLHvvDfqikuiUK2NnMDy3vsm70tOGjtmLhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update tee.txt with AMD-TEE driver details. The driver is written
to communicate with AMD's TEE.

Co-developed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 Documentation/tee.txt | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/tee.txt b/Documentation/tee.txt
index afacdf2..c8fad81 100644
--- a/Documentation/tee.txt
+++ b/Documentation/tee.txt
@@ -112,6 +112,83 @@ kernel are handled by the kernel driver. Other RPC messages will be forwarded to
 tee-supplicant without further involvement of the driver, except switching
 shared memory buffer representation.
 
+AMD-TEE driver
+==============
+
+The AMD-TEE driver handles the communication with AMD's TEE environment. The
+TEE environment is provided by AMD Secure Processor.
+
+The AMD Secure Processor (formerly called Platform Security Processor or PSP)
+is a dedicated processor that features ARM TrustZone technology, along with a
+software-based Trusted Execution Environment (TEE) designed to enable
+third-party Trusted Applications. This feature is currently enabled only for
+APUs.
+
+The following picture shows a high level overview of AMD-TEE::
+
+                                             |
+    x86                                      |
+                                             |
+ User space            (Kernel space)        |    AMD Secure Processor (PSP)
+ ~~~~~~~~~~            ~~~~~~~~~~~~~~        |    ~~~~~~~~~~~~~~~~~~~~~~~~~~
+                                             |
+ +--------+                                  |       +-------------+
+ | Client |                                  |       | Trusted     |
+ +--------+                                  |       | Application |
+     /\                                      |       +-------------+
+     ||                                      |             /\
+     ||                                      |             ||
+     ||                                      |             \/
+     ||                                      |         +----------+
+     ||                                      |         |   TEE    |
+     ||                                      |         | Internal |
+     \/                                      |         |   API    |
+ +---------+           +-----------+---------+         +----------+
+ | TEE     |           | TEE       | AMD-TEE |         | AMD-TEE  |
+ | Client  |           | subsystem | driver  |         | Trusted  |
+ | API     |           |           |         |         |   OS     |
+ +---------+-----------+----+------+---------+---------+----------+
+ |   Generic TEE API        |      | ASP     |      Mailbox       |
+ |   IOCTL (TEE_IOC_*)      |      | driver  | Register Protocol  |
+ +--------------------------+      +---------+--------------------+
+
+At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses the
+CPU to PSP mailbox regsister to submit commands to the PSP. The format of the
+command buffer is opaque to the ASP driver. It's role is to submit commands to
+the secure processor and return results to AMD-TEE driver. The interface
+between AMD-TEE driver and AMD Secure Processor driver can be found in [6].
+
+The AMD-TEE driver packages the command buffer payload for processing in TEE.
+The command buffer format for the different TEE commands can be found in [7].
+
+The TEE commands supported by AMD-TEE Trusted OS are:
+* TEE_CMD_ID_LOAD_TA          - loads a Trusted Application (TA) binary into
+                                TEE environment.
+* TEE_CMD_ID_UNLOAD_TA        - unloads TA binary from TEE environment.
+* TEE_CMD_ID_OPEN_SESSION     - opens a session with a loaded TA.
+* TEE_CMD_ID_CLOSE_SESSION    - closes session with loaded TA
+* TEE_CMD_ID_INVOKE_CMD       - invokes a command with loaded TA
+* TEE_CMD_ID_MAP_SHARED_MEM   - maps shared memory
+* TEE_CMD_ID_UNMAP_SHARED_MEM - unmaps shared memory
+
+AMD-TEE Trusted OS is the firmware running on AMD Secure Processor.
+
+The AMD-TEE driver registers itself with TEE subsystem and implements the
+following driver function callbacks:
+
+* get_version - returns the driver implementation id and capability.
+* open - sets up the driver context data structure.
+* release - frees up driver resources.
+* open_session - loads the TA binary and opens session with loaded TA.
+* close_session -  closes session with loaded TA and unloads it.
+* invoke_func - invokes a command with loaded TA.
+
+cancel_req driver callback is not supported by AMD-TEE.
+
+The GlobalPlatform TEE Client API [5] can be used by the user space (client) to
+talk to AMD's TEE. AMD's TEE provides a secure environment for loading, opening
+a session, invoking commands and clossing session with TA.
+
 References
 ==========
 
@@ -125,3 +202,7 @@ References
 
 [5] http://www.globalplatform.org/specificationsdevice.asp look for
     "TEE Client API Specification v1.0" and click download.
+
+[6] include/linux/psp-tee.h
+
+[7] drivers/tee/amdtee/amdtee_if.h
-- 
1.9.1

